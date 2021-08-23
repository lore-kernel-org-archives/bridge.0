Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZx1KcCIKqQAlRdNQ1/QgDdRGixQy54Tpue5wopCAGY=;
 b=tICiiC8c7SODty6ZnLfqseYng5Ou785wgAQEaOVNw3TXR/+BssKSgGEiJX0Iu8acj5VDGhEZbfh3q7GzgFqbJhEerx7Mkb8vw9LdAy4MQYPaN7t/Oky+jL3rsJvWPHkrnqvKxiIgIej3Hkd+Y1hciHRzHbUzIxaqvLX0ASqGQpF4bAq+fGTO75Gfo91Mu5yutwQan6qJGDCGiBRJWIwkPSfKGCZ3KP05KfQ/BQ0zcR8PnD5iaxtzZDSDJHRtR+qK9Es6IQj1ePIHGhu0/IR0pYNExG/6R03+65VTHRE17tw0024XWSfcBne10ZETEvy87cOWV87ytEoKrrGuxrPNlw==
References: <20210823095634.34752-1-l4stpr0gr4m@gmail.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <d7931059-4841-a39f-4272-0053d6b61bac@nvidia.com>
Date: Mon, 23 Aug 2021 13:00:42 +0300
In-Reply-To: <20210823095634.34752-1-l4stpr0gr4m@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v2 net-next] net: bridge: change return type of
 br_handle_ingress_vlan_tunnel
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Kangmin Park <l4stpr0gr4m@gmail.com>, Roopa Prabhu <roopa@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org

On 23/08/2021 12:56, Kangmin Park wrote:
> br_handle_ingress_vlan_tunnel() is only referenced in
> br_handle_frame(). If br_handle_ingress_vlan_tunnel() is called and
> return non-zero value, goto drop in br_handle_frame().
> 
> But, br_handle_ingress_vlan_tunnel() always return 0. So, the
> routines that check the return value and goto drop has no meaning.
> 
> Therefore, change return type of br_handle_ingress_vlan_tunnel() to
> void and remove if statement of br_handle_frame().
> 
> Signed-off-by: Kangmin Park <l4stpr0gr4m@gmail.com>
> ---
> v2:
>  - cleanup instead of modifying ingress function
>  - change prototype of ingress function
>  - cleanup br_handle_frame function
>  - change commit message accordingly
> 
>  net/bridge/br_input.c          |  7 ++-----
>  net/bridge/br_private_tunnel.h |  6 +++---
>  net/bridge/br_vlan_tunnel.c    | 14 +++++++-------
>  3 files changed, 12 insertions(+), 15 deletions(-)
> 
[snip]
> diff --git a/net/bridge/br_vlan_tunnel.c b/net/bridge/br_vlan_tunnel.c
> index 01017448ebde..7d42b2a5be80 100644
> --- a/net/bridge/br_vlan_tunnel.c
> +++ b/net/bridge/br_vlan_tunnel.c
> @@ -158,30 +158,30 @@ void vlan_tunnel_deinit(struct net_bridge_vlan_group *vg)
>  	rhashtable_destroy(&vg->tunnel_hash);
>  }
>  
> -int br_handle_ingress_vlan_tunnel(struct sk_buff *skb,
> -				  struct net_bridge_port *p,
> -				  struct net_bridge_vlan_group *vg)
> +void br_handle_ingress_vlan_tunnel(struct sk_buff *skb,
> +				   struct net_bridge_port *p,
> +				   struct net_bridge_vlan_group *vg)
>  {
>  	struct ip_tunnel_info *tinfo = skb_tunnel_info(skb);
>  	struct net_bridge_vlan *vlan;
>  
>  	if (!vg || !tinfo)
> -		return 0;
> +		return;
>  
>  	/* if already tagged, ignore */
>  	if (skb_vlan_tagged(skb))
> -		return 0;
> +		return;
>  
>  	/* lookup vid, given tunnel id */
>  	vlan = br_vlan_tunnel_lookup(&vg->tunnel_hash, tinfo->key.tun_id);
>  	if (!vlan)
> -		return 0;
> +		return;
>  
>  	skb_dst_drop(skb);
>  
>  	__vlan_hwaccel_put_tag(skb, p->br->vlan_proto, vlan->vid);
>  
> -	return 0;
> +	return;

Please drop this unnecessary return statement at the end of the void function.

>  }
>  
>  int br_handle_egress_vlan_tunnel(struct sk_buff *skb,
> 

