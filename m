Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=AVB05HmwQe3R7xLi8x+oCjTXlaH8QPcP+BBhzZ/wLIc=;
	b=Y9HCfYbq4rlQoN8lH55Ggsnm9hJGOX6qprySGoiG3+wSogdXLCBlvqr3I3i1xARnhlfGCZKFNm0gTTO8xD5StGwV5b+hwGhkG7UZtAoPjTJlYTLogfzaLv/Fu66He3daPnGAcCL1z60YYKxLP0Fi6MA9Dhf5DhmUBt1XuoQXXQA=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 27 Feb 2019 13:13:14 +0000
Message-ID: <20190227131312.GA17964@splinter>
References: <20190227011427.16487-1-f.fainelli@gmail.com>
	<20190227011427.16487-9-f.fainelli@gmail.com>
In-Reply-To: <20190227011427.16487-9-f.fainelli@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5E39FCBBC94A814BA95AFE2C74F3D4CF@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v2 8/8] net: Remove switchdev_ops
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

On Tue, Feb 26, 2019 at 05:14:27PM -0800, Florian Fainelli wrote:
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net=
/ethernet/mellanox/mlxsw/spectrum.c
> index b00f6f74f91a..995426ea9a43 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
> @@ -3660,7 +3660,6 @@ static int mlxsw_sp_port_create(struct mlxsw_sp *ml=
xsw_sp, u8 local_port,
>  	}
>  	mlxsw_sp_port->default_vlan =3D mlxsw_sp_port_vlan;
> =20
> -	mlxsw_sp_port_switchdev_init(mlxsw_sp_port);
>  	mlxsw_sp->ports[local_port] =3D mlxsw_sp_port;
>  	err =3D register_netdev(dev);
>  	if (err) {
> @@ -3677,7 +3676,6 @@ static int mlxsw_sp_port_create(struct mlxsw_sp *ml=
xsw_sp, u8 local_port,
> =20
>  err_register_netdev:
>  	mlxsw_sp->ports[local_port] =3D NULL;
> -	mlxsw_sp_port_switchdev_fini(mlxsw_sp_port);
>  	mlxsw_sp_port_vlan_destroy(mlxsw_sp_port_vlan);
>  err_port_vlan_create:
>  err_port_pvid_set:
> @@ -3720,7 +3718,6 @@ static void mlxsw_sp_port_remove(struct mlxsw_sp *m=
lxsw_sp, u8 local_port)
>  	mlxsw_core_port_clear(mlxsw_sp->core, local_port, mlxsw_sp);
>  	unregister_netdev(mlxsw_sp_port->dev); /* This calls ndo_stop */
>  	mlxsw_sp->ports[local_port] =3D NULL;
> -	mlxsw_sp_port_switchdev_fini(mlxsw_sp_port);
>  	mlxsw_sp_port_vlan_flush(mlxsw_sp_port, true);
>  	mlxsw_sp_port_nve_fini(mlxsw_sp_port);
>  	mlxsw_sp_tc_qdisc_fini(mlxsw_sp_port);
> @@ -4441,12 +4438,6 @@ static int mlxsw_sp_init(struct mlxsw_core *mlxsw_=
core,
>  		goto err_span_init;
>  	}
> =20
> -	err =3D mlxsw_sp_switchdev_init(mlxsw_sp);

I missed that and got a trace as soon as I tried to enslave a port. You
should only remove mlxsw_sp_port_switchdev_init() and not
mlxsw_sp_switchdev_init()

> -	if (err) {
> -		dev_err(mlxsw_sp->bus_info->dev, "Failed to initialize switchdev\n");
> -		goto err_switchdev_init;
> -	}
> -
>  	err =3D mlxsw_sp_counter_pool_init(mlxsw_sp);
>  	if (err) {
>  		dev_err(mlxsw_sp->bus_info->dev, "Failed to init counter pool\n");
> @@ -4517,8 +4508,6 @@ static int mlxsw_sp_init(struct mlxsw_core *mlxsw_c=
ore,
>  err_afa_init:
>  	mlxsw_sp_counter_pool_fini(mlxsw_sp);
>  err_counter_pool_init:
> -	mlxsw_sp_switchdev_fini(mlxsw_sp);
> -err_switchdev_init:
>  	mlxsw_sp_span_fini(mlxsw_sp);
>  err_span_init:
>  	mlxsw_sp_lag_fini(mlxsw_sp);
> @@ -4585,7 +4574,6 @@ static void mlxsw_sp_fini(struct mlxsw_core *mlxsw_=
core)
>  	mlxsw_sp_nve_fini(mlxsw_sp);
>  	mlxsw_sp_afa_fini(mlxsw_sp);
>  	mlxsw_sp_counter_pool_fini(mlxsw_sp);
> -	mlxsw_sp_switchdev_fini(mlxsw_sp);
>  	mlxsw_sp_span_fini(mlxsw_sp);
>  	mlxsw_sp_lag_fini(mlxsw_sp);
>  	mlxsw_sp_buffers_fini(mlxsw_sp);
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net=
/ethernet/mellanox/mlxsw/spectrum.h
> index a61c1130d9e3..da6278b0caa4 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
> @@ -407,8 +407,6 @@ extern const struct mlxsw_sp_sb_vals mlxsw_sp2_sb_val=
s;
>  /* spectrum_switchdev.c */
>  int mlxsw_sp_switchdev_init(struct mlxsw_sp *mlxsw_sp);
>  void mlxsw_sp_switchdev_fini(struct mlxsw_sp *mlxsw_sp);
> -void mlxsw_sp_port_switchdev_init(struct mlxsw_sp_port *mlxsw_sp_port);
> -void mlxsw_sp_port_switchdev_fini(struct mlxsw_sp_port *mlxsw_sp_port);
>  int mlxsw_sp_rif_fdb_op(struct mlxsw_sp *mlxsw_sp, const char *mac, u16 =
fid,
>  			bool adding);
>  void
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/d=
rivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
> index c1aedfea3a31..f6ce386c3036 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
> @@ -1938,10 +1938,6 @@ static struct mlxsw_sp_port *mlxsw_sp_lag_rep_port=
(struct mlxsw_sp *mlxsw_sp,
>  	return NULL;
>  }
> =20
> -static const struct switchdev_ops mlxsw_sp_port_switchdev_ops =3D {
> -	.switchdev_port_attr_set	=3D mlxsw_sp_port_attr_set,
> -};
> -
>  static int
>  mlxsw_sp_bridge_8021q_port_join(struct mlxsw_sp_bridge_device *bridge_de=
vice,
>  				struct mlxsw_sp_bridge_port *bridge_port,
> @@ -3545,11 +3541,3 @@ void mlxsw_sp_switchdev_fini(struct mlxsw_sp *mlxs=
w_sp)
>  	kfree(mlxsw_sp->bridge);
>  }
> =20
> -void mlxsw_sp_port_switchdev_init(struct mlxsw_sp_port *mlxsw_sp_port)
> -{
> -	mlxsw_sp_port->dev->switchdev_ops =3D &mlxsw_sp_port_switchdev_ops;
> -}
> -
> -void mlxsw_sp_port_switchdev_fini(struct mlxsw_sp_port *mlxsw_sp_port)
> -{
> -}
