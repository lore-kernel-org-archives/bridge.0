Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602294358;
 bh=iTtWEPs7R3iiq6VK1b1OfrjyVJP0Uism8CyeDJiP+1A=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=i3/UCdo4sP3wFVvX/GsyGPxSv+NwjzRumeuYLzX3/3SJCoMs2bq/S9SartvMqeZoV
 1SX+uZiRywSiMnwT0mk9trEnqyUeXfqOr5S87gAFtHsBvy+29SeRG8OiO0D0lwo1cX
 sHjtwGtujakQCWBgra+Xjitb8AkkTyt2bGyKVatA=
Date: Fri, 9 Oct 2020 18:45:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20201009184556.6cfe6fbc@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201009143530.2438738-8-henrik.bjoernlund@microchip.com>
References: <20201009143530.2438738-1-henrik.bjoernlund@microchip.com>
 <20201009143530.2438738-8-henrik.bjoernlund@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v4 07/10] bridge: cfm: Netlink SET
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

On Fri, 9 Oct 2020 14:35:27 +0000 Henrik Bjoernlund wrote:
> +static inline struct mac_addr nla_get_mac(const struct nlattr *nla)

static inlines are generally not needed in C sources and just hide
unused code. Please drop the inline annotation.

> +{
> +	struct mac_addr mac;
> +
> +	nla_memcpy(&mac.addr, nla, sizeof(mac.addr));
> +
> +	return mac;
> +}
> +
> +static inline struct br_cfm_maid nla_get_maid(const struct nlattr *nla)

ditto

> +{
> +	struct br_cfm_maid maid;
> +
> +	nla_memcpy(&maid.data, nla, sizeof(maid.data));

returning a 48B struct from a helper is a little strange, but I guess
it's not too bad when compiler inlines the thing?

> +	return maid;
> +}
> +
> +static const struct nla_policy
> +br_cfm_policy[IFLA_BRIDGE_CFM_MAX + 1] = {
> +	[IFLA_BRIDGE_CFM_UNSPEC]		= { .type = NLA_REJECT },

Not needed, REJECT is treated the same as 0 / uninit, right?

> +	[IFLA_BRIDGE_CFM_MEP_CREATE]		= { .type = NLA_NESTED },

Consider using NLA_POLICY_NESTED() to link up the next layers.

> +	[IFLA_BRIDGE_CFM_MEP_DELETE]		= { .type = NLA_NESTED },
> +	[IFLA_BRIDGE_CFM_MEP_CONFIG]		= { .type = NLA_NESTED },
> +	[IFLA_BRIDGE_CFM_CC_CONFIG]		= { .type = NLA_NESTED },
> +	[IFLA_BRIDGE_CFM_CC_PEER_MEP_ADD]	= { .type = NLA_NESTED },
> +	[IFLA_BRIDGE_CFM_CC_PEER_MEP_REMOVE]	= { .type = NLA_NESTED },
> +	[IFLA_BRIDGE_CFM_CC_RDI]		= { .type = NLA_NESTED },
> +	[IFLA_BRIDGE_CFM_CC_CCM_TX]		= { .type = NLA_NESTED },
> +};
