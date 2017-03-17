Return-Path: <elena.reshetova@intel.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=intel.com; i=@intel.com; q=dns/txt; s=intel;
	t=1489749279; x=1521285279;
	h=from:to:cc:subject:date:message-id:in-reply-to: references;
	bh=YKx5kTAerG4FmwWLMdaJxe8vb0B11I+Z2na0W7BmoOU=;
	b=erp+ZBF7pABmcjRF0zK2AY2lC6wHwLijUzx11IU72W+gmYDDM1o5NrQU
	NKvna9N6hvNun+lvc28JsDRHN4JXGg==;
From: Elena Reshetova <elena.reshetova@intel.com>
Date: Fri, 17 Mar 2017 13:12:54 +0200
Message-Id: <1489749179-12063-14-git-send-email-elena.reshetova@intel.com>
In-Reply-To: <1489749179-12063-1-git-send-email-elena.reshetova@intel.com>
References: <1489749179-12063-1-git-send-email-elena.reshetova@intel.com>
Subject: [Bridge] [PATCH 13/18] net,
	sched: convert Qdisc.refcnt from atomic_t to refcount_t
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: peterz@infradead.org, jchapman@katalix.com, Elena Reshetova <elena.reshetova@intel.com>, johan.hedberg@gmail.com, linux-x25@vger.kernel.org, bridge@lists.linux-foundation.org, jmorris@namei.org, 3chas3@gmail.com, Hans Liljestrand <ishkamiel@gmail.com>, keescook@chromium.org, marcel@holtmann.org, jhs@mojatatu.com, kuznet@ms2.inr.ac.ru, linux-hams@vger.kernel.org, David Windsor <dwindsor@gmail.com>, yoshfuji@linux-ipv6.org, linux-decnet-user@lists.sourceforge.net, linux-kernel@vger.kernel.org, ralf@linux-mips.org, kaber@trash.net, linux-bluetooth@vger.kernel.org, davem@davemloft.net

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
 include/net/sch_generic.h | 3 ++-
 net/sched/sch_api.c       | 8 ++++----
 net/sched/sch_generic.c   | 8 ++++----
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index aeec408..cd7463f 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -8,6 +8,7 @@
 #include <linux/pkt_cls.h>
 #include <linux/percpu.h>
 #include <linux/dynamic_queue_limits.h>
+#include <linux/refcount.h>
 #include <net/gen_stats.h>
 #include <net/rtnetlink.h>
 
@@ -93,7 +94,7 @@ struct Qdisc {
 	struct sk_buff		*skb_bad_txq;
 	struct rcu_head		rcu_head;
 	int			padded;
-	atomic_t		refcnt;
+	refcount_t		refcnt;
 
 	spinlock_t		busylock ____cacheline_aligned_in_smp;
 };
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index bcf49cd..806f7b5 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -828,7 +828,7 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 
 			old = dev_graft_qdisc(dev_queue, new);
 			if (new && i > 0)
-				atomic_inc(&new->refcnt);
+				refcount_inc(&new->refcnt);
 
 			if (!ingress)
 				qdisc_destroy(old);
@@ -839,7 +839,7 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 			notify_and_destroy(net, skb, n, classid,
 					   dev->qdisc, new);
 			if (new && !new->ops->attach)
-				atomic_inc(&new->refcnt);
+				refcount_inc(&new->refcnt);
 			dev->qdisc = new ? : &noop_qdisc;
 
 			if (new && new->ops->attach)
@@ -1245,7 +1245,7 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n)
 				if (q == p ||
 				    (p && check_loop(q, p, 0)))
 					return -ELOOP;
-				atomic_inc(&q->refcnt);
+				refcount_inc(&q->refcnt);
 				goto graft;
 			} else {
 				if (!q)
@@ -1360,7 +1360,7 @@ static int tc_fill_qdisc(struct sk_buff *skb, struct Qdisc *q, u32 clid,
 	tcm->tcm_ifindex = qdisc_dev(q)->ifindex;
 	tcm->tcm_parent = clid;
 	tcm->tcm_handle = q->handle;
-	tcm->tcm_info = atomic_read(&q->refcnt);
+	tcm->tcm_info = refcount_read(&q->refcnt);
 	if (nla_put_string(skb, TCA_KIND, q->ops->id))
 		goto nla_put_failure;
 	if (q->ops->dump && q->ops->dump(q, skb) < 0)
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index b052b27..6e0c695 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -633,7 +633,7 @@ struct Qdisc *qdisc_alloc(struct netdev_queue *dev_queue,
 	sch->dequeue = ops->dequeue;
 	sch->dev_queue = dev_queue;
 	dev_hold(dev);
-	atomic_set(&sch->refcnt, 1);
+	refcount_set(&sch->refcnt, 1);
 
 	return sch;
 errout:
@@ -701,7 +701,7 @@ void qdisc_destroy(struct Qdisc *qdisc)
 	const struct Qdisc_ops  *ops = qdisc->ops;
 
 	if (qdisc->flags & TCQ_F_BUILTIN ||
-	    !atomic_dec_and_test(&qdisc->refcnt))
+	    !refcount_dec_and_test(&qdisc->refcnt))
 		return;
 
 #ifdef CONFIG_NET_SCHED
@@ -739,7 +739,7 @@ struct Qdisc *dev_graft_qdisc(struct netdev_queue *dev_queue,
 	spin_lock_bh(root_lock);
 
 	/* Prune old scheduler */
-	if (oqdisc && atomic_read(&oqdisc->refcnt) <= 1)
+	if (oqdisc && refcount_read(&oqdisc->refcnt) <= 1)
 		qdisc_reset(oqdisc);
 
 	/* ... and graft new one */
@@ -785,7 +785,7 @@ static void attach_default_qdiscs(struct net_device *dev)
 	    dev->priv_flags & IFF_NO_QUEUE) {
 		netdev_for_each_tx_queue(dev, attach_one_default_qdisc, NULL);
 		dev->qdisc = txq->qdisc_sleeping;
-		atomic_inc(&dev->qdisc->refcnt);
+		refcount_inc(&dev->qdisc->refcnt);
 	} else {
 		qdisc = qdisc_create_dflt(txq, &mq_qdisc_ops, TC_H_ROOT);
 		if (qdisc) {
-- 
2.7.4

