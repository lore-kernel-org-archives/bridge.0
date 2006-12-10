From: Patrick Nagel <mail@patrick-nagel.net>
Date: Sun, 10 Dec 2006 19:09:27 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8766173.27VoJWPXM4";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200612101909.39202.mail@patrick-nagel.net>
Subject: [Bridge] Man-in-the-middle scenario within vmware - problem
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

--nextPart8766173.27VoJWPXM4
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi there,

I'm trying to set up a man-in-the-middle scenario within a VMWare Workstati=
on=20
team, using brctl. What I want is the following:

PC1 eth0 >---LAN-segment-1---< eth0 PCMITM eth1 >---LAN-segment-2---< eth0 =
PC2

Now I did the following on PCMITM (PC man in the middle):

ifconfig eth0 down
ifconfig eth1 down
brctl addbr lnxbr0
brctl addif lnxbr0 eth0
brctl addif lnxbr0 eth1
ifconfig eth0 0.0.0.0
ifconfig eth1 0.0.0.0
ifconfig lnxbr0 up

All commands exit successfully and I get eth0, eth1 and lnxbr0 listed in=20
ifconfig.
brctl show says:

bridge name	bridge id		STP enabled	interfaces
lnxbr0		8000.000c296df055	no		eth1
							eth0

which also seems alright to me.

But now the problem: although PC1 and PC2 are in the same IP subnet (addres=
ses=20
192.168.222.1 and 192.168.222.2), a ping doesn't pass the bridge. By=20
starting "ping pc2" on PC1 and "ping pc1" on PC2, I ensure that both machin=
es=20
are transmitting data frequently, and thus should show up in "brctl=20
showmacs", but
brctl showmacs lnxbr0 says:

port no	mac addr		is local?	ageing timer
  1	00:0c:29:6d:f0:55	yes		   0.00
  2	00:0c:29:6d:f0:5f	yes		   0.00
  2	00:0c:29:97:e3:a6	no		   0.14

So there is one NIC missing - that one of PC1.

Does anyone have an explanation? I don't know what could be wrong in my set=
up,=20
I don't even know where to start... Any help is appreciated.

By the way: The LAN segments within VMWare seem to be working. If I give ea=
ch=20
NIC on PCMITM an IP address (with no bridge on PCMITM), I can transfer data=
=20
from PC1 to PCMITM (and vice versa) and from PC2 to PCMITM (and vice versa).

Patrick.

=2D-=20
Key ID: 0x86E346D4 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0http://patrick-=
nagel.net/key.asc
=46ingerprint: 7745 E1BE FA8B FBAD 76AB 2BFC C981 E686 86E3 46D4

--nextPart8766173.27VoJWPXM4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBFfE1jyYHmhobjRtQRAmYBAKDSPFv0k9A5re3vD43JnXucrWTnNACgzLGV
jbbsNP70ibrloYkkSbOQfl4=
=kUgk
-----END PGP SIGNATURE-----

--nextPart8766173.27VoJWPXM4--
