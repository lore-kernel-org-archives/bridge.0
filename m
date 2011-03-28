Date: Mon, 28 Mar 2011 13:28:53 -0500
From: Igor Serebryany <igor47@moomers.org>
Message-ID: <20110328182853.GM23639@moomers.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/+CTqSGWdiRg+8j"
Content-Disposition: inline
Subject: [Bridge] 802.1q broken when used with bridging in 2.6.38
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org


--W/+CTqSGWdiRg+8j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

it appears that 802.1q tagging is broken in 2.6.38 when combined with bridg=
ing. here is how to reproduce the problem:
    =20
i set up an interface for the machine running 2.6.38 on my cisco router, and
assign a subnet to that interface. i am using ping from the router to do the
testing. i am getting all the data here with 'tcpdump -e -n' from the machi=
ne.
    =20
i ping the machine from the router, and i see properly-tagged ARP requests
coming in on eth0:
    =20
12:12:05.052465 00:11:20:dd:81:00 > ff:ff:ff:ff:ff:ff, ethertype 802.1Q
(0x8100), length 64: vlan 234, p 0, ethertype ARP, Request who-has 10.0.0.2=
06
tell 10.0.0.205, length 46
    =20
i then create a vlan interface on the machine:
    =20
vconfig add eth0 234 ifconfig eth0.234 up
    =20
i tcpdump the newly-created interface, and i see the arp packets appearing =
on
it, now properly untagged
    =20
12:14:33.549939 00:11:20:dd:81:00 > ff:ff:ff:ff:ff:ff, ethertype ARP (0x080=
6),
length 60: Request who-has 10.0.0.206 tell 10.0.0.205, length 46
    =20
if i assign an ip to this interface, i can see pings being exchanged on
eth0.234:
    =20
12:17:12.681079 00:11:20:dd:81:00 > ff:ff:ff:ff:ff:ff, ethertype ARP (0x080=
6), length 60: Request who-has 10.0.0.206 tell 10.0.0.205, length 46
12:17:12.681090 00:30:48:fd:98:d8 > 00:11:20:dd:81:00, ethertype ARP (0x080=
6), length 42: Reply 10.0.0.206 is-at 00:30:48:fd:98:d8, length 28
12:17:14.682076 00:11:20:dd:81:00 > 00:30:48:fd:98:d8, ethertype IPv4 (0x08=
00), length 114: 10.0.0.205 > 10.0.0.206: ICMP echo request, id 24, seq 1, =
length 80
12:17:14.682088 00:30:48:fd:98:d8 > 00:11:20:dd:81:00, ethertype IPv4 (0x08=
00), length 114: 10.0.0.206 > 10.0.0.205: ICMP echo reply, id 24, seq 1, le=
ngth 80
    =20
now, i want to assign eth0 to a bridge:
    =20
brctl addbr xenbr0
ifconfig xenbr0 up
brctl addif xenbr0 eth0
    =20
i now attempt to ping the machine again. watching tcpdump on eth0.234, i do=
n't see any of my packets anymore!
    =20
instead, if i watch xenbr0 with tcpdump, i can see the tagged packets being=
 dumped straight into xenbr0, without the vlan tags stripped out!
    =20
12:20:53.041487 00:11:20:dd:81:00 > 00:30:48:fd:98:d8, ethertype 802.1Q (0x=
8100), length 118: vlan 234, p 0, ethertype IPv4, 10.0.0.205 > 10.0.0.206: =
ICMP echo request, id 26, seq 2, length 80
    =20
obviously there are no icmp replies because there is no listening interface=
 on xenbr0.
    =20
i tried doing something really silly:
    =20
vconfig add xenbr0 234
ifconfig xenbr0.234 10.0.0.206 netmask 255.255.255.252
    =20
when watching this unusual interface with tcpdump, i would see properly-unt=
agged packets making their way there. but arp requests couldn't make their =
way back out again:
    =20
12:44:29.952443 00:11:20:dd:81:00 > 00:30:48:fd:98:d8, ethertype IPv4 (0x08=
00), length 114: 10.0.0.205 > 10.0.0.206: ICMP echo request, id 30, seq 4, =
length 80
12:44:29.954549 00:30:48:fd:98:d8 > ff:ff:ff:ff:ff:ff, ethertype ARP (0x080=
6), length 42: Request who-has 10.0.0.205 tell 184.154.127.206, length 28
    =20
so, that doesn't work...
    =20
this is a pretty severe bug for me. my virtual machine setup depends on bei=
ng able to assign VMs to vlans and forward packets to them, and this totall=
y breaks my networking model, taking some of my vms offline. of course, any=
 vm using the native vlan on the port is unaffected.=20

--W/+CTqSGWdiRg+8j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk2Q02UACgkQVyVcp2k8D/n+VQCg6SCLkhJIAnvWhOZBIWiurvbL
G3gAoMfVcMt0ZY5g8pGGkKldI4MPFaKu
=6TrN
-----END PGP SIGNATURE-----

--W/+CTqSGWdiRg+8j--
