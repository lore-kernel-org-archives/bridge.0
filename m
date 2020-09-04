Return-Path: <Henrik.Bjoernlund@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1599211167; x=1630747167;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=o6duENUzbkFkp2C7Ma8T2ODsQTBHZTrbxuc1hJaheSQ=;
 b=cxiipNWXd2WPDiXZ9BiI0qWDPU0NdTcMfiHp+dnPBGCDSfPLMP6t8bmb
 ILuu0wLs5HDQjfS2FD86lWMaUIujrEYN3uwr19lxl74dvaAME/xIhk8Rt
 IpSUEdXdvpxERjEHu68XpNBa4v+G1TMHjsRj4yZabUIj9zPRzdf7vWDy2
 qQj4zd2AnBvnq2ODolQLAP3ZETe/6Vy8LD5pEQywO7cvFnGsisnvvZyeN
 vtnqku5N5CtpGKHo5VkmvN7clzfJNbhKVptqpoWiexqqgqkKaNE2LkK3Q
 LLGOOrjr/AEYKqF8zulwkhgJaUkeLoNJRutFa5lTPiPoql9wEghlWNiEY w==;
From: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>
Date: Fri, 4 Sep 2020 09:15:27 +0000
Message-ID: <20200904091527.669109-8-henrik.bjoernlund@microchip.com>
In-Reply-To: <20200904091527.669109-1-henrik.bjoernlund@microchip.com>
References: <20200904091527.669109-1-henrik.bjoernlund@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH RFC 7/7] bridge: cfm: Bridge port remove.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com, nikolay@nvidia.com, jiri@mellanox.com, idosch@mellanox.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, UNGLinuxDriver@microchip.com
Cc: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>

This is addition of CFM functionality to delete MEP instances
on a port that is removed from the bridge.
A MEP can only exist on a port that is related to a bridge.

Signed-off-by: Henrik Bjoernlund  <henrik.bjoernlund@microchip.com>
---
 net/bridge/br_cfm.c     | 13 +++++++++++++
 net/bridge/br_if.c      |  1 +
 net/bridge/br_private.h |  6 ++++++
 3 files changed, 20 insertions(+)

diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
index b7fed2c1d8ec..c724ce020ce3 100644
--- a/net/bridge/br_cfm.c
+++ b/net/bridge/br_cfm.c
@@ -921,3 +921,16 @@ bool br_cfm_created(struct net_bridge *br)
 {
 	return !list_empty(&br->mep_list);
 }
+
+/* Deletes the CFM instances on a specific bridge port
+ * note: called under rtnl_lock
+ */
+void br_cfm_port_del(struct net_bridge *br, struct net_bridge_port *port)
+{
+	struct br_cfm_mep *mep;
+
+	list_for_each_entry_rcu(mep, &br->mep_list, head,
+				lockdep_rtnl_is_held())
+		if (mep->create.ifindex == port->dev->ifindex)
+			mep_delete_implementation(br, mep);
+}
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index a0e9a7937412..f7d2f472ae24 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -334,6 +334,7 @@ static void del_nbp(struct net_bridge_port *p)
 	spin_unlock_bh(&br->lock);
 
 	br_mrp_port_del(br, p);
+	br_cfm_port_del(br, p);
 
 	br_ifinfo_notify(RTM_DELLINK, NULL, p);
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 53bcbdd21f34..5617255f0c0c 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1369,6 +1369,7 @@ int br_cfm_parse(struct net_bridge *br, struct net_bridge_port *p,
 		 struct nlattr *attr, int cmd, struct netlink_ext_ack *extack);
 int br_cfm_rx_frame_process(struct net_bridge_port *p, struct sk_buff *skb);
 bool br_cfm_created(struct net_bridge *br);
+void br_cfm_port_del(struct net_bridge *br, struct net_bridge_port *p);
 int br_cfm_config_fill_info(struct sk_buff *skb, struct net_bridge *br);
 int br_cfm_status_fill_info(struct sk_buff *skb,
 			    struct net_bridge *br,
@@ -1393,6 +1394,11 @@ static inline bool br_cfm_created(struct net_bridge *br)
 	return false;
 }
 
+static inline void br_cfm_port_del(struct net_bridge *br,
+				   struct net_bridge_port *p)
+{
+}
+
 static inline int br_cfm_config_fill_info(struct sk_buff *skb, struct net_bridge *br)
 {
 	return -EOPNOTSUPP;
-- 
2.28.0

