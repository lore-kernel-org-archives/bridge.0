Return-Path: <rdong.ge@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=UXcY3+LQuritg/1xQjWkFlbv9Xw0iZ9vOAGOhx2mF2c=;
	b=QLlcVD0tgGVoQTJwlyV4nMg3eG6Kn57gTZrRNhMPh8H1StL69Toc9DvkleKV9pUFts
	XfPV+hR8onhDGzMAxrhpm+9YfZHHa3BiJDxSt+w8zv/2VVqF4N668XYTmp25VLw63IBj
	tqeyYMCswQeIROwJtVjIExeEQG/M6dSAkJqVpEKUz8AgfQsutMkE2Qw0Y6XksSmmfPjx
	NJGdZ4sz/ZexQdikNhS31LXWu+cs3qBhiSNUpJoHUlY9sE6doDnJvckbv95ep4ZmOrVH
	T+3Jknpn64bjSmVPSNYnS9yXxGcBoQFBE6TqY3MjDKDmJfnmeb893PVDOUYdI1Bq3o1o
	hEsg==
From: Rundong Ge <rdong.ge@gmail.com>
Date: Tue,  2 Apr 2019 12:56:09 +0000
Message-Id: <20190402125609.30313-1-rdong.ge@gmail.com>
Subject: [Bridge] [PATCH] netfilter:bridge: Hold bridge dev for fake_rtable
	to avoid the dangling pointer
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: pablo@netfilter.org
Cc: rdong.ge@gmail.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, fw@strlen.de, linux-kernel@vger.kernel.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, kadlec@blackhole.kfki.hu, davem@davemloft.net

Problem:
When bridge-nf-call-iptables is enabled, skb_dst(skb) of packets that
in the nfqueue may be a dangling pointer if user delete the bridge.
Because packets go through the br_nf_pre_routing_finish will set the dst
pointer to the br->fake_rtable. But the br struct will be freed
without the reference check for these skbs.

User impact:
Kernel panic may happen when user delete the bridge if there are
continuous traffics go through the nfqueue.
Here is a panic in my device which using kernel v3.10.

general protection fault: 0000 1 SMP
task: ffff880158418000 ti: ffff88011aeec000 task.ti: ffff88011aeec000
RIP: 0010:[<ffffffff8133a83f>] [<ffffffff8133a83f>]
 __percpu_counter_add+0xf/0x70
RSP: 0000:ffff88017fc83e20 EFLAGS: 00010206
RAX: ffff88011aeeffd8 RBX: ff0b900200000080 RCX: ffff88017fc901a0
RDX: 0000000000000020 RSI: ffffffffffffffff RDI: ff0b900200000080
RBP: ffff88017fc83e38 R08: ffff88015b5b1100 R09: ffff88017fc901a0
R10: 0000000000000000 R11: ffff88017fc83da0 R12: 0000000bfd80400a
R13: ffffffffffffffff R14: 0000000000000000 R15: ffff88017fc901c0
FS: 00007fcfe17d2700(0000) GS:ffff88017fc80000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa3fbdf0ec0 CR3: 0000000159eba000 CR4: 00000000003407e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Stack:
ffff88015b5b1100 0000000bfd80400a ff0b900200000000 ffff88017fc83e60
ffffffff8157be3a ffffffff81a3a580 000000000000000a 0000000000000000
ffff88017fc83e70 ffffffff8157c0be ffff88017fc83ed0 ffffffff8113977d
Call Trace:
<IRQ>
[<ffffffff8157be3a>] dst_destroy+0xfa/0x120
[<ffffffff8157c0be>] dst_destroy_rcu+0xe/0x20
[<ffffffff8113977d>] rcu_process_callbacks+0x1dd/0x550
[<ffffffff8108f2cf>] __do_softirq+0xef/0x280
[<ffffffff816b1adc>] call_softirq+0x1c/0x30
[<ffffffff8102d365>] do_softirq+0x65/0xa0
[<ffffffff8108f665>] irq_exit+0x115/0x120
[<ffffffff816b2755>] smp_apic_timer_interrupt+0x45/0x60
[<ffffffff816b0c9d>] apic_timer_interrupt+0x6d/0x80
<EOI>
[<ffffffff816b016b>] ? sysret_audit+0x17/0x21
RIP [<ffffffff8133a83f>] __percpu_counter_add+0xf/0x70
RSP <ffff88017fc83e20>

Solution:
Hold the bridge dev until there is no dst reference.

Signed-off-by: Rundong Ge <rdong.ge@gmail.com>
---
 net/bridge/br_if.c              |  3 +++
 net/bridge/br_netfilter_hooks.c |  3 ++-
 net/bridge/br_netfilter_ipv6.c  |  3 ++-
 net/bridge/br_nf_core.c         |  1 +
 net/core/dst.c                  | 13 ++++++++++++-
 5 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 41f0a69..21948bd 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -384,6 +384,9 @@ void br_dev_delete(struct net_device *dev, struct list_head *head)
 	cancel_delayed_work_sync(&br->gc_work);
 
 	br_sysfs_delbr(br->dev);
+#if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
+	dst_release(&br->fake_rtable.dst);
+#endif
 	unregister_netdevice_queue(br->dev, head);
 }
 
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 22afa56..3683f0f 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -401,7 +401,8 @@ static int br_nf_pre_routing_finish(struct net *net, struct sock *sk, struct sk_
 			kfree_skb(skb);
 			return 0;
 		}
-		skb_dst_set_noref(skb, &rt->dst);
+		skb_dst_set(skb, &rt->dst);
+		dst_hold(&rt->dst);
 	}
 
 	skb->dev = nf_bridge->physindev;
diff --git a/net/bridge/br_netfilter_ipv6.c b/net/bridge/br_netfilter_ipv6.c
index e88d664..425b11a 100644
--- a/net/bridge/br_netfilter_ipv6.c
+++ b/net/bridge/br_netfilter_ipv6.c
@@ -201,7 +201,8 @@ static int br_nf_pre_routing_finish_ipv6(struct net *net, struct sock *sk, struc
 			kfree_skb(skb);
 			return 0;
 		}
-		skb_dst_set_noref(skb, &rt->dst);
+		skb_dst_set(skb, &rt->dst);
+		dst_hold(&rt->dst);
 	}
 
 	skb->dev = nf_bridge->physindev;
diff --git a/net/bridge/br_nf_core.c b/net/bridge/br_nf_core.c
index 8e2d7cf..6543c3c 100644
--- a/net/bridge/br_nf_core.c
+++ b/net/bridge/br_nf_core.c
@@ -81,6 +81,7 @@ void br_netfilter_rtable_init(struct net_bridge *br)
 	dst_init_metrics(&rt->dst, br_dst_default_metrics, true);
 	rt->dst.flags	= DST_NOXFRM | DST_FAKE_RTABLE;
 	rt->dst.ops = &fake_dst_ops;
+	dev_hold(br->dev);
 }
 
 int __init br_nf_core_init(void)
diff --git a/net/core/dst.c b/net/core/dst.c
index a263309..0e6f2a2 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -186,13 +186,24 @@ void dst_release(struct dst_entry *dst)
 {
 	if (dst) {
 		int newrefcnt;
+#if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
+		unsigned short fakertable = dst->flags & DST_FAKE_RTABLE;
+#endif
 
 		newrefcnt = atomic_dec_return(&dst->__refcnt);
 		if (unlikely(newrefcnt < 0))
 			net_warn_ratelimited("%s: dst:%p refcnt:%d\n",
 					     __func__, dst, newrefcnt);
-		if (!newrefcnt)
+		if (!newrefcnt) {
+#if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
+			if (fakertable) {
+				if (dst->dev)
+					dev_put(dst->dev);
+				return;
+			}
+#endif
 			call_rcu(&dst->rcu_head, dst_destroy_rcu);
+		}
 	}
 }
 EXPORT_SYMBOL(dst_release);
-- 
1.8.3.1

