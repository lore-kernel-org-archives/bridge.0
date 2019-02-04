Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=+GrH69au9gNQJGXuWwx46YWKRJ0rC1zNpRUoiH8JEA4=;
	b=pZ78XFWbsFeKcNi6xAbtMbKSLTaQfIkwdbebCv9BMI6rU3acG3AGgZtfT08Gf5iLhD
	b9MXEHe8uKJjj3yeyPn1Qi3lQ/xHLy6j7HS0XBX4pC4iEn7/PTJ3GNVBMT3lkRvo/RQ5
	O2IpRLBz6bpfbsgRLy9sH76aaWxLE93TQt+xa0WB9Fmp0YxRw0L7wY5BZRcVu66IAmzU
	CgHyKozG/OOGY+9YzaFt8u+a2/MvgubKuLhCO/nXlrs54sRxSJbUlBnbVE+ekpmdmlnB
	vHbeB2U9uz8Gn1BCckjDKaGfDkhHNcXRtJw/SFBjKM1mhAgyKmtA5+usGK+xJ5inIaaE
	PYTQ==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon,  4 Feb 2019 15:36:32 -0800
Message-Id: <20190204233633.20421-12-f.fainelli@gmail.com>
In-Reply-To: <20190204233633.20421-1-f.fainelli@gmail.com>
References: <20190204233633.20421-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH 11/12] net: dsa: Implement ndo_get_port_parent_id()
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

DSA implements SWITCHDEV_ATTR_ID_PORT_PARENT_ID and we want to get rid
of switchdev_ops eventually, ease that migration by implementing a
ndo_get_port_parent_id() function which returns what
switchdev_port_attr_get() would do.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/dsa/slave.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 91de3a663226..70395a0ae52e 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -362,18 +362,23 @@ static int dsa_slave_port_obj_del(struct net_device *dev,
 	return err;
 }
 
-static int dsa_slave_port_attr_get(struct net_device *dev,
-				   struct switchdev_attr *attr)
+static int dsa_slave_get_port_parent_id(struct net_device *dev,
+					struct netdev_phys_item_id *ppid)
 {
 	struct dsa_port *dp = dsa_slave_to_port(dev);
 	struct dsa_switch *ds = dp->ds;
 	struct dsa_switch_tree *dst = ds->dst;
 
+	ppid->id_len = sizeof(dst->index);
+	memcpy(&ppid->id, &dst->index, ppid->id_len);
+
+	return 0;
+}
+
+static int dsa_slave_port_attr_get(struct net_device *dev,
+				   struct switchdev_attr *attr)
+{
 	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_PARENT_ID:
-		attr->u.ppid.id_len = sizeof(dst->index);
-		memcpy(&attr->u.ppid.id, &dst->index, attr->u.ppid.id_len);
-		break;
 	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT:
 		attr->u.brport_flags_support = 0;
 		break;
@@ -1046,6 +1051,7 @@ static const struct net_device_ops dsa_slave_netdev_ops = {
 	.ndo_get_phys_port_name	= dsa_slave_get_phys_port_name,
 	.ndo_setup_tc		= dsa_slave_setup_tc,
 	.ndo_get_stats64	= dsa_slave_get_stats64,
+	.ndo_get_port_parent_id	= dsa_slave_get_port_parent_id,
 };
 
 static const struct switchdev_ops dsa_slave_switchdev_ops = {
-- 
2.17.1

