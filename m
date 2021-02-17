Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgYq+W/f18gklNVQ6Bb3hF2UicLJIt0+ZfKeoXIr6YQ=;
 b=bZkedfRa+VjHRFa/gG/aHP2jPyiGhwj6LDlBUuanSuzR40gWZEJMn3RcimO7SU+pN91kQoVee+CdBi4hl2xn/M/7yxVZy9ZrCZj9EwVTbF3JcPRcP5Ar4csOnL1aoH7c0DUsubJl85w2hFeNOyIObYjUlA6K6Q/dgi7jo1wJR1s=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Wed, 17 Feb 2021 10:34:35 +0000
Message-ID: <20210217103433.bilnuo2tfvgvjmxy@skbuf>
References: <20210216214205.32385-1-horatiu.vultur@microchip.com>
 <20210216214205.32385-3-horatiu.vultur@microchip.com>
In-Reply-To: <20210216214205.32385-3-horatiu.vultur@microchip.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CFC55FEA90267D4AA2BEFAB1247F9073@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v4 2/8] switchdev: mrp: Extend
 ring_role_mrp and in_role_mrp
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

On Tue, Feb 16, 2021 at 10:41:59PM +0100, Horatiu Vultur wrote:
> Add the member sw_backup to the structures switchdev_obj_ring_role_mrp
> and switchdev_obj_in_role_mrp. In this way the SW can call the driver in
> 2 ways, once when sw_backup is set to false, meaning that the driver
> should implement this completely in HW. And if that is not supported the
> SW will call again but with sw_backup set to true, meaning that the
> HW should help or allow the SW to run the protocol.
>=20
> For example when role is MRM, if the HW can't detect when it stops
> receiving MRP Test frames but it can trap these frames to CPU, then it
> needs to return -EOPNOTSUPP when sw_backup is false and return 0 when
> sw_backup is true.
>=20
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  include/net/switchdev.h | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/include/net/switchdev.h b/include/net/switchdev.h
> index 465362d9d063..b7fc7d0f54e2 100644
> --- a/include/net/switchdev.h
> +++ b/include/net/switchdev.h
> @@ -127,6 +127,7 @@ struct switchdev_obj_ring_role_mrp {
>  	struct switchdev_obj obj;
>  	u8 ring_role;
>  	u32 ring_id;
> +	u8 sw_backup;
>  };
> =20
>  #define SWITCHDEV_OBJ_RING_ROLE_MRP(OBJ) \
> @@ -161,6 +162,7 @@ struct switchdev_obj_in_role_mrp {
>  	u32 ring_id;
>  	u16 in_id;
>  	u8 in_role;
> +	u8 sw_backup;

What was wrong with 'bool'?

>  };
> =20
>  #define SWITCHDEV_OBJ_IN_ROLE_MRP(OBJ) \
> --=20
> 2.27.0
>=20

If a driver implements full MRP offload for a ring/interconnect
manager/automanager, should it return -EOPNOTSUPP when sw_backup=3Dfalse?=
