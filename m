From: Paul Schulz <pschulz@foursticks.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-HsjsU+1kn1lasE9Xr0Ti"
Message-Id: <1077146945.3779.17.camel@localhost>
Mime-Version: 1.0
Date: Thu, 19 Feb 2004 09:59:05 +1030
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


--=-HsjsU+1kn1lasE9Xr0Ti
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Greetings (first post to the list, with patch)...

The following patch is required to allow bridging to occur on an
IBM x305 (1RU server) - with the tg3 module. =20
(This has been posted to the kernel-developers mailing list.)

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

--------------------------------------------------------------------
diff -Naur linux-2.4.20/drivers/net/tg3.c linux-2.4.20-np/drivers/net/tg3.c
--- linux-2.4.20/drivers/net/tg3.c	Fri Nov 29 10:23:14 2002
+++ linux-2.4.20-np/drivers/net/tg3.c	Thu Jan 23 14:46:54 2003
@@ -6161,6 +6161,11 @@
 	if (tp->pci_chip_rev_id =3D=3D CHIPREV_ID_5700_B0)
 		tp->tg3_flags |=3D TG3_FLAG_BROKEN_CHECKSUMS;
=20
+	/* 5703 A2 have issues with checksumming too. (sarah) */
+	if (tp->pci_chip_rev_id =3D=3D CHIPREV_ID_5703_A2)
+		tp->tg3_flags |=3D TG3_FLAG_BROKEN_CHECKSUMS;
+
 	/* Regardless of whether checksums work or not, we configure
 	 * the StrongARM chips to not compute the pseudo header checksums
 	 * in either direction.  Because of the way Linux checksum support




--=-HsjsU+1kn1lasE9Xr0Ti
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAM/VBR7GbvP4HDg8RAjEtAKDV9fU1BTLLtRi74UTmpLEJnLQm2ACfSvtQ
NR+lAgCxS3vuLW/N3jVNoyc=
=iEnp
-----END PGP SIGNATURE-----

--=-HsjsU+1kn1lasE9Xr0Ti--

