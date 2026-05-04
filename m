Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CC12DCBFC
	for <bridge@lists.linux.dev>; Mon,  4 May 2026 07:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880490; cv=none; b=GzrRn5IOPA7MmWt/6eNV/x5XpecgPbY5bpM28ag8bYcyAl7J1nsXvgwV6/4rDSob+y0lpWxqAWcYf/5TMALfgZLW44sxkQQvHoav76iWkWzOYMQaaExw62ogNy0E7tkQHawDiBn2quVpxeZuZcH3g6moVZRQTpZhCuk5tJzK+pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880490; c=relaxed/simple;
	bh=9C2sSNNeZ1cCc4ayki9NO6X/nZzRwbOwT0cnpksF4xI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HHnKUrAMHEUXo0pS06o6dGbB+WEAiBuyNk+cozsTSZu0TVag2w2WjbhLNUuqvlalVRloYmPiSC5Bgk/B7gvonDUIl73iYO9RjiDiQQt0bNuISoE0gHJ/l6tha0eambNt0EuvpogCHeeYBdQTpqHi10MArcDiFfVp/OvrjUa9pck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=AJKHU0YY; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="AJKHU0YY"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891cd41959so30066815e9.3
        for <bridge@lists.linux.dev>; Mon, 04 May 2026 00:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1777880488; x=1778485288; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N53aTZ6Alw9A7BKH2xpHsS6zd2eepFFKtOswmVsDqXA=;
        b=AJKHU0YYWwyPEx/IUwmlwKXRTZUjeriHZMVQAR8TNNCmxiobkW3kffIJbg/sjnzQeY
         0biaSrTdKVS0DAVNhOEw4yIT0pQsoLjDz6khyVknM1hCGNVZYHcKpBfacfpScqDZ70su
         SvpvvBpT9hjIsqwO0MmHKqFBGsFtJfIjuEJ1YVq7hZcTms1tADVbMbQB1QiHocdBUGWv
         ti6ExQ1FHvEYYq8znD3OhhuGEUKUoZLPCmVLmaRy5HnfFnHCMHoK78qre1UHOp9BCXN0
         ZngrxDFk4TTsq3A2Lf6QFLOiAxVDeBewd5KUF/moOpJBmM/RkT4eAVCBr95R3peTG+BJ
         8vsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777880488; x=1778485288;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N53aTZ6Alw9A7BKH2xpHsS6zd2eepFFKtOswmVsDqXA=;
        b=f6zVp7n5k1wRwgs8khTkT5V2S9VZxTsYf2XnXKd8bfE29KFRnNkgvwPsZ55yCXsLFP
         Uwf72WiezRrvEaWPj3ecFnJSJXYxsgYygXQC1Ux92s8gaz0qhcuE+Zt0CJKLvkoLjvN7
         yEGBNa9f09m/ETnR8Ohry14CfDWB2ajwgC16+sGgPjRCY3R9D+S16WPrNhbWgtulRv+5
         xcCbsHXIi8qqkPDV7K811GlRhzg6uw6Vh++XhD+U+SaCUSntE4rsfG4ZSDFToPe7MDke
         OmVi2p63rI5CScasyKLibbHd2Vibi0AhPp0yLCetjbjbZigMso5lPm76/LSVD1O4YTdy
         PX8g==
X-Forwarded-Encrypted: i=1; AFNElJ8ydcXaTV8FydBFndYdNQqLBdJSKoMmJQW/mAVXxnwksWDKiORacISU3ncJuPqsvaQ1inIcPgU=@lists.linux.dev
X-Gm-Message-State: AOJu0YwIAEkhU4uagLioH7VKNVYwAbVQGWuz+zoeaFun9J0yZpDyNWpL
	0YRSq9b554zsCoPQdwg6aLy4G2Ud7UCh8XqpRNAPciWKhjrhW7gIuO9jbxabdFzkO1s=
X-Gm-Gg: AeBDietCLIrNVm7e+GzainNO2+rOs7yG9EenYK1Dcb1OdEINowK4/Yw5b+98TiLRPQi
	NNdZPIAG1S5wCW4GdoMRDE9V/m2x6oFLAYF4XEEEgIM+wK5xBvQBc49ro7p8HDxPiCpL5cW6tXN
	by3e/N+ieLPdqHMxKhkQ2+csNGnuqx9Sb3v10hKIPoYyX6LQa3VVZNbwEV4PrquNbZ8Cf0j4E4C
	vPi/mfnGzvyvNQOXV11KifoTYxByMJyIqxg8cbeLDrUVOKI40jzvAPx/4Wq4NjUTKO3E5mDdqVr
	9C7oUBDjHwxJ5xdB6db8mKPm4eL52fvOV5I0RDNYyBDpY3bLZP4pjuc/5IFQvHn8wuuy4lqQ2hH
	/hH8b1JjR4nC7FIocRJkS7KZKIuFHcEEQOT8yXBpVs8WGWn+gAz0DyTAwisTrDGd/zL07o9SDt9
	n8agZuTW7Ca8ZnNqtsmorSEVVrJG6lDWhgs/CMoJk0nYlXWRHaOS0g+eC5G9ReXLx3
X-Received: by 2002:a05:600c:c0c5:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-48a98662e71mr109163945e9.21.1777880487219;
        Mon, 04 May 2026 00:41:27 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a9919fc3asm86901945e9.0.2026.05.04.00.41.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 00:41:26 -0700 (PDT)
Message-ID: <7f600103-db90-425d-8ae7-b80cd9d81ad1@blackwall.org>
Date: Mon, 4 May 2026 10:41:24 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/6] bridge: Add internal flags for
 neigh_forward_grat
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
 <20260503073532.2138165-3-danieller@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260503073532.2138165-3-danieller@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/05/2026 10:35, Danielle Ratson wrote:
> Add internal flags for the neigh_forward_grat feature:
> 
> - BR_NEIGH_FORWARD_GRAT: Port-level flag
> - BR_VLFLAG_NEIGH_FORWARD_GRAT_ENABLED: Per-VLAN flag
> 
> These will be used to control whether gratuitous ARP and unsolicited NA
> packets are forwarded when neighbor suppression is enabled.
> 
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   include/linux/if_bridge.h | 1 +
>   net/bridge/br_private.h   | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
> index c5fe3b2a53e8..ec9ffea1e46e 100644
> --- a/include/linux/if_bridge.h
> +++ b/include/linux/if_bridge.h
> @@ -61,6 +61,7 @@ struct br_ip_list {
>   #define BR_PORT_LOCKED		BIT(21)
>   #define BR_PORT_MAB		BIT(22)
>   #define BR_NEIGH_VLAN_SUPPRESS	BIT(23)
> +#define BR_NEIGH_FORWARD_GRAT	BIT(24)
>   
>   #define BR_DEFAULT_AGEING_TIME	(300 * HZ)
>   
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 31e317a3529c..677cd5d68dc7 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -187,6 +187,7 @@ enum {
>   	BR_VLFLAG_GLOBAL_MCAST_ENABLED = BIT(3),
>   	BR_VLFLAG_NEIGH_SUPPRESS_ENABLED = BIT(4),
>   	BR_VLFLAG_TAGGING_BY_SWITCHDEV = BIT(5),
> +	BR_VLFLAG_NEIGH_FORWARD_GRAT_ENABLED = BIT(6),
>   };
>   
>   /**

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

