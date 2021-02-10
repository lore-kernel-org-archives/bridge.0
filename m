Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQqkwuGhjNFmZNNnJKe3Hlp7DMCDgZNrDutJq2Gi424=;
 b=UG4QyeqINyGvXpUwzhuQTDeMKsVy+VCPWugyat1TRq/COotvpxYmpx5EjkFOhobfl9LN76T/BIlcHxk3MWkrME1IIaBj40haZkwyAxJcMYRTzBFO6OMdFea9JqaSt4jHQtRJjIDj3kAUDKGx/ZiIATczEHe/Xizknkmmw5PWhVQ=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Wed, 10 Feb 2021 10:18:03 +0000
Message-ID: <20210210101802.6ztf6c3ifldfa5fw@skbuf>
References: <20210209202112.2545325-1-horatiu.vultur@microchip.com>
 <20210209202112.2545325-6-horatiu.vultur@microchip.com>
In-Reply-To: <20210209202112.2545325-6-horatiu.vultur@microchip.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9683A36585C0A94F9DB267C3DCA6B783@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v3 5/5] net: mscc: ocelot: Add support
	for MRP
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: "ivecera@redhat.com" <ivecera@redhat.com>, "andrew@lunn.ch" <andrew@lunn.ch>, "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "jiri@resnulli.us" <jiri@resnulli.us>, "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "nikolay@nvidia.com" <nikolay@nvidia.com>, "roopa@nvidia.com" <roopa@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>

Would you mind adding the switchdev MRP support for the DSA driver too,
and move the code to the common ocelot library? I would like to give it
a run. I think that's only fair, since I have to keep in sync the
vsc7514 driver too for features that get added through DSA :)

On Tue, Feb 09, 2021 at 09:21:12PM +0100, Horatiu Vultur wrote:
> Add basic support for MRP. The HW will just trap all MRP frames on the
> ring ports to CPU and allow the SW to process them. In this way it is
> possible to for this node to behave both as MRM and MRC.
>=20
> Current limitations are:
> - it doesn't support Interconnect roles.
> - it supports only a single ring.
> - the HW should be able to do forwarding of MRP Test frames so the SW
>   will not need to do this. So it would be able to have the role MRC
>   without SW support.
>=20
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  drivers/net/ethernet/mscc/ocelot_net.c     | 154 +++++++++++++++++++++
>  drivers/net/ethernet/mscc/ocelot_vsc7514.c |   6 +
>  include/soc/mscc/ocelot.h                  |   6 +
>  3 files changed, 166 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/mscc/ocelot_net.c b/drivers/net/etherne=
t/mscc/ocelot_net.c
> index 8f12fa45b1b5..65971403e823 100644
> --- a/drivers/net/ethernet/mscc/ocelot_net.c
> +++ b/drivers/net/ethernet/mscc/ocelot_net.c
> @@ -9,7 +9,10 @@
>   */
> =20
>  #include <linux/if_bridge.h>
> +#include <linux/mrp_bridge.h>
>  #include <net/pkt_cls.h>
> +#include <soc/mscc/ocelot_vcap.h>
> +#include <uapi/linux/mrp_bridge.h>
>  #include "ocelot.h"
>  #include "ocelot_vcap.h"
> =20
> @@ -1069,6 +1072,139 @@ static int ocelot_port_obj_del_mdb(struct net_dev=
ice *dev,
>  	return ocelot_port_mdb_del(ocelot, port, mdb);
>  }
> =20
> +#if IS_ENABLED(CONFIG_BRIDGE_MRP)
> +static int ocelot_mrp_del_vcap(struct ocelot *ocelot, int port)
> +{
> +	struct ocelot_vcap_block *block_vcap_is2;
> +	struct ocelot_vcap_filter *filter;
> +
> +	block_vcap_is2 =3D &ocelot->block[VCAP_IS2];
> +	filter =3D ocelot_vcap_block_find_filter_by_id(block_vcap_is2, port,
> +						     false);
> +	if (!filter)
> +		return 0;
> +
> +	return ocelot_vcap_filter_del(ocelot, filter);
> +}
> +
> +static int ocelot_add_mrp(struct net_device *dev,
> +			  const struct switchdev_obj_mrp *mrp)
> +{
> +	struct ocelot_port_private *priv =3D netdev_priv(dev);
> +	struct ocelot_port *ocelot_port =3D &priv->port;
> +	struct ocelot *ocelot =3D ocelot_port->ocelot;
> +
> +	if (mrp->p_port !=3D dev && mrp->s_port !=3D dev)
> +		return 0;
> +
> +	if (ocelot->mrp_ring_id !=3D 0 &&
> +	    ocelot->mrp_s_port &&
> +	    ocelot->mrp_p_port)
> +		return -EINVAL;
> +
> +	if (mrp->p_port =3D=3D dev)
> +		ocelot->mrp_p_port =3D dev;
> +
> +	if (mrp->s_port =3D=3D dev)
> +		ocelot->mrp_s_port =3D dev;
> +
> +	ocelot->mrp_ring_id =3D mrp->ring_id;
> +
> +	return 0;
> +}
> +
> +static int ocelot_del_mrp(struct net_device *dev,
> +			  const struct switchdev_obj_mrp *mrp)
> +{
> +	struct ocelot_port_private *priv =3D netdev_priv(dev);
> +	struct ocelot_port *ocelot_port =3D &priv->port;
> +	struct ocelot *ocelot =3D ocelot_port->ocelot;
> +
> +	if (ocelot->mrp_p_port !=3D dev && ocelot->mrp_s_port !=3D dev)
> +		return 0;
> +
> +	if (ocelot->mrp_ring_id =3D=3D 0 &&
> +	    !ocelot->mrp_s_port &&
> +	    !ocelot->mrp_p_port)
> +		return -EINVAL;
> +
> +	if (ocelot_mrp_del_vcap(ocelot, priv->chip_port))
> +		return -EINVAL;
> +
> +	if (ocelot->mrp_p_port =3D=3D dev)
> +		ocelot->mrp_p_port =3D NULL;
> +
> +	if (ocelot->mrp_s_port =3D=3D dev)
> +		ocelot->mrp_s_port =3D NULL;
> +
> +	ocelot->mrp_ring_id =3D 0;
> +
> +	return 0;
> +}
> +
> +static int ocelot_add_ring_role(struct net_device *dev,
> +				const struct switchdev_obj_ring_role_mrp *mrp)
> +{
> +	struct ocelot_port_private *priv =3D netdev_priv(dev);
> +	struct ocelot_port *ocelot_port =3D &priv->port;
> +	struct ocelot *ocelot =3D ocelot_port->ocelot;
> +	struct ocelot_vcap_filter *filter;
> +	int err;
> +
> +	if (ocelot->mrp_ring_id !=3D mrp->ring_id)
> +		return -EINVAL;
> +
> +	if (!mrp->sw_backup)
> +		return -EOPNOTSUPP;
> +
> +	if (ocelot->mrp_p_port !=3D dev && ocelot->mrp_s_port !=3D dev)
> +		return 0;
> +
> +	filter =3D kzalloc(sizeof(*filter), GFP_KERNEL);
> +	if (!filter)
> +		return -ENOMEM;
> +
> +	filter->key_type =3D OCELOT_VCAP_KEY_ETYPE;
> +	filter->prio =3D 1;
> +	filter->id.cookie =3D priv->chip_port;
> +	filter->id.tc_offload =3D false;
> +	filter->block_id =3D VCAP_IS2;
> +	filter->type =3D OCELOT_VCAP_FILTER_OFFLOAD;
> +	filter->ingress_port_mask =3D BIT(priv->chip_port);
> +	*(__be16 *)filter->key.etype.etype.value =3D htons(ETH_P_MRP);
> +	*(__be16 *)filter->key.etype.etype.mask =3D htons(0xffff);
> +	filter->action.mask_mode =3D OCELOT_MASK_MODE_PERMIT_DENY;
> +	filter->action.port_mask =3D 0x0;
> +	filter->action.cpu_copy_ena =3D true;
> +	filter->action.cpu_qu_num =3D 0;
> +
> +	err =3D ocelot_vcap_filter_add(ocelot, filter, NULL);
> +	if (err)
> +		kfree(filter);
> +
> +	return err;
> +}
> +
> +static int ocelot_del_ring_role(struct net_device *dev,
> +				const struct switchdev_obj_ring_role_mrp *mrp)
> +{
> +	struct ocelot_port_private *priv =3D netdev_priv(dev);
> +	struct ocelot_port *ocelot_port =3D &priv->port;
> +	struct ocelot *ocelot =3D ocelot_port->ocelot;
> +
> +	if (ocelot->mrp_ring_id !=3D mrp->ring_id)
> +		return -EINVAL;
> +
> +	if (!mrp->sw_backup)
> +		return -EOPNOTSUPP;
> +
> +	if (ocelot->mrp_p_port !=3D dev && ocelot->mrp_s_port !=3D dev)
> +		return 0;
> +
> +	return ocelot_mrp_del_vcap(ocelot, priv->chip_port);
> +}
> +#endif
> +

Would it make sense for this chunk of conditionally compiled code to
stay in a separate file like ocelot_mrp.c?

>  static int ocelot_port_obj_add(struct net_device *dev,
>  			       const struct switchdev_obj *obj,
>  			       struct netlink_ext_ack *extack)
> @@ -1083,6 +1219,15 @@ static int ocelot_port_obj_add(struct net_device *=
dev,
>  	case SWITCHDEV_OBJ_ID_PORT_MDB:
>  		ret =3D ocelot_port_obj_add_mdb(dev, SWITCHDEV_OBJ_PORT_MDB(obj));
>  		break;
> +#if IS_ENABLED(CONFIG_BRIDGE_MRP)
> +	case SWITCHDEV_OBJ_ID_MRP:
> +		ret =3D ocelot_add_mrp(dev, SWITCHDEV_OBJ_MRP(obj));
> +		break;
> +	case SWITCHDEV_OBJ_ID_RING_ROLE_MRP:
> +		ret =3D ocelot_add_ring_role(dev,
> +					   SWITCHDEV_OBJ_RING_ROLE_MRP(obj));
> +		break;
> +#endif

I'm not really sure why SWITCHDEV_OBJ_ID_MRP is conditionally defined.
If you look at SWITCHDEV_ATTR_ID_BRIDGE_VLAN_FILTERING, that isn't
conditionally defined, even though it depends on CONFIG_BRIDGE_VLAN_FILTERI=
NG
at runtime.

>  	default:
>  		return -EOPNOTSUPP;
>  	}
> @@ -1103,6 +1248,15 @@ static int ocelot_port_obj_del(struct net_device *=
dev,
>  	case SWITCHDEV_OBJ_ID_PORT_MDB:
>  		ret =3D ocelot_port_obj_del_mdb(dev, SWITCHDEV_OBJ_PORT_MDB(obj));
>  		break;
> +#if IS_ENABLED(CONFIG_BRIDGE_MRP)
> +	case SWITCHDEV_OBJ_ID_MRP:
> +		ret =3D ocelot_del_mrp(dev, SWITCHDEV_OBJ_MRP(obj));
> +		break;
> +	case SWITCHDEV_OBJ_ID_RING_ROLE_MRP:
> +		ret =3D ocelot_del_ring_role(dev,
> +					   SWITCHDEV_OBJ_RING_ROLE_MRP(obj));
> +		break;
> +#endif
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> diff --git a/drivers/net/ethernet/mscc/ocelot_vsc7514.c b/drivers/net/eth=
ernet/mscc/ocelot_vsc7514.c
> index 6b6eb92149ba..96a9c9f98060 100644
> --- a/drivers/net/ethernet/mscc/ocelot_vsc7514.c
> +++ b/drivers/net/ethernet/mscc/ocelot_vsc7514.c
> @@ -698,6 +698,12 @@ static irqreturn_t ocelot_xtr_irq_handler(int irq, v=
oid *arg)
>  			skb->offload_fwd_mark =3D 1;
> =20
>  		skb->protocol =3D eth_type_trans(skb, dev);
> +#if IS_ENABLED(CONFIG_BRIDGE_MRP)
> +		if (skb->protocol =3D=3D ntohs(ETH_P_MRP) &&
> +		    (priv->dev =3D=3D ocelot->mrp_p_port ||
> +		     priv->dev =3D=3D ocelot->mrp_s_port))
> +			skb->offload_fwd_mark =3D 0;
> +#endif

I wonder if you could just reserve a certain CPUQ for trapped traffic,
and just generically check for that, instead of MRP port roles?

>  		if (!skb_defer_rx_timestamp(skb))
>  			netif_rx(skb);
>  		dev->stats.rx_bytes +=3D len;
> diff --git a/include/soc/mscc/ocelot.h b/include/soc/mscc/ocelot.h
> index d0d48e9620fb..d95c019ad84e 100644
> --- a/include/soc/mscc/ocelot.h
> +++ b/include/soc/mscc/ocelot.h
> @@ -682,6 +682,12 @@ struct ocelot {
>  	/* Protects the PTP clock */
>  	spinlock_t			ptp_clock_lock;
>  	struct ptp_pin_desc		ptp_pins[OCELOT_PTP_PINS_NUM];
> +
> +#if IS_ENABLED(CONFIG_BRIDGE_MRP)
> +	u16				mrp_ring_id;
> +	struct net_device		*mrp_p_port;
> +	struct net_device		*mrp_s_port;
> +#endif
>  };
> =20
>  struct ocelot_policer {
> --=20
> 2.27.0
> =
