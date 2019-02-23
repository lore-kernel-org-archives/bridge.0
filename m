Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=o9lqsyiDsNGH2ZD3Do7ufAfzCq+bh/RR2twbrnzslow=;
	b=pmVW5+Lo0SjkM75k8txsjhQPAHLKL0QTn+SdXR6RTvGuY8dT75XM+FPOgtu0YFcMRqK1Nvhy89rEKeT/8YHLcBxxef8Z3m7qgknQmFa2bUUXKuFVpLOutYUrYyZUPXyZbLo+LUusXVdSqJCJG3Bs3BIZJU+df1Ii7H0GUfwB6ls=
From: Ido Schimmel <idosch@mellanox.com>
Date: Sat, 23 Feb 2019 10:36:54 +0000
Message-ID: <20190223103651.GC13070@splinter>
References: <20190222235927.10295-1-f.fainelli@gmail.com>
	<20190222235927.10295-5-f.fainelli@gmail.com>
In-Reply-To: <20190222235927.10295-5-f.fainelli@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E20568B61978194FB1D0123B536834A2@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next 4/8] mlxsw: spectrum_switchdev: Handle
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

On Fri, Feb 22, 2019 at 03:59:22PM -0800, Florian Fainelli wrote:
> Following patches will change the way we communicate setting a port's
> attribute and use a notifier to perform those tasks.
>=20
> Prepare mlxsw to support receiving notifier events targeting
> SWITCHDEV_PORT_ATTR_SET and utilize the switchdev_handle_port_attr_set()
> to handle stacking of devices.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../net/ethernet/mellanox/mlxsw/spectrum_switchdev.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/d=
rivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
> index 766f5b5f1cf5..c1aedfea3a31 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
> @@ -3123,6 +3123,13 @@ static int mlxsw_sp_switchdev_event(struct notifie=
r_block *unused,
>  	struct net_device *br_dev;
>  	int err;
> =20
> +	if (event =3D=3D SWITCHDEV_PORT_ATTR_SET) {
> +		err =3D switchdev_handle_port_attr_set(dev, ptr,
> +						     mlxsw_sp_port_dev_check,
> +						     mlxsw_sp_port_attr_set);
> +		return notifier_from_errno(err);

I don't think this code is ever executed. And if it was executed, we
would have problems because switchdev_handle_port_attr_set() might
block.

> +	}
> +
>  	/* Tunnel devices are not our uppers, so check their master instead */
>  	br_dev =3D netdev_master_upper_dev_get_rcu(dev);
>  	if (!br_dev)
> @@ -3446,6 +3453,11 @@ static int mlxsw_sp_switchdev_blocking_event(struc=
t notifier_block *unused,
>  							mlxsw_sp_port_dev_check,
>  							mlxsw_sp_port_obj_del);
>  		return notifier_from_errno(err);
> +	case SWITCHDEV_PORT_ATTR_SET:
> +		err =3D switchdev_handle_port_attr_set(dev, ptr,
> +						     mlxsw_sp_port_dev_check,
> +						     mlxsw_sp_port_attr_set);
> +		return notifier_from_errno(err);
>  	}
> =20
>  	return NOTIFY_DONE;
> --=20
> 2.17.1
>=20
