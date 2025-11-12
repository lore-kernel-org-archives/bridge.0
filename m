Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A5F311951
	for <bridge@lists.linux.dev>; Wed, 12 Nov 2025 16:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963530; cv=none; b=VYte2u2J3Hoq0gOTuRVRW/bzEzwB5cj1wMImt44nbIhq4f6kksiXQy2i0x376I8wZNFwYvITTQS8XJdnp1F0PawXC0fUQWnvut34Buh+EG37M+7gESiFa6McayDd3jpgQ08lqXhqbM+c/M+YbFtJfs5qlsXMrnFZRbSKLbNLSA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963530; c=relaxed/simple;
	bh=o5Etr4QyEANsi+uSj2hcDtBvgqOSXbzR6waEVZNQKYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j1bIsLqfKpggkYB9gH6rdD6l8n4vp8OwtwkL3PcwY95jiVMNItznGrpnssFUb5WaVbBTv25tV8XxvxkiTpDhukKURoj434vreQYp+sFmAWNhwXl5ODysvkwv8zB6vUJsfMKhCm2q7oofk+Jsff+TNJEDMZOMlbBy0PGwUNaKUC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=hS67Q6GK; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="hS67Q6GK"
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-64312565c10so1487858a12.2
        for <bridge@lists.linux.dev>; Wed, 12 Nov 2025 08:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1762963527; x=1763568327; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8TjFbCBmI/k3Z2w97FG46OTUJ7HqHouhy0cGCZ1UQn0=;
        b=hS67Q6GKHxxh7od4YRzm9NP4Y94H2NUuJgm7xH/4lpk17CkTpzNzIVSqOc8Yl8qcxY
         HYOA+c1dqyhE0s3x0eM9kQ5hj4BXg0fU15oEdkoTaYDoVVRXfzoHfr+oqgO2gGKIVwBR
         8xjuwuGe6XfrnxiOzr5oBO/nc/TLdce0+JZ1mmE743S+Wo5I8k+IWp/dOhylFKM5PEgk
         6K4y1gopUO9kME1ZhSKTFoHT1vhB3G8Bdfj5DP97gTLXn8uocD3Vmq8yTXHUBpVciD0+
         bY5rsOnLVJIwpUyTV7N3imWXLnrbTa4yFXYV1h3zIw3LIspr0EvntUNqAa+TtU77s6NR
         3XAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762963527; x=1763568327;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8TjFbCBmI/k3Z2w97FG46OTUJ7HqHouhy0cGCZ1UQn0=;
        b=tAQzo26ywyDjXUioJSk/XJzS2/Ya3YUdsjkDrSbeUD4qqMNmt6skfyh6BiJiEF0Qnw
         ceXQ0a/TeHIcBvsR8Ga2N5q07ArYsQiFYU0DfApVivqYuFx+gkMrZVisBdjrnbzR7gr5
         6CSX+mHmmXFplcMbX4ubhoBgiC6ENXW7yCSgpzlamWoNqWxqKwFEjYHIzjxV1dGJS95V
         X++t/cJ2dU2F6ELZ2dhABDefnRNoiBR9b0Gry+x+HQy5Ruebk9TC0bFBLNvFvTVS2K0y
         PWo/z1bz3WbP0PohIkr8fVW8ybhRiJNUi7U8Qq1YIAE9fbYSF11m0QXg9ylfFF+OY5kW
         wTlQ==
X-Gm-Message-State: AOJu0YzDEhdmrqNnWFT2X/zS9t1DkolwGMVUq9JkHxRuyhCCKL3h9ZVa
	fWNwVAIhAku6nae4PXs0iNLnxbR4+uqF7sEQAT32idd/eDOVqVJCI3DjdiIDUwH1uhMVmd4Qntm
	MP6+TC67Gej8S
X-Gm-Gg: ASbGncub16dMbIb8fGbqiv1wGmL3HmfXGFTjcKY7lTjCrKIx/uUft0PzsxJ1errnDdU
	jmUHJIPMtmleApUy2Rdz8BNgjTdaWaenteTzXeuZHl/u+bgtVYhIKjdFHjSkMeG5Bgmez0KxxFi
	MAb2BFHqv/JEb5biwxQ9K6sAQiHVFxxzG5DZH27DTIsJZU0671dGmmLVvPzhvnp7lUOew5G4x+i
	CPzCk+OWdM6JR3AX+51JI+v3yg4S5Yfo2/s9OMBNsFGmlnJrBWbRHiNVt52zZ3CyUu6sYO+WwhU
	Yk9p2xoEigjBpZKtOy7E/3ieDx9LvR50U4cAlfIsiAJM7k8H4wKDsvIvZbeQhI1//R6ze4uu9YS
	eOHIGCYAbZ0UYVY3q0NyH9wgvYeZyodtapxkgQ+e3qN33RN2YhgvaZzRuSpFxGH9xYixs+QSjiM
	GhWbKYpbAUDxGjpbDWvc1yTTNnL1xEU+s=
X-Google-Smtp-Source: AGHT+IGiInT7YZn/VKAAXo7YOv6njihsj9H4CmvrBEePVzXhQRgHQj6UC9y762MvDu/WctUaVNIFZw==
X-Received: by 2002:a05:6402:2753:b0:643:e03:db04 with SMTP id 4fb4d7f45d1cf-6431a4b4dbdmr3119267a12.14.1762963526653;
        Wed, 12 Nov 2025 08:05:26 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64166d06531sm10598424a12.27.2025.11.12.08.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 08:05:25 -0800 (PST)
Message-ID: <2125fef4-12e4-43c6-9577-42822151c7a7@blackwall.org>
Date: Wed, 12 Nov 2025 18:05:24 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Remove eth bridge website
To: Baruch Siach <baruch@tkos.co.il>, Ido Schimmel <idosch@nvidia.com>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org
References: <0a32aaf7fa4473e7574f7327480e8fbc4fef2741.1762946223.git.baruch@tkos.co.il>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <0a32aaf7fa4473e7574f7327480e8fbc4fef2741.1762946223.git.baruch@tkos.co.il>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/11/2025 13:17, Baruch Siach wrote:
> Ethernet bridge website URL shows "This page isn’t available".
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>   MAINTAINERS | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f0c8b85baa6b..c79c182aab41 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9264,7 +9264,6 @@ M:	Ido Schimmel <idosch@nvidia.com>
>   L:	bridge@lists.linux.dev
>   L:	netdev@vger.kernel.org
>   S:	Maintained
> -W:	http://www.linuxfoundation.org/en/Net:Bridge
>   F:	include/linux/if_bridge.h
>   F:	include/uapi/linux/if_bridge.h
>   F:	include/linux/netfilter_bridge/

I agree with Ido, the correct link is very outdated and it's better to
just remove it.

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

