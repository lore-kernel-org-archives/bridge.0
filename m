Return-Path: <linus.luessing@web.de>
Date: Wed, 10 Sep 2014 15:33:41 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20140910133341.GI7058@odroid>
References: <20140324094107.2cfbf103@nehalam.linuxnetplumber.net>
	<20140325125231.GW6008@Linus-Debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20140325125231.GW6008@Linus-Debian>
Subject: Re: [Bridge] Multicast packets being lost (3.10 stable)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: openwrt-devel@lists.openwrt.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, bridge@lists.linux-foundation.org, David Miller <davem@davemloft.net>, Stephen Hemminger <shemming@brocade.com>

I just got a complaint about bridges, multicast and a
3.10 kernel again. Seems like nobody had any objections about
queueing these two patches for stable ( 2)+3) )?

Also I'm still missing some more fixes in the stable branches.
Especially 5), 6) and 7) are of high priority (next to 2) and 3) )
in my opinion as otherwise IPv6 in general could be broken for people
using 3.12 or 3.13 (as 3.12 contains a patch which activates
multicast snooping for link-local addresses, too: 3c3769e63).

Here is a more ordered list of patches I'd suggest to be queued for
stable:

1) bridge: fix switched interval for MLD Query types
   -> 32de868cb (present since 3.10)
2) bridge: disable snooping if there is no querier
   -> b00589af3 (present since 3.11)
3) bridge: don't try to update timers in case of broken MLD queries
   -> 248ba8ec0 (present since 3.11)
4) Revert "bridge: only expire the mdb entry when query is received"
   -> 454594f3b (present since 3.12)
5) bridge: multicast: add sanity check for query source addresses
   -> 6565b9eee (present since 3.14)
6) bridge: multicast: add sanity check for general query destination
   -> 9ed973cc4 (present since 3.14)
7) bridge: multicast: enable snooping on general queries only
   -> 20a599bec (present since 3.14)

Let me know what you'd think about that or if there's any trouble
applying them to older kernels.

Cheers, Linus


On Tue, Mar 25, 2014 at 02:06:07PM +0100, Linus Lüssing wrote:
> That commit is supposed to be a fix and seems to be a easily
> cherry-pickable on top of 3.10. So I think it's suitable for
> stable
> 
> There are two follow-up commit for this particular patch that I'm aware
> of: "bridge: separate querier and query timer into IGMP/IPv4
> and MLD/IPv6 ones" (cc0fdd80). That's just an optimization
> and can be ignored for stable.
> 
> The second one is "bridge: don't try to update timers in case of
> broken MLD queries" (248ba8ec0). Which is a direct fix for
> b00589af3 and should therefore go into stable, too, if b00589af3
> goes into stable.
> 
> Cheers, Linus
> 
> 
> On Mon, Mar 24, 2014 at 09:41:07AM -0700, Stephen Hemminger wrote:
> > We are seeing multicast snooping related issues.
> > Is there some reason this commit never went into stable (3.10)
> > 
> > commit b00589af3b04736376f24625ab0b394642e89e29
> > Author: Linus Lüssing <linus.luessing@web.de>
> > Date:   Thu Aug 1 01:06:20 2013 +0200
> > 
> >     bridge: disable snooping if there is no querier
> >     
> >     If there is no querier on a link then we won't get periodic reports and
> >     therefore won't be able to learn about multicast listeners behind ports,
> >     potentially leading to lost multicast packets, especially for multicast
> >     listeners that joined before the creation of the bridge.
> >     
> >     These lost multicast packets can appear since c5c23260594
> >     ("bridge: Add multicast_querier toggle and disable queries by default")
> >     in particular.
> >     
> >     With this patch we are flooding multicast packets if our querier is
> >     disabled and if we didn't detect any other querier.
> >     
> >     A grace period of the Maximum Response Delay of the querier is added to
> >     give multicast responses enough time to arrive and to be learned from
> >     before disabling the flooding behaviour again.
> >     
> >     Signed-off-by: Linus Lüssing <linus.luessing@web.de>
> >     Signed-off-by: David S. Miller <davem@davemloft.net>
