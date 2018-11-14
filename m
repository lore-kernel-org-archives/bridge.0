Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=EuBsDr1vknGzqyrniSCCEpKyG7K5bClkEUqL8okCYIs=;
	b=bEzwuDre+TOy4LEsDoBu06NaWz05SLiWqNv+Z9jmQpXs9YHDeefwkf8Xsh2GdQ5IpW
	s6XyAOhVToZ2UGqAByf5e0gAM0N+tkxLQgBNVm1SmVt87nypy6oJhhYZcujk7atNpNVA
	got1j5bTcBWRZn0T6zlwC+LAXKdRDToX9XezA=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Wed, 14 Nov 2018 19:27:03 +0200
Message-Id: <20181114172703.5795-1-nikolay@cumulusnetworks.com>
In-Reply-To: <ae147dd3-1ad8-8b8b-93f1-09297171883a@cumulusnetworks.com>
References: <ae147dd3-1ad8-8b8b-93f1-09297171883a@cumulusnetworks.com>
Subject: [Bridge] [PATCH net v2] net: bridge: fix vlan stats use-after-free
	on destruction
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, syzkaller-bugs@googlegroups.com, davem@davemloft.net

Syzbot reported a use-after-free of the global vlan context on port vlan
destruction. When I added per-port vlan stats I missed the fact that the
global vlan context can be freed before the per-port vlan rcu callback.
There're a few different ways to deal with this, I've chosen to add a
new private flag that is set only when per-port stats are allocated so
we can directly check it on destruction without dereferencing the global
context at all. The flag is internally controlled by the kernel and
user-space isn't allowed to set it.

Fixes: 9163a0fc1f0c ("net: bridge: add support for per-port vlan stats")
Reported-by: syzbot+04681da557a0e49a52e5@syzkaller.appspotmail.com
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
v2: cosmetic change, move the check to br_process_vlan_info where the
    other checks are done

 include/uapi/linux/if_bridge.h | 3 +++
 net/bridge/br_netlink.c        | 4 ++++
 net/bridge/br_vlan.c           | 3 ++-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index e41eda3c71f1..fa1f72276712 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -130,6 +130,9 @@ enum {
 #define BRIDGE_VLAN_INFO_RANGE_BEGIN	(1<<3) /* VLAN is start of vlan range */
 #define BRIDGE_VLAN_INFO_RANGE_END	(1<<4) /* VLAN is end of vlan range */
 #define BRIDGE_VLAN_INFO_BRENTRY	(1<<5) /* Global bridge VLAN entry */
+#define BRIDGE_VLAN_INFO_PORT_STATS	(1<<6) /* Per-port VLAN stats */
+
+#define BRIDGE_VLAN_INFO_PRIVATE_FLAGS BRIDGE_VLAN_INFO_PORT_STATS
 
 struct bridge_vlan_info {
 	__u16 flags;
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 3345f1984542..a017ed566b67 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -573,6 +573,10 @@ static int br_process_vlan_info(struct net_bridge *br,
 	if (!vinfo_curr->vid || vinfo_curr->vid >= VLAN_VID_MASK)
 		return -EINVAL;
 
+	/* don't allow user-space control over private flags */
+	if (vinfo_curr->flags & BRIDGE_VLAN_INFO_PRIVATE_FLAGS)
+		return -EINVAL;
+
 	if (vinfo_curr->flags & BRIDGE_VLAN_INFO_RANGE_BEGIN) {
 		/* check if we are already processing a range */
 		if (*vinfo_last)
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 8c9297a01947..004e1f8c5040 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -197,7 +197,7 @@ static void nbp_vlan_rcu_free(struct rcu_head *rcu)
 	v = container_of(rcu, struct net_bridge_vlan, rcu);
 	WARN_ON(br_vlan_is_master(v));
 	/* if we had per-port stats configured then free them here */
-	if (v->brvlan->stats != v->stats)
+	if (v->flags & BRIDGE_VLAN_INFO_PORT_STATS)
 		free_percpu(v->stats);
 	v->stats = NULL;
 	kfree(v);
@@ -264,6 +264,7 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 flags)
 				err = -ENOMEM;
 				goto out_filt;
 			}
+			v->flags |= BRIDGE_VLAN_INFO_PORT_STATS;
 		} else {
 			v->stats = masterv->stats;
 		}
-- 
2.17.2

