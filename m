Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=LbBXhe3YkkTyT7Tr9D7509SAnLlS8iTnmbaYese6GGQ=;
	b=Uy0SlXixSzeXW1dYz9yZnTMGZe3d+RWHPVE04Cr0FMGrgXFOuOFrC6lpuR239VLFP9
	79Ji2CxoL/btfxkjmVuSaaglpEWYyLCHqE2zyecVm4KkLsdzoy4poJbWZP1TxThNHzkw
	TiM19BNzmULTgsm3qH7ZT+ID79TMPysVrJIrwlfkHW+huqRguWe0sIM8G/Ea7SqpPsPk
	YNQuvAhmgD8AEkqTlWqYtt2EH7DElYG0L0OPWA22MZyElhTF/eolEpaqXrFJAPZ/6z99
	M0gXKxAg7hxnKBh1PRiWPuH+lvNxKdw7F+5YC5mIQqGELCUDbdKlSf8+a9zAuz5wzc/5
	IQew==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Fri,  8 Feb 2019 16:32:38 -0800
Message-Id: <20190209003248.31088-7-f.fainelli@gmail.com>
In-Reply-To: <20190209003248.31088-1-f.fainelli@gmail.com>
References: <20190209003248.31088-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next 06/16] net: bridge: Stop calling
	switchdev_port_attr_get()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, andrew@lunn.ch, Florian Fainelli <f.fainelli@gmail.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, vivien.didelot@gmail.com, Ido Schimmel <idosch@mellanox.com>, jiri@mellanox.com, "David S. Miller" <davem@davemloft.net>

Now that all switchdev drivers have been converted to checking the
bridge port flags during the prepare phase of the
switchdev_port_attr_set(), we can move straight to trying to set the
desired flag through SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/bridge/br_switchdev.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index db9e8ab96d48..939f300522c5 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -64,29 +64,15 @@ int br_switchdev_set_port_flag(struct net_bridge_port *p,
 {
 	struct switchdev_attr attr = {
 		.orig_dev = p->dev,
-		.id = SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
+		.id = SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS,
+		.flags = SWITCHDEV_F_DEFER,
+		.u.brport_flags = flags,
 	};
 	int err;
 
 	if (mask & ~BR_PORT_FLAGS_HW_OFFLOAD)
 		return 0;
 
-	err = switchdev_port_attr_get(p->dev, &attr);
-	if (err == -EOPNOTSUPP)
-		return 0;
-	if (err)
-		return err;
-
-	/* Check if specific bridge flag attribute offload is supported */
-	if (!(attr.u.brport_flags_support & mask)) {
-		br_warn(p->br, "bridge flag offload is not supported %u(%s)\n",
-			(unsigned int)p->port_no, p->dev->name);
-		return -EOPNOTSUPP;
-	}
-
-	attr.id = SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS;
-	attr.flags = SWITCHDEV_F_DEFER;
-	attr.u.brport_flags = flags;
 	err = switchdev_port_attr_set(p->dev, &attr);
 	if (err) {
 		br_warn(p->br, "error setting offload flag on port %u(%s)\n",
-- 
2.17.1

