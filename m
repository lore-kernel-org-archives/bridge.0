Return-Path: <fw@strlen.de>
Date: Fri, 9 Mar 2018 17:26:08 +0100
From: Florian Westphal <fw@strlen.de>
Message-ID: <20180309162608.GC19924@breakpoint.cc>
References: <1424705163-13428-1-git-send-email-imrep.amz@gmail.com>
	<20150223160619.GF24297@breakpoint.cc> <54EEF32D.2010202@amazon.de>
	<20150226.113431.238255529591339000.davem@davemloft.net>
	<54F982B5.90108@gmail.com> <20150306142932.GA15926@salvia>
	<20150306163700.GC20382@breakpoint.cc>
	<1520609475.17937.42.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1520609475.17937.42.camel@infradead.org>
Subject: Re: [Bridge] [RFC PATCH v2] bridge: make it possible for packets to
 traverse the bridge without hitting netfilter
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Woodhouse <dwmw2@infradead.org>
Cc: nbd@openwrt.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, aliguori@amazon.com, rga@amazon.de, David Miller <davem@davemloft.net>, Pablo Neira Ayuso <pablo@netfilter.org>

David Woodhouse <dwmw2@infradead.org> wrote:
>=20
>=20
> On Fri, 2015-03-06 at 17:37 +0100, Florian Westphal wrote:
> >=20
> > > > I did performance measurements in the following way:
> > > >=A0
> > > > Removed those pieces of the packet pipeline that I don't necessarily
> > > > need one-by-one.=A0 Then measured their effect on small packet
> > > > performance.
> > > >=A0
> > > > This was the only part that produced considerable effect.
> > > >=A0
> > > > The pure speculation was about why the effect is more than 15%
> > > > increase in packet throughput, although the code path avoided
> > > > contains way less code than 15% of the packet pipeline.=A0 It seems,
> > > > Felix Fietkau profiled similar changes, and found my guess well
> > > > founded.
> > > >=A0
> > > > Now could anybody explain me what else is wrong with my patch?
> > >=A0
> > > We have to come up with a more generic solution for this.
> >=20
> > Jiri Benc suggested to allowing to attach netfilter hooks e.g. via tc
> > action, maybe that would be an option worth investigating.
> >=20
> > Then you could for instance add filtering rules only to the bridge port
> > that needs it.
> >=20
> > > These sysfs tweaks you're proposing look to me like an obscure way to
> > > tune this.
> >=20
> > I agree, adding more tunables isn't all that helpful, in the past this
> > only helped to prolong the problem.
>=20
> How feasible would it be to make it completely dynamic?
>=20
> A given hook could automatically disable itself (for a given device) if
> the result of running it the first time was *tautologically* false for
> that device (i.e. regardless of the packet itself, or anything else).
>=20
> The hook would need to be automatically re-enabled if the rule chain
> ever changes (and might subsequently disable itself again).
>=20
> Is that something that's worth exploring for the general case?

AF_BRIDGE hooks sit in the net namespace, so its enough for
one bridge to request filtering to bring in the hook overhead for all
bridges in the same netns.

Alternatives:
- place the bridges that need filtering in different netns
- use tc ingress for filtering
- use nftables ingress hook for filtering (it sits in almost same
  location as tc ingress hook) to attach the ruleset to those bridge
  ports that need packet filtering.

(The original request came from user with tons of bridges where only
 one single bridge needed filtering).

One alternative I see is to place the bridge hooks into the
bridge device (net_bridge struct, which is in netdev private area).

But, as you already mentioned we would need to annotate the hooks
to figure out which device(s) they are for.

This sounds rather fragile to me, so i would just use nft ingress:

#!/sbin/nft -f

table netdev ingress {
  chain in_public { type filter hook ingress device eth0 priority 0;
   ip saddr 192.168.0.1 counter
 }
}
