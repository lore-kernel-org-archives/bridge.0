Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=NyChWdRafOwc4M2+gSOnj2cHT88wd1bnNz0kBgj+NYQ=;
	b=Nss6A2pL321KkYb7iElWuZ5wqvJ7hVppmyFFUNy25ljjhXeQUxE7UrFLf8aOMJPq6OUjx6TWqS5hgRVKtC7swlV6j09r/HWRWmilpufTe1CUZ/N/Iqeexc/Zt0sC1yzIH4zn3rxnPIchPWDbprnki/TdiSWyM9FtGeJCDkcP7r4=
From: Petr Machata <petrm@mellanox.com>
In-Reply-To: <cover.1527641426.git.petrm@mellanox.com>
References: <cover.1527641426.git.petrm@mellanox.com>
Message-Id: <137041c10e506ef6f4fcdebed4297fec81b9fd6a.1527641426.git.petrm@mellanox.com>
Date: Wed, 30 May 2018 03:00:07 +0200
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v4 6/8] staging: fsl-dpaa2: ethsw: Ignore
 bridge VLAN events
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, devel@driverdev.osuosl.org, bridge@lists.linux-foundation.org
Cc: f.fainelli@gmail.com, andrew@lunn.ch, nikolay@cumulusnetworks.com, gregkh@linuxfoundation.org, vivien.didelot@savoirfairelinux.com, idosch@mellanox.com, jiri@mellanox.com, razvan.stefanescu@nxp.com, davem@davemloft.net, dan.carpenter@oracle.com

A follow-up patch enables emitting VLAN notifications for the bridge CPU
port in addition to the existing slave port notifications. These
notifications have orig_dev set to the bridge in question.

Because there's no specific support for these VLANs, just ignore the
notifications to maintain the current behavior.

Signed-off-by: Petr Machata <petrm@mellanox.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index c723a04..a17dd29 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -719,6 +719,9 @@ static int port_vlans_add(struct net_device *netdev,
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	int vid, err;
 
+	if (netif_is_bridge_master(vlan->obj.orig_dev))
+		return -EOPNOTSUPP;
+
 	if (switchdev_trans_ph_prepare(trans))
 		return 0;
 
@@ -873,6 +876,9 @@ static int port_vlans_del(struct net_device *netdev,
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	int vid, err;
 
+	if (netif_is_bridge_master(vlan->obj.orig_dev))
+		return -EOPNOTSUPP;
+
 	for (vid = vlan->vid_begin; vid <= vlan->vid_end; vid++) {
 		err = ethsw_port_del_vlan(port_priv, vid);
 		if (err)
-- 
2.4.11

