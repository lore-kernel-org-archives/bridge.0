Return-Path: <broonie@sirena.org.uk>
Date: Thu, 13 Nov 2014 11:33:20 +0000
From: Mark Brown <broonie@kernel.org>
Message-ID: <20141113113320.GF3815@sirena.org.uk>
References: <E1Xm8gR-0005nT-PY@debutante> <20141106104616.GU8509@sirena.org.uk>
	<20141112233738.GB3815@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="13Npr3Skz9EA5hx0"
Content-Disposition: inline
In-Reply-To: <20141112233738.GB3815@sirena.org.uk>
Subject: Re: [Bridge] arm64 allmodconfig failures in nft_reject_bridge.c
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>, Guenter Roeck <linux@roeck-us.net>, Pablo Neira Ayuso <pablo@netfilter.org>, Patrick McHardy <kaber@trash.net>, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, Stephen Hemminger <stephen@networkplumber.org>
Cc: linaro-kernel@lists.linaro.org, kernel-build-reports@lists.linaro.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org


--13Npr3Skz9EA5hx0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Since about -rc3 we've been seeing build failures in Linus' tree on
arm64 allmodconfig due to:

> 	arm64-allmodconfig
> ../net/bridge/netfilter/nft_reject_bridge.c:240:3: error: implicit declaration of function 'csum_ipv6_magic' [-Werror=implicit-function-declaration]

By the time I looked into this it was fixed in -next by c1207c049b204b0
(netfilter: nft_reject_bridge: Fix powerpc build error) from Guenter but
that doesn't seem to have made it into -rc4 so I just wanted to check
that this fix was intended to go to Linus before v3.18?

--13Npr3Skz9EA5hx0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUZJb/AAoJECTWi3JdVIfQxH4H/18dBwydBc9XYHTRlOuHwRt1
/joz1Sg1TIbFh9G5KZ4MXBTWn7x3zR+ZuyjlPG3QYNvQso/S0HNhFZlCEfv15FK0
kosBfUnNr5jMS4+VCqXiJlmYYSGSsK8AKyuUJB5hUBO+aOMPZNgAERVACsnhuzaT
OOoLTOG3cLZ1SQ/f8LefwUzdKo4RdK3fo0N5Xdwf0TtPh9xn74g8cqVcIGyQVD1R
i0mwDbs5Mo2FKWUz9V1sNBPeUKbs0bwwIiP8neIPIZmFqeP9srh3u6FvDF5Salib
0ZoiNOUzf07vcOqG+KGqwxPqPB87NGeeLhk197qEkhDwCmi3qxCTIOLJ80USpaQ=
=tleq
-----END PGP SIGNATURE-----

--13Npr3Skz9EA5hx0--
