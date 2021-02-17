Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/aEXQUbrqih7fnqkYtmslFp1Hhl40QN2oBHbhyz044=;
 b=FWm0HRA8bDUCAEf9DQYiBKIEQjzXjkPB8husP1K6w0dsMJluIAb4RKzL1f5GqzYQZLo45OZr6WDOsQBMdVJ3vHkoPd02un5w1CEZEwXTBushWrVnwiBWb32iFz4AMt7eQaRDhnjjVwRF7gUu0aBMd3RF14u1/XBm5f1RpulZd1Y=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Wed, 17 Feb 2021 11:23:42 +0000
Message-ID: <20210217112340.xxdfvwp3mw52isse@skbuf>
References: <20210216214205.32385-1-horatiu.vultur@microchip.com>
 <20210216214205.32385-8-horatiu.vultur@microchip.com>
In-Reply-To: <20210216214205.32385-8-horatiu.vultur@microchip.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <370D995BDD149F42963C905A96EF2249@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v4 7/8] net: dsa: add MRP support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: "ivecera@redhat.com" <ivecera@redhat.com>, "andrew@lunn.ch" <andrew@lunn.ch>, "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>, "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>, "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "nikolay@nvidia.com" <nikolay@nvidia.com>, "roopa@nvidia.com" <roopa@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>

On Tue, Feb 16, 2021 at 10:42:04PM +0100, Horatiu Vultur wrote:
> Add support for offloading MRP in HW. Currently implement the switchdev
> calls 'SWITCHDEV_OBJ_ID_MRP', 'SWITCHDEV_OBJ_ID_RING_ROLE_MRP',
> to allow to create MRP instances and to set the role of these instances.
>=20
> Add DSA_NOTIFIER_MRP_ADD/DEL and DSA_NOTIFIER_MRP_ADD/DEL_RING_ROLE
> which calls to .port_mrp_add/del and .port_mrp_add/del_ring_role in the
> DSA driver for the switch.
>=20
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  include/net/dsa.h  |  12 ++++++
>  net/dsa/dsa_priv.h |  26 +++++++++++
>  net/dsa/port.c     |  48 +++++++++++++++++++++
>  net/dsa/slave.c    |  22 ++++++++++
>  net/dsa/switch.c   | 105 +++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 213 insertions(+)
>=20
> diff --git a/include/net/dsa.h b/include/net/dsa.h
> index 68f8159564a3..83a933e563fe 100644
> --- a/include/net/dsa.h
> +++ b/include/net/dsa.h
> @@ -792,6 +792,18 @@ struct dsa_switch_ops {
>  				 struct net_device *hsr);
>  	int	(*port_hsr_leave)(struct dsa_switch *ds, int port,
>  				  struct net_device *hsr);
> +
> +	/*
> +	 * MRP integration
> +	 */
> +	int	(*port_mrp_add)(struct dsa_switch *ds, int port,
> +				const struct switchdev_obj_mrp *mrp);
> +	int	(*port_mrp_del)(struct dsa_switch *ds, int port,
> +				const struct switchdev_obj_mrp *mrp);
> +	int	(*port_mrp_add_ring_role)(struct dsa_switch *ds, int port,
> +					  const struct switchdev_obj_ring_role_mrp *mrp);
> +	int	(*port_mrp_del_ring_role)(struct dsa_switch *ds, int port,
> +					  const struct switchdev_obj_ring_role_mrp *mrp);
>  };
> =20
>  #define DSA_DEVLINK_PARAM_DRIVER(_id, _name, _type, _cmodes)		\
> diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
> index e9d1e76c42ba..2eeaa42f2e08 100644
> --- a/net/dsa/dsa_priv.h
> +++ b/net/dsa/dsa_priv.h
> @@ -31,6 +31,10 @@ enum {
>  	DSA_NOTIFIER_VLAN_DEL,
>  	DSA_NOTIFIER_MTU,
>  	DSA_NOTIFIER_TAG_PROTO,
> +	DSA_NOTIFIER_MRP_ADD,
> +	DSA_NOTIFIER_MRP_DEL,
> +	DSA_NOTIFIER_MRP_ADD_RING_ROLE,
> +	DSA_NOTIFIER_MRP_DEL_RING_ROLE,
>  };
> =20
>  /* DSA_NOTIFIER_AGEING_TIME */
> @@ -91,6 +95,20 @@ struct dsa_notifier_tag_proto_info {
>  	const struct dsa_device_ops *tag_ops;
>  };
> =20
> +/* DSA_NOTIFIER_MRP_* */
> +struct dsa_notifier_mrp_info {
> +	const struct switchdev_obj_mrp *mrp;
> +	int sw_index;
> +	int port;
> +};
> +
> +/* DSA_NOTIFIER_MRP_* */
> +struct dsa_notifier_mrp_ring_role_info {
> +	const struct switchdev_obj_ring_role_mrp *mrp;
> +	int sw_index;
> +	int port;
> +};
> +
>  struct dsa_switchdev_event_work {
>  	struct dsa_switch *ds;
>  	int port;
> @@ -198,6 +216,14 @@ int dsa_port_vlan_add(struct dsa_port *dp,
>  		      struct netlink_ext_ack *extack);
>  int dsa_port_vlan_del(struct dsa_port *dp,
>  		      const struct switchdev_obj_port_vlan *vlan);
> +int dsa_port_mrp_add(const struct dsa_port *dp,
> +		     const struct switchdev_obj_mrp *mrp);
> +int dsa_port_mrp_del(const struct dsa_port *dp,
> +		     const struct switchdev_obj_mrp *mrp);
> +int dsa_port_mrp_add_ring_role(const struct dsa_port *dp,
> +			       const struct switchdev_obj_ring_role_mrp *mrp);
> +int dsa_port_mrp_del_ring_role(const struct dsa_port *dp,
> +			       const struct switchdev_obj_ring_role_mrp *mrp);
>  int dsa_port_link_register_of(struct dsa_port *dp);
>  void dsa_port_link_unregister_of(struct dsa_port *dp);
>  int dsa_port_hsr_join(struct dsa_port *dp, struct net_device *hsr);
> diff --git a/net/dsa/port.c b/net/dsa/port.c
> index 14a1d0d77657..c9c6d7ab3f47 100644
> --- a/net/dsa/port.c
> +++ b/net/dsa/port.c
> @@ -564,6 +564,54 @@ int dsa_port_vlan_del(struct dsa_port *dp,
>  	return dsa_port_notify(dp, DSA_NOTIFIER_VLAN_DEL, &info);
>  }
> =20
> +int dsa_port_mrp_add(const struct dsa_port *dp,
> +		     const struct switchdev_obj_mrp *mrp)
> +{
> +	struct dsa_notifier_mrp_info info =3D {
> +		.sw_index =3D dp->ds->index,
> +		.port =3D dp->index,
> +		.mrp =3D mrp,
> +	};
> +
> +	return dsa_port_notify(dp, DSA_NOTIFIER_MRP_ADD, &info);
> +}
> +
> +int dsa_port_mrp_del(const struct dsa_port *dp,
> +		     const struct switchdev_obj_mrp *mrp)
> +{
> +	struct dsa_notifier_mrp_info info =3D {
> +		.sw_index =3D dp->ds->index,
> +		.port =3D dp->index,
> +		.mrp =3D mrp,
> +	};
> +
> +	return dsa_port_notify(dp, DSA_NOTIFIER_MRP_DEL, &info);
> +}
> +
> +int dsa_port_mrp_add_ring_role(const struct dsa_port *dp,
> +			       const struct switchdev_obj_ring_role_mrp *mrp)
> +{
> +	struct dsa_notifier_mrp_ring_role_info info =3D {
> +		.sw_index =3D dp->ds->index,
> +		.port =3D dp->index,
> +		.mrp =3D mrp,
> +	};
> +
> +	return dsa_port_notify(dp, DSA_NOTIFIER_MRP_ADD_RING_ROLE, &info);
> +}
> +
> +int dsa_port_mrp_del_ring_role(const struct dsa_port *dp,
> +			       const struct switchdev_obj_ring_role_mrp *mrp)
> +{
> +	struct dsa_notifier_mrp_ring_role_info info =3D {
> +		.sw_index =3D dp->ds->index,
> +		.port =3D dp->index,
> +		.mrp =3D mrp,
> +	};
> +
> +	return dsa_port_notify(dp, DSA_NOTIFIER_MRP_DEL_RING_ROLE, &info);
> +}
> +
>  void dsa_port_set_tag_protocol(struct dsa_port *cpu_dp,
>  			       const struct dsa_device_ops *tag_ops)
>  {
> diff --git a/net/dsa/slave.c b/net/dsa/slave.c
> index 5ecb43a1b6e0..491e3761b5f4 100644
> --- a/net/dsa/slave.c
> +++ b/net/dsa/slave.c
> @@ -404,6 +404,17 @@ static int dsa_slave_port_obj_add(struct net_device =
*dev,
>  	case SWITCHDEV_OBJ_ID_PORT_VLAN:
>  		err =3D dsa_slave_vlan_add(dev, obj, extack);
>  		break;
> +	case SWITCHDEV_OBJ_ID_MRP:
> +		if (!dsa_port_offloads_netdev(dp, obj->orig_dev))
> +			return -EOPNOTSUPP;
> +		err =3D dsa_port_mrp_add(dp, SWITCHDEV_OBJ_MRP(obj));
> +		break;
> +	case SWITCHDEV_OBJ_ID_RING_ROLE_MRP:
> +		if (!dsa_port_offloads_netdev(dp, obj->orig_dev))
> +			return -EOPNOTSUPP;
> +		err =3D dsa_port_mrp_add_ring_role(dp,
> +						 SWITCHDEV_OBJ_RING_ROLE_MRP(obj));
> +		break;
>  	default:
>  		err =3D -EOPNOTSUPP;
>  		break;
> @@ -461,6 +472,17 @@ static int dsa_slave_port_obj_del(struct net_device =
*dev,
>  	case SWITCHDEV_OBJ_ID_PORT_VLAN:
>  		err =3D dsa_slave_vlan_del(dev, obj);
>  		break;
> +	case SWITCHDEV_OBJ_ID_MRP:
> +		if (!dsa_port_offloads_netdev(dp, obj->orig_dev))
> +			return -EOPNOTSUPP;
> +		err =3D dsa_port_mrp_del(dp, SWITCHDEV_OBJ_MRP(obj));
> +		break;
> +	case SWITCHDEV_OBJ_ID_RING_ROLE_MRP:
> +		if (!dsa_port_offloads_netdev(dp, obj->orig_dev))
> +			return -EOPNOTSUPP;
> +		err =3D dsa_port_mrp_del_ring_role(dp,
> +						 SWITCHDEV_OBJ_RING_ROLE_MRP(obj));
> +		break;
>  	default:
>  		err =3D -EOPNOTSUPP;
>  		break;
> diff --git a/net/dsa/switch.c b/net/dsa/switch.c
> index db2a9b221988..4b5da89dc27a 100644
> --- a/net/dsa/switch.c
> +++ b/net/dsa/switch.c
> @@ -372,6 +372,99 @@ static int dsa_switch_change_tag_proto(struct dsa_sw=
itch *ds,
>  	return 0;
>  }
> =20
> +static bool dsa_switch_mrp_match(struct dsa_switch *ds, int port,
> +				 struct dsa_notifier_mrp_info *info)
> +{
> +	if (ds->index =3D=3D info->sw_index && port =3D=3D info->port)
> +		return true;
> +
> +	if (dsa_is_dsa_port(ds, port))
> +		return true;
> +
> +	return false;
> +}
> +
> +static int dsa_switch_mrp_add(struct dsa_switch *ds,
> +			      struct dsa_notifier_mrp_info *info)
> +{
> +	int err =3D 0;
> +	int port;
> +
> +	if (!ds->ops->port_mrp_add)
> +		return -EOPNOTSUPP;
> +
> +	for (port =3D 0; port < ds->num_ports; port++) {
> +		if (dsa_switch_mrp_match(ds, port, info)) {
> +			err =3D ds->ops->port_mrp_add(ds, port, info->mrp);
> +			if (err)
> +				break;
> +		}
> +	}
> +
> +	return err;
> +}
> +
> +static int dsa_switch_mrp_del(struct dsa_switch *ds,
> +			      struct dsa_notifier_mrp_info *info)
> +{
> +	if (!ds->ops->port_mrp_del)
> +		return -EOPNOTSUPP;
> +
> +	if (ds->index =3D=3D info->sw_index)
> +		return ds->ops->port_mrp_del(ds, info->port, info->mrp);
> +
> +	return 0;
> +}
> +

Why not use dsa_switch_mrp_match here too? (question valid for the ring
role below too)

> +static bool
> +dsa_switch_mrp_ring_role_match(struct dsa_switch *ds, int port,
> +			       struct dsa_notifier_mrp_ring_role_info *info)
> +{
> +	if (ds->index =3D=3D info->sw_index && port =3D=3D info->port)
> +		return true;
> +
> +	if (dsa_is_dsa_port(ds, port))
> +		return true;
> +
> +	return false;
> +}
> +
> +static int
> +dsa_switch_mrp_add_ring_role(struct dsa_switch *ds,
> +			     struct dsa_notifier_mrp_ring_role_info *info)
> +{
> +	int err =3D 0;
> +	int port;
> +
> +	if (!ds->ops->port_mrp_add)
> +		return -EOPNOTSUPP;
> +
> +	for (port =3D 0; port < ds->num_ports; port++) {
> +		if (dsa_switch_mrp_ring_role_match(ds, port, info)) {
> +			err =3D ds->ops->port_mrp_add_ring_role(ds, port,
> +							      info->mrp);
> +			if (err)
> +				break;
> +		}
> +	}
> +
> +	return err;
> +}
> +
> +static int
> +dsa_switch_mrp_del_ring_role(struct dsa_switch *ds,
> +			     struct dsa_notifier_mrp_ring_role_info *info)
> +{
> +	if (!ds->ops->port_mrp_del)
> +		return -EOPNOTSUPP;
> +
> +	if (ds->index =3D=3D info->sw_index)
> +		return ds->ops->port_mrp_del_ring_role(ds, info->port,
> +						       info->mrp);
> +
> +	return 0;
> +}
> +
>  static int dsa_switch_event(struct notifier_block *nb,
>  			    unsigned long event, void *info)
>  {
> @@ -427,6 +520,18 @@ static int dsa_switch_event(struct notifier_block *n=
b,
>  	case DSA_NOTIFIER_TAG_PROTO:
>  		err =3D dsa_switch_change_tag_proto(ds, info);
>  		break;
> +	case DSA_NOTIFIER_MRP_ADD:
> +		err =3D dsa_switch_mrp_add(ds, info);
> +		break;
> +	case DSA_NOTIFIER_MRP_DEL:
> +		err =3D dsa_switch_mrp_del(ds, info);
> +		break;
> +	case DSA_NOTIFIER_MRP_ADD_RING_ROLE:
> +		err =3D dsa_switch_mrp_add_ring_role(ds, info);
> +		break;
> +	case DSA_NOTIFIER_MRP_DEL_RING_ROLE:
> +		err =3D dsa_switch_mrp_del_ring_role(ds, info);
> +		break;
>  	default:
>  		err =3D -EOPNOTSUPP;
>  		break;
> --=20
> 2.27.0
> =
