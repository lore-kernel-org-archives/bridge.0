Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FE81C9B7C
	for <bridge@lists.linux.dev>; Mon, 14 Oct 2024 18:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728930852; cv=none; b=QVCyzr/9S39p2h5at/Yyd2WUKVBbiuR8D5dGpwA3ah/ytgG3UH+QBKBWOVFHH3vu7hEr+Gp1+wxoTMig3OWyqqQ9AGfPbi1pQcMRJ3+SpvHOhVK2C6ncjs4VIijp+gn+HzcNe2NMtQzQrK7bRmC1oL8VsZUNrWsgn7+Q3M1ZiTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728930852; c=relaxed/simple;
	bh=UO2Bad4J5y0XW53XxtAm0h5XmWXUfxO04tiAMyE160U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FAhZDu3wIKEf5QvzBlGUHNROXDz3TW+8+YFFckl7eZTGRA2TFvcGvfQwM3So/EMLF89CTPxiKZ+YHPPgmeYgii3jbVAogLVM7GJVqNpO1yMzf7AboegvCNWP5z90TJvzFK+vi+qsnrYNUafNtk9Q0siw0Om5fWsO4vwwrYGjk4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKTgiQDa; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKTgiQDa"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a99f1fd20c4so354662566b.0
        for <bridge@lists.linux.dev>; Mon, 14 Oct 2024 11:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728930849; x=1729535649; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VlOnxyLsKzjPmX7mgEUAeOELC286PF6R2i4tL7ZkhEQ=;
        b=IKTgiQDa8Ua+5CQbimFgoxtG3t0M+O1hvxz5M9qb18CstE8wcZtCG9xjbhFRgdIFwh
         hqj5HXHK5+qF6f5FVEjG1FG8aJLSQGeg/cSQxR2Datzo/aliYbLO6LA7/tMdg04SjA77
         u9RgnoZV7frJIUGiQ2nEkYCVqD/LKJ5nPYokiatLnSXmE5SjStVKCzIjJHmhWwOTVU0O
         QnSWsx1UZr3vCYNgn8HI9SpuqU9+Yi8XZ7Jrlu78Qc9nB2GmXs09ACwzzublbPUDDXHW
         8QFZ8jTL9Zn2gF3TEpjRC6I319fz2aiMxDfm5n2j8CCeuSLrkpNgWVFqlZSeI3nBOJbM
         CKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728930849; x=1729535649;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VlOnxyLsKzjPmX7mgEUAeOELC286PF6R2i4tL7ZkhEQ=;
        b=fFXnf9Co8HnPU6EVb6C32capSjoS0MGqv1AWRQqItmw74Sk02KNIcZIP7h9202KE1L
         Bm2c4v5ZBJGGcEhjFZn5Ndr8OUM+KFLiusghS6D9Q45MhukYopJlMrR+D2N4xcyO6kqk
         bo2eWi9RYuPqWSVC3kZQE1vg/iDzUWP8l2DsCZS/LtBrUcoxHq8LjA7ZOgwZszd9yylI
         bdmLjk/RBT1cRxm7Z0m+WTHVaLL4HA2SBIZfdyfh15/mc9KJx9NisoD3qMMzqB15rxaf
         Kv5HtPV8eOXtefpkwMo+sOP6/QH60HG43ePsI2K2iCGGO07SqKmq1d/znzG/Kq48rF9n
         ussQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOBB2haFEKPjIYKwWriLCH2BhsNqH229zrc3Ih9Qc6K4OsJN1SKsmn/i0830U930FklqmwAkw=@lists.linux.dev
X-Gm-Message-State: AOJu0YwE+ZNsfxa+u32H6kn0wRR9FaJ49HE7RGjRkFEsB526ikA9gJRs
	69HQR302n3lV76qAJOqjygbyM+Ck1uLeFSv1dIwp7dAB2IgdoF0f
X-Google-Smtp-Source: AGHT+IHKZO+fC56r4LaVpTKQzX/+/pa5l07qojFohlY7OCNXpmf0sPt3hbXHuNvHiBIPoGLRAmVB1g==
X-Received: by 2002:a17:907:97cd:b0:a99:dfb3:dcb4 with SMTP id a640c23a62f3a-a99dfb3df63mr790057066b.39.1728930848857;
        Mon, 14 Oct 2024 11:34:08 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a04223e3csm261266766b.52.2024.10.14.11.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 11:34:08 -0700 (PDT)
Message-ID: <a0db4efa-2328-4935-9eb6-3344fcbc4b07@gmail.com>
Date: Mon, 14 Oct 2024 20:34:07 +0200
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
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <c3678626-7f5c-4446-9b4d-2650ddf5d5a6@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/14/24 8:59 AM, Nikolay Aleksandrov wrote:
> On 13/10/2024 21:55, Eric Woudstra wrote:
>> New function dev_fill_bridge_path(), similar to dev_fill_forward_path().
>> It handles starting from a bridge port instead of the bridge master.
>> The structures ctx and nft_forward_info need to be already filled in with
>> the (vlan) encaps.
>>
>> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
>> ---
>>  include/linux/netdevice.h |  2 +
>>  net/core/dev.c            | 77 ++++++++++++++++++++++++++++++++-------
>>  2 files changed, 66 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>> index e87b5e488325..9d80f650345e 100644
>> --- a/include/linux/netdevice.h
>> +++ b/include/linux/netdevice.h
>> @@ -3069,6 +3069,8 @@ void dev_remove_offload(struct packet_offload *po);
>>  
>>  int dev_get_iflink(const struct net_device *dev);
>>  int dev_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb);
>> +int dev_fill_bridge_path(struct net_device_path_ctx *ctx,
>> +			 struct net_device_path_stack *stack);
>>  int dev_fill_forward_path(const struct net_device *dev, const u8 *daddr,
>>  			  struct net_device_path_stack *stack);
>>  struct net_device *__dev_get_by_flags(struct net *net, unsigned short flags,
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index cd479f5f22f6..49959c4904fc 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -713,44 +713,95 @@ static struct net_device_path *dev_fwd_path(struct net_device_path_stack *stack)
>>  	return &stack->path[k];
>>  }
>>  
>> -int dev_fill_forward_path(const struct net_device *dev, const u8 *daddr,
>> -			  struct net_device_path_stack *stack)
>> +static int dev_fill_forward_path_common(struct net_device_path_ctx *ctx,
>> +					struct net_device_path_stack *stack)
>>  {
>>  	const struct net_device *last_dev;
>> -	struct net_device_path_ctx ctx = {
>> -		.dev	= dev,
>> -	};
>>  	struct net_device_path *path;
>>  	int ret = 0;
>>  
>> -	memcpy(ctx.daddr, daddr, sizeof(ctx.daddr));
>> -	stack->num_paths = 0;
>> -	while (ctx.dev && ctx.dev->netdev_ops->ndo_fill_forward_path) {
>> -		last_dev = ctx.dev;
>> +	while (ctx->dev && ctx->dev->netdev_ops->ndo_fill_forward_path) {
>> +		last_dev = ctx->dev;
>>  		path = dev_fwd_path(stack);
>>  		if (!path)
>>  			return -1;
>>  
>>  		memset(path, 0, sizeof(struct net_device_path));
>> -		ret = ctx.dev->netdev_ops->ndo_fill_forward_path(&ctx, path);
>> +		ret = ctx->dev->netdev_ops->ndo_fill_forward_path(ctx, path);
>>  		if (ret < 0)
>>  			return -1;
>>  
>> -		if (WARN_ON_ONCE(last_dev == ctx.dev))
>> +		if (WARN_ON_ONCE(last_dev == ctx->dev))
>>  			return -1;
>>  	}
>>  
>> -	if (!ctx.dev)
>> +	if (!ctx->dev)
>>  		return ret;
>>  
>>  	path = dev_fwd_path(stack);
>>  	if (!path)
>>  		return -1;
>>  	path->type = DEV_PATH_ETHERNET;
>> -	path->dev = ctx.dev;
>> +	path->dev = ctx->dev;
>> +
>> +	return ret;
>> +}
>> +
>> +int dev_fill_bridge_path(struct net_device_path_ctx *ctx,
>> +			 struct net_device_path_stack *stack)
>> +{
>> +	const struct net_device *last_dev, *br_dev;
>> +	struct net_device_path *path;
>> +	int ret = 0;
>> +
>> +	stack->num_paths = 0;
>> +
>> +	if (!ctx->dev || !netif_is_bridge_port(ctx->dev))
>> +		return -1;
>> +
>> +	br_dev = netdev_master_upper_dev_get_rcu((struct net_device *)ctx->dev);
>> +	if (!br_dev || !br_dev->netdev_ops->ndo_fill_forward_path)
>> +		return -1;
>> +
>> +	last_dev = ctx->dev;
>> +	path = dev_fwd_path(stack);
>> +	if (!path)
>> +		return -1;
>> +
>> +	memset(path, 0, sizeof(struct net_device_path));
>> +	ret = br_dev->netdev_ops->ndo_fill_forward_path(ctx, path);
>> +	if (ret < 0)
>> +		return -1;
>> +
>> +	if (!ctx->dev || WARN_ON_ONCE(last_dev == ctx->dev))
>> +		return -1;
>> +
>> +	if (!netif_is_bridge_master(ctx->dev))
> 
> hmm, do we expect ctx->dev to be a bridge master? Looking at
> br_fill_forward_path, it seems to be == fdb->dst->dev which
> should be the target port

It would indeed be very unlikely. It was a left-over from code I wrote,
thinking that here I could handle cascaded bridges (via vlan-device). I
dropped that, since conntrack does not follow this flow.

So would it be better to only make sure that ctx->dev is not a bridge
master?

	if (netif_is_bridge_master(ctx->dev))
		return -1;

	return dev_fill_forward_path_common(ctx, stack);

>> +		return dev_fill_forward_path_common(ctx, stack);
>> +
>> +	path = dev_fwd_path(stack);
>> +	if (!path)
>> +		return -1;
>> +	path->type = DEV_PATH_ETHERNET;
>> +	path->dev = ctx->dev;
>>  
>>  	return ret;
>>  }
>> +EXPORT_SYMBOL_GPL(dev_fill_bridge_path);
>> +
>> +int dev_fill_forward_path(const struct net_device *dev, const u8 *daddr,
>> +			  struct net_device_path_stack *stack)
>> +{
>> +	struct net_device_path_ctx ctx = {
>> +		.dev	= dev,
>> +	};
>> +
>> +	memcpy(ctx.daddr, daddr, sizeof(ctx.daddr));
>> +
>> +	stack->num_paths = 0;
>> +
>> +	return dev_fill_forward_path_common(&ctx, stack);
>> +}
>>  EXPORT_SYMBOL_GPL(dev_fill_forward_path);
>>  
>>  /**
> 
