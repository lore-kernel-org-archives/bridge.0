Message-ID: <4AFC2D65.9040903@gmail.com>
Date: Thu, 12 Nov 2009 10:44:37 -0500
From: Gregory Haskins <gregory.haskins@gmail.com>
MIME-Version: 1.0
References: <20091110222632.24100.14884.stgit@mimic.site>
In-Reply-To: <20091110222632.24100.14884.stgit@mimic.site>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig75BEB90EED3DC6DAD9C707F9"
Subject: Re: [Bridge] [PATCH 0/4] vbus: venet macvlan support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Patrick Mullaney <pmullaney@novell.com>
Cc: arnd@arndb.de, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, alacrityvm-devel@lists.sourceforge.net, evb@yahoogroups.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig75BEB90EED3DC6DAD9C707F9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Patrick Mullaney wrote:
> (Applies to alacrityvm.git/master:34534534)
>=20
> This patchset implements a vbus venet device with a
> macvlan backend.

Thanks Pat, applied.

If possible, please submit a patch for the userspace side "-net
venet-macvlan[,macaddr][,lower-devname]" feature ASAP and I will merge
that as well.

-Greg


--------------enig75BEB90EED3DC6DAD9C707F9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.11 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkr8LWUACgkQP5K2CMvXmqGRaQCgiC071fN0Uw8BceZbqTkXPYTk
KX4Anjl1Gbm/ME8ATSrlvBEmr0FckhFM
=DijE
-----END PGP SIGNATURE-----

--------------enig75BEB90EED3DC6DAD9C707F9--
