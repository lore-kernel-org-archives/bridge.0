Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=6SHEuAD5/41y/dv28qKa6YR8/ZUVzpLi5sCtQnX1F7c=;
	b=pWwpeLecckkObrV1Bl0e/iAlssMNciITu6M5IXbeABlx7zXh395n/ECZFDNJVqRPrd
	i50Adfu4dskekO136gPzYGF9fLU6tZU67KHyS+KhS//wmN+QAO5dGpADIO9Jsp0fVJW8
	QgOkpeUlLdGBn8kilRMmAGqTPd48T+v1usgMMIcZK+9tOZzZgT3j7Ru/cP5+5+kqf/OQ
	SOOBjTW7e+gmlzHY5/C27Irz/D8jZ1UKEuHemv32Lj6PnzckU3hJod7Ed3ZcyPGtHEFy
	sM8LYY+gR17n9bFCng2myS0AF2YlkURPooNsJsFt72GGMqmB455Y8rxf+G0cPD7W3KOA
	z04w==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Sun, 10 Feb 2019 09:50:54 -0800
Message-Id: <20190210175105.31629-6-f.fainelli@gmail.com>
In-Reply-To: <20190210175105.31629-1-f.fainelli@gmail.com>
References: <20190210175105.31629-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2 05/16] rocker: Check bridge flags
	during prepare phase
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: devel@driverdev.osuosl.org, andrew@lunn.ch, Florian Fainelli <f.fainelli@gmail.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, idosch@mellanox.com, jiri@mellanox.com, vivien.didelot@gmail.com

In preparation for getting rid of switchdev_port_attr_get(), have rocker
check for the bridge flags being set through switchdev_port_attr_set()
with the SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS attribute identifier.

Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/rocker/rocker_main.c | 40 ++++++++++++++---------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 66f72f8c46e5..8657313b6f30 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -1565,18 +1565,42 @@ static int rocker_world_port_attr_stp_state_set(struct rocker_port *rocker_port,
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
 					struct switchdev_trans *trans)
 {
 	struct rocker_world_ops *wops = rocker_port->rocker->wops;
+	unsigned long brport_flags_s;
+	int err;
 
 	if (!wops->port_attr_bridge_flags_set)
 		return -EOPNOTSUPP;
 
-	if (switchdev_trans_ph_prepare(trans))
+	if (switchdev_trans_ph_prepare(trans)) {
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
@@ -1593,20 +1617,6 @@ rocker_world_port_attr_bridge_flags_get(const struct rocker_port *rocker_port,
 	return wops->port_attr_bridge_flags_get(rocker_port, p_brport_flags);
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
-- 
2.19.1

