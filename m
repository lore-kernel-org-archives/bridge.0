From: Ben Hutchings <bhutchings@solarflare.com>
In-Reply-To: <20110422163116.3C5C3138DD@rere.qmqm.pl>
References: <20110422163116.3C5C3138DD@rere.qmqm.pl>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 27 Apr 2011 01:26:10 +0100
Message-ID: <1303863970.2850.31.camel@bwh-desktop>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH] net: fix netdev_increment_features()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: netdev@vger.kernel.org, Jay Vosburgh <fubar@us.ibm.com>, bridge@lists.linux-foundation.org

On Fri, 2011-04-22 at 18:31 +0200, Micha=C5=82 Miros=C5=82aw wrote:
> Simplify and fix netdev_increment_features() to conform to what is
> stated in netdevice.h comments about NETIF_F_ONE_FOR_ALL.
> Include FCoE segmentation and VLAN-challedged flags in computation.
>=20
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---
>=20
> I noticed this while converting bridge code to hw_features. After
> adding devices to the bridge all features were always cleared regardless
> of features active in those devices.
>=20
>  include/linux/netdevice.h |    7 ++++++-
>  net/core/dev.c            |   37 ++++++++++++-------------------------
>  2 files changed, 18 insertions(+), 26 deletions(-)
>=20
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 405ce21..86140e4 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1107,7 +1107,12 @@ struct net_device {
>  	 */
>  #define NETIF_F_ONE_FOR_ALL	(NETIF_F_GSO_SOFTWARE | NETIF_F_GSO_ROBUST |=
 \
>  				 NETIF_F_SG | NETIF_F_HIGHDMA |		\
> -				 NETIF_F_FRAGLIST)
> +				 NETIF_F_FRAGLIST | NETIF_F_VLAN_CHALLENGED)

I think we can also add NETIF_F_HW_VLAN_TX, now that
dev_hard_start_xmit() handles VLAN tag insertion.

> +	/*
> +	 * If one device doesn't support one of these features, then disable it
> +	 * for all in netdev_increment_features.
> +	 */
> +#define NETIF_F_ALL_FOR_ALL	(NETIF_F_NOCACHE_COPY | NETIF_F_FSO)

Shouldn't most RX offloads be included in this?  Though it doesn't
really matter that much.

>  	/* changeable features with no special hardware requirements */
>  #define NETIF_F_SOFT_FEATURES	(NETIF_F_GSO | NETIF_F_GRO)
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 3871bf6..1a2c91c 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6184,33 +6184,20 @@ static int dev_cpu_callback(struct notifier_block=
 *nfb,
>   */
>  u32 netdev_increment_features(u32 all, u32 one, u32 mask)
>  {
> +	if (mask & NETIF_F_GEN_CSUM)
> +		mask |=3D NETIF_F_ALL_CSUM;
> +	mask |=3D NETIF_F_VLAN_CHALLENGED;
> +
> +	all |=3D one & (NETIF_F_ONE_FOR_ALL|NETIF_F_ALL_CSUM) & mask;
> +	all &=3D one | ~NETIF_F_ALL_FOR_ALL;
> +
>  	/* If device needs checksumming, downgrade to it. */
> -	if (all & NETIF_F_NO_CSUM && !(one & NETIF_F_NO_CSUM))
> -		all ^=3D NETIF_F_NO_CSUM | (one & NETIF_F_ALL_CSUM);
> -	else if (mask & NETIF_F_ALL_CSUM) {
> -		/* If one device supports v4/v6 checksumming, set for all. */
> -		if (one & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM) &&
> -		    !(all & NETIF_F_GEN_CSUM)) {
> -			all &=3D ~NETIF_F_ALL_CSUM;
> -			all |=3D one & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM);
> -		}
> +	if (all & (NETIF_F_ALL_CSUM & ~NETIF_F_NO_CSUM))
> +		all &=3D ~NETIF_F_NO_CSUM;
> =20
> -		/* If one device supports hw checksumming, set for all. */
> -		if (one & NETIF_F_GEN_CSUM && !(all & NETIF_F_GEN_CSUM)) {
> -			all &=3D ~NETIF_F_ALL_CSUM;
> -			all |=3D NETIF_F_HW_CSUM;
> -		}
> -	}
> -
> -	/* If device can't no cache copy, don't do for all */
> -	if (!(one & NETIF_F_NOCACHE_COPY))
> -		all &=3D ~NETIF_F_NOCACHE_COPY;
> -
> -	one |=3D NETIF_F_ALL_CSUM;
> -
> -	one |=3D all & NETIF_F_ONE_FOR_ALL;
> -	all &=3D one | NETIF_F_LLTX | NETIF_F_GSO | NETIF_F_UFO;
> -	all |=3D one & mask & NETIF_F_ONE_FOR_ALL;
> +	/* If one device supports hw checksumming, set for all. */
> +	if (all & NETIF_F_GEN_CSUM)
> +		all &=3D ~(NETIF_F_ALL_CSUM & ~NETIF_F_GEN_CSUM);
> =20
>  	return all;
>  }

Well it might be correct, but it's hard to tell.  Can we see your unit
tests, please?

Ben.

--=20
Ben Hutchings, Senior Software Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.

