Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FCE51C45
	for <bridge@lists.linux.dev>; Tue, 23 Apr 2024 11:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713870770; cv=none; b=nfhotF0gJ2pZ89phPciUcuXX/+MVrw5t1vXGj1dWC5JFH0daJmossJfak3f8L6L9v8EhryRsMX8OiNM8/ZYsRBTq/Tx1sD1sBpJ9CMSbgDaJXdKEify0VJGaEWEWKUyRcsbJJcew10xdsClA9bZ3Nh8zVG5/EQz15YYCJ7fsqUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713870770; c=relaxed/simple;
	bh=WK4EztFBVAHg7eYRzkCerijhdminORv97CA/HPtekR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d2fWKfoDSv9BoEW9I0WkWr0PUfR+dhWMZBOxAmQhReWjK/e0dmYKZE/r6SwlP1f/0EK/OT93SVL60WfxVwkb7YtDZekR+pkKFezZfSlZCPnfsjctzHsikwtOdgsmnSpAv6kkDYmbLmExw2lgGB+MW7jEB06+sP9LZoyp6W8hVGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=upFjPKJc; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="upFjPKJc"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a5557e3ebcaso904277066b.1
        for <bridge@lists.linux.dev>; Tue, 23 Apr 2024 04:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1713870768; x=1714475568; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1GbwA9AtFu4Yu/r6+eMwCiUFKh6Xn8xW9wVevaAyhDE=;
        b=upFjPKJcD6oUa7vohzqplzDj53zMoEJhf/OSa/3zl4jmoEyM0I5I1ObIivKSggJ6c6
         JB1rXPUuupH9VafDiDPirvmXXXMuFB93yG47gTm7ExrHCz370YazNS96EP7Y/21xu47c
         ETo0Jxv/A7hpGTyP0iIW1KMMRzQtYAsYBVHq/RyMSCkb3eYlpVPfgymWUw3izW0oHZkd
         U8Dj4h51FIerujx6mpi+gXITsvs0+4LyjoJd2AINyc0KAEgx12uzSxZNsWPyDWA46YJg
         t57quQSfMWUjJCrJWwtO695ym15ZumT9TjOM5/v+dqexYbKOH2O9oqKWkbEMJGLHvjyk
         oNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713870768; x=1714475568;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1GbwA9AtFu4Yu/r6+eMwCiUFKh6Xn8xW9wVevaAyhDE=;
        b=NmiV6axKZUa/8da3+ADSEn7YrgXlaVhv7aX7Bawh5g7s7hhL0xEfDfSlQvPoadXYuy
         DxWKQWyncH3ac8dLjGEoOHa+EnzEf5ZTuX2xZNvn+xk6TD+FA908GzLTkQpF/wUFJMyP
         hB24/MIUL/BUszBQ6HSegOv44JWJMw4YKjuipyvU+hI0OLpHTgXgqZDPjC55svFeG8Dz
         v2tzeqtNQ1TYvrVhUbdpkEEw/pCj63VRIc6bsM1eduk14a/LSZ/F74cWOWeN2YbP0jZQ
         epIa0BTRQ6HITaJYSfHXWX3qCp5Nvk4BlGdx/F4348PPagwQnLQSwlwNmTQZmE3wKvXe
         cm+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUB0baytDLZAuKCD6MOruJK/yFwUnrtEslyOoxlOTmjZZcjtAz1KuDPcyrkWLEKpazAc+KeRVdLx2dH5hyc3Wsu8gy/EJxz
X-Gm-Message-State: AOJu0YzGmm1EsIL1mOHALI+DX/Z3YG5FewhhhnXAUD55tltLy+6TOaEv
	uO/xujXKYYX0eYP69Mo64DJKFtu+jDUUbkUIc79oqJw32tWUeZ3uP0DX3wjcKPk=
X-Google-Smtp-Source: AGHT+IG+TtGWysDfdlawCem0S3HMY9EM/WsGwW7MbhgDMk8j9ZqeCViVLQ5g4hfRsmjhInG+O7du1A==
X-Received: by 2002:a17:906:af79:b0:a58:8602:ffa1 with SMTP id os25-20020a170906af7900b00a588602ffa1mr351273ejb.19.1713870767677;
        Tue, 23 Apr 2024 04:12:47 -0700 (PDT)
Received: from [10.100.1.125] (ip.82.144.213.21.stat.volia.net. [82.144.213.21])
        by smtp.gmail.com with ESMTPSA id t22-20020a1709063e5600b00a5209dc79c1sm7006898eji.146.2024.04.23.04.12.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 04:12:47 -0700 (PDT)
Message-ID: <b1fccc7c-3c9f-45e0-979f-f83dfc788613@blackwall.org>
Date: Tue, 23 Apr 2024 14:12:44 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: bridge: remove redundant check of f->dst
Content-Language: en-US
To: linke li <lilinke99@qq.com>
Cc: xujianhao01@gmail.com, Roopa Prabhu <roopa@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_616D84217798828E5D1021857C528B713406@qq.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <tencent_616D84217798828E5D1021857C528B713406@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/24 13:53, linke li wrote:
> In br_fill_forward_path(), f->dst is checked not to be NULL, then
> immediately read using READ_ONCE and checked again. The first check is
> useless, so this patch aims to remove the redundant check of f->dst.
> 
> Signed-off-by: linke li <lilinke99@qq.com>
> ---
>   net/bridge/br_device.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
> index 65cee0ad3c1b..ae33b30ff87c 100644
> --- a/net/bridge/br_device.c
> +++ b/net/bridge/br_device.c
> @@ -405,7 +405,7 @@ static int br_fill_forward_path(struct net_device_path_ctx *ctx,
>   	br_vlan_fill_forward_path_pvid(br, ctx, path);
>   
>   	f = br_fdb_find_rcu(br, ctx->daddr, path->bridge.vlan_id);
> -	if (!f || !f->dst)
> +	if (!f)
>   		return -1;
>   
>   	dst = READ_ONCE(f->dst);

This patch should target net-next (PATCH net-next in subject).
Other than that the patch seems fine.

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

