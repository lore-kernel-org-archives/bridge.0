Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87622144A1
	for <bridge@lists.linux.dev>; Tue,  8 Apr 2025 18:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744138569; cv=none; b=j/PD+fEYQvg0wKs5w1T411XMNpJMrJid1N/8nmYEumo5sQemS8VzPgJdSTdlUugaDsp1d7gmxA4lTu726vgkrczJxqwMsaJf4tngoqCk4LSDS4zgf2DaJ8FP2b2/JOuBM67dq6sgqWtqm2iIA11POo4xAKDNoGjBJS1yzAdfuA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744138569; c=relaxed/simple;
	bh=DXhjXBkNql5ejtVG8/vipeyKelZRQVr0LdEjFC79IoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZVHfuCXfuE5SCzwFFsBN7dLUKeixIEUmVqKaNGyZzpQ1a5ErmChVmuXILDcZF9h1X1yJBvmqC2K7xa6274hXjLBCMpnfO5FJHuYKcIiypnZanHrREKthDI3gn4/fMb8WQA6y57LlZdlUGSH5eH89ubdn7P9SsnOxyvmdnitLHhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=do+vCdpo; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="do+vCdpo"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so1067746466b.1
        for <bridge@lists.linux.dev>; Tue, 08 Apr 2025 11:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744138566; x=1744743366; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2RLobX/NWAoO5M1cQ5CruPiTUctk6qBhH262aYUiAZk=;
        b=do+vCdpoOs3DfOAghGWCDirxDbwrQW0Pnl5oz8NvW5ZGCQAgyI0gvNOh3aqVzZAIqy
         5aBXpUV2kn+MrLWpn/l5qaIwkiFMsG2xUXAsf85GvmXP8CnUmVB33r4DfnKhLg/Y5o5B
         bTeRAhlBpfVrp+R3l1/paBd+UwXn/IaNEtz7BiyBMSNwmoSPnhHvQ5KR++4jWiUV7Gcv
         RuxSyzp3F+FOhnNyGdj9FZk3g+PEz7hsTN2du7xpjl1ts1AsY1A9A34QsTs1YNsAix9g
         j6sE2d4Pj5xVN2gM8XysjqBvuKMaLMUP/jATkBjag5Q2w5NBXZhk4ZozjBQpcbFFx2SU
         wzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744138566; x=1744743366;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2RLobX/NWAoO5M1cQ5CruPiTUctk6qBhH262aYUiAZk=;
        b=tUcoAIqUf9WT2F2Ojl5eEJ96BAeyuIvWEMLkevEhXrUsi5YF7f5J60vHOB7dP1kMT4
         ATk/uYH66UKLfpj+bipCsRBm3OGubAl5H0KeDdqsagrgxAjNQ4nfhTN0SPWwkBUMcOlE
         GjyqS0jUw8k+SV0sO+/4BwmmhYjor1TBlRANMgGiLjTZydhvk3nQtSObMJ6VF3EOiRS/
         ezk5KU33rHWsckLVf+skwX3SxWSHTX8au2jPWpsIwaiTv0ewT6NzC9u32drBKeDaofxG
         oCQHSs2IlpgvQ0ESYeVBaVF+qUQmqqzyWNG6mUXxNDFcGav43YTZykPjpUdP5c07Y9Wz
         P7xg==
X-Forwarded-Encrypted: i=1; AJvYcCViqP7K+7p6/J7VsR+dx2mPh/Dozyn51UsU9zQf6Ys1BIlsIT/4xjmOEUqRzHhyYHYGXcnoa54=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2DS9S+qBN0ElSvR869SgE6etdwTujGFRLnwiE8IJBqiYbsQRN
	eAnyOVCHWlBiG3XCeSw09WYRdk0ZpSYg2wOdlmrZ8Fzpi9MBYUEq
X-Gm-Gg: ASbGncv/digvlqeXduU2cMjgL51uJdgocZUWAN/VFh7OwJel9Imo5yKNNo42SgSQu3/
	O3UfEZT0bMfmdW/hWbL54g90KZpguAvmrGJCDPxjZMdUzcZ6v6BIVqMix9woUDEDYDSlUQaA2lT
	SCoZ+AqtS15sA2BdizByEDz7X4QfazLWtndyVaUvy8x7qfWbtUisapsh/xt1jL49w8SPkgzqgLh
	306neCAH2R0+hXyXS4UvwL9vuN3oyhiHxiyI2qwMnzeobF5LPxnaAFSVI8AEhctFq5l6+Aq8KHQ
	Mx5Q5EX53atpGC4eGfgpsXq9S0+cBClRx9HbzLOeFq4Z/XsWdwadhqkNFgzm/i8eUaOjrMVXWf6
	AZr6ev17yp2eQU7O5PEbZg5fRLslm39xpCmcfbFioeQ2oTr0YTLA/Lcy4RXNeKRYNctYBYpgakd
	8Z/JV2EXZ2nYxq/j/ds6k=
X-Google-Smtp-Source: AGHT+IH4mGT3NxwOkcdKKPFRdtQ3Hu0EU2qa6tlBAPh/EvQuYNLT/psRLecdEUxrQodG3a9UegN+0g==
X-Received: by 2002:a17:907:7f8c:b0:ac7:c5de:97f3 with SMTP id a640c23a62f3a-aca9b7462a9mr26773166b.45.1744138565924;
        Tue, 08 Apr 2025 11:56:05 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfeddc88sm964443866b.76.2025.04.08.11.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 11:56:05 -0700 (PDT)
Message-ID: <41eb417e-60ea-4e1d-a293-fac362d52403@gmail.com>
Date: Tue, 8 Apr 2025 20:56:04 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 nf-next 1/2] netfilter: bridge: Add conntrack double
 vlan and pppoe
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>,
 Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org,
 bridge@lists.linux.dev, netdev@vger.kernel.org
References: <20250408142619.95619-1-ericwouds@gmail.com>
 <20250408142619.95619-2-ericwouds@gmail.com>
 <20250408163931.GA11581@breakpoint.cc>
 <fc34e774-e264-492c-9ecb-20eaf7bd87e8@gmail.com>
 <20250408184806.GB5425@breakpoint.cc>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <20250408184806.GB5425@breakpoint.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/8/25 8:48 PM, Florian Westphal wrote:
> Eric Woudstra <ericwouds@gmail.com> wrote:
>> The thing is, single vlan (802.1Q) can be conntracked without setting up
>> a zone. I've only added Q-in-Q, AD and PPPoE-in-Q. Since single Q (L2)

I forgot to mention only PPPoE here.

>> can be conntracked, I thought the same will apply to other L2 tags.
>>
>> So would single Q also need this restriction added in your opinion?
> 
> I think its too risky to add it now for single-Q case.

Indeed, this would be a regression. I will look into only adding the
restriction to the newly added tags. However, it is inconsistent, which
is the point I was trying making.

