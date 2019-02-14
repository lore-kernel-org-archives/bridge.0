Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=GbzDrE30QcsjBKK5pVdW8OvspW+LUH0Ej/TrJYAhHq0=;
	b=AAe61vEZ7vXFZcrMBieoZV9xWyJPObgLHnNU9//8rNmoBPh0lg0VbAfmN4RYwloxDTB1EWdRRVXbuSR8XNMeVGhnYMaIT7WESzvGMDwaAcCGDBwRY11PH0KMHhCrYLk0moeQstc9HAQ/kKGHGx2FUA88XkkBwYALvRYbKLPd36A=
From: Ido Schimmel <idosch@mellanox.com>
Date: Thu, 14 Feb 2019 11:20:07 +0000
Message-ID: <20190214112002.GA8698@splinter>
References: <20190213220638.1552-1-f.fainelli@gmail.com>
	<20190213220638.1552-8-f.fainelli@gmail.com>
In-Reply-To: <20190213220638.1552-8-f.fainelli@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E18242A66F1D9841904291B1D4DD715A@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next 7/9] net: bridge: Stop calling
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
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, "andrew@lunn.ch" <andrew@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "moderated
	list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>, Jiri Pirko <jiri@mellanox.com>, "David S. Miller" <davem@davemloft.net>

On Wed, Feb 13, 2019 at 02:06:36PM -0800, Florian Fainelli wrote:
> Now that all switchdev drivers have been converted to checking the
> bridge port flags during the prepare phase of the
> switchdev_port_attr_set() when the process
> SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS, we can avoid calling
> switchdev_port_attr_get() with
> SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  net/bridge/br_switchdev.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>=20
> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> index db9e8ab96d48..8f88f8a1a7fa 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c
> @@ -64,29 +64,27 @@ int br_switchdev_set_port_flag(struct net_bridge_port=
 *p,
>  {
>  	struct switchdev_attr attr =3D {
>  		.orig_dev =3D p->dev,
> -		.id =3D SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
> +		.id =3D SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS,
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
> +	err =3D switchdev_port_attr_set(p->dev, &attr);
> +	if (err && err !=3D -EOPNOTSUPP)
>  		return err;
> =20
> -	/* Check if specific bridge flag attribute offload is supported */
> -	if (!(attr.u.brport_flags_support & mask)) {
> +	if (err =3D=3D -EOPNOTSUPP) {
>  		br_warn(p->br, "bridge flag offload is not supported %u(%s)\n",
>  			(unsigned int)p->port_no, p->dev->name);
> -		return -EOPNOTSUPP;
> +		return err;
>  	}

I see that you return -EOPNOTSUPP from drivers in case of unsupported
flags. I believe this is problematic (I'll test soon). The same return
code is used by:

1. Switch drivers to indicate unsupported flags
2. switchdev code to indicate unsupported netdev (no switchdev ops)

I guess that with this patch any attempt to set bridge port flags on
veth/dummy device will result in an error.

> =20
>  	attr.id =3D SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS;
>  	attr.flags =3D SWITCHDEV_F_DEFER;
> -	attr.u.brport_flags =3D flags;
> +
>  	err =3D switchdev_port_attr_set(p->dev, &attr);
>  	if (err) {
>  		br_warn(p->br, "error setting offload flag on port %u(%s)\n",
> --=20
> 2.17.1
>=20
