Return-Path: <elena.reshetova@intel.com>
From: Elena Reshetova <elena.reshetova@intel.com>
Date: Tue,  4 Jul 2017 15:53:22 +0300
Message-Id: <1499172811-16271-28-git-send-email-elena.reshetova@intel.com>
In-Reply-To: <1499172811-16271-1-git-send-email-elena.reshetova@intel.com>
References: <1499172811-16271-1-git-send-email-elena.reshetova@intel.com>
Subject: [Bridge] [PATCH 27/36] net,
	xfrm: convert xfrm_policy.refcnt from atomic_t to refcount_t
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
 include/net/xfrm.h     | 6 +++---
 net/key/af_key.c       | 2 +-
 net/xfrm/xfrm_policy.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index f5272a2..e1bd1de 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -560,7 +560,7 @@ struct xfrm_policy {
 
 	/* This lock only affects elements except for entry. */
 	rwlock_t		lock;
-	atomic_t		refcnt;
+	refcount_t		refcnt;
 	struct timer_list	timer;
 
 	struct flow_cache_object flo;
@@ -816,14 +816,14 @@ static inline void xfrm_audit_state_icvfail(struct xfrm_state *x,
 static inline void xfrm_pol_hold(struct xfrm_policy *policy)
 {
 	if (likely(policy != NULL))
-		atomic_inc(&policy->refcnt);
+		refcount_inc(&policy->refcnt);
 }
 
 void xfrm_policy_destroy(struct xfrm_policy *policy);
 
 static inline void xfrm_pol_put(struct xfrm_policy *policy)
 {
-	if (atomic_dec_and_test(&policy->refcnt))
+	if (refcount_dec_and_test(&policy->refcnt))
 		xfrm_policy_destroy(policy);
 }
 
diff --git a/net/key/af_key.c b/net/key/af_key.c
index edcf1d0..ca9d3ae 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -2177,7 +2177,7 @@ static int pfkey_xfrm_policy2msg(struct sk_buff *skb, const struct xfrm_policy *
 	}
 
 	hdr->sadb_msg_len = size / sizeof(uint64_t);
-	hdr->sadb_msg_reserved = atomic_read(&xp->refcnt);
+	hdr->sadb_msg_reserved = refcount_read(&xp->refcnt);
 
 	return 0;
 }
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 4706df6..ff61d85 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -62,7 +62,7 @@ static struct xfrm_policy *__xfrm_policy_unlink(struct xfrm_policy *pol,
 
 static inline bool xfrm_pol_hold_rcu(struct xfrm_policy *policy)
 {
-	return atomic_inc_not_zero(&policy->refcnt);
+	return refcount_inc_not_zero(&policy->refcnt);
 }
 
 static inline bool
@@ -292,7 +292,7 @@ struct xfrm_policy *xfrm_policy_alloc(struct net *net, gfp_t gfp)
 		INIT_HLIST_NODE(&policy->bydst);
 		INIT_HLIST_NODE(&policy->byidx);
 		rwlock_init(&policy->lock);
-		atomic_set(&policy->refcnt, 1);
+		refcount_set(&policy->refcnt, 1);
 		skb_queue_head_init(&policy->polq.hold_queue);
 		setup_timer(&policy->timer, xfrm_policy_timer,
 				(unsigned long)policy);
-- 
2.7.4

