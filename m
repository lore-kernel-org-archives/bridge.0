Return-Path: <elena.reshetova@intel.com>
From: Elena Reshetova <elena.reshetova@intel.com>
Date: Tue,  4 Jul 2017 15:53:23 +0300
Message-Id: <1499172811-16271-29-git-send-email-elena.reshetova@intel.com>
In-Reply-To: <1499172811-16271-1-git-send-email-elena.reshetova@intel.com>
References: <1499172811-16271-1-git-send-email-elena.reshetova@intel.com>
Subject: [Bridge] [PATCH 28/36] net,
	xfrm: convert sec_path.refcnt from atomic_t to refcount_t
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
 include/net/xfrm.h    | 6 +++---
 net/xfrm/xfrm_input.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index e1bd1de..c0916ab 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1030,7 +1030,7 @@ struct xfrm_offload {
 };
 
 struct sec_path {
-	atomic_t		refcnt;
+	refcount_t		refcnt;
 	int			len;
 	int			olen;
 
@@ -1051,7 +1051,7 @@ static inline struct sec_path *
 secpath_get(struct sec_path *sp)
 {
 	if (sp)
-		atomic_inc(&sp->refcnt);
+		refcount_inc(&sp->refcnt);
 	return sp;
 }
 
@@ -1060,7 +1060,7 @@ void __secpath_destroy(struct sec_path *sp);
 static inline void
 secpath_put(struct sec_path *sp)
 {
-	if (sp && atomic_dec_and_test(&sp->refcnt))
+	if (sp && refcount_dec_and_test(&sp->refcnt))
 		__secpath_destroy(sp);
 }
 
diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 9de4b1d..923205e 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -116,7 +116,7 @@ struct sec_path *secpath_dup(struct sec_path *src)
 		for (i = 0; i < sp->len; i++)
 			xfrm_state_hold(sp->xvec[i]);
 	}
-	atomic_set(&sp->refcnt, 1);
+	refcount_set(&sp->refcnt, 1);
 	return sp;
 }
 EXPORT_SYMBOL(secpath_dup);
@@ -126,7 +126,7 @@ int secpath_set(struct sk_buff *skb)
 	struct sec_path *sp;
 
 	/* Allocate new secpath or COW existing one. */
-	if (!skb->sp || atomic_read(&skb->sp->refcnt) != 1) {
+	if (!skb->sp || refcount_read(&skb->sp->refcnt) != 1) {
 		sp = secpath_dup(skb->sp);
 		if (!sp)
 			return -ENOMEM;
-- 
2.7.4

