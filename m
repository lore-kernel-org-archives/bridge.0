From: Paul Schulz <pschulz@foursticks.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-IFfJIamslVdKW0bQFdw7"
Message-Id: <1077146815.3779.14.camel@localhost>
Mime-Version: 1.0
Date: Thu, 19 Feb 2004 09:56:56 +1030
Subject: [Bridge] Bridging on broken Broadcom hardware.
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org
Cc: sjolly@foursticks.com


--=-IFfJIamslVdKW0bQFdw7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Greetings (first post to the list)...

The following patch is required to allow bridging to occur on an
IBM x305 (1RU server).  (It has been posted to the kernel-developers
mailing list previously.)

Background:
  - The Dual Broadcom NICs in the IBM x305 have a broken checksum
    routine which wants to calculate the checksum the ethernet
    packet where the 'source' IP address is the IP address=20
    of the sending interface.
    This breaks bridging! (Upstream hosts see an invalid checksum=20
    and drop the packet.)

  - I have heard of other issues with Broadcom NICs not
    working with IPv6 and broadcast/multicast which could be=20
    related.
   =20
I would like to get these results and the fix verified, as it will
effect any hosts using this chipset. Does anyone have any pointers?

Paul Schulz <pschulz@foursticks.com>


--=-IFfJIamslVdKW0bQFdw7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAM/S+R7GbvP4HDg8RApjkAKDJCCCOX4B1Nen1tRerlHCzzNAXFwCfS1u5
YhzUYquC8U+52y6TdYRX0BA=
=3vFV
-----END PGP SIGNATURE-----

--=-IFfJIamslVdKW0bQFdw7--

