Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602718430;
 bh=fJuaBZAYZB2ASZnOsQGXjvE2pynwdjPBgfBtVj+H8F4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=c/Mwj5CLJFeg5vBNDeMaxa33nHbmDZun8T/4ILG736efYFWqfucNlCWD/mIFyIp0U
 EbkSPN2poPGBQpgEfedIaBV4grIdHVZ/SciOKy6ZsdQv2lRhMDJIo1dCmFQiNAj1mh
 NUAIvlAl5JzBpAH2m/B0/JqLfxXctsj8mei7fBTM=
Date: Wed, 14 Oct 2020 16:33:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20201014163348.2f99e349@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <20201012140428.2549163-9-henrik.bjoernlund@microchip.com>
References: <20201012140428.2549163-1-henrik.bjoernlund@microchip.com>
 <20201012140428.2549163-9-henrik.bjoernlund@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v5 08/10] bridge: cfm: Netlink GET
 configuration Interface.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, idosch@mellanox.com, jiri@mellanox.com, nikolay@nvidia.com, roopa@nvidia.com, Horatiu Vultur <horatiu.vultur@microchip.com>, davem@davemloft.net

On Mon, 12 Oct 2020 14:04:26 +0000 Henrik Bjoernlund wrote:
> +		if (nla_put_u32(skb, IFLA_BRIDGE_CFM_CC_CCM_TX_SEQ_NO_UPDATE,
> +				mep->cc_ccm_tx_info.seq_no_update))
> +			goto nla_put_failure;
> +
> +		if (nla_put_u32(skb, IFLA_BRIDGE_CFM_CC_CCM_TX_PERIOD,
> +				mep->cc_ccm_tx_info.period))
> +			goto nla_put_failure;
> +
> +		if (nla_put_u32(skb, IFLA_BRIDGE_CFM_CC_CCM_TX_IF_TLV,
> +				mep->cc_ccm_tx_info.if_tlv))
> +			goto nla_put_failure;
> +
> +		if (nla_put_u8(skb, IFLA_BRIDGE_CFM_CC_CCM_TX_IF_TLV_VALUE,
> +			       mep->cc_ccm_tx_info.if_tlv_value))
> +			goto nla_put_failure;
> +
> +		if (nla_put_u32(skb, IFLA_BRIDGE_CFM_CC_CCM_TX_PORT_TLV,
> +				mep->cc_ccm_tx_info.port_tlv))
> +			goto nla_put_failure;
> +
> +		if (nla_put_u8(skb, IFLA_BRIDGE_CFM_CC_CCM_TX_PORT_TLV_VALUE,
> +			       mep->cc_ccm_tx_info.port_tlv_value))
> +			goto nla_put_failure;

Consider collapsing writing related attrs in a nest into a single
if statement:

	if (nla_put_u32(skb, IFLA_BRIDGE_CFM_CC_CCM_TX_SEQ_NO_UPDATE,
			mep->cc_ccm_tx_info.seq_no_update) ||
	    nla_put_u32(skb, IFLA_BRIDGE_CFM_CC_CCM_TX_PERIOD,
			mep->cc_ccm_tx_info.period) ||
		...
