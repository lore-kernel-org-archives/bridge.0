Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8ojTnqodtnJGj9tpT7QuxC+KIVhGhgUQB0KDBTVJcM=;
 b=Bsp9Cy7jjt3n3gxSjf85Cjnb3+Hd7DhPoqxFmxeskjhmBtKg4zi2q8JEwaDw/OK2lpgnrFZ+oNmyyE53CNFoWlKa9xbBGnn2zOIVve0b45dD/mcO+9est1xiASELN1GZ0Y21vb42oB+espoefT+MgevWrowO/Mc1tOcA4FD602o=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Wed, 17 Feb 2021 10:59:51 +0000
Message-ID: <20210217105951.5nyfclvf6e2p2nkf@skbuf>
References: <20210216214205.32385-1-horatiu.vultur@microchip.com>
 <20210216214205.32385-6-horatiu.vultur@microchip.com>
In-Reply-To: <20210216214205.32385-6-horatiu.vultur@microchip.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7FC3E7294BB39C4C8F6B740EB1077ABE@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v4 5/8] bridge: mrp: Update br_mrp to
 use new return values of br_mrp_switchdev
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

On Tue, Feb 16, 2021 at 10:42:02PM +0100, Horatiu Vultur wrote:
> diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
> index 01c67ed727a9..12487f6fe9b4 100644
> --- a/net/bridge/br_mrp.c
> +++ b/net/bridge/br_mrp.c
> @@ -639,7 +639,7 @@ int br_mrp_set_ring_role(struct net_bridge *br,
>  			 struct br_mrp_ring_role *role)
>  {
>  	struct br_mrp *mrp =3D br_mrp_find_id(br, role->ring_id);
> -	int err;
> +	enum br_mrp_hw_support support;
> =20
>  	if (!mrp)
>  		return -EINVAL;
> @@ -647,9 +647,9 @@ int br_mrp_set_ring_role(struct net_bridge *br,
>  	mrp->ring_role =3D role->ring_role;
> =20
>  	/* If there is an error just bailed out */
> -	err =3D br_mrp_switchdev_set_ring_role(br, mrp, role->ring_role);
> -	if (err && err !=3D -EOPNOTSUPP)
> -		return err;
> +	support =3D br_mrp_switchdev_set_ring_role(br, mrp, role->ring_role);
> +	if (support =3D=3D BR_MRP_NONE)
> +		return -EOPNOTSUPP;

It is broken to update the return type and value of a function in one
patch, and check for the updated return value in another patch.

> =20
>  	/* Now detect if the HW actually applied the role or not. If the HW
>  	 * applied the role it means that the SW will not to do those operation=
s
> @@ -657,7 +657,7 @@ int br_mrp_set_ring_role(struct net_bridge *br,
>  	 * SW when ring is open, but if the is not pushed to the HW the SW will
>  	 * need to detect when the ring is open
>  	 */
> -	mrp->ring_role_offloaded =3D err =3D=3D -EOPNOTSUPP ? 0 : 1;
> +	mrp->ring_role_offloaded =3D support =3D=3D BR_MRP_SW ? 0 : 1;
> =20
>  	return 0;
>  }=
