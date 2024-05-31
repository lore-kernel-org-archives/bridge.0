Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD70929D0B
	for <bridge@lists.linux.dev>; Fri, 31 May 2024 08:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717144069; cv=none; b=CF/XC6SykjJ2O2i0oen06CMQYTPWjhBHNbGnCkL8m9z7cXlTegpMAf7+FvU1cXYNBmyrgr2K1atpbE7rfSckIiWn2ScQvBOE1qHIrKUf176mi0bahjCoZEOtffEPa+eueD0tWFU4cSZ2R1+X/+1Pm/AsiwSlvxqSuEZ7IUKdUGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717144069; c=relaxed/simple;
	bh=IJbxPCNMouBhYz+nveoZZGH8XvZoT3tJwwUzzzEqNFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EPI4PjVo7W6qCOKJgRdngrr1qPI5kLpX/+fKl+XzFIcnhiFkQQupPrjQ9kXZzhSAJT+Yy9yemt2WR97EdgxKqW9UbLYwjZaT+ePRhG/wZmTOTh8mbvHfJ3mAmwHNZdRbJCbDZ9b6/5WK0n0MfEgFa+jVqaXYJWU4XayqeCblFk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=cLvACHFX; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="cLvACHFX"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6762109c06so159150066b.0
        for <bridge@lists.linux.dev>; Fri, 31 May 2024 01:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1717144066; x=1717748866; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CczSpm496AORC0Lz1xbvgXRHePaSNFD5ety9dh5tj7k=;
        b=cLvACHFXl/rKMpCa/my64yIjux4AHo6wE8qwOt8NerftVsDoXG5B4W3uq9xq/m+Xi8
         J/SSO/D4aG4ZWFjdrtIVWDZ8PlD1MGnhEIR0cne+cG2I0LzFk8JzI74VfCazU6KDv9v0
         rLVniiw4vS0HAqp0ueSrR7NWTsAi90LVI1Y3Cf1Ya4W0ibe5Bvc2pXO0d9b4YM8koIOU
         sG51+tgpZIP2lsBmMs+w7YWgDjrE5CTcl+t0MmFVUHMPkMdg9I0NNg1o90ehNqQLSAOe
         THz4DPYMKCO9DX9Oepu6a49EfeUQGDetwpXxzlCC4/cNWWltktxHIMzsRZh5/80Tijpq
         hfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717144066; x=1717748866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CczSpm496AORC0Lz1xbvgXRHePaSNFD5ety9dh5tj7k=;
        b=raFfFlkoQ0+W7VV5sH4iZVLvVspiutgMtqJ5uRwHBo6wjFm4xa7276v6qp9D8PN82i
         pvWTy5V1C++kpbw6JyO2fv9TBdiicbAvrtd6+p48rcy6Hip4UEJ2nGfE00OU1SMOWS6t
         GDoXkQHVJwl8DoawwkmcL9fCRmgT5coKuP83ntK0nb0SLemXxqMYrrTo0aQfgLu3i+Xc
         9q6OMYrpzQFqyrDDQQ/+DotYFznb+t/SRHl5db9Qc5PRswGYtIs/DOFG4MH9lODxCmE0
         cKdYC3NJ2ARFrphkHr/+6s91Xg3288DPn79scaX3QTG172w0WaP4I/u7TCq0wyv289EC
         CbYw==
X-Gm-Message-State: AOJu0Yzm+DELEGIYdExV+yJ5IRX+KWMv/YtmAW87ZxYiPJiNP160iWY2
	GhJt83Y0ZhF1kua8DQaE7dqRI9zwl5kODA9ytgTJgSt/9SFQ+q/obr4sKVbCmJw=
X-Google-Smtp-Source: AGHT+IHVpq5jzDNuclnC7a1iNf1qGeZnJRgw4W8zfuGHaA66en+KhpJjecK6QkwfE6pV2cdJtjrdHA==
X-Received: by 2002:a17:906:2851:b0:a67:907f:e68a with SMTP id a640c23a62f3a-a681a878304mr99864066b.27.1717144065986;
        Fri, 31 May 2024 01:27:45 -0700 (PDT)
Received: from [192.168.0.105] (bras-109-160-25-143.comnet.bg. [109.160.25.143])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67eb342009sm61538766b.189.2024.05.31.01.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 01:27:45 -0700 (PDT)
Message-ID: <10eab0b6-4106-481f-abdb-b97fb162355b@blackwall.org>
Date: Fri, 31 May 2024 11:27:44 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: bridge: Clean up one inconsistent indenting warn
 reported by smatch
To: Chen Hanxiao <chenhx.fnst@fujitsu.com>, Roopa Prabhu <roopa@nvidia.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org
References: <20240531081136.582-1-chenhx.fnst@fujitsu.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240531081136.582-1-chenhx.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/31/24 11:11, Chen Hanxiao wrote:
> smatch complains:
> net/bridge/br_netlink_tunnel.c:
>    318 br_process_vlan_tunnel_info() warn: inconsistent indenting
> 
> Fix it with proper indenting.
> 
> Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
> ---
>  net/bridge/br_netlink_tunnel.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bridge/br_netlink_tunnel.c b/net/bridge/br_netlink_tunnel.c
> index 17abf092f7ca..25ac3a5386ef 100644
> --- a/net/bridge/br_netlink_tunnel.c
> +++ b/net/bridge/br_netlink_tunnel.c
> @@ -315,8 +315,9 @@ int br_process_vlan_tunnel_info(const struct net_bridge *br,
>  
>  			if (curr_change)
>  				*changed = curr_change;
> -			 __vlan_tunnel_handle_range(p, &v_start, &v_end, v,
> -						    curr_change);
> +

Drop the extra new line.

> +			__vlan_tunnel_handle_range(p, &v_start, &v_end, v,
> +						   curr_change);
>  		}
>  		if (v_start && v_end)
>  			br_vlan_notify(br, p, v_start->vid, v_end->vid,

The patch should be targeted at net-next (subject PATCH net-next).
Also please remove the "reported by smatch" from the subject
we have a Reported-by tag, but I think that information is not
needed here. Just "fix inconsistent indentation" is enough, you've
already mentioned it was found by smatch in the commit msg.

Thanks,
 Nik

