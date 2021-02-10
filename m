Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1612960243; x=1644496243;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=SO7PnQcQJ3brzaSnIG7oy+PGOYQzMMkRO1glIKCB4Gw=;
 b=0CHORc0gv2/DgIX/E8pf56ZlVhWKHlI3+2atkONshfT+jZ+r/sB0JYb4
 WCluQ1yht+vmm2IoLiI/wpGwHoxWNaSYrU4CeYBq9c73ROnMZItmFTmEI
 AcMk9xEmI4pI3Yl2sxJcwdUjfHx2VTyu38P+6Bm/YHF0OQAQSL8Ew1h4u
 aAB7r7nUgJO/p5q5JMdJUwTS01t3gPnPOM+Pr3Gj9o0ggDLTWZyM4Zrve
 728YQ0aVvMAu0OsOI6XIy8shO6LzcwYZTgbaC0K3EFDfFzQgf7KtCvTbw
 FrwvtdfgUgs1LL3u4AbSa2l9mTS0uZZJk9YlZAKwhmQ2NHQjs4CFIAgjt Q==;
Date: Wed, 10 Feb 2021 13:30:40 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Message-ID: <20210210123040.rz2whrtx35s6gbv5@soft-dev3.localdomain>
References: <20210209202112.2545325-1-horatiu.vultur@microchip.com>
 <20210209202112.2545325-6-horatiu.vultur@microchip.com>
 <20210210101802.6ztf6c3ifldfa5fw@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20210210101802.6ztf6c3ifldfa5fw@skbuf>
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
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "ivecera@redhat.com" <ivecera@redhat.com>, "andrew@lunn.ch" <andrew@lunn.ch>, "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "jiri@resnulli.us" <jiri@resnulli.us>, "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "nikolay@nvidia.com" <nikolay@nvidia.com>, "roopa@nvidia.com" <roopa@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>

The 02/10/2021 10:18, Vladimir Oltean wrote:

Hi Vladimir,

> 
> Would you mind adding the switchdev MRP support for the DSA driver too,
> and move the code to the common ocelot library? I would like to give it
> a run. I think that's only fair, since I have to keep in sync the
> vsc7514 driver too for features that get added through DSA :)

That is totally fair. I will do it in the next version :)

> 
> On Tue, Feb 09, 2021 at 09:21:12PM +0100, Horatiu Vultur wrote:
> > Add basic support for MRP. The HW will just trap all MRP frames on the
> > ring ports to CPU and allow the SW to process them. In this way it is
> > possible to for this node to behave both as MRM and MRC.
> >
> > Current limitations are:
> > - it doesn't support Interconnect roles.
> > - it supports only a single ring.
> > - the HW should be able to do forwarding of MRP Test frames so the SW
> >   will not need to do this. So it would be able to have the role MRC
> >   without SW support.
> >
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > ---
> >  drivers/net/ethernet/mscc/ocelot_net.c     | 154 +++++++++++++++++++++
> >  drivers/net/ethernet/mscc/ocelot_vsc7514.c |   6 +
> >  include/soc/mscc/ocelot.h                  |   6 +
> >  3 files changed, 166 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/mscc/ocelot_net.c b/drivers/net/ethernet/mscc/ocelot_net.c
> > index 8f12fa45b1b5..65971403e823 100644
> > --- a/drivers/net/ethernet/mscc/ocelot_net.c
> > +++ b/drivers/net/ethernet/mscc/ocelot_net.c
> > @@ -9,7 +9,10 @@
> >   */
> >
> >  #include <linux/if_bridge.h>
> > +#include <linux/mrp_bridge.h>
> >  #include <net/pkt_cls.h>
> > +#include <soc/mscc/ocelot_vcap.h>
> > +#include <uapi/linux/mrp_bridge.h>
> >  #include "ocelot.h"
> >  #include "ocelot_vcap.h"
> >
> > @@ -1069,6 +1072,139 @@ static int ocelot_port_obj_del_mdb(struct net_device *dev,
> >       return ocelot_port_mdb_del(ocelot, port, mdb);
> >  }
> >
> > +#if IS_ENABLED(CONFIG_BRIDGE_MRP)
> > +static int ocelot_mrp_del_vcap(struct ocelot *ocelot, int port)
> > +{
> > +     struct ocelot_vcap_block *block_vcap_is2;
> > +     struct ocelot_vcap_filter *filter;
> > +
> > +     block_vcap_is2 = &ocelot->block[VCAP_IS2];
> > +     filter = ocelot_vcap_block_find_filter_by_id(block_vcap_is2, port,
> > +                                                  false);
> > +     if (!filter)
> > +             return 0;
> > +
> > +     return ocelot_vcap_filter_del(ocelot, filter);
> > +}
> > +
> > +static int ocelot_add_mrp(struct net_device *dev,
> > +                       const struct switchdev_obj_mrp *mrp)
> > +{
> > +     struct ocelot_port_private *priv = netdev_priv(dev);
> > +     struct ocelot_port *ocelot_port = &priv->port;
> > +     struct ocelot *ocelot = ocelot_port->ocelot;
> > +
> > +     if (mrp->p_port != dev && mrp->s_port != dev)
> > +             return 0;
> > +
> > +     if (ocelot->mrp_ring_id != 0 &&
> > +         ocelot->mrp_s_port &&
> > +         ocelot->mrp_p_port)
> > +             return -EINVAL;
> > +
> > +     if (mrp->p_port == dev)
> > +             ocelot->mrp_p_port = dev;
> > +
> > +     if (mrp->s_port == dev)
> > +             ocelot->mrp_s_port = dev;
> > +
> > +     ocelot->mrp_ring_id = mrp->ring_id;
> > +
> > +     return 0;
> > +}
> > +
> > +static int ocelot_del_mrp(struct net_device *dev,
> > +                       const struct switchdev_obj_mrp *mrp)
> > +{
> > +     struct ocelot_port_private *priv = netdev_priv(dev);
> > +     struct ocelot_port *ocelot_port = &priv->port;
> > +     struct ocelot *ocelot = ocelot_port->ocelot;
> > +
> > +     if (ocelot->mrp_p_port != dev && ocelot->mrp_s_port != dev)
> > +             return 0;
> > +
> > +     if (ocelot->mrp_ring_id == 0 &&
> > +         !ocelot->mrp_s_port &&
> > +         !ocelot->mrp_p_port)
> > +             return -EINVAL;
> > +
> > +     if (ocelot_mrp_del_vcap(ocelot, priv->chip_port))
> > +             return -EINVAL;
> > +
> > +     if (ocelot->mrp_p_port == dev)
> > +             ocelot->mrp_p_port = NULL;
> > +
> > +     if (ocelot->mrp_s_port == dev)
> > +             ocelot->mrp_s_port = NULL;
> > +
> > +     ocelot->mrp_ring_id = 0;
> > +
> > +     return 0;
> > +}
> > +
> > +static int ocelot_add_ring_role(struct net_device *dev,
> > +                             const struct switchdev_obj_ring_role_mrp *mrp)
> > +{
> > +     struct ocelot_port_private *priv = netdev_priv(dev);
> > +     struct ocelot_port *ocelot_port = &priv->port;
> > +     struct ocelot *ocelot = ocelot_port->ocelot;
> > +     struct ocelot_vcap_filter *filter;
> > +     int err;
> > +
> > +     if (ocelot->mrp_ring_id != mrp->ring_id)
> > +             return -EINVAL;
> > +
> > +     if (!mrp->sw_backup)
> > +             return -EOPNOTSUPP;
> > +
> > +     if (ocelot->mrp_p_port != dev && ocelot->mrp_s_port != dev)
> > +             return 0;
> > +
> > +     filter = kzalloc(sizeof(*filter), GFP_KERNEL);
> > +     if (!filter)
> > +             return -ENOMEM;
> > +
> > +     filter->key_type = OCELOT_VCAP_KEY_ETYPE;
> > +     filter->prio = 1;
> > +     filter->id.cookie = priv->chip_port;
> > +     filter->id.tc_offload = false;
> > +     filter->block_id = VCAP_IS2;
> > +     filter->type = OCELOT_VCAP_FILTER_OFFLOAD;
> > +     filter->ingress_port_mask = BIT(priv->chip_port);
> > +     *(__be16 *)filter->key.etype.etype.value = htons(ETH_P_MRP);
> > +     *(__be16 *)filter->key.etype.etype.mask = htons(0xffff);
> > +     filter->action.mask_mode = OCELOT_MASK_MODE_PERMIT_DENY;
> > +     filter->action.port_mask = 0x0;
> > +     filter->action.cpu_copy_ena = true;
> > +     filter->action.cpu_qu_num = 0;
> > +
> > +     err = ocelot_vcap_filter_add(ocelot, filter, NULL);
> > +     if (err)
> > +             kfree(filter);
> > +
> > +     return err;
> > +}
> > +
> > +static int ocelot_del_ring_role(struct net_device *dev,
> > +                             const struct switchdev_obj_ring_role_mrp *mrp)
> > +{
> > +     struct ocelot_port_private *priv = netdev_priv(dev);
> > +     struct ocelot_port *ocelot_port = &priv->port;
> > +     struct ocelot *ocelot = ocelot_port->ocelot;
> > +
> > +     if (ocelot->mrp_ring_id != mrp->ring_id)
> > +             return -EINVAL;
> > +
> > +     if (!mrp->sw_backup)
> > +             return -EOPNOTSUPP;
> > +
> > +     if (ocelot->mrp_p_port != dev && ocelot->mrp_s_port != dev)
> > +             return 0;
> > +
> > +     return ocelot_mrp_del_vcap(ocelot, priv->chip_port);
> > +}
> > +#endif
> > +
> 
> Would it make sense for this chunk of conditionally compiled code to
> stay in a separate file like ocelot_mrp.c?

Also initially I was thinking to add this code in a different file but I
was not sure. But I will do that in the next version.

> 
> >  static int ocelot_port_obj_add(struct net_device *dev,
> >                              const struct switchdev_obj *obj,
> >                              struct netlink_ext_ack *extack)
> > @@ -1083,6 +1219,15 @@ static int ocelot_port_obj_add(struct net_device *dev,
> >       case SWITCHDEV_OBJ_ID_PORT_MDB:
> >               ret = ocelot_port_obj_add_mdb(dev, SWITCHDEV_OBJ_PORT_MDB(obj));
> >               break;
> > +#if IS_ENABLED(CONFIG_BRIDGE_MRP)
> > +     case SWITCHDEV_OBJ_ID_MRP:
> > +             ret = ocelot_add_mrp(dev, SWITCHDEV_OBJ_MRP(obj));
> > +             break;
> > +     case SWITCHDEV_OBJ_ID_RING_ROLE_MRP:
> > +             ret = ocelot_add_ring_role(dev,
> > +                                        SWITCHDEV_OBJ_RING_ROLE_MRP(obj));
> > +             break;
> > +#endif
> 
> I'm not really sure why SWITCHDEV_OBJ_ID_MRP is conditionally defined.
> If you look at SWITCHDEV_ATTR_ID_BRIDGE_VLAN_FILTERING, that isn't
> conditionally defined, even though it depends on CONFIG_BRIDGE_VLAN_FILTERING
> at runtime.

Then should I just create another patch for removing this? To be honest
I also prefer that SWITCHDEV_OBJ_ID_MRP will not be conditionally
defined.

> 
> >       default:
> >               return -EOPNOTSUPP;
> >       }
> > @@ -1103,6 +1248,15 @@ static int ocelot_port_obj_del(struct net_device *dev,
> >       case SWITCHDEV_OBJ_ID_PORT_MDB:
> >               ret = ocelot_port_obj_del_mdb(dev, SWITCHDEV_OBJ_PORT_MDB(obj));
> >               break;
> > +#if IS_ENABLED(CONFIG_BRIDGE_MRP)
> > +     case SWITCHDEV_OBJ_ID_MRP:
> > +             ret = ocelot_del_mrp(dev, SWITCHDEV_OBJ_MRP(obj));
> > +             break;
> > +     case SWITCHDEV_OBJ_ID_RING_ROLE_MRP:
> > +             ret = ocelot_del_ring_role(dev,
> > +                                        SWITCHDEV_OBJ_RING_ROLE_MRP(obj));
> > +             break;
> > +#endif
> >       default:
> >               return -EOPNOTSUPP;
> >       }
> > diff --git a/drivers/net/ethernet/mscc/ocelot_vsc7514.c b/drivers/net/ethernet/mscc/ocelot_vsc7514.c
> > index 6b6eb92149ba..96a9c9f98060 100644
> > --- a/drivers/net/ethernet/mscc/ocelot_vsc7514.c
> > +++ b/drivers/net/ethernet/mscc/ocelot_vsc7514.c
> > @@ -698,6 +698,12 @@ static irqreturn_t ocelot_xtr_irq_handler(int irq, void *arg)
> >                       skb->offload_fwd_mark = 1;
> >
> >               skb->protocol = eth_type_trans(skb, dev);
> > +#if IS_ENABLED(CONFIG_BRIDGE_MRP)
> > +             if (skb->protocol == ntohs(ETH_P_MRP) &&
> > +                 (priv->dev == ocelot->mrp_p_port ||
> > +                  priv->dev == ocelot->mrp_s_port))
> > +                     skb->offload_fwd_mark = 0;
> > +#endif
> 
> I wonder if you could just reserve a certain CPUQ for trapped traffic,
> and just generically check for that, instead of MRP port roles?

That is a good idea, I would try to have a look.

> 
> >               if (!skb_defer_rx_timestamp(skb))
> >                       netif_rx(skb);
> >               dev->stats.rx_bytes += len;
> > diff --git a/include/soc/mscc/ocelot.h b/include/soc/mscc/ocelot.h
> > index d0d48e9620fb..d95c019ad84e 100644
> > --- a/include/soc/mscc/ocelot.h
> > +++ b/include/soc/mscc/ocelot.h
> > @@ -682,6 +682,12 @@ struct ocelot {
> >       /* Protects the PTP clock */
> >       spinlock_t                      ptp_clock_lock;
> >       struct ptp_pin_desc             ptp_pins[OCELOT_PTP_PINS_NUM];
> > +
> > +#if IS_ENABLED(CONFIG_BRIDGE_MRP)
> > +     u16                             mrp_ring_id;
> > +     struct net_device               *mrp_p_port;
> > +     struct net_device               *mrp_s_port;
> > +#endif
> >  };
> >
> >  struct ocelot_policer {
> > --
> > 2.27.0
> >

-- 
/Horatiu
