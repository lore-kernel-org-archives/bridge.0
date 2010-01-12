From: Ross Vandegrift <ross@kallisti.us>
Date: Tue, 12 Jan 2010 16:32:23 -0500
Message-ID: <20100112213223.GD23219@kallisti.us>
References: <20100112152317.GB23219@kallisti.us>
	<001485e72564c1387e047cf94f54@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SO98HVl1bnMOfKZd"
Content-Disposition: inline
In-Reply-To: <001485e72564c1387e047cf94f54@google.com>
Subject: Re: [Bridge]
	=?iso-8859-1?q?Re=A0=3ARe=3A__Bridging_LACP_=28802=2E3ad?=
	=?iso-8859-1?q?=29_frames_not=09working?=
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: jhautbois@gmail.com
Cc: bridge@lists.linux-foundation.org


--SO98HVl1bnMOfKZd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 12, 2010 at 03:28:53PM +0000, jhautbois@gmail.com wrote:
> OK, I agree, it doesn't make sense, but I want to be transparent using =
=20
> bridging. I can't explain my idea :).

You can't be transparent with respect to LACP if you're using ethernet
to bridge.  It doesn't make sense - LACP is negotiated between bridge
ports on a point-to-point ethernet interface.

> You mean I need to have four physical interfaces ?
> I can't understand how too accomplish this.
> Currently, I am doing :
> brctl addif eth1
> brctl addif eth2

No - you don't need four physical interfaces.  I was trying to
extrapolate what problem you might be trying to solve, and I think I
guessed wrong.  I imagined that you needed a multi-interface bundle
through a Linux bridge.

If you just want your box to speak LACP to the adjacent switches, you
could easily make bond interfaces with single ethernet interfaces.
But it sounds like you don't want to speak LACP to the switches, you
want to pass it as if you were a layer 1 device.

Ross

--=20
Ross Vandegrift
ross@kallisti.us

"If the fight gets hot, the songs get hotter.  If the going gets tough,
the songs get tougher."
	--Woody Guthrie

--SO98HVl1bnMOfKZd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktM6mcACgkQMlMoONfO+HBwUgCgoYQKsi+Yrz0Pc1MGQeV0rj1M
YecAoI5Fb3P6ELmCZsVgDtNBGEORjLnq
=RxP8
-----END PGP SIGNATURE-----

--SO98HVl1bnMOfKZd--
