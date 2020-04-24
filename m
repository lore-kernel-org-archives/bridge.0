Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=9BcUMuWu+VNLqROvvMiYmkUjwNZj8mEI6zOXCjGTZxo=;
 b=PWNcKVYqHTwiMFgcLh7n20tJrrsK/zpNBWaw3Rp0qZdPq2BLfukmh0GIkMVeAuctcY
 Xf9shxjyJXpfiY73Myty+VBxZpg1XpMip0sdhaHc2N+y+1gc7bW53Ua8/P0TFX3RAoAn
 /c6jPNWF57LlMgvDF93pNokpLg5oR44Nsw8eY=
References: <20200422161833.1123-1-horatiu.vultur@microchip.com>
 <20200422161833.1123-4-horatiu.vultur@microchip.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <620390de-6f5a-d3a8-e48c-42089355eefa@cumulusnetworks.com>
Date: Fri, 24 Apr 2020 16:11:58 +0300
MIME-Version: 1.0
In-Reply-To: <20200422161833.1123-4-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3 03/11] bridge: mrp: Extend bridge
	interface
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>, davem@davemloft.net, jiri@resnulli.us, ivecera@redhat.com, kuba@kernel.org, roopa@cumulusnetworks.com, olteanv@gmail.com, andrew@lunn.ch, UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org

On 22/04/2020 19:18, Horatiu Vultur wrote:
> To integrate MRP into the bridge, first the bridge needs to be aware of ports
> that are part of an MRP ring and which rings are on the bridge.
> Therefore extend bridge interface with the following:
> - add new flag(BR_MPP_AWARE) to the net bridge ports, this bit will be
>   set when the port is added to an MRP instance. In this way it knows if
>   the frame was received on MRP ring port
> - add new flag(BR_MRP_LOST_CONT) to the net bridge ports, this bit will be set
>   when the port lost the continuity of MRP Test frames.
> - add a list of MRP instances
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  include/linux/if_bridge.h | 2 ++
>  net/bridge/br_private.h   | 4 ++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
> index 9e57c4411734..b3a8d3054af0 100644
> --- a/include/linux/if_bridge.h
> +++ b/include/linux/if_bridge.h
> @@ -47,6 +47,8 @@ struct br_ip_list {
>  #define BR_BCAST_FLOOD		BIT(14)
>  #define BR_NEIGH_SUPPRESS	BIT(15)
>  #define BR_ISOLATED		BIT(16)
> +#define BR_MRP_AWARE		BIT(17)
> +#define BR_MRP_LOST_CONT	BIT(18)
>  
>  #define BR_DEFAULT_AGEING_TIME	(300 * HZ)
>  
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 1f97703a52ff..835a70f8d3ea 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -428,6 +428,10 @@ struct net_bridge {
>  	int offload_fwd_mark;
>  #endif
>  	struct hlist_head		fdb_list;
> +
> +#if IS_ENABLED(CONFIG_BRIDGE_MRP)
> +	struct list_head		__rcu mrp_list;
> +#endif
>  };
>  
>  struct br_input_skb_cb {
> 

Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

