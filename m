Date: Sun, 12 Sep 2004 14:11:23 +0200
Subject: Re: [Bridge] Sparc64 bug in 1.0.4
Message-ID: <20040912141123.A22682@macwheel.xs4all.nl>
References: <20040804010230.GH21309@riseup.net>
	<33094.63.170.215.71.1091592938.squirrel@www.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <33094.63.170.215.71.1091592938.squirrel@www.osdl.org>;
	from shemmingeratosdl.org on Tue, Aug 03, 2004 at 08:15:38PM +0000
From: stappers@stappers.nl (Geert Stappers)
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 03, 2004 at 08:15:38PM +0000, shemminger@osdl.org wrote:
> >
> > Under sparc64, with the bridge module loaded, running brctl addbr br0
> > results in:
> >
> > add bridge failed: Operation not supported
> > sys32_ioctl(brctl:6667): Unknown cmd fd(3) cmd(000089a0) arg(effffbf9)
>=20
> What version is the kernel you are using?
I can reproduce it on 2.4.26

> If it isn't 2.6.7 or later it probably won't work.
What does that mean?
brctl needs 2.6.7 or later?
When kernel older then 2.6.7, then brctl fails?

And additional:
Are other 64 bits architectures like powerpc effected?
Or is about all architectures?


Cheers
Geert Stappers

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBRDzrOSINbgwa/7sRAnBhAKDHlP0v7c+QkWxF6dr1tv+RsTNUxQCcC3Jv
YhV95KStJKitZKm9q9q/vzQ=
=lrKn
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
