Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504EE20F5A2
	for <bridge@lists.linux.dev>; Wed, 16 Oct 2024 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729094250; cv=none; b=CATIZK/v82PItLhUPPWa+VcIeNsKrX2+qSpagkwJSo7XwXebISucur0DV8K5Iafd4WtfVOpPEKMUqvBYVnJbdPbVFxIPH3sEvoFSNbPDDFf3YVTaTrXa4TMJ8Iq3WvLj05ORnv9/O5Na6l7N9bYrKs+IZezE+uaXXIkGtF9are8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729094250; c=relaxed/simple;
	bh=pQJUycqCCqc9+T8ZvQB9kGSTugUUqfL//ag9Iyd0umo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=McBYqubumwS1+AGgRZWz8l6tCtQMlBjSeVNRP18oc2q9+Se3U2WbH3WUvpRfsM4pUcwa6/dOvPMe2SUjTCW2o5TVukW00m734q3DL9z+j37TJK/XP4wIfFfMR8KDbI9RosdLccAX1HX/+AOSoU+hSi1Y5UKu43+Tw/jyPPvcq+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWEw868f; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWEw868f"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539ebb5a20aso4528678e87.2
        for <bridge@lists.linux.dev>; Wed, 16 Oct 2024 08:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729094246; x=1729699046; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VxA07k9oSO8dTce0PP8TNRQBmoWhoKL9GFOP9Oqykdw=;
        b=BWEw868fnWRSYMyCSCPJTbSsSmAXWCwN11coS5ORiOAjU1VgT0rBbIZ2ebs93a2a51
         /K5BfjOFIDYttu+Hy9IET4KpMzWsKGKtbwxS545qo8WlpE7bSNb0Z4U/R9E6rp8z73Af
         AaZLaB53UTIuWRgup3FRs/nB8wPgwKBU/GXe2P0TjjnJBnLHVcvZkhlltqqd4SB9vQjR
         qPJdJ8sQijILJwdezrPKCODL5VztLWgiv32KsR+O2nSNSlNFa+TB87KvK/TZDDyRel1h
         A4kI/f/EWnV9Em4g5lbLaZxcMwk1cOXhLZjiRDKDKrxh7Mq2hV+Fag8pCzjdf8JfvVoM
         5yXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729094246; x=1729699046;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VxA07k9oSO8dTce0PP8TNRQBmoWhoKL9GFOP9Oqykdw=;
        b=mP1OWyiCHizW2AHIgHU6wM5NGxnFrGAmvnSmFGEv1bmtMcy4GTR2jTkwDetZ/r6sdW
         P+iAJpGTfjMjr9aI265hlm1hDhYruvqxMQSlXUSkA8aP0KMTQR6YLujyEWtKJTO2vKH5
         kDScBnlIwnOntZzyfEGvSxiC8hE8hBZUuyg5MKR1N9QMLe3oupA0DYaH8MlV8J4LFxOY
         pFPddrGTkj3ZKHOgN4/caHZjOWo9HXNFY2tI4MDwAYv9JhNGNct3r1rsed18I9wxBulg
         4MsnCeAhNaVxe5y913+oQVEDbsdtUNkLNC6MQPVKhRsxThcNaAt5UapMrBJxQMpFpMXf
         0KZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJQ+HVlfZhBIrvXlZMhrTsINuGKMAyEh5PM59lg6uBU/5CJqyylOxq7MpCd5HFmPX6VlVCUUA=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6CrecrkZuYTVOP6ZwcwC/VVP9Q3uy/VWA2sIv3uztshYizulX
	xFbIqBHvezR2EPoK27/8fQWLeL7hjOTbtHYDFg3HPPlzf7eogQ/3
X-Google-Smtp-Source: AGHT+IEi/7qYhNCOFZfgn/p4Iqu9Z2zyKn6pf3/u84hhnrnCvkNEdqd/86Jf01yV6NLUAKDt1wtaMg==
X-Received: by 2002:a05:6512:e9d:b0:535:6aa9:9855 with SMTP id 2adb3069b0e04-539e54051famr8422705e87.0.1729094246042;
        Wed, 16 Oct 2024 08:57:26 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a2988c56csm197630466b.209.2024.10.16.08.57.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 08:57:25 -0700 (PDT)
Message-ID: <77aba461-2d32-4c4d-8877-c16f656a0610@gmail.com>
Date: Wed, 16 Oct 2024 17:57:23 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 net-next 06/12] net: core: dev: Add
 dev_fill_bridge_path()
To: Nikolay Aleksandrov <razor@blackwall.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Roopa Prabhu <roopa@nvidia.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 bridge@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241013185509.4430-1-ericwouds@gmail.com>
 <20241013185509.4430-7-ericwouds@gmail.com>
 <c3678626-7f5c-4446-9b4d-2650ddf5d5a6@blackwall.org>
 <a0db4efa-2328-4935-9eb6-3344fcbc4b07@gmail.com>
 <ea4de936-9a84-4910-960b-65c5cc2dfcdd@blackwall.org>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <ea4de936-9a84-4910-960b-65c5cc2dfcdd@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/16/24 9:43 AM, Nikolay Aleksandrov wrote:
> On 14/10/2024 21:34, Eric Woudstra wrote:
>>
>>
>> On 10/14/24 8:59 AM, Nikolay Aleksandrov wrote:
>>> On 13/10/2024 21:55, Eric Woudstra wrote:
>>>> New function dev_fill_bridge_path(), similar to dev_fill_forward_path().
>>>> It handles starting from a bridge port instead of the bridge master.
>>>> The structures ctx and nft_forward_info need to be already filled in with
>>>> the (vlan) encaps.
>>>>
>>>> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
>>>> ---
>>>>  include/linux/netdevice.h |  2 +
>>>>  net/core/dev.c            | 77 ++++++++++++++++++++++++++++++++-------
>>>>  2 files changed, 66 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>>>> index e87b5e488325..9d80f650345e 100644
>>>> --- a/include/linux/netdevice.h
>>>> +++ b/include/linux/netdevice.h
>>>> @@ -3069,6 +3069,8 @@ void dev_remove_offload(struct packet_offload *po);
>>>>  
>>>>  int dev_get_iflink(const struct net_device *dev);
>>>>  int dev_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb);
>>>> +int dev_fill_bridge_path(struct net_device_path_ctx *ctx,
>>>> +			 struct net_device_path_stack *stack);
>>>>  int dev_fill_forward_path(const struct net_device *dev, const u8 *daddr,
>>>>  			  struct net_device_path_stack *stack);
>>>>  struct net_device *__dev_get_by_flags(struct net *net, unsigned short flags,
>>>> diff --git a/net/core/dev.c b/net/core/dev.c
>>>> index cd479f5f22f6..49959c4904fc 100644
>>>> --- a/net/core/dev.c
>>>> +++ b/net/core/dev.c
>>>> @@ -713,44 +713,95 @@ static struct net_device_path *dev_fwd_path(struct net_device_path_stack *stack)
>>>>  	return &stack->path[k];
>>>>  }
>>>>  
>>>> -int dev_fill_forward_path(const struct net_device *dev, const u8 *daddr,
>>>> -			  struct net_device_path_stack *stack)
>>>> +static int dev_fill_forward_path_common(struct net_device_path_ctx *ctx,
>>>> +					struct net_device_path_stack *stack)
>>>>  {
>>>>  	const struct net_device *last_dev;
>>>> -	struct net_device_path_ctx ctx = {
>>>> -		.dev	= dev,
>>>> -	};
>>>>  	struct net_device_path *path;
>>>>  	int ret = 0;
>>>>  
>>>> -	memcpy(ctx.daddr, daddr, sizeof(ctx.daddr));
>>>> -	stack->num_paths = 0;
>>>> -	while (ctx.dev && ctx.dev->netdev_ops->ndo_fill_forward_path) {
>>>> -		last_dev = ctx.dev;
>>>> +	while (ctx->dev && ctx->dev->netdev_ops->ndo_fill_forward_path) {
>>>> +		last_dev = ctx->dev;
>>>>  		path = dev_fwd_path(stack);
>>>>  		if (!path)
>>>>  			return -1;
>>>>  
>>>>  		memset(path, 0, sizeof(struct net_device_path));
>>>> -		ret = ctx.dev->netdev_ops->ndo_fill_forward_path(&ctx, path);
>>>> +		ret = ctx->dev->netdev_ops->ndo_fill_forward_path(ctx, path);
>>>>  		if (ret < 0)
>>>>  			return -1;
>>>>  
>>>> -		if (WARN_ON_ONCE(last_dev == ctx.dev))
>>>> +		if (WARN_ON_ONCE(last_dev == ctx->dev))
>>>>  			return -1;
>>>>  	}
>>>>  
>>>> -	if (!ctx.dev)
>>>> +	if (!ctx->dev)
>>>>  		return ret;
>>>>  
>>>>  	path = dev_fwd_path(stack);
>>>>  	if (!path)
>>>>  		return -1;
>>>>  	path->type = DEV_PATH_ETHERNET;
>>>> -	path->dev = ctx.dev;
>>>> +	path->dev = ctx->dev;
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +int dev_fill_bridge_path(struct net_device_path_ctx *ctx,
>>>> +			 struct net_device_path_stack *stack)
>>>> +{
>>>> +	const struct net_device *last_dev, *br_dev;
>>>> +	struct net_device_path *path;
>>>> +	int ret = 0;
>>>> +
>>>> +	stack->num_paths = 0;
>>>> +
>>>> +	if (!ctx->dev || !netif_is_bridge_port(ctx->dev))
>>>> +		return -1;
>>>> +
>>>> +	br_dev = netdev_master_upper_dev_get_rcu((struct net_device *)ctx->dev);
>>>> +	if (!br_dev || !br_dev->netdev_ops->ndo_fill_forward_path)
>>>> +		return -1;
>>>> +
>>>> +	last_dev = ctx->dev;
>>>> +	path = dev_fwd_path(stack);
>>>> +	if (!path)
>>>> +		return -1;
>>>> +
>>>> +	memset(path, 0, sizeof(struct net_device_path));
>>>> +	ret = br_dev->netdev_ops->ndo_fill_forward_path(ctx, path);
>>>> +	if (ret < 0)
>>>> +		return -1;
>>>> +
>>>> +	if (!ctx->dev || WARN_ON_ONCE(last_dev == ctx->dev))
>>>> +		return -1;
> 
> * ^^^^^^^^^ here
> 
>>>> +
>>>> +	if (!netif_is_bridge_master(ctx->dev))
>>>
>>> hmm, do we expect ctx->dev to be a bridge master? Looking at
>>> br_fill_forward_path, it seems to be == fdb->dst->dev which
>>> should be the target port
>>
>> It would indeed be very unlikely. It was a left-over from code I wrote,
>> thinking that here I could handle cascaded bridges (via vlan-device). I
>> dropped that, since conntrack does not follow this flow.
>>
>> So would it be better to only make sure that ctx->dev is not a bridge
>> master?
>>
>> 	if (netif_is_bridge_master(ctx->dev))
>> 		return -1;
>>
>> 	return dev_fill_forward_path_common(ctx, stack);
>>
> 
> I think you misunderstood me, I don't think ctx->dev can ever be a bridge
> device because ctx->dev gets set to fdb->dst and fdbs that point to the bridge
> itself have fdb->dst == NULL but ctx->dev is checked against NULL earlier*
> so the bridge dev check doesn't make sense to me.

I see, thanks. I'll drop the check in v2.

>>>> +		return dev_fill_forward_path_common(ctx, stack);
>>>> +
>>>> +	path = dev_fwd_path(stack);
>>>> +	if (!path)
>>>> +		return -1;
>>>> +	path->type = DEV_PATH_ETHERNET;
>>>> +	path->dev = ctx->dev;
>>>>  
>>>>  	return ret;
>>>>  }
>>>> +EXPORT_SYMBOL_GPL(dev_fill_bridge_path);
>>>> +
>>>> +int dev_fill_forward_path(const struct net_device *dev, const u8 *daddr,
>>>> +			  struct net_device_path_stack *stack)
>>>> +{
>>>> +	struct net_device_path_ctx ctx = {
>>>> +		.dev	= dev,
>>>> +	};
>>>> +
>>>> +	memcpy(ctx.daddr, daddr, sizeof(ctx.daddr));
>>>> +
>>>> +	stack->num_paths = 0;
>>>> +
>>>> +	return dev_fill_forward_path_common(&ctx, stack);
>>>> +}
>>>>  EXPORT_SYMBOL_GPL(dev_fill_forward_path);
>>>>  
>>>>  /**
>>>
> 
