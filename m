Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=6G/27z
 xuGvxwdfFNgVyByoy1R/9INnm6KuI/THNxp7Q=; b=sDgXzjQif6CKetgCO5COh3
 z/wGfU4m+oKFU0FEG9VzYb5OxJb0xDvUIVJnr14mnTRap9HOivHT3XBsU7+T6olj
 OyvgiY3pvgF1Unsx517MssWAQq5NlAxV5w3esUKvqam58dVtOR1nokIRATFuFz72
 UDNKPJEVD0d1vtq0hNX5mMWoXWt8+hAH8NBE8/+PktMotKQ6HhCQQpCn0/T/e+lZ
 HK0tnCywCTT/2IdynPzzpzF8egM2F9jMXkVCubuPbfdiZRegcAO+kLgYGBpIvkb0
 NAi15VOXO8qKFFcyYBelz7tbdrzX5a7DY8wOg+L/qaqMtk74PRSetImlMQp9jU8A
 ==
Date: Sun, 2 May 2021 18:00:33 +0300
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <YI6+kQxjCcnYmwkx@shredder>
References: <20210426170411.1789186-1-tobias@waldekranz.com>
 <20210426170411.1789186-3-tobias@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426170411.1789186-3-tobias@waldekranz.com>
Subject: Re: [Bridge] [RFC net-next 2/9] net: bridge: Disambiguate
	offload_fwd_mark
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, jiri@resnulli.us, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, vivien.didelot@gmail.com, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, olteanv@gmail.com, davem@davemloft.net

On Mon, Apr 26, 2021 at 07:04:04PM +0200, Tobias Waldekranz wrote:
> - skb->cb->offload_fwd_mark becomes skb->cb->src_hwdom. There is a
>   slight change here: Whereas previously this was only set for
>   offloaded packets, we now always track the incoming hwdom. As all
>   uses where already gated behind checks of skb->offload_fwd_mark,
>   this will not introduce any functional change, but it paves the way
>   for future changes where the ingressing hwdom must be known both for
>   offloaded and non-offloaded frames.

[...]

> @@ -43,15 +43,15 @@ int nbp_switchdev_mark_set(struct net_bridge_port *p)
>  void nbp_switchdev_frame_mark(const struct net_bridge_port *p,
>  			      struct sk_buff *skb)
>  {
> -	if (skb->offload_fwd_mark && !WARN_ON_ONCE(!p->offload_fwd_mark))
> -		BR_INPUT_SKB_CB(skb)->offload_fwd_mark = p->offload_fwd_mark;
> +	if (p->hwdom)
> +		BR_INPUT_SKB_CB(skb)->src_hwdom = p->hwdom;
>  }

I assume you are referring to this change? "src_hwdom" sounds weird if
it's expected to be valid for non-offloaded frames.

Can you elaborate about "future changes where the ingressing hwdom must
be known both for offloaded and non-offloaded frames"?

Probably best to split this change to a different patch given the rest
of the changes are mechanical.

>  
>  bool nbp_switchdev_allowed_egress(const struct net_bridge_port *p,
>  				  const struct sk_buff *skb)
>  {
>  	return !skb->offload_fwd_mark ||
> -	       BR_INPUT_SKB_CB(skb)->offload_fwd_mark != p->offload_fwd_mark;
> +	       BR_INPUT_SKB_CB(skb)->src_hwdom != p->hwdom;
>  }
>  
>  /* Flags that can be offloaded to hardware */
> -- 
> 2.25.1
> 
