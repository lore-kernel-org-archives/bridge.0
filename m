Date: Sun, 12 Sep 2004 17:19:52 +0200
Subject: Re: [Bridge] sparc64: add bridge failed: Operation not supported
Message-ID: <20040912171952.E15021@macwheel.xs4all.nl>
References: <20040910223011.Q15021@macwheel.xs4all.nl>
	<20040911080956.T15021@macwheel.xs4all.nl>
	<20040911152908.U15021@macwheel.xs4all.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7kW37LRKoI6fR2de"
Content-Disposition: inline
In-Reply-To: <20040911152908.U15021@macwheel.xs4all.nl>;
	from stappers@stappers.nl on Sat, Sep 11, 2004 at 03:29:08PM +0200
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


--7kW37LRKoI6fR2de
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 11, 2004 at 03:29:08PM +0200, Geert Stappers wrote:
> On Sat, Sep 11, 2004 at 08:09:56AM +0200, Geert Stappers wrote:
> > On Fri, Sep 10, 2004 at 10:30:11PM +0200, Geert Stappers wrote:
> > > Hello,
 <snip/>
> > > My questions are:
> > >=20
> > > * Are there succesfull reported sparc64 systems doing bridging?
sparc64 seems indeed be some what special on the bridging aspect ...

> > > * What should I do to get that sparc64 acting as a bridge?
> > A recompile with gcc-2.95 did not show improvement.
> AFAICT it is brctl 1.0.4 that needs a 2.6 kernel.

Installing kernel 2.6.8 allowed me to do bridging on a sparc64

> > > Cheers
> > > Geert Stappers

Cheers
Geert Stappers

--7kW37LRKoI6fR2de
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBRGkYOSINbgwa/7sRAgLcAJ0VDiiMPGBr3YAdYDMf/RvuOKutTQCfWTv5
ThfFbc23n4UD//INuAsAb7k=
=bhcs
-----END PGP SIGNATURE-----

--7kW37LRKoI6fR2de--
