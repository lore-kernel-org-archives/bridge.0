Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KLMQTuObJSA9QIMaMCef6bB2Ga2f3nOrogAh5nYxOM=;
 b=dNBdZ9B0nRtd9SVbr3QYMwf+MipFUcG+jwb0P1EHfugoBDzfO0CfQO1rUbdJ+8uWpvFh+pzibm2poQbnc2DNe3PIaCMCxoRwo15hCmajSwpMbVcgfEZo3cLOFrkYLdJianeqGYa2PNd9EULKmM+GRZPEt43rRbZH4VJcvSZOpiY=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Wed, 17 Feb 2021 10:56:25 +0000
Message-ID: <20210217105624.aehyxw3tfs5uycdl@skbuf>
References: <20210216214205.32385-1-horatiu.vultur@microchip.com>
 <20210216214205.32385-5-horatiu.vultur@microchip.com>
In-Reply-To: <20210216214205.32385-5-horatiu.vultur@microchip.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3B1C35D6AD07A842808B7267A18006C1@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v4 4/8] bridge: mrp: Extend
 br_mrp_switchdev to detect better the errors
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

On Tue, Feb 16, 2021 at 10:42:01PM +0100, Horatiu Vultur wrote:
> This patch extends the br_mrp_switchdev functions to be able to have a
> better understanding what cause the issue and if the SW needs to be used
> as a backup.
>=20
> There are the following cases:
> - when the code is compiled without CONFIG_NET_SWITCHDEV. In this case
>   return success so the SW can continue with the protocol. Depending
>   on the function, it returns 0 or BR_MRP_SW.
> - when code is compiled with CONFIG_NET_SWITCHDEV and the driver doesn't
>   implement any MRP callbacks. In this case the HW can't run MRP so it
>   just returns -EOPNOTSUPP. So the SW will stop further to configure the
>   node.
> - when code is compiled with CONFIG_NET_SWITCHDEV and the driver fully
>   supports any MRP functionality. In this case the SW doesn't need to do
>   anything. The functions will return 0 or BR_MRP_HW.
> - when code is compiled with CONFIG_NET_SWITCHDEV and the HW can't run
>   completely the protocol but it can help the SW to run it. For
>   example, the HW can't support completely MRM role(can't detect when it
>   stops receiving MRP Test frames) but it can redirect these frames to
>   CPU. In this case it is possible to have a SW fallback. The SW will
>   try initially to call the driver with sw_backup set to false, meaning
>   that the HW should implement completely the role. If the driver returns
>   -EOPNOTSUPP, the SW will try again with sw_backup set to false,
>   meaning that the SW will detect when it stops receiving the frames but
>   it needs HW support to redirect the frames to CPU. In case the driver
>   returns 0 then the SW will continue to configure the node accordingly.
>=20
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  net/bridge/br_mrp_switchdev.c | 171 +++++++++++++++++++++-------------
>  net/bridge/br_private_mrp.h   |  24 +++--
>  2 files changed, 118 insertions(+), 77 deletions(-)
>=20
> diff --git a/net/bridge/br_mrp_switchdev.c b/net/bridge/br_mrp_switchdev.=
c
> index 3c9a4abcf4ee..cb54b324fa8c 100644
> --- a/net/bridge/br_mrp_switchdev.c
> +++ b/net/bridge/br_mrp_switchdev.c
> @@ -4,6 +4,30 @@
> =20
>  #include "br_private_mrp.h"
> =20
> +static enum br_mrp_hw_support
> +br_mrp_switchdev_port_obj(struct net_bridge *br,
> +			  const struct switchdev_obj *obj, bool add)
> +{
> +	int err;
> +

Looks like you could have added this check here and simplified all the
callers:

	if (!IS_ENABLED(CONFIG_NET_SWITCHDEV))
		return BR_MRP_SW;

> +	if (add)
> +		err =3D switchdev_port_obj_add(br->dev, obj, NULL);
> +	else
> +		err =3D switchdev_port_obj_del(br->dev, obj);
> +
> +	/* In case of success just return and notify the SW that doesn't need
> +	 * to do anything
> +	 */
> +	if (!err)
> +		return BR_MRP_HW;
> +
> +	if (err !=3D -EOPNOTSUPP)
> +		return BR_MRP_NONE;
> +
> +	/* Continue with SW backup */
> +	return BR_MRP_SW;
> +}
> +=
