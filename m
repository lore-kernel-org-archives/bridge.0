Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=+cAJT30s79rwrRdCawr263WbIC1EO48FBpksOa85nOM=;
	b=WsTCn46hQD+u8ZQmsNOTsm5ccW3HqjQK/5grJ+bunI4DN9xu1R0hhNuqm0BpP6HnK6k8qwLyYbWQtujNx23TywlBaFUDY9kOHCWkmLmcUaoqaYKGBehPQ4TvNkyQJxLuUwz+0JfqoZ31wBE7XMMip93XNiMZR+CLsSeN5yh15aA=
From: Ido Schimmel <idosch@mellanox.com>
Date: Sat, 13 Oct 2018 17:18:38 +0000
Message-ID: <20181013171725.3261-12-idosch@mellanox.com>
References: <20181013171725.3261-1-idosch@mellanox.com>
In-Reply-To: <20181013171725.3261-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 11/18] vxlan: Add netif_is_vxlan()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "ivecera@redhat.com" <ivecera@redhat.com>, "andrew@lunn.ch" <andrew@lunn.ch>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, mlxsw <mlxsw@mellanox.com>, Ido Schimmel <idosch@mellanox.com>, "vivien.didelot@savoirfairelinux.com" <vivien.didelot@savoirfairelinux.com>, "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Jiri Pirko <jiri@mellanox.com>, Petr Machata <petrm@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

Add the ability to determine whether a netdev is a VxLAN netdev by
calling the above mentioned function that checks the netdev's private
flags.

This will allow modules to identify netdev events involving a VxLAN
netdev and act accordingly. For example, drivers capable of VxLAN
offload will need to configure the underlying device when a VxLAN netdev
is being enslaved to an offloaded bridge.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
---
 drivers/net/vxlan.c       | 1 +
 include/linux/netdevice.h | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index a646aa8e98ff..9bfd562aa81c 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -3178,6 +3178,7 @@ static int __vxlan_dev_create(struct net *net, struct=
 net_device *dev,
 	if (err)
 		return err;
=20
+	dev->priv_flags |=3D IFF_VXLAN;
 	dev->ethtool_ops =3D &vxlan_ethtool_ops;
=20
 	/* create an fdb entry for a valid default destination */
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 22e4ef7bb701..290083ff285a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1487,6 +1487,7 @@ struct net_device_ops {
  * @IFF_NO_RX_HANDLER: device doesn't support the rx_handler hook
  * @IFF_FAILOVER: device is a failover master device
  * @IFF_FAILOVER_SLAVE: device is lower dev of a failover master device
+ * @IFF_VXLAN: device is a VxLAN device
  */
 enum netdev_priv_flags {
 	IFF_802_1Q_VLAN			=3D 1<<0,
@@ -1518,6 +1519,7 @@ enum netdev_priv_flags {
 	IFF_NO_RX_HANDLER		=3D 1<<26,
 	IFF_FAILOVER			=3D 1<<27,
 	IFF_FAILOVER_SLAVE		=3D 1<<28,
+	IFF_VXLAN			=3D 1<<29,
 };
=20
 #define IFF_802_1Q_VLAN			IFF_802_1Q_VLAN
@@ -1548,6 +1550,7 @@ enum netdev_priv_flags {
 #define IFF_NO_RX_HANDLER		IFF_NO_RX_HANDLER
 #define IFF_FAILOVER			IFF_FAILOVER
 #define IFF_FAILOVER_SLAVE		IFF_FAILOVER_SLAVE
+#define IFF_VXLAN			IFF_VXLAN
=20
 /**
  *	struct net_device - The DEVICE structure.
@@ -4567,6 +4570,11 @@ static inline bool netif_is_failover_slave(const str=
uct net_device *dev)
 	return dev->priv_flags & IFF_FAILOVER_SLAVE;
 }
=20
+static inline bool netif_is_vxlan(const struct net_device *dev)
+{
+	return dev->priv_flags & IFF_VXLAN;
+}
+
 /* This device needs to keep skb dst for qdisc enqueue or ndo_start_xmit()=
 */
 static inline void netif_keep_dst(struct net_device *dev)
 {
--=20
2.17.2

