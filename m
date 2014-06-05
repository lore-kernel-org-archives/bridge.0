Return-Path: <David.Laight@ACULAB.COM>
From: David Laight <David.Laight@ACULAB.COM>
Date: Thu, 5 Jun 2014 11:03:57 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D17257C08@AcuExch.aculab.com>
References: <1401965851-6449-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
In-Reply-To: <1401965851-6449-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next] bridge: Fix incorrect judgment of
	promisc
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: 'Toshiaki Makita' <makita.toshiaki@lab.ntt.co.jp>, "David S . Miller" <davem@davemloft.net>, Stephen Hemminger <stephen@networkplumber.org>
Cc: Vlad Yasevich <vyasevic@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

From: Toshiaki Makita
> br_manage_promisc() incorrectly expects br_auto_port() to return only 0
> or 1, while it actually returns flags, i.e., a subset of BR_AUTO_MASK.
>=20
> Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
> ---
>  net/bridge/br_if.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
> index a08d2b8..6a07a40 100644
> --- a/net/bridge/br_if.c
> +++ b/net/bridge/br_if.c
> @@ -153,7 +153,7 @@ void br_manage_promisc(struct net_bridge *br)
>  			 * This lets us disable promiscuous mode and write
>  			 * this config to hw.
>  			 */
> -			if (br->auto_cnt <=3D br_auto_port(p))
> +			if (br->auto_cnt <=3D !!br_auto_port(p))
>  				br_port_clear_promisc(p);
>  			else
>  				br_port_set_promisc(p);

Why not the less confusing:
			if (br->auto_cnt || br_auto_port(p))
and reverse the then/else lines?

	David



