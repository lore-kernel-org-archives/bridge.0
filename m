Return-Path: <atenart@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602509859;
 bh=mvGEPH4UmSON2svJ1yiU7FBCC0Sgo3PEgLHn7hbXVBA=;
 h=In-Reply-To:References:Subject:Cc:To:From:Date:From;
 b=g1QxIh3VbJlOes9tKz95+xFrXF2XlCTXSAE7mkAFtJGXMJ0jWyq2TUiG6xGcP3I2p
 9EyHU8Q1RaunZXaJZqguVXrqSpEt0h3CVRlJ+3vgxn96Oa9on7L3ATCLIiPkoSVTSC
 pkvlJocmhwy0YDPAMqz49epWC5gkR/hYpw4iEicE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0d81e0f7-7784-42df-8e10-d0b77ca5b7ee@gmail.com>
References: <d77b65de-1793-f808-66b5-aaa4e7c8a8f0@gmail.com>
 <0d81e0f7-7784-42df-8e10-d0b77ca5b7ee@gmail.com>
From: Antoine Tenart <atenart@kernel.org>
Message-ID: <160250985474.6233.14282398170315752864@surface>
Date: Mon, 12 Oct 2020 15:37:34 +0200
Subject: Re: [Bridge] [PATCH net-next v2 03/12] net: macsec: use new
	function dev_fetch_sw_netstats
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bjorn@mork.no, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Andrew Lunn <andrew@lunn.ch>, David Miller <davem@davemloft.net>, Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Igor Mitsyanko <imitsyanko@quantenna.com>, Jakub Kicinski <kuba@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, Kalle Valo <kvalo@codeaurora.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Oliver Neukum <oneukum@suse.com>, Pravin B Shelar <pshelar@ovn.org>, Roopa Prabhu <roopa@nvidia.com>, Sergey Matyukevich <geomatsi@gmail.com>, Steffen Klassert <steffen.klassert@secunet.com>, Vivien Didelot <vivien.didelot@gmail.com>, Vladimir Oltean <olteanv@gmail.com>
Cc: linux-rdma@vger.kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Linux USB Mailing List <linux-usb@vger.kernel.org>, linux-wireless <linux-wireless@vger.kernel.org>, bridge@lists.linux-foundation.org

Hello,

Quoting Heiner Kallweit (2020-10-12 10:04:11)
> Simplify the code by using new function dev_fetch_sw_netstats().
>=20
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Antoine Tenart <atenart@kernel.org>

Thanks!
Antoine

> ---
>  drivers/net/macsec.c | 22 +---------------------
>  1 file changed, 1 insertion(+), 21 deletions(-)
>=20
> diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
> index 2b0c8f01d..11ca5fa90 100644
> --- a/drivers/net/macsec.c
> +++ b/drivers/net/macsec.c
> @@ -3647,30 +3647,10 @@ static int macsec_change_mtu(struct net_device *d=
ev, int new_mtu)
>  static void macsec_get_stats64(struct net_device *dev,
>                                struct rtnl_link_stats64 *s)
>  {
> -       int cpu;
> -
>         if (!dev->tstats)
>                 return;
> =20
> -       for_each_possible_cpu(cpu) {
> -               struct pcpu_sw_netstats *stats;
> -               struct pcpu_sw_netstats tmp;
> -               int start;
> -
> -               stats =3D per_cpu_ptr(dev->tstats, cpu);
> -               do {
> -                       start =3D u64_stats_fetch_begin_irq(&stats->syncp=
);
> -                       tmp.rx_packets =3D stats->rx_packets;
> -                       tmp.rx_bytes   =3D stats->rx_bytes;
> -                       tmp.tx_packets =3D stats->tx_packets;
> -                       tmp.tx_bytes   =3D stats->tx_bytes;
> -               } while (u64_stats_fetch_retry_irq(&stats->syncp, start));
> -
> -               s->rx_packets +=3D tmp.rx_packets;
> -               s->rx_bytes   +=3D tmp.rx_bytes;
> -               s->tx_packets +=3D tmp.tx_packets;
> -               s->tx_bytes   +=3D tmp.tx_bytes;
> -       }
> +       dev_fetch_sw_netstats(s, dev->tstats);
> =20
>         s->rx_dropped =3D dev->stats.rx_dropped;
>         s->tx_dropped =3D dev->stats.tx_dropped;
> --=20
> 2.28.0
>=20
>=20
