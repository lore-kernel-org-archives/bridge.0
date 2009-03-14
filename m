From: Scott James Remnant <scott@canonical.com>
In-Reply-To: <20090313.142718.21189207.davem@davemloft.net>
References: <cover.1236702228.git.scott@canonical.com>
	<74b87ec3359e6e65d59cd6fb62a83fb469e6c8ae.1236702228.git.scott@canonical.com>
	<20090313.142718.21189207.davem@davemloft.net>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-dDC1ANfaqXwhvNJEzGrz"
Date: Sat, 14 Mar 2009 10:36:34 +0000
Message-Id: <1237026994.29975.19.camel@quest>
Mime-Version: 1.0
Subject: Re: [Bridge] [PATCH 01/31] bridge: Auto-load bridge module when
 socket opened.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org


--=-dDC1ANfaqXwhvNJEzGrz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2009-03-13 at 14:27 -0700, David Miller wrote:

> Did you verify that these changes actually do something?
> Or did you blindly run around peppering source files with
> these annotations?
>=20
I converted existing modprobe aliases that most distributions are
carrying around into the one-line kernel patches.

I tested the important ones such as the floppy and ch changes.

If the patches are wrong, which I personally suspected many of them
were, then it's a good example as to why distributions shouldn't hack
around the kernel in userspace, or keep their own patches.

So yes, they're a bit stinky (hell, I even fluffed up the covering mail
subject line <g>) - but distros including Ubuntu were trying to do these
aliases in modprobe rules, so it's a good thing to find out that they're
wrong; no?

Scott
--=20
Scott James Remnant
scott@canonical.com

--=-dDC1ANfaqXwhvNJEzGrz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkm7iLIACgkQSnQiFMl4yK75vQCfbMVoqidrsrcITKItzKaAc5SC
1OoAnioB4Tjlo9IBrxphSw/1wFq/h+D8
=yi2y
-----END PGP SIGNATURE-----

--=-dDC1ANfaqXwhvNJEzGrz--

