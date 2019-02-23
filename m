Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=LJdUX5TVkw2YUqFe6Nabrlkt7RTF8zxyqMMO3IV+3H8=;
	b=uIiUuimyAKCDSQb+kEFdn4QUjkw0d7md9nlTH1qwHCMAKVQLHrNxjmH7wzyGMMaWzX+KqwPXQd7NHAyf5TOes39znUXhO5Zbn37uAOCZUqmiUgyslwQkOaBp3/+jFN/KthHgtHhM0a2UPgef3TlGLGQv2Doq7A6sK6Se1shfIDo=
From: Ido Schimmel <idosch@mellanox.com>
Date: Sat, 23 Feb 2019 10:33:48 +0000
Message-ID: <20190223103330.GB13070@splinter>
References: <20190222235927.10295-1-f.fainelli@gmail.com>
	<20190222235927.10295-2-f.fainelli@gmail.com>
In-Reply-To: <20190222235927.10295-2-f.fainelli@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E2D13F15B9E02A449ED35A1516F3DD1D@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next 1/8] switchdev: Add
	SWITCHDEV_PORT_ATTR_SET
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, "andrew@lunn.ch" <andrew@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "moderated
	list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>, Jiri Pirko <jiri@mellanox.com>, "David S. Miller" <davem@davemloft.net>

On Fri, Feb 22, 2019 at 03:59:19PM -0800, Florian Fainelli wrote:
> In preparation for allowing switchdev enabled drivers to veto specific
> attribute settings from within the context of the caller, introduce a
> new switchdev notifier type for port attributes.
>=20
> Suggested-by: Ido Schimmel <idosch@mellanox.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  include/net/switchdev.h   | 27 +++++++++++++++++++++
>  net/switchdev/switchdev.c | 51 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 78 insertions(+)
>=20
> diff --git a/include/net/switchdev.h b/include/net/switchdev.h
> index 45310ddf2d7e..ca56b7487540 100644
> --- a/include/net/switchdev.h
> +++ b/include/net/switchdev.h
> @@ -136,6 +136,7 @@ enum switchdev_notifier_type {
> =20
>  	SWITCHDEV_PORT_OBJ_ADD, /* Blocking. */
>  	SWITCHDEV_PORT_OBJ_DEL, /* Blocking. */
> +	SWITCHDEV_PORT_ATTR_SET, /* May be blocking . */

See my comment on 7/8. IIUC, this is always blocking, so comment needs to
be changed.

> =20
>  	SWITCHDEV_VXLAN_FDB_ADD_TO_BRIDGE,
>  	SWITCHDEV_VXLAN_FDB_DEL_TO_BRIDGE,
> @@ -164,6 +165,13 @@ struct switchdev_notifier_port_obj_info {
>  	bool handled;
>  };
> =20
> +struct switchdev_notifier_port_attr_info {
> +	struct switchdev_notifier_info info; /* must be first */
> +	const struct switchdev_attr *attr;
> +	struct switchdev_trans *trans;
> +	bool handled;
> +};
> +
>  static inline struct net_device *
>  switchdev_notifier_info_to_dev(const struct switchdev_notifier_info *inf=
o)
>  {
> @@ -216,7 +224,15 @@ int switchdev_handle_port_obj_del(struct net_device =
*dev,
>  			int (*del_cb)(struct net_device *dev,
>  				      const struct switchdev_obj *obj));
> =20
> +int switchdev_handle_port_attr_set(struct net_device *dev,
> +			struct switchdev_notifier_port_attr_info *port_attr_info,
> +			bool (*check_cb)(const struct net_device *dev),
> +			int (*set_cb)(struct net_device *dev,
> +				      const struct switchdev_attr *attr,
> +				      struct switchdev_trans *trans));
> +
>  #define SWITCHDEV_SET_OPS(netdev, ops) ((netdev)->switchdev_ops =3D (ops=
))
> +
>  #else
> =20
>  static inline void switchdev_deferred_process(void)
> @@ -303,6 +319,17 @@ switchdev_handle_port_obj_del(struct net_device *dev=
,
>  	return 0;
>  }
> =20
> +static inline int
> +switchdev_handle_port_attr_set(struct net_device *dev,
> +			struct switchdev_notifier_port_attr_info *port_attr_info,
> +			bool (*check_cb)(const struct net_device *dev),
> +			int (*set_cb)(struct net_device *dev,
> +				      const struct switchdev_attr *attr,
> +				      struct switchdev_trans *trans))
> +{
> +	return 0;
> +}
> +
>  #define SWITCHDEV_SET_OPS(netdev, ops) do {} while (0)
> =20
>  #endif
> diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
> index 7e1357db33d7..94400f5b8e07 100644
> --- a/net/switchdev/switchdev.c
> +++ b/net/switchdev/switchdev.c
> @@ -697,3 +697,54 @@ int switchdev_handle_port_obj_del(struct net_device =
*dev,
>  	return err;
>  }
>  EXPORT_SYMBOL_GPL(switchdev_handle_port_obj_del);
> +
> +static int __switchdev_handle_port_attr_set(struct net_device *dev,
> +			struct switchdev_notifier_port_attr_info *port_attr_info,
> +			bool (*check_cb)(const struct net_device *dev),
> +			int (*set_cb)(struct net_device *dev,
> +				      const struct switchdev_attr *attr,
> +				      struct switchdev_trans *trans))
> +{
> +	struct net_device *lower_dev;
> +	struct list_head *iter;
> +	int err =3D -EOPNOTSUPP;
> +
> +	if (check_cb(dev)) {
> +		port_attr_info->handled =3D true;
> +		return set_cb(dev, port_attr_info->attr,
> +			      port_attr_info->trans);
> +	}
> +
> +	/* Switch ports might be stacked under e.g. a LAG. Ignore the
> +	 * unsupported devices, another driver might be able to handle them. Bu=
t
> +	 * propagate to the callers any hard errors.
> +	 *
> +	 * If the driver does its own bookkeeping of stacked ports, it's not
> +	 * necessary to go through this helper.
> +	 */
> +	netdev_for_each_lower_dev(dev, lower_dev, iter) {
> +		err =3D __switchdev_handle_port_attr_set(lower_dev, port_attr_info,
> +						       check_cb, set_cb);
> +		if (err && err !=3D -EOPNOTSUPP)
> +			return err;
> +	}
> +
> +	return err;
> +}
> +
> +int switchdev_handle_port_attr_set(struct net_device *dev,
> +			struct switchdev_notifier_port_attr_info *port_attr_info,
> +			bool (*check_cb)(const struct net_device *dev),
> +			int (*set_cb)(struct net_device *dev,
> +				      const struct switchdev_attr *attr,
> +				      struct switchdev_trans *trans))
> +{
> +	int err;
> +
> +	err =3D __switchdev_handle_port_attr_set(dev, port_attr_info, check_cb,
> +					       set_cb);
> +	if (err =3D=3D -EOPNOTSUPP)
> +		err =3D 0;
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(switchdev_handle_port_attr_set);
> --=20
> 2.17.1
>=20
