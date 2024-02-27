Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32C53D988
	for <bridge@lists.linux.dev>; Tue, 27 Feb 2024 19:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709060527; cv=none; b=nfu66lKc6BH/b5bMj+BWQSwCfRr5eI1BjWFxUh6Q3Zj51fLs8+gnesazr3r/DMg9di1f6bxfw+sV2F3COvrLO1aO3GzUzJWxYtfQkRv2rpPFdbgPD87X8JEKa8mrF+j1whf7oQV1Irj4NWQcYB2/zpHvbh8iBJeb5PZYhm504eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709060527; c=relaxed/simple;
	bh=N5TI/RT7tSbHAzXpAE0y0CqGtG2+EVcPfWJWRQP7swc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TqGAI/K/NdzsPdWNLrmKN903cQIpGZTBb1v0+FNtI/XSNPhnVmODyhArjI567uwFMwrvj0tQiwGow2XeuT79u7Nr/db+Q1QMw4uRUIFNVkV8oqHm0HYENRwc9wDxooLR9J5g/USguWQYiO6x3bF9kqobC1d97tNaWNVzSa1/P5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=vYrxQSeI; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="vYrxQSeI"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3122b70439so582545066b.3
        for <bridge@lists.linux.dev>; Tue, 27 Feb 2024 11:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1709060523; x=1709665323; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m1q+1nHGeN9JstdRCnM0oUNgt0RBGVjhiHcZGWKHHuo=;
        b=vYrxQSeIYM/ZDs2ErtbVWibd+dUlggkj7SlAiWwWSFBnl9NAjOuzbYdo8bmyqMELmb
         ZKbw4zTsGl9jHX57WIOO/WQVoPoy4UHXChQOPzbIO5xE96DGAEsRPYzfTsbtFkSt9FTI
         L3bRVoBo7jVukFdadgi9wnk+gXD0UApmJfQI71IHokOHsy8qmXcNpIEf7jw14dVsntIg
         L8c7OceOZvxJJhwD0lcVTdlNWC/3DMWN6ObPdxwd+MgBaFdLPoSmbqa/YLzCwo+f42To
         cNfhH2Ry0VzQlYdkKrHaWvguUX2V2jsHX8C7mD4B2+HfaFjHAl8j8PRvmRY/jynBJLBI
         B5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709060523; x=1709665323;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m1q+1nHGeN9JstdRCnM0oUNgt0RBGVjhiHcZGWKHHuo=;
        b=HQ3ARN4KrSjxU4Mue/RXOoro4yntXwcXX3fF7WxhIMFhADDgh4HcLjgbQaAdkfWNcn
         cuyBVx0BEjt9T+VSkmEpIf2JkNPJt38hsC4mzAaGyNh9J3X7fWYUHzW/TLUMxtMXkSfn
         82u9m0EhyVIEm9SInzM0CstrYmOKWNwWZ31gH4nQdlBiuSvXebk/fmvVvlJE8TiV2+0/
         zvvH4k90WkYkzjohmHSjmaAG2V6efVlVARiD3TOKzrKZKnRgzMRCaJAPXGTIWQ8aLGkh
         WRbn41oSDkP5uopXZcB6tjnHCHx6FGpBlZtPncDA08al0Ejdt8uIPuYz48huQVP5p+ij
         8OCg==
X-Forwarded-Encrypted: i=1; AJvYcCVCe7ttTfRAfrF7aNpxoAw1s3iFdsnZLwXHt7+QJ2w8nw0gI2U6MRUs05SzhzVToYExzJMepsWlW56RWP44vgjPFJWpiw/r
X-Gm-Message-State: AOJu0YyosTfapT3li098/4wygmHawZXHBd12uhRu0xf7bGUTeHDot8Bn
	pwISqq+Q7ogVL8ZdqyMEy3wjpgeQm1233djeFp1f/wDKmvC+sjFnlz2JJovHDx4=
X-Google-Smtp-Source: AGHT+IE1XNkbUpSjMjOpcuNNOXVkGSXvQ7nVK4Av1jceNHUmxdsvrz5REIHtRQD4V8RvdGQwkhuNgQ==
X-Received: by 2002:a17:906:a38b:b0:a3f:721f:a7ac with SMTP id k11-20020a170906a38b00b00a3f721fa7acmr7129987ejz.45.1709060523141;
        Tue, 27 Feb 2024 11:02:03 -0800 (PST)
Received: from [192.168.0.106] (176.111.183.96.kyiv.volia.net. [176.111.183.96])
        by smtp.gmail.com with ESMTPSA id rf20-20020a1709076a1400b00a43e6c2e107sm91703ejc.189.2024.02.27.11.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 11:02:02 -0800 (PST)
Message-ID: <a7d6e651-998a-4996-9b03-40d95edc84b5@blackwall.org>
Date: Tue, 27 Feb 2024 21:02:01 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: bridge: Do not allocate stats in the
 driver
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, Roopa Prabhu <roopa@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 "open list:ETHERNET BRIDGE" <bridge@lists.linux.dev>
References: <20240227182338.2739884-1-leitao@debian.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240227182338.2739884-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 20:23, Breno Leitao wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core
> instead of this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> Remove the allocation in the bridge driver and leverage the network
> core allocation.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>   net/bridge/br_device.c | 13 ++-----------
>   1 file changed, 2 insertions(+), 11 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

