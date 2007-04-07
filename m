Date: Sun, 8 Apr 2007 01:08:59 +0200
From: Axel Thimm <Axel.Thimm@ATrpms.net>
Message-ID: <20070407230859.GC27010@neu.nirvana>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
Content-Disposition: inline
Sender: Axel Thimm <thimm@neu.nirvana>
Subject: [Bridge] Bridging and bonding
Reply-To: bridge@lists.linux-foundation.org
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I'm trying to setup a bridge with a bonded device (2 links,
balance-rr). The problem is that after attaching the bonded device to
the bridge the network throughput drops down from 110MB to 100KB. This
seems to be due to the MAC address of internal devices of the bridge
being seen on the external ports, where the bonded device exists (see
also the URLs below).

An arp packet from some device on the bridge gets out on one slave and
returns on the other, so the bridge suddenly moves the mac address to
the wrong port. It looks like the bridge is moving the mac address now
back an forth resulting in packet losses of 50-99.9% depending on the
network utilization.

For kernel 2.6.16 there was a commit that supposedly fixed this for
active/passive mode bonding by ignoring incoing packets on the standby
link.

http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commit;h=3D8f903c708fcc2b579ebf16542bf6109bad593a1d

But I do want to have balance-rr and even for active/passive more
people report that this still isn't working.

Is this a known problem? What kind of solutions exist? Ideally I would
like to add an immutable static entry to the forwarding mac database.

This is for a xen setup, and I've found a couple more issue with that
on xen and openvz lists:

http://lists.xensource.com/archives/html/xen-devel/2006-07/msg00613.html
http://forums.xensource.com/thread.jspa?messageID=3D1839
http://openvz.org/pipermail/users/2006-November/000420.html

Thanks!
--=20
Axel.Thimm at ATrpms.net

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFGGCSLQBVS1GOamfERAvM4AJ9PBbvxf2loDOPnrWztaJm2CTKMKQCePhQJ
z94DB5X6tBJAj2BWyDZB/nI=
=MT69
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--
