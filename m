Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D668B81AF3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C3FBD81B01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ya4tW0j0iTCUe/pMNIiYlbMX2deTzFP2fjC285Q6y6A=;
 b=W2+vx2lqQ9e/3TW3R3jdSdCIDXxqiHuvyJVX31mySw+RrBJPWkXSP2DMPofvNps7HCYECVNE9JziWo8vaWHHvID7NQz3nuP8TFpbswNHN9TSf95DZ3tcQ/+cjKyj6QEESqno1lRbvhvibqQGnwAnyaLHlF0wgBkPd2L2ZRcuWRaes8aErS8pBpc0bUZiOx7n0lWiaP2ZVv2GvvguNVHtUcYDKo59BRMRE1UjkwucfeIoxk5u/+EcDaC2SaAqAKRQya2Btynyk0H1t2yi9kdnc+Hj/YmPgMuqOF/npvxpWV2fStPewsj+nKu2UdagUdn+ujfEx1yzzsGIBRJlZPY8Tw==
From: Petr Machata <petrm@nvidia.com>
Date: Tue, 8 Nov 2022 11:47:17 +0100
Message-ID: <f433543efdb610ef5a6aba9ac52b4783ff137a13.1667902754.git.petrm@nvidia.com>
In-Reply-To: <cover.1667902754.git.petrm@nvidia.com>
References: <cover.1667902754.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 11/15] mlxsw: spectrum_switchdev: Add
	locked bridge port support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Roopa Prabhu <roopa@nvidia.com>, mlxsw@nvidia.com, Jiri Pirko <jiri@nvidia.com>, "Hans J . Schultz" <netdev@kapio-technology.com>

From: Ido Schimmel <idosch@nvidia.com>

Add locked bridge port support by reacting to changes in the
'BR_PORT_LOCKED' flag. When set, enable security checks on the local
port via the previously added SPFSR register.

When security checks are enabled, an incoming packet will trigger an FDB
lookup with the packet's source MAC and the FID it was classified to. If
an FDB entry was not found or was found to be pointing to a different
port, the packet will be dropped. Such packets increment the
"discard_ingress_general" ethtool counter. For added visibility, user
space can trap such packets to the CPU by enabling the "locked_port"
trap. Example:

 # devlink trap set pci/0000:06:00.0 trap locked_port action trap

Unlike other configurations done via bridge port flags (e.g., learning,
flooding), security checks are enabled in the device on a per-port basis
and not on a per-{port, VLAN} basis. As such, scenarios where user space
can configure different locking settings for different VLANs configured
on a port need to be vetoed. To that end, veto the following scenarios:

1. Locking is set on a bridge port that is a VLAN upper

2. Locking is set on a bridge port that has VLAN uppers

3. VLAN upper is configured on a locked bridge port

Examples:

 # bridge link set dev swp1.10 locked on
 Error: mlxsw_spectrum: Locked flag cannot be set on a VLAN upper.

 # ip link add link swp1 name swp1.10 type vlan id 10
 # bridge link set dev swp1 locked on
 Error: mlxsw_spectrum: Locked flag cannot be set on a bridge port that has VLAN uppers.

 # bridge link set dev swp1 locked on
 # ip link add link swp1 name swp1.10 type vlan id 10
 Error: mlxsw_spectrum: VLAN uppers are not supported on a locked port.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
    v1:
    * Add 'BR_PORT_MAB' in mlxsw_sp_port_attr_br_pre_flags_set().

 .../net/ethernet/mellanox/mlxsw/spectrum.c    |  4 ++++
 .../mellanox/mlxsw/spectrum_switchdev.c       | 23 ++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index b34366521914..f5b2d965d476 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -4760,6 +4760,10 @@ static int mlxsw_sp_netdevice_port_upper_event(struct net_device *lower_dev,
 			NL_SET_ERR_MSG_MOD(extack, "VLAN uppers are only supported with 802.1q VLAN protocol");
 			return -EOPNOTSUPP;
 		}
+		if (is_vlan_dev(upper_dev) && mlxsw_sp_port->security) {
+			NL_SET_ERR_MSG_MOD(extack, "VLAN uppers are not supported on a locked port");
+			return -EOPNOTSUPP;
+		}
 		break;
 	case NETDEV_CHANGEUPPER:
 		upper_dev = info->upper_dev;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index db149af7c888..accea95cae5d 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -782,14 +782,26 @@ mlxsw_sp_bridge_port_learning_set(struct mlxsw_sp_port *mlxsw_sp_port,
 
 static int
 mlxsw_sp_port_attr_br_pre_flags_set(struct mlxsw_sp_port *mlxsw_sp_port,
+				    const struct net_device *orig_dev,
 				    struct switchdev_brport_flags flags,
 				    struct netlink_ext_ack *extack)
 {
-	if (flags.mask & ~(BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD)) {
+	if (flags.mask & ~(BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD |
+			   BR_PORT_LOCKED | BR_PORT_MAB)) {
 		NL_SET_ERR_MSG_MOD(extack, "Unsupported bridge port flag");
 		return -EINVAL;
 	}
 
+	if ((flags.mask & BR_PORT_LOCKED) && is_vlan_dev(orig_dev)) {
+		NL_SET_ERR_MSG_MOD(extack, "Locked flag cannot be set on a VLAN upper");
+		return -EINVAL;
+	}
+
+	if ((flags.mask & BR_PORT_LOCKED) && vlan_uses_dev(orig_dev)) {
+		NL_SET_ERR_MSG_MOD(extack, "Locked flag cannot be set on a bridge port that has VLAN uppers");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -822,6 +834,13 @@ static int mlxsw_sp_port_attr_br_flags_set(struct mlxsw_sp_port *mlxsw_sp_port,
 			return err;
 	}
 
+	if (flags.mask & BR_PORT_LOCKED) {
+		err = mlxsw_sp_port_security_set(mlxsw_sp_port,
+						 flags.val & BR_PORT_LOCKED);
+		if (err)
+			return err;
+	}
+
 	if (bridge_port->bridge_device->multicast_enabled)
 		goto out;
 
@@ -1189,6 +1208,7 @@ static int mlxsw_sp_port_attr_set(struct net_device *dev, const void *ctx,
 		break;
 	case SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS:
 		err = mlxsw_sp_port_attr_br_pre_flags_set(mlxsw_sp_port,
+							  attr->orig_dev,
 							  attr->u.brport_flags,
 							  extack);
 		break;
@@ -2787,6 +2807,7 @@ void mlxsw_sp_port_bridge_leave(struct mlxsw_sp_port *mlxsw_sp_port,
 
 	bridge_device->ops->port_leave(bridge_device, bridge_port,
 				       mlxsw_sp_port);
+	mlxsw_sp_port_security_set(mlxsw_sp_port, false);
 	mlxsw_sp_bridge_port_put(mlxsw_sp->bridge, bridge_port);
 }
 
-- 
2.35.3

