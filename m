Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
	bh=GIHxF69y7bQaJ68jMtb4NzZaTSsiyBbNxu6KvKwV1+A=;
	b=gPsguvmukOakzAXXLEVI/jnFe09RVuuTEQ+2S1WFyZ/07e2a5XITz7BLa7Du60Fl/BiJ8rlFjeSGtIIIIZBoAaB51jpHBtcUlIbV+el3Rm0sQOmF7dOQPlpa1eJp3PsdlqRaQ2zJA0ueoohq6Jtiq4qR4/6WWh1lk2MXEbqpuWg=
From: Ido Schimmel <idosch@mellanox.com>
Date: Thu, 10 May 2018 13:13:05 +0300
Message-Id: <20180510101306.4891-4-idosch@mellanox.com>
In-Reply-To: <20180510101306.4891-1-idosch@mellanox.com>
References: <20180510101306.4891-1-idosch@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 3/4] mlxsw: spectrum_span: Support
	mirror-to-VLAN
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Ido Schimmel <idosch@mellanox.com>, mlxsw@mellanox.com, nikolay@cumulusnetworks.com, jiri@mellanox.com, petrm@mellanox.com, davem@davemloft.net

From: Petr Machata <petrm@mellanox.com>

Offload "tc action mirred mirror" to a device that is a vlan device on
top of a front-panel port device. The hardware encapsulates the mirrored
packets in a VLAN tag. That includes the case that the mirrored traffic
is already VLAN-tagged--in that case the monitor traffic will be
double-tagged, just like in the software path.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum_span.c    | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
index cd9071ee19ad..d90582ee478f 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
@@ -235,6 +235,14 @@ mlxsw_sp_span_entry_bridge(const struct net_device *br_dev,
 	return dev;
 }
 
+static struct net_device *
+mlxsw_sp_span_entry_vlan(const struct net_device *vlan_dev,
+			 u16 *p_vid)
+{
+	*p_vid = vlan_dev_vlan_id(vlan_dev);
+	return vlan_dev_real_dev(vlan_dev);
+}
+
 static __maybe_unused int
 mlxsw_sp_span_entry_tunnel_parms_common(struct net_device *l3edev,
 					union mlxsw_sp_l3addr saddr,
@@ -477,6 +485,61 @@ struct mlxsw_sp_span_entry_ops mlxsw_sp_span_entry_ops_gretap6 = {
 };
 #endif
 
+static bool
+mlxsw_sp_span_vlan_can_handle(const struct net_device *dev)
+{
+	return is_vlan_dev(dev) &&
+	       mlxsw_sp_port_dev_check(vlan_dev_real_dev(dev));
+}
+
+static int
+mlxsw_sp_span_entry_vlan_parms(const struct net_device *to_dev,
+			       struct mlxsw_sp_span_parms *sparmsp)
+{
+	struct net_device *real_dev;
+	u16 vid;
+
+	if (!(to_dev->flags & IFF_UP))
+		return mlxsw_sp_span_entry_unoffloadable(sparmsp);
+
+	real_dev = mlxsw_sp_span_entry_vlan(to_dev, &vid);
+	sparmsp->dest_port = netdev_priv(real_dev);
+	sparmsp->vid = vid;
+	return 0;
+}
+
+static int
+mlxsw_sp_span_entry_vlan_configure(struct mlxsw_sp_span_entry *span_entry,
+				   struct mlxsw_sp_span_parms sparms)
+{
+	struct mlxsw_sp_port *dest_port = sparms.dest_port;
+	struct mlxsw_sp *mlxsw_sp = dest_port->mlxsw_sp;
+	u8 local_port = dest_port->local_port;
+	char mpat_pl[MLXSW_REG_MPAT_LEN];
+	int pa_id = span_entry->id;
+
+	mlxsw_reg_mpat_pack(mpat_pl, pa_id, local_port, true,
+			    MLXSW_REG_MPAT_SPAN_TYPE_REMOTE_ETH);
+	mlxsw_reg_mpat_eth_rspan_pack(mpat_pl, sparms.vid);
+
+	return mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(mpat), mpat_pl);
+}
+
+static void
+mlxsw_sp_span_entry_vlan_deconfigure(struct mlxsw_sp_span_entry *span_entry)
+{
+	mlxsw_sp_span_entry_deconfigure_common(span_entry,
+					MLXSW_REG_MPAT_SPAN_TYPE_REMOTE_ETH);
+}
+
+static const
+struct mlxsw_sp_span_entry_ops mlxsw_sp_span_entry_ops_vlan = {
+	.can_handle = mlxsw_sp_span_vlan_can_handle,
+	.parms = mlxsw_sp_span_entry_vlan_parms,
+	.configure = mlxsw_sp_span_entry_vlan_configure,
+	.deconfigure = mlxsw_sp_span_entry_vlan_deconfigure,
+};
+
 static const
 struct mlxsw_sp_span_entry_ops *const mlxsw_sp_span_entry_types[] = {
 	&mlxsw_sp_span_entry_ops_phys,
@@ -486,6 +549,7 @@ struct mlxsw_sp_span_entry_ops *const mlxsw_sp_span_entry_types[] = {
 #if IS_ENABLED(CONFIG_IPV6_GRE)
 	&mlxsw_sp_span_entry_ops_gretap6,
 #endif
+	&mlxsw_sp_span_entry_ops_vlan,
 };
 
 static int
-- 
2.14.3

