Date: Thu, 12 Aug 2004 02:36:15 +0300
From: Yuval Kogman <nothingmuch@woobling.org>
Subject: Re: [Bridge] eth1394 interface support?
Message-ID: <20040811233614.GA17340@woobling.org>
References: <20040811151631.GA12305@woobling.org>
	<20040811092851.43c57af7@dell_ss3.pdx.osdl.net>
	<05da01c47fe4$878de170$8805640a@chriss>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <05da01c47fe4$878de170$8805640a@chriss>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Chris Shaw <chriss@watertech.com>
Cc: bridge@lists.osdl.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 11, 2004 at 13:48:17 -0700, Chris Shaw wrote:
> I shudder at the thought.... but... if you want bridging between 1394 and
> Ethernet or wireless interfaces, you can do it in W2K3 or WinXP...

Sadly.. ehm. ^UI don't have windows.

=3DD

At first it occured to me that maybe some sort of NAT for mac
addresses may be implemented, but then I read your message that said

> You can also use ProxyARP which is a kludge but it can work, provided that
> 1394 under linux can do ARP in the usual 802 way...

Well, that just worked... Funky!

Now if i can only get routing to work "automatically"... Right now
that means messing with the host that forwards, adding specific
hosts to the firewire interface (because it's easier than the other
way), and flushing temporary routes on other hosts.

Maybe some scripting is in order, with unsolicitated arp happenning
for clients which join the firewire subnet, but it's late and i
don't want to get into another war right now.

> True hardware bridges/switches can bridge between wired/wireless,
> tokenring/Ethernet FDDI/Ethernet HIPPI/Ethernet, etc etc etc... It would =
be
> cool if linux could do it for the firewalling capabilities and because
> hardware like that can be very expensive...

--=20
 ()  Yuval Kogman <nothingmuch@woobling.org> 0xEBD27418  perl hacker &
 /\  kung foo master: MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM: neeyah!


--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBGq1uVCwRwOvSdBgRApVkAKCXDAOuckxkjaxF6avnmsig3llTKwCgh6Vp
Z+x9tRavJyyEakBHZjQKKn0=
=0PEw
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
