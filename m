Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat, 26 Aug 2017 22:56:07 +0200
Message-Id: <1503780970-10312-3-git-send-email-andrew@lunn.ch>
In-Reply-To: <1503780970-10312-1-git-send-email-andrew@lunn.ch>
References: <1503780970-10312-1-git-send-email-andrew@lunn.ch>
Subject: [Bridge] [PATCH RFC WIP 2/5] net: bridge: Skip receive handler on
	brX interface
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev <netdev@vger.kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vivien Didelot <vivien.didelot@savoirfairelinux.com>, nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, jiri@mellanox.com

The brX interface will soon become a member of the bridge. As such, it
will get a receiver handler assigned. However, we don't want to handle
packets received on this soft interfaces. So detect the condition and
say all the packets pass.
---
 net/bridge/br_input.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 7637f58c1226..38c2a41968f2 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -267,6 +267,10 @@ rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
 		return RX_HANDLER_CONSUMED;
 
 	p = br_port_get_rcu(skb->dev);
+
+	if (p->dev == p->br->dev)
+		return RX_HANDLER_PASS;
+
 	if (p->flags & BR_VLAN_TUNNEL) {
 		if (br_handle_ingress_vlan_tunnel(skb, p,
 						  nbp_vlan_group_rcu(p)))
-- 
2.14.1

