Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1594712371; x=1626248371;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HVKMV+YoS0rvNMp387sg/5WAHdCOziofqNB5E+Ov/pE=;
 b=l0koWf7EMGdP4qg9ME0sVIbai5wqeoyX7iYa6bN6tF043viSthTj7if7
 TEgHlTK/Yafa8xiXXWyowykzZjoNLhkNAtoZMjbJSA//fXzcycN1ac812
 Ymp+uImS01o5w3siX3CgzQR4/JSww3mXR3AgpeGe0sIuADuw0xVFug5gd
 YvU4X9dh8HQPa2qTIKtcaDbGZzFI87jojnSQ3d0tbyri2cmuxT8un5yd4
 fRBvTO6RPHkySMbktHruWnsLQzUHdIP+4gEkSDJo5HhbpYp03wAhn1rkw
 DGfrnQ2+gIth9VSCkgmgBYUJZdResx0+iI8QswyErYXZt4wfk2VpKkzaR g==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Tue, 14 Jul 2020 09:34:57 +0200
Message-ID: <20200714073458.1939574-12-horatiu.vultur@microchip.com>
In-Reply-To: <20200714073458.1939574-1-horatiu.vultur@microchip.com>
References: <20200714073458.1939574-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v4 11/12] bridge: mrp: Extend
	br_mrp_fill_info
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org, jiri@resnulli.us, ivecera@redhat.com, andrew@lunn.ch, UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

This patch extends the function br_mrp_fill_info to return also the
status for the interconnect ring.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 net/bridge/br_mrp_netlink.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/bridge/br_mrp_netlink.c b/net/bridge/br_mrp_netlink.c
index a006e0771e8d3..2a2fdf3500c5b 100644
--- a/net/bridge/br_mrp_netlink.c
+++ b/net/bridge/br_mrp_netlink.c
@@ -474,6 +474,11 @@ int br_mrp_fill_info(struct sk_buff *skb, struct net_bridge *br)
 				     p->dev->ifindex))
 			goto nla_put_failure;
 
+		p = rcu_dereference(mrp->i_port);
+		if (p && nla_put_u32(skb, IFLA_BRIDGE_MRP_INFO_I_IFINDEX,
+				     p->dev->ifindex))
+			goto nla_put_failure;
+
 		if (nla_put_u16(skb, IFLA_BRIDGE_MRP_INFO_PRIO,
 				mrp->prio))
 			goto nla_put_failure;
@@ -493,6 +498,19 @@ int br_mrp_fill_info(struct sk_buff *skb, struct net_bridge *br)
 				mrp->test_monitor))
 			goto nla_put_failure;
 
+		if (nla_put_u32(skb, IFLA_BRIDGE_MRP_INFO_IN_STATE,
+				mrp->in_state))
+			goto nla_put_failure;
+		if (nla_put_u32(skb, IFLA_BRIDGE_MRP_INFO_IN_ROLE,
+				mrp->in_role))
+			goto nla_put_failure;
+		if (nla_put_u32(skb, IFLA_BRIDGE_MRP_INFO_IN_TEST_INTERVAL,
+				mrp->in_test_interval))
+			goto nla_put_failure;
+		if (nla_put_u32(skb, IFLA_BRIDGE_MRP_INFO_IN_TEST_MAX_MISS,
+				mrp->in_test_max_miss))
+			goto nla_put_failure;
+
 		nla_nest_end(skb, tb);
 	}
 	nla_nest_end(skb, mrp_tb);
-- 
2.27.0

