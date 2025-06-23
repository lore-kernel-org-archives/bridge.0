Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812D21F8BA6
	for <bridge@lists.linux-foundation.org>; Mon, 23 Jun 2025 07:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750665159; cv=none; b=rMFY4xHUJLrGqOCU+MgYNVhwAoA4G8R8C1VERhwv68FkU4RPGd7GOBCK7Ye7zn4QMKbgXsOzXyPqN1jEP4gw0v7vRzxFSDo37gyHQ5wbaBXixdlWXohn056zBUWK5qQEgQokk4JwNJbIhZYv9zsTc2EBUDOyNI/0gPzfdW+pM6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750665159; c=relaxed/simple;
	bh=MiMVMR/aVykWmRUvMhLFXxT/guoaCBMyhvS6yqiFAvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t3DkOqS95kWkBOfMFg+Fpm1wP4cGsjZuA+gSphQKL65jKvDMjNjgHj0QZbRwBxexxCfVfoTIm856F3D8kwF2QMedrOIxjeGNpX121QsaKDyCk2vnVi4/mzcUGbfzMbGuAUyqmUZXVe0Fag1pm85n0V/2irlNPKffTQa/VGPOnD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=0URbEo2p; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="0URbEo2p"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 12FC9407F7
	for <bridge@lists.linux-foundation.org>; Mon, 23 Jun 2025 07:52:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S1UB8sxFPDCe for <bridge@lists.linux-foundation.org>;
 Mon, 23 Jun 2025 07:52:37 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com; envelope-from=razor@blackwall.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C2CF2400D3
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=blackwall.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C2CF2400D3
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=0URbEo2p
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C2CF2400D3
	for <bridge@lists.linux-foundation.org>; Mon, 23 Jun 2025 07:52:36 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-ad89ee255easo708235566b.3
        for <bridge@lists.linux-foundation.org>; Mon, 23 Jun 2025 00:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1750665154; x=1751269954; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MiMVMR/aVykWmRUvMhLFXxT/guoaCBMyhvS6yqiFAvA=;
        b=0URbEo2pUUnsm+O76zhE993/R/TDdNR7NiRapamwvpcz3ljYp8H4ezHP/jJWqUMoAz
         fvLmgFknYzOPMIGkCOIDQjpDYdmuH4hqgAVL+xqZ5EfVFfJAiJrV9s4UE4AIwU7Cfcm/
         2Ei/6nyVY6Zbsk4qiE/WDe2rWm2R4DywYqZR0H86ea+s9cH4/Szo644+ihjHTO68YSqx
         Nn2iN1P+Y/lMHA/jxB5gbRtMKtSOYvXAdHvOjTZ1w3eKlMiuoMeV6CWq90f/ZkQFvjiV
         dtaeKMIbDhhAoLPiLTx/4XREQGh3XvCuDMT8YVyChz28nbIzcpdPudcjPNOsYcEzR4Bx
         n7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750665154; x=1751269954;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MiMVMR/aVykWmRUvMhLFXxT/guoaCBMyhvS6yqiFAvA=;
        b=RDbIwNBMLKUIFLCbgRY/zXxtgHNUnSVrujughdgJsypasaJqsQoeDhvlmoGmzEsx68
         N5rmqrYUErIhPeF0oYMHaqID9UJtG1sPig+0rIFgKHTLDyt0SSQ2zPwhShV9WQJLMDPX
         HTisJuoq5NfbO4p+lmPPJ/cefCRb/7BUpMwj7tUh2O4gOsAXozx2F7XEHzRSQ+FIkY+d
         xiU5Oz9WyCBZdCpz6xKhxLCBFNOWRzWhTxEfJndwBbZpjfOzcxucc5rrTQtUc6vPpzPP
         gKLJf+ppyQN99hZ6H6X1xPJpPTzxDf5K/VxQ/Yyeq+k1cEVr/1SLbvHHWujY5C/XyboA
         7OIA==
X-Forwarded-Encrypted: i=1; AJvYcCXty/Yu2m8Zaj3y0FYwbX4GuZObj9QkdW80Gk5uzq0AWw8Rg2amRXh9v1pmtb6z3nXLCHyBfr0=@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyC+fdJd2brNqHwvmI0wpX9ZPSDmN6X7vSLaGs2iCw1O9mrFDc9
	lsCa2F+GB98P5qKW2Wjv4dDgVgkcrvqZzMo+4pkHuz4OUlOwuieq5Well0DfptHu9cs=
X-Gm-Gg: ASbGncvMktkzRIoBP4jTr57Z1BrbCnvb94mWD+ad5ioU62WJyTjJkcxvRDwfYy/VgRQ
	BJJO1YnlEAm5IUNIpErdN7v1243KILxngwtEWtpA/roU0G+IKcMiRQbEzxt1rGyjV5DYFp7uYz4
	pYIWgpfXk2gqE6EtafhC860AmArmwdqPtU77QnYZySzxqqonrdPGTNUgqIDkWlwLwJ3X3wWqH/o
	wVDV8e6pN+5sAT4706Ekz5CQ5m0V8ebnvr7tamhCJLNAi5DFgCs/ygWMnY3Cd+YGEprjbp2n27v
	Xy0ZHC5CcBwsrreArj1Id8WDiaT0r93nBglgxEjTWidyrOYEbndemZZRlPZWbB4voZ0KSwPdfle
	Qd/HEkElwd8ob2IL7zw==
X-Google-Smtp-Source: AGHT+IEcI2WKNX5Vp6Sj64483GIFOnB/otWSEXt2rQsFZPBJwINAl0CsDM7Uhhr6hpdpqprvcuW88Q==
X-Received: by 2002:a17:907:3f1a:b0:ad2:3f9a:649f with SMTP id a640c23a62f3a-ae057f65c4cmr1055113066b.42.1750665153660;
        Mon, 23 Jun 2025 00:52:33 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053e7d1dbsm673152366b.16.2025.06.23.00.52.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 00:52:33 -0700 (PDT)
Message-ID: <8a8ba47b-76d6-46d9-b48f-c01edd160d22@blackwall.org>
Date: Mon, 23 Jun 2025 10:52:32 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] bridge: dump mcast querier state per vlan
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>, netdev@vger.kernel.org
Cc: dsahern@gmail.com, idosch@nvidia.com, bridge@lists.linux-foundation.org,
 entwicklung@pengutronix.de
References: <20250620121620.2827020-1-f.pfitzner@pengutronix.de>
 <d8d5a8f4-33a8-4a62-b48e-fb82b8de245b@blackwall.org>
 <dbc2fcc9-5cd9-43c9-a9f9-9d5d16bb81b4@pengutronix.de>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <dbc2fcc9-5cd9-43c9-a9f9-9d5d16bb81b4@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/23/25 10:45, Fabian Pfitzner wrote:
> On 6/20/25 14:44, Nikolay Aleksandrov wrote:
>> On 6/20/25 15:16, Fabian Pfitzner wrote:
>>> Dump the multicast querier state per vlan.
>>> This commit is almost identical to [1].
>>>
>>> The querier state can be seen with:
>>>
>>> bridge -d vlan global
>>>
>>> The options for vlan filtering and vlan mcast snooping have to be enabled
>>> in order to see the output:
>>>
>>> ip link set [dev] type bridge mcast_vlan_snooping 1 vlan_filtering 1
>>>
>>> The querier state shows the following information for IPv4 and IPv6
>>> respectively:
>>>
>>> 1) The ip address of the current querier in the network. This could be
>>>     ourselves or an external querier.
>>> 2) The port on which the querier was seen
>>> 3) Querier timeout in seconds
>>>
>>> [1] https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=16aa4494d7fc6543e5e92beb2ce01648b79f8fa2
>>>
>>> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
>>> ---
>>>
>>> v1->v2
>>>     - refactor code
>>>     - link to v1: https://lore.kernel.org/netdev/20250604105322.1185872-1-f.pfitzner@pengutronix.de/
>>>
>>> v2->v3
>>>     - move code into a shared function
>>>     - use shared function in bridge and ip utility
>>>     - link to v2: https://lore.kernel.org/netdev/20250611121151.1660231-1-f.pfitzner@pengutronix.de/
>>> ---
>>>   bridge/vlan.c      |  3 +++
>>>   include/bridge.h   |  3 +++
>>>   ip/iplink_bridge.c | 57 +---------------------------------------------
>>>   lib/bridge.c       | 56 +++++++++++++++++++++++++++++++++++++++++++++
>>>   4 files changed, 63 insertions(+), 56 deletions(-)
>>>
>> Hi,
>> The subject should contain the target for this patch which is iproute2-next,
>> e.g. [PATCH iproute2-next v3]. Since there would be another version, I'd split
>> it in 2 patches - 1 that moves the existing code to lib/bridge.c and the second
>> which adds the vlan querier print code.
>>
>> Also a few comments below..
> I'll split it into three commits then:
> 1. Move existing code into shared function
> 2. Call shared function in bridge/vlan.c as well
> 3. Refactor code according to Ido's code proposal from v1

Sounds good to me. Thanks!

