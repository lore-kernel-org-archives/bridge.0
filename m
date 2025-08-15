Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D792F28980A
	for <bridge@lists.linux.dev>; Fri, 15 Aug 2025 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755270518; cv=none; b=M6RSE4FTiMoE8DXMAfxLdL+14urF/1MdxYrE/FzYNEdtAcQQnaBaM+2OEiAm0bsTINPIhIimTETlW8JjNq+IMCPWLrcNX9kmzB2/aN1oaG27abk6IBp7KLKzf19jO/BK9e8B8Ll5LzNIq0VC6Ye4tYOJc9mkOq7XmU824V1FkH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755270518; c=relaxed/simple;
	bh=wxXY4tEGwganMnpiKU8Ayd+L73yT/MpiUpiLzweyTx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g87E15sydkVfPuqvdbghntGTcn6fII6daNqW8YEcXk3Lpp1gj7zw5JFIvxEWaOBYtQkuSlH9IymAWoqwtNmfn97XlXOrC0SJd3vfIYqJyJvBVcdZdb/OfFBo0YXxm8gnS6hsHpAHMXJlxz+ecLZCx6DJm1INDDHdYopryKuS02A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=CejdWkmX; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="CejdWkmX"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-618896b3ff9so4283136a12.1
        for <bridge@lists.linux.dev>; Fri, 15 Aug 2025 08:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1755270514; x=1755875314; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DvYymIzLnJigupjUPWkbrLGydSeNzR7fRIJx+eQRmEI=;
        b=CejdWkmXFAVrTKexgUKyKjBUgZEZM9LgJ1x+K8KpSzkgOsXBJ6n6yEl+zt1wscukoN
         GNwCE/sqXtBnwG0GPoeNNU2+rExqUuM7C9/Q7o7ItaYjTKT34alAr5nkUrSY9fNElsLd
         WE6b7YuyRKIpAVGx0VWg89iemDHEG+t2dQBjfA75BMPq1S1jIxop1iDPV4dDX5IxZSe+
         oDplob9aeJnYQ+CYN/hp7oorZ7TIWjdeuQS7I4Y+Fz/50rKusiaWyHJJLYscknc1YXk3
         cvDPwmMUwEywlJWjXnDM6lNjZew7QSaNaJ8Tenopw4VlqcXD8tQ0WZgnVLnwg2qwTaNQ
         N+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755270514; x=1755875314;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DvYymIzLnJigupjUPWkbrLGydSeNzR7fRIJx+eQRmEI=;
        b=jdvwEJZf+4QD63tFeZJOIjI8rOLw1Mp89O3AH01mrthTI7rP/z8VL35X7WbEvfsGg4
         b31768KUrNmgplZfYELEuzSRxsO4zWERHL3ewcwLymaoLIZm9M2SnYmMfvinhbJaNrii
         9yfQXA/RupR7JA2MDKOa555cg6Ht9HHGnUnGGb/b+aoEpvW6jKsEKhuK2GfLSJifXfdj
         GdPS+WDrErhUDfsz9AG6VpAl6HFX3b32zzi8KgXW6oc8ly6GvKT9xiaJba9EvmisjN7O
         U1MgrSG63JZcFsHALSABBXHXvyyzGz1mRmbo/cROwffQPj7W/8ra52rP4DFPqNP+fM2h
         yzCQ==
X-Gm-Message-State: AOJu0YzLgqigIDf9DrOXS7lZYetFlKexL7WnI+YNI1Ae3PMvezdAklRL
	G7a8En23cF5MZ2xtCV9v3SSI1xQ7P/ASgmsAzOzKxFDyAo5/EJFJ45jMQDwhNeElaMI=
X-Gm-Gg: ASbGnctOTILnNrDr0kCuyIfS+f9PJoKN7dI/7EvNElA9WlIPfp3maTTnYvAf7VhQzYa
	Jg/MS6S8xXV+YgtPI5/c0NfepTUk+UDdabtkncVTJiTRRahuOfGewsSHGTliRdMxfOY5/I85tWs
	6LLEFWurUhPDEt1+ZuzRM9CMOb+PSgUOkEVXDh0WwqpHhJTMQ4cs0HSCF5N3WARyI11tix5yoPn
	+WQ95DcqAQzqpRKavu13gk3C8Rkx9Jk3mqF4e5uT5HQ9Ey/Ofcm8ViFWUruXjmABh5Oas9X0HDw
	WZPejk/YBooOwzhOGzkNI8dzd45samNdnnG8a2/NDdJKfq3Sq9qSYXEi5uPCL9UuFEBG4DWiR2s
	O1qf4f6kkzFBl5Ir82NU/MIgJjz1zCwYsjuMYI80=
X-Google-Smtp-Source: AGHT+IGg3ipRv25chD0V0TpD5T6M8dl0rPLRTtfh63vVqHF23z3Qpb+K6dK+mPlUqX6NaiNGb1oPjA==
X-Received: by 2002:a05:6402:2188:b0:618:780f:e89d with SMTP id 4fb4d7f45d1cf-6189199fa41mr6105149a12.3.1755270513688;
        Fri, 15 Aug 2025 08:08:33 -0700 (PDT)
Received: from [100.115.92.205] ([149.62.209.203])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-618b01ae5casm1791561a12.36.2025.08.15.08.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 08:08:33 -0700 (PDT)
Message-ID: <9680221e-e702-41b6-8401-9e940e2f3290@blackwall.org>
Date: Fri, 15 Aug 2025 18:08:31 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: bridge: remove unused argument of
 br_multicast_query_expired()
To: Wang Liang <wangliang74@huawei.com>, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com
References: <20250814042355.1720755-1-wangliang74@huawei.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250814042355.1720755-1-wangliang74@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/25 07:23, Wang Liang wrote:
> Since commit 67b746f94ff3 ("net: bridge: mcast: make sure querier
> port/address updates are consistent"), the argument 'querier' is unused,
> just get rid of it.
> 
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
>   net/bridge/br_multicast.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 1377f31b719c..4dc62d01e2d3 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -4049,8 +4049,7 @@ int br_multicast_rcv(struct net_bridge_mcast **brmctx,
>   }
>   
>   static void br_multicast_query_expired(struct net_bridge_mcast *brmctx,
> -				       struct bridge_mcast_own_query *query,
> -				       struct bridge_mcast_querier *querier)
> +				       struct bridge_mcast_own_query *query)
>   {
>   	spin_lock(&brmctx->br->multicast_lock);
>   	if (br_multicast_ctx_vlan_disabled(brmctx))
> @@ -4069,8 +4068,7 @@ static void br_ip4_multicast_query_expired(struct timer_list *t)
>   	struct net_bridge_mcast *brmctx = timer_container_of(brmctx, t,
>   							     ip4_own_query.timer);
>   
> -	br_multicast_query_expired(brmctx, &brmctx->ip4_own_query,
> -				   &brmctx->ip4_querier);
> +	br_multicast_query_expired(brmctx, &brmctx->ip4_own_query);
>   }
>   
>   #if IS_ENABLED(CONFIG_IPV6)
> @@ -4079,8 +4077,7 @@ static void br_ip6_multicast_query_expired(struct timer_list *t)
>   	struct net_bridge_mcast *brmctx = timer_container_of(brmctx, t,
>   							     ip6_own_query.timer);
>   
> -	br_multicast_query_expired(brmctx, &brmctx->ip6_own_query,
> -				   &brmctx->ip6_querier);
> +	br_multicast_query_expired(brmctx, &brmctx->ip6_own_query);
>   }
>   #endif
>   

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

