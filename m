Subject: Re: [Bridge] i need some help with compiling bridge module
From: Stuart Luppescu <s-luppescu@uchicago.edu>
In-Reply-To: <20040301173132.6aeedb29@localhost.localdomain>
References: <200402282000.i1SK06E28411@mail.osdl.org>
	<20040301173132.6aeedb29@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Xm6ibDkUZOJJyEqMuRRX"
Message-Id: <1078162852.30723.20.camel@musuko.uchicago.edu>
Mime-Version: 1.0
Date: Mon, 01 Mar 2004 11:40:52 -0600
Reply-To: s-luppescu@uchicago.edu
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Bridge List <bridge@lists.osdl.org>


--=-Xm6ibDkUZOJJyEqMuRRX
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: quoted-printable

On =1B$B7n=1B(B, 2004-03-01 at 10:31, Software-team wrote:
> I am trying to improve bridge module towards 802.1w (RSTP) but I am new t=
o kernel and modules programming. I dont want to compile the whole modules =
every time I make some changes. Could you give me some clues how to set up =
environment to compile only selected module (bridge 802.1d) for a given ker=
nel version, written in Makefile like:
> VERSION =3D 2
> PATCHLEVEL =3D 4
> SUBLEVEL =3D 20
> EXTRAVERSION =3D-8 etc.
> How to make a Makefile so the bridge module could be compiled separately =
for that kernel (or another)?
> Thanks for any specyfic help.

It's pretty easy. do make menuconfig, and under Networking Options put
'M' where it says 802.1d Ethernet Bridging.

Save your config, and then do make dep && make bzImage modules
modules_install
Move the /usr/src/linux/arch/i386/boot/bzImage to somewhere in /boot
(renaming it if you like), make the appropriate modification to
lilo.conf (and then rerun lilo) or change /boot/grub/grub.conf and
reboot. When it starts up again, just modprobe bridge.

I also found that I had to do make mrproper before I could get the
bridge module to load. In this case, make sure you save your .config
file to somewhere else first, or you'll lose it.

HTH.
--=20
Stuart Luppescu -=3D- s-luppescu .at. uchicago.edu       =20
University of Chicago -=3D- CCSR=20
=1B$B:MJ8$HCRF`H~$NIc=1B(B -=3D-    Kernel 2.6.3-gentoo-r1               =20
Bilbo's First Law:  You cannot count friends that
 are all packed up in barrels.=20
=20


--=-Xm6ibDkUZOJJyEqMuRRX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAQ3WkDBHcBS0tWxMRAnZHAJ9hajemMKd5/HY6mGxxH1OX/D43rwCgsjyI
uj0IIrvapvmVm85yZcgLTrI=
=/cxO
-----END PGP SIGNATURE-----

--=-Xm6ibDkUZOJJyEqMuRRX--

