Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A37329992B
	for <bridge@lists.linux.dev>; Sat,  2 May 2026 06:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777701816; cv=none; b=bm9aFJQMGCGLSCNtvN5D5JvCVfTKTJjdvPg8YK12ZFBcUrtLnUFr+13q78prO88HaIARIsj3HLYbRGPZtCs8Xy167qEmAGYwoWtnm6OJEKxnKA5yiUm3eKgfX8h+5f0CmaHuxW8orrV0wf7G7pK8p6kq+eByy03u+SKEhFGuOuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777701816; c=relaxed/simple;
	bh=S7Lb+q3oEv3NVM0NPPBYU6eUyq6N8yTsNyIwBajUKE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dbDJ+bJznKASXDrDPcRXngpuTf8K3esvu/fnB9GsRx1b5zxGL7O534qcrKJWc5PxIdsfmTZCqBu8fyqWGMDHJJ8HvGry+jeXA0u6kOtctWQ9yUggDfqzs3nu2EcY2wXrG43ekgeYX2HEvoRTRoSqdTtHUg2lmLMUhyX0Nv+r8ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=KEfPwmKh; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="KEfPwmKh"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43d7e23defbso1386493f8f.0
        for <bridge@lists.linux.dev>; Fri, 01 May 2026 23:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1777701814; x=1778306614; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LZREXi6KS9s2NVYeEPr0xKFupND9na8xQrKsYAgQ4Cc=;
        b=KEfPwmKh07a36TaTKoZYkmVcJC0JT5trCFRiyQ0nCqpsfFl5bCHsTTs/wH4RFUZ0im
         9dlZtTp/MJEOGArKcgOW9DbvwbNiSueo7GWARGjTNj9jeDL6/dCXU0LB15lHLwct980S
         p5xiFWRPlt+f227tcXtV62Hi/EIlN3ijI7cdlM13UbAsLAi1Q02509XD3XOuEx5n1rLR
         8QcMLXLeajRDfdcenGy6EWA/S9MZT3dOCmTVrak2kzaLi5WlswLT3PL6A2KOYPfEod+K
         5a3Xb9dhj+kbg7/ERMUsf5tHmkWw+i+V5bdhV+CTN8SSVwG5I7uRF1n0UyirlxZv4mPF
         hZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777701814; x=1778306614;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZREXi6KS9s2NVYeEPr0xKFupND9na8xQrKsYAgQ4Cc=;
        b=NkvJiKI+3rAn6WjkTDR5MvcN9dNrCfg3hTUvZc4t3z3938099fMNrrurXr9haEn6iJ
         +GBfrQ7twjON5BfO4R4HWp2e+ZGt7iz0PDZa86/biEuorUd3Bf/a+vB8BF9XmcF4scFe
         LUM0FTTBHmRahWcjpnF/E/7X5su/wHtYxyNTQgDoI/LO0uSeqbnWnUfnDVIzfg/JoXuv
         b7flxLvHOx3s4IcT/Kcu7TsEMSiwmcn8w0nGdNUbR3zw7WFTVqayBpfB8R/w7aS1h3Pp
         IAPSPh2CV9/Lc0wvZnikq8evSrJazijoI0RpHsURqcT8wqkTWASFraEU6zagJFt/Mijv
         1cWw==
X-Forwarded-Encrypted: i=1; AFNElJ8xng2073Rv/EZy9lAwR2uw2+GV0sn3d2DFb3ImTTvqTejhnv7rTM8xRT7znpjuBg6xbjRusqM=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywjx4BdXc9xmH5GHdMlLt0exedqDBZlzmbzYEc130ZgpD8Mfz8S
	pk87sivSNHcPGaYEDTFNFnAW6HziJbo4rTEEE1IpQi7fgmlI8jh5B6XU2IT0ohjKW2Q=
X-Gm-Gg: AeBDievpl6R62Q5Ob943oFCkU7M/oZAzFmsHWccWGQxMZtmaonAOPKYpvjH64aeXHyV
	+58/Q5A02l7VpCIYD29SLwE3kRKILrGRCiTUA1lYfMpZRR3HW1irWesarMFOhq+ST18eToVv+Gr
	iTLlWuUubt0FoSCRpU6Df+NqxEzwDfeAlp0D8b5nl/G6/dTF+JOYtIOhND+HjNH/Pxmt9NBfg9p
	9nG5wTlRPFB1HCAvDzi+RNuJMzCcRn8m8w6VEI4Ukag6DfFDzug5Or+24Y5e6vEZvCtGw+2kjJH
	rBgEN8iyaB2DmGCqlBTSVQYS0BOXObjd1ri5V/lUj+t46CUOzzcBj45pvOuEoVcXU/VFg64/k9m
	vKa1DUWtwVGOAPA6OWa4FSwLrnR99fxEayRu/GCd8co+iJ0HqkQHkDCi6JQ4w+lSAB2lM5sfLjE
	SV13oYYQBKjRFEcTdsP6ZF1Z/0P1UAmI64mgLTmPK2VfHy27GjwyR+odQbv4oyOz3v
X-Received: by 2002:a05:600d:8453:b0:48a:5339:ef0e with SMTP id 5b1f17b1804b1-48a9852f5e7mr19973775e9.3.1777701813598;
        Fri, 01 May 2026 23:03:33 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fee4d60sm27091805e9.19.2026.05.01.23.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 23:03:33 -0700 (PDT)
Message-ID: <82343bf4-18ab-4482-9241-2f235f6f1449@blackwall.org>
Date: Sat, 2 May 2026 09:03:31 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/5] ipv6: mld: rename mldv2_mrc() and add
 mldv2_qqi()
Content-Language: en-US, bg
To: Ujjal Roy <royujjal@gmail.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>,
 Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>
Cc: Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260501173130.3486-1-royujjal@gmail.com>
 <20260501173130.3486-3-royujjal@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260501173130.3486-3-royujjal@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/05/2026 20:31, Ujjal Roy wrote:
> Rename mldv2_mrc() to mldv2_mrd() as it is used to calculate
> the Maximum Response Delay from the Maximum Response Code.
> 
> Introduce a new API mldv2_qqi() to define the existing
> calculation logic of QQI from QQIC. This also organizes
> the existing mld_update_qi() API.
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Ujjal Roy <royujjal@gmail.com>
> ---
>   include/net/mld.h         | 66 +++++++++++++++++++++++++++++++++------
>   net/bridge/br_multicast.c |  2 +-
>   net/ipv6/mcast.c          | 19 ++---------
>   3 files changed, 61 insertions(+), 26 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

