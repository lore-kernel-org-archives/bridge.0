Return-Path: <pneira@us.es>
Date: Thu, 7 Dec 2017 01:26:19 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20171207002619.GB28145@salvia>
References: <20171125074418.16537-1-linus.luessing@c0d3.blue>
	<20171127233008.GA1418@salvia> <20171204045335.GE3307@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20171204045335.GE3307@otheros>
Subject: Re: [Bridge] [PATCH net-next] bridge: ebtables: Avoid resetting
 limit rule state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, "David S . Miller" <davem@davemloft.net>

Hi Linus,

On Mon, Dec 04, 2017 at 05:53:35AM +0100, Linus L=FCssing wrote:
> Hi Pablo,
>=20
> Thanks for your reply!
>=20
> On Tue, Nov 28, 2017 at 12:30:08AM +0100, Pablo Neira Ayuso wrote:
> > [...]
> > > diff --git a/net/bridge/netfilter/ebt_limit.c b/net/bridge/netfilter/=
ebt_limit.c
> > > index 61a9f1be1263..f74b48633feb 100644
> > > --- a/net/bridge/netfilter/ebt_limit.c
> > > +++ b/net/bridge/netfilter/ebt_limit.c
> > > @@ -69,6 +69,10 @@ static int ebt_limit_mt_check(const struct xt_mtch=
k_param *par)
> > >  {
> > >  	struct ebt_limit_info *info =3D par->matchinfo;
> > > =20
> > > +	/* Do not reset state on unrelated table changes */
> > > +	if (info->prev)
> > > +		return 0;
> >=20
> > What kernel version are you using? I suspect you don't have this
> > applied?
>=20
> I'm indeed using a 4.4.102 kernel, as LEDE is still in the process
> of updating to 4.14. So 4.4 with LEDE is where I got the measurement
> results from.
>=20
> >=20
> > commit ec23189049651b16dc2ffab35a4371dc1f491aca
> > Author: Willem de Bruijn <willemb@google.com>
> > Date:   Mon Jan 2 17:19:46 2017 -0500
> >=20
> >     xtables: extend matches and targets with .usersize
>=20
> And so, no I do not have this patch. I looked at it now, but it
> does not seem to have any relation with .matchinfo, does it?
>=20
> I also had a quick look at a 4.15-rc1 kernel in a VM now. I still
> end up in ebt_limit_mt_check() with the variables being reset
> when editing the table somewhere.

My question is if your fix would work with 4.15-rc1.
