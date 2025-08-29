Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E13332C306
	for <bridge@lists.linux.dev>; Fri, 29 Aug 2025 16:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756484614; cv=none; b=gggPTqXK7Kxyhepq71TjYeJzcwLKCzsEVHmPpNzNRwXPgpOk01GHnq5/Lr/7lT1hep+McoEpv6qQB1QIQNL+VwwSlUiB13W31s/1RqhgIBqZfe3R6GeVXoX0bw9GasQ6tVs+YUztbB5Hd8clQANVi1bDynEF3vpMrA8X521b6T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756484614; c=relaxed/simple;
	bh=IEH6aCSgySsvmxeMGyD6vtz2AyYfOBhMUEbE5AuvFws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i62QRqHA/QvLsi31C/y2hgpE3FztEWS1YalF4vKvwQe6ghIp5ITIsjnMvC5xo+tfOBGoGAytijjUgvbnT3zLu6Jh5PXRrQqEgzJbZjwMkYUb6NTLBrd0sNG8x9hgKbQlVtRbKEauENfg9mr7YAvOjmpo6WyUq3WvHQ7SJsHmYkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=ScQw7BIf; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="ScQw7BIf"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-336b88c5362so7656771fa.0
        for <bridge@lists.linux.dev>; Fri, 29 Aug 2025 09:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1756484610; x=1757089410; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HXohgHhMg5Bl8uDBsv9pYaNNFIL5EofYTOVHQXzVcrk=;
        b=ScQw7BIf8alKAEMjW+SvuMBakJQ8aW+dTmu6vjq3T0YggkZ7vt0IbhEDdaP5RllBO3
         2BzW2A3+7r+Npt/u65CH8UM2EQWfHcFwhGI5jb0scVkqmiTxXUudQT/gRJnc92+NLB+o
         P2NddQ9kcA/0bFUXG0SHW9r55lF9ZuPYMToMw57QizAuq7NFYQ/NL8907wcLH8IUpRlQ
         V4x80CzA1ev7bmoshAPCfkANlKgBH/LhU7iLuy9/lAhw/DOlrmtHFCJJylnVf2aHxnHz
         SbegJh9tTGYF889cr5M9ULZUakLnThatHC2XgpEGrNYfJXbwX7SqSahsevQqZhX35ls/
         tCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756484610; x=1757089410;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HXohgHhMg5Bl8uDBsv9pYaNNFIL5EofYTOVHQXzVcrk=;
        b=p1mCbVsKF+CW/Y2b+Jhg+Y6J6vztORQ+4zKt3khYRmSnTb5Z/ICo+dpZF6ZL0Zg+kG
         kAj0Si8GVZ3JjO7l7qGUNfg6mmQgo8NzL7LahuN60J4bVeFb0QpnL+14pZ/V8jdwNTNB
         rNvvp6mYUSGFUGaeqe8sO9tmsQGaEnBnInQg9i/La2l2o6sNYvFIPBkIJLUcx7koIYbo
         OhOIKhZJXSvfzm0Udphnn+qSSIJJ7CTnyK7QbTxpSEVlWFHjEky2uNaIQFqPUpQfysIa
         MX16UNjd0DhmR07e50bWNc984enYDph/N9Jsr939IsbocRrWOQgCXvarO7SCsGzWehgN
         cn1g==
X-Gm-Message-State: AOJu0YyK2zCmxbeytUOVXtxsBEwHw1S82Oj2H7elYyWlJVkGZX2heuYn
	ju+bQgJW+rGH9tjg/UJ+/2sXtG2ee4FgouLFZfuCfMvxF6tyr74z3KJ3Lha8dfXf2s3vIheMVyS
	I9ziD
X-Gm-Gg: ASbGncvDQNPQMZj2HduUXvGikjmebCqUGJCN4tyLGQvof0mrjgvOqIwV0wX1MJ6SK7O
	VkE3nFtALWAxCAwOSkH8t02chr/xXgke1HL0nVOlpz13IjtqMLFsus75jhDbaMjkmyS1ugnDJjB
	CzFUWWiD2pU2wCklZ+O/BK4lyfFghnLqhqrEH5vf+hlydY6D5zNpFckVwgNNGzUAtJRfLsW6jvu
	RGau/vEH6nRl1HIFJxR6Eh4bGzccB+x0Qiy4Xynn4HWLfVuw7wa2zl078SKPrRjz91J3LdmVWZz
	qnlMnM9EqCYjbDcJYqp7DkiwqP0vZPq2fktR9jXsBD5VmbmiHfjtNv2dcKIY4qR3Y11nYiSjNjP
	RCjR9xvUYMPULNBu+lSyKcz4vK4wZYUW/ALqIpOdflbT6kQAqNq/zBQNcIDZMpKKi11R9xnl07h
	AQLw==
X-Google-Smtp-Source: AGHT+IGkDyVgClqPhi+jy/rUB2ZmKr6ERUVBat7raNEZp8G3QswM+s5vCryFnVhmubSoyKXakx8cmA==
X-Received: by 2002:a2e:a99c:0:b0:336:bcbf:9e with SMTP id 38308e7fff4ca-336bcbf06ffmr6988971fa.20.1756484609848;
        Fri, 29 Aug 2025 09:23:29 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-336b468ac23sm5215941fa.23.2025.08.29.09.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 09:23:29 -0700 (PDT)
Message-ID: <bfb11627-64d5-42a0-911e-8be99e222396@blackwall.org>
Date: Fri, 29 Aug 2025 19:23:24 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] net: bridge: reduce multicast checks in fast path
To: Jakub Kicinski <kuba@kernel.org>, =?UTF-8?Q?Linus_L=C3=BCssing?=
 <linus.luessing@c0d3.blue>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>,
 Kuniyuki Iwashima <kuniyu@google.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Xiao Liang <shaw.leon@gmail.com>
References: <20250829085724.24230-1-linus.luessing@c0d3.blue>
 <20250829084747.55c6386f@kernel.org>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250829084747.55c6386f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/29/25 18:47, Jakub Kicinski wrote:
> On Fri, 29 Aug 2025 10:53:41 +0200 Linus Lüssing wrote:
>> This patchset introduces new state variables to combine and reduce the
>> number of checks we would otherwise perform on every multicast packet
>> in fast/data path.
>>    
>> The second reason for introducing these new, internal multicast active
>> variables is to later propagate a safety mechanism which was introduced
>> in b00589af3b04 ("bridge: disable snooping if there is no querier") to
>> switchdev/DSA, too. That is to notify switchdev/DSA if multicast
>> snooping can safely be applied without potential packet loss.
> 
> Please leave the git-generated diff stat in the cover letter.
> Please include tree designation in the subject, per:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
> 
> I'll leave the real review to the experts but this series appears
> to make kselftests unhappy:
> 

just fyi my email wasn't working for 2 days and unfortunately I missed this set
I took a look now on patchwork, I do have comments but it's difficult to reply as
I don't have the emails and have to do it manually to each, so I'd rather wait
for v2.

a few notes for v2:
- please use READ/WRTE_ONCE() for variables that are used without locking
- please make locking symmetric, I saw that br_multicast_open() expects the lock to be already held, while
   __br_multicast_stop() takes it itself
- target net-next
- is the mcast lock really necessary, would atomic ops do for this tracking?
- can you provide the full view somewhere, how would this tracking be used? I fear
   there might still be races.
- please add more details exactly what we save on the fast-path, I know but it'd be nice
   to have it in the commit message as well, all commits just say "reduce checks, save cycles"
   but there are no details what we save

I will try to give more detailed comments in v2.

Thank you,
  Nik

