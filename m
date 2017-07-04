Return-Path: <elena.reshetova@intel.com>
From: Elena Reshetova <elena.reshetova@intel.com>
Date: Tue,  4 Jul 2017 15:53:19 +0300
Message-Id: <1499172811-16271-25-git-send-email-elena.reshetova@intel.com>
In-Reply-To: <1499172811-16271-1-git-send-email-elena.reshetova@intel.com>
References: <1499172811-16271-1-git-send-email-elena.reshetova@intel.com>
Subject: [Bridge] [PATCH 24/36] net,
	x25: convert x25_route.refcnt from atomic_t to refcount_t
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
 include/net/x25.h   | 7 ++++---
 net/x25/x25_route.c | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/net/x25.h b/include/net/x25.h
index 6d30a01..1ac1400 100644
--- a/include/net/x25.h
+++ b/include/net/x25.h
@@ -11,6 +11,7 @@
 #define _X25_H 
 #include <linux/x25.h>
 #include <linux/slab.h>
+#include <linux/refcount.h>
 #include <net/sock.h>
 
 #define	X25_ADDR_LEN			16
@@ -129,7 +130,7 @@ struct x25_route {
 	struct x25_address	address;
 	unsigned int		sigdigits;
 	struct net_device	*dev;
-	atomic_t		refcnt;
+	refcount_t		refcnt;
 };
 
 struct x25_neigh {
@@ -265,12 +266,12 @@ void x25_route_free(void);
 
 static __inline__ void x25_route_hold(struct x25_route *rt)
 {
-	atomic_inc(&rt->refcnt);
+	refcount_inc(&rt->refcnt);
 }
 
 static __inline__ void x25_route_put(struct x25_route *rt)
 {
-	if (atomic_dec_and_test(&rt->refcnt))
+	if (refcount_dec_and_test(&rt->refcnt))
 		kfree(rt);
 }
 
diff --git a/net/x25/x25_route.c b/net/x25/x25_route.c
index 277c8d2..b85b889 100644
--- a/net/x25/x25_route.c
+++ b/net/x25/x25_route.c
@@ -55,7 +55,7 @@ static int x25_add_route(struct x25_address *address, unsigned int sigdigits,
 
 	rt->sigdigits = sigdigits;
 	rt->dev       = dev;
-	atomic_set(&rt->refcnt, 1);
+	refcount_set(&rt->refcnt, 1);
 
 	list_add(&rt->node, &x25_route_list);
 	rc = 0;
-- 
2.7.4

