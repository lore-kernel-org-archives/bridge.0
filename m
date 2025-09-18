Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9197D30FC1C
	for <bridge@lists.linux-foundation.org>; Thu, 18 Sep 2025 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212334; cv=none; b=kliR1uw6AiOiH9npA54U58Fq+4CZUIkA2pfR6ekXwqQOTWhPkiz6mOQPe/778OuPyYVnXwWCoYIgUgw2Gw8o6v3BJYPwOcQwoojmUbnjqG3TnrJCNlGWVWw+QLTnrK7kHgDfwm0yUKhJzLFYgSTRZvH6H/7BcevoVqEjj72wdQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212334; c=relaxed/simple;
	bh=pT725trLHsFzb6j3PtSFoM1Nlf4Wwd7bd3nQDutkrOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bQeAzAb1Z8CN9TEzPC5ypPyVSB6Eg+Z9EAB9jCaJr8cSDyjAO7mTjDw2uN0HFgPulQKfmLePqnzFOL0Wj4wJ0jZ3mM+KR3U4lSPMJF3WM8xQcd0X2vQn05q9IauV9moh23o2DcHpR0PM+0YE6pk+t+9TNbuUf+K7dwI+kcesrEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=G+ryC5vl; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="G+ryC5vl"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D5E68145D
	for <bridge@lists.linux-foundation.org>; Thu, 18 Sep 2025 16:18:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.098
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VZml-WuEp6WT for <bridge@lists.linux-foundation.org>;
 Thu, 18 Sep 2025 16:18:52 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::232; helo=mail-lj1-x232.google.com; envelope-from=razor@blackwall.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 01CA08145C
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=blackwall.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 01CA08145C
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=G+ryC5vl
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 01CA08145C
	for <bridge@lists.linux-foundation.org>; Thu, 18 Sep 2025 16:18:51 +0000 (UTC)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-33ca74c62acso9627941fa.1
        for <bridge@lists.linux-foundation.org>; Thu, 18 Sep 2025 09:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1758212329; x=1758817129; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hn0hHTGqR47ZeFXXfyKJMLyN9yvA5G3Bb4pO4Wvs8Iw=;
        b=G+ryC5vlKGxKzlGnAWAgUwhta8c/ekQRJmhnoRhJxZhaL5kK+mkkTZcsMDQcKLbSgw
         fBx5TjOoF5RU0CTt3KN3LlpMOifBA+7ZGDYsfIVN71MqeohrFKYsJpUxi0wOsmINAUgo
         fJS4F2U5OQTAH1EcBVuuZByEvuCTBPoh/mQfp8dSuFKtNRdFaOqK/Q6czYq4vG3QDCNW
         +b+Ed6XDdpUHKf6lQH3PrXl37y9B/6BluCK5mBhYg4x9TwZMqbEgUmhEavd/i+FxWRw+
         BUf7yhwqb7LmGYw8Lssd56bWtGyMLg8vXQ4CObrie4NXyV7E+t/Ks4oNtrD/SpEDxB6/
         zqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758212329; x=1758817129;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hn0hHTGqR47ZeFXXfyKJMLyN9yvA5G3Bb4pO4Wvs8Iw=;
        b=PDwv5Sx+/rCRU7q39v7mvcqBbP80UykCq/QWNroPBQfSThqJKHBPjSres0cHa+KPm0
         xYYiH14f0FW4yZ/xOai/emJ3dSfb98or9zckwltjOhv8EvQ33m/sDIbHCpN9aSb3sNZx
         5vIkhe3qAMpYNkeJg4GdBjC4T4mtlDufCK14Lwddkxw7q6JPNX38kUYROO5InCNP/vdP
         goYHxnhCiQ9j7MFJetf23w07PRT1kDGmi9tlpl6H8D/5O3sQJklA11F5RbdIwOHpRFG2
         9i6fHGGkQWUvYhyprJUlVc0FY+XJRJ9vU4+kIozPYWmjE2y/8qA/Q3tJxsQjd9YugmOh
         r7tQ==
X-Gm-Message-State: AOJu0YwhXqYKf1xkZuD1fF/Xflx0JI11wrQKur+Tip1Bluz/3KLo5YF1
	qJYLgjuIyrZL/j2M26ZiXSZOgXZ2pzq01KZc1QB9BmBpnmgexeoIRc8+vpQnRnV5+Ps=
X-Gm-Gg: ASbGncsV9EcnkjxAA4uGxviqjSM7fq2UqUDY7UFIDqIJ3Eo69Vbydj7omL2Qm+P0w6+
	gMfqYyGhqt1eCtj+wxNs8qlmNhAFKuD6uqfhmgtRuyXacW7/2PNhv5ZZsGiwEQmN99T+SXGGLkZ
	93+/JESr113lx0MmH0gfhg/oeh92NxeeqKL82JRSqsU/o/r5nNwAQe9isiti7VSaIogYpuJwVUt
	9i+ojaLLEHfNIQtmReD0qda++8LQRO0wTpZ4dc/cnkiBVkf5UdlSS7ontK45700pMjm5jkKADRY
	UYh0KNFuvqU//FijcGG7AJg9F/DpNZfXdx2Q4NSUlbqyamIADdLY3n6l3Qhd7vbfgVI2YYHt8+f
	K2t5jKaxV9HDKlx/kdJuzFffI1yafIcA9Ve5SPFNtPRZ+AgpwT+bE7erl1OPNrm4wvqKuo+qWIm
	d3b3agCanT301cIj+6+8Ub
X-Google-Smtp-Source: AGHT+IErdKLUND9UQ229ACOmVBQ5JcyfC20KVgyLavY53NqXj/MXkRfXB4GF/n8dR84aDf+50gNRfg==
X-Received: by 2002:a05:651c:2222:b0:336:e03d:6f51 with SMTP id 38308e7fff4ca-3641bd67604mr301251fa.34.1758212329222;
        Thu, 18 Sep 2025 09:18:49 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-361aa4810fasm6850671fa.64.2025.09.18.09.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 09:18:48 -0700 (PDT)
Message-ID: <eb9e2d21-b2f7-4a60-bfe1-530d909526d1@blackwall.org>
Date: Thu, 18 Sep 2025 19:18:47 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v3] ip: iplink_bridge: Support
 fdb_local_vlan_0
To: Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org
References: <d23fb4f116e5540afbd564e0e3a31d91eae42c60.1758209325.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <d23fb4f116e5540afbd564e0e3a31d91eae42c60.1758209325.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/25 18:39, Petr Machata wrote:
> Add support for the new bridge option BR_BOOLOPT_FDB_LOCAL_VLAN_0.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
> 
> Notes:
>      v3:
>      - When printing the option, test optmask, not optval
>      
>      v2:
>      - Maintain RXT in bridge_print_opt()
>      - Mention what the default is in the man page.
> 
>   ip/iplink_bridge.c    | 19 +++++++++++++++++++
>   man/man8/ip-link.8.in | 15 +++++++++++++++
>   2 files changed, 34 insertions(+)
> 
> diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c

Thanks,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

