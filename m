Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=l46VvHT7eqrMkE6E40frKPiWzb4eR8K705HCwYquJCU=;
	b=txh9ImLwOaMk2Pj6TsIYFuyxEpUJqVwgwNymksKWtPWisIJo2EiDoRKdrew+nKzHNe
	PTAz+ddwdXucDqiIBxUrJ0sc70xW6LOifRCyznfbhJGZeQ2mo4zGhbrQSkZPNHdip7WN
	l5uHQT+VJGmWm/gUwO8v7jRroVFoe6C1t4m5IP4AUqqocUPP+cW4EmpadcUIvS8/6AQ7
	t99n36Yvjx8Zbh8yIIkWBKvcgFkiK09KpgbH/iF5KlD/Ndac++AIG2wQCCEo8NjoyUag
	/rXTlITaLmSZrnaXrahsWpLrwdn5Whhop+Pv80iZ/6jWN2ujAnXh88N84GRlid2jSZxU
	Mu5Q==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 20 Feb 2019 16:58:24 -0800
Message-Id: <20190221005826.26317-7-f.fainelli@gmail.com>
In-Reply-To: <20190221005826.26317-1-f.fainelli@gmail.com>
References: <20190221005826.26317-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next v3 6/8] net: bridge: Stop calling
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

Now that all switchdev drivers have been converted to check the
SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS flags and report flags that they
do not support accordingly, we can migrate the bridge code to try to set
that attribute first, check the results and then do the actual setting.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/bridge/br_switchdev.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index db9e8ab96d48..af57c4a2b78a 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -64,21 +64,19 @@ int br_switchdev_set_port_flag(struct net_bridge_port *p,
 {
 	struct switchdev_attr attr = {
 		.orig_dev = p->dev,
-		.id = SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
+		.id = SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS,
+		.u.brport_flags = mask,
 	};
 	int err;
 
 	if (mask & ~BR_PORT_FLAGS_HW_OFFLOAD)
 		return 0;
 
-	err = switchdev_port_attr_get(p->dev, &attr);
+	err = switchdev_port_attr_set(p->dev, &attr);
 	if (err == -EOPNOTSUPP)
 		return 0;
-	if (err)
-		return err;
 
-	/* Check if specific bridge flag attribute offload is supported */
-	if (!(attr.u.brport_flags_support & mask)) {
+	if (err) {
 		br_warn(p->br, "bridge flag offload is not supported %u(%s)\n",
 			(unsigned int)p->port_no, p->dev->name);
 		return -EOPNOTSUPP;
@@ -87,6 +85,7 @@ int br_switchdev_set_port_flag(struct net_bridge_port *p,
 	attr.id = SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS;
 	attr.flags = SWITCHDEV_F_DEFER;
 	attr.u.brport_flags = flags;
+
 	err = switchdev_port_attr_set(p->dev, &attr);
 	if (err) {
 		br_warn(p->br, "error setting offload flag on port %u(%s)\n",
-- 
2.17.1

