Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=RNI+XdPhvdY1OjXcP7pgSSgHAFM8lKWzobqUPPNGsDM=;
	b=lztEYxPrM0KIxkllqKr9XK2KuM1KTBj4yxtTT2w8+sHbBTgTqxzn2DyotYlcnZPPYN
	Ab6UXf3U1UCOie3pSWDNqyXBtoa38nDn/3vePXjTrbuaXKK/Ve1dcgJJiuqeT8Ii0Z3R
	O/893aP6xfVvwOCwSUGzyAstkO214Qwp1s+I84jhdAncUGy4nlqXNGd3iX9ZHLYt1ET+
	67myD0LtTs6unBeVIDsLda1aD16yfbcxg8oN5JuITz99o/eO+FTdKWazOC65PZ7veiw6
	29I8zd55KDiXxY/eLnGwLzzv/QB5aEuXb/7TMdwQUvoadJXP052zFyGyUZPxZrAie4+D
	bqHw==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon,  4 Feb 2019 15:36:27 -0800
Message-Id: <20190204233633.20421-7-f.fainelli@gmail.com>
In-Reply-To: <20190204233633.20421-1-f.fainelli@gmail.com>
References: <20190204233633.20421-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH 06/12] mscc: ocelot: Implement
	ndo_get_port_parent_id()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Jakub Kicinski <jakub.kicinski@netronome.com>, John Hurley <john.hurley@netronome.com>, "open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@netronome.com>, Eric Dumazet <edumazet@google.com>, Ioana Ciornei <ioana.ciornei@nxp.com>, Tyler Hicks <tyhicks@canonical.com>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Ioana Radulescu <ruxandra.radulescu@nxp.com>, "open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Amritha Nambiar <amritha.nambiar@intel.com>, Saeed Mahameed <saeedm@mellanox.com>, Dirk van der Merwe <dirk.vandermerwe@netronome.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Vivien Didelot <vivien.didelot@gmail.com>, Alexander Duyck <alexander.h.duyck@intel.com>, "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Simon Horman <simon.horman@netronome.com>, Roopa Prabhu <roopa@cumulusnetworks.com>, Satanand Burla <sburla@marvell.com>, Ido Schimmel <idosch@mellanox.com>, Jiri Pirko <jiri@mellanox.com>, Kirill Tkhai <ktkhai@virtuozzo.com>, Edwin Peer <edwin.peer@netronome.com>, Michael Chan <michael.chan@broadcom.com>, Christian Brauner <christian@brauner.io>, Felix Manlunas <fmanlunas@marvell.com>, Leon Romanovsky <leon@kernel.org>, Nic Viljoen <nick.viljoen@netronome.com>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, open list <linux-kernel@vger.kernel.org>, Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>, David Ahern <dsahern@gmail.com>, Joe Perches <joe@perches.com>, Derek Chickles <dchickles@marvell.com>, "David S. Miller" <davem@davemloft.net>

Ocelot only supports SWITCHDEV_ATTR_ID_PORT_PARENT_ID as a valid
switchdev attribute getter, convert it to use ndo_get_port_parent_id()
and get rid of the switchdev_ops::switchdev_port_attr_get altogether.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/mscc/ocelot.c | 33 ++++++++++++------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index c6a575eb0ff5..195306d05bcd 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -916,6 +916,18 @@ static int ocelot_set_features(struct net_device *dev,
 	return 0;
 }
 
+static int ocelot_get_port_parent_id(struct net_device *dev,
+				     struct netdev_phys_item_id *ppid)
+{
+	struct ocelot_port *ocelot_port = netdev_priv(dev);
+	struct ocelot *ocelot = ocelot_port->ocelot;
+
+	ppid->id_len = sizeof(ocelot->base_mac);
+	memcpy(&ppid->id, &ocelot->base_mac, ppid->id_len);
+
+	return 0;
+}
+
 static const struct net_device_ops ocelot_port_netdev_ops = {
 	.ndo_open			= ocelot_port_open,
 	.ndo_stop			= ocelot_port_stop,
@@ -930,6 +942,7 @@ static const struct net_device_ops ocelot_port_netdev_ops = {
 	.ndo_vlan_rx_add_vid		= ocelot_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid		= ocelot_vlan_rx_kill_vid,
 	.ndo_set_features		= ocelot_set_features,
+	.ndo_get_port_parent_id		= ocelot_get_port_parent_id,
 };
 
 static void ocelot_get_strings(struct net_device *netdev, u32 sset, u8 *data)
@@ -1013,25 +1026,6 @@ static const struct ethtool_ops ocelot_ethtool_ops = {
 	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
 };
 
-static int ocelot_port_attr_get(struct net_device *dev,
-				struct switchdev_attr *attr)
-{
-	struct ocelot_port *ocelot_port = netdev_priv(dev);
-	struct ocelot *ocelot = ocelot_port->ocelot;
-
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_PARENT_ID:
-		attr->u.ppid.id_len = sizeof(ocelot->base_mac);
-		memcpy(&attr->u.ppid.id, &ocelot->base_mac,
-		       attr->u.ppid.id_len);
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
-}
-
 static int ocelot_port_attr_stp_state_set(struct ocelot_port *ocelot_port,
 					  struct switchdev_trans *trans,
 					  u8 state)
@@ -1331,7 +1325,6 @@ static int ocelot_port_obj_del(struct net_device *dev,
 }
 
 static const struct switchdev_ops ocelot_port_switchdev_ops = {
-	.switchdev_port_attr_get	= ocelot_port_attr_get,
 	.switchdev_port_attr_set	= ocelot_port_attr_set,
 };
 
-- 
2.17.1

