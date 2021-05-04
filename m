Return-Path: <Joseph.Huang@garmin.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pps1;
 bh=eGB4vdoqn/KudE2r/6GyvU8YVGKeGDDX+aBr9Ms9O88=;
 b=heWUE/Eyu7rg6O4+O5OyFfHOOi5Tb/Ggco6nuv+glqjaFk0F6jKGnVyhSsEnM0TI5Plk
 +7629hQ2/INPWo4LnVjizunq8/HcqliU4//DaCx0i93RFguJehjUw89gKjgMQvV0pOS4
 9RfgPtFibhbskj2hYcup+tkyKjlfNqFsXgmZFDYMDQNB+c3T5/REBKMLykQnqw9oHHnl
 Hz+O3it9H2DPQuszdCsqXLe7m5YRvtE7c55DdAkAltp/G+zgDiwpAWMeGgigbAch2RvE
 1MLLFU0+XCCB8nFmlfMzhDL7KAlR0+FUsGOy+xempYcRP1tVjmNOSkH6Lz/bRB3jgscs cQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=garmin.onmicrosoft.com; s=selector1-garmin-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGB4vdoqn/KudE2r/6GyvU8YVGKeGDDX+aBr9Ms9O88=;
 b=Q7OLogtpLy9t6HYXi44dtp8fAht4NfP9+UKYNknUu09kHDVPnqavCVAMUVfJxDxGQK7Rzkga2iMXQI2NZvHauRHr+MwiQ3ab3wchoW83ifAIadBMtZpSgaFHZt2L0/Sh0Yy7/all0hvH4e9DRjqet4bk5WAQ1GO4ElbMBU4s3Fx02wZE9fp/Rdw//FqnpXrSo4WlNfGV/t9PysiFC2/LgzeWgVLSz+cYcXgzOEc9YG9pt+hnyy5f/i6Jtlo/6aqCskrQanO1Ms4Lk5FpyHOLB9dKNqIVB0Wkn7wjUHc5Dmw+VegMaVsAcp2McPtaJAeGJAAgQF8KJpSVZQNxfxyM5A==
From: Joseph Huang <Joseph.Huang@garmin.com>
Date: Tue, 4 May 2021 14:22:55 -0400
Message-ID: <20210504182259.5042-3-Joseph.Huang@garmin.com>
In-Reply-To: <20210504182259.5042-1-Joseph.Huang@garmin.com>
References: <20210504182259.5042-1-Joseph.Huang@garmin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH 2/6] bridge: Offload mrouter port forwarding to
	switchdev
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Joseph Huang <Joseph.Huang@garmin.com>

Offload the mrouter port forwarding to switchdev also.

Currently multicast snooping fails to forward traffic in some cases
where there're multiple hardware-offloading bridges involved.

Consider the following scenario:

                 +--------------------+
                 |                    |
                 |      Snooping   +--|    +------------+
                 |      Bridge 1   |P1|----| Listener 1 |
                 |     (Querier)   +--|    +------------+
                 |                    |
                 +--------------------+
                           |
                           |
                 +--------------------+
                 |    | mrouter |     |
+-----------+    |    +---------+  +--|    +------------+
| MC Source |----|      Snooping   |P2|----| Listener 2 |
+-----------|    |      Bridge 2   +--|    +------------+
                 |    (Non-Querier)   |
                 +--------------------+

In this scenario, Listener 2 is able to receive multicast traffic
from MC Source while Listener 1 is not. The reason is that, on
Snooping Bridge 2, when the (soft) bridge attempts to forward
a packet to the mrouter port via br_multicast_flood, the effort
is blocked by nbp_switchdev_allowed_egress, since offload_fwd_mark
indicates that the packet should have been handled by the hardware
already. Listener 2 would receive the packets without any problem
since P2 is programmed into the hardware as a member of the group;
however the mrouter port would not since the mrouter port would
normally not be a member of any group, and thus will not be added
to the address database on the hardware switch chip.

This patch takes a simplistic approach: when an mrouter port is added/
deleted, it's added/deleted to all mdb groups; and similarly, when
an mdb group is added/deleted, all mrouter ports are added/deleted
to/from it.

Before this patch, switchdev programming matches exactly with mdb:
 +-----+
 | mdb |
 +-----+
    |
 +----------------------------------------------+
 |  |        +--------------------------------+ |
 |  |        | both in mdb and switchdev      | |
 |  |        | +------+   +------+   +------+ | |
 |  +--------|-| port |---| port |---| port | | |
 |           | +------+   +------+   +------+ | |
 | switchdev +--------------------------------+ |
 +----------------------------------------------+

After this patch, some entries will only exist in switchdev and not
in mdb:
 +-----+
 | mdb |
 +-----+
    |
 +---------------------------------------------------------------------+
 |  |        +--------------------------------++---------------------+ |
 |  |        |  both in mdb and switchdev     ||  only in switchdev  | |
 |  |        | +------+   +------+   +------+ || +------+   +------+ | |
 |  +--------|-| port |---| port |---| port | || |  mr  |---|  mr  | | |
 |           | +------+   +------+   +------+ || +------+   +------+ | |
 | switchdev +--------------------------------++---------------------+ |
 +---------------------------------------------------------------------+

Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
---
 net/bridge/br_multicast.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 226bb05c3b42..5ed0d5efef09 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -522,10 +522,26 @@ static void br_multicast_destroy_mdb_entry(struct net_bridge_mcast_gc *gc)
 	kfree_rcu(mp, rcu);
 }
 
+/* Add/delete all mrouter ports to/from a group
+ * called while br->multicast_lock is held
+ */
+static void br_multicast_group_change(struct net_bridge_mdb_entry *mp,
+				      bool is_group_added)
+{
+	struct net_bridge_port *p;
+	struct hlist_node *n;
+
+	hlist_for_each_entry_safe(p, n, &mp->br->router_list, rlist)
+		br_mdb_switchdev_port(mp, p, is_group_added ?
+				      RTM_NEWMDB : RTM_DELMDB);
+}
+
 static void br_multicast_del_mdb_entry(struct net_bridge_mdb_entry *mp)
 {
 	struct net_bridge *br = mp->br;
 
+	br_multicast_group_change(mp, false);
+
 	rhashtable_remove_fast(&br->mdb_hash_tbl, &mp->rhnode,
 			       br_mdb_rht_params);
 	hlist_del_init_rcu(&mp->mdb_node);
@@ -1068,6 +1084,8 @@ struct net_bridge_mdb_entry *br_multicast_new_group(struct net_bridge *br,
 		hlist_add_head_rcu(&mp->mdb_node, &br->mdb_list);
 	}
 
+	br_multicast_group_change(mp, true);
+
 	return mp;
 }
 
@@ -2651,8 +2669,18 @@ static void br_port_mc_router_state_change(struct net_bridge_port *p,
 		.flags = SWITCHDEV_F_DEFER,
 		.u.mrouter = is_mc_router,
 	};
+	struct net_bridge_mdb_entry *mp;
+	struct hlist_node *n;
 
 	switchdev_port_attr_set(p->dev, &attr, NULL);
+
+	/* Add/delete the router port to/from all multicast group
+	 * called whle br->multicast_lock is held
+	 */
+	hlist_for_each_entry_safe(mp, n, &p->br->mdb_list, mdb_node) {
+		br_mdb_switchdev_port(mp, p, is_mc_router ?
+				      RTM_NEWMDB : RTM_DELMDB);
+	}
 }
 
 /*
-- 
2.17.1

