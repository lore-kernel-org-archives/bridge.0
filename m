Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BD22381260
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB70D81255
MIME-Version: 1.0
Date: Sun, 30 Oct 2022 23:09:31 +0100
From: netdev@kapio-technology.com
In-Reply-To: <20221025100024.1287157-2-idosch@nvidia.com>
References: <20221025100024.1287157-1-idosch@nvidia.com>
 <20221025100024.1287157-2-idosch@nvidia.com>
Message-ID: <0b1655f30a383f9b12c0d0c9c11efa56@kapio-technology.com>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC PATCH net-next 01/16] bridge: Add MAC
 Authentication Bypass (MAB) support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: petrm@nvidia.com, ivecera@redhat.com, netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, roopa@nvidia.com, vladimir.oltean@nxp.com, edumazet@google.com, mlxsw@nvidia.com, jiri@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 2022-10-25 12:00, Ido Schimmel wrote:
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 5aeb3646e74c..bbc82c70b091 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -188,6 +188,7 @@ static inline size_t br_port_info_size(void)
>  		+ nla_total_size(1)	/* IFLA_BRPORT_NEIGH_SUPPRESS */
>  		+ nla_total_size(1)	/* IFLA_BRPORT_ISOLATED */
>  		+ nla_total_size(1)	/* IFLA_BRPORT_LOCKED */
> +		+ nla_total_size(1)	/* IFLA_BRPORT_MAB */
>  		+ nla_total_size(sizeof(struct ifla_bridge_id))	/* 
> IFLA_BRPORT_ROOT_ID */
>  		+ nla_total_size(sizeof(struct ifla_bridge_id))	/* 
> IFLA_BRPORT_BRIDGE_ID */
>  		+ nla_total_size(sizeof(u16))	/* IFLA_BRPORT_DESIGNATED_PORT */
> @@ -274,7 +275,8 @@ static int br_port_fill_attrs(struct sk_buff *skb,
>  	    nla_put_u8(skb, IFLA_BRPORT_MRP_IN_OPEN,
>  		       !!(p->flags & BR_MRP_LOST_IN_CONT)) ||
>  	    nla_put_u8(skb, IFLA_BRPORT_ISOLATED, !!(p->flags & BR_ISOLATED)) 
> ||
> -	    nla_put_u8(skb, IFLA_BRPORT_LOCKED, !!(p->flags & 
> BR_PORT_LOCKED)))
> +	    nla_put_u8(skb, IFLA_BRPORT_LOCKED, !!(p->flags & 
> BR_PORT_LOCKED)) ||
> +	    nla_put_u8(skb, IFLA_BRPORT_MAB, !!(p->flags & BR_PORT_MAB)))
>  		return -EMSGSIZE;
> 
>  	timerval = br_timer_value(&p->message_age_timer);
> @@ -876,6 +878,7 @@ static const struct nla_policy
> br_port_policy[IFLA_BRPORT_MAX + 1] = {
>  	[IFLA_BRPORT_NEIGH_SUPPRESS] = { .type = NLA_U8 },
>  	[IFLA_BRPORT_ISOLATED]	= { .type = NLA_U8 },
>  	[IFLA_BRPORT_LOCKED] = { .type = NLA_U8 },
> +	[IFLA_BRPORT_MAB] = { .type = NLA_U8 },
>  	[IFLA_BRPORT_BACKUP_PORT] = { .type = NLA_U32 },
>  	[IFLA_BRPORT_MCAST_EHT_HOSTS_LIMIT] = { .type = NLA_U32 },
>  };
> @@ -943,6 +946,14 @@ static int br_setport(struct net_bridge_port *p,
> struct nlattr *tb[],
>  	br_set_port_flag(p, tb, IFLA_BRPORT_NEIGH_SUPPRESS, 
> BR_NEIGH_SUPPRESS);
>  	br_set_port_flag(p, tb, IFLA_BRPORT_ISOLATED, BR_ISOLATED);
>  	br_set_port_flag(p, tb, IFLA_BRPORT_LOCKED, BR_PORT_LOCKED);
> +	br_set_port_flag(p, tb, IFLA_BRPORT_MAB, BR_PORT_MAB);
> +
> +	if ((p->flags & BR_PORT_MAB) &&
> +	    (!(p->flags & BR_PORT_LOCKED) || !(p->flags & BR_LEARNING))) {
> +		NL_SET_ERR_MSG(extack, "MAB can only be enabled on a locked port
> with learning enabled");

It's a bit odd to get this message when turning off learning on a port 
with MAB on, e.g....

# bridge link set dev a2 learning off
Error: MAB can only be enabled on a locked port with learning enabled.

