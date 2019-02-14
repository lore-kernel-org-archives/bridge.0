Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=wAY+bonFh6ivtbjOPXMXkuk9C2B287LoDQOniKarWDc=;
	b=Ga6d2gkQyCRVVGcVe5Qt9xzX1iGxo+InUynduIGAWft9XjshKx9aI0ZNIU5LtrmldPMlEf6/JzIc+6ebR4tO4rdHG7QTKEt0VqYP61CWt3l2FZtUDE11wA+bG1htfJFv7CEEUsZ7mGlP84sAauMkyKwHri5SKKaxq25huDhCerY=
From: Ido Schimmel <idosch@mellanox.com>
Date: Thu, 14 Feb 2019 13:11:46 +0000
Message-ID: <20190214131143.GA12064@splinter>
References: <20190213220638.1552-1-f.fainelli@gmail.com>
	<20190213220638.1552-4-f.fainelli@gmail.com>
In-Reply-To: <20190213220638.1552-4-f.fainelli@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BB8CC15313445A4F83537A62675CD75F@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next 3/9] mlxsw: spectrum: Check bridge
 flags during prepare phase
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

On Wed, Feb 13, 2019 at 02:06:32PM -0800, Florian Fainelli wrote:
> In preparation for getting rid of switchdev_port_attr_get(), have mlxsw
> check for the bridge flags being set through switchdev_port_attr_set()
> when the SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS attribute identifier is
> used.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/d=
rivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
> index 1f492b7dbea8..7616eab50035 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
> @@ -598,13 +598,17 @@ mlxsw_sp_bridge_port_learning_set(struct mlxsw_sp_p=
ort *mlxsw_sp_port,
>  static int mlxsw_sp_port_attr_br_flags_set(struct mlxsw_sp_port *mlxsw_s=
p_port,
>  					   struct switchdev_trans *trans,
>  					   struct net_device *orig_dev,
> -					   unsigned long brport_flags)
> +					   unsigned long brport_flags,
> +					   bool pre_set)
>  {
>  	struct mlxsw_sp_bridge_port *bridge_port;
>  	int err;
> =20
> -	if (switchdev_trans_ph_prepare(trans))
> +	if (switchdev_trans_ph_prepare(trans) && pre_set) {
> +		if (brport_flags & ~(BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD))
> +			return -EOPNOTSUPP;
>  		return 0;
> +	}

When we get SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS we only want to
perform a check. With this code in case it's not prepare phase, then we
continue to set the flags. Better do:

if (pre_set) {
	if (switchdev_trans_ph_commit(trans))
		return 0;
	// perform check here
}

> =20
>  	bridge_port =3D mlxsw_sp_bridge_port_find(mlxsw_sp_port->mlxsw_sp->brid=
ge,
>  						orig_dev);
> @@ -833,6 +837,7 @@ static int mlxsw_sp_port_attr_set(struct net_device *=
dev,
>  				  struct switchdev_trans *trans)
>  {
>  	struct mlxsw_sp_port *mlxsw_sp_port =3D netdev_priv(dev);
> +	bool pre_set =3D false;
>  	int err;
> =20
>  	switch (attr->id) {
> @@ -841,10 +846,13 @@ static int mlxsw_sp_port_attr_set(struct net_device=
 *dev,
>  						       attr->orig_dev,
>  						       attr->u.stp_state);
>  		break;
> +	case SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS:
> +		pre_set =3D true;	/* fall through */
>  	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
>  		err =3D mlxsw_sp_port_attr_br_flags_set(mlxsw_sp_port, trans,
>  						      attr->orig_dev,
> -						      attr->u.brport_flags);
> +						      attr->u.brport_flags,
> +						      pre_set);
>  		break;
>  	case SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME:
>  		err =3D mlxsw_sp_port_attr_br_ageing_set(mlxsw_sp_port, trans,
> --=20
> 2.17.1
>=20
