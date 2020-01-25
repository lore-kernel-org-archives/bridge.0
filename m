Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7pOZtCRspHMG7P8OoioPIeVczYmsdyWf2zfgI15qGfA=; b=FBkqhd+zNjAokfOr0U28bnV6cy
 rS/LI20ZiGJKZQ169QVHehvysN/lCP2dukOffEJL6rkdG/UR3LJBUK0bE5+Wg1u6eXZIdevpfGxJ8
 0rK9AQ5S+ShDtvfzuhBY62mgUhN6r0jKdOegG0eMW+93WfcBWb5k7eaITn+tB7zYPErk=;
Date: Sat, 25 Jan 2020 17:16:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20200125161615.GD18311@lunn.ch>
References: <20200124161828.12206-1-horatiu.vultur@microchip.com>
 <20200124161828.12206-10-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124161828.12206-10-horatiu.vultur@microchip.com>
Subject: Re: [Bridge] [RFC net-next v3 09/10] net: bridge: mrp: Integrate
 MRP into the bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: ivecera@redhat.com, jiri@resnulli.us, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, anirudh.venkataramanan@intel.com, jeffrey.t.kirsher@intel.com, olteanv@gmail.com, davem@davemloft.net

>  br_netif_receive_skb(struct net *net, struct sock *sk, struct sk_buff *skb)
> @@ -338,6 +341,17 @@ rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
>  			return RX_HANDLER_CONSUMED;
>  		}
>  	}
> +#ifdef CONFIG_BRIDGE_MRP
> +	/* If there is no MRP instance do normal forwarding */
> +	if (!p->mrp_aware)
> +		goto forward;
> +
> +	if (skb->protocol == htons(ETH_P_MRP))
> +		return RX_HANDLER_PASS;

What MAC address is used for these MRP frames? It would make sense to
use a L2 link local destination address, since i assume they are not
supposed to be forwarded by the bridge. If so, you could extend the
if (unlikely(is_link_local_ether_addr(dest))) condition.

> +
> +	if (p->state == BR_STATE_BLOCKING)
> +		goto drop;
> +#endif

Is this needed? The next block of code is a switch statement on
p->state. The default case, which BR_STATE_BLOCKING should hit, is
drop.

This function is on the hot path. So we should try to optimize it as
much as possible.

     Andrew
