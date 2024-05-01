Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2404750277
	for <bridge@lists.linux.dev>; Wed,  1 May 2024 09:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714554057; cv=none; b=oUPCEq0jKnBdKmmK9QHcom5qmxzxFHVitx/Oitl9I1ydBxUgCjqGjWnd8F1i0Dud8MHXLJyhjvBEIngPvssaf8jAzPqRz17jTGjU6NtrcdRDsYT1DjMO9aVTEUdK4MF/D2ir1mPatumpPW+CFlZcxXedyVq4YOY0bnNNo1guiRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714554057; c=relaxed/simple;
	bh=RvlWpLEFaTjb+9r8GV4kOWTTNkCATCgpD5gAqvzy9as=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d+dkCCDw5JI6YznjZkrOtWVqZ52P8OjQZO6/iXw+MvWhYIC1zj8ZqgkV+43vxTRf5zsMAzfa1DNcBCykOyf5xV3fE0xYcnC2P2QSnWjyPzW3hyfhYYMl08Mmh0pSxdNfLOQ6Zp7j1ixhKPTfy9pDyEczsSRi1T3MkzHFmPQLgiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=0Td6VQq8; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="0Td6VQq8"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e0b2ddc5d1so30990551fa.3
        for <bridge@lists.linux.dev>; Wed, 01 May 2024 02:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1714554054; x=1715158854; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Z/cUhjxZbZcBp200s+T3WFXuwoGui/XESvwGtAV7pU=;
        b=0Td6VQq8kLiBo0aWneZbYsJPRW/+zmRf/Pr73Qgz+k7Grk0B55yOaq35uPygr87HxK
         ksCzpMw3I9pe7roilc+CW7b5WaHxfa8PF7C6eay5d4qOfsi5CBVVJjPfdg22QvWkRWab
         cUykRyxApKcehXtk+46ciAKSPGTZnuT851zYmw+25RT7y5y1qXPAkWjzpo9QqDF3R+pV
         xlw/2R7kYJN1cK77D1sqDjiDaEcLi3ArNSwn6B3MfrivUb1cKm/SLoS2L6D9BtHdugxM
         /wro+6d1Hj6qX3O2XdINKLEUUJ4FCiM4EOh7D3yoTtm/rWOUZfluRkku7d7yceWPUmB6
         Wtog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714554054; x=1715158854;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Z/cUhjxZbZcBp200s+T3WFXuwoGui/XESvwGtAV7pU=;
        b=CzzMzFYtlA4AnYUHJmbq7FEeeGJUIBlwMSCCNuKkvkfV2cxjNVZowkXXorYwlLm6MT
         HkTFeyQIwqqx9LH7H9UNMp3m3e77mA3rMHsCwaFha01a47GEZLwkqgmqYxHusTWaxPwJ
         VAKyq+C2kXW3T7g1voTwqnTd0mSXUgeRMkY+QqEbX7U6oPCOiNVzZAOgLZIR6W2ZB47b
         tdUj+gxNLBogmO0Nsz/idsAhqldIIbkJopL0YwXKPzV9mPgtkVGJE/UphZ11hKZDaQPs
         WIT9O9uK0bAFFxBxaI/BT6w7MCtkQET5AvYF9sab6H6Qiz0l3wZgy/WRHtwt3wBSnUqf
         oW+w==
X-Gm-Message-State: AOJu0Yy0mbAaTZ/2ZOo0YYrF0YWwf/MY1Dq2J76sSHgiE6JDjdVSBQfJ
	HS40eIeqPJOvdlEAEmlPzTyL9ObVpx8yOqHVx2sURH9cP6W//akuUGia8Z09K5Q=
X-Google-Smtp-Source: AGHT+IE6du7GtGa4yWJTPKJ9+hxmuTCQMBAnDfeiG7v0iH1S+LQsBmxd6vnFIJ8yJppXhTWsJgTwMg==
X-Received: by 2002:a2e:3a1a:0:b0:2dc:b1c7:514e with SMTP id h26-20020a2e3a1a000000b002dcb1c7514emr1350558lja.8.1714554054077;
        Wed, 01 May 2024 02:00:54 -0700 (PDT)
Received: from [192.168.0.161] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id bg33-20020a05600c3ca100b0041c14e42e2bsm1533485wmb.44.2024.05.01.02.00.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 02:00:53 -0700 (PDT)
Message-ID: <07cc48d8-658b-4eee-a72d-efe3cdbed967@blackwall.org>
Date: Wed, 1 May 2024 12:00:51 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: bridge: fix multicast-to-unicast with
 fraglist GSO
Content-Language: en-US
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
 Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, =?UTF-8?Q?Linus_L=C3=BCssing?=
 <linus.luessing@c0d3.blue>
Cc: bridge@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240427182420.24673-1-nbd@nbd.name>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240427182420.24673-1-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/04/2024 21:24, Felix Fietkau wrote:
> Calling skb_copy on a SKB_GSO_FRAGLIST skb is not valid, since it returns
> an invalid linearized skb. This code only needs to change the ethernet
> header, so pskb_copy is the right function to call here.
> 
> Fixes: 6db6f0eae605 ("bridge: multicast to unicast")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  net/bridge/br_forward.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> index 7431f89e897b..d7c35f55bd69 100644
> --- a/net/bridge/br_forward.c
> +++ b/net/bridge/br_forward.c
> @@ -266,7 +266,7 @@ static void maybe_deliver_addr(struct net_bridge_port *p, struct sk_buff *skb,
>  	if (skb->dev == p->dev && ether_addr_equal(src, addr))
>  		return;
>  
> -	skb = skb_copy(skb, GFP_ATOMIC);
> +	skb = pskb_copy(skb, GFP_ATOMIC);
>  	if (!skb) {
>  		DEV_STATS_INC(dev, tx_dropped);
>  		return;

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
