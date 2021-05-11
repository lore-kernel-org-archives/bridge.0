Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 11 May 2021 13:28:54 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20210511112854.GA2222@otheros>
References: <20210509194509.10849-1-linus.luessing@c0d3.blue>
 <20210509194509.10849-10-linus.luessing@c0d3.blue>
 <f2f1c811-0502-bde4-8ece-e47b3e30dc66@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f2f1c811-0502-bde4-8ece-e47b3e30dc66@nvidia.com>
Subject: Re: [Bridge] [net-next v2 09/11] net: bridge: mcast: split
 multicast router state for IPv4 and IPv6
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>

On Tue, May 11, 2021 at 12:29:41PM +0300, Nikolay Aleksandrov wrote:
> [...]
> > -static void br_multicast_mark_router(struct net_bridge *br,
> > -				     struct net_bridge_port *port)
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +struct hlist_node *
> > +br_ip6_multicast_get_rport_slot(struct net_bridge *br, struct net_bridge_port *port)
> > +{
> > +	struct hlist_node *slot = NULL;
> > +	struct net_bridge_port *p;
> > +
> > +	hlist_for_each_entry(p, &br->ip6_mc_router_list, ip6_rlist) {
> > +		if ((unsigned long)port >= (unsigned long)p)
> > +			break;
> > +		slot = &p->ip6_rlist;
> > +	}
> > +
> > +	return slot;
> > +}
> 
> The ip4/ip6 get_rport_slot functions are identical, why not add a list pointer
> and use one function ?

Hi Nikolay,

Thanks for all the feedback and reviewing again! I'll
remove (most of) the inlines as the router list modifications are
not in the fast path.

For the get_rport_slot functions, maybe I'm missing a simple
solution. Note that "ip6_rlist" in hlist_for_each_entry() is not a
pointer but will be expanded by the macro. I currently don't see
how I could solve this with just one hlist_for_each_entry().

Regards, Linus
