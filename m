Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6221C73530
	for <bridge@lists.linux.dev>; Tue,  7 May 2024 12:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715084149; cv=none; b=k7Y/EW/Kat7+P0lBGYCnAMeV+YXplpYKi10t+eJedQxqcbAnunrX+FWfQah3N8eMuUsR7Uecl0bRealFjU0fs4fUme9HaQ3hVPydlksmd9JlTxk5/+T4MOcO0SNVk1/9eU7Cff6hOayuipCisd3UfDmGcWDcm+HX0FD5F8BOhbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715084149; c=relaxed/simple;
	bh=dWYuhSmaw6zHw/xPyvKvmeoz7fmgJSbAFIN1ULigx1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bnDscfUXQHUXEkkjVdU6DqKovHYo1Rs+Rpzhm75BUHHmI0pYD8kqdDsC3mGEx68OlQCJuW5fvTiOtihmZ8VlCKwc0mNlGtCdQc4SFUzhCy1YoujXRtvDpw5xW05Yf4hQd0V7Mn7UhV2Kvf27WXZfUEvl4ndRR7pmnfEZiJ10cIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=ClHQqugI; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="ClHQqugI"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a59b178b75bso522286366b.0
        for <bridge@lists.linux.dev>; Tue, 07 May 2024 05:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1715084146; x=1715688946; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IUKfXenJAG2N5WSgqguRSHR3qBfgjkNSXZ2oXGFiItU=;
        b=ClHQqugIB1aISqYE6zKQlr++XIksuhtWiIAo/AsJpznU7SslDEAFJ13U8c+JpVRFmE
         szUyqivbdtTWYLhfH5Z7s1EuCXCoZNmP3RRi0f/wwH8Wgd5VUwAeZb9W47VkZDct9fGW
         ZnKa4tLuAJruMqFLr4QSvITJlnTTva6SPhLPSH5MSm3fLUs3mlrQELL51lPlvSdytZ9z
         cMMjMsWKxBNh3n59QBhtWHhUZVnL7Eju7UPV3FzvjXzOiU+Jzy1Erswrb7K92xh5oP9q
         Fcb8QlXL2XXlvNoVcbtWeXubzkuYIZD8pjxSeP8+CEvU6u0vlegeCIjwEQn8CyG/MYaB
         xvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715084146; x=1715688946;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUKfXenJAG2N5WSgqguRSHR3qBfgjkNSXZ2oXGFiItU=;
        b=Uy4/cSSRe38ANzK9NNufOo8qKtfJTiSKco1Jkib6E6MPTdvyk/rUhD6w26trB4dmYM
         +5j+fa1daui7OgGhqkl47RqZi6mYSWws3Xoz0+irxqnMc2XtcjjlElX9N4hkvISleUBr
         Lh3mnKHV5/gFBrpiF45NWJl4xKOxi8qGnHyiM/HE912NmAzBWMBg1w0Tk4s6uYxktDhT
         WZHuSaphQI4RFySgDsOLyXLfiSzzcvcCPJcNsKTRbTbwu51R5SPXKJ2U8Bhg5g9xBWqB
         OFcAsNdaXzriCqpbTCbwk4Q1T9BrF1c1enOrB56TiH5ExEDPRfp7U6tU+yfCDU3qL31h
         YA/Q==
X-Gm-Message-State: AOJu0YyzxMwq8M5kYNmmA17j322cv0FbZCgaMAFnMDtTcCtayuywAh64
	rbK4Nbiaa06yBMq5mSjdXg5kDqP0hBfT5YIo7Q3EbRpOjSl+ST5aj3fA2xH9NBo=
X-Google-Smtp-Source: AGHT+IG9cak2fCNRkjLA6nMOklMc3wR0gPeYdLkCkvN53U7wFdtqN+DcTu8b6RKxXiaT5kYD3tNeag==
X-Received: by 2002:a50:d4d3:0:b0:570:cd6:8ef with SMTP id e19-20020a50d4d3000000b005700cd608efmr9909187edj.29.1715084145631;
        Tue, 07 May 2024 05:15:45 -0700 (PDT)
Received: from [192.168.51.243] ([78.128.78.220])
        by smtp.gmail.com with ESMTPSA id j8-20020a50ed08000000b0056e718795f8sm6289854eds.36.2024.05.07.05.15.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 05:15:45 -0700 (PDT)
Message-ID: <9a1825ff-3a55-4c2a-86bc-0709d4ff8153@blackwall.org>
Date: Tue, 7 May 2024 15:15:43 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: fix corrupted ethernet header on
 multicast-to-unicast
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
 Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: bridge@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240505184239.15002-1-nbd@nbd.name>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240505184239.15002-1-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/05/2024 21:42, Felix Fietkau wrote:
> The change from skb_copy to pskb_copy unfortunately changed the data
> copying to omit the ethernet header, since it was pulled before reaching
> this point. Fix this by calling __skb_push/pull around pskb_copy.
> 
> Fixes: 59c878cbcdd8 ("net: bridge: fix multicast-to-unicast with fraglist GSO")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>   net/bridge/br_forward.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> index d7c35f55bd69..d97064d460dc 100644
> --- a/net/bridge/br_forward.c
> +++ b/net/bridge/br_forward.c
> @@ -258,6 +258,7 @@ static void maybe_deliver_addr(struct net_bridge_port *p, struct sk_buff *skb,
>   {
>   	struct net_device *dev = BR_INPUT_SKB_CB(skb)->brdev;
>   	const unsigned char *src = eth_hdr(skb)->h_source;
> +	struct sk_buff *nskb;
>   
>   	if (!should_deliver(p, skb))
>   		return;
> @@ -266,12 +267,16 @@ static void maybe_deliver_addr(struct net_bridge_port *p, struct sk_buff *skb,
>   	if (skb->dev == p->dev && ether_addr_equal(src, addr))
>   		return;
>   
> -	skb = pskb_copy(skb, GFP_ATOMIC);
> -	if (!skb) {
> +	__skb_push(skb, ETH_HLEN);
> +	nskb = pskb_copy(skb, GFP_ATOMIC);
> +	__skb_pull(skb, ETH_HLEN);
> +	if (!nskb) {
>   		DEV_STATS_INC(dev, tx_dropped);
>   		return;
>   	}
>   
> +	skb = nskb;
> +	__skb_pull(skb, ETH_HLEN);
>   	if (!is_broadcast_ether_addr(addr))
>   		memcpy(eth_hdr(skb)->h_dest, addr, ETH_ALEN);
>   

This dance is getting ugly, but better to have it correct.
It'd be nice if you could add a selftest that exercises it.

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

