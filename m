Return-Path: <broonie@sirena.org.uk>
Date: Thu, 13 Nov 2014 19:47:52 +0000
From: Mark Brown <broonie@kernel.org>
Message-ID: <20141113194752.GQ3815@sirena.org.uk>
References: <20141112233738.GB3815@sirena.org.uk>
	<20141113113320.GF3815@sirena.org.uk>
	<20141113114357.GA7857@salvia>
	<20141113.143513.785778562781935404.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8A8vkjq8WxqbGzeT"
Content-Disposition: inline
In-Reply-To: <20141113.143513.785778562781935404.davem@davemloft.net>
Subject: Re: [Bridge] arm64 allmodconfig failures in nft_reject_bridge.c
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: linaro-kernel@lists.linaro.org, kernel-build-reports@lists.linaro.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, stephen@networkplumber.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, pablo@netfilter.org, kadlec@blackhole.kfki.hu, kaber@trash.net, linux@roeck-us.net


--8A8vkjq8WxqbGzeT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 13, 2014 at 02:35:13PM -0500, David Miller wrote:

> I hold changes in my tree for a week or more, because I want them to
> "cook" there before they go to Linus.

Hrm.  Guess there must've been some other change in -next that pulled
the header in implicitly here :(

> So if it takes a week or two for a bug fix like this to propagate into
> Linus's tree, that's just what sometimes happens.

> In the mean time you can apply the fix locally if you absolutely have
> to have it right at this moment, that is the freedom that everyone
> has.

This can be a bit problematic for build (or widespread boot) breaks in
common configs since it takes out all the automated runtime testing that
people have running for the time the build break is in place.  In this
case it was just allmodconfig so it doesn't really get non-build testing
and makes little difference but for defconfigs it can be a more
substantial impact.  Applying fixes locally doesn't really work for this
case.

> FWIW, I plan to push my tree to Linus some time today, so this will be
> resolved in the next day or so.

Great, thanks.

--8A8vkjq8WxqbGzeT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUZQrnAAoJECTWi3JdVIfQJlkIAIJ9dZBa1EoU/6FHmwDKiw7g
63e+maRlJtxoulwYscDkTws0xKOl2cKH4MpuTtqhLUy3f5QBv20PAbiJfBZfSxX6
DEHyPYe373lGQcSY4q1jCPU9eCPk2pai9f3boIamOxZqEOxz0vPo5BQk0Fz6pAGh
vDN4POGDejV/+Fc2bRVrXOVCwjYUICLBFFAnsItV4NiE1FkBkq2Zy3hiHekuA3SD
UACx3+8M7cVqvSAqiRACrzCXZddRQ1U0B0b6wdMtNXYEFpR8Dlst6I0etxYlF5/e
eOhIf/SNxPJdrE38DJTpYg1mN5z9VJkZJhaUpUEdcrzosHou7dLokt/BWAXgOFM=
=CLvh
-----END PGP SIGNATURE-----

--8A8vkjq8WxqbGzeT--
