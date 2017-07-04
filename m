Return-Path: <elena.reshetova@intel.com>
From: Elena Reshetova <elena.reshetova@intel.com>
Date: Tue,  4 Jul 2017 15:53:11 +0300
Message-Id: <1499172811-16271-17-git-send-email-elena.reshetova@intel.com>
In-Reply-To: <1499172811-16271-1-git-send-email-elena.reshetova@intel.com>
References: <1499172811-16271-1-git-send-email-elena.reshetova@intel.com>
Subject: [Bridge] [PATCH 16/36] net,
	netrom: convert nr_neigh.refcount from atomic_t to refcount_t
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: peterz@infradead.org, jchapman@katalix.com, bfields@fieldses.org, linux-sctp@vger.kernel.org, jlayton@poochiereds.net, Elena Reshetova <elena.reshetova@intel.com>, steffen.klassert@secunet.com, zyan@redhat.com, herbert@gondor.apana.org.au, linux-x25@vger.kernel.org, linux-rdma@vger.kernel.org, bridge@lists.linux-foundation.org, jmorris@namei.org, 3chas3@gmail.com, kuznet@ms2.inr.ac.ru, jreuter@yaina.de, keescook@chromium.org, santosh.shilimkar@oracle.com, jhs@mojatatu.com, Hans Liljestrand <ishkamiel@gmail.com>, linux-hams@vger.kernel.org, David Windsor <dwindsor@gmail.com>, linux-nfs@vger.kernel.org, sage@redhat.com, nhorman@tuxdriver.com, yoshfuji@linux-ipv6.org, vyasevich@gmail.com, linux-decnet-user@lists.sourceforge.net, linux-kernel@vger.kernel.org, ralf@linux-mips.org, kaber@trash.net, davem@davemloft.net

refcount_t type and corresponding API should be
used instead of atomic_t when the variable is used as
a reference counter. This allows to avoid accidental
refcounter overflows that might lead to use-after-free
situations.

Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Hans Liljestrand <ishkamiel@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 include/net/netrom.h  | 7 ++++---
 net/netrom/nr_route.c | 4 ++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/net/netrom.h b/include/net/netrom.h
index 110350a..cecb4fd 100644
--- a/include/net/netrom.h
+++ b/include/net/netrom.h
@@ -11,6 +11,7 @@
 #include <linux/list.h>
 #include <linux/slab.h>
 #include <net/sock.h>
+#include <linux/refcount.h>
 
 #define	NR_NETWORK_LEN			15
 #define	NR_TRANSPORT_LEN		5
@@ -93,7 +94,7 @@ struct nr_neigh {
 	unsigned short		count;
 	unsigned int		number;
 	unsigned char		failed;
-	atomic_t		refcount;
+	refcount_t		refcount;
 };
 
 struct nr_route {
@@ -128,11 +129,11 @@ static __inline__ void nr_node_put(struct nr_node *nr_node)
 }
 
 #define nr_neigh_hold(__nr_neigh) \
-	atomic_inc(&((__nr_neigh)->refcount))
+	refcount_inc(&((__nr_neigh)->refcount))
 
 static __inline__ void nr_neigh_put(struct nr_neigh *nr_neigh)
 {
-	if (atomic_dec_and_test(&nr_neigh->refcount)) {
+	if (refcount_dec_and_test(&nr_neigh->refcount)) {
 		if (nr_neigh->ax25)
 			ax25_cb_put(nr_neigh->ax25);
 		kfree(nr_neigh->digipeat);
diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index d72a4f1..6b72970 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -149,7 +149,7 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
 		nr_neigh->count    = 0;
 		nr_neigh->number   = nr_neigh_no++;
 		nr_neigh->failed   = 0;
-		atomic_set(&nr_neigh->refcount, 1);
+		refcount_set(&nr_neigh->refcount, 1);
 
 		if (ax25_digi != NULL && ax25_digi->ndigi > 0) {
 			nr_neigh->digipeat = kmemdup(ax25_digi,
@@ -431,7 +431,7 @@ static int __must_check nr_add_neigh(ax25_address *callsign,
 	nr_neigh->count    = 0;
 	nr_neigh->number   = nr_neigh_no++;
 	nr_neigh->failed   = 0;
-	atomic_set(&nr_neigh->refcount, 1);
+	refcount_set(&nr_neigh->refcount, 1);
 
 	if (ax25_digi != NULL && ax25_digi->ndigi > 0) {
 		nr_neigh->digipeat = kmemdup(ax25_digi, sizeof(*ax25_digi),
-- 
2.7.4

