Message-ID: <4E412DEF.8080805@maxb.eu>
Date: Tue, 09 Aug 2011 13:54:07 +0100
From: Max Bowsher <_@maxb.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------enigF81F4DB0FA649A2199B0F1C9"
Subject: [Bridge] Problems with bridging and bonding - bridge learns MAC on
 incorrect port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF81F4DB0FA649A2199B0F1C9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I've recently been setting up what I would hope would be a not too
uncommon configuration, and seem to be encountering an unfortunate
interaction between bridging and bonding.

My configuration is:

* eth0 and eth1: Physical network adapters connected to the same
switched network.

* bond0: active-backup bonding device slaving together eth0 and eth1

* bond0.11: VLAN interface on top of the above

* br0: Bridge to which bond0.11 is added.


And then I am starting KVM virtual machines, which obtain their network
connectivity via tap interfaces, which are added to br0.


I see intermittent connectivity problems from the VMs, which manifest
when the bridge becomes confused, and erroneously learns that the VM MAC
address is present on the bond0.11 port of the bridge.

I have discovered that this occurs when the VM sends an ethernet
broadcast - e.g. ARP query.

It seems that the ethernet broadcast re-enters the machine on the backup
bonding interface, and on reaching the bridge, causes it to
inappropriately learn that the virtual machine is on the physical
network side of the bridge.


Can anyone suggest any way to address this problem?

Thanks,
Max.


--------------enigF81F4DB0FA649A2199B0F1C9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJOQS32AAoJEHJ/0QnCDv8OeKIP/3zKuCn9eRUoFNqAO/Iub9r3
5lbBTJRjthOCkL/HMhOKYe6YcMq0XFToStMqbb4/FIbdXu0SBExDxH2uyICwZy7Z
PwxNYosOJwvLYDNjvU9sUE/E+zgLWF+s2uA6yVBbCII8D4VRLrelYhgbbYy2BsKo
GsK4vFIi9QCoTin07L1x/UpO0XfofsebwidlV6XlqopEhzR6MXrKYMf2mToSe4D1
V4sgOsHH1muHiLmCVrTF6IXd7VNeaE+eHaHsVRcW0BsWfvlhMTvlopY4sEfeazrq
VEHg6rZ2ayFvoXYHXQqfgZ2X9nQy4f2lDRKquMWao9wwxsOvc8XOwLN3uPME7pVi
Sk5nOsf6haYGM546qFwFoCutQavwWY3mfb7K4jHEXIa++LrfsC3BSul3UUhmE+ZP
W0UujQKPvg0VodF7aItzSBIIxirt+mXaKVZQhbXl4jpvHbOkmwNYyFTN47tkxpj9
aAh4ti3mfQPXlR3BQpqiV+BFIizxuh3n+dDWdHwXX7Cl2G2UmcVTOdK0tzGSRnNa
nDa5VzdR8Jf/RjrMTp/ue9wAhjD0iChfiHdHE+IE+xbDY/lItNY+BtG1Ma1mHdAN
VuIGfNde9ykZdz4g+GjFQI1YvnHJY1b8mqKtxuaVNjeRkgwikfANbp1BCrHOPA1m
j9HSWYPoOVXPqqU6arq8
=Rhgn
-----END PGP SIGNATURE-----

--------------enigF81F4DB0FA649A2199B0F1C9--
