Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=qURyynMi/HgXpmSfLyUFNqbqAu/l3MGX7Mv0yI+XyPQ=;
 b=Ep3QG/4ZU24+B32NtMclXeYMmGtv/CULxCL1Xcm8LpSfsHlwc1RTO4xFbc2BtrbqRI
 wDXQD3JBhvqiFguK4cLM0aMfivTA8qyy0+Hnf+PP/zfio3r48S7rMkJeCF35l9tWeIJ9
 mYwxrsKxnteK0lvvQUrJlMPI0Sk2yD/jrwglf9Wv3ZEk+QCLUDHd7m8QPxYd726BqHi7
 8KYmUHMI7xBVqF/1QJPn4zifeyxo/cOQYMIPV9na6+SiN3Wo5GEnLYo9GjPtjmuA9BvE
 Uzuiej//fqAXgRzjnqLsRzkRu3JqXTga+bPwZPb7aSJRoNSMim0pbBcv3PeymH4LOt94
 ClqQ==
Date: Fri, 4 Mar 2022 00:29:42 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220303222942.dkz7bfuagkv7hbpp@skbuf>
References: <20220301100321.951175-1-tobias@waldekranz.com>
 <20220301100321.951175-7-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301100321.951175-7-tobias@waldekranz.com>
Subject: Re: [Bridge] [PATCH v2 net-next 06/10] net: dsa: Pass VLAN MSTI
 migration notifications to driver
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Matt Johnston <matt@codeconstruct.com.au>, davem@davemloft.net, linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 11:03:17AM +0100, Tobias Waldekranz wrote:
> Add the usual trampoline functionality from the generic DSA layer down
> to the drivers for VLAN MSTI migrations.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---
>  include/net/dsa.h  |  3 +++
>  net/dsa/dsa_priv.h |  1 +
>  net/dsa/port.c     | 10 ++++++++++
>  net/dsa/slave.c    |  6 ++++++
>  4 files changed, 20 insertions(+)
> 
> diff --git a/include/net/dsa.h b/include/net/dsa.h
> index cfedcfb86350..cc8acb01bd9b 100644
> --- a/include/net/dsa.h
> +++ b/include/net/dsa.h
> @@ -962,6 +962,9 @@ struct dsa_switch_ops {
>  				 struct netlink_ext_ack *extack);
>  	int	(*port_vlan_del)(struct dsa_switch *ds, int port,
>  				 const struct switchdev_obj_port_vlan *vlan);
> +	int	(*vlan_msti_set)(struct dsa_switch *ds,
> +				 const struct switchdev_attr *attr);

I would rather pass the struct switchdev_vlan_attr and the orig_dev
(bridge) as separate arguments here. Or even the struct dsa_bridge, for
consistency to the API changes for database isolation.

> +
>  	/*
>  	 * Forwarding database
>  	 */
> diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
> index 07c0ad52395a..87ec0697e92e 100644
> --- a/net/dsa/dsa_priv.h
> +++ b/net/dsa/dsa_priv.h
> @@ -217,6 +217,7 @@ int dsa_port_vlan_filtering(struct dsa_port *dp, bool vlan_filtering,
>  			    struct netlink_ext_ack *extack);
>  bool dsa_port_skip_vlan_configuration(struct dsa_port *dp);
>  int dsa_port_ageing_time(struct dsa_port *dp, clock_t ageing_clock);
> +int dsa_port_vlan_msti(struct dsa_port *dp, const struct switchdev_attr *attr);
>  int dsa_port_mtu_change(struct dsa_port *dp, int new_mtu,
>  			bool targeted_match);
>  int dsa_port_fdb_add(struct dsa_port *dp, const unsigned char *addr,
> diff --git a/net/dsa/port.c b/net/dsa/port.c
> index d9da425a17fb..5f45cb7d70ba 100644
> --- a/net/dsa/port.c
> +++ b/net/dsa/port.c
> @@ -778,6 +778,16 @@ int dsa_port_bridge_flags(struct dsa_port *dp,
>  	return 0;
>  }
>  
> +int dsa_port_vlan_msti(struct dsa_port *dp, const struct switchdev_attr *attr)
> +{
> +	struct dsa_switch *ds = dp->ds;
> +
> +	if (!ds->ops->vlan_msti_set)
> +		return -EOPNOTSUPP;
> +
> +	return ds->ops->vlan_msti_set(ds, attr);

I guess this doesn't need to be a cross-chip notifier event for all
switches, because replication to all bridge ports is handled by
switchdev_handle_port_attr_set(). Ok. But isn't it called too many times
per switch?

> +}
> +
>  int dsa_port_mtu_change(struct dsa_port *dp, int new_mtu,
>  			bool targeted_match)
>  {
> diff --git a/net/dsa/slave.c b/net/dsa/slave.c
> index 089616206b11..c6ffcd782b5a 100644
> --- a/net/dsa/slave.c
> +++ b/net/dsa/slave.c
> @@ -314,6 +314,12 @@ static int dsa_slave_port_attr_set(struct net_device *dev, const void *ctx,
>  
>  		ret = dsa_port_bridge_flags(dp, attr->u.brport_flags, extack);
>  		break;
> +	case SWITCHDEV_ATTR_ID_VLAN_MSTI:
> +		if (!dsa_port_offloads_bridge_dev(dp, attr->orig_dev))
> +			return -EOPNOTSUPP;
> +
> +		ret = dsa_port_vlan_msti(dp, attr);
> +		break;
>  	default:
>  		ret = -EOPNOTSUPP;
>  		break;
> -- 
> 2.25.1
> 

