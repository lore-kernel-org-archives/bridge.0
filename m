Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=MI5rLrltG6qcpnCztg5EZ1K3nVSvKYVEA3cqkLXVhFU=;
	b=WuLev+j/rALhoQ09/hmsGx+askv/Om3DOSeAG2td9H9Eqa/fh4v88lSfuM9DAqmzWa50prDypUqZzsYuR/rdk3nwjrE7U94LzvXChju4zgau0r/19Ah+ZnxoRAlxOSpeQNzHwrPFX8QAj6f8jur/8XSv9xp6dvrRKlOJvdXHF4Y=
From: Petr Machata <petrm@mellanox.com>
In-Reply-To: <cover.1527503302.git.petrm@mellanox.com>
References: <cover.1527503302.git.petrm@mellanox.com>
Message-Id: <39f36b56f2eb14842b534e48575e66c7db3c2e4a.1527503302.git.petrm@mellanox.com>
Date: Mon, 28 May 2018 12:50:21 +0200
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v2 5/7] staging: fsl-dpaa2: ethsw: Ignore
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
Cc: f.fainelli@gmail.com, andrew@lunn.ch, nikolay@cumulusnetworks.com, gregkh@linuxfoundation.org, vivien.didelot@savoirfairelinux.com, idosch@mellanox.com, jiri@mellanox.com, razvan.stefanescu@nxp.com, davem@davemloft.net

Ignore VLAN events where the orig_dev is the bridge device itself.

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

