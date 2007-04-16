Date: Tue, 17 Apr 2007 00:40:02 +0200
From: Axel Thimm <Axel.Thimm@ATrpms.net>
Message-ID: <20070416224002.GC5695@neu.nirvana>
References: <2eceaddb0704161410i3a4b7d5al430a4165063f0684@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GPJrCs/72TxItFYR"
Content-Disposition: inline
In-Reply-To: <2eceaddb0704161410i3a4b7d5al430a4165063f0684@mail.gmail.com>
Sender: Axel Thimm <thimm@neu.nirvana>
Subject: Re: [Bridge] Bridging over a bonded interface?
Reply-To: bridge@lists.linux-foundation.org
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ravi Ramamirtham <rrshanks@gmail.com>
Cc: bridge@lists.linux-foundation.org


--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 16, 2007 at 05:10:37PM -0400, Ravi Ramamirtham wrote:
> Hi,
>  This may sound crazy but I will go ahead anyway. Here's my scenario:
>=20
> ifconfig bond0 10.10.10.1 netmask 255.0.0.0
> ifenslave bond0 eth0
> ifenslave bond0 eth1
>=20
> brctl addbr stp0
> brctl addif stp0 bond0
> brctl stp stp0 on
>=20
> Is this a valid scenario? I am trying to bond two interfaces and run STP
> over the bonded interface..The problem I am trying to solve is to run STP
> over aggregated links between two nodes. Any suggestions/pointers would be
> much appreciated.

Just happened that I asked the same 9 days ago:

http://lists.linux-foundation.org/pipermail/bridge/2007-April/001764.html

Depending on the switch on the other side of the wire, you will get
the arp packets you send out on the other link of the bond. This will
make an outgoing arp packet register on the internal port of the
bridge and reregister a couple of ms later on the outer port.

This leads to packets loss of > 99%, e.g. a 2x1GB bond degarded to
70kB/sec.

It would be nice if the bridging code could prevent this. Either by
identifying the outgoing arp packet that immediately returns and not
updating the forwarding database, or allowing to hardcode some static
arp entries into the forwarding database.
--=20
Axel.Thimm at ATrpms.net

--GPJrCs/72TxItFYR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFGI/tCQBVS1GOamfERAgnxAJsF3wCnbVxTbyX/YiicfxPFQnBSMwCfYuWr
TAb0X0frvO+yeRmym2yP9/4=
=3Uvm
-----END PGP SIGNATURE-----

--GPJrCs/72TxItFYR--
