Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWidAe/8A4gdk6Kl8311PrlfqqyC1xvATabjBn6pkyk=;
 b=Ej2Ge6n2InAqQomc87fweyXLr+eFIn43jiZsyuDzU/L1myrc+vf5R+ZxgZC2SPTuGiFUSoda5ouO8paHZRZzbfg6ZOfAqrBba2RF1bFymlBhh/HbLc2vHsCJPBnteuUGVmul/4xvjxRkCXT730UrMnjhwFI8wwgpWhr51+9VjIro6wwLpnkO9levH+VHhapypNGY7aAuWXIj3u/vo4X7vvtErMMPithjtaLpw/BVeVQ0UvjHhh7/QdG2XiAMBFFR5Cfy7MSt9OuJEiAQDDhYS8UWix4p53C5L5Vif0/BPGZJIoP3QBggtzfULBw8kFAEzyylE6vX+rMhHM9fbwO78Q==
Message-ID: <60f020b7-53b8-4f3c-ead2-8077aad8e5bb@nvidia.com>
Date: Sat, 19 Feb 2022 11:46:37 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220218155148.2329797-1-schultz.hans+netdev@gmail.com>
 <20220218155148.2329797-2-schultz.hans+netdev@gmail.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
In-Reply-To: <20220218155148.2329797-2-schultz.hans+netdev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3 1/5] net: bridge: Add support for
 bridge port in locked mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <schultz.hans@gmail.com>, davem@davemloft.net, kuba@kernel.org
Cc: Petr Machata <petrm@nvidia.com>, Andrew Lunn <andrew@lunn.ch>, Baowen Zheng <baowen.zheng@corigine.com>, Florian Fainelli <f.fainelli@gmail.com>, Amit Cohen <amcohen@nvidia.com>, netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Stephen Suryaputra <ssuryaextr@gmail.com>, Hans Schultz <schultz.hans+netdev@gmail.com>, Po-Hsu Lin <po-hsu.lin@canonical.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>

On 18/02/2022 17:51, Hans Schultz wrote:
> In a 802.1X scenario, clients connected to a bridge port shall not
> be allowed to have traffic forwarded until fully authenticated.
> A static fdb entry of the clients MAC address for the bridge port
> unlocks the client and allows bidirectional communication.
> 
> This scenario is facilitated with setting the bridge port in locked
> mode, which is also supported by various switchcore chipsets.
> 
> Signed-off-by: Hans Schultz <schultz.hans+netdev@gmail.com>
> ---
>  include/linux/if_bridge.h    |  1 +
>  include/uapi/linux/if_link.h |  1 +
>  net/bridge/br_input.c        | 10 +++++++++-
>  net/bridge/br_netlink.c      |  6 +++++-
>  4 files changed, 16 insertions(+), 2 deletions(-)
> 

Hi Hans,
The patch looks good overall, I have one minor cosmetic comment below.

> diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
> index 509e18c7e740..3aae023a9353 100644
> --- a/include/linux/if_bridge.h
> +++ b/include/linux/if_bridge.h
> @@ -58,6 +58,7 @@ struct br_ip_list {
>  #define BR_MRP_LOST_CONT	BIT(18)
>  #define BR_MRP_LOST_IN_CONT	BIT(19)
>  #define BR_TX_FWD_OFFLOAD	BIT(20)
> +#define BR_PORT_LOCKED		BIT(21)
>  
>  #define BR_DEFAULT_AGEING_TIME	(300 * HZ)
>  
> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index 6218f93f5c1a..a45cc0a1f415 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -537,6 +537,7 @@ enum {
>  	IFLA_BRPORT_MRP_IN_OPEN,
>  	IFLA_BRPORT_MCAST_EHT_HOSTS_LIMIT,
>  	IFLA_BRPORT_MCAST_EHT_HOSTS_CNT,
> +	IFLA_BRPORT_LOCKED,
>  	__IFLA_BRPORT_MAX
>  };
>  #define IFLA_BRPORT_MAX (__IFLA_BRPORT_MAX - 1)
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index b50382f957c1..e99f635ff727 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -81,6 +81,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
>  	if (!p || p->state == BR_STATE_DISABLED)
>  		goto drop;
>  
> +	br = p->br;
>  	brmctx = &p->br->multicast_ctx;
>  	pmctx = &p->multicast_ctx;
>  	state = p->state;
> @@ -88,10 +89,17 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
>  				&state, &vlan))
>  		goto out;
>  
> +	if (p->flags & BR_PORT_LOCKED) {
> +		struct net_bridge_fdb_entry *fdb_src =
> +			br_fdb_find_rcu(br, eth_hdr(skb)->h_source, vid);

Please leave an empty line between variable declaration and the code.

> +		if (!fdb_src || READ_ONCE(fdb_src->dst) != p ||
> +		    test_bit(BR_FDB_LOCAL, &fdb_src->flags))
> +			goto drop;
> +	}
> +

With the above change you can add my Acked-by tag.

Thanks,
 Nik
