Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=sSjjoOHJidT9/pIgLFsq3W+LBsl+cz9iS4/agq0LRNc=; b=dCE5BE0K
 JTFEB+bRKm0TMx+68B7cLds0eFst7oR9KhXl+39XxK03m7vd9f1nOjYe/L7UqPHQ
 tNY4C9juXW8p+Z5OfnM6ear4Li4lFbnXm1RQ8DAhi5xEQ2VR4aGMbzC5OUY540Ha
 KDXn4pYTcu23FkpKhFHkf9KzsKAZrPqBCS3SQDbec86LPxk5i0w8W46DMdYfjYKy
 wEhrKxaH2kYKg0C3vczVzVi/daIbxktOrQhlFLKD62OAzvSxR/N1uSq6uZUpBZRp
 lEHZg3qLM106HdA7qzp+YD7bAM27fX4o5FjjxKLF34/FenT5ppsaUyJIhrlfWmLW
 H4j58Q7jriiYxA==
From: Ido Schimmel <idosch@idosch.org>
Date: Sun, 29 Nov 2020 14:54:03 +0200
Message-Id: <20201129125407.1391557-6-idosch@idosch.org>
In-Reply-To: <20201129125407.1391557-1-idosch@idosch.org>
References: <20201129125407.1391557-1-idosch@idosch.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 5/9] mlxsw: spectrum_switchdev: Create
	common functions for VLAN-aware bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: ivecera@redhat.com, petrm@nvidia.com, amcohen@nvidia.com, danieller@nvidia.com, mlxsw@nvidia.com, Ido Schimmel <idosch@nvidia.com>, jiri@nvidia.com, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

From: Amit Cohen <amcohen@nvidia.com>

The code in mlxsw_sp_bridge_8021q_port_{join, leave}() can be used also
for 802.1ad bridge.

Move the code to functions called
mlxsw_sp_bridge_vlan_aware_port_{join, leave}() and call them from
mlxsw_sp_bridge_8021q_port_{join, leave}() respectively to enable code
reuse.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 .../mellanox/mlxsw/spectrum_switchdev.c       | 29 ++++++++++++++-----
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index a4aa2f620066..dfb97a847efc 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -1979,10 +1979,9 @@ static struct mlxsw_sp_port *mlxsw_sp_lag_rep_port(struct mlxsw_sp *mlxsw_sp,
 }
 
 static int
-mlxsw_sp_bridge_8021q_port_join(struct mlxsw_sp_bridge_device *bridge_device,
-				struct mlxsw_sp_bridge_port *bridge_port,
-				struct mlxsw_sp_port *mlxsw_sp_port,
-				struct netlink_ext_ack *extack)
+mlxsw_sp_bridge_vlan_aware_port_join(struct mlxsw_sp_bridge_port *bridge_port,
+				     struct mlxsw_sp_port *mlxsw_sp_port,
+				     struct netlink_ext_ack *extack)
 {
 	if (is_vlan_dev(bridge_port->dev)) {
 		NL_SET_ERR_MSG_MOD(extack, "Can not enslave a VLAN device to a VLAN-aware bridge");
@@ -1996,16 +1995,32 @@ mlxsw_sp_bridge_8021q_port_join(struct mlxsw_sp_bridge_device *bridge_device,
 	return 0;
 }
 
+static int
+mlxsw_sp_bridge_8021q_port_join(struct mlxsw_sp_bridge_device *bridge_device,
+				struct mlxsw_sp_bridge_port *bridge_port,
+				struct mlxsw_sp_port *mlxsw_sp_port,
+				struct netlink_ext_ack *extack)
+{
+	return mlxsw_sp_bridge_vlan_aware_port_join(bridge_port, mlxsw_sp_port,
+						    extack);
+}
+
 static void
-mlxsw_sp_bridge_8021q_port_leave(struct mlxsw_sp_bridge_device *bridge_device,
-				 struct mlxsw_sp_bridge_port *bridge_port,
-				 struct mlxsw_sp_port *mlxsw_sp_port)
+mlxsw_sp_bridge_vlan_aware_port_leave(struct mlxsw_sp_port *mlxsw_sp_port)
 {
 	/* Make sure untagged frames are allowed to ingress */
 	mlxsw_sp_port_pvid_set(mlxsw_sp_port, MLXSW_SP_DEFAULT_VID,
 			       ETH_P_8021Q);
 }
 
+static void
+mlxsw_sp_bridge_8021q_port_leave(struct mlxsw_sp_bridge_device *bridge_device,
+				 struct mlxsw_sp_bridge_port *bridge_port,
+				 struct mlxsw_sp_port *mlxsw_sp_port)
+{
+	mlxsw_sp_bridge_vlan_aware_port_leave(mlxsw_sp_port);
+}
+
 static int
 mlxsw_sp_bridge_8021q_vxlan_join(struct mlxsw_sp_bridge_device *bridge_device,
 				 const struct net_device *vxlan_dev, u16 vid,
-- 
2.28.0

