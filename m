From: Ross Vandegrift <ross@kallisti.us>
Date: Tue, 12 Jan 2010 10:23:17 -0500
Message-ID: <20100112152317.GB23219@kallisti.us>
References: <8cad0aa1001120713h55bcde41p56bcd1771030e7ec@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline
In-Reply-To: <8cad0aa1001120713h55bcde41p56bcd1771030e7ec@mail.gmail.com>
Subject: Re: [Bridge] Bridging LACP (802.3ad) frames not working
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jean-Michel Hautbois <jhautbois@gmail.com>
Cc: bridge@lists.linux-foundation.org


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 12, 2010 at 04:13:01PM +0100, Jean-Michel Hautbois wrote:
> Hi there !
>=20
> I have connected two ethernet 1000Mbps interfaces to my routers, and I
> have built a bridge between them :
> eth1 <---> br0 <---> eth2
>=20
> When I am transmitting UDP, ADP, ARP or any other type of frames, I
> don't have any problem.
> But when, the router sends LACP packets, it is not transmitted
> (neither from eth1 to eth2 than from eth2 to eth1).
>=20
> I can't figure out why, so if you have an idea, thanks in advance for
> your help !

You can't bridge LACP - it doesn't even make sense.  LACP bundles must
be between adjacent devices.  Moreover,  LACPDUs are destined for a
bridge-management address that is prohibited from being bridged by
802.1D.

What are you trying to accomplish?  If you want to transparently
bridge with LACP channels, you should terminate the LACP bundles on
the Linux box and bridge the bundles:

eth0 \                          / eth2
      bond0 ----- br0 ---- bond1
eth1 /                          \ eth3

And then cable eth0/eth1 to one device and eth2/eth3 to the other.

Ross

--=20
Ross Vandegrift
ross@kallisti.us

"If the fight gets hot, the songs get hotter.  If the going gets tough,
the songs get tougher."
	--Woody Guthrie

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktMk+UACgkQMlMoONfO+HBNSwCfbyGlKf9+X9c0ZPqAlV07jmcn
oWsAniuKgYz2XDbJSVBmClK7BXcKAnDv
=R2AD
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
