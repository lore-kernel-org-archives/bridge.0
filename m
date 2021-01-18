Return-Path: <rasmus.villemoes@prevas.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpkkFwXLIHzY8BlZXKg3oBEANHhM8BBvDNZNHRVaxXY=;
 b=jQZqn3Pc242n/taN0tkL7gv9y/rmMRAa+phNukEx8mJfK58Gwm0I/DZPWZsPf/c+wERmjZNELSYu4M9l3NdGq33LI7c6M1AsKTJ0tGeNSWXfq7v62VUdWtZPubRw6OFmRS7avmTgIIrfLx/CDLBJApMfsLQAHGYOBSQMlP7szg0=
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Date: Mon, 18 Jan 2021 19:13:19 +0100
Message-Id: <20210118181319.25419-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net] net: mrp: use stp state as substitute for
	unimplemented mrp state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Vladimir Oltean <vladimir.oltean@nxp.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Horatiu Vultur <horatiu.vultur@microchip.com>

When using MRP with hardware that does understand the concept of
blocked or forwarding ports, but not the full MRP offload, we
currently fail to tell the hardware what state it should put the port
in when the ring is closed - resulting in a ring of forwarding ports
and all the trouble that comes with that.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---

I don't really understand why SWITCHDEV_ATTR_ID_MRP_PORT_STATE even
has to exist seperately from SWITCHDEV_ATTR_ID_PORT_STP_STATE, and
it's hard to tell what the difference might be since no kernel code
implements the former.

 net/bridge/br_mrp_switchdev.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/bridge/br_mrp_switchdev.c b/net/bridge/br_mrp_switchdev.c
index ed547e03ace1..8a1c7953e57a 100644
--- a/net/bridge/br_mrp_switchdev.c
+++ b/net/bridge/br_mrp_switchdev.c
@@ -180,6 +180,24 @@ int br_mrp_port_switchdev_set_state(struct net_bridge_port *p,
 	int err;
 
 	err = switchdev_port_attr_set(p->dev, &attr);
+	if (err == -EOPNOTSUPP) {
+		attr.id = SWITCHDEV_ATTR_ID_PORT_STP_STATE;
+		switch (state) {
+		case BR_MRP_PORT_STATE_DISABLED:
+		case BR_MRP_PORT_STATE_NOT_CONNECTED:
+			attr.u.stp_state = BR_STATE_DISABLED;
+			break;
+		case BR_MRP_PORT_STATE_BLOCKED:
+			attr.u.stp_state = BR_STATE_BLOCKING;
+			break;
+		case BR_MRP_PORT_STATE_FORWARDING:
+			attr.u.stp_state = BR_STATE_FORWARDING;
+			break;
+		default:
+			return err;
+		};
+		err = switchdev_port_attr_set(p->dev, &attr);
+	}
 	if (err && err != -EOPNOTSUPP)
 		br_warn(p->br, "error setting offload MRP state on port %u(%s)\n",
 			(unsigned int)p->port_no, p->dev->name);
-- 
2.23.0

