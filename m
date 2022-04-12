Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=0I4B/XmBZ0J0+KCFpKsvKUIAVo+1Rq3rKSI2L+PakG8=;
 b=DDZQbk5T5ql0/W3nkHkf2d+GTy4eAoTBHfDsI23Lmou7j7WGazvlpFzvkJ6e+TOnmH
 7TvDhLDoyPmwyn/lb+b1/Te72O8GWh3fpqlo9Is2903pVqbvUfh+tn1lH++QtmDx35JQ
 EqnqQqeUNBHRIYAEPPGi/8T7lw8woq/41JEc1XPzU0Ye+Rf8z0eim03VIpBE8wyOqV8g
 sjKW44fx8bHQjqPLezxJs4sBFM44RqodzIqnVQ9TbWli9Ykmk5zpDcJnTMEcYf7rZPb2
 tcUl0F+bdNBkvc/zLXkoR1q99XwpbtzqAkL4O3QfcwOfyFhG2tjvUMAR8JG6u9s7jqe0
 vYdA==
Message-ID: <37bb2846-6371-1e49-9a7e-7c27a7a8b9c4@blackwall.org>
Date: Tue, 12 Apr 2022 21:24:16 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20220411133837.318876-1-troglobit@gmail.com>
 <20220411133837.318876-5-troglobit@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20220411133837.318876-5-troglobit@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH RFC net-next 04/13] net: bridge: netlink
 support for controlling BUM flooding to bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joachim Wiberg <troglobit@gmail.com>, Roopa Prabhu <roopa@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Vladimir Oltean <vladimir.oltean@nxp.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

On 11/04/2022 16:38, Joachim Wiberg wrote:
> This patch adds netlink support for controlling the new broadcast,
> unicast, and multicast flooding flags to the bridge itself.
> 
> The messy part is in br_setport(), which re-indents a large block of
> code for the port settings.  To reduce code duplication a few new
> variables have been added; new_flags and dev.  The latter is used for
> the recently renamed br_switchdev_set_dev_flag(), which can now be used
> by underlying switching fabric drivers as another source of information
> when controlling flooding of unknown BUM traffic to the CPU port.
> 
> Signed-off-by: Joachim Wiberg <troglobit@gmail.com>
> ---

Absolutely not. This is just wrong on a few levels and way too hacky.

Please separate the bridge handling altogether and make it clean.
No need to integrate it with the port handling, also I think you've missed
a few things about bool options, more below...

For boolopts examples you can check BR_BOOLOPT_NO_LL_LEARN,
BR_BOOLOPT_MCAST_VLAN_SNOOPING and BR_BOOLOPT_MST_ENABLE.

>  net/bridge/br_netlink.c | 160 ++++++++++++++++++++++++++++++----------
>  1 file changed, 123 insertions(+), 37 deletions(-)
> 
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 8f4297287b32..68bbf703b31a 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -225,13 +225,29 @@ static inline size_t br_nlmsg_size(struct net_device *dev, u32 filter_mask)
>  		+ nla_total_size(4); /* IFLA_BRPORT_BACKUP_PORT */
>  }
>  
> -static int br_port_fill_attrs(struct sk_buff *skb,
> +static int br_port_fill_attrs(struct sk_buff *skb, const struct net_bridge *br,
>  			      const struct net_bridge_port *p)
>  {
> -	u8 mode = !!(p->flags & BR_HAIRPIN_MODE);
>  	struct net_bridge_port *backup_p;
>  	u64 timerval;
> +	u8 mode;
>  
> +	if (!p) {
> +		if (!br)
> +			return -EINVAL;
> +
> +		if (nla_put_u8(skb, IFLA_BRPORT_UNICAST_FLOOD,
> +			       br_opt_get(br, BROPT_UNICAST_FLOOD)) ||
> +		    nla_put_u8(skb, IFLA_BRPORT_MCAST_FLOOD,
> +			       br_opt_get(br, BROPT_MCAST_FLOOD)) ||
> +		    nla_put_u8(skb, IFLA_BRPORT_BCAST_FLOOD,
> +			       br_opt_get(br, BROPT_BCAST_FLOOD)))
> +			return -EMSGSIZE;

No. Bool opts are already exposed through IFLA_BR_MULTI_BOOLOPT.

> +
> +		return 0;
> +	}
> +
> +	mode = !!(p->flags & BR_HAIRPIN_MODE);
>  	if (nla_put_u8(skb, IFLA_BRPORT_STATE, p->state) ||
>  	    nla_put_u16(skb, IFLA_BRPORT_PRIORITY, p->priority) ||
>  	    nla_put_u32(skb, IFLA_BRPORT_COST, p->path_cost) ||
> @@ -475,11 +491,11 @@ static int br_fill_ifinfo(struct sk_buff *skb,
>  	     nla_put_u32(skb, IFLA_LINK, dev_get_iflink(dev))))
>  		goto nla_put_failure;
>  
> -	if (event == RTM_NEWLINK && port) {
> +	if (event == RTM_NEWLINK) {
>  		struct nlattr *nest;
>  
>  		nest = nla_nest_start(skb, IFLA_PROTINFO);
> -		if (nest == NULL || br_port_fill_attrs(skb, port) < 0)
> +		if (!nest || br_port_fill_attrs(skb, br, port) < 0)
>  			goto nla_put_failure;
>  		nla_nest_end(skb, nest);
>  	}
> @@ -911,43 +927,113 @@ static void br_set_port_flag(struct net_bridge_port *p, struct nlattr *tb[],
>  		p->flags &= ~mask;
>  }
>  
> +/* Map bridge options to brport flags */
> +static unsigned long br_boolopt_map_flags(struct br_boolopt_multi *bm)
> +{
> +	unsigned long bitmap = bm->optmask;
> +	unsigned long bitmask = 0;
> +	int opt_id;
> +
> +	for_each_set_bit(opt_id, &bitmap, BR_BOOLOPT_MAX) {
> +		if (!(bm->optval & BIT(opt_id)))
> +			continue;
> +
> +		switch (opt_id) {
> +		case BROPT_UNICAST_FLOOD:
> +			bitmask |= BR_FLOOD;
> +			break;
> +		case BROPT_MCAST_FLOOD:
> +			bitmask |= BR_MCAST_FLOOD;
> +			break;
> +		case BROPT_BCAST_FLOOD:
> +			bitmask |= BR_BCAST_FLOOD;
> +			break;
> +		}
> +	}
> +
> +	return bitmask;
> +}
> +
> +static void br_set_bropt(struct net_bridge *br, struct nlattr *tb[],
> +			 int attrtype, enum net_bridge_opts opt)
> +{
> +	if (!tb[attrtype])
> +		return;
> +
> +	br_opt_toggle(br, opt, !!nla_get_u8(tb[attrtype]));
> +}

These must be controlled via the boolopt api and attributes, not through
additional nl attributes.

> +
> +#define BROPT_MASK (BROPT_UNICAST_FLOOD | BROPT_MCAST_FLOOD | BROPT_MCAST_FLOOD)
> +
>  /* Process bridge protocol info on port */
> -static int br_setport(struct net_bridge_port *p, struct nlattr *tb[],
> -		      struct netlink_ext_ack *extack)
> +static int br_setport(struct net_bridge *br, struct net_bridge_port *p,
> +		      struct nlattr *tb[], struct netlink_ext_ack *extack)
>  {
> -	unsigned long old_flags, changed_mask;
> +	unsigned long old_flags, new_flags, changed_mask;
> +	struct br_boolopt_multi old_opts = {
> +		.optmask = BROPT_MASK
> +	};
>  	bool br_vlan_tunnel_old;
> +	struct net_device *dev;
>  	int err;
>  
> -	old_flags = p->flags;
> -	br_vlan_tunnel_old = (old_flags & BR_VLAN_TUNNEL) ? true : false;
> -
> -	br_set_port_flag(p, tb, IFLA_BRPORT_MODE, BR_HAIRPIN_MODE);
> -	br_set_port_flag(p, tb, IFLA_BRPORT_GUARD, BR_BPDU_GUARD);
> -	br_set_port_flag(p, tb, IFLA_BRPORT_FAST_LEAVE,
> -			 BR_MULTICAST_FAST_LEAVE);
> -	br_set_port_flag(p, tb, IFLA_BRPORT_PROTECT, BR_ROOT_BLOCK);
> -	br_set_port_flag(p, tb, IFLA_BRPORT_LEARNING, BR_LEARNING);
> -	br_set_port_flag(p, tb, IFLA_BRPORT_UNICAST_FLOOD, BR_FLOOD);
> -	br_set_port_flag(p, tb, IFLA_BRPORT_MCAST_FLOOD, BR_MCAST_FLOOD);
> -	br_set_port_flag(p, tb, IFLA_BRPORT_MCAST_TO_UCAST,
> -			 BR_MULTICAST_TO_UNICAST);
> -	br_set_port_flag(p, tb, IFLA_BRPORT_BCAST_FLOOD, BR_BCAST_FLOOD);
> -	br_set_port_flag(p, tb, IFLA_BRPORT_PROXYARP, BR_PROXYARP);
> -	br_set_port_flag(p, tb, IFLA_BRPORT_PROXYARP_WIFI, BR_PROXYARP_WIFI);
> -	br_set_port_flag(p, tb, IFLA_BRPORT_VLAN_TUNNEL, BR_VLAN_TUNNEL);
> -	br_set_port_flag(p, tb, IFLA_BRPORT_NEIGH_SUPPRESS, BR_NEIGH_SUPPRESS);
> -	br_set_port_flag(p, tb, IFLA_BRPORT_ISOLATED, BR_ISOLATED);
> -	br_set_port_flag(p, tb, IFLA_BRPORT_LOCKED, BR_PORT_LOCKED);
> -
> -	changed_mask = old_flags ^ p->flags;
> -
> -	err = br_switchdev_set_dev_flag(p->dev, p->flags, changed_mask, extack);
> +	if (p) {
> +		old_flags = p->flags;
> +		br_vlan_tunnel_old = (old_flags & BR_VLAN_TUNNEL) ? true : false;
> +
> +		br_set_port_flag(p, tb, IFLA_BRPORT_MODE, BR_HAIRPIN_MODE);
> +		br_set_port_flag(p, tb, IFLA_BRPORT_GUARD, BR_BPDU_GUARD);
> +		br_set_port_flag(p, tb, IFLA_BRPORT_FAST_LEAVE,
> +				 BR_MULTICAST_FAST_LEAVE);
> +		br_set_port_flag(p, tb, IFLA_BRPORT_PROTECT, BR_ROOT_BLOCK);
> +		br_set_port_flag(p, tb, IFLA_BRPORT_LEARNING, BR_LEARNING);
> +		br_set_port_flag(p, tb, IFLA_BRPORT_UNICAST_FLOOD, BR_FLOOD);
> +		br_set_port_flag(p, tb, IFLA_BRPORT_MCAST_FLOOD, BR_MCAST_FLOOD);
> +		br_set_port_flag(p, tb, IFLA_BRPORT_MCAST_TO_UCAST,
> +				 BR_MULTICAST_TO_UNICAST);
> +		br_set_port_flag(p, tb, IFLA_BRPORT_BCAST_FLOOD, BR_BCAST_FLOOD);
> +		br_set_port_flag(p, tb, IFLA_BRPORT_PROXYARP, BR_PROXYARP);
> +		br_set_port_flag(p, tb, IFLA_BRPORT_PROXYARP_WIFI, BR_PROXYARP_WIFI);
> +		br_set_port_flag(p, tb, IFLA_BRPORT_VLAN_TUNNEL, BR_VLAN_TUNNEL);
> +		br_set_port_flag(p, tb, IFLA_BRPORT_NEIGH_SUPPRESS, BR_NEIGH_SUPPRESS);
> +		br_set_port_flag(p, tb, IFLA_BRPORT_ISOLATED, BR_ISOLATED);
> +		br_set_port_flag(p, tb, IFLA_BRPORT_LOCKED, BR_PORT_LOCKED);
> +
> +		new_flags = p->flags;
> +		dev = p->dev;
> +	} else {
> +		struct br_boolopt_multi opts = {
> +			.optmask = BROPT_MASK
> +		};
> +
> +		br_boolopt_multi_get(br, &old_opts);
> +		old_flags = br_boolopt_map_flags(&old_opts);
> +
> +		br_set_bropt(br, tb, IFLA_BRPORT_UNICAST_FLOOD, BROPT_UNICAST_FLOOD);
> +		br_set_bropt(br, tb, IFLA_BRPORT_MCAST_FLOOD, BROPT_MCAST_FLOOD);
> +		br_set_bropt(br, tb, IFLA_BRPORT_BCAST_FLOOD, BROPT_BCAST_FLOOD);
> +
> +		br_boolopt_multi_get(br, &opts);
> +		new_flags = br_boolopt_map_flags(&opts);
> +		dev = br->dev;
> +	}
> +
> +	changed_mask = old_flags ^ new_flags;
> +
> +	err = br_switchdev_set_dev_flag(dev, new_flags, changed_mask, extack);
>  	if (err) {
> -		p->flags = old_flags;
> +		if (!p)
> +			br_boolopt_multi_toggle(br, &old_opts, extack);
> +		else
> +			p->flags = old_flags;
> +
>  		return err;
>  	}
>  
> +	/* Skip the rest for the bridge itself, for now */
> +	if (!p)
> +		return 0;
> +
>  	if (br_vlan_tunnel_old && !(p->flags & BR_VLAN_TUNNEL))
>  		nbp_vlan_tunnel_info_flush(p);
>  
> @@ -1048,7 +1134,7 @@ int br_setlink(struct net_device *dev, struct nlmsghdr *nlh, u16 flags,
>  	if (!p && !afspec)
>  		return -EINVAL;
>  
> -	if (p && protinfo) {
> +	if (protinfo) {
>  		if (protinfo->nla_type & NLA_F_NESTED) {
>  			err = nla_parse_nested_deprecated(tb, IFLA_BRPORT_MAX,
>  							  protinfo,
> @@ -1058,9 +1144,9 @@ int br_setlink(struct net_device *dev, struct nlmsghdr *nlh, u16 flags,
>  				return err;
>  
>  			spin_lock_bh(&br->lock);
> -			err = br_setport(p, tb, extack);
> +			err = br_setport(br, p, tb, extack);

setport is for *port* only...

>  			spin_unlock_bh(&br->lock);
> -		} else {
> +		} else if (p) {
>  			/* Binary compatibility with old RSTP */
>  			if (nla_len(protinfo) < sizeof(u8))
>  				return -EINVAL;
> @@ -1153,7 +1239,7 @@ static int br_port_slave_changelink(struct net_device *brdev,
>  		return 0;
>  
>  	spin_lock_bh(&br->lock);
> -	ret = br_setport(br_port_get_rtnl(dev), data, extack);
> +	ret = br_setport(br, br_port_get_rtnl(dev), data, extack);
>  	spin_unlock_bh(&br->lock);
>  
>  	return ret;
> @@ -1163,7 +1249,7 @@ static int br_port_fill_slave_info(struct sk_buff *skb,
>  				   const struct net_device *brdev,
>  				   const struct net_device *dev)
>  {
> -	return br_port_fill_attrs(skb, br_port_get_rtnl(dev));
> +	return br_port_fill_attrs(skb, NULL, br_port_get_rtnl(dev));
>  }
>  
>  static size_t br_port_get_slave_size(const struct net_device *brdev,

