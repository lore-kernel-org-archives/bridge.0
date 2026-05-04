Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C71306B3B
	for <bridge@lists.linux.dev>; Mon,  4 May 2026 07:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880522; cv=none; b=ICETNAhPufNWp1I+tVzN0GWedSxSbTUQIi/UWF+qzsyBWdFPj3TqonaDytA8ZrJjaLPKhVAIFvV3mMbDd9m+GRbsm3QHc5zNU5z8nsNWqIUBfuuym8Yw0u7f6O5hVnVxn1/1DjFRFfdwX6FEzC6erBL3+Dw8Yo0C5Aade94vO5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880522; c=relaxed/simple;
	bh=wppOGaRjuNDplImhUtX3yedW8XVD+Rjnv4702GUsXr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SZyXlKpZ4epAk2UqVWcqF4PPjFuiOyxyDIZyuvrLxbObGiBSSIyR3IWTBfxvmMayj0lNDjAneJt1Ze+iC+fOFluIL2KtPADIXhYNZP3m/lWf6lrLKqP44zD5mLBqZO4/ry7IxH54ztbIQNyzOOiDNeKIb4QypL3+1L/l+VxUlLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=V7Jqaaaj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="V7Jqaaaj"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso39514815e9.3
        for <bridge@lists.linux.dev>; Mon, 04 May 2026 00:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1777880519; x=1778485319; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C3RAkK6cIEAorEjiat0wspxnHljFQkJZ30oFU41kBVI=;
        b=V7Jqaaaj1AEZV90svCXozK1rCjagIo+LNRZEHj2GziuQfySQIqdTh0xVJaFwu6Qw7n
         cy5OT3bW7eii/TeEX6oHUAxgbfI7Si4jeZ4PCW7Uij1dikYrd8f1JaJXPb61REyTIDAw
         QwgXa8nF4EzxMd1g2wq648PYUSZxpPs1UN24HQnqvCxgIaCxvUimg0bORkpSw+eSB2a7
         SuanygeBXUOoP3sJmIFOVNOTL1+ieffLScUsVKizLN4WmxOrQ0XTn7wLXHjz9xCbKFHQ
         7ZuloMzUjHJs90pUaKCnQcLz+sniit9ovetF+ai63tZ2lQJ17UvGGpVWDgxF6IJcwvw0
         MbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777880519; x=1778485319;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C3RAkK6cIEAorEjiat0wspxnHljFQkJZ30oFU41kBVI=;
        b=O2SNdvEyWmkKaEBuy/cvUaz3IShQcBSjBAduTLn/s5nwPcz5dBhDKvTq2X5uQeswtz
         HAI2n+E/RpRN8WQ/BbcuSIfa98zxMCcnC2gwoIv2x10EPX3KnGsRW2zQ3UTjFWeSN7Kz
         OLQWbk3Oo8U8SlRoF56uopN5zLvm2Jl4h8eXmfvIQ/gAYYs6k8yAcorLEcpIqlEPHwR0
         jj8DGq+P7HMYY4L7ZNXQpsDnkDk297WyZen0uJXPJ3+xuWRRmX/GIuQNdcd1A77Sbv5B
         +2o0v3NRYZYKHMytMlKzeURNJ6RQRu8cHdoGWzHZk3iKTGKEhK+2vMDDXj++mXefzCyA
         mk/g==
X-Forwarded-Encrypted: i=1; AFNElJ9cc1FM/gbSE9El6lfTsaLovfuAFM8kAzGGeIvH2teoy1BSWrISkD96SZZWfOd6BoAilhw2yeg=@lists.linux.dev
X-Gm-Message-State: AOJu0YzjXewMEkDMy5z49RnAJeRuldlGBZKF/NO8BZCkNRe7cgQkL6N5
	jffTTmRrUbue62vtDybjHoNxmhBTHyijt5Xx56bTb5prvQMfEl1barCCY0vIv0n34JI=
X-Gm-Gg: AeBDieua6kknXfmp93rXUnoAiaVCMbKj0IfcarTv3Ro3L69Fot/8MM4kAuzsvWXDEW+
	WSUrbB/DYj5+QHLJ43+oUBPacysK1lmSSAdD1RsqwL9qm1DnSGoBDw6D2R8bUpp7J7o8/YezP8C
	dmgxePaChJwR84SGrYspDVGfC6uB6Mx5PSDbDj+QcveYLsDZpo2rlNUilsr84MDYMzkvhLbSLVe
	M6s6xY3bLs08/9nxY3wQoP6D3a28ZTvFqKxvbi62zf8blB01lF9ougMbL3a7RHHDU+Tiws+iAeK
	dIq3P6TJwz9jhSWwHeQAJX/hMfbolcwYRpJQ82K/RIWACDjB0MngB5Q7UMAn1HjDLrJ8pPqmc/T
	VibbkulxBkltR8orS3DD5lo3K21c4w58U6/JWuLr4pae+XkgexwaBmBMNfEEkYqlmnWnRtd08+P
	WzWSTtwMXFyewylIid2fPSlgZU68BfWiFq3m8lGUSnzWbVdMPf5iHQYkhOqdw9X1oh
X-Received: by 2002:a05:600c:1386:b0:488:9439:881a with SMTP id 5b1f17b1804b1-48a9852f471mr135743855e9.2.1777880519512;
        Mon, 04 May 2026 00:41:59 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fef8f39sm73312865e9.32.2026.05.04.00.41.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 00:41:58 -0700 (PDT)
Message-ID: <4e172860-1f37-4de9-8520-dcf3d53d5ad7@blackwall.org>
Date: Mon, 4 May 2026 10:41:57 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/6] bridge: Add selective forwarding of
 gratuitous neighbor announcements
Content-Language: en-US, bg
To: Danielle Ratson <danieller@nvidia.com>, netdev@vger.kernel.org
Cc: donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, idosch@nvidia.com,
 andrew+netdev@lunn.ch, shuah@kernel.org, ast@fiberby.net,
 liuhangbin@gmail.com, daniel@iogearbox.net, aroulin@nvidia.com,
 fmaurer@redhat.com, sdf.kernel@gmail.com, sd@queasysnail.net,
 kees@kernel.org, nickgarlis@gmail.com, amorenoz@redhat.com,
 alasdair@mcwilliam.dev, johannes.wiesboeck@aisec.fraunhofer.de,
 petrm@nvidia.com, linux-kernel@vger.kernel.org, bridge@lists.linux.dev,
 linux-kselftest@vger.kernel.org
References: <20260503073532.2138165-1-danieller@nvidia.com>
 <20260503073532.2138165-4-danieller@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260503073532.2138165-4-danieller@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/05/2026 10:35, Danielle Ratson wrote:
> The existing neighbor suppression unconditionally suppresses gratuitous
> ARPs and unsolicited Neighbor Advertisements, which prevents fast
> mobility of hosts between VTEPs.
> 
> Add the neigh_forward_grat option to allow selective control of gratuitous
> neighbor announcements. When neigh_suppress is enabled but
> neigh_forward_grat is disabled (default), gratuitous announcements are
> suppressed. When neigh_forward_grat is enabled, gratuitous announcements
> are forwarded while regular neighbor discovery remains suppressed.
> 
> The implementation provides per-output-port control by:
> 1. Adding a 'grat_arp' flag to BR_INPUT_SKB_CB to mark gratuitous ARPs and
>     unsolicited NAs.
> 2. Setting both grat_arp and proxyarp_replied flags in
>     br_do_proxy_suppress_arp() and br_do_suppress_nd() when gratuitous
>     packets are detected.
> 3. Checking neigh_forward_grat per output port during flooding:
>     - For gratuitous ARPs/NAs: suppress unless the output port has
>       neigh_forward_grat enabled.
>     - For regular ARPs/NDs: maintain existing behavior.
> 
> This allows gratuitous announcements from any input port to be selectively
> forwarded based on each output port's individual neigh_forward_grat
> setting, enabling gratuitous neighbor announcements to be flooded to the
> VXLAN fabric.
> 
> Regular neighbor discovery (ARP requests, NS queries, solicited replies)
> remains controlled by neigh_suppress and is unaffected.
> 
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---
>   net/bridge/br_arp_nd_proxy.c | 22 ++++++++++++++++++++++
>   net/bridge/br_forward.c      | 15 +++++++++++----
>   net/bridge/br_private.h      |  2 ++
>   3 files changed, 35 insertions(+), 4 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

