Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512BE13C914
	for <bridge@lists.linux.dev>; Fri, 20 Dec 2024 12:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734697657; cv=none; b=Jr+0HBbs3xekbdUALVBGtU9NKZA+POxABht03zuDnbys1HY8gbJMgDd4eNKKtSwIbMfWRt4dOl0nkBFxGDLWvY8MxiHyMbdADDR5XPRZVDOhd3t3RLwksy4wgXjeDXZo4ijSY/u0uGeDe8tW9vUwrzttSMfbP0E1NUHVrVZC7I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734697657; c=relaxed/simple;
	bh=zA7a4bZu48ACitHBhxc9qodT4PaQ4DeroceLOgXAYH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oL1vQQdPp9H027eOeAcSKBPCFggCk6GlaHgV94NmT6/rfPcul2SKlmlfqIyksPbF7ZMEAsAd3kqwgYLGT7Ph7aPTwo5GLmBM0iqO4Kf8Ve+HFz+B4dlUcS/pijrHOPgcePMogKfwULRATHPIrGHuL1ajWsQZissD41a+69gbfkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=jLsHhcUj; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="jLsHhcUj"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43618283dedso17767065e9.3
        for <bridge@lists.linux.dev>; Fri, 20 Dec 2024 04:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1734697652; x=1735302452; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6yxLq8x+6aHmMAIO4raWWraNl83b7b09sXoVthd5fIM=;
        b=jLsHhcUj4BhZK+Wh0upy83q/dJflsOuh7DvWorQaG7P/uxcLUnusc/prgJGyOcLTki
         gooBbMKVxk7vAorwv9SUYD8aS4/Ef4vua9Lv11DpNk0bffkfe3sIxcdd98AhwWud2Ta3
         GVGs2wALei+8WDkKqXTbQGCJyyLtvLUTTxZ/hucVtFevaxWQQ0xq8H3MaVHrODoLW1nj
         TMmPaxJ6F5KOH/Je0/cApnuc/sjnArCPAV3XO148ssCNn3Djk2WJq/joG4iTVipIj0QE
         wpdUAPuFWTA3uisW08QjKxUcFDnEo7GCJuOxNE2GI3CQj6G/JBe4ppUZClQ6I9Y7dtip
         AoFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734697652; x=1735302452;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6yxLq8x+6aHmMAIO4raWWraNl83b7b09sXoVthd5fIM=;
        b=j1FSJPNf/2CExrCbhhNiranlTuu7dAL9f6lC+8rvviAPXy4Yw+9fLUe+BOtsfC2UYK
         bkCwajedx44LCkiJuwqBJCbybk0mNTqQRirM+g7RD+hqPTjn7jq/ObauW9KcKPJXSYzp
         yyX20fXd3J68OuPivSnLXtjtSpXigE8BifV5tAacjpXM9aBjFwq8lXdU9SAwdSRN07CJ
         I+0TkMM+6w5JYH93i1nFsxjTOhPALi/Pb/oujPBS0G3Ys0KYSseSwmafx69ifpV/J7EC
         w7IK3I3sNAg0G/W8WKsVr+GNmLeFv1sfB+rmF9x0Kc2uX4CayRHUdZgTqe0ZPZXGdq7X
         +g6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXa5xZIdk3g0ioXuw1cLIBRpUS4MpT25sXMc9aBbaugm02Gq4jwVeXTfZ5k2hqL198lADgrm6A=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3HOsUeXt5AUiT0iR8LbO55xTLapwfaDX/WRUSkg4NcZXibV5Q
	VASJMAbPvGygS+ObhSaoYQH0eX8q/crvf/zelB4PS4TUfjyNpDziUM2WBARzUcU=
X-Gm-Gg: ASbGncuNAxs83FtxUZWZeddmW4Fz3blX7GPR3KPO8l48XO4sgQHy/30HP7D3r0MTO3O
	oyIwCQu6e8gHcoo4W0Xr8pClIutR88IxbdXUvpk1hCYNrtABaaGijonQLOCBEgbcklcyByXHvw1
	7/G0eLhWJWe3Z2G80sh3fYRgwoaTAsqWItX2kEovOg5IqDXE2y4qUZJSLRnKTTbpjglKaZZGm9N
	WhUWS18OQOergrIeJAJ/TswAKfz9LTrVYyuGDzGR5V4zKh35OCq5YNCI+x939jbuO1w/OwYSgoD
	q/M13ND5DJNV
X-Google-Smtp-Source: AGHT+IF0nXfFMV2mR1adR3X1lrTPlRuKqMQUEP6YuFL1k1v8N1A4WExmKhshpLKhwZ4tokJIrcSxnQ==
X-Received: by 2002:a05:600c:358d:b0:435:fa90:f19f with SMTP id 5b1f17b1804b1-436686425eamr24106235e9.12.1734697652460;
        Fri, 20 Dec 2024 04:27:32 -0800 (PST)
Received: from [192.168.0.123] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8a8d32sm3964112f8f.99.2024.12.20.04.27.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 04:27:31 -0800 (PST)
Message-ID: <d23db9cd-d9ec-4697-a851-3b395c6afae9@blackwall.org>
Date: Fri, 20 Dec 2024 14:27:30 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] net: bridge: Extract a helper to handle
 bridge_binding toggles
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Roopa Prabhu <roopa@nvidia.com>,
 bridge@lists.linux.dev, Ido Schimmel <idosch@nvidia.com>, mlxsw@nvidia.com
References: <cover.1734540770.git.petrm@nvidia.com>
 <a7455f6fe1dfa7b13126ed8a7fb33d3b611eecb8.1734540770.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <a7455f6fe1dfa7b13126ed8a7fb33d3b611eecb8.1734540770.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/24 19:15, Petr Machata wrote:
> Currently, the BROPT_VLAN_BRIDGE_BINDING bridge option is only toggled when
> VLAN devices are added on top of a bridge or removed from it. Extract the
> toggling of the option to a function so that it could be invoked by a
> subsequent patch when the state of an upper VLAN device changes.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_vlan.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
> index 89f51ea4cabe..b728b71e693f 100644
> --- a/net/bridge/br_vlan.c
> +++ b/net/bridge/br_vlan.c
> @@ -1664,6 +1664,18 @@ static void br_vlan_set_all_vlan_dev_state(struct net_bridge_port *p)
>  	}
>  }
>  
> +static void br_vlan_toggle_bridge_binding(struct net_device *br_dev,
> +					  bool enable)
> +{
> +	struct net_bridge *br = netdev_priv(br_dev);
> +
> +	if (enable)
> +		br_opt_toggle(br, BROPT_VLAN_BRIDGE_BINDING, true);
> +	else
> +		br_opt_toggle(br, BROPT_VLAN_BRIDGE_BINDING,
> +			      br_vlan_has_upper_bind_vlan_dev(br_dev));
> +}
> +
>  static void br_vlan_upper_change(struct net_device *dev,
>  				 struct net_device *upper_dev,
>  				 bool linking)
> @@ -1673,13 +1685,9 @@ static void br_vlan_upper_change(struct net_device *dev,
>  	if (!br_vlan_is_bind_vlan_dev(upper_dev))
>  		return;
>  
> -	if (linking) {
> +	br_vlan_toggle_bridge_binding(dev, linking);
> +	if (linking)
>  		br_vlan_set_vlan_dev_state(br, upper_dev);
> -		br_opt_toggle(br, BROPT_VLAN_BRIDGE_BINDING, true);
> -	} else {
> -		br_opt_toggle(br, BROPT_VLAN_BRIDGE_BINDING,
> -			      br_vlan_has_upper_bind_vlan_dev(dev));
> -	}
>  }
>  
>  struct br_vlan_link_state_walk_data {

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

