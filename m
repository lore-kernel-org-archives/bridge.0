From: "Bogdan B. Rudas" <bogdar@tut.by>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-kDaysYhqLrpk+gFXGFgZ"
Message-Id: <1094312506.20738.20.camel@rudasb>
Mime-Version: 1.0
Date: Sat, 04 Sep 2004 18:41:46 +0300
Subject: [Bridge] Bridge + VLAN
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Linux Bridge <bridge@lists.osdl.org>


--=-kDaysYhqLrpk+gFXGFgZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi. I have one untagged VLAN on enterasys managed switch. I set up a
bridge between common ethernet and vlan, turn stp on, then interface
connected to VLAN goin into blocking state. Then I conect old Cabletron
SmartStack (with stp enabled) 10mbit switch between bridge interface and
VLAN on enterasys and get in working. No VLAN on cabletron device was
configured. VLAN support in kernel was not enabled. Kernel version in
2.6.8.1

--=-kDaysYhqLrpk+gFXGFgZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: =?koi8-r?Q?=E7=DC=D4=C1=D1?=
	=?koi8-r?Q?_=DE=C1=D3=D4=CB=C1?=
	=?koi8-r?Q?_=D0=C1=D7=C5=C4=C1=CD=CC=C5=CE=D8?=
	=?koi8-r?Q?=D0=C1=D7=C5=C4=C1=CD=CC=C5=CE=D8=CE?= =?koi8-r?Q?=D1?=
	=?koi8-u?Q?_=D0=C1=C4=D0=A6=D3=C1=CE=C1?=
	=?koi8-r?Q?_=DC=CC=C5=CB=D4=D2=CF=CE=D9=CD?=
	=?koi8-u?Q?_=D0=CF=C4=D0=A6=D3=C1=CD?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBOeI6C2VaeYaW2NkRAtMWAJ4rAkMoOP+vNVQxsQJ6OcmESeawjACfTeBF
OUSYolKgahZGE8poTgajkeE=
=oX/y
-----END PGP SIGNATURE-----

--=-kDaysYhqLrpk+gFXGFgZ--

