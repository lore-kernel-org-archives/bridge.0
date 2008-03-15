Date: Sat, 15 Mar 2008 12:07:30 +0000
From: Matt Richards <matt@mattstone.net>
Message-ID: <20080315120730.GB1766@mattstone.net>
References: <941215.43035.qm@web52404.mail.re2.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline
In-Reply-To: <941215.43035.qm@web52404.mail.re2.yahoo.com>
Subject: Re: [Bridge] catching all packets on an interface
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Bridge Mailing List <bridge@linux-foundation.org>


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,=20

by capture I'm guessing you mean match?

With bridges and iptables i normally use physdev

iptables -I FORWARD -m physdev --physdev-in eth0 --physdev-out eth1

Hth,

Matt.

On Sat, Mar 15, 2008 at 04:50:39AM -0700, Scott MacKay wrote:
> In a simple bridge design, eth0, eth1, bridged to br0,
> what iptables rules would be needed to capture all of
> the packets?
>=20
> It looked like one in PREROUTING/mangle and
> POSTROUTING/mangle would do it for all locally
> delivered/received and passthru....
>=20
> -Scott
>=20
>=20
>       ___________________________________________________________________=
_________________
> Never miss a thing.  Make Yahoo your home page.=20
> http://www.yahoo.com/r/hs
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge

--=20
Matt Richards

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH27wCrmnybSDmzlsRAotIAKCt0geSj1s2Xu6PA6q0LNZbODpikwCg0O92
4CWfAwaS9y7KYpUfOOMT23E=
=TJsV
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--

