Return-Path: <elena.reshetova@intel.com>
From: Elena Reshetova <elena.reshetova@intel.com>
Date: Tue,  4 Jul 2017 15:53:21 +0300
Message-Id: <1499172811-16271-27-git-send-email-elena.reshetova@intel.com>
In-Reply-To: <1499172811-16271-1-git-send-email-elena.reshetova@intel.com>
References: <1499172811-16271-1-git-send-email-elena.reshetova@intel.com>
Subject: [Bridge] [PATCH 26/36] net,
	xfrm: convert xfrm_state.refcnt from atomic_t to refcount_t
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
 include/net/xfrm.h    | 9 +++++----
 net/xfrm/xfrm_state.c | 4 ++--
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 01fa357..f5272a2 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -13,6 +13,7 @@
 #include <linux/mutex.h>
 #include <linux/audit.h>
 #include <linux/slab.h>
+#include <linux/refcount.h>
 
 #include <net/sock.h>
 #include <net/dst.h>
@@ -137,7 +138,7 @@ struct xfrm_state {
 	struct hlist_node	bysrc;
 	struct hlist_node	byspi;
 
-	atomic_t		refcnt;
+	refcount_t		refcnt;
 	spinlock_t		lock;
 
 	struct xfrm_id		id;
@@ -837,18 +838,18 @@ void __xfrm_state_destroy(struct xfrm_state *);
 
 static inline void __xfrm_state_put(struct xfrm_state *x)
 {
-	atomic_dec(&x->refcnt);
+	refcount_dec(&x->refcnt);
 }
 
 static inline void xfrm_state_put(struct xfrm_state *x)
 {
-	if (atomic_dec_and_test(&x->refcnt))
+	if (refcount_dec_and_test(&x->refcnt))
 		__xfrm_state_destroy(x);
 }
 
 static inline void xfrm_state_hold(struct xfrm_state *x)
 {
-	atomic_inc(&x->refcnt);
+	refcount_inc(&x->refcnt);
 }
 
 static inline bool addr_match(const void *token1, const void *token2,
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 4a28f66..6c0956d 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -48,7 +48,7 @@ static HLIST_HEAD(xfrm_state_gc_list);
 
 static inline bool xfrm_state_hold_rcu(struct xfrm_state __rcu *x)
 {
-	return atomic_inc_not_zero(&x->refcnt);
+	return refcount_inc_not_zero(&x->refcnt);
 }
 
 static inline unsigned int xfrm_dst_hash(struct net *net,
@@ -558,7 +558,7 @@ struct xfrm_state *xfrm_state_alloc(struct net *net)
 
 	if (x) {
 		write_pnet(&x->xs_net, net);
-		atomic_set(&x->refcnt, 1);
+		refcount_set(&x->refcnt, 1);
 		atomic_set(&x->tunnel_users, 0);
 		INIT_LIST_HEAD(&x->km.all);
 		INIT_HLIST_NODE(&x->bydst);
-- 
2.7.4

