Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=I7rRGkpXq7CkNzOX7vahMr99VKUy5W50XI5Z7ov8fk4=;
	b=uXvAX9f8MXyVBj4il+aU680EQYfn682FYCpvlogcZjqFlWSro7hHZIaDdisvKKR7CZ
	gC0yhdu/mPz0MJ/fvh177zcu5hx77Fi38g+0+GAAq+rBV9pKGaYw/DBrGESG4J/8mu1V
	z63eoBYqJ18dLxnXG1sw3pyfc/URj5NnQ/FSIYE3/p6HjyesQRxAuW1ai1IThLxLjHkI
	Pb7paN9/VqSUIK+8b0zuMcZ+Jy3gS/0JTcRjX9dJc2ai7UB7W1RdIlXe8idGR4djv+OS
	p1W2FmIHuwcq6YUbOBkqjR0X1CJvlQVCzXKvNkXn2lap3O9cRKD3GrtCG6rWvoSd8cj/
	TRpQ==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon,  4 Feb 2019 15:36:29 -0800
Message-Id: <20190204233633.20421-9-f.fainelli@gmail.com>
In-Reply-To: <20190204233633.20421-1-f.fainelli@gmail.com>
References: <20190204233633.20421-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH 08/12] rocker: Implement ndo_get_port_parent_id()
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

mlxsw implements SWITCHDEV_ATTR_ID_PORT_PARENT_ID and we want to get rid
of switchdev_ops eventually, ease that migration by implementing a
ndo_get_port_parent_id() function which returns what
switchdev_port_attr_get() would do.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/rocker/rocker_main.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 62a205eba9f7..596f44dbfae1 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2026,6 +2026,18 @@ static void rocker_port_neigh_destroy(struct net_device *dev,
 			    err);
 }
 
+static int rocker_port_get_port_parent_id(struct net_device *dev,
+					  struct netdev_phys_item_id *ppid)
+{
+	const struct rocker_port *rocker_port = netdev_priv(dev);
+	const struct rocker *rocker = rocker_port->rocker;
+
+	ppid->id_len = sizeof(rocker->hw.id);
+	memcpy(&ppid->id, &rocker->hw.id, ppid->id_len);
+
+	return 0;
+}
+
 static const struct net_device_ops rocker_port_netdev_ops = {
 	.ndo_open			= rocker_port_open,
 	.ndo_stop			= rocker_port_stop,
@@ -2035,6 +2047,7 @@ static const struct net_device_ops rocker_port_netdev_ops = {
 	.ndo_get_phys_port_name		= rocker_port_get_phys_port_name,
 	.ndo_change_proto_down		= rocker_port_change_proto_down,
 	.ndo_neigh_destroy		= rocker_port_neigh_destroy,
+	.ndo_get_port_parent_id		= rocker_port_get_port_parent_id,
 };
 
 /********************
@@ -2049,10 +2062,6 @@ static int rocker_port_attr_get(struct net_device *dev,
 	int err = 0;
 
 	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_PARENT_ID:
-		attr->u.ppid.id_len = sizeof(rocker->hw.id);
-		memcpy(&attr->u.ppid.id, &rocker->hw.id, attr->u.ppid.id_len);
-		break;
 	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
 		err = rocker_world_port_attr_bridge_flags_get(rocker_port,
 							      &attr->u.brport_flags);
-- 
2.17.1

