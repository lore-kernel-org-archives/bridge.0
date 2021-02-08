Return-Path: <ioana.ciornei@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exkoNkB4sKnYOGWCAq/KbIKLo3oZIEKBU8fvAi6+BCY=;
 b=ZcosWDECG0AWYnXOaSvHD4PxxeWXgN7gqd1wwfQRufp1aFxSWN75mNao95M5cSDsdZr/A1QPvcOhxFYzxEnu//YNSEgFZ46eUwsbReUVbVgK/1vzDJCcRzmmodTLm47tnV1r5HZcxvs0Lspb9oDoccDQWtEiriYKi0rSj7Zvu94=
From: Ioana Ciornei <ioana.ciornei@nxp.com>
Date: Mon, 8 Feb 2021 16:04:20 +0000
Message-ID: <20210208160418.pen47yf3xhtzuwkb@skbuf>
References: <20210207232141.2142678-1-olteanv@gmail.com>
 <20210207232141.2142678-6-olteanv@gmail.com>
In-Reply-To: <20210207232141.2142678-6-olteanv@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EBBD033502BAE849A5733453869BC577@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next 5/9] net: squash switchdev attributes
 PRE_BRIDGE_FLAGS and BRIDGE_FLAGS
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Vadym Kochan <vkochan@marvell.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>, Taras Chornyi <tchornyi@marvell.com>, Ido Schimmel <idosch@idosch.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>, "David S. Miller" <davem@davemloft.net>

On Mon, Feb 08, 2021 at 01:21:37AM +0200, Vladimir Oltean wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
>=20
> There does not appear to be any strong reason why
> br_switchdev_set_port_flag issues a separate notification for checking
> the supported brport flags rather than just attempting to apply them and
> propagating the error if that fails.
>=20
> However, there is a reason why this switchdev API is counterproductive
> for a driver writer, and that is because although br_switchdev_set_port_f=
lag
> gets passed a "flags" and a "mask", those are passed piecemeal to the
> driver, so while the PRE_BRIDGE_FLAGS listener knows what changed
> because it has the "mask", the BRIDGE_FLAGS listener doesn't, because it
> only has the final value. This means that "edge detection" needs to be
> done by each individual BRIDGE_FLAGS listener by XOR-ing the old and the
> new flags, which in turn means that copying the flags into a driver
> private variable is strictly necessary.
>=20
> This can be solved by passing the "flags" and the "value" together into
> a single switchdev attribute, and it also reduces some boilerplate in
> the drivers that offload this.
>=20
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/net/dsa/b53/b53_common.c              | 16 ++++-------
>  drivers/net/dsa/mv88e6xxx/chip.c              | 17 ++++-------
>  .../marvell/prestera/prestera_switchdev.c     | 16 +++++------
>  .../mellanox/mlxsw/spectrum_switchdev.c       | 28 ++++++-------------
>  drivers/net/ethernet/rocker/rocker_main.c     | 24 +++-------------
>  drivers/net/ethernet/ti/cpsw_switchdev.c      | 20 ++++---------
>  drivers/staging/fsl-dpaa2/ethsw/ethsw.c       | 22 ++++-----------
>  include/net/dsa.h                             |  4 +--
>  include/net/switchdev.h                       |  8 ++++--
>  net/bridge/br_switchdev.c                     | 19 ++++---------
>  net/dsa/dsa_priv.h                            |  4 +--
>  net/dsa/port.c                                | 15 ++--------
>  net/dsa/slave.c                               |  3 --
>  13 files changed, 58 insertions(+), 138 deletions(-)
>=20

(..)

> --- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
> +++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
> @@ -908,28 +908,22 @@ static int dpaa2_switch_port_attr_stp_state_set(str=
uct net_device *netdev,
>  	return dpaa2_switch_port_set_stp_state(port_priv, state);
>  }
> =20
> -static int dpaa2_switch_port_attr_br_flags_pre_set(struct net_device *ne=
tdev,
> -						   unsigned long flags)
> -{
> -	if (flags & ~(BR_LEARNING | BR_FLOOD))
> -		return -EINVAL;
> -
> -	return 0;
> -}
> -
>  static int dpaa2_switch_port_attr_br_flags_set(struct net_device *netdev=
,
> -					       unsigned long flags)
> +					       struct switchdev_brport_flags val)
>  {
>  	struct ethsw_port_priv *port_priv =3D netdev_priv(netdev);
>  	int err =3D 0;
> =20
> +	if (val.mask & ~(BR_LEARNING | BR_FLOOD))
> +		return -EINVAL;
> +
>  	/* Learning is enabled per switch */
>  	err =3D dpaa2_switch_set_learning(port_priv->ethsw_data,
> -					!!(flags & BR_LEARNING));
> +					!!(val.flags & BR_LEARNING));
>  	if (err)
>  		goto exit;
> =20
> -	err =3D dpaa2_switch_port_set_flood(port_priv, !!(flags & BR_FLOOD));
> +	err =3D dpaa2_switch_port_set_flood(port_priv, !!(val.flags & BR_FLOOD)=
);


Could you also check the mask to see if the flag needs to be actually chang=
ed?

> --- a/include/net/dsa.h
> +++ b/include/net/dsa.h
> @@ -621,10 +621,8 @@ struct dsa_switch_ops {
>  	void	(*port_stp_state_set)(struct dsa_switch *ds, int port,
>  				      u8 state);
>  	void	(*port_fast_age)(struct dsa_switch *ds, int port);
> -	int	(*port_pre_bridge_flags)(struct dsa_switch *ds, int port,
> -					 unsigned long mask);
>  	int	(*port_bridge_flags)(struct dsa_switch *ds, int port,
> -				     unsigned long flags);
> +				     struct switchdev_brport_flags val);
>  	int	(*port_set_mrouter)(struct dsa_switch *ds, int port,
>  				    bool mrouter);
> =20

In the previous patch you add the .port_pre_bridge_flags()
dsa_switch_ops only to remove it here. Couldn't these two patches be in
reverse order so that there is no need to actually add the callback in
the first place?

Ioana=
