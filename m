Date: Sun, 27 Mar 2011 14:37:49 +0800
From: Herbert Xu <herbert@gondor.hengli.com.au>
Message-ID: <20110327063749.GA24299@gondor.apana.org.au>
References: <20110327034404.GC31916@Sellars>
	<1301207244-10428-1-git-send-email-linus.luessing@web.de>
	<1301207244-10428-2-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1301207244-10428-2-git-send-email-linus.luessing@web.de>
Subject: Re: [Bridge] [PATCH] bridge: mcast snooping,
	fix IPv6 MLD checksum	calculation
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@web.de>
Cc: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, David Miller <davem@davemloft.net>

On Sun, Mar 27, 2011 at 08:27:23AM +0200, Linus L=FCssing wrote:
> In contrast to IGMP, the MLDv1/2 message checksum needs to include an
> IPv6 "pseudo-header" in the calculations (see RFC2710, section 3.3;
> RFC3810, section 5.1.2).
>=20
> The multicast snooping feature of the bridge code however did not take
> this "pseudo-header" into consideration for the checksum validation when
> parsing a snooped IPv6 MLDv1/2 message of another host, leading to
> possibly ignored, though valid MLDv1/2 messages. This commit shall fix
> this issue.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>
> ---
>  net/bridge/br_multicast.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
>=20
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index f61eb2e..47fae4f 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1525,7 +1525,10 @@ static int br_multicast_ipv6_rcv(struct net_bridge=
 *br,
>  			break;
>  		/*FALLTHROUGH*/
>  	case CHECKSUM_NONE:
> -		skb2->csum =3D 0;
> +		skb2->csum =3D ~csum_unfold(csum_ipv6_magic(&ip6h->saddr,
> +							  &ip6h->daddr,
> +							  skb2->len,
> +							  nexthdr, 0));

You also need to include the pseudo-header for the CHECKSUM_COMPLETE
case, before we've fallen through (which only happens if the
hardware checksum doesn't match).

Thanks,
--=20
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
