Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=0JGpt7xsjLRYxkWoFrwmh9KO3NVf0Cy+eQJm5k/e7BM=;
	b=rTCFuWJx4Sq6Y9CeBljOnymHsTJ8XamBnfYbqyNoZVSPQEeWegOgyuUWAu1eBgy4It
	88k+WHZWOo6lZ2AXsNy8sROCMC0kn7qcIyw1KiWllqgr4vMdnKhvpPHqcs5Pa+jGYVds
	mgBTmMejAn86wZldqNJ9jddtpcPJmdqlQReRldITjrvOAHU0PXF4SBgnABTYjhc8ayiI
	EdowGvcgYgQyvbwLun6IfRBUyUDpxDD9cEiGTidL2AAGGl6owBXl+gPCElwzmd9hXgQ3
	2hFSN11vZ+izWDtsxf5RkAmcSc1yIumE3UmBhEl/tCFegrtKZmEev8Efgp2SfQNoB9cd
	cU+A==
Date: Wed, 14 Mar 2018 08:08:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20180314080831.35cac09c@xeon-e3>
In-Reply-To: <20180314110119.13631-1-zajec5@gmail.com>
References: <20180314110119.13631-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH] brcmfmac: drop Inter-Access Point Protocol
 packets by default
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: James Hughes <james.hughes@raspberrypi.org>, Arend van Spriel <arend.vanspriel@broadcom.com>, netdev@vger.kernel.org, Chi-Hsien Lin <chi-hsien.lin@cypress.com>, bridge@lists.linux-foundation.org, linux-wireless@vger.kernel.org, Hante Meuleman <hante.meuleman@broadcom.com>, Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>, brcm80211-dev-list.pdl@broadcom.com, Wright Feng <wright.feng@cypress.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, Felix Fietkau <nbd@nbd.name>, brcm80211-dev-list@cypress.com, Kalle Valo <kvalo@codeaurora.org>, Franky Lin <franky.lin@broadcom.com>

On Wed, 14 Mar 2018 12:01:19 +0100
Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> wrote:

> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/dr=
ivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> index 19048526b4af..db6987015fb1 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> @@ -230,6 +230,34 @@ static void brcmf_netdev_set_multicast_list(struct n=
et_device *ndev)
>  	schedule_work(&ifp->multicast_work);
>  }
> =20
> +/**
> + * brcmf_skb_is_iapp - checks if skb is an IAPP packet
> + *
> + * @skb: skb to check
> + */
> +static bool brcmf_skb_is_iapp(struct sk_buff *skb)
> +{
> +	const u8 iapp_l2_update_packet[6] __aligned(2) =3D {
> +		0x00, 0x01, 0xaf, 0x81, 0x01, 0x00,
> +	};
> +	unsigned char *eth_data =3D skb_mac_header(skb) + ETH_HLEN;
> +#if !defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
> +	const u16 *a =3D (const u16 *)eth_data;
> +	const u16 *b =3D (const u16 *)iapp_l2_update_packet;
> +#endif
> +
> +	if (skb->len - skb->mac_len !=3D 6 ||
> +	    !is_multicast_ether_addr(eth_hdr(skb)->h_dest))
> +		return false;
> +
> +#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
> +	return !(((*(const u32 *)eth_data) ^ (*(const u32 *)iapp_l2_update_pack=
et)) |
> +		 ((*(const u16 *)(eth_data + 4)) ^ (*(const u16 *)(iapp_l2_update_pack=
et + 4))));
> +#else
> +	return !((a[0] ^ b[0]) | (a[1] ^ b[1]) | (a[2] ^ b[2]));
> +#endif
> +}
> +
>  static netdev_tx_t brcmf_netdev_start_xmit(struct sk_buff *skb,
>  					   struct net_device *ndev)
>  {
> @@ -250,6 +278,12 @@ static netdev_tx_t brcmf_netdev_start_xmit(struct sk=
_buff *skb,
>  		goto done;
>  	}
> =20
> +	if (!IS_ENABLED(CONFIG_BRCMFMAC_IAPP) && brcmf_skb_is_iapp(skb)) {
> +		dev_kfree_skb(skb);
> +		ret =3D -EINVAL;
> +		goto done;
> +	}
> +

The usual way to handle config options in kernel is either inline
stub function or #define

#ifdef CONFIG_BRFMMAC_IAPP
static bool brcmf_skb_is_app(...) {
	real code
}
#else
#define brcmf_skb_is_app  (false)
#endif

