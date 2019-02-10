Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=IVaqKF5ruEJqcImjKYCUmLUHS3vhDUqSkvF6Yr3HUWM=;
	b=EJyGyNsZtsZ97N68/gbWz1oQ2CAKmK/wWvKrg4pBjEMhGSZr1mgO4hbSvzoIR2TtYJ/mq/nnRF5TzCRXMpEJOZOxrVPrX9XXmbOqsxnT9blXyX0ftXWm0DuiK84jJliBqVGcHT1woDpe2e+6UFNOsuLIhnrLAb4tCxfJnjEp10M=
From: Ido Schimmel <idosch@mellanox.com>
Date: Sun, 10 Feb 2019 19:05:04 +0000
Message-ID: <20190210190501.GA26726@splinter>
References: <20190210175105.31629-1-f.fainelli@gmail.com>
	<20190210175105.31629-7-f.fainelli@gmail.com>
In-Reply-To: <20190210175105.31629-7-f.fainelli@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C8504F4294E37B45B2118EBF49BE8AEB@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v2 06/16] net: bridge: Stop calling
 switchdev_port_attr_get()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "andrew@lunn.ch" <andrew@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiri Pirko <jiri@mellanox.com>, "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>

On Sun, Feb 10, 2019 at 09:50:55AM -0800, Florian Fainelli wrote:
> Now that all switchdev drivers have been converted to checking the
> bridge port flags during the prepare phase of the
> switchdev_port_attr_set(), we can move straight to trying to set the
> desired flag through SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS.
>=20
> Acked-by: Jiri Pirko <jiri@mellanox.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  net/bridge/br_switchdev.c | 20 +++-----------------
>  1 file changed, 3 insertions(+), 17 deletions(-)
>=20
> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> index db9e8ab96d48..939f300522c5 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c
> @@ -64,29 +64,15 @@ int br_switchdev_set_port_flag(struct net_bridge_port=
 *p,
>  {
>  	struct switchdev_attr attr =3D {
>  		.orig_dev =3D p->dev,
> -		.id =3D SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
> +		.id =3D SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS,
> +		.flags =3D SWITCHDEV_F_DEFER,

How does this work? You defer the operation, so the driver cannot veto
it. This is why we have SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT
which is not deferred.

> +		.u.brport_flags =3D flags,
>  	};
>  	int err;
> =20
>  	if (mask & ~BR_PORT_FLAGS_HW_OFFLOAD)
>  		return 0;
> =20
> -	err =3D switchdev_port_attr_get(p->dev, &attr);
> -	if (err =3D=3D -EOPNOTSUPP)
> -		return 0;
> -	if (err)
> -		return err;
> -
> -	/* Check if specific bridge flag attribute offload is supported */
> -	if (!(attr.u.brport_flags_support & mask)) {
> -		br_warn(p->br, "bridge flag offload is not supported %u(%s)\n",
> -			(unsigned int)p->port_no, p->dev->name);
> -		return -EOPNOTSUPP;
> -	}
> -
> -	attr.id =3D SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS;
> -	attr.flags =3D SWITCHDEV_F_DEFER;
> -	attr.u.brport_flags =3D flags;
>  	err =3D switchdev_port_attr_set(p->dev, &attr);
>  	if (err) {
>  		br_warn(p->br, "error setting offload flag on port %u(%s)\n",
> --=20
> 2.19.1
>=20
