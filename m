Subject: Re: [Bridge] Static arp entries in showmacs?
From: Matthew Hall <matt@ecsc.co.uk>
In-Reply-To: <20040514094330.7d27aa36@dell_ss3.pdx.osdl.net>
References: <1084545329.3681.65.camel@miyazaki>
	<20040514094330.7d27aa36@dell_ss3.pdx.osdl.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-I8ZMMtKUMHYISOQys5fZ"
Date: Fri, 14 May 2004 18:04:32 +0100
Message-Id: <1084554272.3681.100.camel@miyazaki>
Mime-Version: 1.0
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@lists.osdl.org


--=-I8ZMMtKUMHYISOQys5fZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-05-14 at 09:43 -0700, Stephen Hemminger wrote:
> Since it is a multicast address, it isn't bound to any particular interfa=
ce.

Ack. As I expected.

> The simplest fix would be to just add filtering rule to block that addres=
s
> leaking back out other interfaces.

Yep, sounds like a plan, so onto ebtables I go.

Thanks,
Matt

--=-I8ZMMtKUMHYISOQys5fZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBApPwfw5xT5S6r89URAgqwAJ9MzjF+wRCA//aS3s2+DgxjbI4LCACfXHYi
/jaB7+4VZmEaFPrivuHJQuw=
=twXS
-----END PGP SIGNATURE-----

--=-I8ZMMtKUMHYISOQys5fZ--

