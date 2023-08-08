Return-Path: <j.granados@samsung.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 45A2C4119B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B7937404D1
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20230809071321euoutp01daffd5f6a01edf39fc36d5af9cc9ab2d~5pZa-JLBS0907609076euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1691565202;
 bh=V7AXA3XKbCTJdCLCEcFa9yONVo03/VAYcmjCmAIVm/0=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=PbTANdOUFchwh/zQnW95iisuOL+LirFf8CuGNyW/Oa7KXicswQbaSCFd0qWjoU5sm
 TwaZARytYxnAfU11yAZNn/ZXPrBy/vqVu84xMjebQSH0XOYXEuG/Zh0hyMdQcUrAaU
 jrG4mDGWwLdWv3/TIZjPL8jtNkNRvz2u9E9bbhkg=
Date: Tue, 8 Aug 2023 15:58:47 +0200
From: Joel Granados <j.granados@samsung.com>
Message-ID: <20230808135847.46ln434mbpiiklvz@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="x4zdqo2w6ogqmllb"
Content-Disposition: inline
In-Reply-To: <CANnsUMGRBnatKB4-3eYjb5aG7YnXDiZG6cjuwSgtjvVF6ErJNg@mail.gmail.com>
References: <20230731071728.3493794-1-j.granados@samsung.com>
 <ZMgpck0rjqHR74sl@bombadil.infradead.org>
 <ZNFlqwwvE6w6HyHl@bombadil.infradead.org>
 <CANnsUMG3WO_19GpnsNaXPqu6eEnpBvYUpkrf1QbHwsc9wEoCZQ@mail.gmail.com>
 <ZNGBrkP7J2g/BAWV@bombadil.infradead.org>
 <CGME20230808025059eucas1p24caeb224edb8f4fce693364913a37841@eucas1p2.samsung.com>
 <CANnsUMGRBnatKB4-3eYjb5aG7YnXDiZG6cjuwSgtjvVF6ErJNg@mail.gmail.com>
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

--x4zdqo2w6ogqmllb
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Chris

My questions inline
On Mon, Aug 07, 2023 at 07:50:44PM -0700, Chris Maness wrote:
> I tried running the current mainline kernel (current Arch Linux) with
What kernel version are we talking about exactly here? Please notice the
base that I used in the cover letter (rc2 or rc3). They should also
rebase cleanly on top of v6.5-rc5.

I'm not sure what the patches will do if you apply them to an older
kernel.

> simple single MUX socket (ax0) using LinFBB.  I was a happy camper as
> it seemed to work fine at first, then the system just slowed to a
> crawl.  I am wondering if any of these patches are addressing this
> behavior.  No kernel panic like before, but not what I was hoping for.
So you have been experiencing kernel panics from before? What does
before mean? And can you bisect to pinpoint what commit fixed it?

> I have also tried sixpack, and that explodes instantly the last time I
> have checked.   That goes all the way back to the v4 kernels.  v2 is
> fine there.
You mean that 6pack is broken in all the major versions up until v2? If
this is the case, then it might be an issue that is not related to this
patchset.I see that Andreas Koensgen <ajk@comnets.uni-bremen.de> is the
maintainer of 6pack, maybe he can chime in on the issue?

>=20
> 73 de Chris KQ6UP
>=20
> On Mon, Aug 7, 2023 at 4:43=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.or=
g> wrote:
> >
> > On Mon, Aug 07, 2023 at 04:00:49PM -0700, Chris Maness wrote:
> > > When are these likely to hit the mainline release code?
> >
> > linux-next tomorrow. The first 7 patches are scheduled for mainline
> > as they were merged + tested without any hiccups. These last few patches
> > I'll wait and see. If nothing blows up on linux-next perhaps I'll
> > include them to Linux for mainline during the next merge window.
> >
> >   Luis
>=20
>=20
>=20
> --=20
> Thanks,
> Chris Maness

--=20

Joel Granados

--x4zdqo2w6ogqmllb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmTSShUACgkQupfNUreW
QU9V5Qv9EPEpi2TR8AnLqIPU7OhWjIi17BiRDGt3v4ld7gPtc9IDscWkSVOlkMHp
CJsDbzP6uifAXxWYA/eqroOI7XNJn4YT96BVArmjzPBNAtMyqIyKQtqWvtlmLxnQ
1XsF8kk8rkIguKbfvLeU26KBKXpy4ET8XODODPl1jVqo+/ztgRB85ZujCqeqwLah
Qk249z8JImXEI4zYMoh7TPqKNSWFCkWoyRsVc+nlDPoPvl82b0pDATR5N5j4uU9+
QB1sNVZkgWXqu7Z+Pfmy7UgtSd5AO9juaaCpVdROh6FXtrP1xxnIS4qdL71H4n57
hpLxWSjLlm4S24sfl46pbCAfGU5iWM1QSe0nMquMfG+SR0uLyuDs3FvHsEeXzATE
KzjhrFGiEXkBUtJW4L/rKGMa2vJBs6TWEuA9tlWvJF7U6E6WapKJNI8TrZjt1DlX
TeV+PipASlYIhVb2o+ZRbbSJIVkr88vGBEBlsn8LOODSL/BACgWfhvrwmVDFqf8m
LXyRMUq6
=mpca
-----END PGP SIGNATURE-----

--x4zdqo2w6ogqmllb--
