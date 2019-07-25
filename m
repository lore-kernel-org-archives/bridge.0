Return-Path: <Horatiu.Vultur@microchip.com>
Date: Thu, 25 Jul 2019 16:21:03 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Message-ID: <20190725142101.65tusauc6fzxb2yp@soft-dev3.microsemi.net>
References: <1564055044-27593-1-git-send-email-horatiu.vultur@microchip.com>
	<7e7a7015-6072-d884-b2ba-0a51177245ab@cumulusnetworks.com>
	<eef063fe-fd3a-7e02-89c2-e40728a17578@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <eef063fe-fd3a-7e02-89c2-e40728a17578@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH] net: bridge: Allow bridge to joing multicast
	groups
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, allan.nielsen@microchip.com, davem@davemloft.net

Hi Nikolay,

The 07/25/2019 16:21, Nikolay Aleksandrov wrote:
> External E-Mail
> 
> 
> On 25/07/2019 16:06, Nikolay Aleksandrov wrote:
> > On 25/07/2019 14:44, Horatiu Vultur wrote:
> >> There is no way to configure the bridge, to receive only specific link
> >> layer multicast addresses. From the description of the command 'bridge
> >> fdb append' is supposed to do that, but there was no way to notify the
> >> network driver that the bridge joined a group, because LLADDR was added
> >> to the unicast netdev_hw_addr_list.
> >>
> >> Therefore update fdb_add_entry to check if the NLM_F_APPEND flag is set
> >> and if the source is NULL, which represent the bridge itself. Then add
> >> address to multicast netdev_hw_addr_list for each bridge interfaces.
> >> And then the .ndo_set_rx_mode function on the driver is called. To notify
> >> the driver that the list of multicast mac addresses changed.
> >>
> >> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> >> ---
> >>  net/bridge/br_fdb.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++---
> >>  1 file changed, 46 insertions(+), 3 deletions(-)
> >>
> > 
> > Hi,
> > I'm sorry but this patch is wrong on many levels, some notes below. In general
> > NLM_F_APPEND is only used in vxlan, the bridge does not handle that flag at all.
> > FDB is only for *unicast*, nothing is joined and no multicast should be used with fdbs.
> > MDB is used for multicast handling, but both of these are used for forwarding.
> > The reason the static fdbs are added to the filter is for non-promisc ports, so they can
> > receive traffic destined for these FDBs for forwarding.
> > If you'd like to join any multicast group please use the standard way, if you'd like to join
> > it only on a specific port - join it only on that port (or ports) and the bridge and you'll
> 
> And obviously this is for the case where you're not enabling port promisc mode (non-default).
> In general you'll only need to join the group on the bridge to receive traffic for it
> or add it as an mdb entry to forward it.
> 
> > have the effect that you're describing. What do you mean there's no way ?

Thanks for the explanation.
There are few things that are not 100% clear to me and maybe you can
explain them, not to go totally in the wrong direction. Currently I am
writing a network driver on which I added switchdev support. Then I was
looking for a way to configure the network driver to copy link layer
multicast address to the CPU port.

If I am using bridge mdb I can do it only for IP multicast addreses,
but how should I do it if I want non IP frames with link layer multicast
address to be copy to CPU? For example: all frames with multicast
address '01-21-6C-00-00-01' to be copy to CPU. What is the user space
command for that?

> > 
> > In addition you're allowing a mix of mcast functions to be called with unicast addresses
> > and vice versa, it is not that big of a deal because the kernel will simply return an error
> > but still makes no sense.
> > 
> > Nacked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> > 
> >> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> >> index b1d3248..d93746d 100644
> >> --- a/net/bridge/br_fdb.c
> >> +++ b/net/bridge/br_fdb.c
> >> @@ -175,6 +175,29 @@ static void fdb_add_hw_addr(struct net_bridge *br, const unsigned char *addr)
> >>  	}
> >>  }
> >>  
> >> +static void fdb_add_hw_maddr(struct net_bridge *br, const unsigned char *addr)
> >> +{
> >> +	int err;
> >> +	struct net_bridge_port *p;
> >> +
> >> +	ASSERT_RTNL();
> >> +
> >> +	list_for_each_entry(p, &br->port_list, list) {
> >> +		if (!br_promisc_port(p)) {
> >> +			err = dev_mc_add(p->dev, addr);
> >> +			if (err)
> >> +				goto undo;
> >> +		}
> >> +	}
> >> +
> >> +	return;
> >> +undo:
> >> +	list_for_each_entry_continue_reverse(p, &br->port_list, list) {
> >> +		if (!br_promisc_port(p))
> >> +			dev_mc_del(p->dev, addr);
> >> +	}
> >> +}
> >> +
> >>  /* When a static FDB entry is deleted, the HW address from that entry is
> >>   * also removed from the bridge private HW address list and updates all
> >>   * the ports with needed information.
> >> @@ -192,13 +215,27 @@ static void fdb_del_hw_addr(struct net_bridge *br, const unsigned char *addr)
> >>  	}
> >>  }
> >>  
> >> +static void fdb_del_hw_maddr(struct net_bridge *br, const unsigned char *addr)
> >> +{
> >> +	struct net_bridge_port *p;
> >> +
> >> +	ASSERT_RTNL();
> >> +
> >> +	list_for_each_entry(p, &br->port_list, list) {
> >> +		if (!br_promisc_port(p))
> >> +			dev_mc_del(p->dev, addr);
> >> +	}
> >> +}
> >> +
> >>  static void fdb_delete(struct net_bridge *br, struct net_bridge_fdb_entry *f,
> >>  		       bool swdev_notify)
> >>  {
> >>  	trace_fdb_delete(br, f);
> >>  
> >> -	if (f->is_static)
> >> +	if (f->is_static) {
> >>  		fdb_del_hw_addr(br, f->key.addr.addr);
> >> +		fdb_del_hw_maddr(br, f->key.addr.addr);
> > 
> > Walking over all ports again for each static delete is a no-go.
> > 
> >> +	}
> >>  
> >>  	hlist_del_init_rcu(&f->fdb_node);
> >>  	rhashtable_remove_fast(&br->fdb_hash_tbl, &f->rhnode,
> >> @@ -843,13 +880,19 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
> >>  			fdb->is_local = 1;
> >>  			if (!fdb->is_static) {
> >>  				fdb->is_static = 1;
> >> -				fdb_add_hw_addr(br, addr);
> >> +				if (flags & NLM_F_APPEND && !source)
> >> +					fdb_add_hw_maddr(br, addr);
> >> +				else
> >> +					fdb_add_hw_addr(br, addr);
> >>  			}
> >>  		} else if (state & NUD_NOARP) {
> >>  			fdb->is_local = 0;
> >>  			if (!fdb->is_static) {
> >>  				fdb->is_static = 1;
> >> -				fdb_add_hw_addr(br, addr);
> >> +				if (flags & NLM_F_APPEND && !source)
> >> +					fdb_add_hw_maddr(br, addr);
> >> +				else
> >> +					fdb_add_hw_addr(br, addr);
> >>  			}
> >>  		} else {
> >>  			fdb->is_local = 0;
> >>
> > 
> 

-- 
/Horatiu
