Date: Sat, 11 Sep 2004 08:09:56 +0200
Subject: Re: [Bridge] sparc64: add bridge failed: Operation not supported
Message-ID: <20040911080956.T15021@macwheel.xs4all.nl>
References: <20040910223011.Q15021@macwheel.xs4all.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2/+Vq7w28QOSGzSM"
Content-Disposition: inline
In-Reply-To: <20040910223011.Q15021@macwheel.xs4all.nl>;
	from stappers@stappers.nl on Fri, Sep 10, 2004 at 10:30:11PM +0200
From: stappers@stappers.nl (Geert Stappers)
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org


--2/+Vq7w28QOSGzSM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 10, 2004 at 10:30:11PM +0200, Geert Stappers wrote:
> Hello,
Here so more information,

> On a Sun Sparc Ultra5, where `uname -m` reports "sparc64",
> and the bridge kernel modules is loaded (`insmod bridge`),
the kernel is version 2.4.26

> reports on `brctl addbr br0` with
> add bridge failed: Operation not supported
>=20
> That failure writes in /var/log/kern.log
> sys32_ioctl(brctl:572): Unknown cmd fd(3) cmd(000089a0) arg(effffcbd)
the 572 is the process id

> My questions are:
>=20
> * Are there succesfull reported sparc64 systems doing bridging?
> * What should I do to get that sparc64 acting as a bridge?
A recompile with gcc-2.95 did not show improvement.

> Cheers
> Geert Stappers

--2/+Vq7w28QOSGzSM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBQpa0OSINbgwa/7sRAgjyAJ9eIo8q3VmaL74U8dzMz6h3GNfqaACgitdM
ht5mnQSvkYBpVad8Ngd5DSg=
=mjUb
-----END PGP SIGNATURE-----

--2/+Vq7w28QOSGzSM--
