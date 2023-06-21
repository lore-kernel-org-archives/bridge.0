Return-Path: <j.granados@samsung.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C993F41DE7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9934141DA0
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20230621113629euoutp012b7600df2066e4bf78303bced9a8ed4e~qqYKol0t21354513545euoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1687347389;
 bh=xi7eTGf/eo7hL99txpODdPbOTqM8SUp1Uvq7GSYr9t0=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=HjKp+av5H9OWz9N+piZmYV0JdOXyasDQu7fP+oVjXb7Y+kVM0Io3ajx0enmD93+1o
 QfCtJMzVFDU6VNsScQsUkuUaPpqyeN3tDl929Z9gJ11rJnIBnBf90vEPEmWbs2ovDI
 ArrLVq+1RFmQTKQQj7R4dAFkdlj57Bg06J9ZJDN0=
Date: Wed, 21 Jun 2023 13:36:25 +0200
From: Joel Granados <j.granados@samsung.com>
Message-ID: <20230621113625.o54p6qfvr5duskfb@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="hjmbaevabjqfrodd"
Content-Disposition: inline
In-Reply-To: <dab06c20-f8b0-4e34-b885-f3537e442d54@kadam.mountain>
References: <20230621091000.424843-1-j.granados@samsung.com>
 <CGME20230621091022eucas1p1c097da50842b23e902e1a674e117e1aa@eucas1p1.samsung.com>
 <20230621091000.424843-7-j.granados@samsung.com>
 <dab06c20-f8b0-4e34-b885-f3537e442d54@kadam.mountain>
Subject: Re: [Bridge] [PATCH 06/11] sysctl: Add size to register_net_sysctl
	function
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Alexander Aring <alex.aring@gmail.com>, Nikolay Aleksandrov <razor@blackwall.org>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, David Howells <dhowells@redhat.com>, Eric Dumazet <edumazet@google.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Marc Dionne <marc.dionne@auristor.com>, Jan Karcher <jaka@linux.ibm.com>, Mat Martineau <martineau@kernel.org>, linux-afs@lists.infradead.org, Stefan Schmidt <stefan@datenfreihafen.org>, Steffen Klassert <steffen.klassert@secunet.com>, linux-s390@vger.kernel.org, rds-devel@oss.oracle.com, Xin Long <lucien.xin@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, Leon Romanovsky <leon@kernel.org>, dccp@vger.kernel.org, linux-rdma@vger.kernel.org, bridge@lists.linux-foundation.org, Jozsef Kadlecsik <kadlec@netfilter.org>, lvs-devel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, Julian Anastasov <ja@ssi.bg>, coreteam@netfilter.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Pablo Neira Ayuso <pablo@netfilter.org>, Martin Schiller <ms@dev.tdt.de>, Santosh Shilimkar <santosh.shilimkar@oracle.com>, linux-sctp@vger.kernel.org, Wenjia Zhang <wenjia@linux.ibm.com>, Simon Horman <horms@verge.net.au>, Remi Denis-Courmont <courmisch@gmail.com>, linux-hams@vger.kernel.org, mptcp@lists.linux.dev, tipc-discussion@lists.sourceforge.net, linux-x25@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>, netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Karsten Graul <kgraul@linux.ibm.com>, Jon Maloy <jmaloy@redhat.com>, mcgrof@kernel.org, netfilter-devel@vger.kernel.org, Joerg Reuter <jreuter@yaina.de>, Ying Xue <ying.xue@windriver.com>, Matthieu Baerts <matthieu.baerts@tessares.net>, linux-wpan@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

--hjmbaevabjqfrodd
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 12:47:30PM +0300, Dan Carpenter wrote:
> The patchset doesn't include the actual interesting changes, just a
> bunch of mechanical prep work.
Yep, The thread got mangled on the way out. But hopefully the rest of
the patch made its way to the lists and maintainers.

>=20
> On Wed, Jun 21, 2023 at 11:09:55AM +0200, Joel Granados wrote:
> > diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowp=
an/reassembly.c
> > index a91283d1e5bf..7b717434368c 100644
> > --- a/net/ieee802154/6lowpan/reassembly.c
> > +++ b/net/ieee802154/6lowpan/reassembly.c
> > @@ -379,7 +379,8 @@ static int __net_init lowpan_frags_ns_sysctl_regist=
er(struct net *net)
> >  	table[1].extra2	=3D &ieee802154_lowpan->fqdir->high_thresh;
> >  	table[2].data	=3D &ieee802154_lowpan->fqdir->timeout;
> > =20
> > -	hdr =3D register_net_sysctl(net, "net/ieee802154/6lowpan", table);
> > +	hdr =3D register_net_sysctl(net, "net/ieee802154/6lowpan", table,
> > +				  ARRAY_SIZE(lowpan_frags_ns_ctl_table));
>=20
> For example, in lowpan_frags_ns_sysctl_register() the sentinel is
> sometimes element zero if the user doesn't have enough permissions.  I
> would want to ensure that was handled correctly, but that's going to be
> done later in a completely different patchset.  I'm definitely not going
> to remember to check.
Very good catch! I have fixed this as well as ensure_safe_net_sysctl
that was missing a table_size arg.

>=20
> > diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
> > index dc5165d3eec4..6f96aae76537 100644
> > --- a/net/mpls/af_mpls.c
> > +++ b/net/mpls/af_mpls.c
> > @@ -1395,6 +1395,40 @@ static const struct ctl_table mpls_dev_table[] =
=3D {
> >  	{ }
> >  };
> > =20
> > +static int mpls_platform_labels(struct ctl_table *table, int write,
> > +				void *buffer, size_t *lenp, loff_t *ppos);
> > +#define MPLS_NS_SYSCTL_OFFSET(field)		\
> > +	(&((struct net *)0)->field)
> > +
> > +static const struct ctl_table mpls_table[] =3D {
> > +	{
> > +		.procname	=3D "platform_labels",
> > +		.data		=3D NULL,
> > +		.maxlen		=3D sizeof(int),
> > +		.mode		=3D 0644,
> > +		.proc_handler	=3D mpls_platform_labels,
> > +	},
> > +	{
> > +		.procname	=3D "ip_ttl_propagate",
> > +		.data		=3D MPLS_NS_SYSCTL_OFFSET(mpls.ip_ttl_propagate),
> > +		.maxlen		=3D sizeof(int),
> > +		.mode		=3D 0644,
> > +		.proc_handler	=3D proc_dointvec_minmax,
> > +		.extra1		=3D SYSCTL_ZERO,
> > +		.extra2		=3D SYSCTL_ONE,
> > +	},
> > +	{
> > +		.procname	=3D "default_ttl",
> > +		.data		=3D MPLS_NS_SYSCTL_OFFSET(mpls.default_ttl),
> > +		.maxlen		=3D sizeof(int),
> > +		.mode		=3D 0644,
> > +		.proc_handler	=3D proc_dointvec_minmax,
> > +		.extra1		=3D SYSCTL_ONE,
> > +		.extra2		=3D &ttl_max,
> > +	},
> > +	{ }
> > +};
> > +
> >  static int mpls_dev_sysctl_register(struct net_device *dev,
> >  				    struct mpls_dev *mdev)
> >  {
> > @@ -1410,7 +1444,7 @@ static int mpls_dev_sysctl_register(struct net_de=
vice *dev,
> >  	/* Table data contains only offsets relative to the base of
> >  	 * the mdev at this point, so make them absolute.
> >  	 */
> > -	for (i =3D 0; i < ARRAY_SIZE(mpls_dev_table); i++) {
> > +	for (i =3D 0; i < ARRAY_SIZE(mpls_dev_table) - 1; i++) {
>=20
> Adding the " - 1" is just a gratuitous change.  It's not required.
> It makes that patch more confusing to review.  And you're just going
> to have to change it back to how it was if you remove the sentinel.
Removed this for convenience. Thx.


>=20
> >  		table[i].data =3D (char *)mdev + (uintptr_t)table[i].data;
> >  		table[i].extra1 =3D mdev;
> >  		table[i].extra2 =3D net;
> > @@ -1418,7 +1452,8 @@ static int mpls_dev_sysctl_register(struct net_de=
vice *dev,
> > =20
> >  	snprintf(path, sizeof(path), "net/mpls/conf/%s", dev->name);
> > =20
> > -	mdev->sysctl =3D register_net_sysctl(net, path, table);
> > +	mdev->sysctl =3D register_net_sysctl(net, path, table,
> > +					   ARRAY_SIZE(mpls_dev_table));
> >  	if (!mdev->sysctl)
> >  		goto free;
> > =20
> > @@ -1432,6 +1467,7 @@ static int mpls_dev_sysctl_register(struct net_de=
vice *dev,
> >  	return -ENOBUFS;
> >  }
> > =20
> > +
Oops. thx. fixed

>=20
> Double blank line.
>=20
> >  static void mpls_dev_sysctl_unregister(struct net_device *dev,
> >  				       struct mpls_dev *mdev)
> >  {
>=20
> regards,
> dan carpenter

--=20

Joel Granados

--hjmbaevabjqfrodd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmSS4LkACgkQupfNUreW
QU/f/Av/R9arMJ/TiZiqAogcW91VL9TisCyhWWoGaao2pCurV0d4vQIZ22no1jLz
HOEQ8SmtnWRZeyVNdgB7JZ5LM1wEGu3I/NnYEThVwKKblsSErfTYdUKTi5VyBDUj
UjuPXKvJPdKhW8XwN/d5gKHeY8ugeCZI82AEKP3qqv/p+Tsai8fqlTU4frjB77C2
pi6zJv+WXkEUknsHnTZQJBV+TL+UJaghgjkhV0QWf8n0dzveTLsK7XhKQxszk067
fos0Ckxs3JrFiC8eWPX7/Qm8H2qg64O2Y51uD8ahz0EcUWxV8f1UDk4PsgUvACu1
oEVx/n+aGQGKiOafURew4esnRnmhet8t8EkTGoEQaxqsU7jXnClyR5DWTrVDnT3c
YHUavHdXH0qCFQoTXaa2YWcds8WpmPuzEDQLnAmhoOKr8C4+NUri6y0HGdBTwHcG
rQCCd2NcjGCEepKDVkuvJkoMkfj72FpOK+jb+M7K0JQIsRKxKDhPLo31xiesBx05
mm4+Slxp
=d3wP
-----END PGP SIGNATURE-----

--hjmbaevabjqfrodd--
