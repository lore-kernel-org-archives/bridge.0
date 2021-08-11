Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=46gsBV
 2j973bcXk58Yhoh6T8qA9awpQNF3grGouu5fs=; b=LEmXRq4gE48Ra1Yw4mS0b+
 ojXjF41Nyu1tPJnG8hqPyeJSjrGWhaUF3OjcuayiuVQwCWqV6AHjdQUEOl7UBWwq
 qolJ6xWMywEog1bPksUMXYytedDbqaMmeCftEe2SG9s23h1uDopwzeXxa/ffgiT1
 wTkC0OKgzH1Dk0vyow3X/e362EpdXBklTd4/bak1a9lI1EefSc0D3IYg0+3HhTjV
 9QBd2k926dKN4soU1kOiuaQBXgK5chdgojk+Xni/vcePpHc/xW63+qQe+ZNCU8zM
 nAeJC9gepPlNFiQmgfVycjguV9xBXxvn4wQtygQ8AmE6lE4OtcUOnvd2xAQ7lHfQ
 ==
Date: Thu, 12 Aug 2021 00:38:56 +0300
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <YRRDcGWaWHgBkNhQ@shredder>
References: <20210811135247.1703496-1-dqfext@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811135247.1703496-1-dqfext@gmail.com>
Subject: Re: [Bridge] [PATCH net-next] net: bridge: switchdev: allow port
 isolation to be offloaded
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: DENG Qingfang <dqfext@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, "open list:ETHERNET BRIDGE" <netdev@vger.kernel.org>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>

On Wed, Aug 11, 2021 at 09:52:46PM +0800, DENG Qingfang wrote:
> Add BR_ISOLATED flag to BR_PORT_FLAGS_HW_OFFLOAD, to allow switchdev
> drivers to offload port isolation.
> 
> Suggested-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: DENG Qingfang <dqfext@gmail.com>
> ---
>  net/bridge/br_switchdev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> index 6bf518d78f02..898257153883 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c
> @@ -71,7 +71,8 @@ bool nbp_switchdev_allowed_egress(const struct net_bridge_port *p,
>  
>  /* Flags that can be offloaded to hardware */
>  #define BR_PORT_FLAGS_HW_OFFLOAD (BR_LEARNING | BR_FLOOD | \
> -				  BR_MCAST_FLOOD | BR_BCAST_FLOOD)
> +				  BR_MCAST_FLOOD | BR_BCAST_FLOOD | \
> +				  BR_ISOLATED)

Why add it now and not as part of a patchset that actually makes use of
the flag in a driver that offloads port isolation?

>  
>  int br_switchdev_set_port_flag(struct net_bridge_port *p,
>  			       unsigned long flags,
> -- 
> 2.25.1
> 
