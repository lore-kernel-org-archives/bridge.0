Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2A939B4A6
	for <bridge@lists.linux.dev>; Wed, 29 Apr 2026 09:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777453452; cv=none; b=rmr/TpoeS/rhePsS+ZjUftw2Nvaa8R0EORsy1csbVO0WS1Q+kh9MxpRy37yVqSt8+5pIlv96/6/4z3DyjHK0oy0UmOwqizlTG/t1ckM2ra+uoIoJUshuP+c913S5j0HyWsJa4CIQX+wt9QaiEnL2r7lT3AEp2zZNLQL2JwKyGeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777453452; c=relaxed/simple;
	bh=LJ5MyJOBQxjnHJBZCuWhdVRGlvLTXvOSKs7GWnM7aFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SslX+e+CAVUgJnbdqovbd6qofz7u+Px84nfWlDp4pd2ChsPUQaWhawGBJCfOREV2GMy0go95hsxbQtFK93vpknTgNFEwyRNBb1j2NK1NL8kwd2vLHlJ2U4xS+WQQ1GZyXTbESRJfMQiADnLPjbE87XOHPngHrbv8BRLS7TSjPDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=DjA/yQQM; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="DjA/yQQM"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso107389705e9.2
        for <bridge@lists.linux.dev>; Wed, 29 Apr 2026 02:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1777453448; x=1778058248; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EmuOh+kGeDXrP0yx3685UynvWNqrsYu6pdmhoYjK2d0=;
        b=DjA/yQQM6W8HD+19quz4waJB8EcR6kj/U1JJmw8ohB9oo7429gIujFonK85vguJY+Y
         jUx5i3rrpfHTOXguceUiqyBtupF6MJEmLiajYEF3qmTVyIHVBW0clzESvzjHHyzKl9UA
         jC1RfmSKpK3tf7pW7VPs0iWpSIw/d/Yhz1X8Pn8e9nMsrtdJIm0TXdMKkgIob8upqLcd
         IwWhOyV6tfsa3goqHfDPnv3RSEvF+V94iAiRCym6P1B1eHSYqiC8c2WuWXAhlpfdd2kz
         onFY4+y6bsCWwqhYzqcoUxfWUgm/imEaA5WhFpDiznyoM0Ho2/SJySQUvlfRI3xyimM3
         Cfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777453448; x=1778058248;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EmuOh+kGeDXrP0yx3685UynvWNqrsYu6pdmhoYjK2d0=;
        b=DUN6iyk3GKeVB+RNDnLLy4yjUjohy4QadS7W5UN+pmpeTjB1bPk58Yi7V+Z++KPUDp
         Rsh1b/x5Z8+UqIkCpNEHiA+sozYeHZT2b5grAGnKLIaTiMUnNUKFypcQdPTXdw7aHztl
         bH7pWZnrM9CT+WY20VPLdWTJIjhBP3M6a2xiKfegVVh/KU59mEGSr6Io8eD5wV0D9Zs0
         kb4pd/VGUubYSdSNXFZAJdoCMQLry3yGAdSw0x037pltYP1y33NV/HYhRe9pYLnRGN8o
         xJaBneoB7j2Ax6g4mFJVmM9YeUYcDxwU0wCjR9dooY7JyntMpcwRfbG+TE6+kbFwUybX
         qfsg==
X-Forwarded-Encrypted: i=1; AFNElJ8pro+MXzux9SNuoaAVbfuSf81jPZTP/8WtB5NPpJh6H8Wub7ENVPjZcS6G5aMoTGqT1hXUFZc=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz88EnoEXKokzayRUDbLDDZO6vI4HVDXEMK+tZxSjUYAuznK51+
	kR8948w0qfoj1x4l86sS4cVq6mSjD7yrgJiJ4Dpu3dDuCxvYoIUkGTzRRABAhawm+Lo=
X-Gm-Gg: AeBDiesOnyUsWeDAIL6fJWA7QaNUPKjuf5iXQhHXigQ2TmgxBQEHwPTkmxi2zalHnIR
	bfHIaf5WW8P3la/qRmDbRZjYHduj9rGWYcTmrZj3bglokGXrnueBh0RJUVJiq1cqbham6BpGdyG
	14cqRaf5bZIqpVZiOSXy+RvFYjBC+1jZ5818YWZ5cHzvS9akYrDcNpWygc4+4BHzadMQzm7oiza
	zwzjY2vjpn9Ak7Me//z02/I0n3PFhQeo4pdMV+Z/80CGs8gC8HtKRQx4IdEZ+ICM3BMgS4DytTy
	P49eUzMtzQYV6uxsS29gatcEA+5ZRX12B+8cmgdVXKEtMnPaCptgzGSg3d5QAKK4Wla9b/MyccJ
	6suNuW3vFNi+hpSxH64jf0M71WiiQOYsozleoLc9goTStWlT9biZ2W2esepQkOnMvfE5E3HTJG9
	tgItNDkCgegfa3TdnomKV+0cuyPNv2EHk+t8JXlWFGx1tzIKbYcw9kqC41uKw+CQ25
X-Received: by 2002:a05:600c:3505:b0:486:fb69:4960 with SMTP id 5b1f17b1804b1-48a77b12983mr102721605e9.19.1777453448112;
        Wed, 29 Apr 2026 02:04:08 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c30f856sm13683255e9.21.2026.04.29.02.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 02:04:07 -0700 (PDT)
Message-ID: <f30f3eae-ef39-4b95-b39a-b68aaad608d2@blackwall.org>
Date: Wed, 29 Apr 2026 12:04:04 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] bridge: Do not suppress ARP probes and DAD
 NS unconditionally
Content-Language: en-US, bg
To: Danielle Ratson <danieller@nvidia.com>, netdev@vger.kernel.org
Cc: idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 bridge@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260429062405.1386417-1-danieller@nvidia.com>
 <20260429062405.1386417-2-danieller@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260429062405.1386417-2-danieller@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/04/2026 09:24, Danielle Ratson wrote:
> When neighbor suppression is enabled on a VXLAN port, the bridge is
> expected to reply to ARP/NS messages on behalf of remote hosts when both
> FDB and neighbor entries exist. This allows the bridge to suppress
> flooding of these messages to the VXLAN overlay.
> 
> According to RFC 9161 ("Operational Aspects of Proxy ARP/ND in Ethernet
> Virtual Private Networks"):
> "A PE SHOULD reply to broadcast/multicast address resolution messages,
> i.e., ARP Requests, ARP probes, NS messages, as well as DAD NS messages.
> An ARP probe is an ARP Request constructed with an all-zero sender IP
> address that may be used by hosts for IPv4 Address Conflict Detection as
> specified in [RFC5227]".
> 
> However, the current implementation unconditionally suppresses ARP probes
> and DAD Neighbor Solicitations, which breaks Duplicate Address Detection
> (DAD) over EVPN.
> 
> For DAD to work correctly over the VXLAN fabric:
> - When the bridge does not know the answer:
>    flood the probe/DAD packet to allow remote VTEPs to respond.
> - When the bridge knows the answer:
>    reply to indicate the address is in use.
> 
> Fix by adjusting the early suppression checks to exclude ARP probes and
> DAD NS from unconditional suppression.
> 
> When replying to a DAD NS, br_nd_send() is adjusted to set the NA
> destination to the all-nodes multicast address (ff02::1) and clear the
> Solicited flag, in accordance with RFC 4861 section 7.2.4.
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> ---
>   net/bridge/br_arp_nd_proxy.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

