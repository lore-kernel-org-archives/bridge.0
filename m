Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=Qzn148We9XavLCPnkjKAVkx4J24baZYNxkMK7Z/8yLA=;
 b=6zcvRk4t6zjIi9VUqhYdQe5+Y/t3BN+bwbv90esoK9EZDsSs6uD08xfUsY5UgyewXR
 c2roVuOjy6N2Mi1WzTgSTN80CWaQKrdCwAuGud5odlmrPqbDKs4wTuuorWJSNJJ75h5l
 kplFvdJdLES5TaVpqwOJKtG0YD1lbIgtg9j7dGBplZZdnesop0BhKVkBC0URr9GqoqvI
 ZAJSKtRXAFAINt/zKBta4T2sBoc4MAi1BaYEdTrXrzuc90f8HdFwRxKNCE/Y4jAYtyc7
 YGuzMfU+Q6Q+ML8z8vzSstV3dyqe76Wl1ABDb5DHolRI9g3lU+S25RmzBYMbE7G/mr51
 gGug==
Message-ID: <76490693-ea6d-7174-0546-b9361ab5088c@blackwall.org>
Date: Tue, 12 Apr 2022 21:36:34 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20220411133837.318876-1-troglobit@gmail.com>
 <20220411133837.318876-4-troglobit@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20220411133837.318876-4-troglobit@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH RFC net-next 03/13] net: bridge: minor refactor
 of br_setlink() for readability
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joachim Wiberg <troglobit@gmail.com>, Roopa Prabhu <roopa@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Vladimir Oltean <vladimir.oltean@nxp.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

On 11/04/2022 16:38, Joachim Wiberg wrote:
> The br_setlink() function extracts the struct net_bridge pointer a bit
> sloppy.  It's easy to interpret the code wrong.  This patch attempts to
> clear things up a bit.
> 
> Signed-off-by: Joachim Wiberg <troglobit@gmail.com>
> ---
>  net/bridge/br_netlink.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 

I think you can make it more straight-forward, remove the first br = netdev_priv
and do something like (completely untested):
...
struct net_bridge_port *p = NULL;
...
if (netif_is_bridge_master(dev)) {
 br = netdev_priv(dev);
} else {
 p = br_port_get_rtnl(dev);
 if (WARN_ON(!p))
	return -EINVAL;
 br = p->br;
}

So br is always and only set in this block.

> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 7fca8ff13ec7..8f4297287b32 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -1040,6 +1040,8 @@ int br_setlink(struct net_device *dev, struct nlmsghdr *nlh, u16 flags,
>  		return 0;
>  
>  	p = br_port_get_rtnl(dev);
> +	if (p)
> +		br = p->br;
>  	/* We want to accept dev as bridge itself if the AF_SPEC
>  	 * is set to see if someone is setting vlan info on the bridge
>  	 */
> @@ -1055,17 +1057,17 @@ int br_setlink(struct net_device *dev, struct nlmsghdr *nlh, u16 flags,
>  			if (err)
>  				return err;
>  
> -			spin_lock_bh(&p->br->lock);
> +			spin_lock_bh(&br->lock);
>  			err = br_setport(p, tb, extack);
> -			spin_unlock_bh(&p->br->lock);
> +			spin_unlock_bh(&br->lock);
>  		} else {
>  			/* Binary compatibility with old RSTP */
>  			if (nla_len(protinfo) < sizeof(u8))
>  				return -EINVAL;
>  
> -			spin_lock_bh(&p->br->lock);
> +			spin_lock_bh(&br->lock);
>  			err = br_set_port_state(p, nla_get_u8(protinfo));
> -			spin_unlock_bh(&p->br->lock);
> +			spin_unlock_bh(&br->lock);
>  		}
>  		if (err)
>  			goto out;

