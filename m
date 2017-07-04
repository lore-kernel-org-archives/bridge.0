Return-Path: <elena.reshetova@intel.com>
From: Elena Reshetova <elena.reshetova@intel.com>
Date: Tue,  4 Jul 2017 15:53:16 +0300
Message-Id: <1499172811-16271-22-git-send-email-elena.reshetova@intel.com>
In-Reply-To: <1499172811-16271-1-git-send-email-elena.reshetova@intel.com>
References: <1499172811-16271-1-git-send-email-elena.reshetova@intel.com>
Subject: [Bridge] [PATCH 21/36] net,
	rds: convert rds_incoming.i_refcount from atomic_t to refcount_t
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
 net/rds/rds.h  |  3 ++-
 net/rds/recv.c | 12 ++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/rds/rds.h b/net/rds/rds.h
index 4a25db7..35ceaa2 100644
--- a/net/rds/rds.h
+++ b/net/rds/rds.h
@@ -8,6 +8,7 @@
 #include <linux/mutex.h>
 #include <linux/rds.h>
 #include <linux/rhashtable.h>
+#include <linux/refcount.h>
 
 #include "info.h"
 
@@ -261,7 +262,7 @@ struct rds_ext_header_rdma_dest {
 #define	RDS_MSG_RX_CMSG		3
 
 struct rds_incoming {
-	atomic_t		i_refcount;
+	refcount_t		i_refcount;
 	struct list_head	i_item;
 	struct rds_connection	*i_conn;
 	struct rds_conn_path	*i_conn_path;
diff --git a/net/rds/recv.c b/net/rds/recv.c
index 373a6aa1..b25bcfe 100644
--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -45,7 +45,7 @@ void rds_inc_init(struct rds_incoming *inc, struct rds_connection *conn,
 {
 	int i;
 
-	atomic_set(&inc->i_refcount, 1);
+	refcount_set(&inc->i_refcount, 1);
 	INIT_LIST_HEAD(&inc->i_item);
 	inc->i_conn = conn;
 	inc->i_saddr = saddr;
@@ -61,7 +61,7 @@ EXPORT_SYMBOL_GPL(rds_inc_init);
 void rds_inc_path_init(struct rds_incoming *inc, struct rds_conn_path *cp,
 		       __be32 saddr)
 {
-	atomic_set(&inc->i_refcount, 1);
+	refcount_set(&inc->i_refcount, 1);
 	INIT_LIST_HEAD(&inc->i_item);
 	inc->i_conn = cp->cp_conn;
 	inc->i_conn_path = cp;
@@ -74,14 +74,14 @@ EXPORT_SYMBOL_GPL(rds_inc_path_init);
 
 static void rds_inc_addref(struct rds_incoming *inc)
 {
-	rdsdebug("addref inc %p ref %d\n", inc, atomic_read(&inc->i_refcount));
-	atomic_inc(&inc->i_refcount);
+	rdsdebug("addref inc %p ref %d\n", inc, refcount_read(&inc->i_refcount));
+	refcount_inc(&inc->i_refcount);
 }
 
 void rds_inc_put(struct rds_incoming *inc)
 {
-	rdsdebug("put inc %p ref %d\n", inc, atomic_read(&inc->i_refcount));
-	if (atomic_dec_and_test(&inc->i_refcount)) {
+	rdsdebug("put inc %p ref %d\n", inc, refcount_read(&inc->i_refcount));
+	if (refcount_dec_and_test(&inc->i_refcount)) {
 		BUG_ON(!list_empty(&inc->i_item));
 
 		inc->i_conn->c_trans->inc_free(inc);
-- 
2.7.4

