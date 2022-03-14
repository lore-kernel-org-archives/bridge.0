Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=MZp7gpnQ9sDMK3u9FGLF0DtfQSh/r7kXG58Sm7tKpYY=;
 b=saLhr5vFxCZrsjEj3zox8KF0Jb1MMbflR64Kb4l4U4tzSm3yiiVkIu+uDJS5QATHiw
 +lz3GSqr1atOyRu9wMyJSddeuHQfuT51ZKhx5MXqEaQwuT4mU0EpDw/EZf0OKtxz77k9
 E1u92oMbVLni/4nwkwlmgAPyRXb2sJAeOYNkMiqFVWgHeTD/7FDa+CcVqS+dsCMaYNmZ
 8vcD5L0hbgAhMnwckDw9FbuSlEXGVYKADhUqOsrUuhlNxZ8L+K0y1SDQUcZM3MCyD+M4
 iDbXJ+YTY706sAufKQi8A9tZU7mX/5UGDJ9gg8pL1zaHxP1Y+57GunLctJxM6ahtSYqU
 ojfQ==
Message-ID: <d16cb4b7-a1bf-2e96-0b59-2c4c37b2fdd3@blackwall.org>
Date: Mon, 14 Mar 2022 12:37:46 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220314095231.3486931-1-tobias@waldekranz.com>
 <20220314095231.3486931-4-tobias@waldekranz.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20220314095231.3486931-4-tobias@waldekranz.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v3 net-next 03/14] net: bridge: mst: Support
 setting and reporting MST port states
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Waldekranz <tobias@waldekranz.com>, davem@davemloft.net, kuba@kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, Matt Johnston <matt@codeconstruct.com.au>, Vladimir Oltean <olteanv@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>

On 14/03/2022 11:52, Tobias Waldekranz wrote:
> Make it possible to change the port state in a given MSTI by extending
> the bridge port netlink interface (RTM_SETLINK on PF_BRIDGE).The
> proposed iproute2 interface would be:
> 
>     bridge mst set dev <PORT> msti <MSTI> state <STATE>
> 
> Current states in all applicable MSTIs can also be dumped via a
> corresponding RTM_GETLINK. The proposed iproute interface looks like
> this:
> 
> $ bridge mst
> port              msti
> vb1               0
> 		    state forwarding
> 		  100
> 		    state disabled
> vb2               0
> 		    state forwarding
> 		  100
> 		    state forwarding
> 
> The preexisting per-VLAN states are still valid in the MST
> mode (although they are read-only), and can be queried as usual if one
> is interested in knowing a particular VLAN's state without having to
> care about the VID to MSTI mapping (in this example VLAN 20 and 30 are
> bound to MSTI 100):
> 
> $ bridge -d vlan
> port              vlan-id
> vb1               10
> 		    state forwarding mcast_router 1
> 		  20
> 		    state disabled mcast_router 1
> 		  30
> 		    state disabled mcast_router 1
> 		  40
> 		    state forwarding mcast_router 1
> vb2               10
> 		    state forwarding mcast_router 1
> 		  20
> 		    state forwarding mcast_router 1
> 		  30
> 		    state forwarding mcast_router 1
> 		  40
> 		    state forwarding mcast_router 1
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---

Hi Tobias,
A few comments below..

>  include/uapi/linux/if_bridge.h |  17 ++++++
>  include/uapi/linux/rtnetlink.h |   1 +
>  net/bridge/br_mst.c            | 105 +++++++++++++++++++++++++++++++++
>  net/bridge/br_netlink.c        |  32 +++++++++-
>  net/bridge/br_private.h        |  15 +++++
>  5 files changed, 169 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
> index f60244b747ae..879dfaef8da0 100644
> --- a/include/uapi/linux/if_bridge.h
> +++ b/include/uapi/linux/if_bridge.h
> @@ -122,6 +122,7 @@ enum {
>  	IFLA_BRIDGE_VLAN_TUNNEL_INFO,
>  	IFLA_BRIDGE_MRP,
>  	IFLA_BRIDGE_CFM,
> +	IFLA_BRIDGE_MST,
>  	__IFLA_BRIDGE_MAX,
>  };
>  #define IFLA_BRIDGE_MAX (__IFLA_BRIDGE_MAX - 1)
> @@ -453,6 +454,21 @@ enum {
>  
>  #define IFLA_BRIDGE_CFM_CC_PEER_STATUS_MAX (__IFLA_BRIDGE_CFM_CC_PEER_STATUS_MAX - 1)
>  
> +enum {
> +	IFLA_BRIDGE_MST_UNSPEC,
> +	IFLA_BRIDGE_MST_ENTRY,
> +	__IFLA_BRIDGE_MST_MAX,
> +};
> +#define IFLA_BRIDGE_MST_MAX (__IFLA_BRIDGE_MST_MAX - 1)
> +
> +enum {
> +	IFLA_BRIDGE_MST_ENTRY_UNSPEC,
> +	IFLA_BRIDGE_MST_ENTRY_MSTI,
> +	IFLA_BRIDGE_MST_ENTRY_STATE,
> +	__IFLA_BRIDGE_MST_ENTRY_MAX,
> +};
> +#define IFLA_BRIDGE_MST_ENTRY_MAX (__IFLA_BRIDGE_MST_ENTRY_MAX - 1)
> +
>  struct bridge_stp_xstats {
>  	__u64 transition_blk;
>  	__u64 transition_fwd;
> @@ -786,4 +802,5 @@ enum {
>  	__BRIDGE_QUERIER_MAX
>  };
>  #define BRIDGE_QUERIER_MAX (__BRIDGE_QUERIER_MAX - 1)
> +

stray new line

>  #endif /* _UAPI_LINUX_IF_BRIDGE_H */
> diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
> index 51530aade46e..83849a37db5b 100644
> --- a/include/uapi/linux/rtnetlink.h
> +++ b/include/uapi/linux/rtnetlink.h
> @@ -817,6 +817,7 @@ enum {
>  #define RTEXT_FILTER_MRP	(1 << 4)
>  #define RTEXT_FILTER_CFM_CONFIG	(1 << 5)
>  #define RTEXT_FILTER_CFM_STATUS	(1 << 6)
> +#define RTEXT_FILTER_MST	(1 << 7)
>  
>  /* End of information exported to user level */
>  
> diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
> index 78ef5fea4d2b..df65aa7701c1 100644
> --- a/net/bridge/br_mst.c
> +++ b/net/bridge/br_mst.c
> @@ -124,3 +124,108 @@ int br_mst_set_enabled(struct net_bridge *br, bool on,
>  	br_opt_toggle(br, BROPT_MST_ENABLED, on);
>  	return 0;
>  }
> +
> +int br_mst_fill_info(struct sk_buff *skb, struct net_bridge_vlan_group *vg)

const vg

> +{
> +	struct net_bridge_vlan *v;

const v

> +	struct nlattr *nest;
> +	unsigned long *seen;
> +	int err = 0;
> +
> +	seen = bitmap_zalloc(VLAN_N_VID, 0);
> +	if (!seen)
> +		return -ENOMEM;
> +
> +	list_for_each_entry(v, &vg->vlan_list, vlist) {
> +		if (test_bit(v->brvlan->msti, seen))
> +			continue;
> +
> +		nest = nla_nest_start_noflag(skb, IFLA_BRIDGE_MST_ENTRY);
> +		if (!nest ||
> +		    nla_put_u16(skb, IFLA_BRIDGE_MST_ENTRY_MSTI, v->brvlan->msti) ||
> +		    nla_put_u8(skb, IFLA_BRIDGE_MST_ENTRY_STATE, v->state)) {
> +			err = -EMSGSIZE;
> +			break;
> +		}
> +		nla_nest_end(skb, nest);
> +
> +		set_bit(v->brvlan->msti, seen);

__set_bit()

> +	}
> +
> +	kfree(seen);
> +	return err;
> +}
> +
> +static const struct nla_policy br_mst_nl_policy[IFLA_BRIDGE_MST_ENTRY_MAX + 1] = {
> +	[IFLA_BRIDGE_MST_ENTRY_MSTI] = NLA_POLICY_RANGE(NLA_U16,
> +						   1, /* 0 reserved for CST */
> +						   VLAN_N_VID - 1),
> +	[IFLA_BRIDGE_MST_ENTRY_STATE] = NLA_POLICY_RANGE(NLA_U8,
> +						    BR_STATE_DISABLED,
> +						    BR_STATE_BLOCKING),
> +};
> +
> +static int br_mst_parse_one(struct net_bridge_port *p,
> +			    const struct nlattr *attr,
> +			    struct netlink_ext_ack *extack)
> +{

I'd either set the state after parsing, so this function just does what it
says (parse) or I'd rename it.

> +	struct nlattr *tb[IFLA_BRIDGE_MST_ENTRY_MAX + 1];
> +	u16 msti;
> +	u8 state;
> +	int err;
> +
> +	err = nla_parse_nested(tb, IFLA_BRIDGE_MST_ENTRY_MAX, attr,
> +			       br_mst_nl_policy, extack);
> +	if (err)
> +		return err;
> +
> +	if (!tb[IFLA_BRIDGE_MST_ENTRY_MSTI]) {
> +		NL_SET_ERR_MSG_MOD(extack, "MSTI not specified");
> +		return -EINVAL;
> +	}
> +
> +	if (!tb[IFLA_BRIDGE_MST_ENTRY_STATE]) {
> +		NL_SET_ERR_MSG_MOD(extack, "State not specified");
> +		return -EINVAL;
> +	}
> +
> +	msti = nla_get_u16(tb[IFLA_BRIDGE_MST_ENTRY_MSTI]);
> +	state = nla_get_u8(tb[IFLA_BRIDGE_MST_ENTRY_STATE]);
> +
> +	br_mst_set_state(p, msti, state);
> +	return 0;
> +}
> +
> +int br_mst_parse(struct net_bridge_port *p, struct nlattr *mst_attr,
> +		 struct netlink_ext_ack *extack)

This doesn't just parse though, it also sets the state. Please rename it to
something more appropriate.

const mst_attr

> +{
> +	struct nlattr *attr;
> +	int err, msts = 0;
> +	int rem;
> +
> +	if (!br_opt_get(p->br, BROPT_MST_ENABLED)) {
> +		NL_SET_ERR_MSG_MOD(extack, "Can't modify MST state when MST is disabled");
> +		return -EBUSY;
> +	}
> +
> +	nla_for_each_nested(attr, mst_attr, rem) {
> +		switch (nla_type(attr)) {
> +		case IFLA_BRIDGE_MST_ENTRY:
> +			err = br_mst_parse_one(p, attr, extack);
> +			break;
> +		default:
> +			continue;
> +		}
> +
> +		msts++;
> +		if (err)
> +			break;
> +	}
> +
> +	if (!msts) {
> +		NL_SET_ERR_MSG_MOD(extack, "Found no MST entries to process");
> +		err = -EINVAL;
> +	}
> +
> +	return err;
> +}
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 7d4432ca9a20..d2b4550f30d6 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -485,7 +485,8 @@ static int br_fill_ifinfo(struct sk_buff *skb,
>  			   RTEXT_FILTER_BRVLAN_COMPRESSED |
>  			   RTEXT_FILTER_MRP |
>  			   RTEXT_FILTER_CFM_CONFIG |
> -			   RTEXT_FILTER_CFM_STATUS)) {
> +			   RTEXT_FILTER_CFM_STATUS |
> +			   RTEXT_FILTER_MST)) {
>  		af = nla_nest_start_noflag(skb, IFLA_AF_SPEC);
>  		if (!af)
>  			goto nla_put_failure;
> @@ -564,7 +565,28 @@ static int br_fill_ifinfo(struct sk_buff *skb,
>  		nla_nest_end(skb, cfm_nest);
>  	}
>  
> +	if ((filter_mask & RTEXT_FILTER_MST) &&
> +	    br_opt_get(br, BROPT_MST_ENABLED) && port) {
> +		struct net_bridge_vlan_group *vg = nbp_vlan_group(port);

const vg

> +		struct nlattr *mst_nest;
> +		int err;
> +
> +		if (!vg || !vg->num_vlans)
> +			goto done;
> +
> +		mst_nest = nla_nest_start(skb, IFLA_BRIDGE_MST);
> +		if (!mst_nest)
> +			goto nla_put_failure;
> +
> +		err = br_mst_fill_info(skb, vg);
> +		if (err)
> +			goto nla_put_failure;
> +
> +		nla_nest_end(skb, mst_nest);
> +	}
> +

I think you should also update br_get_link_af_size_filtered() to account for the
new dump attributes based on the filter. I'd adjust vinfo_sz based on the filter
flag.

>  done:
> +
>  	if (af)
>  		nla_nest_end(skb, af);
>  	nlmsg_end(skb, nlh);
> @@ -803,6 +825,14 @@ static int br_afspec(struct net_bridge *br,
>  			if (err)
>  				return err;
>  			break;
> +		case IFLA_BRIDGE_MST:
> +			if (cmd != RTM_SETLINK || !p)
> +				return -EINVAL;

These are two different errors, please set extack appropriately
for each error.

> +
> +			err = br_mst_parse(p, attr, extack);
> +			if (err)
> +				return err;
> +			break;
>  		}
>  	}
>  
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index b907d389b63a..08d82578bd97 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -1783,6 +1783,9 @@ int br_mst_vlan_set_msti(struct net_bridge_vlan *v, u16 msti);
>  void br_mst_vlan_init_state(struct net_bridge_vlan *v);
>  int br_mst_set_enabled(struct net_bridge *br, bool on,
>  		       struct netlink_ext_ack *extack);
> +int br_mst_fill_info(struct sk_buff *skb, struct net_bridge_vlan_group *vg);
> +int br_mst_parse(struct net_bridge_port *p, struct nlattr *mst_attr,
> +		 struct netlink_ext_ack *extack);
>  #else
>  static inline bool br_mst_is_enabled(struct net_bridge *br)
>  {
> @@ -1791,6 +1794,18 @@ static inline bool br_mst_is_enabled(struct net_bridge *br)
>  
>  static inline void br_mst_set_state(struct net_bridge_port *p,
>  				    u16 msti, u8 state) {}
> +static inline int br_mst_fill_info(struct sk_buff *skb,
> +				   struct net_bridge_vlan_group *vg)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int br_mst_parse(struct net_bridge_port *p,
> +			       struct nlattr *mst_attr,
> +			       struct netlink_ext_ack *extack)
> +{
> +	return -EOPNOTSUPP;
> +}
>  #endif
>  
>  struct nf_br_ops {

