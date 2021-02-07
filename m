Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=y/6NgpsBeErYab+30KbKJBuFft3Z4fcnH7w7GQj4tp0=;
 b=JbkOPJr04aovGfsmAXPf9CiN9/Koa04BxXUywI8aB5dDQfr4dJo77KZrCeVzJjMzuB
 10VWCvRGiRtt5Ya0/9SRRpBtWCUWh+hXxUKwYMsc9BL8ar/HYLGN5k26Yzp33MvvYPmG
 /iIRu+VDCGYluLfubCnaBoBN73kssBkwKg+8gjZeFPmzH2ZPEPrKD8vB4z+nkc9OwVdA
 vaH2NKM9NmW5PsSgXP7j1t/3c/hdI6D0s45puXvW4SLb6dUZTiVXZR1eGxTOMi8iFzLF
 cJF//YxAV9QxDR/DJSU3tBYgFbZn2vS7ErUYyocqt+Ha5qm5X05x0xVBqE1G8x05rsWH
 aC6Q==
From: Vladimir Oltean <olteanv@gmail.com>
Date: Mon,  8 Feb 2021 01:21:38 +0200
Message-Id: <20210207232141.2142678-7-olteanv@gmail.com>
In-Reply-To: <20210207232141.2142678-1-olteanv@gmail.com>
References: <20210207232141.2142678-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 6/9] net: bridge: stop treating EOPNOTSUPP
	as special in br_switchdev_set_port_flag
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Vadym Kochan <vkochan@marvell.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Taras Chornyi <tchornyi@marvell.com>, Ido Schimmel <idosch@idosch.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, linux-omap@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>

From: Vladimir Oltean <vladimir.oltean@nxp.com>

It is customary to return -EOPNOTSUPP when an operation is not supported.
Sometimes the fact that an operation is not supported is irrelevant to
upper layers, and in that case the return code is ignored.

However, in the case of br_switchdev_set_port_flag, it took it upon
itself to treat -EOPNOTSUPP differently and replace it with 0.

Due to that, users won't be notified that a switchdev port doesn't
support changing a certain bridge port flag (learning, flooding etc).

However, no one is returning -EOPNOTSUPP, seemingly as a workaround to
the fact that -EOPNOTSUPP will be ignored.

So let's stop treating -EOPNOTSUPP special, and just propagate that
error, and convert all drivers to use EOPNOTSUPP instead of EINVAL.
We already made br_switchdev_set_port_flag stop printing, and we have
callers that shouldn't fail already ignore the error code.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../ethernet/marvell/prestera/prestera_switchdev.c    |  2 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_switchdev.c  |  2 +-
 drivers/net/ethernet/rocker/rocker_main.c             |  2 +-
 drivers/net/ethernet/ti/cpsw_switchdev.c              |  2 +-
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c               |  2 +-
 net/bridge/br_switchdev.c                             | 11 +----------
 net/dsa/port.c                                        |  2 +-
 7 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_switchdev.c b/drivers/net/ethernet/marvell/prestera/prestera_switchdev.c
index ab62945c7183..9acd6907454d 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_switchdev.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_switchdev.c
@@ -587,7 +587,7 @@ static int prestera_port_attr_br_flags_set(struct prestera_port *port,
 	int err;
 
 	if (val.mask & ~(BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD))
-		err = -EINVAL;
+		err = -EOPNOTSUPP;
 
 	br_port = prestera_bridge_port_by_dev(port->sw->swdev, dev);
 	if (!br_port)
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index f19be04704e7..a2b2dd7bf6b3 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -661,7 +661,7 @@ static int mlxsw_sp_port_attr_br_flags_set(struct mlxsw_sp_port *mlxsw_sp_port,
 	int err;
 
 	if (val.mask & ~(BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD))
-		return -EINVAL;
+		return -EOPNOTSUPP;
 
 	bridge_port = mlxsw_sp_bridge_port_find(mlxsw_sp_port->mlxsw_sp->bridge,
 						orig_dev);
diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index b8087dd0b284..e755c9ac8716 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -1591,7 +1591,7 @@ rocker_world_port_attr_bridge_flags_set(struct rocker_port *rocker_port,
 		return err;
 
 	if (val.mask & ~brport_flags_s)
-		return -EINVAL;
+		return -EOPNOTSUPP;
 
 	return wops->port_attr_bridge_flags_set(rocker_port, val.flags);
 }
diff --git a/drivers/net/ethernet/ti/cpsw_switchdev.c b/drivers/net/ethernet/ti/cpsw_switchdev.c
index dd4b1e161dde..b47ec2ac5b17 100644
--- a/drivers/net/ethernet/ti/cpsw_switchdev.c
+++ b/drivers/net/ethernet/ti/cpsw_switchdev.c
@@ -63,7 +63,7 @@ static int cpsw_port_attr_br_flags_set(struct cpsw_priv *priv,
 	bool unreg_mcast_add = false;
 
 	if (val.mask & ~(BR_LEARNING | BR_MCAST_FLOOD))
-		return -EINVAL;
+		return -EOPNOTSUPP;
 
 	if (val.flags & BR_MCAST_FLOOD)
 		unreg_mcast_add = true;
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index c4bcd63b68b8..25ebb127db3c 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -915,7 +915,7 @@ static int dpaa2_switch_port_attr_br_flags_set(struct net_device *netdev,
 	int err = 0;
 
 	if (val.mask & ~(BR_LEARNING | BR_FLOOD))
-		return -EINVAL;
+		return -EOPNOTSUPP;
 
 	/* Learning is enabled per switch */
 	err = dpaa2_switch_set_learning(port_priv->ethsw_data,
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 3b460eb225dd..e1774f1b0a44 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -82,16 +82,7 @@ int br_switchdev_set_port_flag(struct net_bridge_port *p,
 	/* We run from atomic context here */
 	err = call_switchdev_notifiers(SWITCHDEV_PORT_ATTR_SET, p->dev,
 				       &info.info, extack);
-	err = notifier_to_errno(err);
-	if (err == -EOPNOTSUPP)
-		return 0;
-
-	if (err) {
-		NL_SET_ERR_MSG_MOD(extack, "bridge flag offload is not supported");
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
+	return notifier_to_errno(err);
 }
 
 static void
diff --git a/net/dsa/port.c b/net/dsa/port.c
index fffe5f14ec0a..26be06ba1461 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -388,7 +388,7 @@ int dsa_port_bridge_flags(const struct dsa_port *dp,
 	struct dsa_switch *ds = dp->ds;
 
 	if (!ds->ops->port_bridge_flags)
-		return -EINVAL;
+		return -EOPNOTSUPP;
 
 	return ds->ops->port_bridge_flags(ds, dp->index, val);
 }
-- 
2.25.1

