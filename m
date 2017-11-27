Return-Path: <pneira@us.es>
Date: Tue, 28 Nov 2017 00:30:08 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20171127233008.GA1418@salvia>
References: <20171125074418.16537-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20171125074418.16537-1-linus.luessing@c0d3.blue>
Subject: Re: [Bridge] [PATCH net-next] bridge: ebtables: Avoid resetting
 limit rule state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, "David S . Miller" <davem@davemloft.net>

Hi Linus,

On Sat, Nov 25, 2017 at 08:44:18AM +0100, Linus L=FCssing wrote:
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
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  net/bridge/netfilter/ebt_limit.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/net/bridge/netfilter/ebt_limit.c b/net/bridge/netfilter/ebt_=
limit.c
> index 61a9f1be1263..f74b48633feb 100644
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

What kernel version are you using? I suspect you don't have this
applied?

commit ec23189049651b16dc2ffab35a4371dc1f491aca
Author: Willem de Bruijn <willemb@google.com>
Date:   Mon Jan 2 17:19:46 2017 -0500

    xtables: extend matches and targets with .usersize
