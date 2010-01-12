From: Ross Vandegrift <ross@kallisti.us>
Date: Tue, 12 Jan 2010 17:04:48 -0500
Message-ID: <20100112220448.GF23219@kallisti.us>
References: <20100112213223.GD23219@kallisti.us>
	<001485f790a4c2633c047cfe80e0@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ExXT7PjY8AI4Hyfa"
Content-Disposition: inline
In-Reply-To: <001485f790a4c2633c047cfe80e0@google.com>
Subject: Re: [Bridge]
	=?iso-8859-1?q?Re=A0=3ARe=3A_Re=A0=3ARe=3A__Bridging_LAC?=
	=?iso-8859-1?q?P_=28802=2E3ad=29_frames_not=09working?=
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


--ExXT7PjY8AI4Hyfa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 12, 2010 at 09:40:30PM +0000, jhautbois@gmail.com wrote:
> This is exactly the problem.
> But, sounds like it is not possible... ?

You could run a custom version of the bridge driver to enable bridging
of frames sent to the bridge-management MAC addresses.  Some folks
have talked about doing similar things to enable bridging of STP.

Doing that with STP makes a bit more sense to me (since there are
valid networks that could be constructed that way).  But you'll be
breaking a pretty fundamental assumption of LACP....

--=20
Ross Vandegrift
ross@kallisti.us

"If the fight gets hot, the songs get hotter.  If the going gets tough,
the songs get tougher."
	--Woody Guthrie

--ExXT7PjY8AI4Hyfa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktM8gAACgkQMlMoONfO+HC6UwCgkLsC/ZE4ovcxX1e+A/NV3ELz
Rp4AoIFyCMtgrMYkxK2k81b9M3n6/v0U
=A5kn
-----END PGP SIGNATURE-----

--ExXT7PjY8AI4Hyfa--
