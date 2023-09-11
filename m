Return-Path: <pavel@denx.de>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4BC6181971
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 81F548196E
Date: Mon, 11 Sep 2023 11:36:15 +0200
From: Pavel Machek <pavel@denx.de>
Message-ID: <ZP7fj1LW3YLu2LrM@duo.ucw.cz>
References: <20230908182127.3461199-1-sashal@kernel.org>
 <20230908182127.3461199-6-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="EYwzxsuobC4JVE2D"
Content-Disposition: inline
In-Reply-To: <20230908182127.3461199-6-sashal@kernel.org>
Subject: Re: [Bridge] [PATCH AUTOSEL 4.14 6/8] netfilter: ebtables: fix
 fortify warnings in size_entry_mwt()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Sasha Levin <sashal@kernel.org>
Cc: bridge@lists.linux-foundation.org, pabeni@redhat.com, Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org, razor@blackwall.org, roopa@nvidia.com, Florian Westphal <fw@strlen.de>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, GONG@vger.kernel.org, linux-kernel@vger.kernel.org, edumazet@google.com, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, stable@vger.kernel.org, "GONG,
 Ruiqi" <gongruiqi1@huawei.com>, kuba@kernel.org, kadlec@netfilter.org, davem@davemloft.net, pablo@netfilter.org


--EYwzxsuobC4JVE2D
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit a7ed3465daa240bdf01a5420f64336fee879c09d ]
>=20
> When compiling with gcc 13 and CONFIG_FORTIFY_SOURCE=3Dy, the following
> warning appears:
>=20
> In function =E2=80=98fortify_memcpy_chk=E2=80=99,
>     inlined from =E2=80=98size_entry_mwt=E2=80=99 at net/bridge/netfilter=
/ebtables.c:2118:2:
> ./include/linux/fortify-string.h:592:25: error: call to =E2=80=98__read_o=
verflow2_field=E2=80=99
> declared with attribute warning: detected read beyond size of field (2nd =
parameter);
> maybe use struct_group()? [-Werror=3Dattribute-warning]
>   592 |                         __read_overflow2_field(q_size_field, size=
);
>       |
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This is not queued for 4.19. Mistake?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--EYwzxsuobC4JVE2D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZP7fjwAKCRAw5/Bqldv6
8jOPAJ446x9CNCOtOGu8jnKHqakoizjVowCfRJpsAS8y5nIe7eQnbTc+73ASZFY=
=5xRs
-----END PGP SIGNATURE-----

--EYwzxsuobC4JVE2D--
