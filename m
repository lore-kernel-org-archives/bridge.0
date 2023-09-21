Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BC5F24203A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 43496420E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1695300113; x=1695904913;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fv18euYIHxUyDyU2umf2N7sAa5N8tvwc+B+kdZWr598=;
 b=B4mxryEgOOHdhUtAkJPAC5/uSHD7cV0QfmAYC/4E/oG1vKfV0tirXXAxrGivbkmGMz
 zUvV16e7+zrpCkpQdlUk2/fK5diFSFNVhIy1i/8W6Hd4Yc7ag8XQ63pX/bR/hdDj9uFP
 ZsoWOhqhqo09WmnHt0nfCJYLJZebVQImuyUJLzOJA2rRdU6CZTDuNK01SXHXoSG2+KZE
 1Y1zQHekddvmQjKvClEQjEhSXri3SlQG9j5PaeNEW+F0Z88ed6cFSUrnlA4hnwOmwaFq
 wn6MSb70Kg8trZxc2F29Tcqd17OYiT7VY2UerhKSlsdwF7+cfjhwyHJ8eMCpBjvWKQyT
 oMOg==
Message-ID: <0ae67e4d-0d51-5290-1255-1fe1b699ca14@blackwall.org>
Date: Thu, 21 Sep 2023 15:41:50 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20230919-fdb_limit-v4-0-39f0293807b8@avm.de>
 <20230919-fdb_limit-v4-4-39f0293807b8@avm.de>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230919-fdb_limit-v4-4-39f0293807b8@avm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v4 4/6] net: bridge: Add netlink knobs
 for number / max learned FDB entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Johannes Nixdorf <jnixdorf-oss@avm.de>, "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, David Ahern <dsahern@gmail.com>, Eric Dumazet <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>, Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Oleksij Rempel <linux@rempel-privat.de>, Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, Shuah Khan <shuah@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

On 9/19/23 11:12, Johannes Nixdorf wrote:
> The previous patch added accounting and a limit for the number of
> dynamically learned FDB entries per bridge. However it did not provide
> means to actually configure those bounds or read back the count. This
> patch does that.
> 
> Two new netlink attributes are added for the accounting and limit of
> dynamically learned FDB entries:
>   - IFLA_BR_FDB_N_LEARNED (RO) for the number of entries accounted for
>     a single bridge.
>   - IFLA_BR_FDB_MAX_LEARNED (RW) for the configured limit of entries for
>     the bridge.
> 
> The new attributes are used like this:
> 
>   # ip link add name br up type bridge fdb_max_learned 256
>   # ip link add name v1 up master br type veth peer v2
>   # ip link set up dev v2
>   # mausezahn -a rand -c 1024 v2
>   0.01 seconds (90877 packets per second
>   # bridge fdb | grep -v permanent | wc -l
>   256
>   # ip -d link show dev br
>   13: br: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 [...]
>       [...] fdb_n_learned 256 fdb_max_learned 256
> 
> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
> ---
>   include/uapi/linux/if_link.h |  2 ++
>   net/bridge/br_netlink.c      | 15 ++++++++++++++-
>   2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index ce3117df9cec..0486f314c176 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -510,6 +510,8 @@ enum {
>   	IFLA_BR_VLAN_STATS_PER_PORT,
>   	IFLA_BR_MULTI_BOOLOPT,
>   	IFLA_BR_MCAST_QUERIER_STATE,
> +	IFLA_BR_FDB_N_LEARNED,
> +	IFLA_BR_FDB_MAX_LEARNED,
>   	__IFLA_BR_MAX,
>   };
>   
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 505683ef9a26..f5d49a05e61b 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -1267,6 +1267,8 @@ static const struct nla_policy br_policy[IFLA_BR_MAX + 1] = {
>   	[IFLA_BR_VLAN_STATS_PER_PORT] = { .type = NLA_U8 },
>   	[IFLA_BR_MULTI_BOOLOPT] =
>   		NLA_POLICY_EXACT_LEN(sizeof(struct br_boolopt_multi)),
> +	[IFLA_BR_FDB_N_LEARNED] = { .type = NLA_U32 },
> +	[IFLA_BR_FDB_MAX_LEARNED] = { .type = NLA_U32 },
>   };
>   
>   static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
> @@ -1541,6 +1543,12 @@ static int br_changelink(struct net_device *brdev, struct nlattr *tb[],
>   			return err;
>   	}
>   
> +	if (data[IFLA_BR_FDB_MAX_LEARNED]) {
> +		u32 val = nla_get_u32(data[IFLA_BR_FDB_MAX_LEARNED]);
> +
> +		WRITE_ONCE(br->fdb_max_learned, val);
> +	}
> +
>   	return 0;
>   }
>   
> @@ -1595,6 +1603,8 @@ static size_t br_get_size(const struct net_device *brdev)
>   	       nla_total_size_64bit(sizeof(u64)) + /* IFLA_BR_TOPOLOGY_CHANGE_TIMER */
>   	       nla_total_size_64bit(sizeof(u64)) + /* IFLA_BR_GC_TIMER */
>   	       nla_total_size(ETH_ALEN) +       /* IFLA_BR_GROUP_ADDR */
> +	       nla_total_size(sizeof(u32)) +    /* IFLA_BR_FDB_N_LEARNED */
> +	       nla_total_size(sizeof(u32)) +    /* IFLA_BR_FDB_MAX_LEARNED */
>   #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
>   	       nla_total_size(sizeof(u8)) +     /* IFLA_BR_MCAST_ROUTER */
>   	       nla_total_size(sizeof(u8)) +     /* IFLA_BR_MCAST_SNOOPING */
> @@ -1670,7 +1680,10 @@ static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
>   	    nla_put_u8(skb, IFLA_BR_TOPOLOGY_CHANGE_DETECTED,
>   		       br->topology_change_detected) ||
>   	    nla_put(skb, IFLA_BR_GROUP_ADDR, ETH_ALEN, br->group_addr) ||
> -	    nla_put(skb, IFLA_BR_MULTI_BOOLOPT, sizeof(bm), &bm))
> +	    nla_put(skb, IFLA_BR_MULTI_BOOLOPT, sizeof(bm), &bm) ||
> +	    nla_put_u32(skb, IFLA_BR_FDB_N_LEARNED,
> +			atomic_read(&br->fdb_n_learned)) ||
> +	    nla_put_u32(skb, IFLA_BR_FDB_MAX_LEARNED, br->fdb_max_learned))
>   		return -EMSGSIZE;
>   
>   #ifdef CONFIG_BRIDGE_VLAN_FILTERING
> 

Actually you're using atomic for counting, but using a u32 for the 
limit, you should cap it because the count can overflow. Or you should
use atomic64 for the counting.



