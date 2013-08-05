Return-Path: <linus.luessing@web.de>
Date: Tue, 6 Aug 2013 00:40:59 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20130805224059.GG25436@Linus-Debian>
References: <20130730.161035.1646022729333223847.davem@davemloft.net>
	<1375311980-25575-1-git-send-email-linus.luessing@web.de>
	<20130731.174037.1794753574143053874.davem@davemloft.net>
	<1375692066.25148.14.camel@x61.thuisdomein>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1375692066.25148.14.camel@x61.thuisdomein>
Subject: Re: [Bridge] [PATCHv3] bridge: disable snooping if there is no
	querier
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Paul Bolle <pebolle@tiscali.nl>
Cc: herbert@gondor.apana.org.au, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux@baker-net.org.uk, stephen@networkplumber.org, linus.luessing@web.de, David Miller <davem@davemloft.net>, amwang@redhat.com

Thanks for the very quick reporting! Looks like my gcc was and still
isn't as supportive... You and the lists should have received a patch
to fix that.

Cheers, Linus


On Mon, Aug 05, 2013 at 10:41:06AM +0200, Paul Bolle wrote:
> On Wed, 2013-07-31 at 17:40 -0700, David Miller wrote:
> > > If there is no querier on a link then we won't get periodic reports and
> > > therefore won't be able to learn about multicast listeners behind ports,
> > > potentially leading to lost multicast packets, especially for multicast
> > > listeners that joined before the creation of the bridge.
> > > 
> > > These lost multicast packets can appear since c5c23260594
> > > ("bridge: Add multicast_querier toggle and disable queries by default")
> > > in particular.
> > > 
> > > With this patch we are flooding multicast packets if our querier is
> > > disabled and if we didn't detect any other querier.
> > > 
> > > A grace period of the Maximum Response Delay of the querier is added to
> > > give multicast responses enough time to arrive and to be learned from
> > > before disabling the flooding behaviour again.
> > > 
> > > Signed-off-by: Linus Lüssing <linus.luessing@web.de>
> > 
> > Looks good, applied, thanks Linus.
> 
> 0) This patch is part of v3.11-rc4 as commit b00589af3b0. It introduced
> a GCC warning:
>     net/bridge/br_multicast.c: In function ‘br_multicast_rcv’:
>     net/bridge/br_multicast.c:1081:36: warning: ‘max_delay’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>     net/bridge/br_multicast.c:1178:16: note: ‘max_delay’ was declared here
> 
> 1) Summarized, the code reads:
> 
>         unsigned long max_delay;
> 
>         if (skb->len == sizeof(*mld))
>                 max_delay = msecs_to_jiffies(ntohs(mld->mld_maxdelay));
>         else if (skb->len >= sizeof(*mld2q))
>                 max_delay = mld2q->mld2q_mrc ? MLDV2_MRC(ntohs(mld2q->mld2q_mrc)) : 1;
> 
>         br_multicast_query_received(br, port, !ipv6_addr_any(&ip6h->saddr),
>                                     max_delay);
>  
> So GCC notices that max_delay is still uninitialized if skb->len is
> neither equal to sizeof(*mld) nor equal or bigger than sizeof(*mld2q).
> To me it looks GCC is right here. At least, it is not obvious that
> max_delay will actually not be used in br_multicast_query_received() if
> it still is uninitialized.
> 
> 2) I'm entirely unfamiliar to this code. So I can't say how this warning
> might be silenced.
> 
> 
> Paul Bolle
> 
