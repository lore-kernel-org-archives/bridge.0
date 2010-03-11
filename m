Date: Wed, 10 Mar 2010 23:51:23 -0500
From: Nathaniel Gephart <10thaperag@gmail.com>
Message-ID: <20100311045123.GB3123@aquila.north.oberlin.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Content-Disposition: inline
Subject: [Bridge] Disabling MAC address tracking
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I'm using bridge-utils as part of a Xen installation. I've got a bunch of
isolated bridges connecting up a number of virtual machines. I would like these
bridges to act more like hubs. That is, instead of keeping track of which MAC
addresses are on which ports, I want them to forward frames to all ports always.
Is there a way to do this?

Thanks,

Nate Gephart


--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkuYdssACgkQryOkOFR/NSrsfQCffvdRMwecys3mZCHjnMuakWs8
BqEAoJOecOkEVDo4Q1BT3cK2eSHk5JGS
=PdJm
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--
