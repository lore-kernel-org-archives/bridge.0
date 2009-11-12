Message-ID: <4AFC2FCC.5090103@gmail.com>
Date: Thu, 12 Nov 2009 10:54:52 -0500
From: Gregory Haskins <gregory.haskins@gmail.com>
MIME-Version: 1.0
References: <20091110222632.24100.14884.stgit@mimic.site>
	<4AFC2D65.9040903@gmail.com> <4AFC2F71.1060408@trash.net>
In-Reply-To: <4AFC2F71.1060408@trash.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig446F7890475F406410D336E8"
Subject: Re: [Bridge] [PATCH 0/4] vbus: venet macvlan support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Patrick McHardy <kaber@trash.net>
Cc: arnd@arndb.de, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, alacrityvm-devel@lists.sourceforge.net, Patrick Mullaney <pmullaney@novell.com>, evb@yahoogroups.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig446F7890475F406410D336E8
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Patrick McHardy wrote:
> Gregory Haskins wrote:
>> Patrick Mullaney wrote:
>>> (Applies to alacrityvm.git/master:34534534)
>>>
>>> This patchset implements a vbus venet device with a
>>> macvlan backend.
>> Thanks Pat, applied.
>=20
> As I mentioned in my response to these patches, the macvlan part
> need more work.

Yeah, I talked to Pat offline.  He is going to patch it incrementally as
its not a trivial problem to cleanup.  For the time being, they are
sitting in the alacrityvm tree, but they are not going upstream until
the macvlan stuff is resolved.  All but the last patch are not really my
business to push up, anyway.

In the meantime, Pat or others can enhance the work that he's done to
date, so I will carry them out-of-tree.

Kind Regards,
-Greg


--------------enig446F7890475F406410D336E8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.11 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkr8L8wACgkQP5K2CMvXmqHqZgCeL+DYwW8KLcxD1Ruo9SFTY4wo
sV4An2ADiWlbBiQtDTfj7R6FvI5XpgPs
=NKah
-----END PGP SIGNATURE-----

--------------enig446F7890475F406410D336E8--
