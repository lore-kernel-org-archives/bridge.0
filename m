From: Stuart Luppescu <s-luppescu@uchicago.edu>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-2JyNSjRQHoAjzcks9S9s"
Message-Id: <1076433752.23155.21.camel@musuko.uchicago.edu>
Mime-Version: 1.0
Date: Tue, 10 Feb 2004 11:22:32 -0600
Subject: [Bridge] Problem loading bridge.o
Reply-To: s-luppescu@uchicago.edu
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Bridge List <bridge@lists.osdl.org>


--=-2JyNSjRQHoAjzcks9S9s
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello, I want to add wireless capability to my Gentoo-linux based
firewall/router at home, so I bought a Netgear MA311 PCI and installed
the hostap package. I load the hostap_pci module and the wlan0 interface
comes up fine. I can detect the signal from a wireless enabled laptop.

Now I'm thinking I'm going to bridge the wlan0 interface and the eth1
interface, and run the firewall with br0 as the internal interface. I
compiled the kernel (2.4.23) with
CONFIG_BRIDGE=3Dm
but when I modprobe bridge, I get this stuff:

/lib/modules/2.4.23-ck1/kernel/net/bridge/bridge.o: unresolved symbol br_io=
ctl_hook
/lib/modules/2.4.23-ck1/kernel/net/bridge/bridge.o: unresolved symbol br_ha=
ndle_frame_hook
/lib/modules/2.4.23-ck1/kernel/net/bridge/bridge.o: insmod /lib/modules/2.4=
.23-ck1/kernel/net/bridge/bridge.o failed
/lib/modules/2.4.23-ck1/kernel/net/bridge/bridge.o: insmod bridge failed

I can't figure it out. Do I need to patch the kernel? (I thought 2.4.21
and beyond needed no patches.) Do I need to configure something else?

Thanks in advance.
--=20
Stuart Luppescu -=3D- s-luppescu .at. uchicago.edu       =20
University of Chicago -=3D- CCSR=20
=1B$B:MJ8$HCRF`H~$NIc=1B(B -=3D-    Kernel 2.6.1-gentoo               =20
Wishing without work is like fishing without bait.=20
 -- Frank Tyger=20
=20


--=-2JyNSjRQHoAjzcks9S9s
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAKRNYDBHcBS0tWxMRAqJNAKCYcCDWiGVtmmBk33Oz1iA2PSisiQCfeEUw
5d3A+LHarxAKv/Fc29YXAUM=
=bOey
-----END PGP SIGNATURE-----

--=-2JyNSjRQHoAjzcks9S9s--

