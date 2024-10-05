Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBFB1DFE1
	for <bridge@lists.linux.dev>; Sat,  5 Oct 2024 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728137221; cv=none; b=JcFqjNykiH7F1mzaozg2PjTRxixZzwYpTz1SBC0HjDS6Q5+Fy2HrfvQ0mkznshfQEcD044bQ0ogV0S0GlWMYdmJpI9P2OvxxTfW/TaDX6xO8vjMmIPEuPP1CLthYoxivpIqVpe/q4KkQYdLzjJcN3zVH0OKWGmq3B7Pf0HhASMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728137221; c=relaxed/simple;
	bh=w7hv67Bv4jGJL1OIuMDm5zDOxYIxf51jzM1/fXgu7r8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=flSLFoHjOi5YBgWU6fbVv+JGraVgBVfrGA/QdRiS2goZNjobVZWZx5/Q4zLG45WBctvMnnG3YTsyQ7t5irVylPKOfa1MNzTwwhacwyMcr+KEWnhSwJ0Jcx6zrF3f7k0Pp0PoMz8yvdTEl+Z7B3XPHtsAnSJKsfuxwwcXwtpEGig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=v/4gnk5l; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="v/4gnk5l"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37cd0b5515fso1819786f8f.2
        for <bridge@lists.linux.dev>; Sat, 05 Oct 2024 07:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1728137218; x=1728742018; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=73RXbNvNBQEszJaut+1wcFfhljNaK/Kf2dgm13KEtRw=;
        b=v/4gnk5lq+jpixTxCFjqiwMgWB6n5o4Pvj0UZQB0cai4Hcwgr2zkQPbKFFVZQpanIi
         1GD5J23fmCI6/6ElyibKTklPIaG3aDaaPWzMieVTbOdMrtadvOO3CkUiKKcyLS1SBM1F
         xVt4E5WeNnqZ/3MlnqcITTYDjWdtNXEEbluDcQ6zCPr2FagEWI7YeFMtCtxj+Ym/742q
         dVOHU1A6jEAIE8VD0HDMtFOkCzisPhFElca+3hORUu5gDyWHmf6YXkyUtkF/LXQl9wWt
         WjI5b0D4wXnc0MdjUgCaDWjl/shnaKOs3xZKHb7CD2CBVPgXh+GH/a/x5uzNsMoTlUmI
         bcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728137218; x=1728742018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=73RXbNvNBQEszJaut+1wcFfhljNaK/Kf2dgm13KEtRw=;
        b=o59daF6fLA4o+dPhprIvBVKfeiGZKgSMyBzS3GrhEXyuZ0bXYUwfjzQhDS0clcSZo2
         ywsRxZo4S2yaJQNI8zChfvRQvURfGiUpPIURdW2zGllNpu05N5beZYwrCIs1Ra1qFrTj
         p9vPEDoVrnQiFfPOShglafaD6RCw5ge/dYJLWKU1JNfiIUBnmVXyalHU0uQ9L+BoqAz1
         lFp85xrl1/ly6ckUSZTDw2zt5wNAiLKxQKJF8eINalEiiW12QtpDRItYIN+Q3u8kyHiM
         dI95vLlPjTHVILeYgb61yVSw9i9JnatUfKlKpT2oeTscX1GZcw5wyqCPIACM99POHbVq
         jH5g==
X-Forwarded-Encrypted: i=1; AJvYcCVubf+K0F1N8vekzItqzyFiMDk5wphrqzk1hMTusGoA+RguCFPo9/MwCqQ/J+Bchy3UaYgLAwg=@lists.linux.dev
X-Gm-Message-State: AOJu0Yya9V+mFiPsSMcI7fMFhx9ZKBrrwnYza1d4ORFvJUSfTaQCKjwD
	alPnv6OuXIEk6S6TF+s1XOkn9vva6QTSih6Z+iW12fr0D+y1kvz6Ui18zrKuTBw=
X-Google-Smtp-Source: AGHT+IEop7QV/LQ0/ci7yuPRtnBcGOvevIn7tuDVlQ8/zdMwhtTaLfoE32mNc8E+fIIZYTUwqHvxHg==
X-Received: by 2002:a5d:510e:0:b0:374:af19:7992 with SMTP id ffacd0b85a97d-37d0e6f361bmr3281936f8f.7.1728137217667;
        Sat, 05 Oct 2024 07:06:57 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d16920cc7sm1838947f8f.61.2024.10.05.07.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 07:06:57 -0700 (PDT)
Message-ID: <c06d9227-dcac-4131-9c2d-83dace086a5d@blackwall.org>
Date: Sat, 5 Oct 2024 17:06:56 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bridge: use promisc arg instead of skb flags
To: Amedeo Baragiola <ingamedeo@gmail.com>
Cc: Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Pablo Neira Ayuso <pablo@netfilter.org>
References: <20241005014514.1541240-1-ingamedeo@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241005014514.1541240-1-ingamedeo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/10/2024 04:44, Amedeo Baragiola wrote:
> Since commit 751de2012eaf ("netfilter: br_netfilter: skip conntrack input hook for promisc packets")
> a second argument (promisc) has been added to br_pass_frame_up which
> represents whether the interface is in promiscuous mode. However,
> internally - in one remaining case - br_pass_frame_up checks the device
> flags derived from skb instead of the argument being passed in.
> This one-line changes addresses this inconsistency.
> 
> Signed-off-by: Amedeo Baragiola <ingamedeo@gmail.com>
> ---
>  net/bridge/br_input.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index ceaa5a89b947..156c18f42fa3 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -50,8 +50,7 @@ static int br_pass_frame_up(struct sk_buff *skb, bool promisc)
>  	 * packet is allowed except in promisc mode when someone
>  	 * may be running packet capture.
>  	 */
> -	if (!(brdev->flags & IFF_PROMISC) &&
> -	    !br_allowed_egress(vg, skb)) {
> +	if (!promisc && !br_allowed_egress(vg, skb)) {
>  		kfree_skb(skb);
>  		return NET_RX_DROP;
>  	}

This is subtle, but it does change behaviour when a BR_FDB_LOCAL dst
is found it will always drop the traffic after this patch (w/ promisc) if it
doesn't pass br_allowed_egress(). It would've been allowed before, but current
situation does make the patch promisc bit inconsistent, i.e. we get
there because of BR_FDB_LOCAL regardless of the promisc flag. 

Because we can have a BR_FDB_LOCAL dst and still pass up such skb because of
the flag instead of local_rcv (see br_br_handle_frame_finish()).

CCing also Pablo for a second pair of eyes and as the original patch
author. :)

Pablo WDYT?

Just FYI we definitely want to see all traffic if promisc is set, so
this patch is a no-go.

Cheers,
 Nik
