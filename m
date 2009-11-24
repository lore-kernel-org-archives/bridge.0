Message-ID: <4B0B9639.4070607@gmail.com>
Date: Tue, 24 Nov 2009 09:15:53 +0100
From: Eric Dumazet <eric.dumazet@gmail.com>
MIME-Version: 1.0
References: <1259024166-28158-1-git-send-email-arnd@arndb.de>
	<1259024166-28158-3-git-send-email-arnd@arndb.de>
In-Reply-To: <1259024166-28158-3-git-send-email-arnd@arndb.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH 2/4] macvlan: cleanup rx statistics
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Anna Fischer <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Mark Smith <lk-netdev@lk-netdev.nosense.org>, Gerhard Stenzel <gerhard.stenzel@de.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Jens Osterkamp <jens@linux.vnet.ibm.com>, Patrick Mullaney <pmullaney@novell.com>, Stephen Hemminger <shemminger@vyatta.com>, Edge Virtual Bridging <evb@yahoogroups.com>, David Miller <davem@davemloft.net>

Arnd Bergmann a =E9crit :
> We have very similar code for rx statistics in
> two places in the macvlan driver, with a third
> one being added in the next patch.
>=20
> Consolidate them into one function to improve
> overall readability of the driver.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/macvlan.c |   63 +++++++++++++++++++++++++------------------=
-----
>  1 files changed, 33 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
> index ae2b5c7..a0dea23 100644
> --- a/drivers/net/macvlan.c
> +++ b/drivers/net/macvlan.c
> @@ -116,42 +116,53 @@ static int macvlan_addr_busy(const struct macvlan_p=
ort *port,
>  	return 0;
>  }
> =20
> +static inline void macvlan_count_rx(const struct macvlan_dev *vlan, int =
length,
> +			     int success, int multicast)

success and multicast should be declared as bool

> +{
> +	struct macvlan_rx_stats *rx_stats;
> +
> +	rx_stats =3D per_cpu_ptr(vlan->rx_stats, smp_processor_id());
> +	rx_stats->rx_packets +=3D success !=3D 0;
> +	rx_stats->rx_bytes   +=3D success ? length : 0;
> +	rx_stats->multicast  +=3D success && multicast;
> +	rx_stats->rx_errors  +=3D !success;
> +}
> +

I find following more readable, it probably generates more branches,
but avoid dirtying rx_errors if it is in another cache line.

if (likely(success)) {
	rx_stats->rx_packets++;
	rx_stats->rx_bytes +=3D length;
	if (multicast)
		rx_stats->multicast++;
} else {
	rx_stats->rx_errors++;
}


> -	rx_stats =3D per_cpu_ptr(vlan->rx_stats, smp_processor_id());
>  	skb =3D skb_share_check(skb, GFP_ATOMIC);
> -	if (skb =3D=3D NULL) {
> -		rx_stats->rx_errors++;
> -		return NULL;
> -	}
> -
> -	rx_stats->rx_bytes +=3D skb->len + ETH_HLEN;
> -	rx_stats->rx_packets++;
> +	macvlan_count_rx(vlan, skb->len + ETH_HLEN, likely(skb !=3D NULL), 0);

its not _likely_ that skb !=3D NULL, its a fact :)

-> macvlan_count_rx(vlan, skb->len + ETH_HLEN, true, false);

