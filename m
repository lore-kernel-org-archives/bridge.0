Return-Path: <Henrik.Bjoernlund@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1601996165; x=1633532165;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=v0/BOEk8FwPkuHSCL3bWhHvT/r5H6A4X4lw4kAN4c/4=;
 b=EUxzYgX8AD899m4FSKS+7Nd5KCldl9hPXhkZXWvKss01m/7lGYiF1epr
 HAwUvAZSiRHIlKxCRNUsDGEcblq3KOZmHDMWcM481RjmN14xDz2PJM9FY
 kf9mLRPixHesgXVbDta/LIBc628gLDY5DjICvZlgZGT92faGRvglIZTQi
 WulVQNPbL+shBxLNVn14C6gWscKYNsWtc72nOB0mDqcVYxPEVIVmq1Uav
 dt3ULXQTHmEEq4Mq7sg2A3bEpiZothnBzcm5V9LTJZjupZPBw7VGW3ygz
 zI+oLM/UiAoXKjwvF10iiH2hzNa2qS5Gf/f5qoDRUg/ZXmzEx6VuOKYJ9 Q==;
From: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>
Date: Tue, 6 Oct 2020 14:53:38 +0000
Message-ID: <20201006145338.1956886-10-henrik.bjoernlund@microchip.com>
In-Reply-To: <20201006145338.1956886-1-henrik.bjoernlund@microchip.com>
References: <20201006145338.1956886-1-henrik.bjoernlund@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [net-next v3 9/9] bridge: cfm: Bridge port remove.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com, nikolay@nvidia.com, jiri@resnulli.us, idosch@mellanox.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, UNGLinuxDriver@microchip.com
Cc: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>

This is addition of CFM functionality to delete MEP instances
on a port that is removed from the bridge.
A MEP can only exist on a port that is related to a bridge.

Signed-off-by: Henrik Bjoernlund  <henrik.bjoernlund@microchip.com>m
Reviewed-by: Horatiu Vultur  <horatiu.vultur@microchip.com>
---
 net/bridge/br_cfm.c     | 13 +++++++++++++
 net/bridge/br_if.c      |  1 +
 net/bridge/br_private.h |  6 ++++++
 3 files changed, 20 insertions(+)

diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
index 6fbfef44c235..fc8268cb76c1 100644
--- a/net/bridge/br_cfm.c
+++ b/net/bridge/br_cfm.c
@@ -867,3 +867,16 @@ bool br_cfm_created(struct net_bridge *br)
 {
 	return !hlist_empty(&br->mep_list);
 }
+
+/* Deletes the CFM instances on a specific bridge port
+ */
+void br_cfm_port_del(struct net_bridge *br, struct net_bridge_port *port)
+{
+	struct br_cfm_mep *mep;
+
+	ASSERT_RTNL();
+
+	hlist_for_each_entry(mep, &br->mep_list, head)
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
index c36a0e3e29f2..6c79b10dad82 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1465,6 +1465,7 @@ static inline int br_mrp_fill_info(struct sk_buff *skb, struct net_bridge *br)
 int br_cfm_parse(struct net_bridge *br, struct net_bridge_port *p,
 		 struct nlattr *attr, int cmd, struct netlink_ext_ack *extack);
 bool br_cfm_created(struct net_bridge *br);
+void br_cfm_port_del(struct net_bridge *br, struct net_bridge_port *p);
 int br_cfm_config_fill_info(struct sk_buff *skb, struct net_bridge *br);
 int br_cfm_status_fill_info(struct sk_buff *skb,
 			    struct net_bridge *br,
@@ -1484,6 +1485,11 @@ static inline bool br_cfm_created(struct net_bridge *br)
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

