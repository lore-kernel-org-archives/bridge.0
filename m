Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7AAE3610C5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9BD5560E24
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1687244168; x=1689836168;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qURJBP/qdgAxM7ZVrKekMbXpVFwIY0w1rl0S98JqRrY=;
 b=pVTj1zp0/qrrmSSVqckn6CBxM+ggdMfq78nPOEWemBGEdrykXBI0XQ2kljMCagq+Vg
 RMvni/PxPuD77mR/DRMbO9fRTIVKirSfiVMekLPIVnnwr7XnyDHWokPxjnK+xs4VQURU
 FmX+jgJujhzW9VZb1h6oYENi7XasxDaHeICz7Emgf1EUbFcPpPP5HGeHzPAfssfx+dHy
 jreQhybyKOcFqVFQMIITHbBHTit45bw8tk/Xx2V7G/mU/3vTgzUXos68Mhl+kYwt/RZc
 DZFeV8EIClWcZzRaJ/gbgY6a/zyR+8uJNyeZ06zruiaIjtSpTBgJpxwcgkrqWbOKYn2M
 Kk4w==
Message-ID: <3fdb4091-3dc9-e1f2-26a6-561c021c9fae@blackwall.org>
Date: Tue, 20 Jun 2023 09:56:06 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20230619071444.14625-1-jnixdorf-oss@avm.de>
 <20230619071444.14625-4-jnixdorf-oss@avm.de>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230619071444.14625-4-jnixdorf-oss@avm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 3/3] net: bridge: Add a
 configurable default FDB learning limit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Johannes Nixdorf <jnixdorf-oss@avm.de>, bridge@lists.linux-foundation.org
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@gmail.com>, Roopa Prabhu <roopa@nvidia.com>, Oleksij Rempel <linux@rempel-privat.de>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On 6/19/23 10:14, Johannes Nixdorf wrote:
> This adds a Kconfig option to configure a default FDB learning limit
> system wide, so a distributor building a special purpose kernel can
> limit all created bridges by default.
> 
> The limit is only a soft default setting and overridable per bridge
> using netlink.
> 
> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
> 
> ---
> 
> Changes since v1:
>   - Added a default limit in Kconfig. (deemed acceptable in review
>     comments)
> 
>   net/bridge/Kconfig     | 13 +++++++++++++
>   net/bridge/br_device.c |  2 ++
>   2 files changed, 15 insertions(+)
> 
> diff --git a/net/bridge/Kconfig b/net/bridge/Kconfig
> index 3c8ded7d3e84..c0d9c08088c4 100644
> --- a/net/bridge/Kconfig
> +++ b/net/bridge/Kconfig
> @@ -84,3 +84,16 @@ config BRIDGE_CFM
>   	  Say N to exclude this support and reduce the binary size.
>   
>   	  If unsure, say N.
> +
> +config BRIDGE_DEFAULT_FDB_MAX_LEARNED
> +	int "Default FDB learning limit"
> +	default 0
> +	depends on BRIDGE
> +	help
> +	  Sets a default limit on the number of learned FDB entries on
> +	  new bridges. This limit can be overwritten via netlink on a
> +	  per bridge basis.
> +
> +	  The default of 0 disables the limit.
> +
> +	  If unsure, say 0.
> diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
> index 8eca8a5c80c6..93f081ce8195 100644
> --- a/net/bridge/br_device.c
> +++ b/net/bridge/br_device.c
> @@ -530,6 +530,8 @@ void br_dev_setup(struct net_device *dev)
>   	br->bridge_ageing_time = br->ageing_time = BR_DEFAULT_AGEING_TIME;
>   	dev->max_mtu = ETH_MAX_MTU;
>   
> +	br->fdb_max_learned_entries = CONFIG_BRIDGE_DEFAULT_FDB_MAX_LEARNED;
> +
>   	br_netfilter_rtable_init(br);
>   	br_stp_timer_init(br);
>   	br_multicast_init(br);

IMO this is pointless, noone will set the kconfig option except very 
specific users. I prefer if we leave it to the distribution to set a 
maximum on bridge creation, i.e. make it a distro policy.

