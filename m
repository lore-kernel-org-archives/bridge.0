Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6x3iIGyCGsN68lIF6ed9AghORaspzdJVcLPtIKjcQKI=;
 b=NpZHsjjJ/5PT5aW0vu8nYH751pAGqZdvQQrrPEBBpGGCUNhvVTQq5zn5jfypzbnNVPjZNYLYixgRBQzuMManpc/DZKk5LUZ2cDG/j2A3/W7gDeHALZIvP0zUV5c3FN5JnzxaEn+pv3q5KvkR4/haQulwdZNgT9E5V1NtJ2v5uK1fBMBeNJK0hlRNWIykegfPTiGh5uOgLbVFOR320gLdyVGjPTdw0Y/u1vk1w1G1y5YalCsTKlZDHMnqiHF/HJN2r4mAlAYy7eq393tCHunTZAIUAEYjnjoJjvF4fuT/+EBQAt4zMSKOixu1whnHMPsfH367u4Jsh53X1Y4DyqpHVA==
Message-ID: <fc5450f0-5d60-ac5c-03dd-e42507a52465@nvidia.com>
Date: Thu, 27 Jan 2022 10:03:30 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220127074953.12632-1-tim.yi@pica8.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
In-Reply-To: <20220127074953.12632-1-tim.yi@pica8.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] net: bridge: vlan: fix memory leak in
	__allowed_ingress
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tim Yi <tim.yi@pica8.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

On 27/01/2022 09:49, Tim Yi wrote:
> When using per-vlan state, if vlan snooping and stats are disabled,
> untagged or priority-tagged ingress frame will go to check pvid state.
> If the port state is forwarding and the pvid state is not
> learning/forwarding, untagged or priority-tagged frame will be dropped
> but skb memory is not freed.
> Should free skb when __allowed_ingress returns false.
> 
> Signed-off-by: Tim Yi <tim.yi@pica8.com>
> ---
>  net/bridge/br_vlan.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
> index 84ba456a78cc..88c4297cddee 100644
> --- a/net/bridge/br_vlan.c
> +++ b/net/bridge/br_vlan.c
> @@ -560,10 +560,10 @@ static bool __allowed_ingress(const struct net_bridge *br,
>  		    !br_opt_get(br, BROPT_VLAN_STATS_ENABLED)) {
>  			if (*state == BR_STATE_FORWARDING) {
>  				*state = br_vlan_get_pvid_state(vg);
> -				return br_vlan_state_allowed(*state, true);
> -			} else {
> -				return true;
> +				if (!br_vlan_state_allowed(*state, true))
> +					goto drop;
>  			}
> +			return true;
>  		}
>  	}
>  	v = br_vlan_find(vg, *vid);



Good catch, also should go to stable, here's the appropriate fixes tag.

Fixes: a580c76d534c ("net: bridge: vlan: add per-vlan state")
Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>

Thanks,
 Nik
