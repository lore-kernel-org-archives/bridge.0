Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A74361976
	for <bridge@lists.linux.dev>; Sun, 16 Aug 2026 07:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786865594; cv=none; b=PG0MCUhVG2j6OlwqSUM1embNuydMyMTPr87tRlJIo54M9O/BRJL/TcEcG003BB3ArZVN4NtV5Wt3yIilUt2RjB2uZ+0vjynGq9pdO8oo7YSJQK3fyZcmNFmPgolRPJpUVv3hC+jQgVIQgwfQZYtQNV9HgR8f8aNv1UdTP0Jor2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786865594; c=relaxed/simple;
	bh=y6QcRCCfW4d495k95HuIQw2UVSsdUa46AUu5XwAig4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NmSQYFpG4t6Guug68KFVLRbuBe1gVZzhImljfKNjCuqbv9/xi5ctpMl1CriZLJy7plno4METJvjcKJrqrCh0+hMOEOYNx5GzQiS0Gtu4tsPtdGM93p6VKsJ9QJA+0OtgJ1xjRMarSwAwHNE3qkeEVTPl4+B06p4Q7YznEWfeZAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=lyXKm8j8; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="lyXKm8j8"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-476a130c138so2501061f8f.0
        for <bridge@lists.linux.dev>; Sun, 16 Aug 2026 00:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1786865591; x=1787470391; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V4Dxzk9SYkYwJWvs5z6wDXm/t0KB0vBdS9GjuR4ntoo=;
        b=lyXKm8j85o7cQ40Kc3fdePpqvR96JzAUXhFz2Vzg2g7465dd86IeNA42tTmbQxteuY
         ZtRHAJn12tj3Q+da23uljjHVXjUwCvXk4YGrTElLCIVHKECR0B8xBIsgkSctr+YZ0CH4
         k4WikLBhBInPcApTzjRSaOdqVohn5zZjK5WDfPe7+uBboXoLQHcnJ6K2FPq9uYyjowXR
         xY2OUqOT6ssdvO6Z2R53lRni+67c+seace/tgQs0qoCNfjoWl/Cof51La2WcsLg1/92B
         PLgCHzP1FjBhFjtjyuhtcovebtr7iSsjf4EuXpa2UDRC3+FzI5VNDsP3GW2oXFRUh0xJ
         9fqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786865591; x=1787470391;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V4Dxzk9SYkYwJWvs5z6wDXm/t0KB0vBdS9GjuR4ntoo=;
        b=Cf1eWCZsvkHjvmjIeejeDQ6p7wUwef+DTd3rkVTtWDXpEybgUf8qfF9DSvrlmOaKuR
         q9pmeMirh17dHd7qYitIU4NqgIYeqR6FxnPENt3l2WMTjb7JPj2Cgj+ibB5lDZAsB/Xi
         3MsFr81Pbwdbzc4QhB1yudIpAiMno2cYVCFXpMmOr2a+VaD8KL+jEXYptB8i1XZr/bTq
         DFYqo7QcnyMsoOEtSftelncoxrsRAA38/jiTPIO8ZnkIgaQoBTdzGItprymmpowGMRfs
         iVSl1oabnfnTFFyt7/42+k3GMggRBhS8ea/NHGR+55y31V2FcIuZBqkoGEkDynWiSqo3
         EywA==
X-Gm-Message-State: AOJu0Yy7u0hDHeOLVL28AtCYxc2Si3tDVs6fFQbUMx6UvxTSA/tInq1K
	jezeOF7HwFBBD1dUC2UfMFQr/q9jsl5UHNtgd0SVgh6V2YIImbEz/ua5PQFTES76T0A=
X-Gm-Gg: AR+sD11b/DX4KYhiJyCl+AVsoNuFZcsutg6CdMir6nAGvShaUMGHVmhAFQnHhQpnoat
	zxl9WcfiJpcGtBlYmmnyyMik6skBMhLWHewUg4bgk7S416UosCBmO+OCvB6FxxqJgpqGnBK49a+
	xypmPpeTf0eUDi+Jk7mr9jb4WRtHdVi7xnwbbS+sJaKbG3+BrTkgRxwy0lQeo4C3JMdrKAbD8+m
	GLK9ZXCeewOe/5zWHcW+I3bI17U4Qnia3R0+9WydBTvdUdzEAVY90C2HePBVq952lo24hz9AcSs
	Tzq6bbQBGrQHTVLX1skQBizMFNNMdmuBVMHyQtmPtb73spMZNM+KNwovOA2Mn9vwAIfSWfJFmKK
	4V1SPY0EDxmrP3XyQO+6LriFq/hvATTemgaSlDeyq3p8l0NNlDV17FOr/muiG2AA0NDLYy0jbVa
	+w6Iwn1HiXEwKpMw0m5RZMGxorwkMg0b2GsdnX0zDbEmIfnuK4pIpqxipA1BC8xQ4rJNrUounEi
	x904S4LwmJMmpM5Dbs/E4QpRrdtqyg=
X-Received: by 2002:a05:600c:528d:b0:499:900c:9c69 with SMTP id 5b1f17b1804b1-499900c9e99mr124668415e9.9.1786865591344;
        Sun, 16 Aug 2026 00:33:11 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49996188217sm53667815e9.13.2026.08.16.00.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Aug 2026 00:33:10 -0700 (PDT)
Message-ID: <0d917407-feaf-41c6-af7f-080aced09bf3@blackwall.org>
Date: Sun, 16 Aug 2026 10:33:09 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: Reject descending VLAN tunnel ranges
Content-Language: en-US, bg
To: Ruoyu Wang <ruoyuw560@gmail.com>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260814134053.1387275-1-ruoyuw560@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260814134053.1387275-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/08/2026 16:40, Ruoyu Wang wrote:
> A pair of descending VLAN and tunnel IDs can pass the tunnel range span
> check. The VLAN subtraction produces a negative int, which is converted
> to unsigned when compared with the u32 tunnel ID subtraction. It can
> therefore equal the wrapped tunnel ID delta.
> 
> The range loop then performs no iterations. Since the batched
> notification handling added a post-loop error check, this leaves err
> uninitialized and makes the request's return value unpredictable.
> 
> Reject descending VLAN ranges before comparing the spans. Valid
> ascending and single-entry ranges remain unchanged, while malformed
> descending ranges consistently return -EINVAL.
> 
> This issue was found by a static analysis checker and confirmed by
> manual source review.
> 
> Fixes: 94339443686b ("net: bridge: notify on vlan tunnel changes done via the old api")
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> ---
>   net/bridge/br_netlink_tunnel.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_netlink_tunnel.c b/net/bridge/br_netlink_tunnel.c
> index 71a12da30004c..05f560eeb789c 100644
> --- a/net/bridge/br_netlink_tunnel.c
> +++ b/net/bridge/br_netlink_tunnel.c
> @@ -301,7 +301,8 @@ int br_process_vlan_tunnel_info(const struct net_bridge *br,
>   
>   		if (!(tinfo_last->flags & BRIDGE_VLAN_INFO_RANGE_BEGIN))
>   			return -EINVAL;
> -		if ((tinfo_curr->vid - tinfo_last->vid) !=
> +		if (tinfo_curr->vid < tinfo_last->vid ||
> +		    (tinfo_curr->vid - tinfo_last->vid) !=
>   		    (tinfo_curr->tunid - tinfo_last->tunid))
>   			return -EINVAL;
>   		t = tinfo_last->tunid;

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
