Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494ED745D6
	for <bridge@lists.linux.dev>; Fri, 19 Apr 2024 09:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713518736; cv=none; b=YFinzAoCDf3sJF+mDCSYNcHhZ8VQ2ibLpPabr+93BPb7H3cZz+y+Obg/ji2q9AIQKDX4YbrAA/nMNKRgJQ4oSNzTe6MGBUA0osbuA3MqJYiZY8D+HJMSoo0gF3iKkdS6rwTsjB0gUku2JdH3nCRKxi1fDYk6ul2FD/ZASZK/21I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713518736; c=relaxed/simple;
	bh=lwfbCBDs1tEwbE1UZPUD88YzNGmP7APawOKjZXevzwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NCyvmzXSih6uNvBHsNcCKJKt5X8vP/c0iWOMkSDjQj3gi8q4HVO9Osbh9nC2LU/E18atjFLASX8PReE2MnFFToxerHEZ0KOUE+r7lggcpNjT/irJUFnYdZ2PtGUhRFmICuiwwDy6LBt+c8juEs+s6082k9fQNAw0UGbsPbgi0Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=OsrpTevL; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="OsrpTevL"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-571bddddbc2so1407645a12.1
        for <bridge@lists.linux.dev>; Fri, 19 Apr 2024 02:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1713518732; x=1714123532; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uwf2npPrMEmhMxrv7/NTurvJ8uTzmGNrt6EeJbqzv9U=;
        b=OsrpTevLC4MNYsa0eP50AC0+sfWbR6c8HensnPzMdIbEEfWvuxWnUHA3lvS61PiCVE
         1OcwkJrdMbVNCXTgyVK8Z/pS8EZRsDUf/HwYyXdBjKiL5qv2BA+NB3LLcsnjR/ow4rrg
         iHBTBoS0lso9JpwwNCAxYWrhFQxo0jPISoTFjr86k7XbRyuwRIxZr9dkciv3RmHj6vom
         +jNvVuul8KCoHuA46aNHEfNkmqKdq9Vd7f//cS832/0viCAXKzbI2fCoVkeXpLaQG+hZ
         URBQNHnm5czwCXpqMZBN0yycEKWt+mqLI4JmZXXQUb9HZsjcYc19n2r9kKcbybv08Rgw
         z43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713518732; x=1714123532;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uwf2npPrMEmhMxrv7/NTurvJ8uTzmGNrt6EeJbqzv9U=;
        b=Jne21kpnTjkdJQoAKBr4hOOS6+lLaR2rPJvpWJvRqUggSI2qiZbMdS1aHKrxOqyb1K
         ae16IFnOiJwqficDivkjrvqIEUDf/VkmcL4kycfvu2gciB73FsGQTKkHOqn1/blKstXQ
         gXn8r1NtFvhqNKkDbM2xclPUGp9IV3aKP1sWSpd3J6PHECGWvumXRy6QtMJAwMe9m9i0
         TfNVrWZIdbio4T1FEWKe1IoD9lrDnN1c1vQytJrOjYyY54c3WuZ91Na+ITPDW6sgBH2G
         BDVdwLZIga4FjqNamVEbLu4qsjRXFfeikrCFIFRHx8ELibHFqaBfBZxLosi+6qzeWbLj
         9RrA==
X-Forwarded-Encrypted: i=1; AJvYcCVubmcyjlTEnhExzaJyJmNh6OkBloDYI7NxQHy0uzQaaGBWrOlAGdirzx4HnyQRW49wQ27tQdlscUCxQpSp/Pu/1WNLIiw9
X-Gm-Message-State: AOJu0YyVo6S250sffg1weGy1fSMKGdjEJfGu1cF31R7aR0w1CmV68hJv
	cm3EIvZ6xlLH6pMbXPC18bVQYH1ytRAKu6zUwmeisihmzmd0vbm5l6hbQC8xKa0=
X-Google-Smtp-Source: AGHT+IEl3rvlq6QmdmVaDorfQOCxAXtCAgbkDlD27c2AQSzMAYnN5ZI4Sw4Kv8LA4OlLhHlCmYxBjw==
X-Received: by 2002:a50:9508:0:b0:568:b622:f225 with SMTP id u8-20020a509508000000b00568b622f225mr1041542eda.30.1713518732359;
        Fri, 19 Apr 2024 02:25:32 -0700 (PDT)
Received: from [192.168.0.106] (176.111.184.242.kyiv.volia.net. [176.111.184.242])
        by smtp.gmail.com with ESMTPSA id fi5-20020a056402550500b0056e598155fasm1875341edb.64.2024.04.19.02.25.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 02:25:31 -0700 (PDT)
Message-ID: <441dd6a4-281f-4223-ba96-8767cc902e7f@blackwall.org>
Date: Fri, 19 Apr 2024 12:25:30 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bridge/br_netlink.c: no need to return void function
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 Henrik Bjoernlund <henrik.bjoernlund@microchip.com>, bridge@lists.linux.dev
References: <20240419080200.3531134-1-liuhangbin@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240419080200.3531134-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/19/24 11:02, Hangbin Liu wrote:
> br_info_notify is a void function. There is no need to return.
> 
> Fixes: b6d0425b816e ("bridge: cfm: Netlink Notifications.")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>   net/bridge/br_netlink.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 2cf4fc756263..f17dbac7d828 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -667,7 +667,7 @@ void br_ifinfo_notify(int event, const struct net_bridge *br,
>   {
>   	u32 filter = RTEXT_FILTER_BRVLAN_COMPRESSED;
>   
> -	return br_info_notify(event, br, port, filter);
> +	br_info_notify(event, br, port, filter);
>   }
>   
>   /*

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
