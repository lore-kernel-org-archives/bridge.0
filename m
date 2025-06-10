Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3AE28FFCE
	for <bridge@lists.linux-foundation.org>; Tue, 10 Jun 2025 12:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749558037; cv=none; b=VXvhf5lp1x58To00bf0oI/VbnC7+JywHuRxZpONXpx/3UAKXuBirmnknR1mffNjiE52ouKy4RCSJuhpqkHoCj6KFq5/NGnX5I9wF/ImZkPAu7bYob1/ydiP+eJMvCsuIqcUPkjZ7YxiCdcVoYX1q08ajtsXDXY3RmHZ8mp0Dj8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749558037; c=relaxed/simple;
	bh=GxAzovlHgLGnYrZU1ySFi76vhcQRxNyPfdNwRBun9e8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C8D09OMJuQO6DOkKytFv7RCoZG6R5J0kLWYCN1by9spAWnnYfTET8Kr0B7mJNCXvhTIEdA6f1hhFMw3vuJAq5tdFXid1OU1L2PemFksHaObU2jBihqNw40UbpSxoDDwIs7scliGNyJICvZ5rD0KWvM+58ouCr0nXWMx/NaOSKlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=B5YwUXeL; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="B5YwUXeL"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3AE8D404F5
	for <bridge@lists.linux-foundation.org>; Tue, 10 Jun 2025 12:20:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qyIDKJ9qqNcP for <bridge@lists.linux-foundation.org>;
 Tue, 10 Jun 2025 12:20:35 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::136; helo=mail-lf1-x136.google.com; envelope-from=razor@blackwall.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1F2A440261
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=blackwall.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1F2A440261
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=B5YwUXeL
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1F2A440261
	for <bridge@lists.linux-foundation.org>; Tue, 10 Jun 2025 12:20:34 +0000 (UTC)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-553543ddfc7so5177239e87.0
        for <bridge@lists.linux-foundation.org>; Tue, 10 Jun 2025 05:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1749558033; x=1750162833; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+/yj1cI+THStCgol0p5dxqSrifx2yS1OsxMik6/kECg=;
        b=B5YwUXeLvHpvwUekGYb49YDHjmJtSeCTlgd7Isjhi0irpiwooxwreWEfCXl3AUB1BC
         Kj2Br7H5De/7ZYgZgmRSn/qkQO+Aqhm1zcjrehTiZhwUqmUYU5C760usX09vSLXBghnp
         /4XyLYY5cw2tY+xL0CkheRH3GmTglcdWOqoNgFXuvl+UK5Qi1p6xjQk0Po4UPkeXnYTC
         Ee9L02rl29HM+lctZpr8wLznbuTl8nRNir0LWCCGFTI0dDFsPQJT1BLO+Iq8PxBSXWPs
         PuNBmjUXtnEN/+QDzlBOdmVI6Haz2t8WXOhCkYMM3W6/ERlKpS6ophLLC6z4X3TkfnUd
         wvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749558033; x=1750162833;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+/yj1cI+THStCgol0p5dxqSrifx2yS1OsxMik6/kECg=;
        b=iPG4xSexd/Xd/ZA3mUCy9YjXgrsXkcrFRpleom5z7FthqRMKHFHK6o2lx+nj0L8upI
         9W6ddbxaN1y/Ogo0xi77eFTenXNi0cIw7ZiK3VtJ1Rjhe9WvzJMsybHCBfVEAHWX2Hx/
         10LhDizrDtyx8a2di4uZZ391F1uexfrLTRstZzu0d16yvgtV/pOCfNPlSWFFwZH6WMz/
         c34eOMGX4ZeuHTofGiP/CTvYHwE0Pn/0OHIh+z9wvU4oFxP4nu5244SxmqVoqhdrF4A7
         Q1oss6X/X7jOHKXE1rquzo6yFk44dzC7X47r0OUYi39M4+aMzekjapDP1Dr4kreqkLbg
         XqTg==
X-Forwarded-Encrypted: i=1; AJvYcCWnGD9ucTnV5r5TqQCNNBg8aApuZEsYUXul3MWmMfPQyIkeadRhTU9kWWATk/sRFRv+VvPP5BE=@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwBYdA+0Y3exIv8Gdo98M+KoXGURpK0LQvhqVyRhBTHHxl/6Cwj
	D2xwmArphJmshLXB7TIV608q8QRf3iZxdt+9CMSsZQcftLJU5Tni0T9D8EKItWjZK6U=
X-Gm-Gg: ASbGncuRAHlbJWI3wJNqHlnnalXJoP2QEv2BCw81Lg5ouS/K0fOo8fakpRiRcWNB4Cp
	ZwG4nVZCGLC6Ci2zj0KgDR1OA8sBJSNm6LORZYdfynlm6txT1sTxMvfJzOqs4n9WYaCx9/0eDPn
	NnQ7EoM2Gxtz9+cbEBNNTDdIxpuprFDWR8MBz/WAkEal2lj7wJyjJsFyRVqqgMw3xuIP7AdSoIL
	ZRT2G3OSxlyuBthHDWQ2LKuXdi9Vb5Wrvp37WQ65hGC7uw9Us9e1gkIvuH1tdZqdkyCP3GxcmLT
	6OxKwwZAmT/sN+un5U+hCzNgEa6Ua+JxHOrxXr6e3x/Yeu9AEMktLUjFfccgZK6w+BFMXpXnzSd
	04PaSl4K4plANQT6PWMSKfkKsuAvCKnE=
X-Google-Smtp-Source: AGHT+IEl1JdeQusLwp3zre1k9d82StLthBpTHKOhic5o5TqIO+6zKIQSHxAEW6Ax+/UcbkiOXIeGvA==
X-Received: by 2002:ac2:4e0a:0:b0:553:65eb:319b with SMTP id 2adb3069b0e04-5539475e453mr745771e87.22.1749558032370;
        Tue, 10 Jun 2025 05:20:32 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5536772254dsm1525207e87.111.2025.06.10.05.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 05:20:31 -0700 (PDT)
Message-ID: <5a6798b9-5e6a-47fc-8217-d7907e0f8720@blackwall.org>
Date: Tue, 10 Jun 2025 15:20:29 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v2 1/4] ip: ipstats: Iterate all xstats
 attributes
To: Petr Machata <petrm@nvidia.com>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org
References: <cover.1749484902.git.petrm@nvidia.com>
 <e8834ec759b3e7f94545fe07a219ca592e84e402.1749484902.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <e8834ec759b3e7f94545fe07a219ca592e84e402.1749484902.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/25 19:05, Petr Machata wrote:
> ipstats_stat_desc_show_xstats() operates by first parsing the attribute
> stream into a type-indexed table, and then accessing the right attribute.
> But bridge VLAN stats are given as several BRIDGE_XSTATS_VLAN attributes,
> one per VLAN. With the above approach to parsing, only one of these
> attributes would be shown. Instead, iterate the stream of attributes and
> call the show_cb for each one with a matching type.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
> 
> Notes:
>      v2:
>      - Use rtattr_for_each_nested
>      - Drop #include <alloca.h>, it's not used anymore
> 
>   ip/ipstats.c | 17 +++++++----------
>   1 file changed, 7 insertions(+), 10 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

