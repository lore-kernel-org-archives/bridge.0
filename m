Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8ARGCbzXYmxoVhI/W45fy7wsub+EkJDR8//ZmjXIV0=;
 b=UdldaYw4PcFuEjx+U3FA+s70+P9JWLeP7uPnZYH/3YA8Kfxiq4vdgSWVbDvpIApj+WYejlfqc1G9kEOj9NU6RrFUL8wuFl+0xtn1TOUQyo+05vOYnbA4vWUM5bQhTTwbn6QsYxsDY74SZ6I0WWz6IhPwmFl6e77CfcxD04IY+bk=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Sat,  3 Jul 2021 14:56:56 +0300
Message-Id: <20210703115705.1034112-2-vladimir.oltean@nxp.com>
In-Reply-To: <20210703115705.1034112-1-vladimir.oltean@nxp.com>
References: <20210703115705.1034112-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH v2 net-next 01/10] net: dfwd: constrain
	existing users to macvlan subordinates
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, bridge@lists.linux-foundation.org, Alexander Duyck <alexander.duyck@gmail.com>, Ido Schimmel <idosch@idosch.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>

From: Tobias Waldekranz <tobias@waldekranz.com>

The dfwd_add/del_station NDOs are currently only used by the macvlan
subsystem to request L2 forwarding offload from lower devices. In
order add support for other types of devices (like bridges), we
constrain the current users to make sure that the subordinate
requesting the offload is in fact a macvlan.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
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
index 861e59a350bd..812ad241a049 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -7629,6 +7629,9 @@ static void *i40e_fwd_add(struct net_device *netdev, struct net_device *vdev)
 	struct i40e_fwd_adapter *fwd;
 	int avail_macvlan, ret;
 
+	if (!netif_is_macvlan(vdev))
+		return ERR_PTR(-EOPNOTSUPP);
+
 	if ((pf->flags & I40E_FLAG_DCB_ENABLED)) {
 		netdev_info(netdev, "Macvlans are not supported when DCB is enabled\n");
 		return ERR_PTR(-EINVAL);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index ffff69efd78a..1ecdb7dc9534 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -9938,6 +9938,9 @@ static void *ixgbe_fwd_add(struct net_device *pdev, struct net_device *vdev)
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

