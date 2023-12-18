Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018BF13FFA
	for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 10:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="VKB/qwIp"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 61F1B60ED4
	for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 10:12:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 61F1B60ED4
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=VKB/qwIp
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZIuwe1bXUgKL for <bridge@lists.linux-foundation.org>;
	Mon, 18 Dec 2023 10:12:00 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 12A1560AEA
	for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 10:11:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 12A1560AEA
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50e3c6f1c10so456146e87.1
        for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 02:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1702894318; x=1703499118; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wnw+qbk0VP/BP6lvQ4oZ3vUOazKKIyCaxjztZbrET5M=;
        b=VKB/qwIpuF0PArXydQqY/SGmAcyOiGR7x5QrchROSV3pNXDg6K7LvHvaOsZETEVX33
         F4wqcNpOBM7n21oQ1QUna30ZCCD1kduFSMzOlSL/GeCQGXwL6/O6j8Hb8fDRW86CPBW/
         M0ovUty00lI6mmXUmv18oa0n+aXT68PsXt6rCzYx46z8dzgdXJfQlKyxeDvyi2xjJ5Bp
         pZzzcXLUJZC26i2PPJh94ETsH7Qp1YVfmq8eBRgwb6Xk2iEHqSOw5jw+8azceDLF2rBe
         0CYH4Ukm2LByfDCn4B+dORP1ilhX5DWTAy0N2985VDdhVOyVDGmYHF2Ua1iPT5kQ6Xoc
         s8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702894318; x=1703499118;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wnw+qbk0VP/BP6lvQ4oZ3vUOazKKIyCaxjztZbrET5M=;
        b=JSXwmZk8E1k2OdbVoO8qcokm5BSn1ojV6u9wOQFeVloOtca3BNftqU4+tm3fV9NBfb
         P79l1qt2uwMKAl+JERMYf70R5sCCAENmg4HuuGlc2GEu7F1k7VY1ugUlXgqCHGVcob37
         3LN5Ma20YXN944f5gObLjZfB2QnAj/UFsfpNHRvf/LHZuSwS8mUvnyv4zuPL48G359Ls
         ZFdQlZAE4mCOQE+yqzKqAP35bfXO0Ep7Rh/oS+AgIVVLekkMJXE/4sVs1bQUCQBm1JPI
         gahH8YLzonJGmCFK427ZEFLRL1J5yJTgb/H89fqWZcuoOckc+6197DeWF2i3Vg/TLiMV
         SmAg==
X-Gm-Message-State: AOJu0YzK44TTy7MUKEJhmJqvupmuBfYBsycUDvgT3ZU5tHrSILRC4J+S
	mPrYkHIwF60jcB2mX/MN8qcTLw==
X-Google-Smtp-Source: AGHT+IEOP30S4bcfVGOUNvJcKtWrnryg+mvVN3DzpEsX8J1CAg1+0/WqWVH8QvtR47BNvhMCBRj1Gw==
X-Received: by 2002:ac2:538c:0:b0:50e:da7:d4f9 with SMTP id g12-20020ac2538c000000b0050e0da7d4f9mr2078466lfh.209.1702894317762;
        Mon, 18 Dec 2023 02:11:57 -0800 (PST)
Received: from [192.168.51.243] ([78.128.78.220])
        by smtp.gmail.com with ESMTPSA id h7-20020adff187000000b003366d79edbfsm551862wro.67.2023.12.18.02.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 02:11:57 -0800 (PST)
Message-ID: <761761fe-d69c-4b38-ae3e-34e7d1854a1e@blackwall.org>
Date: Mon, 18 Dec 2023 12:11:56 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/9] bridge: mdb: Add MDB bulk deletion support
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, roopa@nvidia.com, petrm@nvidia.com
References: <20231217083244.4076193-1-idosch@nvidia.com>
 <20231217083244.4076193-6-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231217083244.4076193-6-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/12/2023 10:32, Ido Schimmel wrote:
> Implement MDB bulk deletion support in the bridge driver, allowing MDB
> entries to be deleted in bulk according to provided parameters.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---
>   net/bridge/br_device.c  |   1 +
>   net/bridge/br_mdb.c     | 133 ++++++++++++++++++++++++++++++++++++++++
>   net/bridge/br_private.h |   8 +++
>   3 files changed, 142 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>




