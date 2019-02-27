Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=n/GsUgg6V0Qm3dJI29WE0dFeCZiRRM50FdKRSxc+FOE=;
	b=xuSUxj1a5zHHUqmh/+ugrumJDrLk8eRSqeeGyMdOaPtYszy/xSfUUjZawBfnsTAx+BeRKnl214JXbFhW/rCiwARAqSfh7u07UoGGDGBN7tTIYRzwq0KLYT6lkcfm6hSQlF7HvcBmLSNOJ7IjoBLIaq7GixB08pkqdP6l4QO5Uy0=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 27 Feb 2019 20:16:31 +0000
Message-ID: <20190227201628.GA7022@splinter>
References: <20190227194432.725-1-f.fainelli@gmail.com>
	<20190227194432.725-8-f.fainelli@gmail.com>
In-Reply-To: <20190227194432.725-8-f.fainelli@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A900F4E71779D34F8B6C0E492FB4363A@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v3 7/8] net: switchdev: Replace port
 attr set SDO with a notification
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

On Wed, Feb 27, 2019 at 11:44:31AM -0800, Florian Fainelli wrote:
> Drop switchdev_ops.switchdev_port_attr_set. Drop the uses of this field
> from all clients, which were migrated to use switchdev notification in
> the previous patches.
>=20
> Add a new function switchdev_port_attr_notify() that sends the switchdev
> notifications SWITCHDEV_PORT_ATTR_SET and calls the blocking (process)
> notifier chain.
>=20
> We have one odd case within net/bridge/br_switchdev.c with the
> SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS attribute identifier that
> requires executing from atomic context, we deal with that one
> specifically.
>=20
> Drop __switchdev_port_attr_set() and update switchdev_port_attr_set()
> likewise.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>

One small nit that you can address in a follow-up:

> @@ -67,12 +67,18 @@ int br_switchdev_set_port_flag(struct net_bridge_port=
 *p,
>  		.id =3D SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS,
>  		.u.brport_flags =3D mask,
>  	};
> +	struct switchdev_notifier_port_attr_info info =3D {
> +		.attr =3D &attr,
> +	};
>  	int err;
> =20
>  	if (mask & ~BR_PORT_FLAGS_HW_OFFLOAD)
>  		return 0;
> =20
> -	err =3D switchdev_port_attr_set(p->dev, &attr);
> +	/* We run from atomic context here */
> +	err =3D call_switchdev_notifiers(SWITCHDEV_PORT_ATTR_SET, p->dev,
> +				       &info.info, NULL);
> +	err =3D notifier_to_errno(err);
>  	if (err =3D=3D -EOPNOTSUPP)
>  		return 0;

This check can be removed. The code below checks `err` and fails the
operation in case of error.
