Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382B61422B5
	for <bridge@lists.linux.dev>; Fri, 12 Jul 2024 07:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720769268; cv=none; b=rQ5PMslzMoTN/9jDSkvU7OrYEGvOuxHXzGTm/VBSfbSlXzw65KvFKyKZS7VvbavfXN+bXYuwLnnuqCkdPvoyAz//HAKiO+xhSPNAByK1ATC2FXPLo4BZaXLtdqBgWyyI5neRccy7vo/okNskHRmyjrsPU2vUBugEVhhA6zhh2A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720769268; c=relaxed/simple;
	bh=P4mIafREpn6h7plQjYSpGs1UlyXzDra4OmllL9/yIZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RqZMYu4vVj0Rs14oz5WVEAfsHyTUzq63LqrIKXkCp1Rjveeqrwf7sPrz9AdiOBxhI9AyFN6b3e8WiMxhiNuyLFU6lXCJVUXUZJPdc0SVWA79KCUX+0DxD3BUvT2sV0dKi09AycLE0iLdxyyYjUx/RRFmr1xMETBWYEH78ihy6uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=KALVlkxg; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="KALVlkxg"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57cf8880f95so2103630a12.3
        for <bridge@lists.linux.dev>; Fri, 12 Jul 2024 00:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1720769265; x=1721374065; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LlwpSi63N1z5BUSejLoMf5VZ8PuCQqb4+FkOedv3l0A=;
        b=KALVlkxgJbPPuBi66aw/hl+x6mhun719YlJ/I1tNyjZp/Mu+G3wmsCP+g3J0LxoK42
         P82r6JleuGMz48oo9g2nmfSQ5UgFBM3oU6cUNGmNu6Iz3LifPLu9MjG8Dp0P9bv7gmcL
         MP/Hx3cdb+5DdFXm+D7u84PJNmIVLoT0UE5TjEKn5nHDUNpVF+NK1yxNXxuOOsYmVaG5
         NqatGxPosnTlklD+YVtTRr2vF0bgZmS4890V2O2j1S6NzXca67HHM2c4n0vsqRAOMsqS
         px2NeRrJ5oRP7zpmNBBxB5Fgx+sFSDWzXtTmK5eB4+fDN1F7AbN3MwV4mCBq8Qe6OI+I
         4GQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720769265; x=1721374065;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LlwpSi63N1z5BUSejLoMf5VZ8PuCQqb4+FkOedv3l0A=;
        b=L0rfEp08v7w/J4A9CuBrp7cQS/73TMUvQ+mVfP9JGT5YfQFahAnwfbcdCfRrwXRLre
         WmIh5CkSQsQ5EPRm+SygpzcRzA/+htaY/Txh9870dz0AavbJ7aj1ZrQWGcxMmKrgbXJ0
         Gp/tZqcJ0KU+qMpd+6MMBqGHB3oxo69vEPFlQZT5WXEgaPuHfWfK2riGaPluqEBAraca
         bzjACAftN8sgUuZasajHP6uEcpVHxhGc8gdGtCyiyFtk3uxOb6dF74YBRuMePyPVa84c
         iN8GL8IeR0rPNc10T6g4TRG2eB6jBfZWdbQo7zXMQIE0Wc9ckyJGxA+ue2ATFCXNwFOI
         0fRw==
X-Forwarded-Encrypted: i=1; AJvYcCWwLAxyj95+pVJX/qvP8FUnGEh/GfJtBWO0IGD71i9qS8x3SCGrioM/u/kPS8YDXRudRt3PIKAjJuRgxh7PhlOEVwdr2tbb
X-Gm-Message-State: AOJu0YzqeO+mGYjjrVhiexti0DLJbcw0QSpndUpijPwSu0ijsepMHWem
	43zysCuN1eilnS234Z5eydc7rrzDaF4/PkxuqzpC6iT5rc/+5azsUnU3diVvvVA=
X-Google-Smtp-Source: AGHT+IHgpOHeaT3lVGJdaXi/tIr1BOqe27pQXQR344YC5suu3getWDIJlHps77AKEhLiL7Q5GgUxYg==
X-Received: by 2002:a05:6402:11cd:b0:57d:2db9:15e7 with SMTP id 4fb4d7f45d1cf-594baf917e8mr10130318a12.12.1720769265456;
        Fri, 12 Jul 2024 00:27:45 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bbe2ce4bsm4244511a12.25.2024.07.12.00.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 00:27:45 -0700 (PDT)
Message-ID: <17d67de2-4f10-4454-addb-1fbb86a264ee@blackwall.org>
Date: Fri, 12 Jul 2024 10:27:43 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: bridge: mst: Check vlan state for egress
 decision
To: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>, davem@davemloft.net
Cc: Roopa Prabhu <roopa@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240712013134.717150-1-elliot.ayrey@alliedtelesis.co.nz>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240712013134.717150-1-elliot.ayrey@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/07/2024 04:31, Elliot Ayrey wrote:
> If a port is blocking in the common instance but forwarding in an MST
> instance, traffic egressing the bridge will be dropped because the
> state of the common instance is overriding that of the MST instance.
> 
> Fix this by skipping the port state check in MST mode to allow
> checking the vlan state via br_allowed_egress(). This is similar to
> what happens in br_handle_frame_finish() when checking ingress
> traffic, which was introduced in the change below.
> 
> Fixes: ec7328b59176 ("net: bridge: mst: Multiple Spanning Tree (MST) mode")
> Signed-off-by: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
> ---
> 
> v3:
>   - Properly reference port state to fix compile error
> v2: https://lore.kernel.org/all/20240711045926.756958-1-elliot.ayrey@alliedtelesis.co.nz/
>   - Restructure the MST mode check to make it read better
> v1: https://lore.kernel.org/all/20240705030041.1248472-1-elliot.ayrey@alliedtelesis.co.nz/
> 
>  net/bridge/br_forward.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> index d97064d460dc..e19b583ff2c6 100644
> --- a/net/bridge/br_forward.c
> +++ b/net/bridge/br_forward.c
> @@ -25,8 +25,8 @@ static inline int should_deliver(const struct net_bridge_port *p,
>  
>  	vg = nbp_vlan_group_rcu(p);
>  	return ((p->flags & BR_HAIRPIN_MODE) || skb->dev != p->dev) &&
> -		p->state == BR_STATE_FORWARDING && br_allowed_egress(vg, skb) &&
> -		nbp_switchdev_allowed_egress(p, skb) &&
> +		(br_mst_is_enabled(p->br) || p->state == BR_STATE_FORWARDING) &&
> +		br_allowed_egress(vg, skb) && nbp_switchdev_allowed_egress(p, skb) &&
>  		!br_skb_isolated(p, skb);
>  }
>  

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

