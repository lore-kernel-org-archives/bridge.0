Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD2C134C3
	for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 10:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="MziSFiNb"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2BFDF40525
	for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 10:08:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2BFDF40525
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=MziSFiNb
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PAmGdZfLWMVE for <bridge@lists.linux-foundation.org>;
	Mon, 18 Dec 2023 10:08:38 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B8B1640128
	for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 10:08:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B8B1640128
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40c3ca9472dso31980605e9.2
        for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 02:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1702894115; x=1703498915; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uo/CHEd7dbzAEsS6JzfIDLPp9KiSxgXCjh4CRPBuAoo=;
        b=MziSFiNbECB26ZMjckbgRxkxOV+G/nF5MQV03ihNaolj2ueNs4DNVYVYZZBHYXWmhr
         GtSUAWT7YrWfP165pZTpwaYB6vpPitk+XVBopBttqWBhLTc4r44qfOVl1pVwRCBw20BI
         f3RKQLDHFfL0jLfPZpR9mN74fkfSgkg0oaQQLhuzLYzkK7p/CAFVqF9z9Rlh8HuHY6pc
         4QJX6a3M3CmCeLXWk6Cuqzpsk74c3zbXZijwAY/Ns3fnk61/qzs2o7str49nlYymkwtT
         N5zdeJF1ueKlHOi+1XvUPt9MJ7cRJhDTjnBFIp0qta1QIQlcdE4M4+iVnYo3pfzlYnXu
         L/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702894115; x=1703498915;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uo/CHEd7dbzAEsS6JzfIDLPp9KiSxgXCjh4CRPBuAoo=;
        b=XewekqdU8QSsm9H16A+Gih27WVD15IzQFJ7Di3XtRL5jAyMEfTDbEJnJieveSH9D4g
         6PzMQBYEzS27GlpBK+leVpvlNuHvX16/B7G3GL3t3kLRcfIFf0dP0FgQ5kCoxZCIFhcZ
         uZPL4LKxX7VLFNRYFMjbVbwGId+NeXwVy1QuPtOYSuKJ/YC9ZIynS73p4FsbceG9RNEd
         OdkJhgpdbaeR+IknOxoVr6VgA+U3mtcc1p6Hf44KpQbCwHMQn6Tce07y4LU1Vn2lPWok
         AhMK/sNyZ7v+LbT7G+ntT1Hy2+MDRHzqCKCiLqt9cw3fQ4sGvavXDRgmLmZThD76SpnY
         cVJQ==
X-Gm-Message-State: AOJu0YytZeHrAJ3Km5F+Hwi5DRUYBnUUNQw14d9RJ6Zk+08nyZsWAs0p
	hheiCWozb/msUyzsgHK0vqjh5g==
X-Google-Smtp-Source: AGHT+IHvNnO42mHLGvMXQ+SK7wM9O1aTKi43hk6h9sA8X/KxulNmawscwowIEzqbAcBgv3iTqUA57w==
X-Received: by 2002:a05:600c:244:b0:40c:2b4c:623f with SMTP id 4-20020a05600c024400b0040c2b4c623fmr5281222wmj.82.1702894115690;
        Mon, 18 Dec 2023 02:08:35 -0800 (PST)
Received: from [192.168.51.243] ([78.128.78.220])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05600c3d8800b0040c43be2e52sm33818365wmb.40.2023.12.18.02.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 02:08:35 -0800 (PST)
Message-ID: <b6e0e7b2-4e94-434b-add5-4e05eddeecc4@blackwall.org>
Date: Mon, 18 Dec 2023 12:08:34 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/9] rtnetlink: bridge: Use a different policy
 for MDB bulk delete
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, roopa@nvidia.com, petrm@nvidia.com
References: <20231217083244.4076193-1-idosch@nvidia.com>
 <20231217083244.4076193-3-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231217083244.4076193-3-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/12/2023 10:32, Ido Schimmel wrote:
> For MDB bulk delete we will need to validate 'MDBA_SET_ENTRY'
> differently compared to regular delete. Specifically, allow the ifindex
> to be zero (in case not filtering on bridge port) and force the address
> to be zero as bulk delete based on address is not supported.
> 
> Do that by introducing a new policy and choosing the correct policy
> based on the presence of the 'NLM_F_BULK' flag in the netlink message
> header. Use nlmsg_parse() for strict validation.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---
>   net/core/rtnetlink.c | 51 ++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 49 insertions(+), 2 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


