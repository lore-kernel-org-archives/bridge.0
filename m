Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Iyaq3yEjkUqCdNXty1gzLutDNHaIKj6egyv5O/wPqPk=;
	b=lHWeIXstmVjHTmd88m1ivg4nObLl4jTdKn3KpN8aMDAshZHsgkPsGNbUDERKeb7BhI
	9TNquCTl+ssi4E4t0fu2NfGPToDkT8YCsdZIUQLXGryqcnBVLP2RGFi7SFetrCqPJdMA
	S9kE2MEHwHB4Xd/Djxn6/OguEWiCYOhkcQRPZRTrC6vdmxwEsNx4l2JbKMokQaVR/vRb
	mQRWbyZd4KdKTG2DhEHTIMMAMc1NejJIk2eYm5a/QqwaBGdrIeVtvnvDFS3ggnLx4pDM
	VCcn8kC20sOXRbEZRoi4IMMRlKHNSMopsdROE8ez4oVx+JvehykHujJT0jpY4j/XrGIZ
	cDKg==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 13 Feb 2019 14:06:35 -0800
Message-Id: <20190213220638.1552-7-f.fainelli@gmail.com>
In-Reply-To: <20190213220638.1552-1-f.fainelli@gmail.com>
References: <20190213220638.1552-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next 6/9] rocker: Check bridge flags during
	prepare phase
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

In preparation for getting rid of switchdev_port_attr_get(), have rocker
check for the bridge flags being set through switchdev_port_attr_set()
with the SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS attribute identifier.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/rocker/rocker_main.c | 48 +++++++++++++++--------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 5ce8d5aba603..863a8b32e6e9 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -1565,37 +1565,48 @@ static int rocker_world_port_attr_stp_state_set(struct rocker_port *rocker_port,
 	return wops->port_attr_stp_state_set(rocker_port, state);
 }
 
+static int
+rocker_world_port_attr_bridge_flags_support_get(const struct rocker_port *
+						rocker_port,
+						unsigned long *
+						p_brport_flags_support)
+{
+	struct rocker_world_ops *wops = rocker_port->rocker->wops;
+
+	if (!wops->port_attr_bridge_flags_support_get)
+		return -EOPNOTSUPP;
+	return wops->port_attr_bridge_flags_support_get(rocker_port,
+							p_brport_flags_support);
+}
+
 static int
 rocker_world_port_attr_bridge_flags_set(struct rocker_port *rocker_port,
 					unsigned long brport_flags,
-					struct switchdev_trans *trans)
+					struct switchdev_trans *trans,
+					bool pre_set)
 {
 	struct rocker_world_ops *wops = rocker_port->rocker->wops;
+	unsigned long brport_flags_s;
+	int err;
 
 	if (!wops->port_attr_bridge_flags_set)
 		return -EOPNOTSUPP;
 
-	if (switchdev_trans_ph_prepare(trans))
+	if (switchdev_trans_ph_prepare(trans) && pre_set) {
+		err = rocker_world_port_attr_bridge_flags_support_get(rocker_port,
+							      &brport_flags_s);
+		if (err)
+			return err;
+
+		if (brport_flags & ~brport_flags_s)
+			return -EOPNOTSUPP;
 		return 0;
+	}
 
 	return wops->port_attr_bridge_flags_set(rocker_port, brport_flags,
 						trans);
 }
 
-static int
-rocker_world_port_attr_bridge_flags_support_get(const struct rocker_port *
-						rocker_port,
-						unsigned long *
-						p_brport_flags_support)
-{
-	struct rocker_world_ops *wops = rocker_port->rocker->wops;
-
-	if (!wops->port_attr_bridge_flags_support_get)
-		return -EOPNOTSUPP;
-	return wops->port_attr_bridge_flags_support_get(rocker_port,
-							p_brport_flags_support);
-}
-
 static int
 rocker_world_port_attr_bridge_ageing_time_set(struct rocker_port *rocker_port,
 					      u32 ageing_time,
@@ -2066,6 +2077,7 @@ static int rocker_port_attr_set(struct net_device *dev,
 				struct switchdev_trans *trans)
 {
 	struct rocker_port *rocker_port = netdev_priv(dev);
+	bool pre_set = false;
 	int err = 0;
 
 	switch (attr->id) {
@@ -2074,10 +2086,12 @@ static int rocker_port_attr_set(struct net_device *dev,
 							   attr->u.stp_state,
 							   trans);
 		break;
+	case SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS:
+		pre_set = true; /* fall through */
 	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
 		err = rocker_world_port_attr_bridge_flags_set(rocker_port,
 							      attr->u.brport_flags,
-							      trans);
+							      trans, pre_set);
 		break;
 	case SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME:
 		err = rocker_world_port_attr_bridge_ageing_time_set(rocker_port,
-- 
2.17.1

