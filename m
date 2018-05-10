Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
	bh=E34uzuXAeVuC6vcOeGBeVRyrHWs5Hqt8Jn1NtBQhKRQ=;
	b=c8P41hnGedgGrEWBuurt5FVC0NTE03DEPxjsPqk89HDY/XPJZ7vIcpvkSeYTTSHkqZQhjXnWQjJZCitSli+XYhKlsfH8AENHeo521XUKAARBnOtI0LmoIaNWuBlj/NIRIMgE67LeOrKtmUc1KBgTsLrxImjfN32CJNfAa/vT730=
From: Ido Schimmel <idosch@mellanox.com>
Date: Thu, 10 May 2018 13:13:06 +0300
Message-Id: <20180510101306.4891-5-idosch@mellanox.com>
In-Reply-To: <20180510101306.4891-1-idosch@mellanox.com>
References: <20180510101306.4891-1-idosch@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 4/4] mlxsw: spectrum_span: Support VLAN
	under mirror-to-gretap
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

When mirroring to a gretap or ip6gretap device, allow the underlay
packet path to include VLAN devices. The following configurations are
supported in underlay:

- vlan over phys
- vlan-unaware bridge where the egress device is vlan over phys
- vlan over vlan-aware bridge where the egress device is phys

Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum_span.c    | 27 +++++++++++++++-------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
index d90582ee478f..3b77990df599 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
@@ -176,21 +176,23 @@ mlxsw_sp_span_entry_bridge_8021q(const struct net_device *br_dev,
 {
 	struct bridge_vlan_info vinfo;
 	struct net_device *edev;
-	u16 pvid;
+	u16 vid = *p_vid;
 
-	if (WARN_ON(br_vlan_get_pvid(br_dev, &pvid)))
+	if (!vid && WARN_ON(br_vlan_get_pvid(br_dev, &vid)))
 		return NULL;
-	if (!pvid)
+	if (!vid ||
+	    br_vlan_get_info(br_dev, vid, &vinfo) ||
+	    !(vinfo.flags & BRIDGE_VLAN_INFO_BRENTRY))
 		return NULL;
 
-	edev = br_fdb_find_port(br_dev, dmac, pvid);
+	edev = br_fdb_find_port(br_dev, dmac, vid);
 	if (!edev)
 		return NULL;
 
-	if (br_vlan_get_info(edev, pvid, &vinfo))
+	if (br_vlan_get_info(edev, vid, &vinfo))
 		return NULL;
 	if (!(vinfo.flags & BRIDGE_VLAN_INFO_UNTAGGED))
-		*p_vid = pvid;
+		*p_vid = vid;
 	return edev;
 }
 
@@ -208,13 +210,13 @@ mlxsw_sp_span_entry_bridge(const struct net_device *br_dev,
 {
 	struct mlxsw_sp_bridge_port *bridge_port;
 	enum mlxsw_reg_spms_state spms_state;
+	struct net_device *dev = NULL;
 	struct mlxsw_sp_port *port;
-	struct net_device *dev;
 	u8 stp_state;
 
 	if (br_vlan_enabled(br_dev))
 		dev = mlxsw_sp_span_entry_bridge_8021q(br_dev, dmac, p_vid);
-	else
+	else if (!*p_vid)
 		dev = mlxsw_sp_span_entry_bridge_8021d(br_dev, dmac);
 	if (!dev)
 		return NULL;
@@ -261,12 +263,21 @@ mlxsw_sp_span_entry_tunnel_parms_common(struct net_device *l3edev,
 	if (!l3edev || mlxsw_sp_span_dmac(tbl, &gw, l3edev, dmac))
 		goto unoffloadable;
 
+	if (is_vlan_dev(l3edev))
+		l3edev = mlxsw_sp_span_entry_vlan(l3edev, &vid);
+
 	if (netif_is_bridge_master(l3edev)) {
 		l3edev = mlxsw_sp_span_entry_bridge(l3edev, dmac, &vid);
 		if (!l3edev)
 			goto unoffloadable;
 	}
 
+	if (is_vlan_dev(l3edev)) {
+		if (vid || !(l3edev->flags & IFF_UP))
+			goto unoffloadable;
+		l3edev = mlxsw_sp_span_entry_vlan(l3edev, &vid);
+	}
+
 	if (!mlxsw_sp_port_dev_check(l3edev))
 		goto unoffloadable;
 
-- 
2.14.3

