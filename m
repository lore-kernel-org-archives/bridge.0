Date: Wed, 11 Aug 2004 21:04:44 +0300
From: Yuval Kogman <nothingmuch@woobling.org>
Subject: Re: [Bridge] eth1394 interface support?
Message-ID: <20040811180444.GA14424@woobling.org>
References: <20040811151631.GA12305@woobling.org>
	<20040811092851.43c57af7@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <20040811092851.43c57af7@dell_ss3.pdx.osdl.net>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@lists.osdl.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 11, 2004 at 09:28:51 -0700, Stephen Hemminger wrote:
> It must use ethernet link encapsulation: 6 byte dst, 6 byte src, 2 byte t=
ype.
> But 1394 uses 8 byte dst, 2 byte type.  Obviously this can't be bridged.

Ah.. So, if I understand correctly, ethernet like behavior is in
effect emulated with firewire "messages", instead of firewire
completely encapsulating ethernet frames?

I always reckoned that the arp protocol over firewire contains some
sort of translation from the firewire addressing to an ethernet like
addressing scheme, and that host addresses are provided for by
address allocation faries.

Come to think of it, now that I'm looking, the fw based interfaces
don't have a MAC address [of the type i'm familiar with], instead
the hardware address is 8 bytes on OSX, and 16 with the bottom half
all zeros on linux.

*sigh*. It could have been fun.

Thanks for your knowlege and input!

--=20
 ()  Yuval Kogman <nothingmuch@woobling.org> 0xEBD27418  perl hacker &
 /\  kung foo master: /me spreads pj3Ar using 0wnage: neeyah!!!!!!!!!!!


--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBGl+8VCwRwOvSdBgRAp0AAKCbRsqXiRZgQ2cVcclyWBYK8kPPIgCfd/Y4
abYDhWOmI1z6pvp7m0+/1uw=
=h3Zw
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
