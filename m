Return-Path: <pneira@us.es>
Date: Fri, 24 Jun 2016 10:51:28 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20160624085128.GA1939@salvia>
References: <f39576f17e9f5dee35258917917f2d740e820a77.1466024030.git.joe@perches.com>
	<20160623173659.GA3474@salvia>
	<1466708400.1847.15.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1466708400.1847.15.camel@perches.com>
Subject: Re: [Bridge] [PATCH] bridge: netfilter: spanning tree: Add
 masked_ether_addr_equal and neatening
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joe Perches <joe@perches.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Patrick McHardy <kaber@trash.net>, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, "David S. Miller" <davem@davemloft.net>

On Thu, Jun 23, 2016 at 12:00:00PM -0700, Joe Perches wrote:
> On Thu, 2016-06-23 at 19:36 +0200, Pablo Neira Ayuso wrote:
> > On Wed, Jun 15, 2016 at 01:58:45PM -0700, Joe Perches wrote:
> > >=20
> > > There is code duplication of a masked ethernet address comparison here
> > > so make it a separate function instead.
> > >=20
> > > Miscellanea:
> > >=20
> > > o Neaten alignment of FWINV macro uses to make it clearer for the rea=
der
> > Applied, thanks.
> >=20
> > >=20
> > > Signed-off-by: Joe Perches <joe@perches.com>
> > > ---
> > >=20
> > > This masked_ether_addr_equal function could go into etherdevice.h,
> > > but I don't see another use like it in kernel code.=A0=A0Is there one?
> >
> > This is specific of iptables, not even nftables would use this. So I
> > would keep this in the iptables tree.
>=20
> Did you see the other patch that adds a generic
> ether_addr_equal_masked() and uses it in a few
> more files?

You mean this one:

        http://patchwork.ozlabs.org/patch/636208/

OK, so I'll toss the previous and will take this one instead.

As I said my opinion is that ether_addr_equal_masked() is only
required by netfilter, but thinking it well I don't really mind in
what header this function is placed given that these are our internal
headers.

Thanks.
