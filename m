Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=tB7WEjmYFebb1ka2RaEWjr519S6avl7PPHLsjQg0yJk=;
	b=GHhAfypfKwFcGcoUYDvZVHW6jSg3TF5RCW9pzgK3NRwnNpZ8YzLo1uzNB60LDYOqaip76pVLndClAJA8L1j1/lG/3TgJVKcL2Huq9QFeDYdoJsGEXs4buV3dB+yhb03exBa42Qa1HNsvdjkgpJneh4zL0U0YQ85vuak2lcmAMmE=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 27 Feb 2019 12:28:34 +0000
Message-ID: <20190227122831.GA13567@splinter>
References: <20190227011427.16487-1-f.fainelli@gmail.com>
	<20190227011427.16487-8-f.fainelli@gmail.com>
In-Reply-To: <20190227011427.16487-8-f.fainelli@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F77EC415C0476E40980E2EDD1F90F65C@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v2 7/8] net: switchdev: Replace port
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

On Tue, Feb 26, 2019 at 05:14:26PM -0800, Florian Fainelli wrote:
> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> index af57c4a2b78a..b7988d49d708 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c
> @@ -67,12 +67,17 @@ int br_switchdev_set_port_flag(struct net_bridge_port=
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
>  	if (err =3D=3D -EOPNOTSUPP)

Florian, this needs to use notifier_to_errno() and check for any error.
With the ops, `-EOPNOTSUPP` was returned for devices that did not
implement `switchdev_ops`. Now they will simply not listen / reply to
the notification.

>  		return 0;
