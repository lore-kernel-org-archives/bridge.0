Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F0A154AF
	for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 10:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Rb0EHCU0"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B32B82298
	for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 10:24:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1B32B82298
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=Rb0EHCU0
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6evWrYu2ODMi for <bridge@lists.linux-foundation.org>;
	Mon, 18 Dec 2023 10:24:53 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A79DC8227E
	for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 10:24:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A79DC8227E
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40c3ca9472dso32127245e9.2
        for <bridge@lists.linux-foundation.org>; Mon, 18 Dec 2023 02:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1702895092; x=1703499892; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bgqfxng/f1TeURYLmSla2oJOkzUelTfDM8uCrGRKaag=;
        b=Rb0EHCU0/ozJPsZtLF/Mh6pIbfwwTRPe74/G3qlrBZqXDhWSdcGKb6pszDF2QjmlSj
         YpwmAhH4QGdmPvsAR6wZCEUyvkdzIZ9L1D2P1/gypP0PNGEcrqI5lMlDNIYaE9Z3znCe
         tJeY7/Ez6Ijkihaav6m4UNnEMUZ7y2gWkL5DGLKYxWHFFt8chmFWIqFQxNtTkPCLthn5
         s7iS9eFhofwmQI/XjtzeckTNoN8LsponsjN/HPf6HQALG/JksljXvdktwpoNJj7VcYVe
         7PvEy604SrasZKiJSOR23xg5jWwR3ZeDrxeLSCP0QuTlDru94VXoVir85/0liAH12DRu
         ffuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702895092; x=1703499892;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bgqfxng/f1TeURYLmSla2oJOkzUelTfDM8uCrGRKaag=;
        b=fbKZ3qitQ04QI621fFq4RXj+dZs14g4YgycL1cimj3+zQAzfV+4Az+bO2vTTmn7B+x
         PedI0tIBugAW51l/E+1DnQrtFWfNysUc6peGUEJEzXBUEvIhhXYmGyJ+/KomRiHHmabF
         XUng3MoDQAhf7OMO7CytAOLWQDvfuqTopRGeLq/1difRlh+GVNTq91xalA3qKV2Z+kz7
         0mEsbURadBAn3PS2BAYgQyVBafTpU84IrRm4Qd7NJ6v/4q0xYXLUyLqxKGvbdSdi0OmO
         FnKfBSS6c75eAME8IcVgWsNV8YdZe0gAgS5e79EKeEYTw5/+Xuer6BBxt/eC32EcbMGI
         /JWA==
X-Gm-Message-State: AOJu0Yy6b+lDyCUqwjDLHdMKqW2Fko0qFEKDu+geyiyuxovZ9Mt5rFoJ
	87E1pgHckF9hOFscC9YLT5VMpg==
X-Google-Smtp-Source: AGHT+IHtjTd2rdStR2WSp5hVDvpU9VvdG8nF9k7zFxdFMbmk9kAaOH3qG7Z/8/HZGCF/iL9fGWqByg==
X-Received: by 2002:a05:600c:35cb:b0:40d:1773:2d79 with SMTP id r11-20020a05600c35cb00b0040d17732d79mr695244wmq.205.1702895091723;
        Mon, 18 Dec 2023 02:24:51 -0800 (PST)
Received: from [192.168.51.243] ([78.128.78.220])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c315100b0040d1775dfd6sm5777864wmo.10.2023.12.18.02.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 02:24:51 -0800 (PST)
Message-ID: <4d0d42c6-8219-48a6-828b-1743d28e871e@blackwall.org>
Date: Mon, 18 Dec 2023 12:24:50 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/9] vxlan: mdb: Add MDB bulk deletion support
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, roopa@nvidia.com, petrm@nvidia.com
References: <20231217083244.4076193-1-idosch@nvidia.com>
 <20231217083244.4076193-7-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231217083244.4076193-7-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/12/2023 10:32, Ido Schimmel wrote:
> Implement MDB bulk deletion support in the VXLAN driver, allowing MDB
> entries to be deleted in bulk according to provided parameters.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---
>   drivers/net/vxlan/vxlan_core.c    |   1 +
>   drivers/net/vxlan/vxlan_mdb.c     | 174 +++++++++++++++++++++++++-----
>   drivers/net/vxlan/vxlan_private.h |   2 +
>   3 files changed, 153 insertions(+), 24 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


