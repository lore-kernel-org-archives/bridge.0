Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7531632E4
	for <bridge@lists.linux.dev>; Wed,  5 Mar 2025 08:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741163381; cv=none; b=atUyCUeZ80lZhwrmbCgXzhidGEn0/Yv4gmndXTh+RccQzWOJduDiP6qSe2WOcnK7FhirV8H+g2DJxkepDswUmNLU5JWweV6cAcFcxzLGomzWrx+t6rmY6fUQihy6SiiX5EuJ05Ug5MAC/0jjXPK6xPWUjBLrSpaOcVDzpBYtq7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741163381; c=relaxed/simple;
	bh=BIb8PPjZHUval8yQxPaR2VI3OQirSDX4w545WCXSCig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H5ztBFa/NY/Sc4eynH3ypq9n4+V0ZkWd3FXZj/GUkK5rPvrv4Vxp9Wy/b/uqTEci1C2BjFDeNRsJfx3/7q5tIf0vYgzGO8lZFBlnbAk9zFvLcCqnFTG51NCu/XugN13z0Et2obvvHSr2BiTgp8yiKy9xfrwyZET6/NQMMoiO/Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=mYJZ2Bci; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="mYJZ2Bci"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e058ca6806so10752527a12.3
        for <bridge@lists.linux.dev>; Wed, 05 Mar 2025 00:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1741163377; x=1741768177; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iS635IvOc12Hbl5A1UFbpTyLqQYfDtGYrejudL0pBtc=;
        b=mYJZ2BciXWAJyHfS30KKw7LkNDC7Ee8ipYGMR+qZLSHExaWARNf60tzHJD/zVtelgW
         S4DL/LEuoDLmgkq8YiSyxPfLPAAw+d/Votm0FFLth32UFXc8bozjR9hp8Zvkq4QioNol
         wtC/vr2fLEmlo+ygGPy/A1BQWvisomERs+ekzB/3A4HLgNCMm+rJ+gjfvE5IGPr9vimM
         RA2VOF3aNjfcCTmroMzTsw5eEdEUtvOVFFRngSDI9TT/IJi8d7Tsd2/fHug/gBOCUpNc
         KZSfk50jTsUUmqZ+PTIotrgX8TC//G8QmbfuOlEbnwTCy02zZGap3y0VnW/cZ7sEeBeE
         m5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741163377; x=1741768177;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iS635IvOc12Hbl5A1UFbpTyLqQYfDtGYrejudL0pBtc=;
        b=YOO3DNq8aY4diGBchPX6y92eD1O5RgEJZ9dwwHZ5/xAAALBE09ATaXFShjNdw8Z7QH
         HKXCoDfEZ841B4nVnBvjgKiTsA8P3zgVIhwRkSZVkEI6UmnAXT6hA/3NWTX6NQJZwSnY
         JY6LzuLDNWmZ4BwjaWjYlSmbo1YXrcZMrMYJ4TaAZgyRZ7H18gj1jparCAWGP6L90Dbl
         IUQflYA9e9TurB7Y7khRt2/7FWQlqv2F2SghueltvWohn/0G/qidsHe3J8PWDShDDttZ
         Zan3naA4Jq5jazM4rLp8J9hjGL7dX4/dJdgTLeJ3g2uBJBIR1SkfQzUK1EgE8dYr1qKF
         X4CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAHB8hMzQIiVC7qtlU+/KgTd9859ru1UO5rOuYNEHSbFG5TkDRelPD2OJ/TCSxHAYG3Op5NfQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YxHp+WF3Fw3dTZ+/AdRLKgmRVlGSeq3baugkdg3tjeIUNodBqyU
	MKNpWIIYw3zOsav2P/JMOESMK3LIV7yDAR3NabJtvedy9SUMtCVnoNmoaGkxE38=
X-Gm-Gg: ASbGncs7pmQ8HT6DgTTg6AHQ6O9H7iLI1EZ+2+l+YByOJ8otXRpPaB/9LILnR4jJ11h
	TV9Dzj8zR7LkDvSu9GIfbbOw5InEp4I/2j4prHymg5Fi3I+Xpga9seEy6/RKyvyrIr1uvmDwMj3
	38ggWPScBKpB9TZFaA0pCF+uvYOtBUpSaPDNeml4yMMNlOhpr6ckrgyxAdmm5VIe1hiuhXer7R/
	zgyJs9jRxXterx6G03V4Dq/WKqTTMiJGdJ0YzsrXwvAYoDyo8etuO66alL8wjkpSE7cNFjYsTOL
	D/5J3Shv6LqbLUOu/bkPaIa+OMXRX3lD4mmoYkO8sMwQ12S/6qkB0U7ONlC3GVsWKi2j4wr+gwj
	S
X-Google-Smtp-Source: AGHT+IEjj5zOJcj1/OsRfe5VF46uWo7cJGLTZaHw0tlhP7T8cxub/kFHcc4MiHV1iodJ3D5MAmAOeQ==
X-Received: by 2002:a17:907:9446:b0:ac2:b73:db3d with SMTP id a640c23a62f3a-ac20da4c87fmr226467166b.4.1741163376857;
        Wed, 05 Mar 2025 00:29:36 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abfa393dd6dsm453290666b.96.2025.03.05.00.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 00:29:36 -0800 (PST)
Message-ID: <1975f2a1-9461-400d-8b3f-f40e8b94be80@blackwall.org>
Date: Wed, 5 Mar 2025 10:29:34 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 15/15] netfilter: nft_flow_offload: Add
 bridgeflow to nft_flow_offload_eval()
To: Eric Woudstra <ericwouds@gmail.com>,
 Michal Ostrowski <mostrows@earthlink.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Jiri Pirko <jiri@resnulli.us>,
 Ivan Vecera <ivecera@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Ahmed Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Vladimir Oltean <olteanv@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 bridge@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20250228201533.23836-1-ericwouds@gmail.com>
 <20250228201533.23836-16-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250228201533.23836-16-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/28/25 22:15, Eric Woudstra wrote:
> Edit nft_flow_offload_eval() to make it possible to handle a flowtable of
> the nft bridge family.
> 
> Use nft_flow_offload_bridge_init() to fill the flow tuples. It uses
> nft_dev_fill_bridge_path() in each direction.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  net/netfilter/nft_flow_offload.c | 142 +++++++++++++++++++++++++++++--
>  1 file changed, 137 insertions(+), 5 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

