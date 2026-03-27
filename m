Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B904398903
	for <bridge@lists.linux.dev>; Fri, 27 Mar 2026 12:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774613968; cv=none; b=rLEx1HH5+Yl05XT/DjaNFTh6/9U7WEj8PiMAhT/tj4NkLVJV+pXgfEZCYkGNg9sZaFCZKy/FOV9u3LLb0jYIojFWjnMB4w40aMfqkni/Q4rhchcGAWxVQJxlCR4FligOE61239pjmeKnwwN9RqTmNdcFiYvlGCAzs0naChpfnG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774613968; c=relaxed/simple;
	bh=PqtqR/6h0NC60cTerLw5KDXlizq+v+vVVirZ7vHZIx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fo5C0wN+BeFgRug/tYCykhBlrPfezuPpCzagadl4hoPD3/eqKYYr8GYflRQykfNFAeQlDlZMHcK1GtKlnQY0WZjJd02r/WMhWrYITPr2/vHSDOEm4Qnaro+SaZo0rpGAw4OOp64PzPmTS7+X/N5pj1rDgxOiE6d7dGR1lbi4/A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=OYXU54ue; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="OYXU54ue"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-483487335c2so22194745e9.2
        for <bridge@lists.linux.dev>; Fri, 27 Mar 2026 05:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1774613965; x=1775218765; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6zimsPVsDumOVwRCe4M573NwSIeXesqqtNX9MQ4nuFE=;
        b=OYXU54ueN3oSKLht816xHcDgwhLi11SmI4D+IqWqzISelrw9awbtpknyBsz2Nw+aTs
         MHMAJpXwlhqQlh5hNCxD/jYSC1k930j3nMabO5XDnfKJcCOrPxTfrh8+jWblSKdQ3LXD
         nbL380r+oBUG8tZZ0os1cSVLBYJFpGtx5yZo0qW6d4aK8xVc46aipvl4o0ojSTAalGTf
         Qz1yAyUdMQymfDU1DniZGsjlUm0QyMYcO73ZzKJzJ6CMQcT0miXOtDcI2JC4F/Z5yPxW
         Kt+de+Pq3/E/UBiKNWZytPOqnylCKGQ0FNCt1I92Me97RTTVLgMwDq1L7SiW64Y4o+MQ
         kZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774613965; x=1775218765;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6zimsPVsDumOVwRCe4M573NwSIeXesqqtNX9MQ4nuFE=;
        b=RcGl3KxclF2Ax2fF8F9Ai5e2B9qIGTxq8vl6nUnKwy3R7FLCr6iGXwaIVxVv41v8wc
         gtuC0kH6VzxEWC/AjQ0RXxfAKWiwz5Bk7LpESge6gcfwYoP2QtvTrDRfy52qQ85819rx
         Bnr9fo+jQuKve/pWBrTso4ZPbVmzyN7Xeab70Ndz2ZrQ+A48y5eASCry/9g6LXGaeK3X
         pTD023qeNMBmH6KBHxnL2CoJPoQqOujJ0SoH/dlZ6SFsm4IyaY1j/ZtJkU38haMFYli/
         Q/VPv7WKBjvpHE2HNP38Fz7jui841ZkPVPxCaSTPSmgSW19Ut2NZzhoBMIT0/khqrwXQ
         mIxA==
X-Forwarded-Encrypted: i=1; AJvYcCUhQZQX0qMn+LuZkqgz/rZ/5LbkGkNJvXYTBO7DwTUuubxvXAke0LOiqVIYVvAPUn6GC9+jjVM=@lists.linux.dev
X-Gm-Message-State: AOJu0YxEUFO5ZuarnZpaQ0HEmulNzpqTigfH7MY93EzAn/XfMu5Fg2Lm
	isTwTpPe/IKI5A/sqfj8KcnYbS+Q11FFLnbIj7IRNkMCqMyWhTOWorNL2YgKiYTpcLA=
X-Gm-Gg: ATEYQzyQT2CQ7MYCKkwxH/CoPI/JFYad95BFl2ae4qfnpxQYJb52EmRYDyRw9QHj4T5
	D5qVWUR5EtajAfXY2IegBT6OG6U90c6QPRRwX9dCxuxzrXb5mAoL34sY4Sk23JLhUc2TPLEqbpc
	p0yN2EQzdJl72RFP5wJ3KWATUeQY9PAJSCpLC5pbK/4yYiIg3JSRkVXW08fZHIkunmYJ3FdZWRy
	lhRqk1YmG/OVfzddhBlJ5ljo4L7OYxV21j2SfBTLgVTOrxwpQnWx+ySJiI/ZzHMdbR3ZrZbPmbj
	eMmd2ES86+pHQJ98cihnPpbzRjsk+FuqjSHUsBed42G5W5M1q0wyOAjwbWxDbeS0dMGRmW6gAYZ
	fLRUWB0LbQurqV4PkfH30P/0ET6SUdwKZ4xET//65UaK5GyUs1jsIG4UfFWAta0NXIg/Y8WIL4s
	hDyCEy89pXQfegd6Lgy7fMaaYZcGgC8MiONNEitRURoyzqyxBhe/7drA==
X-Received: by 2002:a05:600c:8b4b:b0:485:3fe6:21f5 with SMTP id 5b1f17b1804b1-48727f0e5f8mr35058265e9.10.1774613965289;
        Fri, 27 Mar 2026 05:19:25 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722d38a5fsm86886705e9.12.2026.03.27.05.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 05:19:24 -0700 (PDT)
Message-ID: <f23ed1b3-6321-4e6d-9cda-ec5d34304f3b@blackwall.org>
Date: Fri, 27 Mar 2026 14:19:23 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ipv4: igmp: encode multicast exponential fields
To: Ujjal Roy <royujjal@gmail.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>
Cc: Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260326150742.50289-1-royujjal@gmail.com>
 <20260326150742.50289-4-royujjal@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260326150742.50289-4-royujjal@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/03/2026 17:07, Ujjal Roy wrote:
> In IGMP, QQIC and MRC fields are not currently encoded
> when generating query packets. Since the receiver of the
> query interprets these fields using the IGMPv3 floating-
> point decoding logic, any raw interval value that exceeds
> the linear threshold is currently parsed incorrectly as
> an exponential value, leading to an incorrect interval
> calculation.
> 
> Encode and assign the corresponding protocol fields during
> query generation. Introduce the logic to dynamically
> calculate the exponent and mantissa using bit-scan (fls).
> This ensures QQIC and MRC fields (8-bit) are properly
> encoded when transmitting query packets with intervals
> that exceed their respective linear threshold value of
> 128 (for QQI/MRT).
> 
> RFC 3376: if QQIC/MRC >= 128, the QQIC/MRC field represents
> a floating-point value as follows:
>       0 1 2 3 4 5 6 7
>      +-+-+-+-+-+-+-+-+
>      |1| exp | mant  |
>      +-+-+-+-+-+-+-+-+
> 
> Signed-off-by: Ujjal Roy <royujjal@gmail.com>
> ---
>   include/linux/igmp.h      | 80 +++++++++++++++++++++++++++++++++++++++
>   net/bridge/br_multicast.c | 14 +++----
>   2 files changed, 86 insertions(+), 8 deletions(-)
> 
[snip]
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 1438c023db62..1de6242413e0 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -939,7 +939,7 @@ static struct sk_buff *br_ip4_multicast_alloc_query(struct net_bridge_mcast *brm
>   	struct sk_buff *skb;
>   	struct igmphdr *ih;
>   	struct ethhdr *eth;
> -	unsigned long lmqt;
> +	unsigned long lmqt, mrt;
>   	struct iphdr *iph;
>   	u16 lmqt_srcs = 0;

please keep reverse xmas tree order

>   
> @@ -1004,15 +1004,15 @@ static struct sk_buff *br_ip4_multicast_alloc_query(struct net_bridge_mcast *brm
>   	skb_put(skb, 24);
>   
>   	skb_set_transport_header(skb, skb->len);
> +	mrt = group ? brmctx->multicast_last_member_interval :
> +		      brmctx->multicast_query_response_interval;
>   	*igmp_type = IGMP_HOST_MEMBERSHIP_QUERY;
>   
>   	switch (brmctx->multicast_igmp_version) {
>   	case 2:
>   		ih = igmp_hdr(skb);
>   		ih->type = IGMP_HOST_MEMBERSHIP_QUERY;
> -		ih->code = (group ? brmctx->multicast_last_member_interval :
> -				    brmctx->multicast_query_response_interval) /
> -			   (HZ / IGMP_TIMER_SCALE);
> +		ih->code = mrt / (HZ / IGMP_TIMER_SCALE);
>   		ih->group = group;
>   		ih->csum = 0;
>   		csum = &ih->csum;
> @@ -1021,11 +1021,9 @@ static struct sk_buff *br_ip4_multicast_alloc_query(struct net_bridge_mcast *brm
>   	case 3:
>   		ihv3 = igmpv3_query_hdr(skb);
>   		ihv3->type = IGMP_HOST_MEMBERSHIP_QUERY;
> -		ihv3->code = (group ? brmctx->multicast_last_member_interval :
> -				      brmctx->multicast_query_response_interval) /
> -			     (HZ / IGMP_TIMER_SCALE);
> +		ihv3->code = igmpv3_mrc(mrt / (HZ / IGMP_TIMER_SCALE));
>   		ihv3->group = group;
> -		ihv3->qqic = brmctx->multicast_query_interval / HZ;
> +		ihv3->qqic = igmpv3_qqic(brmctx->multicast_query_interval / HZ);
>   		ihv3->nsrcs = htons(lmqt_srcs);
>   		ihv3->resv = 0;
>   		ihv3->suppress = sflag;

