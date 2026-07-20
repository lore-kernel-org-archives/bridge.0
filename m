Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6323B6344
	for <bridge@lists.linux.dev>; Mon, 20 Jul 2026 09:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784539638; cv=none; b=eX3GrQ5/axwrxHTkGKbOx6cb5rtNSLUfHwtiKwrIFNNBhCBnfApLvuWJun5pQW3ZA/SvoaJmO6hKSdZ9roT3/VYTM2/aB4j7JSlZXTGAzRh5O7eTseUSUEIWHTzNYDPXDErXEYwO9JAKPjmlPKk5MVNFhoxU2aHgtrMUAhk9FuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784539638; c=relaxed/simple;
	bh=HQMQFnSUXuBKeeJ97RIwrfO3zajoT/O4JZOcb4WgBqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e9NgZrgC2ue7iu7tngEVdp64kGfUEpx3KzXqgUZTlKYI1WJpxOd+GhsNky2iP+Bh8ehDWtdEzqG6NBci53YjrfF8ta+/N3KM/3CCzvr47NmeVTekMjlJirKdiCjzRXx/tgy7ByKV4/6xGC+oEtMUC7TJDWCCSlQLL3bv409/7PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=OuNn086f; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="OuNn086f"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47df43bfb07so2553972f8f.1
        for <bridge@lists.linux.dev>; Mon, 20 Jul 2026 02:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1784539631; x=1785144431; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y5AYMZaEUXhh4z8P8i95ra+KWHKRxofJ1kLmW4+NFQs=;
        b=OuNn086frVk3obSfPJz/qUL3XMGT0j2DM81C/RkFN5Mxtwl7Ro9bH7rAgdKe8BdHnt
         OvcCVrUWsmVOeOBDe4NPWssltIMIUp5pWwJU0p118xFAHqs34MK68m5rpQSqoP9DLiFP
         zH9OHUg776x8XbW5L8U41EEVY8mhCWC6FZ77nIx4kF/ZIAizBENdEcAlBSPTo7g8bAQJ
         ROS+HGIdRhdKe5ha6jkAcOxsM3lHiBFroYhcoGVuuWt31ID4Ecq40Etvp9H/HMgnFthN
         D6BsCr3n3omfeIUHShRRrC7W48EfgKEKItCg/Tg6gLjfvBebDh9Wh3lGNepDinIQaOCA
         3xuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784539631; x=1785144431;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y5AYMZaEUXhh4z8P8i95ra+KWHKRxofJ1kLmW4+NFQs=;
        b=ZPfo0uT76zewEfbTEpkyTmff52y/BLXZN9qgH6hn7QAEpebmT8IVvnn20ituunKOkB
         13pun2Pgon8/ymg9790ikbyG6P5prMpZ4NYIOcIHLfrzjXkaORiO2bsF/MhhOW/IDsLR
         F5vFpi/KhvzSIeqnI5qNw6fLxqQdDXKuv/anPgeIOKTRO0TCHlAbLKiHvxmSLm77tLjD
         wNXD4Zd5cvSo31CkOpy9MQpSnAp/oKOvjZPTStiNhF6wlAPBXMRQILO3c/6GY5ia2PE8
         mIxNWqOVbTVHJmOKpnstZN6XV/bUqpQOnE9QdU5Weo+EO8+e/TWwlMlFAvbMfQibISoN
         Z6xg==
X-Forwarded-Encrypted: i=1; AHgh+Rr6uPiSjo8k8AKl2Mb/VLGnRH/9GCESgiha983f0dC44/eD1SWtxkMlgN6w50gxLWCJwsG93gY=@lists.linux.dev
X-Gm-Message-State: AOJu0YwRO6hzIHoOKvuTy30zXs2tzglYs6smVmy8DDRTz7pEtjSiKQaH
	HFNUwxSnKR677WO0wr5n1HaGA2TY8YIXuGHNseGGdjYNpXoSX0vVefy5PKJgpLuYrfc=
X-Gm-Gg: AfdE7cmqpeaOcSvkFUqfqrsL5lxhi+KbRAfiiPUaaEpCNYE5646U6aA63HFQ3lkJ5k8
	1+eAzOIj6YJrIj5LOczZGJBunf2WQIHztb7a+BpyiOqdPlPU5nz2v5tGWczozXXns/PF3fYcgyc
	evefIuuA8WTpU32G49woO8NYId8lTm11/k2e/GnSyAkL8To3lJfO/pZZQbdX+SGaJp7/9uiNNQX
	kzLcbByKKzYWTuL37SLiZzExT+b8wh0R3Q5UAIpcOdn5xSdsFBBtTzMvV+iiWMB5OR5bt7+dhA5
	z0HAp13aVf5zIS3LPWpvIjK6DQEtSt5HW5dAit/mi8pMNCc4x1Fnso81bO0bpqk9S3E0pGtXUAg
	xpZ2G6IkDZzK8JaVXTKI87ko14iaVtUlpeFVAosIxGEbuW93w4WCEHbuzJuVV3jtJtR1480E9f3
	gstmnA6LckpuQT+FOQqcUW7Vij4vHu2rvA
X-Received: by 2002:a05:6000:60f:b0:47f:6d75:7a52 with SMTP id ffacd0b85a97d-47f6d757ac4mr10330530f8f.31.1784539631284;
        Mon, 20 Jul 2026 02:27:11 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eddd27sm28372768f8f.28.2026.07.20.02.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 02:27:10 -0700 (PDT)
Message-ID: <103f04dd-dc48-42e0-83db-46864ca9297b@blackwall.org>
Date: Mon, 20 Jul 2026 12:27:09 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/5] bridge: Use ndisc_parse_options() to parse
 ND options in br_nd_send()
Content-Language: en-US, bg
To: Danielle Ratson <danieller@nvidia.com>, netdev@vger.kernel.org
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ja@ssi.bg, petrm@nvidia.com, fw@strlen.de, kuniyu@google.com,
 bridge@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1784463131.git.danieller@nvidia.com>
 <d75c565729850a2b95c5b19fd5997e94cf55029c.1784463131.git.danieller@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <d75c565729850a2b95c5b19fd5997e94cf55029c.1784463131.git.danieller@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/07/2026 16:34, Danielle Ratson wrote:
> Replace the manual ND option parsing loop in br_nd_send() with
> ndisc_parse_options(), which provides proper validation and avoids the
> class of bugs that were fixed by commit 53fc685243bd ("bridge: Avoid
> infinite loop when suppressing NS messages with invalid options") and
> commit 850837965af1 ("bridge: br_nd_send: validate ND option lengths").
> 
> Use ndisc_opt_addr_data() to extract the source link-layer address
> from the parsed options, which correctly validates the option length
> for the underlying device type.
> 
> Export ndisc_parse_options() so that it can be resolved from the bridge
> when it is built as a module (CONFIG_BRIDGE=m); otherwise modpost fails
> with an undefined symbol.
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> ---
>   net/bridge/br_arp_nd_proxy.c | 32 +++++++++++++++++---------------
>   net/ipv6/ndisc.c             |  1 +
>   2 files changed, 18 insertions(+), 15 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

