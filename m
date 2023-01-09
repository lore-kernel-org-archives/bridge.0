Return-Path: <idosch@idosch.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A28C660EFD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D771760784
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
 :feedback-id:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1673266807; x=1673353207; bh=BoRrhg2qoLX8AzR5nlod213O8Dn0
 cuabW6bstFyKh6g=; b=DFepMdIDoB+mlolDcbW2KqnE5pmmpY+RdAochu7RfvCA
 9oc+Bv2B0P8Dg4MCtPhAY3VvbvVNwAVqI62ZqJsY5fE0bZmyJ62KC9TA2OhnxS01
 InOGx5C8ZAmsKMmOJBsN4qNUud9CcI0iWUYZ+qD8plQ2AxLmmLtniJggTgFuK8mg
 YVFYYonVCZ2uRj3qXJ+AkeDxlA5Lr0I/2PX00UNM5cKrK/8+25ehqQ4g76akEOBV
 cd/l23v3UYN/q+CfUEeyGKnQrrVktiHsgbO1d9iP+5+VrT0WG7TOQuBJBBuBt1nj
 6hsAQCXix7tobllTf1RJqzut1NlyA8f8Z/+geLEmUg==
Date: Mon, 9 Jan 2023 14:20:02 +0200
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <Y7wGct6VWmbuWs5F@shredder>
References: <20220316150857.2442916-1-tobias@waldekranz.com>
 <20220316150857.2442916-2-tobias@waldekranz.com>
 <Y7vK4T18pOZ9KAKE@shredder> <20230109100236.euq7iaaorqxrun7u@skbuf>
 <Y7v98s8lC1WUvsSO@shredder> <20230109115653.6yjijaj63n2v35lw@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109115653.6yjijaj63n2v35lw@skbuf>
Subject: Re: [Bridge] [PATCH v5 net-next 01/15] net: bridge: mst: Multiple
 Spanning Tree (MST) mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Matt Johnston <matt@codeconstruct.com.au>, davem@davemloft.net, linux-kernel@vger.kernel.org, Tobias Waldekranz <tobias@waldekranz.com>

On Mon, Jan 09, 2023 at 01:56:53PM +0200, Vladimir Oltean wrote:
> On Mon, Jan 09, 2023 at 01:43:46PM +0200, Ido Schimmel wrote:
> > OK, thanks for confirming. Will send a patch later this week if Tobias
> > won't take care of it by then. First patch will probably be [1] to make
> > sure we dump the correct MST state to user space. It will also make it
> > easier to show the problem and validate the fix.
> > 
> > [1]
> > diff --git a/net/bridge/br.c b/net/bridge/br.c
> > index 4f5098d33a46..f02a1ad589de 100644
> > --- a/net/bridge/br.c
> > +++ b/net/bridge/br.c
> > @@ -286,7 +286,7 @@ int br_boolopt_get(const struct net_bridge *br, enum br_boolopt_id opt)
> >  	case BR_BOOLOPT_MCAST_VLAN_SNOOPING:
> >  		return br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED);
> >  	case BR_BOOLOPT_MST_ENABLE:
> > -		return br_opt_get(br, BROPT_MST_ENABLED);
> > +		return br_mst_is_enabled(br);
> 
> Well, this did report the correct MST state despite the incorrect static
> branch state, no? The users of br_mst_is_enabled(br) are broken, not
> those of br_opt_get(br, BROPT_MST_ENABLED).

I should have said "actual"/"effective" instead of "correct". IMO, it's
better to use the same conditional in the both the data and control
paths to eliminate discrepancies. Without the patch, a user will see
that MST is supposedly enabled when it is actually disabled in the data
path.

> 
> Anyway, I see there's a br_mst_is_enabled() and also a br_mst_enabled()?!
> One is used in the fast path and the other in the slow path. They should
> probably be merged, I guess. They both exist probably because somebody
> thought that the "if (!netif_is_bridge_master(dev))" test is redundant
> in the fast path.

The single user of br_mst_enabled() (DSA) is not affected by the bug
(only the SW data path is), so I suggest making this consolidation in
net-next after the bug is fixed. OK?

> 
> >  	default:
> >  		/* shouldn't be called with unsupported options */
> >  		WARN_ON(1);
> > diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> > index 75aff9bbf17e..7f0475f62d45 100644
> > --- a/net/bridge/br_private.h
> > +++ b/net/bridge/br_private.h
> > @@ -1827,7 +1827,7 @@ static inline bool br_vlan_state_allowed(u8 state, bool learn_allow)
> >  /* br_mst.c */
> >  #ifdef CONFIG_BRIDGE_VLAN_FILTERING
> >  DECLARE_STATIC_KEY_FALSE(br_mst_used);
> > -static inline bool br_mst_is_enabled(struct net_bridge *br)
> > +static inline bool br_mst_is_enabled(const struct net_bridge *br)
> >  {
> >  	return static_branch_unlikely(&br_mst_used) &&
> >  		br_opt_get(br, BROPT_MST_ENABLED);
> > @@ -1845,7 +1845,7 @@ int br_mst_fill_info(struct sk_buff *skb,
> >  int br_mst_process(struct net_bridge_port *p, const struct nlattr *mst_attr,
> >  		   struct netlink_ext_ack *extack);
> >  #else
> > -static inline bool br_mst_is_enabled(struct net_bridge *br)
> > +static inline bool br_mst_is_enabled(const struct net_bridge *br)
> >  {
> >  	return false;
> >  }
