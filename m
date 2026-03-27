Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6813BED35
	for <bridge@lists.linux.dev>; Fri, 27 Mar 2026 06:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774593724; cv=none; b=h5va3WakQwu3HVGmHSAsWYFZv7BFq1UMK4FobIoztIJPD+2Nk+A8e2yH+XJrWdR6HC27mqHovvLSaeqSpI6+ykJtOYl403OjI6upTuVUmzuxc6ZYeAx8yFXcg7sYp1fXS/tEmPNcuhUWo5y6rr4mVV9y/zu/crpXHk+kPgfIEbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774593724; c=relaxed/simple;
	bh=1DVvOQT5/+mxb45EgxQ4bZpWpNiDNjMj+xSlK6Mjv9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=utLQnFoylHNh2idj3Fds7Vs6U5YOYyA9UjT4j6TFsWNnEzbyWJGxhuFc6DMTb2qXBuhNNvbzpSNhJ3jgElbofmGWEWWNJ0VLBFZkTrpFuHKwPSiN4JWpHAZl8ADtCNHkclPnzPVvfYmb2A/FoFlp/J4pFdDRzvMuH2QpNkWtRgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=SaDC/Zqn; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="SaDC/Zqn"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-482f454be5bso25839945e9.0
        for <bridge@lists.linux.dev>; Thu, 26 Mar 2026 23:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1774593711; x=1775198511; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n1sYbnxelvK9CSuY2huaIB6H/ZT6wbmHM2ZeRybED1c=;
        b=SaDC/ZqnSRsSqmyLn2opHgCwbh5g/mv0JObsQbMtMnoLVgMw8a+usmER1yy1QBAz2D
         Wjp84EWTxK9a9XVkn5oibyWN5vo374hbRrCPHW5FZvKVMNacnDUaZ68JV55my69locW8
         PjwDhL1DO8eOQQKS/Yie+gSBhrlbz/qvSyE47gaP+Cwik1wQKKLldMfGYgIEVeW2tMhU
         CNV/P5/Ur64725CljgTkpr/q0OcVh3iVgiRWuR3o0IJr4EpokAlUYxSlL0Tn4gBKhj27
         B7b+OEbkpxaRQvYrJwzJ/5RUMtt4dmr3WWt4eEXGTwIwZ+6TqNbGLtKdcwgKG/XDC2QM
         J62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774593711; x=1775198511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n1sYbnxelvK9CSuY2huaIB6H/ZT6wbmHM2ZeRybED1c=;
        b=iwSayMvCvOx1bmZyZ6Z24yU9y/2n6OW6W8ujHf1bO6OotuOLfXx7yYrw3CzWQ+E4/R
         RViocll+ZTpw1+4XrhyCkmekmXlWcJYjYMPQdbWZR0LOmDuqEEShhfpS6QR+qw4l/WWF
         2MHNn2nTjl2ZIv/Hg9jCVwDev5pgS6QdnbOQZ1TMoFILwNGriUP8pBWF+G6UxHOI+W+i
         zKzYmN4NRZzQoaWKQY3xORjNO4Du1TzdRe+4QqUGB4aOOnatN8zmkGQo012H6L1A+Je5
         zJR9wnvn0hpDfa7akGqQFd7NUw6uuq9bzRGXBLOfIkUeddx4f9jLgZfBvg9eXST7FDYp
         47nw==
X-Forwarded-Encrypted: i=1; AJvYcCUt4AGXmgQxUXqj5CFCD1WKHWV/vvHEfrqotGmJgoCXuulD/kueae8q2g1PYIqgVGoT82k3xpA=@lists.linux.dev
X-Gm-Message-State: AOJu0YxUkdx95MxOVY0RIWdhTmVXuVAn3thXetpKkKjykjRRsEEgvrQO
	92bCB+3PNJttGED2HPK84HF4ne10sgzuHPwxc6XXMez3OHP76pwxFdvSanpdKAjZ0zw=
X-Gm-Gg: ATEYQzxyiJt8A2pvC+2XRF97UiMlz5b9T8hvUmqXUPDY2zVAnKdLBqSSG5DrJvU2MiE
	pGNrnPsiAYgcc/I6f0/YKVb7u7IslKcaIUTa2PD2MqRI4ktweF8g3SL66KtUcgXElFVgfMWKS3A
	nPlwinpy0T62a1jahOtLT3+jpFNKIMnKd5B3DzEa0FQDbqezGaHTkJrQai3PVy8sW/DQU4FPek8
	PTw4s6aZyQKX1YrNeXhZSm5DeGRI+dcQfkSs9+jGHtjpK1L2auzZnFzXO8yuWGZnDGQY3Y+T9s2
	ra6R2kpXYkClRMJBbwUe/oia6tJCLU2YUBYdIhqEcv6ieOMakOhoc/gFKX9BT/ejQJaCQGuw0fB
	WaKDJ92BQdalUkXFERoxRF8+qxSgx+Ua92t2TyWqCGDadik0TCozNVjI0cohrNWPN+V5RvxioFk
	YZV5sAUUy3sj1ciU7OZArqoUGmUKWjh3W9JeDEeCubeMbfwV3cVuTj+beG6W/DEu8s
X-Received: by 2002:a05:600c:45cd:b0:486:fbc4:8fe2 with SMTP id 5b1f17b1804b1-4872912dd2bmr13078015e9.15.1774593711374;
        Thu, 26 Mar 2026 23:41:51 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c9f58fsm121225245e9.11.2026.03.26.23.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 23:41:50 -0700 (PDT)
Message-ID: <0e8a01b0-9b83-405f-a0ad-7b335135962f@blackwall.org>
Date: Fri, 27 Mar 2026 08:41:49 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] net: bridge: mcast: add multicast exponential field
 encoding
To: Ujjal Roy <royujjal@gmail.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>
Cc: Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260326150742.50289-1-royujjal@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260326150742.50289-1-royujjal@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/03/2026 17:07, Ujjal Roy wrote:
> Description:
> This series addresses a mismatch in how multicast query
> intervals and response codes are handled across IPv4 (IGMPv3)
> and IPv6 (MLDv2). While decoding logic currently exists,
> the corresponding encoding logic is missing during query
> packet generation. This leads to incorrect intervals being
> transmitted when values exceed their linear thresholds.
> 
> The patches introduce a unified floating-point encoding
> approach based on RFC3376 and RFC3810, ensuring that large
> intervals are correctly represented in QQIC and MRC fields
> using the exponent-mantissa format.
> 
> Key Changes:
> * ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplify calculation
>    Removes legacy macros in favor of a cleaner, unified
>    calculation for retrieving intervals from encoded fields,
>    improving code maintainability.
> 
> * ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()
>    Standardizes MLDv2 terminology by renaming mldv2_mrc()
>    to mldv2_mrd() (Maximum Response Delay) and introducing
>    a new API mldv2_qqi for QQI calculation, improving code
>    readability.
> 
> * ipv4: igmp: encode multicast exponential fields
>    Introduces the logic to dynamically calculate the exponent
>    and mantissa using bit-scan (fls). This ensures QQIC and
>    MRC fields (8-bit) are properly encoded when transmitting
>    query packets with intervals that exceed their respective
>    linear threshold value of 128 (for QQI/MRT).
> 
> * ipv6: mld: encode multicast exponential fields
>    Applies similar encoding logic for MLDv2. This ensures
>    QQIC (8-bit) and MRC (16-bit) fields are properly encoded
>    when transmitting query packets with intervals that exceed
>    their respective linear thresholds (128 for QQI; 32768
>    for MRD).
> 
> Impact:
> These changes ensure that multicast queriers and listeners
> stay synchronized on timing intervals, preventing protocol
> timeouts or premature group membership expiration caused
> by incorrectly formatted packet headers.
> 

Can you add selftests which cover these cases?


