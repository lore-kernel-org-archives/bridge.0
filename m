Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A9730E0D9
	for <bridge@lists.linux-foundation.org>; Mon, 22 Sep 2025 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758556552; cv=none; b=NPf6vIje5cb0ABjvALsoL8LIA3nlKmPHHIWQHqzeaTkahT6y7hEHMCOCqTHoMwq7gIkb16J3e6qf7O+VwZSDdaZYuIIj+dGuwQPieEoJhHBGIIRn7fPy6g2RwUMwkl1QhvJYsSavi+tVmB7QyEjSaMNDwfyRHhFxeQw+tN+tqM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758556552; c=relaxed/simple;
	bh=pq/O0L3iQRvpt2S4brWTo8EHJ/WdeRstTtx1HjRCEWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r8X5lfMKIwAqSK9b2aNkzLeBI+wu6Q3m6lt5p1Bt76LY6ObQH61+0SpKI5ZZqBNIJdiRuRxNFQ3oCpRnytDgAIlhrsitQk87ltXG/hsgQuMdC7V6hIidjInbU0vn2kWSi0rf1E3J+a1dKz0oFLKcAZ/hbVfK5W/wy2LaEpjWxV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=LJX0ZDmy; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="LJX0ZDmy"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E19AE41922
	for <bridge@lists.linux-foundation.org>; Mon, 22 Sep 2025 15:55:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.098
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sj07uinr6Bce for <bridge@lists.linux-foundation.org>;
 Mon, 22 Sep 2025 15:55:50 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::12b; helo=mail-lf1-x12b.google.com; envelope-from=razor@blackwall.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0364F40C3A
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=blackwall.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0364F40C3A
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=LJX0ZDmy
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0364F40C3A
	for <bridge@lists.linux-foundation.org>; Mon, 22 Sep 2025 15:55:49 +0000 (UTC)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-57e03279bfeso1821192e87.0
        for <bridge@lists.linux-foundation.org>; Mon, 22 Sep 2025 08:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1758556547; x=1759161347; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JH5AoWKD3BnRdokPxPgfiznRnTMj6/N6Wxj8BEiEKQA=;
        b=LJX0ZDmyjeBtyXQoVj9CycB6Dt8Z7RRpcCpCIwe8xxLkHoceO0vxadqM8omoaf8bOe
         6bZrIC7zW3y1jYWUj1pE97qJEIyQJHTNrBEy7+jaIZnRoA39tHQbdJIH9gSNpxufiuwT
         uMa47Yatm57TTxDhBgr7Eay1NSYnx7Eysm8803j7MVZlHbamVi3QgoF6oHoAlqwOYCXJ
         2KX/SXGgjdneIxkBXePUGAP5qYvboX9OMay1z7l+HTXcaUd7tDYYoQODkiN5C49qXgGt
         1DhDhIegg0uV7ZBC6Xjh3WBW6zBtQVhPIm6Y7qL1D7nV3mugZBGc7c0F4SJr5AF3GAtO
         G+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758556547; x=1759161347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JH5AoWKD3BnRdokPxPgfiznRnTMj6/N6Wxj8BEiEKQA=;
        b=aCElbWBP8BrYDJb4aq+LJbeHhY0aEdqNReG57rKL5w4AsIHB+xOKJx/grb3yeV/WES
         uBW0ex0LeE/7/gYQfqlJ8Sed6J+geOGHQL9LO9Fl7lRaUZqfGOridFsdhF5PnAJClT9G
         20+LPBXDmV2BOLqk9qYv4Rkxq2XpLMd1cDWreYHx1/kBdtd15bYeJOzkHwFqmcm7KsIr
         EYkOhkEv5jiU59LXIQP9c/mYHHtBTiFlRS11Yyf5GO0x7dadRrcQhdpZb0+4+CDcjBDQ
         dBhh3tJ0CaUNfY8KdBKDm6aaDLd437O/gNpG/wWAJdyLE3TET4vwaTkxsTDGzOBCDgxr
         KpTg==
X-Forwarded-Encrypted: i=1; AJvYcCUt+BQ6hO/x4fRglZGDrwh871ceZOsynrQ09n3kVAb80W9yJlfJ4MhXR23E9kuoW4hCJO+LXXc=@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwZHM5YoI7xIed5E+gvjg8uEqGA1SX4lxG7Rvo0//9Dzz1ZM3EK
	fLP8m3AFwbioPzVuv/EyCaDehsDs3sh9/e9ma9H4MNlZvrSu4bMWso/7qfirnBIqSu8=
X-Gm-Gg: ASbGncsFbwQoL1CcBzSkhhw9wgBPG1683nAUitg9taCdtljqNvz17e2+tu7oiKGkIXG
	ZLBI4TlSWsEqEM6WDluKGdqOB+zh4EwdSTcS6YimB1olpiuDqLOgPUNpFLdpf+BJBx2f0FGUFoS
	moRjEgOIVBLTJWJ3K/HK02KwpYR8KiMKwsjE2gmhf9cY3N46kmgTZvHZ9zTE5GH32YyzjdSMyn1
	2ltBLCrhKFuVzu8auMLAkAXCMUbFwoUvrnshudZYVAAHWdGK7SE48lz2wRbMOr0OdoNvd+9WCmF
	GEnE0jPRqFjVW+7DjG56meT7cvf3nRk0o/7oitpqN8Z4zIDqM3ghiFw/dV3C6zihpJhagQ/Y5Yw
	yUGssfq8ghmdLo1sPXBxvYQQ+8flJvLT+7oXr2WmNf8MzuLx7IJijgT5AmFkBGfPfO4wA0wNQvi
	hT0Q==
X-Google-Smtp-Source: AGHT+IERmXOhfELt8HvWUl7P0WDmFnVRCBbD/AzuUK5nRxpLxCKfqpY4wj6t5yMfkpqaSjn/kjNSOQ==
X-Received: by 2002:a05:6512:ea1:b0:577:fd15:396 with SMTP id 2adb3069b0e04-5789586999bmr5689677e87.15.1758556547546;
        Mon, 22 Sep 2025 08:55:47 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57f504e8bbdsm500761e87.133.2025.09.22.08.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 08:55:46 -0700 (PDT)
Message-ID: <fa3b661b-8bdc-4d2f-a058-8e379ee411c6@blackwall.org>
Date: Mon, 22 Sep 2025 18:55:44 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] selftests: bridge_fdb_local_vlan_0: Test FDB
 vs. NET_ADDR_SET behavior
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, bridge@lists.linux-foundation.org,
 mlxsw@nvidia.com
References: <415202b2d1b9b0899479a502bbe2ba188678f192.1758550408.git.petrm@nvidia.com>
 <137cc25396f5a4f407267af895a14bc45552ba5f.1758550408.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <137cc25396f5a4f407267af895a14bc45552ba5f.1758550408.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/25 17:14, Petr Machata wrote:
> The previous patch fixed an issue whereby no FDB entry would be created for
> the bridge itself on VLAN 0 under some circumstances. This could break
> forwarding. Add a test for the fix.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>   .../net/forwarding/bridge_fdb_local_vlan_0.sh | 28 ++++++++++++++++---
>   1 file changed, 24 insertions(+), 4 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

