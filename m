Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=7vuIGYN0KGvwnI1aHr46uRKC1r95J/r4Egh2ShHtxKY=;
	b=HlcqHp/QLH+1ZLerJN3RgfIOZblmCpGn246xZv/gjwZ9L8axYctjyh++1kQABNt0rx
	cYZl/cC57+lO5WgcSmJpCN1HBrq9nVwiJcxRT8vj468/u1QZCS0iSAshJxwo5OyiXhXV
	hMCWsiXfh1jkRxaxX7lwijEJQ4+V28YIEvsOqLzwVMDPfup4rde3EmSRwlpj6s11C3Wk
	PrDtz+TpIYtlB5LQ97QNX7MHQywdnKa71rNkkonf7wcZpyPVlX46a2g5UDKl0BxeLvbB
	4O6Dfhn8ZsrDCE5SPUigtGipPnapzGmztXroeA6zInGBPUR2ENHD74o84vu9B2wVVl6f
	v/pw==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon,  4 Feb 2019 15:36:24 -0800
Message-Id: <20190204233633.20421-4-f.fainelli@gmail.com>
In-Reply-To: <20190204233633.20421-1-f.fainelli@gmail.com>
References: <20190204233633.20421-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH 03/12] liquidio: Implement ndo_get_port_parent_id()
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

Liquidio only supports SWITCHDEV_ATTR_ID_PORT_PARENT_ID, which makes it
a great candidate to be converted to use the ndo_get_port_parent_id()
NDO instead of implementing switchdev_port_attr_get().

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../net/ethernet/cavium/liquidio/lio_main.c   | 22 ++++------------
 .../net/ethernet/cavium/liquidio/lio_vf_rep.c | 25 ++++++-------------
 2 files changed, 12 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index 3d24133e5e49..e97e6754ee09 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -21,7 +21,6 @@
 #include <linux/firmware.h>
 #include <net/vxlan.h>
 #include <linux/kthread.h>
-#include <net/switchdev.h>
 #include "liquidio_common.h"
 #include "octeon_droq.h"
 #include "octeon_iq.h"
@@ -3184,7 +3183,8 @@ static const struct devlink_ops liquidio_devlink_ops = {
 };
 
 static int
-lio_pf_switchdev_attr_get(struct net_device *dev, struct switchdev_attr *attr)
+liquidio_get_port_parent_id(struct net_device *dev,
+			    struct netdev_phys_item_id *ppid)
 {
 	struct lio *lio = GET_LIO(dev);
 	struct octeon_device *oct = lio->oct_dev;
@@ -3192,24 +3192,12 @@ lio_pf_switchdev_attr_get(struct net_device *dev, struct switchdev_attr *attr)
 	if (oct->eswitch_mode != DEVLINK_ESWITCH_MODE_SWITCHDEV)
 		return -EOPNOTSUPP;
 
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_PARENT_ID:
-		attr->u.ppid.id_len = ETH_ALEN;
-		ether_addr_copy(attr->u.ppid.id,
-				(void *)&lio->linfo.hw_addr + 2);
-		break;
-
-	default:
-		return -EOPNOTSUPP;
-	}
+	ppid->id_len = ETH_ALEN;
+	ether_addr_copy(ppid->id, (void *)&lio->linfo.hw_addr + 2);
 
 	return 0;
 }
 
-static const struct switchdev_ops lio_pf_switchdev_ops = {
-	.switchdev_port_attr_get = lio_pf_switchdev_attr_get,
-};
-
 static int liquidio_get_vf_stats(struct net_device *netdev, int vfidx,
 				 struct ifla_vf_stats *vf_stats)
 {
@@ -3259,6 +3247,7 @@ static const struct net_device_ops lionetdevops = {
 	.ndo_set_vf_trust	= liquidio_set_vf_trust,
 	.ndo_set_vf_link_state  = liquidio_set_vf_link_state,
 	.ndo_get_vf_stats	= liquidio_get_vf_stats,
+	.ndo_get_port_parent_id	= liquidio_get_port_parent_id,
 };
 
 /** \brief Entry point for the liquidio module
@@ -3534,7 +3523,6 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
 		 * netdev tasks.
 		 */
 		netdev->netdev_ops = &lionetdevops;
-		SWITCHDEV_SET_OPS(netdev, &lio_pf_switchdev_ops);
 
 		retval = netif_set_real_num_rx_queues(netdev, num_oqueues);
 		if (retval) {
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
index de61060721c4..f3f2e71431ac 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
@@ -25,7 +25,6 @@
 #include "octeon_nic.h"
 #include "octeon_main.h"
 #include "octeon_network.h"
-#include <net/switchdev.h>
 #include "lio_vf_rep.h"
 
 static int lio_vf_rep_open(struct net_device *ndev);
@@ -38,6 +37,8 @@ static int lio_vf_rep_phys_port_name(struct net_device *dev,
 static void lio_vf_rep_get_stats64(struct net_device *dev,
 				   struct rtnl_link_stats64 *stats64);
 static int lio_vf_rep_change_mtu(struct net_device *ndev, int new_mtu);
+static int lio_vf_get_port_parent_id(struct net_device *dev,
+				     struct netdev_phys_item_id *ppid);
 
 static const struct net_device_ops lio_vf_rep_ndev_ops = {
 	.ndo_open = lio_vf_rep_open,
@@ -47,6 +48,7 @@ static const struct net_device_ops lio_vf_rep_ndev_ops = {
 	.ndo_get_phys_port_name = lio_vf_rep_phys_port_name,
 	.ndo_get_stats64 = lio_vf_rep_get_stats64,
 	.ndo_change_mtu = lio_vf_rep_change_mtu,
+	.ndo_get_port_parent_id = lio_vf_get_port_parent_id,
 };
 
 static int
@@ -443,31 +445,19 @@ lio_vf_rep_pkt_xmit(struct sk_buff *skb, struct net_device *ndev)
 	return NETDEV_TX_OK;
 }
 
-static int
-lio_vf_rep_attr_get(struct net_device *dev, struct switchdev_attr *attr)
+static int lio_vf_get_port_parent_id(struct net_device *dev,
+				     struct netdev_phys_item_id *ppid)
 {
 	struct lio_vf_rep_desc *vf_rep = netdev_priv(dev);
 	struct net_device *parent_ndev = vf_rep->parent_ndev;
 	struct lio *lio = GET_LIO(parent_ndev);
 
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_PARENT_ID:
-		attr->u.ppid.id_len = ETH_ALEN;
-		ether_addr_copy(attr->u.ppid.id,
-				(void *)&lio->linfo.hw_addr + 2);
-		break;
-
-	default:
-		return -EOPNOTSUPP;
-	}
+	ppid->id_len = ETH_ALEN;
+	ether_addr_copy(ppid->id, (void *)&lio->linfo.hw_addr + 2);
 
 	return 0;
 }
 
-static const struct switchdev_ops lio_vf_rep_switchdev_ops = {
-	.switchdev_port_attr_get        = lio_vf_rep_attr_get,
-};
-
 static void
 lio_vf_rep_fetch_stats(struct work_struct *work)
 {
@@ -524,7 +514,6 @@ lio_vf_rep_create(struct octeon_device *oct)
 		ndev->min_mtu = LIO_MIN_MTU_SIZE;
 		ndev->max_mtu = LIO_MAX_MTU_SIZE;
 		ndev->netdev_ops = &lio_vf_rep_ndev_ops;
-		SWITCHDEV_SET_OPS(ndev, &lio_vf_rep_switchdev_ops);
 
 		vf_rep = netdev_priv(ndev);
 		memset(vf_rep, 0, sizeof(*vf_rep));
-- 
2.17.1

