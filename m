Date: Wed, 30 Mar 2011 11:37:38 -0500
From: Igor Serebryany <igor47@moomers.org>
Message-ID: <20110330163738.GO23639@moomers.org>
References: <loom.20110328T194703-472@post.gmane.org>
	<AANLkTi=8TqZWM_xxkAh16KoHTPe+8vBjeoqWNy-icm64@mail.gmail.com>
	<20110329183657.GB2781@psychotron.redhat.com>
	<AANLkTiktA_41W2X+J0Z94B_gsDcrmO0i0YHVQFQSnxLJ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iAzLNm1y1mIRgolD"
Content-Disposition: inline
In-Reply-To: <AANLkTiktA_41W2X+J0Z94B_gsDcrmO0i0YHVQFQSnxLJ@mail.gmail.com>
Subject: Re: [Bridge] 802.1q tagging broken when used with bridging in 2.6.38
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org
Cc: Jiri Pirko <jpirko@redhat.com>


--iAzLNm1y1mIRgolD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 29, 2011 at 03:18:44PM -0400, Andy Gospodarek wrote:
> I have no idea what version Igor was using before.  Even if Igor's
> upgrade as not from 2.6.37, this sounds like a regression.

I am using debian, and in Sid the kernel versions go from 2.6.32 to
2.6.37. I had a chance to test 2.6.37, and it behaves the same way as
2.6.38, with the problem I've described. 2.6.32 behaves as expected.

--Igor

--iAzLNm1y1mIRgolD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk2TXFIACgkQVyVcp2k8D/ns3gCeM3a+anYKNMZf56RGfz9tNNoF
nesAnRV5Su3opMeFAybJSS3y6XKx3Jn1
=M7+/
-----END PGP SIGNATURE-----

--iAzLNm1y1mIRgolD--
