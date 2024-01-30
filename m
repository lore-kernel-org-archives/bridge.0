Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D7E59161
	for <bridge@lists.linux.dev>; Tue, 30 Jan 2024 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706606957; cv=none; b=MJGIGWb7P5bN/L70QldrPAJ1pMPLt5LD4VtiMvDPImnZPOoCojXRIU7sjqxbS7vviZq4TxKSmw42r0fR2fG4AC5jIiZkxe3MZ+NLqMuZvrRJGMtsFLFle0fWDbehtbDG7PkD2zLmtZVgyq5Ncsl4eAOeBpDCprlccS6+Qpq7P38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706606957; c=relaxed/simple;
	bh=g7/Tw40iurYfKeZa/xZvbogA0Dz7AsysUvBEQywxNgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yw3sEOAE7Aa4SAWSfzV2rOeq2z3RNFaIMiAba9C504c9KOdn2Na0rrJpQXhHQyLhmzU3rjKa8UQT4rDLMEGVswpFHooLHFdReKHKsvrxpQkCWD0fV0MVYqikX81HEb53xp/mFWLByD4rpza/qE7kOzll8GmbOfG9S/U78XGOnWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=n+QXerXI; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="n+QXerXI"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cf4fafa386so40179241fa.1
        for <bridge@lists.linux.dev>; Tue, 30 Jan 2024 01:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1706606953; x=1707211753; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CvgkqrVhgwAp9eomtc6oUrzhXKUHKI4dKXoGY8fDTwo=;
        b=n+QXerXIX6zSa65FDHINq8gsW2P1QXwk5mV8cNeE+XmgsvSg0w6lKTxOfbvbYVf/aX
         756IohvRSydlrhV4Nftyio0RWyRS5ZNxRFBkglrLlNX5Gq9h28dzX+NBHGmUD6JkCT3C
         +HCJz22r7vQ9m2QA8rOLQjZzGs2xc86AqQ78Wn98t457qCdWAT4HEi36BKi6wQGYQiLJ
         zkALQWdlImzQK5V2v/NeChXiEyCNOAPlLi7bN0rTSLNTsWPPnXWLcaECRF9/9dtW3cBb
         UMqN3sc/tV0Ku1CUa2YNF/dnY60FtGaUdRnAPgfV0OxwxinTmH5PUaaIh+r56zBapeA5
         xerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706606953; x=1707211753;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CvgkqrVhgwAp9eomtc6oUrzhXKUHKI4dKXoGY8fDTwo=;
        b=Fsdz325fEpfkZvXxxDGa+8EpLAkKR7K8OunyephW8d3Pn3FlGp8c7cBg7LPpOAfTQ9
         Nwu2+JwAIJEG7jKpK3PPxHhTz2kyODZzvVf4I0Pf1PUfPeB35yVyGDY9+JPg7IOdYwTi
         TpoyGc9zd9oQh23OxY5tBM+f6sdKhfBzqH+HSCaD1nu9uohR/C69fnJtqwwE+zEQZEGH
         +tzOaSJ8bErz3Q0+PukQcWvrdldO7sqtsQQsuH8ux7er+hG1Wt4tMXFcNU/T6Kt5vHUw
         hVQQU8mdAebeFTKnWtKCtVWkgJLAYUtnEBdh5Sm1D/RI8goRNIjWY7I+FgtXMKKGxW+V
         EBFQ==
X-Gm-Message-State: AOJu0YwntkhGoe1OgMRP420lIjs2JnaJPlASGbhQZIO7LbPi1zWmvorS
	hrgBAMtlM9MP7tV3Lg+CW1EMFJQP2ig9hqarWNLOvBk5ugi7LV9TOfnocdLaguNBBkpMgdhcoA9
	d
X-Google-Smtp-Source: AGHT+IFKOierXNs5R8QtY/OftsfX1IkVkKVPMFcsF71RjOLl9Nbv1Fck3f+sLCr3SUy88diadJDN8Q==
X-Received: by 2002:a05:6512:34d2:b0:50e:af9d:9b1 with SMTP id w18-20020a05651234d200b0050eaf9d09b1mr4522166lfr.14.1706606952959;
        Tue, 30 Jan 2024 01:29:12 -0800 (PST)
Received: from [192.168.0.161] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id u16-20020a05600c19d000b0040e4733aecbsm12370438wmq.15.2024.01.30.01.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 01:29:12 -0800 (PST)
Message-ID: <4c073b12-c1b7-44fd-8f46-d901a4cd403c@blackwall.org>
Date: Tue, 30 Jan 2024 11:29:11 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: bridge: Use KMEM_CACHE instead of
 kmem_cache_create
Content-Language: en-US
To: Kunwu Chan <chentao@kylinos.cn>, roopa@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240130092536.73623-1-chentao@kylinos.cn>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240130092536.73623-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/01/2024 11:25, Kunwu Chan wrote:
> commit 0a31bd5f2bbb ("KMEM_CACHE(): simplify slab cache creation")
> introduces a new macro.
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  net/bridge/br_fdb.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index c622de5eccd0..c77591e63841 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -35,10 +35,7 @@ static struct kmem_cache *br_fdb_cache __read_mostly;
>  
>  int __init br_fdb_init(void)
>  {
> -	br_fdb_cache = kmem_cache_create("bridge_fdb_cache",
> -					 sizeof(struct net_bridge_fdb_entry),
> -					 0,
> -					 SLAB_HWCACHE_ALIGN, NULL);
> +	br_fdb_cache = KMEM_CACHE(net_bridge_fdb_entry, SLAB_HWCACHE_ALIGN);
>  	if (!br_fdb_cache)
>  		return -ENOMEM;
>  

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

