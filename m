Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AC23D7D82
	for <bridge@lists.linux.dev>; Mon,  2 Mar 2026 13:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772456550; cv=none; b=Hk9SnQVU3cxL+g8Xoy+yY782r5jR1LVzo9ThB6Musj37o/4WnDaUi24f/pykGqP0eL89aSEBIXpqG/Uu71t2qDyTEFzjIb9YO+Jh5UgXOumwzoqyFI2JJpED5FxRDHk23nmVn5muRTCMb1xfAH6BgtVByFsrunSBlq+UNSfGmXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772456550; c=relaxed/simple;
	bh=vE/lYEZyUZyWrX7dEGM1mz947xLpTBkb/sXTqs/xZFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cN1GOzMABWEWij1EbbcfCK5RVoQKBAOp5n+DMAudRbLSQ7COY7DGvhJF6o4M96m0Bh5Ty6qO/CzJttI4ns53hZQLmCFmE4MceEQifrK0RATmmnWFUyhqVf4OmSZS0WzD2wGrvaE14jCsx7r6bWI+MP2gLLvdJDQteMaOsqcGc3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=jcddcOR2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="jcddcOR2"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-483770e0b25so38748915e9.0
        for <bridge@lists.linux.dev>; Mon, 02 Mar 2026 05:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1772456545; x=1773061345; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9/FjIYbH8rLK7M1wySsOhpB5kk1nqA9iYm40NdHpoF0=;
        b=jcddcOR2O+3j4152Ml0qe35TbyQHuCKLJpDBEEHN8KhjTo9sUZSKhpWS0yGjlgWAH3
         REp9L6Ay4Smflz2S7g1B1huXTOzimvvq1lBm6hIdO+kIzssgPO1RhEz3N9MligxT0KA8
         IVZXmI0XoDQKdoXwhM3EQeRisbFFY4BoijKc0KkReRlUzyBKdChwSNFr6Y6heIT9bCiV
         sv0nrWHOrubotMdO0qsbIcmLelia2QsU7jr+L9lRRwl21qSjyY7g/pkPRPNBH9tlFQ3I
         XWQq191vIG/tjUL4PlGhqoyQJfn7G1b+2c5rUK7uhxJ1SXmNrA75FyPxQz+39Z5rlzTf
         wdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772456545; x=1773061345;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9/FjIYbH8rLK7M1wySsOhpB5kk1nqA9iYm40NdHpoF0=;
        b=jUvKuiW5F1i2w7IAoCNROvN+ajH+ZgCUh1TpHEUJF0y4+VKehYSoeCwLuwdrvEUWvE
         VobjYo3RC42gMZEVwuJM06iw0yHyEyj19ZRxijJA1ag2NWCfuduCmEFKFaN4U0whtgIZ
         GfPK/zxFhDTb18lshkazyjO4/mEjf+l9Qz+RDkZVqpJbZT8Qz0HQ8Ag5gRCxvjU7TiL+
         2Ro5itVnyZwk2qfO2e5fIlylTXnXQjm8h6YhwsxQEDu5utBvXQpUQYVOGacfPx5oPvnQ
         Kzsw8kK5tH+in1TrYoY3YqMR6ixnYFnmt8wUxAFey+zStcb8/l0VtWuAZS2ezvgDPOEM
         8nyQ==
X-Gm-Message-State: AOJu0YxY46K2zleaF8fOXx6hrnUIp9/9CVII1aCNa6hNwAEBowbcsV19
	uSRAs7O71CwS9fJzXSh1HDLvDOmR65+c4r8hvErR7JjIBs0AEWplCmisShCZbY24TWc=
X-Gm-Gg: ATEYQzyhDQ9pzQMixtxhJAWsxlxPYbIzK9i7Pfea4c1PxPmfwOUCkMFzNg79jhi15Bz
	cGaWwZldQelYdHTrTVHTWCGogRRBszeGfa4eGuV5nBfsuGkkDa8dHQPfdnxqQmiwdMPVWbS/jnf
	dKWalsWkwvZnwoX2sP3q3+ke7PZXF5aQlZXV85Yd+20Bb7Fd2lkGulwFNso42Ct4jeLILBHBFoY
	DD+mNKDMPvI1ZCpl02yN+pTmCVYEMPMnc7lH1JczU7HXLYTXa6vLVOpvzLEaUD6OxN1w6TuM5Ep
	7my+Ed2ttQMi2eElhrXQkFIC5Ug94u9JFuTkSIY77WTwkrWo5TBkPVlZ2D+XXuZYpy2XEIm14o9
	FTXpu1UZTeNA/gG0XIIiXwg3jQnXYrhqWi1mqZ1q1azL9rnPAgpKLHoUhl1DZ8mh1DwEH2JOULW
	RLxwxpk8AYXiJTaqtvsVVCZ0HxTlzLSDs9D6K+/wYmjkxhZ2TYQbAZGBuvTw==
X-Received: by 2002:a05:600c:3542:b0:480:1e8f:d15f with SMTP id 5b1f17b1804b1-483c9bc5596mr224330125e9.2.1772456544273;
        Mon, 02 Mar 2026 05:02:24 -0800 (PST)
Received: from localhost (176.111.181.188.kyiv.nat.volia.net. [176.111.181.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b7713csm262504675e9.11.2026.03.02.05.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 05:02:23 -0800 (PST)
Date: Mon, 2 Mar 2026 15:02:22 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>, shuah@kernel.org
Subject: Re: [PATCH net-next v3 13/14] net: bridge: mcast: use combined
 active state in fast/data path
Message-ID: <aaWKXh24aEudngaV@penguin>
References: <20260302054008.21638-1-linus.luessing@c0d3.blue>
 <20260302054008.21638-14-linus.luessing@c0d3.blue>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260302054008.21638-14-linus.luessing@c0d3.blue>

On Mon, Mar 02, 2026 at 06:40:07AM +0100, Linus Lüssing wrote:
> As the multicast active state variable is now always up to date and
> functionally equivalent to our manual, extensive checks in fast path
> we can just use this state variable in fast path, too. This allows to
> save some CPU cycles for every multicast packet in the fast/data path.
> 
> Next to using brmctx->ip4_active / brmctx->ip6_active in fast path this
> mostly just moves some code around to not expose it via br_private.h
> anymore. While at it now also passing the ethernet protocol number
> directly, instead of a pointer into the ethernet header.
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> ---
>  net/bridge/br_device.c    |  3 ++-
>  net/bridge/br_input.c     |  3 ++-
>  net/bridge/br_multicast.c | 41 ++++++++++++++++++++++++++++++++++-----
>  net/bridge/br_private.h   | 38 ++++++++----------------------------
>  4 files changed, 48 insertions(+), 37 deletions(-)
> 
> diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
> index ee01122f466f..1ac363826b4c 100644
> --- a/net/bridge/br_device.c
> +++ b/net/bridge/br_device.c
> @@ -102,7 +102,8 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  		mdst = br_mdb_entry_skb_get(brmctx, skb, vid);
>  		if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
> -		    br_multicast_querier_exists(brmctx, eth_hdr(skb), mdst))
> +		    br_multicast_snooping_active(brmctx, eth_hdr(skb)->h_proto,
> +						 mdst))
>  			br_multicast_flood(mdst, skb, brmctx, false, true);
>  		else
>  			br_flood(br, skb, BR_PKT_MULTICAST, false, true, vid);
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index 1405f1061a54..e79963e3d05f 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -187,7 +187,8 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
>  	case BR_PKT_MULTICAST:
>  		mdst = br_mdb_entry_skb_get(brmctx, skb, vid);
>  		if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
> -		    br_multicast_querier_exists(brmctx, eth_hdr(skb), mdst)) {
> +		    br_multicast_snooping_active(brmctx, eth_hdr(skb)->h_proto,
> +						 mdst)) {
>  			if ((mdst && mdst->host_joined) ||
>  			    br_multicast_is_router(brmctx, skb) ||
>  			    br->dev->flags & IFF_ALLMULTI) {
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 715a0e0aa5ad..4a1005bb68f1 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1067,6 +1067,26 @@ static struct sk_buff *br_ip4_multicast_alloc_query(struct net_bridge_mcast *brm
>  	return skb;
>  }
>  
> +static bool
> +__br_multicast_querier_exists(struct net_bridge_mcast *brmctx,
> +			      struct bridge_mcast_other_query *querier,
> +			      bool is_ipv6)
> +{
> +	bool own_querier_enabled;
> +
> +	if (brmctx->multicast_querier) {
> +		if (is_ipv6 && !br_opt_get(brmctx->br, BROPT_HAS_IPV6_ADDR))
> +			own_querier_enabled = false;
> +		else
> +			own_querier_enabled = true;
> +	} else {
> +		own_querier_enabled = false;
> +	}
> +
> +	return !timer_pending(&querier->delay_timer) &&
> +	       (own_querier_enabled || timer_pending(&querier->timer));
> +}
> +
>  static bool br_ip4_multicast_querier_exists(struct net_bridge_mcast *brmctx)
>  {
>  	return __br_multicast_querier_exists(brmctx, &brmctx->ip4_other_query, false);
> @@ -1079,6 +1099,21 @@ static bool br_ip6_multicast_querier_exists(struct net_bridge_mcast *brmctx)
>  }
>  #endif
>  
> +static bool
> +br_multicast_querier_exists(struct net_bridge_mcast *brmctx, u16 proto)
> +{
> +	switch (proto) {
> +	case ETH_P_IP:
> +		return br_ip4_multicast_querier_exists(brmctx);
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case ETH_P_IPV6:
> +		return br_ip6_multicast_querier_exists(brmctx);
> +#endif
> +	default:
> +		return false;
> +	}
> +}
> +
>  static void br_ip4_multicast_update_active(struct net_bridge_mcast *brmctx,
>  					   bool force_inactive)
>  {
> @@ -5132,7 +5167,6 @@ bool br_multicast_has_querier_anywhere(struct net_device *dev, int proto)
>  {
>  	struct net_bridge *br;
>  	struct net_bridge_port *port;
> -	struct ethhdr eth;
>  	bool ret = false;
>  
>  	rcu_read_lock();
> @@ -5145,10 +5179,7 @@ bool br_multicast_has_querier_anywhere(struct net_device *dev, int proto)
>  
>  	br = port->br;
>  
> -	memset(&eth, 0, sizeof(eth));
> -	eth.h_proto = htons(proto);
> -
> -	ret = br_multicast_querier_exists(&br->multicast_ctx, &eth, NULL);
> +	ret = br_multicast_querier_exists(&br->multicast_ctx, proto);
>  
>  unlock:
>  	rcu_read_unlock();
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 8150ecc2c919..75684f8079f2 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -1159,37 +1159,15 @@ br_multicast_is_router(struct net_bridge_mcast *brmctx, struct sk_buff *skb)
>  }
>  
>  static inline bool
> -__br_multicast_querier_exists(struct net_bridge_mcast *brmctx,
> -			      struct bridge_mcast_other_query *querier,
> -			      const bool is_ipv6)
> +br_multicast_snooping_active(struct net_bridge_mcast *brmctx, __be16 eth_proto,

const brmctx

> +			     const struct net_bridge_mdb_entry *mdb)
>  {
> -	bool own_querier_enabled;
> -
> -	if (brmctx->multicast_querier) {
> -		if (is_ipv6 && !br_opt_get(brmctx->br, BROPT_HAS_IPV6_ADDR))
> -			own_querier_enabled = false;
> -		else
> -			own_querier_enabled = true;
> -	} else {
> -		own_querier_enabled = false;
> -	}
> -
> -	return !timer_pending(&querier->delay_timer) &&
> -	       (own_querier_enabled || timer_pending(&querier->timer));
> -}
> -
> -static inline bool br_multicast_querier_exists(struct net_bridge_mcast *brmctx,
> -					       struct ethhdr *eth,
> -					       const struct net_bridge_mdb_entry *mdb)
> -{
> -	switch (eth->h_proto) {
> +	switch (eth_proto) {
>  	case (htons(ETH_P_IP)):

since you're changing it, could you please remove the extra ()?
they're unnecessary and don't help readability

> -		return __br_multicast_querier_exists(brmctx,
> -			&brmctx->ip4_other_query, false);
> +		return READ_ONCE(brmctx->ip4_active);
>  #if IS_ENABLED(CONFIG_IPV6)
>  	case (htons(ETH_P_IPV6)):
> -		return __br_multicast_querier_exists(brmctx,
> -			&brmctx->ip6_other_query, true);
> +		return READ_ONCE(brmctx->ip6_active);
>  #endif
>  	default:
>  		return !!mdb && br_group_is_l2(&mdb->addr);
> @@ -1448,9 +1426,9 @@ static inline bool br_multicast_is_router(struct net_bridge_mcast *brmctx,
>  	return false;
>  }
>  
> -static inline bool br_multicast_querier_exists(struct net_bridge_mcast *brmctx,
> -					       struct ethhdr *eth,
> -					       const struct net_bridge_mdb_entry *mdb)
> +static inline bool
> +br_multicast_snooping_active(struct net_bridge_mcast *brmctx, __be16 eth_proto,
> +			     const struct net_bridge_mdb_entry *mdb)
>  {
>  	return false;
>  }
> -- 
> 2.51.0
> 
