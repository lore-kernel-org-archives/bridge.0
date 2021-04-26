Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:organization:content-transfer-encoding;
 bh=OOyB/1EE0eWY12Fb0O+Ry3sAB71ImU80hOCuCFisolk=;
 b=0HxjTxUqm16Mjfaxqs+3gIH6mIXzFURaMQXnQTxOWVr/b1qcz/uuVMvXrH4PIkKHkt
 E0of8vDgA0EnZ/7ghKu9m3qVi8i2U8tX46qT6tUf58bHMHPKoyWIx2Myyi3XdpWHnPai
 361UPhyG0ytSzko2v1PqsnWDTKm/+5i22SzYBDzwmE5ZBnl7MMMwRPIhsKpRZyyUJz8N
 HkZH702ly+zqHvMI5mi00tLT5FFcBFdiqT4r6nwkqMQOCo0TgQYBE+sTvsy0XHaYvIIa
 TqkiHTN6zFfAt9sDvyURfitCnKpGZ0j6l3uDComxii0BQaHOgBWygUe5GY/Joy+U36Iy
 0cUQ==
From: Tobias Waldekranz <tobias@waldekranz.com>
Date: Mon, 26 Apr 2021 19:04:03 +0200
Message-Id: <20210426170411.1789186-2-tobias@waldekranz.com>
In-Reply-To: <20210426170411.1789186-1-tobias@waldekranz.com>
References: <20210426170411.1789186-1-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [RFC net-next 1/9] net: dfwd: Constrain existing users to
	macvlan subordinates
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org
Cc: andrew@lunn.ch, f.fainelli@gmail.com, jiri@resnulli.us, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, idosch@idosch.org, nikolay@nvidia.com, roopa@nvidia.com, olteanv@gmail.com, vivien.didelot@gmail.com

The dfwd_add/del_station NDOs are currently only used by the macvlan
subsystem to request L2 forwarding offload from lower devices. In
order add support for other types of devices (like bridges), we
constrain the current users to make sure that the subordinate
requesting the offload is in fact a macvlan.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 3 +++
 drivers/net/ethernet/intel/i40e/i40e_main.c     | 3 +++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c   | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index 2fb52bd6fc0e..4dba6e6a282d 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -1352,6 +1352,9 @@ static void *fm10k_dfwd_add_station(struct net_device *dev,
 	int size, i;
 	u16 vid, glort;
 
+	if (!netif_is_macvlan(sdev))
+		return ERR_PTR(-EOPNOTSUPP);
+
 	/* The hardware supported by fm10k only filters on the destination MAC
 	 * address. In order to avoid issues we only support offloading modes
 	 * where the hardware can actually provide the functionality.
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index c2d145a56b5e..b90b79f7ee46 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -7663,6 +7663,9 @@ static void *i40e_fwd_add(struct net_device *netdev, struct net_device *vdev)
 	struct i40e_fwd_adapter *fwd;
 	int avail_macvlan, ret;
 
+	if (!netif_is_macvlan(vdev))
+		return ERR_PTR(-EOPNOTSUPP);
+
 	if ((pf->flags & I40E_FLAG_DCB_ENABLED)) {
 		netdev_info(netdev, "Macvlans are not supported when DCB is enabled\n");
 		return ERR_PTR(-EINVAL);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index c5ec17d19c59..ff5334faf6c5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -9940,6 +9940,9 @@ static void *ixgbe_fwd_add(struct net_device *pdev, struct net_device *vdev)
 	int tcs = adapter->hw_tcs ? : 1;
 	int pool, err;
 
+	if (!netif_is_macvlan(vdev))
+		return ERR_PTR(-EOPNOTSUPP);
+
 	if (adapter->xdp_prog) {
 		e_warn(probe, "L2FW offload is not supported with XDP\n");
 		return ERR_PTR(-EINVAL);
-- 
2.25.1

