Return-Path: <equinox@diac24.net>
Date: Thu, 8 Mar 2012 04:59:14 +0100
From: David Lamparter <equinox@diac24.net>
Message-ID: <20120308035914.GK591081@jupiter.n2.diac24.net>
References: <20120306142219.31783.30201.stgit@localhost.localdomain>
	<20120306.143323.1591818099708591757.davem@davemloft.net>
	<4F571674.6000107@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8tUgZ4IE8L4vmMyh"
Content-Disposition: inline
In-Reply-To: <4F571674.6000107@gmail.com>
Subject: Re: [Bridge] [PATCH] bridge: fix "entering disabled state" logging
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, David Miller <davem@davemloft.net>


--8tUgZ4IE8L4vmMyh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 07, 2012 at 10:04:04AM +0200, Paulius Zaleckas wrote:
> On 03/06/2012 09:33 PM, David Miller wrote:
> > From: Paulius Zaleckas<paulius.zaleckas@gmail.com>
> > Date: Tue, 06 Mar 2012 16:22:19 +0200
> >
> >> Now we have:
> >> eth0: link *down*
> >> br0: port 1(eth0) entering *forwarding* state
> >>
> >> State should be logged *after* it was changed, not before.
> >>
> >> Reported-by: Zilvinas Valinskas<zilvinas@wilibox.com>
> >> Signed-off-by: Paulius Zaleckas<paulius.zaleckas@gmail.com>
> >
> > This is intentional, this was a discussion about this.
> >
> > "Entering" means "about to" therefore we say it before it happens.
>=20
> You have missed the whole point here... please look at dmesg output, I=20
> have bolded what you should pay attention to. It should say "entering=20
> disabled state" instead of "entering forwarding state".

To make this even more clear so it's not dismissed another time:

it says "entering forwarding state" when it is actually entering
disabled state. Because the print references the value before the
change. Which is changed to disabled just after.

Whatever the tense of the verb, it prints the state that's just being
left instead of the one being entered.


-David

--8tUgZ4IE8L4vmMyh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iF4EAREIAAYFAk9YLpIACgkQCy20tTec6ePuyQD+MZ8fMsZzELeAm7yp7ZFhRsuE
EPlOjlAwEtQ0kU9wlZkA/Ah634DowvybenpZpR8K9Vibn/lDBbyGUk/Whmhoz/YS
=jNaB
-----END PGP SIGNATURE-----

--8tUgZ4IE8L4vmMyh--
