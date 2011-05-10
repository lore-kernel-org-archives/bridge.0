Date: Mon, 9 May 2011 21:38:33 -0700
From: Noah Meyerhans <noahm@debian.org>
Message-ID: <20110510043833.GG6397@morgul.net>
References: <20110506201234.6297.70279.reportbug@ip6-localhost>
	<1304995124.4065.157.camel@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lFRK9w0o3gensELN"
Content-Disposition: inline
In-Reply-To: <1304995124.4065.157.camel@localhost>
Subject: Re: [Bridge] Bug#625914: linux-image-2.6.38-2-amd64: bridging is
	not	interacting well with multicast in 2.6.38-4
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: 625914@bugs.debian.org, bridge@lists.linux-foundation.org, netdev <netdev@vger.kernel.org>


--lFRK9w0o3gensELN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 10, 2011 at 03:38:44AM +0100, Ben Hutchings wrote:
> This is pretty weird.  Debian version 2.6.38-3 has a few bridging
> changes from stable 2.6.38.3 and 2.6.38.4, but they don't look like they
> would cause this.

I have apparently filed the bug against the wrong version of Debian's
kernel.  2.6.38-3 is not affected, and works as expected.  The change
was introduced in -4.  That may have been clear from the report itself,
but the report was filed against -3.  I've fixed that in the BTS.

I've also confirmed that -5 is affected, to no great surprise.

I'll investigate further.

noah


--lFRK9w0o3gensELN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFNyMFJYrVLjBFATsMRArhNAJ0bccdvjeUyjmEdwHo7Er+J+mL7qQCbBVb5
3zmB8Esv3xPtfmyLlEV5H6E=
=NP+w
-----END PGP SIGNATURE-----

--lFRK9w0o3gensELN--
