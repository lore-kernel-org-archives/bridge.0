Date: Sun, 27 Mar 2011 09:06:45 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20110327070645.GA1734@Sellars>
References: <20110327034404.GC31916@Sellars>
	<1301207244-10428-1-git-send-email-linus.luessing@web.de>
	<1301207244-10428-2-git-send-email-linus.luessing@web.de>
	<20110327063749.GA24299@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20110327063749.GA24299@gondor.apana.org.au>
Sender: linus.luessing@web.de
Subject: Re: [Bridge] [PATCH] bridge: mcast snooping,
 fix IPv6 MLD checksum calculation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Herbert Xu <herbert@gondor.hengli.com.au>
Cc: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, David Miller <davem@davemloft.net>

So instead of 'if (!csum_fold(skb2->csum))' it should be this?
---
if (!csum_ipv6_magic(&ip6h->saddr, &ip6h->daddr,
                     skb2->len, nexthdr, skb2->csum))
---
(I'm peeking a little bit at
http://lxr.linux.no/linux+*/net/ipv6/netfilter.c#L98)

Hmm, if so, then I don't know how to test and verify that now though.

Cheers, Linus

On Sun, Mar 27, 2011 at 02:37:49PM +0800, Herbert Xu wrote:
> On Sun, Mar 27, 2011 at 08:27:23AM +0200, Linus Lüssing wrote:
> > In contrast to IGMP, the MLDv1/2 message checksum needs to include an
> > IPv6 "pseudo-header" in the calculations (see RFC2710, section 3.3;
> > RFC3810, section 5.1.2).
> > 
> > The multicast snooping feature of the bridge code however did not take
> > this "pseudo-header" into consideration for the checksum validation when
> > parsing a snooped IPv6 MLDv1/2 message of another host, leading to
> > possibly ignored, though valid MLDv1/2 messages. This commit shall fix
> > this issue.
> > 
> > Signed-off-by: Linus Lüssing <linus.luessing@web.de>
> > ---
> >  net/bridge/br_multicast.c |    5 ++++-
> >  1 files changed, 4 insertions(+), 1 deletions(-)
> > 
> > diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> > index f61eb2e..47fae4f 100644
> > --- a/net/bridge/br_multicast.c
> > +++ b/net/bridge/br_multicast.c
> > @@ -1525,7 +1525,10 @@ static int br_multicast_ipv6_rcv(struct net_bridge *br,
> >  			break;
> >  		/*FALLTHROUGH*/
> >  	case CHECKSUM_NONE:
> > -		skb2->csum = 0;
> > +		skb2->csum = ~csum_unfold(csum_ipv6_magic(&ip6h->saddr,
> > +							  &ip6h->daddr,
> > +							  skb2->len,
> > +							  nexthdr, 0));
> 
> You also need to include the pseudo-header for the CHECKSUM_COMPLETE
> case, before we've fallen through (which only happens if the
> hardware checksum doesn't match).
> 
> Thanks,
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
> 
