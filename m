Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=VkHeawapFxvFE6350X6CQgGsPoo5+76V86NE1YTDZZY=;
 b=UCw4fcFiE2bu30hwS5e53xnmFf+zg/e3F4GQSOf+CxTd+/UU2nPZ0Lv4BfuRyw22uc
 CDod9C4FfBlOTDCB2ZUDsDPLR9UI29zIbwcxnnobpyQc2kXJiWaTdm/oSo3WFy2KTXol
 1qL7NpIrmTG+IC8MwIR3dC8yu/CLxOhBcApyJ9aIRHY4pyTYzpRRACAkcAnIpi81LY8g
 pmC74sEB878o/1vGjgLlk2EVOhfl54LAaFQNWEpUZuLTMtR92vHJb8i4ZSSXhnJaZZP/
 X9vdSHQVr5SU0CDzgCGNlu3m9L4siq0kEpBAtnbOlIirLJldET+9pt6bDAt8+GPdGv4D
 cddg==
Date: Thu, 15 Jul 2021 17:49:29 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20210715144929.oa3u44is3v6gewr5@skbuf>
References: <20210712152142.800651-1-vladimir.oltean@nxp.com>
 <20210712152142.800651-23-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712152142.800651-23-vladimir.oltean@nxp.com>
Subject: Re: [Bridge] [RFC PATCH v3 net-next 22/24] net: dsa: add support
 for bridge TX forwarding offload
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@idosch.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

On Mon, Jul 12, 2021 at 06:21:40PM +0300, Vladimir Oltean wrote:
> +static bool dsa_port_bridge_tx_fwd_prepare(struct dsa_port *dp,
> +					   struct net_device *bridge_dev)
> +{
> +	struct dsa_switch *ds = dp->ds;
> +	struct dsa_switch_tree *dst;
> +	int bridge_num, err;
> +
> +	dst = ds->dst;
> +
> +	bridge_num = dsa_tree_find_bridge_num(dst, bridge_dev);
> +	if (bridge_num < 0) {
> +		/* First port that offloads TX forwarding for this bridge */
> +		int bridge_num;

Stupid bug: "bridge_num" is redeclared here as a different variable with
a different scope, shadowing the one from dsa_port_bridge_tx_fwd_prepare().

> +
> +		bridge_num = find_first_zero_bit(&dst->fwd_offloading_bridges,
> +						 DSA_MAX_NUM_OFFLOADING_BRIDGES);
> +		if (bridge_num >= ds->num_fwd_offloading_bridges)
> +			return false;
> +
> +		set_bit(bridge_num, &dst->fwd_offloading_bridges);
> +	}
> +
> +	dp->bridge_num = bridge_num;

and then here, the scope from the "if" block is lost, so the bridge_num
variable is still -1. So dp->bridge_num remains -1.

Deleting the "int bridge_num" declaration from the "if" block fixes the
issue. This got introduced between v2 and v3.

> +
> +	/* Notify the driver */
> +	err = dsa_port_bridge_fwd_offload_add(dp, bridge_dev, bridge_num);
> +	if (err) {
> +		dsa_port_bridge_tx_fwd_unprepare(dp, bridge_dev);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
>  int dsa_port_bridge_join(struct dsa_port *dp, struct net_device *br,
>  			 struct netlink_ext_ack *extack)
>  {
> @@ -241,6 +310,7 @@ int dsa_port_bridge_join(struct dsa_port *dp, struct net_device *br,
>  	};
>  	struct net_device *dev = dp->slave;
>  	struct net_device *brport_dev;
> +	bool tx_fwd_offload;
>  	int err;
>  
>  	/* Here the interface is already bridged. Reflect the current
> @@ -254,7 +324,10 @@ int dsa_port_bridge_join(struct dsa_port *dp, struct net_device *br,
>  	if (err)
>  		goto out_rollback;
>  
> -	err = switchdev_bridge_port_offload(brport_dev, dev, dp, false, extack);
> +	tx_fwd_offload = dsa_port_bridge_tx_fwd_prepare(dp, br);
> +
> +	err = switchdev_bridge_port_offload(brport_dev, dev, dp, tx_fwd_offload,
> +					    extack);
>  	if (err)
>  		goto out_rollback_unbridge;
>  
> @@ -279,6 +352,8 @@ int dsa_port_pre_bridge_leave(struct dsa_port *dp, struct net_device *br,
>  	struct net_device *brport_dev = dsa_port_to_bridge_port(dp);
>  	struct net_device *dev = dp->slave;
>  
> +	dsa_port_bridge_tx_fwd_prepare(dp, br);

We are in the pre_bridge_leave path, this should have been _unprepare.

> +
>  	return switchdev_bridge_port_unoffload(brport_dev, dev, dp, extack);
>  }

The patches should work otherwise, if somebody wants to test they should
make these changes.

There are also some more changes that need to be made to mlxsw to
properly handle the unoffload of bridge ports that are LAG devices and
VLAN devices. I have them in my tree now. When net-next reopens I will
first send a series of 7 refactoring patches for dpaa2-switch, mlxsw and
prestera, and then the TX data plane offload in DSA as a 15-patch series.
