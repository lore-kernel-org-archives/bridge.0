Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0CA3CB56F
	for <bridge@lists.linux.dev>; Mon, 20 Jul 2026 09:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784538895; cv=none; b=fJouRlQAJRQGcn9r4Hlzh+Q+fBESu1qXss0TudROAuqNDWSOZs4PvPxG7fadgW1Oxw50TUAeDZL/UWSHQ9JZXdCpRCgrtRQpG61vKrAfqibl43717nfeJecfps22wETuC3POWBnhmwyES4h4tOpfhZ0lS/r0o04ikAJKwy8mjYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784538895; c=relaxed/simple;
	bh=n0cYgeO7AYelPNLANCH9y/hwheUejDo61R1XtpNA9/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y4rpO0PAXq4G/is6cKNzXxDJXwQAZ5gOYqx8WcvTPLitTRCuPtXeIi8KwAY7lvpuI3HDV2Y0J8OyTrj0+OPI77cs+Fa7w7ez7qkXFSNYZ8tndlf+nn8KHwY7s6yE+9NpVCRL40Fj5revT4feQdYukNcKgrdBX9hvuEUjTZPT2d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=YlzQ/Eun; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="YlzQ/Eun"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-476d8e647e9so8974428f8f.0
        for <bridge@lists.linux.dev>; Mon, 20 Jul 2026 02:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1784538892; x=1785143692; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qYe/cwTmtSYCyBAS9PJyu1+mCd/R/Mo9vdMOvvfakiE=;
        b=YlzQ/EunajX/T5x0l8tvy1UBYBR03x3qCxSyCp3IEAbLjQPm1UkGRccKtwKeKVTpQb
         NpgeF+JcP3+42RyVF4u5m4UEY2YoSja9kmX+wr55N15Wer8qsmLjOZHciTf7CQrhvtdX
         r3fPlOEhlqfsjEZd4+Ycb1GtBUNuwR6KXB0VYedssR6jThexGe1BHSLTotX9tQaYuNYA
         2yCCXUTQz/sdTKVsy6qyaX1ORffDa2GjRpXpesM/VEXPSb8ZltbHSM76qWsrp5oXVP7w
         8lZcAReVnVmJwWFZF4RvAjU6a2fpECZjFNnSxjW8gOIW2yqS6APlsgDnTAZHawnDBDsv
         hT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784538892; x=1785143692;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qYe/cwTmtSYCyBAS9PJyu1+mCd/R/Mo9vdMOvvfakiE=;
        b=hMoobJu2x4QQDEIeUhG1FtHaE0eVtbo/UVBdp/mnnOCXN6YhvRIXXU472kOXjCtrCT
         cXA5cwrzGt00YvKDMeQw8lfjyl54bb67qW5n2F37YHIzRwWTxJde8qTZEShI1VjYUIeo
         FBgHin7A9RTGuWhHf8cUsJeEiAHLiy/BANwOk7lV0lSxwj4dUbEri6isqQQth033WLpk
         bwniNf752/EtUqlEmPOAu5PqhIsqdwD5TRUdgm2XIIVtjA8PG/jEhsvCwhzIs6xZkSW0
         0mEQMH8SXud97pAiHbAB4Bx7NbgS+E8koCAontBrcmtWXMIbPnB/ytyPkJwv2ImJEdpI
         IZ2g==
X-Forwarded-Encrypted: i=1; AHgh+Rqn2i/d9U8+ChFnCARvocRIBbBVWwiOTYfhIrN89b2da4zQz8V5HpCW3W7AEffqAw2Arwu/Bok=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2EHMuL2qZn/AzDv8ZHoWbPooe1oJIYSC//2rnY4M57eerXpg+
	dAFtBHGf4Zbj0roQVARxbeszuvwCGcKiO/T/c+NqcnCjvPF09MMj1yM03gONDhtHX08=
X-Gm-Gg: AfdE7cldFWxOln8kS8aMza8KsnmxI/+Y99bUOEEbzuheA6n6bKJvNSeKR4KUN1QQiVP
	FFVsq4qtrLnexAejwUmrPN53sBj3TCLW+gySjvIsRMykoRsmd2OOB8XNIxM4VRPWolruDpYnard
	Y06fuGQLkdrEfJaVyjUkfdTL5ypPamBgBabGzxL5ju7orDz40PFQ9enf6zAz1tK4P33n7LpG5hX
	RVUZZaG2yhrYRxzRKpBcqRG2nc9sMv0T3AbdKx5N1gyaqlWA/d06974JzB8Cr5F1nCCpXf2AuYD
	zs+JlFAT1M0fXvM+uQhM5cxKA/2tRlaq+kEdS66840cLSRkdE3sjubfCMX5Ivjb+WrE6cQJ6ZW2
	gVrh+BkBOA2v/y8V8NtYK7vYAUSRH/k9/PpF+/8VK1ko679zDTn2yLgfj5KNDn5W0eXgHvBf8+F
	D4Wklk5OqhyWs31TWNjIsG0tr9Qh1KDDk3
X-Received: by 2002:a05:6000:4b01:b0:47d:ee9d:90c8 with SMTP id ffacd0b85a97d-47f6230659bmr16136823f8f.3.1784538892521;
        Mon, 20 Jul 2026 02:14:52 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f67466e09sm29580156f8f.21.2026.07.20.02.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 02:14:51 -0700 (PDT)
Message-ID: <78f42aa0-70fe-475a-ab2b-eff062a629db@blackwall.org>
Date: Mon, 20 Jul 2026 12:14:50 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/5] bridge: Validate NS/NA messages using
 ndisc_check_ns_na()
Content-Language: en-US, bg
To: Danielle Ratson <danieller@nvidia.com>, netdev@vger.kernel.org
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ja@ssi.bg, petrm@nvidia.com, fw@strlen.de, kuniyu@google.com,
 bridge@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1784463131.git.danieller@nvidia.com>
 <63efa708b4b0bd9edb3a6f6a521cb5022c43aaa5.1784463131.git.danieller@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <63efa708b4b0bd9edb3a6f6a521cb5022c43aaa5.1784463131.git.danieller@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/07/2026 16:34, Danielle Ratson wrote:
> The bridge performs neighbor suppression by snooping NS/NA messages, but
> previously only checked the ICMPv6 type and code. This leaves it open to
> acting on malformed or spoofed packets that any RFC-compliant node should
> reject.
> 
> Wire br_is_nd_neigh_msg() into the new ndisc_check_ns_na() helper, which
> enforces the full RFC 4861 section 7.1.1/7.1.2 receive validation:
> hop limit of 255, valid checksum, correct code, and type-specific rules
> (NS target not multicast; NA solicited flag clear for multicast
> destinations).
> 
> MLD messages are already validated by ipv6_mc_check_mld() before the
> bridge acts on them; this brings NS/NA to the same standard.
> 
> As a side effect, the skb parameter of br_is_nd_neigh_msg() changes from
> const to non-const, since ndisc_check_ns_na() may reallocate the skb head
> via pskb_may_pull() and sets the transport header. The returned pointer is
> now derived from skb_transport_header() rather than a direct cast.
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> ---
>   net/bridge/br_arp_nd_proxy.c | 11 ++++-------
>   net/bridge/br_private.h      |  2 +-
>   2 files changed, 5 insertions(+), 8 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

