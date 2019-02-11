Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=p5ZCXTBfLok1XMf+SlQNjbPYGN3N8X4VxG7Tq+I0H5E=;
	b=OSIA8Fj2pOi8lhCDKo5ZYKT8u0H9kmPzH/BVhtIGSchGYFx56fFEUVkxdOe3G5YDkL
	ZyMPiBo7zqGPKB4r03DMaloM7CdCi5cKXAyj4GcrEQ03C9UiMUa6zx0Cw6OmP+RLSL2B
	o39SdzxdfHh1qq4yZB0xdtfFIwpH0lXDFenjKudDnO154i8DAPuDZjLJOquTiniHgnOk
	DCD/zJNkUN9KAB1IR16U/hgB8kfOwh4+nqZJPmrir7gYBUYPURe7sL4Bxx6VkrzRgb2P
	mtGQ7MeofN/DlFTywGxbwpUEVZLBQG5kSBYes1HY958iFY+RZFQoiu7VYZAiDNTEpg6h
	3TyQ==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon, 11 Feb 2019 13:17:48 -0800
Message-Id: <20190211211749.19847-3-f.fainelli@gmail.com>
In-Reply-To: <20190211211749.19847-1-f.fainelli@gmail.com>
References: <20190211211749.19847-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next 2/3] rocker: Remove getting
	PORT_BRIDGE_FLAGS
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

There is no code that attempts to get the
SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS attribute, remove support for that.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/rocker/rocker.h       |  2 --
 drivers/net/ethernet/rocker/rocker_main.c  | 15 ---------------
 drivers/net/ethernet/rocker/rocker_ofdpa.c | 10 ----------
 3 files changed, 27 deletions(-)

diff --git a/drivers/net/ethernet/rocker/rocker.h b/drivers/net/ethernet/rocker/rocker.h
index 748fb12260a6..2b2e1c4f0dc3 100644
--- a/drivers/net/ethernet/rocker/rocker.h
+++ b/drivers/net/ethernet/rocker/rocker.h
@@ -109,8 +109,6 @@ struct rocker_world_ops {
 	int (*port_attr_bridge_flags_set)(struct rocker_port *rocker_port,
 					  unsigned long brport_flags,
 					  struct switchdev_trans *trans);
-	int (*port_attr_bridge_flags_get)(const struct rocker_port *rocker_port,
-					  unsigned long *p_brport_flags);
 	int (*port_attr_bridge_flags_support_get)(const struct rocker_port *
 						  rocker_port,
 						  unsigned long *
diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 66f72f8c46e5..5ce8d5aba603 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -1582,17 +1582,6 @@ rocker_world_port_attr_bridge_flags_set(struct rocker_port *rocker_port,
 						trans);
 }
 
-static int
-rocker_world_port_attr_bridge_flags_get(const struct rocker_port *rocker_port,
-					unsigned long *p_brport_flags)
-{
-	struct rocker_world_ops *wops = rocker_port->rocker->wops;
-
-	if (!wops->port_attr_bridge_flags_get)
-		return -EOPNOTSUPP;
-	return wops->port_attr_bridge_flags_get(rocker_port, p_brport_flags);
-}
-
 static int
 rocker_world_port_attr_bridge_flags_support_get(const struct rocker_port *
 						rocker_port,
@@ -2061,10 +2050,6 @@ static int rocker_port_attr_get(struct net_device *dev,
 	int err = 0;
 
 	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
-		err = rocker_world_port_attr_bridge_flags_get(rocker_port,
-							      &attr->u.brport_flags);
-		break;
 	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT:
 		err = rocker_world_port_attr_bridge_flags_support_get(rocker_port,
 								      &attr->u.brport_flags_support);
diff --git a/drivers/net/ethernet/rocker/rocker_ofdpa.c b/drivers/net/ethernet/rocker/rocker_ofdpa.c
index bea7895930f6..9c07f6040720 100644
--- a/drivers/net/ethernet/rocker/rocker_ofdpa.c
+++ b/drivers/net/ethernet/rocker/rocker_ofdpa.c
@@ -2511,16 +2511,6 @@ static int ofdpa_port_attr_bridge_flags_set(struct rocker_port *rocker_port,
 	return err;
 }
 
-static int
-ofdpa_port_attr_bridge_flags_get(const struct rocker_port *rocker_port,
-				 unsigned long *p_brport_flags)
-{
-	const struct ofdpa_port *ofdpa_port = rocker_port->wpriv;
-
-	*p_brport_flags = ofdpa_port->brport_flags;
-	return 0;
-}
-
 static int
 ofdpa_port_attr_bridge_flags_support_get(const struct rocker_port *
 					 rocker_port,
-- 
2.17.1

