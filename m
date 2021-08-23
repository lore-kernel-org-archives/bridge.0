Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhkY4sxH7BnSdsblCHD6C4HSfFyBBXfDAZzZU5UipAI=;
 b=bGVS3uxCcZIY5z8IlVscb7wYaQz/qmJWHY3gLk1jRspr5XFj+HNsZhprMBeQbFlzUpp+Qqevq8O0HLfMT6wVRTU6NSnivYFLaFZnFeVlVPxlghfdFNsNQQVxh2UXjh8FuH5lgyhzSJg3vhShQP3mTZJ9kAbK4IJrMw6bMHSZp0d/Nq4hWCLwoUt7qraODDTGw/gLYtM+qnyuwQnvWCuMQ87BBmU5pFUyca8BRq+9uFWfcPNyv6TUw6MUIRdktt3weebbbCylj0AXuuPx0A0NMHk0AzUau6eYS7Wy+1mhp7tnsOMF1+gNzjPZ54IZbEm1PosXXDNfWQnm0osEz9J22w==
References: <20210823061938.28240-1-l4stpr0gr4m@gmail.com>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <13c1df91-be22-f4e0-cd61-7c99eb4e45f4@nvidia.com>
Date: Mon, 23 Aug 2021 12:00:25 +0300
In-Reply-To: <20210823061938.28240-1-l4stpr0gr4m@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next] net: bridge: replace
 __vlan_hwaccel_put_tag with skb_vlan_push
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

On 23/08/2021 09:19, Kangmin Park wrote:
> br_handle_ingress_vlan_tunnel() is called in br_handle_frame() and
> goto drop when br_handle_ingress_vlan_tunnel() return non-zero.
> 
> But, br_handle_ingress_vlan_tunnel() always return 0. So, the goto
> routine is currently meaningless.
> 
> However, paired function br_handle_egress_vlan_tunnel() call
> skb_vlan_pop(). So, change br_handle_ingress_vlan_tunnel() to call
> skb_vlan_push() instead of __vlan_hwaccel_put_tag(). And return
> the return value of skb_vlan_push().
> 
> Signed-off-by: Kangmin Park <l4stpr0gr4m@gmail.com>
> ---
>  net/bridge/br_vlan_tunnel.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/net/bridge/br_vlan_tunnel.c b/net/bridge/br_vlan_tunnel.c
> index 01017448ebde..7b5a33dc9d4d 100644
> --- a/net/bridge/br_vlan_tunnel.c
> +++ b/net/bridge/br_vlan_tunnel.c
> @@ -179,9 +179,7 @@ int br_handle_ingress_vlan_tunnel(struct sk_buff *skb,
>  
>  	skb_dst_drop(skb);
>  
> -	__vlan_hwaccel_put_tag(skb, p->br->vlan_proto, vlan->vid);
> -
> -	return 0;
> +	return skb_vlan_push(skb, p->br->vlan_proto, vlan->vid);
>  }
>  
>  int br_handle_egress_vlan_tunnel(struct sk_buff *skb,
> 

This changes behaviour though, I don't like changing code just for the sake of it.
Perhaps the author had a reason to use hwaccel_put_tag instead. Before we would
just put hwaccel tag, now if there already is hwaccel tag we'll push it inside
the skb and then push the new tag in hwaccel. In fact I think you can even trigger
the warning inside skb_vlan_push, so:

Nacked-by: Nikolay Aleksandrov <nikolay@nvidia.com>


