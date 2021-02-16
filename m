Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1613511895; x=1645047895;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=21JiiqEIgm5zFzzo3WjE3M2nVZRsuDLR5EdGNJxiEgU=;
 b=ecXVDJL263nrarzJD9JFlW+XBk575bH7N1lNtps/ymrHseY/XRqcrFZ5
 QtMhZJCgmTz3rKpBeXmaKNfbyPc4gXKlkLWIhZ9y8Kk72TFufG4LfaA9E
 eBx57zaV1gIJNiYFpgUYpFkqPmEhYrARbuB/R3Zcb6bpA8AWjKyYMvEGR
 QbqKCscchmuAmCn952mPyFpqrpX8uQkYOvEaF0/u1VFXorsaQI1r/rcD+
 tvFvCM5cM3ag+5JPqKtLaBlDmurKUStRy5PPAVbUMoLG04iyCrk2EFBB6
 y3lqapRY8v2azOeFq6j+ynF8YtWppEtBQLEPwHwyLMBWdrK44HfbVc2Yf w==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Tue, 16 Feb 2021 22:42:05 +0100
Message-ID: <20210216214205.32385-9-horatiu.vultur@microchip.com>
In-Reply-To: <20210216214205.32385-1-horatiu.vultur@microchip.com>
References: <20210216214205.32385-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v4 8/8] net: dsa: felix: Add support for
	MRP
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org
Cc: ivecera@redhat.com, andrew@lunn.ch, alexandre.belloni@bootlin.com, f.fainelli@gmail.com, jiri@resnulli.us, rasmus.villemoes@prevas.dk, vladimir.oltean@nxp.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, claudiu.manoil@nxp.com, netdev@vger.kernel.org, nikolay@nvidia.com, roopa@nvidia.com, Horatiu Vultur <horatiu.vultur@microchip.com>, vivien.didelot@gmail.com

Implement functions 'port_mrp_add', 'port_mrp_del',
'port_mrp_add_ring_role' and 'port_mrp_del_ring_role' to call the mrp
functions from ocelot.

Also all MRP frames that arrive to CPU on queue number OCELOT_MRP_CPUQ
will be forward by the SW.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/dsa/ocelot/felix.c | 38 ++++++++++++++++++++++++++++++++++
 net/dsa/tag_ocelot.c           |  8 +++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index 800f27d65c6c..fa1c3f14bb88 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -1561,6 +1561,40 @@ static int felix_sb_occ_tc_port_bind_get(struct dsa_switch *ds, int port,
 					      pool_type, p_cur, p_max);
 }
 
+static int felix_mrp_add(struct dsa_switch *ds, int port,
+			 const struct switchdev_obj_mrp *mrp)
+{
+	struct ocelot *ocelot = ds->priv;
+
+	return ocelot_mrp_add(ocelot, port, mrp);
+}
+
+static int felix_mrp_del(struct dsa_switch *ds, int port,
+			 const struct switchdev_obj_mrp *mrp)
+{
+	struct ocelot *ocelot = ds->priv;
+
+	return ocelot_mrp_add(ocelot, port, mrp);
+}
+
+static int
+felix_mrp_add_ring_role(struct dsa_switch *ds, int port,
+			const struct switchdev_obj_ring_role_mrp *mrp)
+{
+	struct ocelot *ocelot = ds->priv;
+
+	return ocelot_mrp_add_ring_role(ocelot, port, mrp);
+}
+
+static int
+felix_mrp_del_ring_role(struct dsa_switch *ds, int port,
+			const struct switchdev_obj_ring_role_mrp *mrp)
+{
+	struct ocelot *ocelot = ds->priv;
+
+	return ocelot_mrp_del_ring_role(ocelot, port, mrp);
+}
+
 const struct dsa_switch_ops felix_switch_ops = {
 	.get_tag_protocol		= felix_get_tag_protocol,
 	.change_tag_protocol		= felix_change_tag_protocol,
@@ -1615,6 +1649,10 @@ const struct dsa_switch_ops felix_switch_ops = {
 	.devlink_sb_occ_max_clear	= felix_sb_occ_max_clear,
 	.devlink_sb_occ_port_pool_get	= felix_sb_occ_port_pool_get,
 	.devlink_sb_occ_tc_port_bind_get= felix_sb_occ_tc_port_bind_get,
+	.port_mrp_add			= felix_mrp_add,
+	.port_mrp_del			= felix_mrp_del,
+	.port_mrp_add_ring_role		= felix_mrp_add_ring_role,
+	.port_mrp_del_ring_role		= felix_mrp_del_ring_role,
 };
 
 struct net_device *felix_port_to_netdev(struct ocelot *ocelot, int port)
diff --git a/net/dsa/tag_ocelot.c b/net/dsa/tag_ocelot.c
index f9df9cac81c5..743809b5806b 100644
--- a/net/dsa/tag_ocelot.c
+++ b/net/dsa/tag_ocelot.c
@@ -83,6 +83,7 @@ static struct sk_buff *ocelot_rcv(struct sk_buff *skb,
 	struct dsa_port *dp;
 	u8 *extraction;
 	u16 vlan_tpid;
+	u64 cpuq;
 
 	/* Revert skb->data by the amount consumed by the DSA master,
 	 * so it points to the beginning of the frame.
@@ -112,6 +113,7 @@ static struct sk_buff *ocelot_rcv(struct sk_buff *skb,
 	ocelot_xfh_get_qos_class(extraction, &qos_class);
 	ocelot_xfh_get_tag_type(extraction, &tag_type);
 	ocelot_xfh_get_vlan_tci(extraction, &vlan_tci);
+	ocelot_xfh_get_cpuq(extraction, &cpuq);
 
 	skb->dev = dsa_master_find_slave(netdev, 0, src_port);
 	if (!skb->dev)
@@ -126,6 +128,12 @@ static struct sk_buff *ocelot_rcv(struct sk_buff *skb,
 	skb->offload_fwd_mark = 1;
 	skb->priority = qos_class;
 
+#if IS_ENABLED(CONFIG_BRIDGE_MRP)
+	if (eth_hdr(skb)->h_proto == cpu_to_be16(ETH_P_MRP) &&
+	    cpuq & BIT(OCELOT_MRP_CPUQ))
+		skb->offload_fwd_mark = 0;
+#endif
+
 	/* Ocelot switches copy frames unmodified to the CPU. However, it is
 	 * possible for the user to request a VLAN modification through
 	 * VCAP_IS1_ACT_VID_REPLACE_ENA. In this case, what will happen is that
-- 
2.27.0

