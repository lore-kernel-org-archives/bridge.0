Return-Path: <j.granados@samsung.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CDC7160AD4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A5B5860A94
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20230809071323euoutp015d2b996c65b2b9125c2fa606849b0eb7~5pZb-us8e0911009110euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1691565203;
 bh=pd0rkBBl239hWUg1rHcfh8BtHyeO6HyV2u6nDFSCWm0=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=XJ3SeBQkhJ7ZaOnSLxtM3BytZFFQVnU3UGIPJpukUn8AgLqEqNqS+MstyY5OdroTM
 GdbqsR2lXlr3UHMyvKPDA5ajb5C5q9GmO7KzPcM796hL5FqKq2HOoxqmLBBjhJqVjQ
 Hs5UChvxttSTzpTOYv5BpP1svXsa/HlFU8gSljBw=
Date: Tue, 8 Aug 2023 15:59:53 +0200
From: Joel Granados <j.granados@samsung.com>
Message-ID: <20230808135953.l2y6gj7j272434fw@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="h3c25ibwzmlgmjj3"
Content-Disposition: inline
In-Reply-To: <CANnsUMGHnurbph9F7mex=1s0mxhwpNgeQbKJ6j1r37Qmd6LAMQ@mail.gmail.com>
References: <20230731071728.3493794-1-j.granados@samsung.com>
 <ZMgpck0rjqHR74sl@bombadil.infradead.org>
 <ZNFlqwwvE6w6HyHl@bombadil.infradead.org>
 <CANnsUMG3WO_19GpnsNaXPqu6eEnpBvYUpkrf1QbHwsc9wEoCZQ@mail.gmail.com>
 <ZNGBrkP7J2g/BAWV@bombadil.infradead.org>
 <CANnsUMGRBnatKB4-3eYjb5aG7YnXDiZG6cjuwSgtjvVF6ErJNg@mail.gmail.com>
 <ZNGv3Q5VBsS2/w4e@bombadil.infradead.org>
 <CGME20230808030739eucas1p2192f620771cb9655afdbcd624775b4c8@eucas1p2.samsung.com>
 <CANnsUMGHnurbph9F7mex=1s0mxhwpNgeQbKJ6j1r37Qmd6LAMQ@mail.gmail.com>
Subject: Re: [Bridge] [PATCH v2 00/14] sysctl: Add a size argument to
 register functions in sysctl
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Chris Maness <christopher.maness@gmail.com>
Cc: Alexander Aring <alex.aring@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Nikolay Aleksandrov <razor@blackwall.org>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, netfilter-devel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Paolo Abeni <pabeni@redhat.com>, Jan Karcher <jaka@linux.ibm.com>, Jozsef Kadlecsik <kadlec@netfilter.org>, Tony Lu <tonylu@linux.alibaba.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Stefan Schmidt <stefan@datenfreihafen.org>, Steffen Klassert <steffen.klassert@secunet.com>, linux-s390@vger.kernel.org, rds-devel@oss.oracle.com, Xin Long <lucien.xin@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, linux-rdma@vger.kernel.org, Will Deacon <will@kernel.org>, bridge@lists.linux-foundation.org, willy@infradead.org, Mat Martineau <martineau@kernel.org>, lvs-devel@vger.kernel.org, Julian Anastasov <ja@ssi.bg>, coreteam@netfilter.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Iurii Zaikin <yzaikin@google.com>, Joerg Reuter <jreuter@yaina.de>, Sven Schnelle <svens@linux.ibm.com>, Kees Cook <keescook@chromium.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Santosh Shilimkar <santosh.shilimkar@oracle.com>, linux-sctp@vger.kernel.org, josh@joshtriplett.org, Wenjia Zhang <wenjia@linux.ibm.com>, Simon Horman <horms@verge.net.au>, linux-hams@vger.kernel.org, mptcp@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Christian Borntraeger <borntraeger@linux.ibm.com>, netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, "David S. Miller" <davem@davemloft.net>, Luis Chamberlain <mcgrof@kernel.org>, Wen Gu <guwen@linux.alibaba.com>, Pablo Neira Ayuso <pablo@netfilter.org>, "D. Wythe" <alibuda@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, Matthieu Baerts <matthieu.baerts@tessares.net>, linux-wpan@vger.kernel.org, Karsten Graul <kgraul@linux.ibm.com>

--h3c25ibwzmlgmjj3
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 07, 2023 at 08:07:24PM -0700, Chris Maness wrote:
> >
> > Are you reporting a separate regression that goes all the way back to v=
4 kernels?
> >
>=20
> I am not certain what you mean by regression.
>=20
> > > v2 is fine there.
> >
> > What does this mean?
>=20
> I have to go all the way back to kernel version 2 for the serial 6PACK
> driver to work.  If I try to use it in Kernel version 4, 5, or 6 the
> kernel panics as soon as I attempt to connect to another station.
Again. Have you reached out to Andreas Koensgen
<ajk@comnets.uni-bremen.de>? Maybe he has more info on this.

Best

>=20
> >
> >   Luis
>=20
> Chris KQ6UP
>=20
>=20
> --=20
> Thanks,
> Chris Maness

--=20

Joel Granados

--h3c25ibwzmlgmjj3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmTSSlkACgkQupfNUreW
QU8zQQv/csq4fZgijsNRirYRY4BuHiERw8G3UuPFIPemEFB+C72FHbLDK66oqfKN
8AvTZLmXSA90J1kikzqAhrHgXqDgl4lOVwf6XZ+n2rBYuPlay1XSyC3/RlBrDOiS
cmddkmwrrbZpE3aW7uXV5H5eLFmnLds5C5I6Ui9bEbnJthaJGXCXTbwUXpFFh8B/
EMsFVsOG+Ek2KycdHGtsm6Lcrst2N0+cSWLSu35IXZEi2jB22fhn2PEF0kvtrL4X
bCQVgIPuWI4Q7PtdmMG4ewdSZFbVnbg+42EFMTGjdjOu7DkrTFMwl93/febfP84X
oUz7KjNP/ez3A54qqcjN1YgUIQKJLhO95BZTl9ZI1eqcrsg0HuxUGd6cpWxOT1ZD
xiJNJUhscRd1xE592veXF6+aXotpJvyEWWb39/bf1HAE0Kjr2DljSslkr8lsjQEh
4wP3OB5LIp/YVT6urTAiHoL+vJGA3TWIMfLwSWTmvu6ePiLpFZwEpmcBQNnGzm67
jHdxey6Y
=slPS
-----END PGP SIGNATURE-----

--h3c25ibwzmlgmjj3--
