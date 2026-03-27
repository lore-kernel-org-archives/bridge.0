Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55BC366049
	for <bridge@lists.linux.dev>; Fri, 27 Mar 2026 11:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774611112; cv=none; b=hUfhUWgSvNmLhiUc5GbR1csKT/sB74K923dkc5egooBB3VLc4NfMCXw4TdbGc1ygD9zhlDErfSp50tLC57tP3sesv/FKA0Vy1TdCjvoRCm/24b7qpNwLlPEpS23fg77gT7Fz1xcZqBt+ewi9Pe2DJhCCnV1jAHVRu+EL8eu8xo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774611112; c=relaxed/simple;
	bh=RfemSCYO7Qpo6eUQ9+NOWyXgL3/HYNFzcucOk9JKzpU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HtEu2hL0o+gHdYiqM1kvp0Oc2xDKILA+Q72p9/q17kkingOKeTrekUonhHeJNlnHNepIz6C0qkJga/8ynmhf2TpBjfyaVX/0M7TTEoXuqu3OeQ+yOIT4doqYzqpV9DrqjtQXwTlzbClhhj1eSa6+KY76nl8/9TTLN7Yu5FcKnEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=HJYsHCy/; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="HJYsHCy/"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439b2965d4bso1515995f8f.2
        for <bridge@lists.linux.dev>; Fri, 27 Mar 2026 04:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1774611107; x=1775215907; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=77K0V4DrQKU0I/h2znnukzMgi4FIv6qKk6d+0fvRL7M=;
        b=HJYsHCy/mEQAYpdjTJEni3vEO5M7DudzZZPnki4S2ScnGm+XqoJnrMK7kvBRobyWko
         FsMUcYGTuwzKzZKMumzcitdyoV6mQproehyJ2COzCgCzEAJgP46YJLl0psvy87zBcGV6
         IHmkXjPUGJfyGS8+GMb2huV1wRu5x9mdKTBVh7phuRTZxA4/09+pPmpz+N2APgI//EFv
         YzWpDFDJe8HGBzrjaWrtBdt88u6smvQCehsrdFn5XnfKvk7xNo3ACwKx6OvXwtkxGrR1
         G8JjPpocwFHpPH/mPc35u+Qn34nn7/1hF+vek3kzba7jJXIqKc9TS6B/yJXjMclG759N
         9RGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774611107; x=1775215907;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=77K0V4DrQKU0I/h2znnukzMgi4FIv6qKk6d+0fvRL7M=;
        b=swciovskp5clu7zqj0Q8aPOlM4IMdJns3lO2svOzaS3OEHnXaobcZQQEhqXtX8OAEQ
         trnR+WBO92xe/16SP/y0YvYdzjKWBkbkJieMLLVLZgQpSkSP0X9Wvrt1pm6IWr0quU9x
         +8MbyFxSLErnokR+AvuDQJz4gY2A4Dvnb0IZ2+8IDpjuWfMd50FBiRqmva5fH5ljg/bk
         qIZVwv0X7k4/SG5ivQDdCtdfNEQIID5UGfmaxjnLMZ49UXaWkcDL1ZpVF7VvFtQxxrPI
         y1TP1dOBxcjC7juxxyIe5HLDsPe2NlCQDhl4Wu1cGstRKTFFUWqIW/ReC00QAOKfYW1z
         aquw==
X-Forwarded-Encrypted: i=1; AJvYcCXesHjT3dHBS8/Mv8jkczAzHM81Ch7ITJe4W/d5gn0ZVIQGJ7F3AfRSSaMBu/mqU5O3/7w+SYk=@lists.linux.dev
X-Gm-Message-State: AOJu0YyTBytiFelDjSw2RsX0qncc1Fnig1JG+SWvHKZasAT5TlXkf4KE
	RLbwOKhYAEy7uaWe2nJF94JbTOQKoJkmS0P9/v6wybtxGRFS9Zau7HW2k3FPmArdg2jc9DcEUph
	6j3Ok
X-Gm-Gg: ATEYQzxJ7WtYJfRAiVjYRHXKuY3aJyeWRT7oN/qGa5IwFNKnmhmmaj4/DSNjXHXEDFd
	65DTt/Txpc8qM+SSJ42objk2vf29EQX3ULLlx7bqOLznahxcw/B8p77t1ajxoOXlg0iw50d++x6
	tZl6nkfBW53biE/Nl66s971nnowg7wiP1d++THloInHmXfOms7C+B/EQcBxz6n593saoEJVb90r
	GZuoVi5Y0BRKcwD6k+euxcP5/nheL1b5WnGnFv18zjX1XDwHOb94MK3l5ArMn6OEaMeFdjnf3rz
	sOZFOBb8UeHYIh8LCkN77fMXZQMWSiwxR8C4gE+6Ehez1ZGBzvtQS5bwsF2qERx9WKZmokdBjeu
	N29nXDH4J2hI0equM1fHimLf62KDW8zbIj2u5dzLroSmv4/fH6BUb4wDySsQPGwNUpeYW88KNjk
	34rHhyil7h4NnXwOfsbWi30D5JHKh5fq3jx1ZK7hv1VVaKGLzNYu831w==
X-Received: by 2002:a05:6000:4013:b0:43b:3e40:2223 with SMTP id ffacd0b85a97d-43b9e9e8a0fmr2968001f8f.19.1774611105996;
        Fri, 27 Mar 2026 04:31:45 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919cf2b2sm15558913f8f.18.2026.03.27.04.31.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 04:31:45 -0700 (PDT)
Message-ID: <e78472a1-f11d-42cf-9c34-9fc5479db1db@blackwall.org>
Date: Fri, 27 Mar 2026 13:31:44 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] net: bridge: mcast: add multicast exponential field
 encoding
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Ujjal Roy <royujjal@gmail.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>
Cc: Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260326150742.50289-1-royujjal@gmail.com>
 <0e8a01b0-9b83-405f-a0ad-7b335135962f@blackwall.org>
Content-Language: en-US
In-Reply-To: <0e8a01b0-9b83-405f-a0ad-7b335135962f@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/03/2026 08:41, Nikolay Aleksandrov wrote:
> On 26/03/2026 17:07, Ujjal Roy wrote:
>> Description:
>> This series addresses a mismatch in how multicast query
>> intervals and response codes are handled across IPv4 (IGMPv3)
>> and IPv6 (MLDv2). While decoding logic currently exists,
>> the corresponding encoding logic is missing during query
>> packet generation. This leads to incorrect intervals being
>> transmitted when values exceed their linear thresholds.
>>
>> The patches introduce a unified floating-point encoding
>> approach based on RFC3376 and RFC3810, ensuring that large
>> intervals are correctly represented in QQIC and MRC fields
>> using the exponent-mantissa format.
>>
>> Key Changes:
>> * ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplify calculation
>>    Removes legacy macros in favor of a cleaner, unified
>>    calculation for retrieving intervals from encoded fields,
>>    improving code maintainability.
>>
>> * ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()
>>    Standardizes MLDv2 terminology by renaming mldv2_mrc()
>>    to mldv2_mrd() (Maximum Response Delay) and introducing
>>    a new API mldv2_qqi for QQI calculation, improving code
>>    readability.
>>
>> * ipv4: igmp: encode multicast exponential fields
>>    Introduces the logic to dynamically calculate the exponent
>>    and mantissa using bit-scan (fls). This ensures QQIC and
>>    MRC fields (8-bit) are properly encoded when transmitting
>>    query packets with intervals that exceed their respective
>>    linear threshold value of 128 (for QQI/MRT).
>>
>> * ipv6: mld: encode multicast exponential fields
>>    Applies similar encoding logic for MLDv2. This ensures
>>    QQIC (8-bit) and MRC (16-bit) fields are properly encoded
>>    when transmitting query packets with intervals that exceed
>>    their respective linear thresholds (128 for QQI; 32768
>>    for MRD).
>>
>> Impact:
>> These changes ensure that multicast queriers and listeners
>> stay synchronized on timing intervals, preventing protocol
>> timeouts or premature group membership expiration caused
>> by incorrectly formatted packet headers.
>>
> 
> Can you add selftests which cover these cases?
> 
> 

Forgot to mention - for improvements and new features please target net-next.

Cheers,
  Nik

