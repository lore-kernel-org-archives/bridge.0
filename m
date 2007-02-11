Message-ID: <45CE9940.2060501@mattstone.net>
Date: Sun, 11 Feb 2007 04:19:12 +0000
From: Matt Richards <matt@mattstone.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8B7C372E82A2BAD86420E8D0"
Subject: [Bridge] bridge wont forward when ip address changes
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8B7C372E82A2BAD86420E8D0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

hello :)

I have been using the bridge utils for a long time now and its been very
good but there are a couple of issues that I came across when trying to
setup a wireless bridge...

Firstly I currently have a setup like the following ...

Computer A --- Wired Network --- linux box ---- wireless link ------
linux box ----- Wired Network --- Computer B

I have bridged the wireless interfaces and the wired interfaces together
on both of the linux box's and data can travel across the wireless
bridge without any trouble but if I attempt to change the IP addresses /
subnet of Computers A and B the bridges seem to stop forwarding packets
and no data get through at all, its like they aren't learning the new
addresses.

If I restart the 2 Linux boxes then everything starts flowing properly
again.

The 'Linux boxes' are a couple of Motorola Wireless Access points
running OpenWRT.

Does anybody know why this might be happening and what I might be able
to do about it?

The other issue is that the this bridge setup doesn't seem to forward
any NetBIOS traffic, however, i'm not too worried about this its more of
just bring curious.

Thanks for your help,

Matty.


--------------enig8B7C372E82A2BAD86420E8D0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFzplErmnybSDmzlsRAmjYAKDM5yxnFObHA8Fu4ME54zfNTGoftACfRqsV
elaRYl2KKxjYo4PrTz0I8c0=
=jmvk
-----END PGP SIGNATURE-----

--------------enig8B7C372E82A2BAD86420E8D0--

