Return-Path: <pablo@netfilter.org>
Date: Mon, 10 Dec 2018 12:23:22 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20181210112322.rxndlqmfckctbhjm@salvia>
References: <20181209061405.15112-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181209061405.15112-1-linus.luessing@c0d3.blue>
Subject: Re: [Bridge] [PATCH net-next v2] netfilter: ebtables: avoid
 resetting limit rule state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, "David S . Miller" <davem@davemloft.net>

Hi Linus,

On Sun, Dec 09, 2018 at 07:14:05AM +0100, Linus L=FCssing wrote:
> So far any changes with ebtables will reset the state of limit rules,
> leading to spikes in traffic. This is especially noticeable if changes
> are done frequently, for instance via a daemon.
>=20
> This patch fixes this by bailing out from (re)setting if the limit
> rule was initialized before.
>=20
> When sending packets every 250ms for 600s, with a
> "--limit 1/sec --limit-burst 50" rule and a command like this
> in the background:
>=20
> $ ebtables -N VOIDCHAIN
> $ while true; do ebtables -F VOIDCHAIN; sleep 30; done
>=20
> The results are:
>=20
> Before: ~1600 packets
> After: 650 packets
>=20
> This also aligns the behavior to "xtables-nft-multi ebtables" which uses
> nft_limit instead of ebt_limit. In tests nft_limit did not suffer from
> this issue and rate limited to 650 just fine.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
>=20
> ---
>=20
> Changelog v2:
>=20
> - Adjusted commit message (adjusted title, added test results with
>   nft_limit for comparison)
> - Excluded rate limiting variables from zeroing when passed to userspace
>   by increasing .usersize. This became necessary with 4.11 /
>   commit ec2318904965 ("xtables: extend matches and targets with .usersiz=
e")
> - Retested with 4.20-rc4 and current net-next/master (83af01ba1c2d)
>=20
> v1 was:
>=20
> "[net-next] bridge: ebtables: Avoid resetting limit rule state"
> -> https://lore.kernel.org/patchwork/patch/854802/
> ---
>  net/bridge/netfilter/ebt_limit.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/bridge/netfilter/ebt_limit.c b/net/bridge/netfilter/ebt_=
limit.c
> index 165b9d678cf1..2cf9861c3bce 100644
> --- a/net/bridge/netfilter/ebt_limit.c
> +++ b/net/bridge/netfilter/ebt_limit.c
> @@ -69,6 +69,10 @@ static int ebt_limit_mt_check(const struct xt_mtchk_pa=
ram *par)
>  {
>  	struct ebt_limit_info *info =3D par->matchinfo;
> =20
> +	/* Do not reset state on unrelated table changes */
> +	if (info->prev)
> +		return 0;

Hm, still I don't think we can follow this path, even if it works.

This means we trust userspace in what it sets for info->prev.

Using ebtables-nft (instead of ebtables-legacy) fixes this problem,
without this patch.

> +
>  	/* Check for overflow. */
>  	if (info->burst =3D=3D 0 ||
>  	    user2credits(info->avg * info->burst) < user2credits(info->avg)) {
> @@ -105,7 +109,7 @@ static struct xt_match ebt_limit_mt_reg __read_mostly=
 =3D {
>  	.match		=3D ebt_limit_mt,
>  	.checkentry	=3D ebt_limit_mt_check,
>  	.matchsize	=3D sizeof(struct ebt_limit_info),
> -	.usersize	=3D offsetof(struct ebt_limit_info, prev),
> +	.usersize	=3D sizeof(struct ebt_limit_info),
>  #ifdef CONFIG_COMPAT
>  	.compatsize	=3D sizeof(struct ebt_compat_limit_info),
>  #endif
> --=20
> 2.11.0
>=20
