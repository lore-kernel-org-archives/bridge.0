Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=wAJVsK8hiHFIB9tUBItftnwv/AzgwwxpOx3Es/kuofA=;
	b=XYEOlfJGsYvgCTLASixkDD12MsGFOIylML+E8/WSDCazwqR6HPnAZfLgFVn/CdsRrkpgwBIJIampj2CvzrwBERV5dzArrtE60+cr5j9a+att7l4ysZC30oA9EjA1zhFJUQcOlBZEt8NcLF0yTO1MQt1SFz3f7ACROaX8OSh2QCc=
From: Ido Schimmel <idosch@mellanox.com>
Date: Tue, 12 Feb 2019 14:07:58 +0000
Message-ID: <20190212140756.GB16850@splinter>
References: <20190211191001.8623-1-f.fainelli@gmail.com>
	<20190211191001.8623-5-f.fainelli@gmail.com>
In-Reply-To: <20190211191001.8623-5-f.fainelli@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7357BE726D79B14582CF9DE74276DEA6@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v4 4/9] mlxsw: spectrum_switchdev:
 Handle SWITCHDEV_PORT_ATTR_GET/SET
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

On Mon, Feb 11, 2019 at 11:09:56AM -0800, Florian Fainelli wrote:
> Following patches will change the way we communicate getting or setting
> a port's attribute and use a blocking notifier to perform those tasks.
>=20
> Prepare mlxsw to support receiving notifier events targeting
> SWITCHDEV_PORT_ATTR_GET/SET and simply translate that into the existing
> mlxsw_sp_port_attr_{set,get} calls.
>=20
> Acked-by: Jiri Pirko <jiri@mellanox.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../mellanox/mlxsw/spectrum_switchdev.c       | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/d=
rivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
> index 95e37de3e48f..88d4994309a7 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
> @@ -3443,6 +3443,26 @@ mlxsw_sp_switchdev_handle_vxlan_obj_del(struct net=
_device *vxlan_dev,
>  	}
>  }
> =20
> +static int
> +mlxsw_sp_switchdev_port_attr_event(unsigned long event, struct net_devic=
e *dev,
> +		struct switchdev_notifier_port_attr_info *port_attr_info)
> +{
> +	int err =3D -EOPNOTSUPP;
> +
> +	switch (event) {
> +	case SWITCHDEV_PORT_ATTR_SET:
> +		err =3D mlxsw_sp_port_attr_set(dev, port_attr_info->attr,
> +					     port_attr_info->trans);

It is not that simple. These functions expect 'dev' to be an mlxsw
netdev since the operation is propagated using the device chain. This is
not the case with notification chains. 'dev' can be any netdev in the
system and then this line in mlxsw_sp_port_attr_set() is not correct:

struct mlxsw_sp_port *mlxsw_sp_port =3D netdev_priv(dev);

You can check commit f30f0601eb93 ("switchdev: Add helpers to aid
traversal through lower devices") for reference.

> +		break;
> +	case SWITCHDEV_PORT_ATTR_GET:
> +		err =3D mlxsw_sp_port_attr_get(dev, port_attr_info->attr);
> +		break;
> +	}
> +
> +	port_attr_info->handled =3D true;

I believe this should only be set in case the driver actually handled
the notification. That's how it works for objects.

I suggest looking at the series merged in commit 06d212900ea9 ("Merge
branch 'switchdev-blocking-notifiers'").

> +	return notifier_from_errno(err);
> +}
> +
>  static int mlxsw_sp_switchdev_blocking_event(struct notifier_block *unus=
ed,
>  					     unsigned long event, void *ptr)
>  {
> @@ -3466,6 +3486,9 @@ static int mlxsw_sp_switchdev_blocking_event(struct=
 notifier_block *unused,
>  							mlxsw_sp_port_dev_check,
>  							mlxsw_sp_port_obj_del);
>  		return notifier_from_errno(err);
> +	case SWITCHDEV_PORT_ATTR_SET: /* fall through */
> +	case SWITCHDEV_PORT_ATTR_GET:
> +		return mlxsw_sp_switchdev_port_attr_event(event, dev, ptr);
>  	}
> =20
>  	return NOTIFY_DONE;
> --=20
> 2.17.1
>=20
