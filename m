Date: Wed, 30 Mar 2011 16:46:34 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
Message-ID: <20110330164634.0defc987@center4.mivlgu.local>
In-Reply-To: <20110329194709.GC2781@psychotron.redhat.com>
References: <loom.20110328T194703-472@post.gmane.org>
	<AANLkTi=8TqZWM_xxkAh16KoHTPe+8vBjeoqWNy-icm64@mail.gmail.com>
	<20110329183657.GB2781@psychotron.redhat.com>
	<AANLkTiktA_41W2X+J0Z94B_gsDcrmO0i0YHVQFQSnxLJ@mail.gmail.com>
	<20110329194709.GC2781@psychotron.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	boundary="Sig_/PVqTtGjblqDru9grgiJjApD";
	protocol="application/pgp-signature"
Subject: Re: [Bridge] 802.1q tagging broken when used with bridging in 2.6.38
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: igor serebryany <igor47@moomers.org>
Cc: jesse@nicira.com, bridge@osdl.org, Jiri Pirko <jpirko@redhat.com>

--Sig_/PVqTtGjblqDru9grgiJjApD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Mar 2011 21:47:09 +0200 Jiri Pirko wrote:

> Tue, Mar 29, 2011 at 09:18:44PM CEST, andy@greyhouse.net wrote:
> >On Tue, Mar 29, 2011 at 2:36 PM, Jiri Pirko <jpirko@redhat.com> wrote:
> >> Tue, Mar 29, 2011 at 06:54:58PM CEST, andy@greyhouse.net wrote:
> >>>On Mon, Mar 28, 2011 at 1:54 PM, igor serebryany <igor47@moomers.org> =
wrote:
> >>>> it appears that 802.1q tagging is broken in 2.6.38 when combined wit=
h bridging.
> >>>> here is how to reproduce the problem:
> >>>>
> >>>> i set up an interface for the machine running 2.6.38 on my cisco rou=
ter, and
> >>>> assign a subnet to that interface. i am using ping from the router t=
o do the
> >>>> testing. i am getting all the data here with 'tcpdump -e -n' from th=
e machine.
> >>>>
> >>>> i ping the machine from the router, and i see properly-tagged ARP re=
quests
> >>>> coming in on eth0:
> >>>>
> >>>> 12:12:05.052465 00:11:20:dd:81:00 > ff:ff:ff:ff:ff:ff, ethertype 802=
.1Q
> >>>> (0x8100), length 64: vlan 234, p 0, ethertype ARP, Request who-has 1=
0.0.0.206
> >>>> tell 10.0.0.205, length 46
> >>>>
> >>>> i then create a vlan interface on the machine:
> >>>>
> >>>> vconfig add eth0 234
> >>>> ifconfig eth0.234 up
> >>>>
> >>>> i tcpdump the newly-created interface, and i see the arp packets app=
earing on
> >>>> it, now properly untagged
> >>>>
> >>>> 12:14:33.549939 00:11:20:dd:81:00 > ff:ff:ff:ff:ff:ff, ethertype ARP=
 (0x0806),
> >>>> length 60: Request who-has 10.0.0.206 tell 10.0.0.205, length 46
> >>>>
> >>>> if i assign an ip to this interface, i can see pings being exchanged=
 on eth0.234
> >>>>
> >>>> 12:17:12.681079 00:11:20:dd:81:00 > ff:ff:ff:ff:ff:ff, ethertype ARP=
 (0x0806),
> >>>> length 60: Request who-has 10.0.0.206 tell 10.0.0.205, length 46
> >>>> 12:17:12.681090 00:30:48:fd:98:d8 > 00:11:20:dd:81:00, ethertype ARP=
 (0x0806),
> >>>> length 42: Reply 10.0.0.206 is-at 00:30:48:fd:98:d8, length 28
> >>>> 12:17:14.682076 00:11:20:dd:81:00 > 00:30:48:fd:98:d8, ethertype IPv=
4 (0x0800),
> >>>> length 114: 10.0.0.205 > 10.0.0.206: ICMP echo request, id 24, seq 1=
, length 80
> >>>> 12:17:14.682088 00:30:48:fd:98:d8 > 00:11:20:dd:81:00, ethertype IPv=
4 (0x0800),
> >>>> length 114: 10.0.0.206 > 10.0.0.205: ICMP echo reply, id 24, seq 1, =
length 80
> >>>>
> >>>> now, i want to assign eth0 to a bridge
> >>>>
> >>>> brctl addbr xenbr0
> >>>> ifconfig xenbr0 up
> >>>> brctl addif xenbr0 eth0
> >>>>
> >>>> i now attempt to ping the machine again. watching tcpdump on eth0.23=
4, i don't
> >>>> see any of my packets anymore!
> >>>>
> >>>> instead, if i watch xenbr0 with tcpdump, i can see the tagged packet=
s being
> >>>> dumped straight into xenbr0, without the vlan tags stripped out!
> >>
> >> Yep, that seems expected. rx_handler for bridge is earlier in rx path
> >> than vlan processing. This is was not changed in 2.6.38. This is with =
us
> >> for a long time. I plan to refuse this topo in future (not sure yet
> >> thought)
> >>
> >
> >I have no idea what version Igor was using before.  Even if Igor's
> >upgrade as not from 2.6.37, this sounds like a regression.
>=20
> Well, one commit I'm thinking of which might cause this "regression"
> (athought I do not see that as one) is this:
>=20
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dco=
mmitdiff;h=3D3701e51382a026cba10c60b03efabe534fba4ca4
>=20
> cc'ing Jesse.
>=20
> Anyway. I think that on non-hw-accel vlans this is the same all the
> time as it is now.

It is possible to make this configuration work again by adding ebtables
rules - an example is given in the bridge-nf FAQ
(http://ebtables.sourceforge.net/misc/brnf-faq.html):

  ebtables -t broute -A BROUTING -i eth0 --vlan-id 15 -j DROP

This sends traffic for VLAN 15 coming from eth0 to the VLAN code instead
of bridge, so that it would be properly received on eth0.15.

Or you can add a rule which handles any VLAN-tagged traffic:

  ebtables -t broute -A BROUTING -i eth0 -p 802_1Q -j DROP

This was required even for kernels before 2.6.37, but only if the
network card did not have VLAN RX acceleration support; VLAN hw-accel
code in those kernels handled tagged packets before the bridge code.
The commit mentioned above (present in mainline since 2.6.37-rc1) made
the behavior for hw-accel and non-hw-accel cases identical - now
ebtables rules are required for all kinds of cards.

--Sig_/PVqTtGjblqDru9grgiJjApD
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iEYEARECAAYFAk2TJi4ACgkQW82GfkQfsqJy4wCgh1Zv2TTkKS4XUx1A5t0yd/4D
VYYAn03w1rPpkx/Af/3jkH85Z72ND+na
=i30u
-----END PGP SIGNATURE-----

--Sig_/PVqTtGjblqDru9grgiJjApD--
