Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1593588179; x=1625124179;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aWm+L+wE/a795Tsk1bRpXP+dtgc9uslu1pAjKBx9m8s=;
 b=uW8HzGwOQRkOCWxWbpwG80VBgP7VZpbFNFEX1VEWR5o+E4w9HfCNBk0v
 MVkOjm+0RbbOzbmyIm+84QfiBhksgwKotBrjKqYxAJe4gbKd2+ZgbZFdL
 reGPBO/xHUOZYVoU4mmM9gT8MiQarkcK5IQGZ0XLgDBaDinPlcQsWWUim
 j4wLyo+rJOGzdKdn7CbEfo2AfOEBHYnZbDN99LaqOo63IZP5Gi2W4kJ8x
 Nf3PVJpx1QHyaCrEv9lCiGrp/MBoz4khjxPsdZ3/j3lQhQtxIay+C8IS6
 rKl3gx9sThuX2WrAMMqKg/dabu3MjPYzZZ+ReIZO9ISCWDo9yHq8GCvFC Q==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Wed, 1 Jul 2020 09:22:38 +0200
Message-ID: <20200701072239.520807-3-horatiu.vultur@microchip.com>
In-Reply-To: <20200701072239.520807-1-horatiu.vultur@microchip.com>
References: <20200701072239.520807-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v2 2/3] bridge: mrp: Add br_mrp_fill_info
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org, jiri@mellanox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org, UNGLinuxDriver@microchip.com
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

Add the function br_mrp_fill_info which populates the MRP attributes
regarding the status of each MRP instance.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 net/bridge/br_mrp_netlink.c | 64 +++++++++++++++++++++++++++++++++++++
 net/bridge/br_private.h     |  7 ++++
 2 files changed, 71 insertions(+)

diff --git a/net/bridge/br_mrp_netlink.c b/net/bridge/br_mrp_netlink.c
index 34b3a8776991f..c4e80844e53bd 100644
--- a/net/bridge/br_mrp_netlink.c
+++ b/net/bridge/br_mrp_netlink.c
@@ -304,6 +304,70 @@ int br_mrp_parse(struct net_bridge *br, struct net_bridge_port *p,
 	return 0;
 }
 
+int br_mrp_fill_info(struct sk_buff *skb, struct net_bridge *br)
+{
+	struct nlattr *tb, *mrp_tb;
+	struct br_mrp *mrp;
+
+	mrp_tb = nla_nest_start_noflag(skb, IFLA_BRIDGE_MRP);
+	if (!mrp_tb)
+		return -EMSGSIZE;
+
+	list_for_each_entry(mrp, &br->mrp_list, list) {
+		struct net_bridge_port *p;
+
+		tb = nla_nest_start_noflag(skb, IFLA_BRIDGE_MRP_INFO);
+		if (!tb)
+			goto nla_info_failure;
+
+		if (nla_put_u32(skb, IFLA_BRIDGE_MRP_INFO_RING_ID,
+				mrp->ring_id))
+			goto nla_put_failure;
+
+		p = rtnl_dereference(mrp->p_port);
+		if (p && nla_put_u32(skb, IFLA_BRIDGE_MRP_INFO_P_IFINDEX,
+				     p->dev->ifindex))
+			goto nla_put_failure;
+
+		p = rtnl_dereference(mrp->s_port);
+		if (p && nla_put_u32(skb, IFLA_BRIDGE_MRP_INFO_S_IFINDEX,
+				     p->dev->ifindex))
+			goto nla_put_failure;
+
+		if (nla_put_u16(skb, IFLA_BRIDGE_MRP_INFO_PRIO,
+				mrp->prio))
+			goto nla_put_failure;
+		if (nla_put_u32(skb, IFLA_BRIDGE_MRP_INFO_RING_STATE,
+				mrp->ring_state))
+			goto nla_put_failure;
+		if (nla_put_u32(skb, IFLA_BRIDGE_MRP_INFO_RING_ROLE,
+				mrp->ring_role))
+			goto nla_put_failure;
+		if (nla_put_u32(skb, IFLA_BRIDGE_MRP_INFO_TEST_INTERVAL,
+				mrp->test_interval))
+			goto nla_put_failure;
+		if (nla_put_u32(skb, IFLA_BRIDGE_MRP_INFO_TEST_MAX_MISS,
+				mrp->test_max_miss))
+			goto nla_put_failure;
+		if (nla_put_u32(skb, IFLA_BRIDGE_MRP_INFO_TEST_MONITOR,
+				mrp->test_monitor))
+			goto nla_put_failure;
+
+		nla_nest_end(skb, tb);
+	}
+	nla_nest_end(skb, mrp_tb);
+
+	return 0;
+
+nla_put_failure:
+	nla_nest_cancel(skb, tb);
+
+nla_info_failure:
+	nla_nest_cancel(skb, mrp_tb);
+
+	return -EMSGSIZE;
+}
+
 int br_mrp_port_open(struct net_device *dev, u8 loc)
 {
 	struct net_bridge_port *p;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 6a7d8e218ae7e..65d2c163a24ab 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1317,6 +1317,7 @@ int br_mrp_parse(struct net_bridge *br, struct net_bridge_port *p,
 int br_mrp_process(struct net_bridge_port *p, struct sk_buff *skb);
 bool br_mrp_enabled(struct net_bridge *br);
 void br_mrp_port_del(struct net_bridge *br, struct net_bridge_port *p);
+int br_mrp_fill_info(struct sk_buff *skb, struct net_bridge *br);
 #else
 static inline int br_mrp_parse(struct net_bridge *br, struct net_bridge_port *p,
 			       struct nlattr *attr, int cmd,
@@ -1339,6 +1340,12 @@ static inline void br_mrp_port_del(struct net_bridge *br,
 				   struct net_bridge_port *p)
 {
 }
+
+static inline int br_mrp_fill_info(struct sk_buff *skb, struct net_bridge *br)
+{
+	return 0;
+}
+
 #endif
 
 /* br_netlink.c */
-- 
2.27.0

