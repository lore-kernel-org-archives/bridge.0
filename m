Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72761225A59
	for <bridge@lists.linux-foundation.org>; Tue, 12 Aug 2025 08:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987307; cv=none; b=A1vzpyn18mCWm7caGJWtkfC4b3Dh5nFNc3fy9WFn6Ay1v3wAidbhkHsWpcsOVEzD4rVANDbPWyDXtVjHzs/x3gooTEh+UaEvnI/0JoOjn/RDuVkNy2pwdewZeumhJTv3Owqz2HLFlVldr8joVLJ2RycNIoEUwnq/s4JwfBYp9+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987307; c=relaxed/simple;
	bh=fgqjykETSbd8OLkEoI2OcORjWOwo4cvMEHo1V4muxXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YRLq7kK72Kp4V2k7gW8Fdgl3l2bn9xOC41m92apM/crWPK06lOp6j1UhV2u7Jx0u7DZBOBDuMGgEA1KtNXToVJQ/KGASSCwCEznud5i8JqSaqeS38FyekLbhYOwRyvBKsMKIRLKfPtUNuy7mMVT81OMvLyH37n5/Fhkkz/xp20c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=V11BhLU6; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="V11BhLU6"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 222A542018
	for <bridge@lists.linux-foundation.org>; Tue, 12 Aug 2025 08:28:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IE5aH8wd9tec for <bridge@lists.linux-foundation.org>;
 Tue, 12 Aug 2025 08:28:25 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=razor@blackwall.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 34BF741E5D
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=blackwall.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 34BF741E5D
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=V11BhLU6
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 34BF741E5D
	for <bridge@lists.linux-foundation.org>; Tue, 12 Aug 2025 08:28:25 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so9663975a12.2
        for <bridge@lists.linux-foundation.org>; Tue, 12 Aug 2025 01:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1754987303; x=1755592103; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5parWk4KRrzk3kF82+RurV5ODsapxZgFSbh/OkX2u5E=;
        b=V11BhLU6jC+ry6kdJaXswVDdOwtJonUZYAVLzcYkxBd9d63LFgpqJ2n4/kPffGvpOK
         lSdBiv25cShxedJSESh2iyIBC+CzIHOXIJCvfJGddzDkaUkPm+YUWGZXIrxKm+xoIOGf
         e0rtA2MrTq5OBBg6NtK4qRHJKmP83D3IdVRKT0goKewqH78InmZkE8wwb2Azvf3fSxFc
         L+7OYbKWwtVv2DA/HrHWSQ/kepRouAudr3xd+LjgEFlAzWfJSeJ9pxYVgrAXW0VEypsm
         7NA7bOL86j6YAkBGA9no1IYbOj3l0j7O63RSt/QSfHMz8AIJ1AK6bM6ROr4CPtOj7nT/
         s4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754987303; x=1755592103;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5parWk4KRrzk3kF82+RurV5ODsapxZgFSbh/OkX2u5E=;
        b=pbe89EU1OQ8+wXY60atihbE1W+sRLnSJDzDDInga7FO7lYvj98e+SX02kXI6iXk7fE
         syBWT6nkNbTMoeT/uYLaKdlJ8XWNpXXxjiWaQ0xPylfhTx8p8ous1yXf7tKrCqJm0UWZ
         EE8Ah0MenPN0EbzHDyB08Dj9fnWFLALMhOKwQ37gIJR5jCJZzxbgSDIx8E0qRbNe+Hly
         6GJj2Pl3Bqs8kCMF41eV6CVHK62Ok2lE2szIlzWvWl1+Ph5QzmIbmOIDluhaHt0HoBca
         J20MEYnYj/VU/5K2x20/uouFhC4bnPQECMfDLkEDqdYVvzz0mbb/8VnbFocr+36PaSaL
         XZzw==
X-Forwarded-Encrypted: i=1; AJvYcCUWGk7Il2d0sFPYBOCPCwRH2AO7OO8/ndGQ627SulS3TN59tkYQGqNXOAHqUxA8OTZ4/zxKtSY=@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwpLrZ1xPii/vTHfde1aat7rOnsbCCLw2RvRPE1gxBXvon4L9BP
	qDaOZ/22O9bO/FKE6RI49E7jxXnvVN8WY/q/uTKFXpfKblz2qet5ltlOG0R7M6mOP4E=
X-Gm-Gg: ASbGnctcihw6aL84qPx/Vbn1FoB22xRtrw5v/+fhRE/+hVyaSLHdx4Lexl+n9yO+opN
	S5RzWvdzqEndRtvJ2LhX+ufdFL1Ybj2CWmzi2HX5z8AWGzU0FynMYrET4M8iOwce+yFlyzxbJXO
	xyIMGXdWBcbqsJMgLVgAF0/1htttUReUKl4wBu+OP22DjD3ifJWrHH0OWVQfAoZfQG6Jw3AvdLg
	qRcXMB2bkOFJycn9l933csnsL/+HzVyady+qlJnpT0hbL4I9CfMq+iC5ZTzUPmUJn6hQLezHJj8
	tkq4gta6617NRSI6AG9OHgy1GJwokZfeHAEjaBi0cjL6Q1iwDqfzVPS5Bb6KS+Djb+Eszg6dlEj
	ospiAo0kqpIHDPeQTJ1T7ISs/o5JF
X-Google-Smtp-Source: AGHT+IG7gR7TKPP6Kg4VwIrN1R7Fl37VkQK/DmyRFG8R801slqU/0xuHrsdUtyWS1bLhZeJceZ748Q==
X-Received: by 2002:a17:907:7ba4:b0:ae3:5368:be85 with SMTP id a640c23a62f3a-afa1e128eafmr208409866b.47.1754987303139;
        Tue, 12 Aug 2025 01:28:23 -0700 (PDT)
Received: from [100.115.92.205] ([109.160.72.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e8332sm2168716066b.75.2025.08.12.01.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 01:28:22 -0700 (PDT)
Message-ID: <dcc3c884-8b1d-4c80-8b56-a277c7d1d95d@blackwall.org>
Date: Tue, 12 Aug 2025 11:28:20 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] selftests: net: Test bridge backup port when
 port is administratively down
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, petrm@nvidia.com, horms@kernel.org
References: <20250812080213.325298-1-idosch@nvidia.com>
 <20250812080213.325298-3-idosch@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250812080213.325298-3-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/25 11:02, Ido Schimmel wrote:
> Test that packets are redirected to the backup port when the primary
> port is administratively down.
> 
> With the previous patch:
> 
>   # ./test_bridge_backup_port.sh
>   [...]
>   TEST: swp1 administratively down                                    [ OK ]
>   TEST: No forwarding out of swp1                                     [ OK ]
>   TEST: Forwarding out of vx0                                         [ OK ]
>   TEST: swp1 administratively up                                      [ OK ]
>   TEST: Forwarding out of swp1                                        [ OK ]
>   TEST: No forwarding out of vx0                                      [ OK ]
>   [...]
>   Tests passed:  89
>   Tests failed:   0
> 
> Without the previous patch:
> 
>   # ./test_bridge_backup_port.sh
>   [...]
>   TEST: swp1 administratively down                                    [ OK ]
>   TEST: No forwarding out of swp1                                     [ OK ]
>   TEST: Forwarding out of vx0                                         [FAIL]
>   TEST: swp1 administratively up                                      [ OK ]
>   TEST: Forwarding out of swp1                                        [ OK ]
>   [...]
>   Tests passed:  85
>   Tests failed:   4
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   .../selftests/net/test_bridge_backup_port.sh  | 31 ++++++++++++++++---
>   1 file changed, 27 insertions(+), 4 deletions(-)
> 

Nice!
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
