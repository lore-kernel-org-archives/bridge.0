Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9951A41706
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 68A0A41705
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w/AZ/A/olYCP18HetNsEPN25VtnURtcy+kAXgeU7ycM=;
 b=fjrTGrhig1y4OqWIksdP6M4gdfwa71nXHU9U/H7D7xPlxVJ+zyBk2qqW5YfW0OAwX1
 PNkeIbHDkAKnRhhZV2G0GEknGvaUi82PvwJqeZ5jQJ/zh/I8fZuNI0uDKckoBfVI49AZ
 RMrG3mTEOjU1ZlJMbpxWVr9BKBsvaHodQfpGksB0+qnZ4hbJeWAJwgXitwJGyeyj7Q6x
 hgUXtqI7GCcUYj3Azk0GrGJTx5RdEKSGNl1QXzS+D2IHFfTFUmHSIAo0TunNi7eOZ7en
 abS5zii44GGB8pDiHYuMORB5OI7eyTzWqqAa7kp3XnP3jCVhkoun01+63SGyPH4zEf4d
 peug==
Message-ID: <dbfe0af4-24f8-bdc9-38ea-c873936bdd7f@blackwall.org>
Date: Sun, 29 Jan 2023 11:09:29 +0200
MIME-Version: 1.0
References: <cover.1674752051.git.petrm@nvidia.com>
 <8886e11bde5874305a26c0b7dc397923a1d5a794.1674752051.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <8886e11bde5874305a26c0b7dc397923a1d5a794.1674752051.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 01/16] net: bridge: Set
 strict_start_type at two policies
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org

On 26/01/2023 19:01, Petr Machata wrote:
> Make any attributes newly-added to br_port_policy or vlan_tunnel_policy
> parsed strictly, to prevent userspace from passing garbage. Note that this
> patchset only touches the former policy. The latter was adjusted for
> completeness' sake. There do not appear to be other _deprecated calls
> with non-NULL policies.
> 
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_netlink.c        | 2 ++
>  net/bridge/br_netlink_tunnel.c | 3 +++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 4316cc82ae17..a6133d469885 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -858,6 +858,8 @@ static int br_afspec(struct net_bridge *br,
>  }
>  
>  static const struct nla_policy br_port_policy[IFLA_BRPORT_MAX + 1] = {
> +	[IFLA_BRPORT_UNSPEC]	= { .strict_start_type =
> +					IFLA_BRPORT_MCAST_EHT_HOSTS_LIMIT + 1 },
>  	[IFLA_BRPORT_STATE]	= { .type = NLA_U8 },
>  	[IFLA_BRPORT_COST]	= { .type = NLA_U32 },
>  	[IFLA_BRPORT_PRIORITY]	= { .type = NLA_U16 },
> diff --git a/net/bridge/br_netlink_tunnel.c b/net/bridge/br_netlink_tunnel.c
> index 8914290c75d4..17abf092f7ca 100644
> --- a/net/bridge/br_netlink_tunnel.c
> +++ b/net/bridge/br_netlink_tunnel.c
> @@ -188,6 +188,9 @@ int br_fill_vlan_tunnel_info(struct sk_buff *skb,
>  }
>  
>  static const struct nla_policy vlan_tunnel_policy[IFLA_BRIDGE_VLAN_TUNNEL_MAX + 1] = {
> +	[IFLA_BRIDGE_VLAN_TUNNEL_UNSPEC] = {
> +		.strict_start_type = IFLA_BRIDGE_VLAN_TUNNEL_FLAGS + 1
> +	},
>  	[IFLA_BRIDGE_VLAN_TUNNEL_ID] = { .type = NLA_U32 },
>  	[IFLA_BRIDGE_VLAN_TUNNEL_VID] = { .type = NLA_U16 },
>  	[IFLA_BRIDGE_VLAN_TUNNEL_FLAGS] = { .type = NLA_U16 },

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

