Date: Wed, 11 Aug 2004 18:16:31 +0300
From: Yuval Kogman <nothingmuch@woobling.org>
Message-ID: <20040811151631.GA12305@woobling.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
Subject: [Bridge] eth1394 interface support?
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I have a linux box which sits in the living room and plays
ti^H^Hfreevo.

Among other things it also talks to the cable modem via interface
eth0, and does NAT transformations for eth1.

Yesterday i was sitting in the living room with my laptop, thinking
about the fact that my wireless access point will only arrive next
week, and then remembered they both the laptop and the linux boxhave
firewire. The plot thickens.

I enabled bridging support in the kernel, and i got to

	brctl addbr br0
	brctl addif br0 eth1 # LAN interface
	brctl addif br0 eth2 # firewire interface
	br_add_interface: Invalid argument

I reckon eth1394 is at fault, but I'd like to know what the bridge
code expects from it.

eth1394 on a different subnet works, and I can also manipulate the
routing table in funny ways. I'd like to not do that.

Thanks

--=20
 ()  Yuval Kogman <nothingmuch@woobling.org> 0xEBD27418  perl hacker &
 /\  kung foo master: /me sneaks up from another MIME part: neeyah!!!!!


--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBGjhPVCwRwOvSdBgRAtlgAJ4ic634aRLHdDJRFA29xEu1tHIdYgCgtzgX
b/fFPNb2Icg/485843fI7HI=
=6pRw
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
