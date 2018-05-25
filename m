Return-Path: <makita.toshiaki@lab.ntt.co.jp>
References: <20180524085648.5934-1-nikolay@cumulusnetworks.com>
From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Message-ID: <33123f2d-5242-de36-a105-ecefcfda06e0@lab.ntt.co.jp>
Date: Fri, 25 May 2018 09:47:47 +0900
MIME-Version: 1.0
In-Reply-To: <20180524085648.5934-1-nikolay@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: add support for port
 isolation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org
Cc: roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

On 2018/05/24 17:56, Nikolay Aleksandrov wrote:
> This patch adds support for a new port flag - BR_ISOLATED. If it is set
> then isolated ports cannot communicate between each other, but they can
> still communicate with non-isolated ports. The same can be achieved via
> ACLs but they can't scale with large number of ports and also the
> complexity of the rules grows. This feature can be used to achieve
> isolated vlan functionality (similar to pvlan) as well, though currently
> it will be port-wide (for all vlans on the port). The new test in
> should_deliver uses data that is already cache hot and the new boolean
> is used to avoid an additional source port test in should_deliver.
> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Sometimes I need this kind of configuration and used vlan for such
cases. I guess it does not scale for your case so added this feature.
I wonder if this kind of feature is common in hardware switches.

FWIW,

Reviewed-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>

> ---
>  include/linux/if_bridge.h    | 1 +
>  include/uapi/linux/if_link.h | 1 +
>  net/bridge/br_forward.c      | 3 ++-
>  net/bridge/br_input.c        | 1 +
>  net/bridge/br_netlink.c      | 9 ++++++++-
>  net/bridge/br_private.h      | 9 +++++++++
>  net/bridge/br_sysfs_if.c     | 2 ++
>  7 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
> index 585d27182425..7843b98e1c6e 100644
> --- a/include/linux/if_bridge.h
> +++ b/include/linux/if_bridge.h
> @@ -50,6 +50,7 @@ struct br_ip_list {
>  #define BR_VLAN_TUNNEL		BIT(13)
>  #define BR_BCAST_FLOOD		BIT(14)
>  #define BR_NEIGH_SUPPRESS	BIT(15)
> +#define BR_ISOLATED		BIT(16)
>  
>  #define BR_DEFAULT_AGEING_TIME	(300 * HZ)
>  
> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index b85266420bfb..cf01b6824244 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -333,6 +333,7 @@ enum {
>  	IFLA_BRPORT_BCAST_FLOOD,
>  	IFLA_BRPORT_GROUP_FWD_MASK,
>  	IFLA_BRPORT_NEIGH_SUPPRESS,
> +	IFLA_BRPORT_ISOLATED,
>  	__IFLA_BRPORT_MAX
>  };
>  #define IFLA_BRPORT_MAX (__IFLA_BRPORT_MAX - 1)
> diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> index 7a7fd672ccf2..9019f326fe81 100644
> --- a/net/bridge/br_forward.c
> +++ b/net/bridge/br_forward.c
> @@ -30,7 +30,8 @@ static inline int should_deliver(const struct net_bridge_port *p,
>  	vg = nbp_vlan_group_rcu(p);
>  	return ((p->flags & BR_HAIRPIN_MODE) || skb->dev != p->dev) &&
>  		br_allowed_egress(vg, skb) && p->state == BR_STATE_FORWARDING &&
> -		nbp_switchdev_allowed_egress(p, skb);
> +		nbp_switchdev_allowed_egress(p, skb) &&
> +		!br_skb_isolated(p, skb);
>  }
>  
>  int br_dev_queue_push_xmit(struct net *net, struct sock *sk, struct sk_buff *skb)
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index 7f98a7d25866..72074276c088 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -114,6 +114,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
>  		goto drop;
>  
>  	BR_INPUT_SKB_CB(skb)->brdev = br->dev;
> +	BR_INPUT_SKB_CB(skb)->src_port_isolated = !!(p->flags & BR_ISOLATED);
>  
>  	if (IS_ENABLED(CONFIG_INET) &&
>  	    (skb->protocol == htons(ETH_P_ARP) ||
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 015f465c514b..9f5eb05b0373 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -139,6 +139,7 @@ static inline size_t br_port_info_size(void)
>  		+ nla_total_size(1)	/* IFLA_BRPORT_PROXYARP_WIFI */
>  		+ nla_total_size(1)	/* IFLA_BRPORT_VLAN_TUNNEL */
>  		+ nla_total_size(1)	/* IFLA_BRPORT_NEIGH_SUPPRESS */
> +		+ nla_total_size(1)	/* IFLA_BRPORT_ISOLATED */
>  		+ nla_total_size(sizeof(struct ifla_bridge_id))	/* IFLA_BRPORT_ROOT_ID */
>  		+ nla_total_size(sizeof(struct ifla_bridge_id))	/* IFLA_BRPORT_BRIDGE_ID */
>  		+ nla_total_size(sizeof(u16))	/* IFLA_BRPORT_DESIGNATED_PORT */
> @@ -213,7 +214,8 @@ static int br_port_fill_attrs(struct sk_buff *skb,
>  							BR_VLAN_TUNNEL)) ||
>  	    nla_put_u16(skb, IFLA_BRPORT_GROUP_FWD_MASK, p->group_fwd_mask) ||
>  	    nla_put_u8(skb, IFLA_BRPORT_NEIGH_SUPPRESS,
> -		       !!(p->flags & BR_NEIGH_SUPPRESS)))
> +		       !!(p->flags & BR_NEIGH_SUPPRESS)) ||
> +	    nla_put_u8(skb, IFLA_BRPORT_ISOLATED, !!(p->flags & BR_ISOLATED)))
>  		return -EMSGSIZE;
>  
>  	timerval = br_timer_value(&p->message_age_timer);
> @@ -660,6 +662,7 @@ static const struct nla_policy br_port_policy[IFLA_BRPORT_MAX + 1] = {
>  	[IFLA_BRPORT_VLAN_TUNNEL] = { .type = NLA_U8 },
>  	[IFLA_BRPORT_GROUP_FWD_MASK] = { .type = NLA_U16 },
>  	[IFLA_BRPORT_NEIGH_SUPPRESS] = { .type = NLA_U8 },
> +	[IFLA_BRPORT_ISOLATED]	= { .type = NLA_U8 },
>  };
>  
>  /* Change the state of the port and notify spanning tree */
> @@ -810,6 +813,10 @@ static int br_setport(struct net_bridge_port *p, struct nlattr *tb[])
>  	if (err)
>  		return err;
>  
> +	err = br_set_port_flag(p, tb, IFLA_BRPORT_ISOLATED, BR_ISOLATED);
> +	if (err)
> +		return err;
> +
>  	br_port_flags_change(p, old_flags ^ p->flags);
>  	return 0;
>  }
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 742f40aefdaf..11520ed528b0 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -423,6 +423,7 @@ struct br_input_skb_cb {
>  #endif
>  
>  	bool proxyarp_replied;
> +	bool src_port_isolated;
>  
>  #ifdef CONFIG_BRIDGE_VLAN_FILTERING
>  	bool vlan_filtered;
> @@ -574,6 +575,14 @@ int br_forward_finish(struct net *net, struct sock *sk, struct sk_buff *skb);
>  void br_flood(struct net_bridge *br, struct sk_buff *skb,
>  	      enum br_pkt_type pkt_type, bool local_rcv, bool local_orig);
>  
> +/* return true if both source port and dest port are isolated */
> +static inline bool br_skb_isolated(const struct net_bridge_port *to,
> +				   const struct sk_buff *skb)
> +{
> +	return BR_INPUT_SKB_CB(skb)->src_port_isolated &&
> +	       (to->flags & BR_ISOLATED);
> +}
> +
>  /* br_if.c */
>  void br_port_carrier_check(struct net_bridge_port *p, bool *notified);
>  int br_add_bridge(struct net *net, const char *name);
> diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
> index fd31ad83ec7b..f99c5bf5c906 100644
> --- a/net/bridge/br_sysfs_if.c
> +++ b/net/bridge/br_sysfs_if.c
> @@ -192,6 +192,7 @@ BRPORT_ATTR_FLAG(proxyarp_wifi, BR_PROXYARP_WIFI);
>  BRPORT_ATTR_FLAG(multicast_flood, BR_MCAST_FLOOD);
>  BRPORT_ATTR_FLAG(broadcast_flood, BR_BCAST_FLOOD);
>  BRPORT_ATTR_FLAG(neigh_suppress, BR_NEIGH_SUPPRESS);
> +BRPORT_ATTR_FLAG(isolated, BR_ISOLATED);
>  
>  #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
>  static ssize_t show_multicast_router(struct net_bridge_port *p, char *buf)
> @@ -243,6 +244,7 @@ static const struct brport_attribute *brport_attrs[] = {
>  	&brport_attr_broadcast_flood,
>  	&brport_attr_group_fwd_mask,
>  	&brport_attr_neigh_suppress,
> +	&brport_attr_isolated,
>  	NULL
>  };
>  
> 

-- 
Toshiaki Makita

