Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=HxZ0IRRgHJ9M+edFd
 /uChpMWKuc/uyIm4Qwe86ghBaQ=; b=YpgAO98pauEPZcjNOoITdgX8mZWyvSVKN
 aaQ1jEXcc8/8FZVCEdIxgRen43i8vPpq/vq17hMiEkjQ3WAt8Tauy9z5LNEaCLBH
 TTWEFZPDhVKb/cC+Jwu2I9yDhCaA8ebeeLdwTI5oF5zEhaaQJqxZmeFrT0A/445N
 M0ZMtI2q6f88n5yTbpQVSNZVdEB6KgttihpX8B+gWQZYfBLV5y9Ye26Ajria4+jJ
 KJnTDKT8u6D1ReeOKBeDI+m+tysQBGQmsJQK4UAsm90fa4nTwCqTpICOatvtmCON
 rRvem3rUWsM8/Ds3+NC0bpSJeev+6lM1XwLJgHYSCjHAgKbh7geng==
Date: Thu, 10 Feb 2022 12:20:49 +0200
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <YgTnAcfTfeyQOQCf@shredder>
References: <20220209130538.533699-1-schultz.hans+netdev@gmail.com>
 <20220209130538.533699-2-schultz.hans+netdev@gmail.com>
 <c821f05b-94e1-cf48-f2a6-40a689678c2b@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c821f05b-94e1-cf48-f2a6-40a689678c2b@blackwall.org>
Subject: Re: [Bridge] [PATCH net-next v2 1/5] net: bridge: Add support for
 bridge port in locked mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, Hans Schultz <schultz.hans@gmail.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Hans Schultz <schultz.hans+netdev@gmail.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, davem@davemloft.net

On Thu, Feb 10, 2022 at 10:30:01AM +0200, Nikolay Aleksandrov wrote:
> On 09/02/2022 15:05, Hans Schultz wrote:
> > In a 802.1X scenario, clients connected to a bridge port shall not
> > be allowed to have traffic forwarded until fully authenticated.
> > A static fdb entry of the clients MAC address for the bridge port
> > unlocks the client and allows bidirectional communication.
> > 
> > This scenario is facilitated with setting the bridge port in locked
> > mode, which is also supported by various switchcore chipsets.
> > 
> > Signed-off-by: Hans Schultz <schultz.hans+netdev@gmail.com>
> > ---
> 
> Hi,
> I'm writing from my private email because for some reason I'm not receiving the full
> patch-set in my nvidia mail, a few comments below..
> 
> >  include/linux/if_bridge.h    |  1 +
> >  include/uapi/linux/if_link.h |  1 +
> >  net/bridge/br_input.c        | 10 +++++++++-
> >  net/bridge/br_netlink.c      |  6 +++++-
> >  4 files changed, 16 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
> > index 509e18c7e740..3aae023a9353 100644
> > --- a/include/linux/if_bridge.h
> > +++ b/include/linux/if_bridge.h
> > @@ -58,6 +58,7 @@ struct br_ip_list {
> >  #define BR_MRP_LOST_CONT	BIT(18)
> >  #define BR_MRP_LOST_IN_CONT	BIT(19)
> >  #define BR_TX_FWD_OFFLOAD	BIT(20)
> > +#define BR_PORT_LOCKED		BIT(21)
> >  
> >  #define BR_DEFAULT_AGEING_TIME	(300 * HZ)
> >  
> > diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> > index 6218f93f5c1a..a45cc0a1f415 100644
> > --- a/include/uapi/linux/if_link.h
> > +++ b/include/uapi/linux/if_link.h
> > @@ -537,6 +537,7 @@ enum {
> >  	IFLA_BRPORT_MRP_IN_OPEN,
> >  	IFLA_BRPORT_MCAST_EHT_HOSTS_LIMIT,
> >  	IFLA_BRPORT_MCAST_EHT_HOSTS_CNT,
> > +	IFLA_BRPORT_LOCKED,
> >  	__IFLA_BRPORT_MAX
> >  };
> >  #define IFLA_BRPORT_MAX (__IFLA_BRPORT_MAX - 1)
> > diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> > index b50382f957c1..469e3adbce07 100644
> > --- a/net/bridge/br_input.c
> > +++ b/net/bridge/br_input.c
> > @@ -69,6 +69,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
> >  	struct net_bridge_port *p = br_port_get_rcu(skb->dev);
> >  	enum br_pkt_type pkt_type = BR_PKT_UNICAST;
> >  	struct net_bridge_fdb_entry *dst = NULL;
> > +	struct net_bridge_fdb_entry *fdb_entry;
> 
> move fdb_entry below to where it is used
> 
> >  	struct net_bridge_mcast_port *pmctx;
> >  	struct net_bridge_mdb_entry *mdst;
> >  	bool local_rcv, mcast_hit = false;
> > @@ -81,6 +82,8 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
> >  	if (!p || p->state == BR_STATE_DISABLED)
> >  		goto drop;
> >  
> > +	br = p->br;
> > +
> 
> please drop the extra new line
> 
> >  	brmctx = &p->br->multicast_ctx;
> >  	pmctx = &p->multicast_ctx;
> >  	state = p->state;
> > @@ -88,10 +91,15 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
> >  				&state, &vlan))
> >  		goto out;
> >  
> > +	if (p->flags & BR_PORT_LOCKED) {
> 
> fdb_entry should be defined in this scope only, and please rename it to something
> like fdb_src or just "src" as we already have "dst".
> 
> > +		fdb_entry = br_fdb_find_rcu(br, eth_hdr(skb)->h_source, vid);
> > +		if (!(fdb_entry && fdb_entry->dst == p))
> 
> if (!fdb_entry || READ_ONCE(fdb_entry->dst) != p

I think we should also check that entry does not have 'BR_FDB_LOCAL'
set. These entries point at the bridge ports themselves, but do not
actually represent hosts behind the ports. Since they are automatically
populated, a malicious host can craft packets with SMAC of the bridge
port and bypass the check.

Assuming the above is true (didn't test), would be good to add a test
case for it in the selftest.

> 
> > +			goto drop;
> > +	}
> > +
> >  	nbp_switchdev_frame_mark(p, skb);
> >  
> >  	/* insert into forwarding database after filtering to avoid spoofing */
> > -	br = p->br;
> >  	if (p->flags & BR_LEARNING)
> >  		br_fdb_update(br, p, eth_hdr(skb)->h_source, vid, 0);
> >  
> > diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> > index 2ff83d84230d..7d4432ca9a20 100644
> > --- a/net/bridge/br_netlink.c
> > +++ b/net/bridge/br_netlink.c
> > @@ -184,6 +184,7 @@ static inline size_t br_port_info_size(void)
> >  		+ nla_total_size(1)	/* IFLA_BRPORT_VLAN_TUNNEL */
> >  		+ nla_total_size(1)	/* IFLA_BRPORT_NEIGH_SUPPRESS */
> >  		+ nla_total_size(1)	/* IFLA_BRPORT_ISOLATED */
> > +		+ nla_total_size(1)	/* IFLA_BRPORT_LOCKED */
> >  		+ nla_total_size(sizeof(struct ifla_bridge_id))	/* IFLA_BRPORT_ROOT_ID */
> >  		+ nla_total_size(sizeof(struct ifla_bridge_id))	/* IFLA_BRPORT_BRIDGE_ID */
> >  		+ nla_total_size(sizeof(u16))	/* IFLA_BRPORT_DESIGNATED_PORT */
> > @@ -269,7 +270,8 @@ static int br_port_fill_attrs(struct sk_buff *skb,
> >  							  BR_MRP_LOST_CONT)) ||
> >  	    nla_put_u8(skb, IFLA_BRPORT_MRP_IN_OPEN,
> >  		       !!(p->flags & BR_MRP_LOST_IN_CONT)) ||
> > -	    nla_put_u8(skb, IFLA_BRPORT_ISOLATED, !!(p->flags & BR_ISOLATED)))
> > +	    nla_put_u8(skb, IFLA_BRPORT_ISOLATED, !!(p->flags & BR_ISOLATED)) ||
> > +	    nla_put_u8(skb, IFLA_BRPORT_LOCKED, !!(p->flags & BR_PORT_LOCKED)))
> >  		return -EMSGSIZE;
> >  
> >  	timerval = br_timer_value(&p->message_age_timer);
> > @@ -827,6 +829,7 @@ static const struct nla_policy br_port_policy[IFLA_BRPORT_MAX + 1] = {
> >  	[IFLA_BRPORT_GROUP_FWD_MASK] = { .type = NLA_U16 },
> >  	[IFLA_BRPORT_NEIGH_SUPPRESS] = { .type = NLA_U8 },
> >  	[IFLA_BRPORT_ISOLATED]	= { .type = NLA_U8 },
> > +	[IFLA_BRPORT_LOCKED] = { .type = NLA_U8 },
> >  	[IFLA_BRPORT_BACKUP_PORT] = { .type = NLA_U32 },
> >  	[IFLA_BRPORT_MCAST_EHT_HOSTS_LIMIT] = { .type = NLA_U32 },
> >  };
> > @@ -893,6 +896,7 @@ static int br_setport(struct net_bridge_port *p, struct nlattr *tb[],
> >  	br_set_port_flag(p, tb, IFLA_BRPORT_VLAN_TUNNEL, BR_VLAN_TUNNEL);
> >  	br_set_port_flag(p, tb, IFLA_BRPORT_NEIGH_SUPPRESS, BR_NEIGH_SUPPRESS);
> >  	br_set_port_flag(p, tb, IFLA_BRPORT_ISOLATED, BR_ISOLATED);
> > +	br_set_port_flag(p, tb, IFLA_BRPORT_LOCKED, BR_PORT_LOCKED);
> >  
> >  	changed_mask = old_flags ^ p->flags;
> >  
> 
> Thanks,
>  Nik
