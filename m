Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7051A1B87F2
	for <bridge@lists.linux-foundation.org>; Fri,  4 Apr 2025 10:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743762747; cv=none; b=mGCPiaPpgMzOy5ad5mWkhdVTxtjPEDKm7Mql78nMON5JGvL8Y59q+73TzPzEfocIvm/uG7gq02CLt+/NFMvJYKrfprzj29Cp4uJH9l8nZXv0NBWFa0GwnzaIvhB4txAbsSV1Z8FX7FhUWWrMGjWol11Jk83LqVM1n+D47AMftjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743762747; c=relaxed/simple;
	bh=/eefFO5H2rkJhZAMwjPkmwG4Oxm/AsjJOcWPdE69QPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pUyaa2EYRSw49FvPhEljuc4kK8tCl9s7ZEQ/8+pIWskOrSl7W4moevjSZ29BUeiuq1foEWuaiWeVxDuVO6XTkCEeQh4qd7G41YWaWlHjveQOKGnOembyjNEUN32bgiXD6Q18UnZsuZc13P7OIqchK8Tc1xr3j5R1GxRpq9yxiYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=MTp516zs; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="MTp516zs"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 232AB6FACE
	for <bridge@lists.linux-foundation.org>; Fri,  4 Apr 2025 10:32:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PnW2IHOTU7bO for <bridge@lists.linux-foundation.org>;
 Fri,  4 Apr 2025 10:32:25 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::341; helo=mail-wm1-x341.google.com; envelope-from=razor@blackwall.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 79C2F6FA13
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=blackwall.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 79C2F6FA13
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=MTp516zs
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 79C2F6FA13
	for <bridge@lists.linux-foundation.org>; Fri,  4 Apr 2025 10:32:24 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so11612135e9.1
        for <bridge@lists.linux-foundation.org>; Fri, 04 Apr 2025 03:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1743762742; x=1744367542; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9NPPqHWD7AMDiD4PKiUNW9Uy03GasUv4r/53C4cJhf4=;
        b=MTp516zsyEe+KW+eZ90zscPDmU6jiCb0BEx/9D8syRxEkDJL6yM5He/tLaMi/FTSYr
         b/SRuE+NusrDTprXvyZhP8ywnV8HgtbPgKs/jbbVwuPCuowMoKsH2MxwGJWZHhx8RR1Z
         k/4ujAtMm5sxIVK1bP8YGBJNO65fV+0zXuaNKzKLjq/vlJFpfTQ3HAat12LeZqc0BtyL
         uoMzIdDGKXMgrgxYcFN/UFzjylfg+aGArhecjK2gJclJKDjzDwG6E4ZLfVv0fLfHO6KE
         6Xy1uN8Cf/cV6q4jYSQNvkhuZ/fy2wRpsRBmJg8gAW9b297Gbw+ZUCwhVhyjiSpKUuGY
         ZUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743762742; x=1744367542;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9NPPqHWD7AMDiD4PKiUNW9Uy03GasUv4r/53C4cJhf4=;
        b=UfKFTa8oHyFgce8I34WvtUkTaukXx6CoLzz+MhzqMO0uf+3+elFSG3DsOnGEBPzN0T
         Tp6mph80J9XokE5acuSx0xWXRpUTIQg0AajABDB0Ysz8MC2/pAQ3zu/23/J0+Jwgz4KU
         pn3xPiJgcB1pV30a/M0lH9OTB04XPaEqvuhAkxSa0sqEG+qGERDjI73C7iB5yWmxt9yh
         hYrkoVWG/aAXxZUPjXcUPYP5vAIQbIYyb45b4I2e9lXqULBjBEEZcGMm4gp6avB8oMF6
         HXjtF6rqcZ+IgbSDt+XAbMwFksfj+ugkxkDLqadFxNg8DmCvk7Hawl2VNfi8ZMSoIfov
         Ieag==
X-Forwarded-Encrypted: i=1; AJvYcCXd+ILsl4rDsG4oLWzWIAio0aLtOJJNeQifXy7jtQqcw7pJgT/ZdDFPznSQLhn1yk6/l3yZdeI=@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxHb+ZT6/UqHvJeT+/NNqOFxj3kNTYXZ+FvgbkMEE1VIMPOP5rQ
	X9Cxw7/B374n/s4JXrs8Ls8LZ+5qBpDUPmbINzrKFGa+haB+Tpvs0UyUw8exoTU=
X-Gm-Gg: ASbGnctQQIiGmlG3UGHzQp1lI+whBFbyKOHC03Ugmh65UleJUSncWSMRyxRkGYnZ2KB
	8tchOW5jYbL20BP7rtoDmSHsRRZIQYJmCIqOu/4Dd9bSAmCHBpFC/ZxSprynQ8LVYDHFbx9swCj
	RnCpOhFMXzA8tcuvlGnLNjO4MC7v94c251xqkAnuWCrD0FYR5qMLkn0Y6JDwb/VgmUvW0OKvXjM
	1rV9lNoou9/pNndKdLZpefyZVdv7ACxQ5Gmm6Jd5W7qUoIANAsrjUFDUXOHs/i2D4as9vxUrMOt
	qDY8wi7sk0mMh292Tvp5bw72sWVkhkaEJyuz3f6WVTiu5AKzw2fgC43ZCq16AiEBbaxsJgKEQGs
	u
X-Google-Smtp-Source: AGHT+IG631D8DMeVx3hSdyqQ7JDFDf392sDkYb35wAo8+cxTeaolfX7nYV8l3wZAFDhfxjEVcwG8UQ==
X-Received: by 2002:a05:600c:1d14:b0:439:4b23:9e8e with SMTP id 5b1f17b1804b1-43eced994a9mr24466825e9.3.1743762741641;
        Fri, 04 Apr 2025 03:32:21 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec17b0a38sm45200295e9.34.2025.04.04.03.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 03:32:21 -0700 (PDT)
Message-ID: <662b83fe-ae5e-4460-b2ae-2042ef8e59af@blackwall.org>
Date: Fri, 4 Apr 2025 13:32:20 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 iproute2-next 0/2] Add mdb offload failure notification
To: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Joseph Huang <joseph.huang.2024@gmail.com>,
 Ido Schimmel <idosch@nvidia.com>,
 "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>
References: <20250403235452.1534269-1-Joseph.Huang@garmin.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250403235452.1534269-1-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/4/25 02:54, Joseph Huang wrote:
> Add support to handle mdb offload failure notifications.
> 
> The link to kernel changes:
> https://lore.kernel.org/netdev/20250403234412.1531714-1-Joseph.Huang@garmin.com/
> 
> Joseph Huang (2):
>   bridge: mdb: Support offload failed flag
>   iplink_bridge: Add mdb_offload_fail_notification
> 
>  bridge/mdb.c          |  2 ++
>  ip/iplink_bridge.c    | 19 +++++++++++++++++++
>  man/man8/ip-link.8.in |  7 +++++++
>  3 files changed, 28 insertions(+)
> 
> ---
> v1: https://lore.kernel.org/netdev/20250318225026.145501-1-Joseph.Huang@garmin.com/
> v2: Change multi-valued option mdb_notify_on_flag_change to bool option
>     mdb_offload_fail_notification
> 

Please CC bridge maintainers on bridge patches.
