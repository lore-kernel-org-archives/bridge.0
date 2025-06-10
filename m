Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACC328F507
	for <bridge@lists.linux-foundation.org>; Tue, 10 Jun 2025 12:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749558095; cv=none; b=t9g6QiMjGCD9PqK/voGlaxZ0AECBSj5NMPoLdyZW3eMObKuHqO5erjGsrmvnKqVahfk8Jo2VSdVk3ZOJOqVGRoe/2/Iqr1FjHnrfDJkMSJiHHB9ZSajQVGRHL2KNMcs9L+/K6YE3tVmsKMy/FUDrM1DdRdflRcuDohIjzawkvss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749558095; c=relaxed/simple;
	bh=j+kjI1Cr46kXYcnCOLIGfPEopv/e5BdzQZE6/Lie3LU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OX0toJhiAEcgMceWxgUfeWgV4VUnbbBoM7k/kpjTMASXJFVipf3KUxzT1Sv9ETShWHMAExrVa23sxHl5mGleaf55P74NZY26cAzXzAc/fd7AhCkPhqtdVx4tM3Wc/sk7atmzZYtMP5ZhI0+Thpqomz5zvrRPbtc120Qc58LZctM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=dxH9gnMX; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="dxH9gnMX"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7990940139
	for <bridge@lists.linux-foundation.org>; Tue, 10 Jun 2025 12:21:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8hRQZ-xILuSP for <bridge@lists.linux-foundation.org>;
 Tue, 10 Jun 2025 12:21:33 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::131; helo=mail-lf1-x131.google.com; envelope-from=razor@blackwall.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B4F7F40123
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=blackwall.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B4F7F40123
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=dxH9gnMX
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B4F7F40123
	for <bridge@lists.linux-foundation.org>; Tue, 10 Jun 2025 12:21:32 +0000 (UTC)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-54b10594812so5934102e87.1
        for <bridge@lists.linux-foundation.org>; Tue, 10 Jun 2025 05:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1749558090; x=1750162890; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=90hBZk4CDyR14IAw9VNCcUh9JhW2CycBOFXCvhBzbfs=;
        b=dxH9gnMXa4zxaoq6GTPrq9llcThPesqE64L8XFlx0keT2qQrjk5OVHuQqcE6X+fXIn
         dcrwZNQpEmKprjo5BZU5KjVEFccf7G0N9uS5hDyz6LRpxIqpzXflhq3BDq2BGY/YIR1o
         luUH6ZmVzidSQiCboyMQjG1GnVzD4pNFe3DoKgqFkjP4WIMMsGMbyFaeY8z+gobcJm2g
         VaOobFaZ/Pua0vixOA2WDNKcOrYizPTNbbknzHlQDZGj2D7uKXoMnMTxaUMgvXxqH3VF
         qwoxSuVnq0nHV6kBluDSWqpA6/m4zOeRKjlxMqpSA+mJEgODSWXZV3Y7dgANhGo4xAlW
         n9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749558090; x=1750162890;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=90hBZk4CDyR14IAw9VNCcUh9JhW2CycBOFXCvhBzbfs=;
        b=QYxkUbEByh9XrjR1Txf08uQqmWgks5pyc16UuSSFBixltNc4wb2zLHwvKs7CayurUL
         lLz8xDRpeXdA3c5/yP2GFjM0A9FGlz5j8SOS0GBXFLvmh6Odi4GrkuWEQN4+xdIIoo+6
         LnBH7e46oc5WqYdfnLC0cIChShDQxQAqATFnOrJktXBgU5EB0qkdOjzENTqv1Lj4GWkk
         cmXTgo2uPOihuo9ueDROtqqT/LEL4jdVcjyhcyhe6Mc1KPuKnGsqCMu/H9nxTrlKGhBL
         X+3tiPVYMWdydt6xAxW/fAFeBOLMT9sEKWDAR6V1LJVbq6wx/SPy1G/cDBU7QncAz/vo
         CbSg==
X-Forwarded-Encrypted: i=1; AJvYcCVhBf/N/I6TMAWIa5heOGYuSnOE1PTvUQlElSEHcm5vsxbdAMDnbDMWaUwclgePjGZeoB1zMfw=@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwJj2v5khxpQBcqaKG/KlXde6ND7LCjOFEcX02raW1Aew2OMDqo
	7/WjYTCaZaNhukem7IIRHnEE2YeEV/PBylsN9lDl0p2bbX4zcmLbwayz/8ngcui4mYM=
X-Gm-Gg: ASbGnctLW5JOnp9gEecowDdte7xYjM8bzLgVuiUA+s+2qqw3hV7mpYlpnoClCS/NeJE
	ufbxkrCsoSIaWZAW2TFYztzamhFrLkIziN5UBSI0AV+osk4TEkiyTgjGnV8ukUw2h8+4q60hVu4
	R7ai43lh9Yx/1qiuNfCKze7hufGXlqI8FikqH2u6JkJZUlbmikiTJhTBCbvMzLXRxTIUCGssqAl
	nl8jts6MqxthQpzTAgYxS45nHEMq9+gSHGFAFF1luMyrSeun3HPRuAjXa5qwa2M1EB+IsqpK7TN
	XwtiPJhXaN/DtbFGpgTvZPr72sk+vSmZghAIOK5NLbjUQZ/wkjuGSq5XCMLGwQFg3WHpD07n54R
	SobBgEGn89GfojGpPzPZl8qbJU21JLrY=
X-Google-Smtp-Source: AGHT+IHmGTena6fqAcYhevTo/MniFuCsCwAJhSNtQSdZdrt8rUXODpILzrQfAf1qsCiMYoGHYp/zgQ==
X-Received: by 2002:a05:6512:e88:b0:553:2f78:d7f4 with SMTP id 2adb3069b0e04-55366bd23a5mr4565732e87.7.1749558090387;
        Tue, 10 Jun 2025 05:21:30 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55367722181sm1557175e87.132.2025.06.10.05.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 05:21:29 -0700 (PDT)
Message-ID: <552e0ea4-f8b0-431a-9382-95adad7f2b9f@blackwall.org>
Date: Tue, 10 Jun 2025 15:21:28 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v2 3/4] lib: bridge: Add a module for
 bridge-related helpers
To: Petr Machata <petrm@nvidia.com>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org
References: <cover.1749484902.git.petrm@nvidia.com>
 <b50c8fdb2fed1c8d47f06ee139f26fcb263472bb.1749484902.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <b50c8fdb2fed1c8d47f06ee139f26fcb263472bb.1749484902.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/25 19:05, Petr Machata wrote:
> `ip stats' displays a range of bridge_slave-related statistics, but not
> the VLAN stats. `bridge vlan' actually has code to show these. Extract the
> code to libutil so that it can be reused between the bridge and ip stats
> tools.
> 
> Rename them reasonably so as not to litter the global namespace.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
> 
> Notes:
>      v2:
>      - Add MAINTAINERS entry for the module
> 
>   MAINTAINERS      |  2 ++
>   bridge/vlan.c    | 50 +++++-------------------------------------------
>   include/bridge.h | 11 +++++++++++
>   lib/Makefile     |  3 ++-
>   lib/bridge.c     | 47 +++++++++++++++++++++++++++++++++++++++++++++
>   5 files changed, 67 insertions(+), 46 deletions(-)
>   create mode 100644 include/bridge.h
>   create mode 100644 lib/bridge.c
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
