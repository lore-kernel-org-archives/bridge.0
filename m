Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0yrxVL6xhRd/sdLuiSvmYyX87dqeoDckLZbdQPLqkd8=;
 b=YLx0Q8tKCRfI/UO7dFeN4/R+v2Tp/kB7N0smu8bt0DssonIDnzvxDIV3O/s6WLCWXE
 3kTeeulbNvJlxV3Hg4JnQ+PMORipZXgsjNNadhhPEV6d3knnxD9SGQmifnJeoP8zQ2nH
 NdFlpJaW8O7LnVgJoge/9/DWjfQqmOcrWZBwMAaVlgC86NdG6jzHA7v1OoEUVRnOxhwE
 kbKllme/FsqhEIX8glGlhM0kO/KpBhgR+LmA/Csnoa4ZjO53azDAekaB+hpbBAJAPYge
 dglPKpT5wJ2tlQwM2UPHk8lszSKPvWYePjvoqzDAofDfq21rcM7kkgP5oNSZSU78dc6o
 zy6Q==
Date: Thu, 7 Apr 2022 09:16:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20220407091640.1551b9d4@hermes.local>
In-Reply-To: <20220407151217.GA8736@codemonkey.org.uk>
References: <20220407151217.GA8736@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] decouple llc/bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>, Roopa Prabhu <roopa@nvidia.com>

On Thu, 7 Apr 2022 11:12:17 -0400
Dave Jones <davej@codemonkey.org.uk> wrote:

> I was wondering why the llc code was getting compiled and it turned out
> to be because I had bridging enabled. It turns out to only needs it for
> a single function (llc_mac_hdr_init).
> 
> Converting this to a static inline like the other llc functions it uses
> allows to decouple the dependency
> 
> Signed-off-by: Dave Jones <davej@codemonkey.org.uk>
> 
> diff --git include/net/llc.h include/net/llc.h
> index e250dca03963..edcb120ee6b0 100644
> --- include/net/llc.h
> +++ include/net/llc.h
> @@ -13,6 +13,7 @@
>   */
>  
>  #include <linux/if.h>
> +#include <linux/if_arp.h>
>  #include <linux/if_ether.h>
>  #include <linux/list.h>
>  #include <linux/spinlock.h>
> @@ -100,8 +101,34 @@ extern struct list_head llc_sap_list;
>  int llc_rcv(struct sk_buff *skb, struct net_device *dev, struct packet_type *pt,
>  	    struct net_device *orig_dev);
>  
> -int llc_mac_hdr_init(struct sk_buff *skb, const unsigned char *sa,
> -		     const unsigned char *da);
> +/**
> + *      llc_mac_hdr_init - fills MAC header fields
> + *      @skb: Address of the frame to initialize its MAC header
> + *      @sa: The MAC source address
> + *      @da: The MAC destination address
> + *
> + *      Fills MAC header fields, depending on MAC type. Returns 0, If MAC type
> + *      is a valid type and initialization completes correctly 1, otherwise.
> + */
> +static inline int llc_mac_hdr_init(struct sk_buff *skb,
> +				   const unsigned char *sa, const unsigned char *da)
> +{
> +	int rc = -EINVAL;
> +
> +	switch (skb->dev->type) {
> +	case ARPHRD_ETHER:
> +	case ARPHRD_LOOPBACK:
> +		rc = dev_hard_header(skb, skb->dev, ETH_P_802_2, da, sa,
> +				     skb->len);
> +		if (rc > 0)
> +			rc = 0;
> +		break;
> +	default:
> +		break;
> +	}
> +	return rc;
> +}
> +
>  
>  void llc_add_pack(int type,
>  		  void (*handler)(struct llc_sap *sap, struct sk_buff *skb));
> diff --git net/802/Kconfig net/802/Kconfig
> index aaa83e888240..8bea5d1d5118 100644
> --- net/802/Kconfig
> +++ net/802/Kconfig
> @@ -1,7 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config STP
>  	tristate
> -	select LLC
>  
>  config GARP
>  	tristate
> diff --git net/bridge/Kconfig net/bridge/Kconfig
> index 3c8ded7d3e84..c011856d3386 100644
> --- net/bridge/Kconfig
> +++ net/bridge/Kconfig
> @@ -5,7 +5,6 @@
>  
>  config BRIDGE
>  	tristate "802.1d Ethernet Bridging"
> -	select LLC
>  	select STP
>  	depends on IPV6 || IPV6=n
>  	help
> diff --git net/llc/llc_output.c net/llc/llc_output.c
> index 5a6466fc626a..ad66886ed141 100644
> --- net/llc/llc_output.c
> +++ net/llc/llc_output.c
> @@ -13,34 +13,6 @@
>  #include <net/llc.h>
>  #include <net/llc_pdu.h>
>  
> -/**
> - *	llc_mac_hdr_init - fills MAC header fields
> - *	@skb: Address of the frame to initialize its MAC header
> - *	@sa: The MAC source address
> - *	@da: The MAC destination address
> - *
> - *	Fills MAC header fields, depending on MAC type. Returns 0, If MAC type
> - *	is a valid type and initialization completes correctly 1, otherwise.
> - */
> -int llc_mac_hdr_init(struct sk_buff *skb,
> -		     const unsigned char *sa, const unsigned char *da)
> -{
> -	int rc = -EINVAL;
> -
> -	switch (skb->dev->type) {
> -	case ARPHRD_ETHER:
> -	case ARPHRD_LOOPBACK:
> -		rc = dev_hard_header(skb, skb->dev, ETH_P_802_2, da, sa,
> -				     skb->len);
> -		if (rc > 0)
> -			rc = 0;
> -		break;
> -	default:
> -		break;
> -	}
> -	return rc;
> -}
> -
>  /**
>   *	llc_build_and_send_ui_pkt - unitdata request interface for upper layers
>   *	@sap: sap to use

You may break other uses of LLC.

Why not open code as different function.  I used the llc stuff because there
were multiple copies of same code (DRY).
