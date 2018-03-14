Return-Path: <arend.vanspriel@broadcom.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=RYgPMRyHKCzB8A1in2IFMY+9M0s4TgdGSaYxDkJhR88=;
	b=XBBDbSE0w4wp0kzzafdlLbnvHkScsVgOWmCEVic8M/pe0xDDVvJve9xuuFDYp4oNJo
	e3O3s/C8SwKR90dtWUTy6sVkIT5VdYuYeR3gBd8dWFraKj7wq9wInPsdtVLxUC1fxui9
	MVT7ZxUE0dfuN4/T+RNhw/FuBQnwn+j2+XXso=
References: <20180314110119.13631-1-zajec5@gmail.com>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5AA91C67.90001@broadcom.com>
MIME-Version: 1.0
In-Reply-To: <20180314110119.13631-1-zajec5@gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
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
Date: Wed, 14 Mar 2018 12:58:20 -0000
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, Kalle Valo <kvalo@codeaurora.org>
Cc: James Hughes <james.hughes@raspberrypi.org>, brcm80211-dev-list.pdl@broadcom.com, netdev@vger.kernel.org, Chi-Hsien Lin <chi-hsien.lin@cypress.com>, bridge@lists.linux-foundation.org, linux-wireless@vger.kernel.org, Hante Meuleman <hante.meuleman@broadcom.com>, Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>, Wright Feng <wright.feng@cypress.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, Felix Fietkau <nbd@nbd.name>, brcm80211-dev-list@cypress.com, Franky Lin <franky.lin@broadcom.com>

On 3/14/2018 12:01 PM, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
>
> Testing brcmfmac with more recent firmwares resulted in AP interfaces
> not working in some specific setups. Debugging resulted in discovering
> support for IAPP in Broadcom's firmwares. This is an obsoleted standard
> and its implementation is something that:
> 1) Most people don't need / want to use
> 2) Can allow local DoS attacks
> 3) Breaks AP interfaces in some specific bridge setups
>
> To solve issues it can cause this commit modifies brcmfmac to drop IAPP
> packets. If affects:
> 1) Rx path: driver won't be sending these unwanted packets up.
> 2) Tx path: driver will reject packets that would trigger STA
>     disassociation perfromed by a firmware (possible local DoS attack).
>
> It appears there are some Broadcom's clients/users who care about this
> feature despite the drawbacks. They can switch it on by a newly added
> Kconfig option.

Thanks for taking this approach. Looks fine except for .... (see below)

Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>   drivers/net/wireless/broadcom/brcm80211/Kconfig    | 20 +++++++++++
>   .../wireless/broadcom/brcm80211/brcmfmac/core.c    | 39 ++++++++++++++++++++++
>   2 files changed, 59 insertions(+)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/Kconfig b/drivers/net/wireless/broadcom/brcm80211/Kconfig
> index 9d99eb42d917..876787ef991a 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/Kconfig
> +++ b/drivers/net/wireless/broadcom/brcm80211/Kconfig
> @@ -68,6 +68,26 @@ config BRCMFMAC_PCIE
>   	  IEEE802.11ac embedded FullMAC WLAN driver. Say Y if you want to
>   	  use the driver for an PCIE wireless card.
>
> +config BRCMFMAC_IAPP
> +	bool "Partial support for obsoleted Inter-Access Point Protocol"
> +	depends on BRCMFMAC
> +	---help---
> +	  Most of Broadcom's firmwares can send 802.11f ADD frame every
> +	  time new STA connects to the AP interface. Some recent ones
> +	  can also disassociate STA when they receive such a frame.

I do not see any evidence that this would occur only for recent 
firmware. That stuff is old and not touched recently.

> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> index 19048526b4af..db6987015fb1 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c

[...]

>   static netdev_tx_t brcmf_netdev_start_xmit(struct sk_buff *skb,
>   					   struct net_device *ndev)
>   {
> @@ -250,6 +278,12 @@ static netdev_tx_t brcmf_netdev_start_xmit(struct sk_buff *skb,
>   		goto done;
>   	}
>
> +	if (!IS_ENABLED(CONFIG_BRCMFMAC_IAPP) && brcmf_skb_is_iapp(skb)) {
> +		dev_kfree_skb(skb);
> +		ret = -EINVAL;
> +		goto done;
> +	}

This is not right. The function must return netdev_tx_t type. Here is 
kerneldoc of .start_xmit():

  * netdev_tx_t (*ndo_start_xmit)(struct sk_buff *skb,
  *                               struct net_device *dev);
  *	Called when a packet needs to be transmitted.
  *	Returns NETDEV_TX_OK.  Can return NETDEV_TX_BUSY, but you should stop
  *	the queue before that can happen; it's for obsolete devices and weird
  *	corner cases, but the stack really does a non-trivial amount
  *	of useless work if you return NETDEV_TX_BUSY.
  *	Required; cannot be NULL.

You may want to increase dropped netstat or add driver internal 
statistic counter so there is visibility of IAPP packets being dropped.

Regards,
Arend
