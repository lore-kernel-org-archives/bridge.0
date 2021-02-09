Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1612902277; x=1644438277;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QtwOaRIv2PtLKpYjgqSxl18uh6l2sLduk/xVC1keVzM=;
 b=x3YXQvmxXgK2wElBbL72uLLzS+HWU1/+/JPYXyOhqd/2CL57eg/T8dCT
 uCxcYPZm9KZ1+dRxQyvuKWsAXk4JLVVdXu/2i4Gd2YdmpRruMH69HINg4
 W51+WtHFZBU6uSuNe+0lB4dOgiUUMknWlhr8klZE+MyZggSS72a5sg8j/
 KK41rtLD8V1PfqL8g4WXB090aiTiFTEKk5WzINWu8e97ZjXsvc+FWhFWW
 6Uf5kSBfdKDDm2EAko5JnAuyjU/90gq1+YzcP3T/ZVO4k30eQGKVSIWUU
 Y1SWjX4BPlgnsYiioMjQYl4aOct8OvpTh+IUNFXjm7VUvBMKandlfuCTh w==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Tue, 9 Feb 2021 21:21:12 +0100
Message-ID: <20210209202112.2545325-6-horatiu.vultur@microchip.com>
In-Reply-To: <20210209202112.2545325-1-horatiu.vultur@microchip.com>
References: <20210209202112.2545325-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v3 5/5] net: mscc: ocelot: Add support for
	MRP
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: jiri@resnulli.us, ivecera@redhat.com, davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com, nikolay@nvidia.com, rasmus.villemoes@prevas.dk, andrew@lunn.ch, vladimir.oltean@nxp.com, claudiu.manoil@nxp.com, alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

Add basic support for MRP. The HW will just trap all MRP frames on the
ring ports to CPU and allow the SW to process them. In this way it is
possible to for this node to behave both as MRM and MRC.

Current limitations are:
- it doesn't support Interconnect roles.
- it supports only a single ring.
- the HW should be able to do forwarding of MRP Test frames so the SW
  will not need to do this. So it would be able to have the role MRC
  without SW support.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/ethernet/mscc/ocelot_net.c     | 154 +++++++++++++++++++++
 drivers/net/ethernet/mscc/ocelot_vsc7514.c |   6 +
 include/soc/mscc/ocelot.h                  |   6 +
 3 files changed, 166 insertions(+)

diff --git a/drivers/net/ethernet/mscc/ocelot_net.c b/drivers/net/ethernet/mscc/ocelot_net.c
index 8f12fa45b1b5..65971403e823 100644
--- a/drivers/net/ethernet/mscc/ocelot_net.c
+++ b/drivers/net/ethernet/mscc/ocelot_net.c
@@ -9,7 +9,10 @@
  */
 
 #include <linux/if_bridge.h>
+#include <linux/mrp_bridge.h>
 #include <net/pkt_cls.h>
+#include <soc/mscc/ocelot_vcap.h>
+#include <uapi/linux/mrp_bridge.h>
 #include "ocelot.h"
 #include "ocelot_vcap.h"
 
@@ -1069,6 +1072,139 @@ static int ocelot_port_obj_del_mdb(struct net_device *dev,
 	return ocelot_port_mdb_del(ocelot, port, mdb);
 }
 
+#if IS_ENABLED(CONFIG_BRIDGE_MRP)
+static int ocelot_mrp_del_vcap(struct ocelot *ocelot, int port)
+{
+	struct ocelot_vcap_block *block_vcap_is2;
+	struct ocelot_vcap_filter *filter;
+
+	block_vcap_is2 = &ocelot->block[VCAP_IS2];
+	filter = ocelot_vcap_block_find_filter_by_id(block_vcap_is2, port,
+						     false);
+	if (!filter)
+		return 0;
+
+	return ocelot_vcap_filter_del(ocelot, filter);
+}
+
+static int ocelot_add_mrp(struct net_device *dev,
+			  const struct switchdev_obj_mrp *mrp)
+{
+	struct ocelot_port_private *priv = netdev_priv(dev);
+	struct ocelot_port *ocelot_port = &priv->port;
+	struct ocelot *ocelot = ocelot_port->ocelot;
+
+	if (mrp->p_port != dev && mrp->s_port != dev)
+		return 0;
+
+	if (ocelot->mrp_ring_id != 0 &&
+	    ocelot->mrp_s_port &&
+	    ocelot->mrp_p_port)
+		return -EINVAL;
+
+	if (mrp->p_port == dev)
+		ocelot->mrp_p_port = dev;
+
+	if (mrp->s_port == dev)
+		ocelot->mrp_s_port = dev;
+
+	ocelot->mrp_ring_id = mrp->ring_id;
+
+	return 0;
+}
+
+static int ocelot_del_mrp(struct net_device *dev,
+			  const struct switchdev_obj_mrp *mrp)
+{
+	struct ocelot_port_private *priv = netdev_priv(dev);
+	struct ocelot_port *ocelot_port = &priv->port;
+	struct ocelot *ocelot = ocelot_port->ocelot;
+
+	if (ocelot->mrp_p_port != dev && ocelot->mrp_s_port != dev)
+		return 0;
+
+	if (ocelot->mrp_ring_id == 0 &&
+	    !ocelot->mrp_s_port &&
+	    !ocelot->mrp_p_port)
+		return -EINVAL;
+
+	if (ocelot_mrp_del_vcap(ocelot, priv->chip_port))
+		return -EINVAL;
+
+	if (ocelot->mrp_p_port == dev)
+		ocelot->mrp_p_port = NULL;
+
+	if (ocelot->mrp_s_port == dev)
+		ocelot->mrp_s_port = NULL;
+
+	ocelot->mrp_ring_id = 0;
+
+	return 0;
+}
+
+static int ocelot_add_ring_role(struct net_device *dev,
+				const struct switchdev_obj_ring_role_mrp *mrp)
+{
+	struct ocelot_port_private *priv = netdev_priv(dev);
+	struct ocelot_port *ocelot_port = &priv->port;
+	struct ocelot *ocelot = ocelot_port->ocelot;
+	struct ocelot_vcap_filter *filter;
+	int err;
+
+	if (ocelot->mrp_ring_id != mrp->ring_id)
+		return -EINVAL;
+
+	if (!mrp->sw_backup)
+		return -EOPNOTSUPP;
+
+	if (ocelot->mrp_p_port != dev && ocelot->mrp_s_port != dev)
+		return 0;
+
+	filter = kzalloc(sizeof(*filter), GFP_KERNEL);
+	if (!filter)
+		return -ENOMEM;
+
+	filter->key_type = OCELOT_VCAP_KEY_ETYPE;
+	filter->prio = 1;
+	filter->id.cookie = priv->chip_port;
+	filter->id.tc_offload = false;
+	filter->block_id = VCAP_IS2;
+	filter->type = OCELOT_VCAP_FILTER_OFFLOAD;
+	filter->ingress_port_mask = BIT(priv->chip_port);
+	*(__be16 *)filter->key.etype.etype.value = htons(ETH_P_MRP);
+	*(__be16 *)filter->key.etype.etype.mask = htons(0xffff);
+	filter->action.mask_mode = OCELOT_MASK_MODE_PERMIT_DENY;
+	filter->action.port_mask = 0x0;
+	filter->action.cpu_copy_ena = true;
+	filter->action.cpu_qu_num = 0;
+
+	err = ocelot_vcap_filter_add(ocelot, filter, NULL);
+	if (err)
+		kfree(filter);
+
+	return err;
+}
+
+static int ocelot_del_ring_role(struct net_device *dev,
+				const struct switchdev_obj_ring_role_mrp *mrp)
+{
+	struct ocelot_port_private *priv = netdev_priv(dev);
+	struct ocelot_port *ocelot_port = &priv->port;
+	struct ocelot *ocelot = ocelot_port->ocelot;
+
+	if (ocelot->mrp_ring_id != mrp->ring_id)
+		return -EINVAL;
+
+	if (!mrp->sw_backup)
+		return -EOPNOTSUPP;
+
+	if (ocelot->mrp_p_port != dev && ocelot->mrp_s_port != dev)
+		return 0;
+
+	return ocelot_mrp_del_vcap(ocelot, priv->chip_port);
+}
+#endif
+
 static int ocelot_port_obj_add(struct net_device *dev,
 			       const struct switchdev_obj *obj,
 			       struct netlink_ext_ack *extack)
@@ -1083,6 +1219,15 @@ static int ocelot_port_obj_add(struct net_device *dev,
 	case SWITCHDEV_OBJ_ID_PORT_MDB:
 		ret = ocelot_port_obj_add_mdb(dev, SWITCHDEV_OBJ_PORT_MDB(obj));
 		break;
+#if IS_ENABLED(CONFIG_BRIDGE_MRP)
+	case SWITCHDEV_OBJ_ID_MRP:
+		ret = ocelot_add_mrp(dev, SWITCHDEV_OBJ_MRP(obj));
+		break;
+	case SWITCHDEV_OBJ_ID_RING_ROLE_MRP:
+		ret = ocelot_add_ring_role(dev,
+					   SWITCHDEV_OBJ_RING_ROLE_MRP(obj));
+		break;
+#endif
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -1103,6 +1248,15 @@ static int ocelot_port_obj_del(struct net_device *dev,
 	case SWITCHDEV_OBJ_ID_PORT_MDB:
 		ret = ocelot_port_obj_del_mdb(dev, SWITCHDEV_OBJ_PORT_MDB(obj));
 		break;
+#if IS_ENABLED(CONFIG_BRIDGE_MRP)
+	case SWITCHDEV_OBJ_ID_MRP:
+		ret = ocelot_del_mrp(dev, SWITCHDEV_OBJ_MRP(obj));
+		break;
+	case SWITCHDEV_OBJ_ID_RING_ROLE_MRP:
+		ret = ocelot_del_ring_role(dev,
+					   SWITCHDEV_OBJ_RING_ROLE_MRP(obj));
+		break;
+#endif
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/mscc/ocelot_vsc7514.c b/drivers/net/ethernet/mscc/ocelot_vsc7514.c
index 6b6eb92149ba..96a9c9f98060 100644
--- a/drivers/net/ethernet/mscc/ocelot_vsc7514.c
+++ b/drivers/net/ethernet/mscc/ocelot_vsc7514.c
@@ -698,6 +698,12 @@ static irqreturn_t ocelot_xtr_irq_handler(int irq, void *arg)
 			skb->offload_fwd_mark = 1;
 
 		skb->protocol = eth_type_trans(skb, dev);
+#if IS_ENABLED(CONFIG_BRIDGE_MRP)
+		if (skb->protocol == ntohs(ETH_P_MRP) &&
+		    (priv->dev == ocelot->mrp_p_port ||
+		     priv->dev == ocelot->mrp_s_port))
+			skb->offload_fwd_mark = 0;
+#endif
 		if (!skb_defer_rx_timestamp(skb))
 			netif_rx(skb);
 		dev->stats.rx_bytes += len;
diff --git a/include/soc/mscc/ocelot.h b/include/soc/mscc/ocelot.h
index d0d48e9620fb..d95c019ad84e 100644
--- a/include/soc/mscc/ocelot.h
+++ b/include/soc/mscc/ocelot.h
@@ -682,6 +682,12 @@ struct ocelot {
 	/* Protects the PTP clock */
 	spinlock_t			ptp_clock_lock;
 	struct ptp_pin_desc		ptp_pins[OCELOT_PTP_PINS_NUM];
+
+#if IS_ENABLED(CONFIG_BRIDGE_MRP)
+	u16				mrp_ring_id;
+	struct net_device		*mrp_p_port;
+	struct net_device		*mrp_s_port;
+#endif
 };
 
 struct ocelot_policer {
-- 
2.27.0

