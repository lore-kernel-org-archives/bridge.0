Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
	bh=xqfjX5VF+o+xM4Nzvs2cbnBua6L9AGPXOsLF87+43a8=;
	b=petW6jyBatFLQC1Fredn/Yr6qb2bzOt8x7GBZS8Lt+OQTpdSBQeM1fBmRXqNJ+nDW5oCI2BeS/oOvdpdn2H1u7vIsXA/1Rv4MqNnu9c4RfG7ODK3qgMAmre8jDZnyvqEpLZP3New5M2XwBAYZI6zGWcEeMB7f6/2fgjUx6ztF4E=
From: Ido Schimmel <idosch@mellanox.com>
Date: Sun, 29 Apr 2018 10:56:13 +0300
Message-Id: <20180429075613.10832-7-idosch@mellanox.com>
In-Reply-To: <20180429075613.10832-1-idosch@mellanox.com>
References: <20180429075613.10832-1-idosch@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v3 6/6] mlxsw: spectrum_span: Allow bridge
	for gretap mirror
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

When handling mirroring to a gretap or ip6gretap netdevice in mlxsw, the
underlay address (i.e. the remote address of the tunnel) may be routed
to a bridge.

In that case, look up the resolved neighbor Ethernet address in that
bridge's FDB. Then configure the offload to direct the mirrored traffic
to that port, possibly with tagging.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum_span.c    | 95 ++++++++++++++++++++--
 .../net/ethernet/mellanox/mlxsw/spectrum_span.h    |  1 +
 2 files changed, 90 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
index 65a77708ff61..cd9071ee19ad 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
@@ -32,6 +32,7 @@
  * POSSIBILITY OF SUCH DAMAGE.
  */
 
+#include <linux/if_bridge.h>
 #include <linux/list.h>
 #include <net/arp.h>
 #include <net/gre.h>
@@ -39,8 +40,9 @@
 #include <net/ip6_tunnel.h>
 
 #include "spectrum.h"
-#include "spectrum_span.h"
 #include "spectrum_ipip.h"
+#include "spectrum_span.h"
+#include "spectrum_switchdev.h"
 
 int mlxsw_sp_span_init(struct mlxsw_sp *mlxsw_sp)
 {
@@ -167,6 +169,72 @@ mlxsw_sp_span_entry_unoffloadable(struct mlxsw_sp_span_parms *sparmsp)
 	return 0;
 }
 
+static struct net_device *
+mlxsw_sp_span_entry_bridge_8021q(const struct net_device *br_dev,
+				 unsigned char *dmac,
+				 u16 *p_vid)
+{
+	struct bridge_vlan_info vinfo;
+	struct net_device *edev;
+	u16 pvid;
+
+	if (WARN_ON(br_vlan_get_pvid(br_dev, &pvid)))
+		return NULL;
+	if (!pvid)
+		return NULL;
+
+	edev = br_fdb_find_port(br_dev, dmac, pvid);
+	if (!edev)
+		return NULL;
+
+	if (br_vlan_get_info(edev, pvid, &vinfo))
+		return NULL;
+	if (!(vinfo.flags & BRIDGE_VLAN_INFO_UNTAGGED))
+		*p_vid = pvid;
+	return edev;
+}
+
+static struct net_device *
+mlxsw_sp_span_entry_bridge_8021d(const struct net_device *br_dev,
+				 unsigned char *dmac)
+{
+	return br_fdb_find_port(br_dev, dmac, 0);
+}
+
+static struct net_device *
+mlxsw_sp_span_entry_bridge(const struct net_device *br_dev,
+			   unsigned char dmac[ETH_ALEN],
+			   u16 *p_vid)
+{
+	struct mlxsw_sp_bridge_port *bridge_port;
+	enum mlxsw_reg_spms_state spms_state;
+	struct mlxsw_sp_port *port;
+	struct net_device *dev;
+	u8 stp_state;
+
+	if (br_vlan_enabled(br_dev))
+		dev = mlxsw_sp_span_entry_bridge_8021q(br_dev, dmac, p_vid);
+	else
+		dev = mlxsw_sp_span_entry_bridge_8021d(br_dev, dmac);
+	if (!dev)
+		return NULL;
+
+	port = mlxsw_sp_port_dev_lower_find(dev);
+	if (!port)
+		return NULL;
+
+	bridge_port = mlxsw_sp_bridge_port_find(port->mlxsw_sp->bridge, dev);
+	if (!bridge_port)
+		return NULL;
+
+	stp_state = mlxsw_sp_bridge_port_stp_state(bridge_port);
+	spms_state = mlxsw_sp_stp_spms_state(stp_state);
+	if (spms_state != MLXSW_REG_SPMS_STATE_FORWARDING)
+		return NULL;
+
+	return dev;
+}
+
 static __maybe_unused int
 mlxsw_sp_span_entry_tunnel_parms_common(struct net_device *l3edev,
 					union mlxsw_sp_l3addr saddr,
@@ -177,13 +245,22 @@ mlxsw_sp_span_entry_tunnel_parms_common(struct net_device *l3edev,
 					struct mlxsw_sp_span_parms *sparmsp)
 {
 	unsigned char dmac[ETH_ALEN];
+	u16 vid = 0;
 
 	if (mlxsw_sp_l3addr_is_zero(gw))
 		gw = daddr;
 
-	if (!l3edev || !mlxsw_sp_port_dev_check(l3edev) ||
-	    mlxsw_sp_span_dmac(tbl, &gw, l3edev, dmac))
-		return mlxsw_sp_span_entry_unoffloadable(sparmsp);
+	if (!l3edev || mlxsw_sp_span_dmac(tbl, &gw, l3edev, dmac))
+		goto unoffloadable;
+
+	if (netif_is_bridge_master(l3edev)) {
+		l3edev = mlxsw_sp_span_entry_bridge(l3edev, dmac, &vid);
+		if (!l3edev)
+			goto unoffloadable;
+	}
+
+	if (!mlxsw_sp_port_dev_check(l3edev))
+		goto unoffloadable;
 
 	sparmsp->dest_port = netdev_priv(l3edev);
 	sparmsp->ttl = ttl;
@@ -191,7 +268,11 @@ mlxsw_sp_span_entry_tunnel_parms_common(struct net_device *l3edev,
 	memcpy(sparmsp->smac, l3edev->dev_addr, ETH_ALEN);
 	sparmsp->saddr = saddr;
 	sparmsp->daddr = daddr;
+	sparmsp->vid = vid;
 	return 0;
+
+unoffloadable:
+	return mlxsw_sp_span_entry_unoffloadable(sparmsp);
 }
 
 #if IS_ENABLED(CONFIG_NET_IPGRE)
@@ -268,9 +349,10 @@ mlxsw_sp_span_entry_gretap4_configure(struct mlxsw_sp_span_entry *span_entry,
 	/* Create a new port analayzer entry for local_port. */
 	mlxsw_reg_mpat_pack(mpat_pl, pa_id, local_port, true,
 			    MLXSW_REG_MPAT_SPAN_TYPE_REMOTE_ETH_L3);
+	mlxsw_reg_mpat_eth_rspan_pack(mpat_pl, sparms.vid);
 	mlxsw_reg_mpat_eth_rspan_l2_pack(mpat_pl,
 				    MLXSW_REG_MPAT_ETH_RSPAN_VERSION_NO_HEADER,
-				    sparms.dmac, false);
+				    sparms.dmac, !!sparms.vid);
 	mlxsw_reg_mpat_eth_rspan_l3_ipv4_pack(mpat_pl,
 					      sparms.ttl, sparms.smac,
 					      be32_to_cpu(sparms.saddr.addr4),
@@ -368,9 +450,10 @@ mlxsw_sp_span_entry_gretap6_configure(struct mlxsw_sp_span_entry *span_entry,
 	/* Create a new port analayzer entry for local_port. */
 	mlxsw_reg_mpat_pack(mpat_pl, pa_id, local_port, true,
 			    MLXSW_REG_MPAT_SPAN_TYPE_REMOTE_ETH_L3);
+	mlxsw_reg_mpat_eth_rspan_pack(mpat_pl, sparms.vid);
 	mlxsw_reg_mpat_eth_rspan_l2_pack(mpat_pl,
 				    MLXSW_REG_MPAT_ETH_RSPAN_VERSION_NO_HEADER,
-				    sparms.dmac, false);
+				    sparms.dmac, !!sparms.vid);
 	mlxsw_reg_mpat_eth_rspan_l3_ipv6_pack(mpat_pl, sparms.ttl, sparms.smac,
 					      sparms.saddr.addr6,
 					      sparms.daddr.addr6);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.h
index 4b87ec20e658..14a6de904db1 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.h
@@ -63,6 +63,7 @@ struct mlxsw_sp_span_parms {
 	unsigned char smac[ETH_ALEN];
 	union mlxsw_sp_l3addr daddr;
 	union mlxsw_sp_l3addr saddr;
+	u16 vid;
 };
 
 struct mlxsw_sp_span_entry_ops;
-- 
2.14.3

