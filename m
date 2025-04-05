Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06C01C5D7C
	for <bridge@lists.linux-foundation.org>; Sat,  5 Apr 2025 08:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743840862; cv=none; b=LTE/cAn/FPemlOlIIgIGuzOkgpLPyUvXPAyugYPkV8CKIyNsp8SOX7B6dyXmTKdrm5wKBaP3CJGaHzw+c3dFxMAwPVzxD3FyurBb6vYFFqaKPbKemtfiJQCeZsi7n2jU5LpEeOErXeikdRgxhfCXIvhB4+qWeiL2W6400oqbR9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743840862; c=relaxed/simple;
	bh=0uHZxEe7XrTJDst89mB8hK8itnIDw021YoHtu7tQZ7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ifChOrMB9a5t7gVZobSxPl1YYCAKEZHSlJ7ogNiLStPhBCPFtkoikVuo5nGNUAHJj7zSZYSHSuDXyQqdxhv24SSETu3VMdaqq56ozbo6bNG+krcmM6/CGZhiVPeRx3k2ePTke9DgrwqTO6frbiBSQsDB6NsmF+JJeZfQcKmzG48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=A0TFXCG+; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="A0TFXCG+"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 80F9E60BBF
	for <bridge@lists.linux-foundation.org>; Sat,  5 Apr 2025 08:14:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RXvXQnyR1baW for <bridge@lists.linux-foundation.org>;
 Sat,  5 Apr 2025 08:14:19 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::443; helo=mail-wr1-x443.google.com; envelope-from=razor@blackwall.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1ACA560BBC
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=blackwall.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1ACA560BBC
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=A0TFXCG+
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1ACA560BBC
	for <bridge@lists.linux-foundation.org>; Sat,  5 Apr 2025 08:14:18 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id ffacd0b85a97d-39c30d9085aso1597514f8f.1
        for <bridge@lists.linux-foundation.org>; Sat, 05 Apr 2025 01:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1743840856; x=1744445656; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yJMIvKqHoFlNjkAPG072V0/WXmbwCX45M2RN3605BFc=;
        b=A0TFXCG+V5q8sytwbryy+O7Air78ve41IY8kGkmKVlvsgPY+p/kPswbWDuLeP3Bfba
         LlExXXMqjOPJv5GHe8Z5FzrT6JTtk2NZASxUMAu0WduTSlfQhEWCzuh+gi6LHuZblzbP
         Dfw+JT/+PWWKhrSl8nWZXDO0/OAxfJ/5k1r+NBww2KwZDWcMBIgqvferB2dzPCl2r8Gk
         IN1goMsfSgv7e8DV4hiPA4HDQHdFjixpx+qPqU2Z5NLw1h1RLWLB12/0S2evZw/Nb7rq
         hxFXo9ZBBV1ZZVjlen4x/+kCOhOs62zxEzv/PfOy1gnUSCwtVj4qoUkwE0Xsbh0E/b0X
         GlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743840856; x=1744445656;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yJMIvKqHoFlNjkAPG072V0/WXmbwCX45M2RN3605BFc=;
        b=AsxEnl7tPPkfOekpirpxN5+452hSXuvfZo2gfEOdrt/poH7tJ0yE5i+/8VqQ3agpDb
         VzQ1xhrqvoWTL3gbP+GD+IxVX6dUYH9drrfIch1aJn7FGoDtYJv3aWsSRuRspEopqmPs
         +qcRyJRYU/xbs4agmfyglPqmf3zbWjunhzCu0HhdFWe/QRhgjrq/PPATZJ514kbBa8xz
         kvwdOLWul/UmizenGa3cJmt7hGLaFZ5KLZeSxqY6yRVUMk4rqtIBPZHWaf7h/ZILlqdu
         Fm4RQvfS6bXtygjlCqd7JPNL8tw54LNb8EW/lAnromiiE5fzMuR78l6lqESQNQSe4BnR
         /INw==
X-Forwarded-Encrypted: i=1; AJvYcCVivt5SkTqxy80Bx4aLJ3I2zuFlx7kQ3h2jEIIG22Tejg4zDThNL3BzBeM1/YbMeC1p+bteo2E=@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yy2Ts73rLWXoYLLIrIOUIkzW/7Hxjcn4iqItelGp1XI0DQiyrS2
	JEn3KUq7kI3wfjZBnnRzl2upkrekc8qv8mLfgDzt+XFuRPZRwtjI6OhMKVifXVw=
X-Gm-Gg: ASbGncs7LqKrV5I0etCZHj6v3G0Vtzq/ppwTQhsemBjaqVYJ0lqPxzgYVnUPZnXJMDs
	4jzX2qCFBHMUwRUgUKW63C4XwZW13u3SDDR4UKMHAX+FvbqQxl4TK6g6ZwlQM1UA4LBeXjMwtqw
	qKtMxezHrQcg3VLWUetLizxYgBkSiWXt0xpyZvbYrwKf0XKTDF0PX9Gh65RuYYOL4Qx9TrQfU6/
	P1ojrRLpdHwSt4WvSj3Oobx0mPLqEIutnB0UndCY4UlbM2KLwBUWja2L0ic5qxBXKeqLjQZqy7t
	nMpxxg2915KH+I7G08+ZWCmPkE4nGuDSKJfACzcjjj3AqcsLO/cq19HYwECz2xgX3YwJwfYLH8w
	l5cxOxV4VjGI=
X-Google-Smtp-Source: AGHT+IEcuSu6lzaAzckCsCjmkxVQbCqAsMtgjYTxhj0B1iLZWt/aU3LfOwwmpGP04b31fI8GiD2lwg==
X-Received: by 2002:a5d:64e9:0:b0:39c:1257:c7a3 with SMTP id ffacd0b85a97d-39cba93d9eamr5505067f8f.59.1743840856218;
        Sat, 05 Apr 2025 01:14:16 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec366a88csm64665095e9.37.2025.04.05.01.14.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Apr 2025 01:14:15 -0700 (PDT)
Message-ID: <8a758dd8-b423-4d03-8f33-88b81ae9c24f@blackwall.org>
Date: Sat, 5 Apr 2025 11:14:14 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 iproute2-next 0/2] Add mdb offload failure notification
To: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org,
 Joseph Huang <joseph.huang.2024@gmail.com>
References: <20250404215328.1843239-1-Joseph.Huang@garmin.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250404215328.1843239-1-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/5/25 00:53, Joseph Huang wrote:
> Add support to handle mdb offload failure notifications.
> 
> The link to kernel changes:
> https://lore.kernel.org/netdev/20250404212940.1837879-1-Joseph.Huang@garmin.com/
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
> v2: https://lore.kernel.org/netdev/20250403235452.1534269-1-Joseph.Huang@garmin.com/
>     Change multi-valued option mdb_notify_on_flag_change to bool option
>     mdb_offload_fail_notification
> v3: Patch 2/2 Use strcmp instead of matches
> 

Somehow you've CCed me only on patch 1. :)
