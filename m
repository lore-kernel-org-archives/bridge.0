Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7341A1C07EA
	for <bridge@lists.linux.dev>; Wed, 16 Oct 2024 07:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729064626; cv=none; b=LfdY4ZpaCfZqKnCkOL273b6caNHVFg7ZSDcsKfbUXHROxaLUAVvdPkqFzzZonil5Lp8tAlP7jWuIOULtCABNftrATb4AG0Yxgi4kTXWSp1qIGRb73WG1rxa+UJyTtoKxLP7zLUK6pji4hpJnDmT1avl2iyb3X9Ya9vOCePs/CBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729064626; c=relaxed/simple;
	bh=p5ZxYhx8ZIeKOuvBg5VMhkMlNdup+Y7U0n6qru+fU0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pSgYHFPOHvceaYwhGHq4qlWXHhe4wbOt9kyfkw/UVnVoyXFaR1+k/6TVEtzyGGRQRqKiFfvv1CBWW2jU64b43cp/rmLBUr3l7aJWOXsxL75jRdKSVD4RkKRsolHMesCQEHO5hz+N7CaWJcUxnTTZbT9M9kHbjO+MBnp96dIM0Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=XhwA4elU; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="XhwA4elU"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a99f629a7aaso110029866b.1
        for <bridge@lists.linux.dev>; Wed, 16 Oct 2024 00:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1729064623; x=1729669423; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EOMYLzkxXlztr2X9JVmFvqxwZU+iOw3BliPLuajBLvI=;
        b=XhwA4elUhkQiy6/tNk/1UEolSXwqicYQ0LlaxQnpnRgfCZ+juTQ1Upf7zxGfjvSMtU
         76+H3i4U6EtagazsXeKWV+VsYeKQwRcqr4kNiau7zMINpUSY1vLRqDcVbmz5+Lm0LaCL
         j5W+wCMwWuPUaEIPpKzp1D2l5p3mW8TY6dPnzSd5IcQoBXi4/wQ7KkqNhlZz0GZ7FnFY
         mIb0dFeUpfWRC+nruqZV7Cc7RoXvIpoxR7UwvVRDxVowwNt44QauLB3h2fH3STYwpeoI
         gm07Wudd3yrUzwnF/r8yV5FE848fngPD+orH191DPQnB9/F0BkMllbVtlQOSeDpkG3oM
         SyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729064623; x=1729669423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EOMYLzkxXlztr2X9JVmFvqxwZU+iOw3BliPLuajBLvI=;
        b=QhoTtkAwvkeT0xy6325f1B3DYhT1r6IRF4e+7GCy3GMVyU4ihJtzLCiR+URkOTYPlU
         AQp1Uq3b6MbbV/bQUOHUgejyOBHvzRZ0vGwMkQjysqPg2uWmlTRAhZWCjLycvDVgxI5P
         oXguyE6kMzBF8k7fA2z0m2BXpXpyEqxk1TChRUqbBQXF4ORZpSshdc6KFKGuJJifmjYR
         JW2uF5LvuLJWtaf02UopwvEkA5NDhIa4DQonlAXZVVHzeTCXwKeYBjykUWzj1AO8bAsm
         EM46ahgEEYZ39XDbVvV6Mp/yZfcGhC74nOWhC6F+/M/8PXZMylI86x2wtzQJ4qifinmo
         oHLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8UOoEMlOVSwKW08FLnTNEu+4kpg7tMupB5PfI4DWXIRH39Q7TZmcg29zxF4ZhaqNFhRj8u5U=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywgju64BhyG6XdxYpzQq0J3djMRc5a4d171brx5SEONg0l1M95c
	qBE+WBmddl6PRfwYvVRQ7JgeXLgIlAIdGaQS3rboiWK5TipvQ3gIxtX5Ame6E8I=
X-Google-Smtp-Source: AGHT+IHtkc3sEYisRvH1Z62l5rcBJzJB6v43M6C+fulzoVqkC6uCMW4XNujhBsdtaO8gPsiHnusJdA==
X-Received: by 2002:a17:907:9706:b0:a99:facf:cfc with SMTP id a640c23a62f3a-a99facf0e10mr1044501566b.17.1729064622648;
        Wed, 16 Oct 2024 00:43:42 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a2973fba2sm149241266b.47.2024.10.16.00.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 00:43:42 -0700 (PDT)
Message-ID: <ea4de936-9a84-4910-960b-65c5cc2dfcdd@blackwall.org>
Date: Wed, 16 Oct 2024 10:43:40 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 net-next 06/12] net: core: dev: Add
 dev_fill_bridge_path()
To: Eric Woudstra <ericwouds@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
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
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <a0db4efa-2328-4935-9eb6-3344fcbc4b07@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/10/2024 21:34, Eric Woudstra wrote:
> 
> 
> On 10/14/24 8:59 AM, Nikolay Aleksandrov wrote:
>> On 13/10/2024 21:55, Eric Woudstra wrote:
>>> New function dev_fill_bridge_path(), similar to dev_fill_forward_path().
>>> It handles starting from a bridge port instead of the bridge master.
>>> The structures ctx and nft_forward_info need to be already filled in with
>>> the (vlan) encaps.
>>>
>>> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
>>> ---
>>>  include/linux/netdevice.h |  2 +
>>>  net/core/dev.c            | 77 ++++++++++++++++++++++++++++++++-------
>>>  2 files changed, 66 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>>> index e87b5e488325..9d80f650345e 100644
>>> --- a/include/linux/netdevice.h
>>> +++ b/include/linux/netdevice.h
>>> @@ -3069,6 +3069,8 @@ void dev_remove_offload(struct packet_offload *po);
>>>  
>>>  int dev_get_iflink(const struct net_device *dev);
>>>  int dev_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb);
>>> +int dev_fill_bridge_path(struct net_device_path_ctx *ctx,
>>> +			 struct net_device_path_stack *stack);
>>>  int dev_fill_forward_path(const struct net_device *dev, const u8 *daddr,
>>>  			  struct net_device_path_stack *stack);
>>>  struct net_device *__dev_get_by_flags(struct net *net, unsigned short flags,
>>> diff --git a/net/core/dev.c b/net/core/dev.c
>>> index cd479f5f22f6..49959c4904fc 100644
>>> --- a/net/core/dev.c
>>> +++ b/net/core/dev.c
>>> @@ -713,44 +713,95 @@ static struct net_device_path *dev_fwd_path(struct net_device_path_stack *stack)
>>>  	return &stack->path[k];
>>>  }
>>>  
>>> -int dev_fill_forward_path(const struct net_device *dev, const u8 *daddr,
>>> -			  struct net_device_path_stack *stack)
>>> +static int dev_fill_forward_path_common(struct net_device_path_ctx *ctx,
>>> +					struct net_device_path_stack *stack)
>>>  {
>>>  	const struct net_device *last_dev;
>>> -	struct net_device_path_ctx ctx = {
>>> -		.dev	= dev,
>>> -	};
>>>  	struct net_device_path *path;
>>>  	int ret = 0;
>>>  
>>> -	memcpy(ctx.daddr, daddr, sizeof(ctx.daddr));
>>> -	stack->num_paths = 0;
>>> -	while (ctx.dev && ctx.dev->netdev_ops->ndo_fill_forward_path) {
>>> -		last_dev = ctx.dev;
>>> +	while (ctx->dev && ctx->dev->netdev_ops->ndo_fill_forward_path) {
>>> +		last_dev = ctx->dev;
>>>  		path = dev_fwd_path(stack);
>>>  		if (!path)
>>>  			return -1;
>>>  
>>>  		memset(path, 0, sizeof(struct net_device_path));
>>> -		ret = ctx.dev->netdev_ops->ndo_fill_forward_path(&ctx, path);
>>> +		ret = ctx->dev->netdev_ops->ndo_fill_forward_path(ctx, path);
>>>  		if (ret < 0)
>>>  			return -1;
>>>  
>>> -		if (WARN_ON_ONCE(last_dev == ctx.dev))
>>> +		if (WARN_ON_ONCE(last_dev == ctx->dev))
>>>  			return -1;
>>>  	}
>>>  
>>> -	if (!ctx.dev)
>>> +	if (!ctx->dev)
>>>  		return ret;
>>>  
>>>  	path = dev_fwd_path(stack);
>>>  	if (!path)
>>>  		return -1;
>>>  	path->type = DEV_PATH_ETHERNET;
>>> -	path->dev = ctx.dev;
>>> +	path->dev = ctx->dev;
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +int dev_fill_bridge_path(struct net_device_path_ctx *ctx,
>>> +			 struct net_device_path_stack *stack)
>>> +{
>>> +	const struct net_device *last_dev, *br_dev;
>>> +	struct net_device_path *path;
>>> +	int ret = 0;
>>> +
>>> +	stack->num_paths = 0;
>>> +
>>> +	if (!ctx->dev || !netif_is_bridge_port(ctx->dev))
>>> +		return -1;
>>> +
>>> +	br_dev = netdev_master_upper_dev_get_rcu((struct net_device *)ctx->dev);
>>> +	if (!br_dev || !br_dev->netdev_ops->ndo_fill_forward_path)
>>> +		return -1;
>>> +
>>> +	last_dev = ctx->dev;
>>> +	path = dev_fwd_path(stack);
>>> +	if (!path)
>>> +		return -1;
>>> +
>>> +	memset(path, 0, sizeof(struct net_device_path));
>>> +	ret = br_dev->netdev_ops->ndo_fill_forward_path(ctx, path);
>>> +	if (ret < 0)
>>> +		return -1;
>>> +
>>> +	if (!ctx->dev || WARN_ON_ONCE(last_dev == ctx->dev))
>>> +		return -1;

* ^^^^^^^^^ here

>>> +
>>> +	if (!netif_is_bridge_master(ctx->dev))
>>
>> hmm, do we expect ctx->dev to be a bridge master? Looking at
>> br_fill_forward_path, it seems to be == fdb->dst->dev which
>> should be the target port
> 
> It would indeed be very unlikely. It was a left-over from code I wrote,
> thinking that here I could handle cascaded bridges (via vlan-device). I
> dropped that, since conntrack does not follow this flow.
> 
> So would it be better to only make sure that ctx->dev is not a bridge
> master?
> 
> 	if (netif_is_bridge_master(ctx->dev))
> 		return -1;
> 
> 	return dev_fill_forward_path_common(ctx, stack);
> 

I think you misunderstood me, I don't think ctx->dev can ever be a bridge
device because ctx->dev gets set to fdb->dst and fdbs that point to the bridge
itself have fdb->dst == NULL but ctx->dev is checked against NULL earlier*
so the bridge dev check doesn't make sense to me.

>>> +		return dev_fill_forward_path_common(ctx, stack);
>>> +
>>> +	path = dev_fwd_path(stack);
>>> +	if (!path)
>>> +		return -1;
>>> +	path->type = DEV_PATH_ETHERNET;
>>> +	path->dev = ctx->dev;
>>>  
>>>  	return ret;
>>>  }
>>> +EXPORT_SYMBOL_GPL(dev_fill_bridge_path);
>>> +
>>> +int dev_fill_forward_path(const struct net_device *dev, const u8 *daddr,
>>> +			  struct net_device_path_stack *stack)
>>> +{
>>> +	struct net_device_path_ctx ctx = {
>>> +		.dev	= dev,
>>> +	};
>>> +
>>> +	memcpy(ctx.daddr, daddr, sizeof(ctx.daddr));
>>> +
>>> +	stack->num_paths = 0;
>>> +
>>> +	return dev_fill_forward_path_common(&ctx, stack);
>>> +}
>>>  EXPORT_SYMBOL_GPL(dev_fill_forward_path);
>>>  
>>>  /**
>>

