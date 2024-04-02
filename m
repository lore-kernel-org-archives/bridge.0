Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326C31E525
	for <bridge@lists.linux.dev>; Tue,  2 Apr 2024 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712050124; cv=none; b=oA/i0wj+jrJg0zfI4AowpT4E65az8zCzIBE5PgG9tHtRAHGpF7zhegs7sMHJydZ9FvkJwlLisHDamJDyjfEhlAKmQ044e29hrokh/Vc8o/MxHF2zwd5SWe3Y+nuRUBQ7HXP4vzc9dAxuCmnpPv00wFotUvI7zFGP8essWwXSkVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712050124; c=relaxed/simple;
	bh=SaHdWyZMielfHTNhw3NZ6AoIsZ4bpjd1xazWDgacU6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XU+ZCTXUIh6bjblkUxEKAaXHuXKqey/IIVrErl5CIr1b28V0pDCCooKOQDgQFD4tW+q7nIjdBAX0SpoEOy906wXvtn4dM+/YRGCxeqSB7Yn/toQDs1i6bC3LWzW5gqoFVbC1c3WEyMPgBZ3bUK9xAcqve+s+CoME/DaWMXAbcqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=VLh4DNu+; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="VLh4DNu+"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3416df43cabso3481567f8f.3
        for <bridge@lists.linux.dev>; Tue, 02 Apr 2024 02:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1712050120; x=1712654920; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xHNO1hVo3g5ZBLDGdpQZsS60/lEQyobzAsIONNu4tIs=;
        b=VLh4DNu+oXLNalcmueEOwiEljlJ+1aA1fdUHtJPRDeP2mfqktqaBSCwvhWXNj9dtYW
         8kURjqc+dbZJ6ehYauUinJZbvVcDZDPLvpM91A4Xpl4zCVjXCYT0vGlzvG1ur2jOyOAF
         0BEbfQM3jt4ELTjgXuMTf39Qwq7xXQVorW0XqmHiEZeHwqjNuehkHIjnHfx8/3B8DEqo
         Xgu7kJQvRAcSVQtut3YvsC+w0pohqT/illmc3vHQFUj2oVl+O+KFynsH00xLp89ve5pR
         3Gs4HRV7aVRIBaY7Q/9LTNZ6QA4mOlBxSTLMEgNFLxd2MRhYSlMk+RuhTOdtoYlNOmFJ
         Ebng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712050120; x=1712654920;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xHNO1hVo3g5ZBLDGdpQZsS60/lEQyobzAsIONNu4tIs=;
        b=WNWu0z7iGNQsy/9nbxqGSGMz7lNw4F5diBxTvFZHRd49PMjifz0wtqPt/ZK7HBOz/y
         bOzwVdvaCCfpkr2C7vdI2Ej148jP5knfFjsjorAxUJQXSuvRrVv47yVaK/Y4tfcRKBX7
         SCAEp8OfW1uUMZ+qdwaUtrv+/fpJnrvEXeVfCHak88TZWZkNZsHpGy/xBIUCLmBfGykD
         PfR2VcIhbqiFgV9a3cv8wIfCEtaRXSo9FykurLMIZf12HUBsSRMf8g9sS5IQI2nxMhbj
         7bkhzRyMgzELQF5C82wRY9uYj1qfJKfYz8Msd8ykKTqTg4qxQIamJgXEBnMCUdkmoArm
         0N4g==
X-Forwarded-Encrypted: i=1; AJvYcCVHwmhWfACeoY2tt+tjd4WMV0LQ6lCUBNDEttYQWAE7ryCEaijJRzTpLnBmtirEcGMl5KNklwhIc2qOm+nqZfHb60ZKX6mE
X-Gm-Message-State: AOJu0YzAlUjdlIjVwBEe/1BgevezfQJm/uP4MEcbwKdIAlOvKjqk/9oJ
	nGkHY7skRNzjsbQmRSXJR+LY3/sMTrs92OqQqH8UOca3pJaho5BZYVRBPs+uVsA=
X-Google-Smtp-Source: AGHT+IEI24f1p1p1BLDEE6iJrpvuBCcj4zOyiUqGHCc+h7DoytXVrqcMxVKkFly4F3F5rVn71rvUOA==
X-Received: by 2002:adf:e011:0:b0:33e:7896:a9d7 with SMTP id s17-20020adfe011000000b0033e7896a9d7mr8560010wrh.67.1712050120249;
        Tue, 02 Apr 2024 02:28:40 -0700 (PDT)
Received: from [192.168.0.106] (176.111.182.227.kyiv.volia.net. [176.111.182.227])
        by smtp.gmail.com with ESMTPSA id en19-20020a056000421300b0034365152f2asm1170910wrb.97.2024.04.02.02.28.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 02:28:39 -0700 (PDT)
Message-ID: <7fc8264a-a383-4682-a144-8d91fe3971d9@blackwall.org>
Date: Tue, 2 Apr 2024 12:28:38 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 00/10] MC Flood disable and snooping
Content-Language: en-US
To: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, =?UTF-8?Q?Linus_L=C3=BCssing?=
 <linus.luessing@c0d3.blue>, linux-kernel@vger.kernel.org,
 bridge@lists.linux.dev
References: <20240402001137.2980589-1-Joseph.Huang@garmin.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240402001137.2980589-1-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/2/24 03:10, Joseph Huang wrote:
> There is a use case where one would like to enable multicast snooping
> on a bridge but disable multicast flooding on all bridge ports so that
> registered multicast traffic will only reach the intended recipients and
> unregistered multicast traffic will be dropped. However, with existing
> bridge ports' mcast_flood flag implementation, it doesn't work as desired.
> 
> This patchset aims to make multicast snooping work even when multicast
> flooding is disabled on the bridge ports, without changing the semantic of
> the mcast_flood flag too much. Patches 1 to 4 attempt to address this issue.
> 
> Also, in a network where more than one multicast snooping capable bridges
> are interconnected without multicast routers being present, multicast
> snooping fails if:
> 
>    1. The source is not directly attached to the Querier
>    2. The listener is beyond the mrouter port of the bridge where the
>       source is directly attached
>    3. A hardware offloading switch is involved
> 
> When all of the conditions are met, the listener will not receive any
> multicast packets from the source. Patches 5 to 10 attempt to address this
> issue. Specifically, patches 5 to 8 set up the infrastructure, patch 9
> handles unregistered multicast packets forwarding, and patch 10 handles
> registered multicast packets forwarding to the mrouter port.
> 
> The patches were developed against 5.15, and forward-ported to 6.8.
> Tests were done on a Pi 4B + Marvell 6393X Eval board with a single
> switch chip with no VLAN.
> 
> V1 -> V2:
> - Moved the bulk of the change from the bridge to the mv88e6xxx driver.
> - Added more patches (specifically 3 and 4) to workaround some more
>    issues with multicast flooding being disabled.
> 
> v1 here:
> https://patchwork.kernel.org/project/netdevbpf/cover/20210504182259.5042-1-Joseph.Huang@garmin.com/
> 

For the bridge patches:
Nacked-by: Nikolay Aleksandrov <razor@blackwall.org>

You cannot break the multicast flood flag to add support for a custom
use-case. This is unacceptable. The current bridge behaviour is correct
your patch 02 doesn't fix anything, you should configure the bridge
properly to avoid all those problems, not break protocols.

Your special use case can easily be solved by a user-space helper or
eBPF and nftables. You can set the mcast flood flag and bypass the
bridge for these packets. I basically said the same in 2021, if this is
going to be in the bridge it should be hidden behind an option that is
default off. But in my opinion adding an option to solve such special
cases is undesirable, they can be easily solved with what's currently
available.


