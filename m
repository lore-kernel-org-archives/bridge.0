Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA43148316
	for <bridge@lists.linux.dev>; Thu, 13 Mar 2025 18:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741888906; cv=none; b=h2ILsfUtboYJ9dx2rRPzk5Og2VlE4LOquwZ8uLozhxXrzsgV2c2AJNhIwt0bV2lNWxfutTU0ru8Rm3141Rd9fFCFXqUEF9mxVwcawbyH5zvWBoFjRoEWgOMg1rd4lfbWhlvf1l/pgSFOwgK0t2uk2BjqY6vqrbgyI/atOgSmvLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741888906; c=relaxed/simple;
	bh=6jV0radH4S2lzjjNkKAxQaEnlVGn3SNEWffq1tdiwe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TgONvomoTo1Qv3Zew5q+fV3ybBHjANS+fIFCASAUrkuDHYjOM1TWcDzncGip3niJsYvf1fFiWfiIRpKPwOR78DynPP9v/A1qLWAJ3HqU2UFZsXMCzljLfWUaOxLZD4t4oVi96nBmHnWqvyn58Mf3Nx6p2lXC06nJR9eH/Y45zZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBl3ej8z; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBl3ej8z"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e614da8615so2420258a12.1
        for <bridge@lists.linux.dev>; Thu, 13 Mar 2025 11:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741888903; x=1742493703; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W/aqvoIKuR6wHeO9Dw3liQGVZV24Y7M6R/uaPC7XW8g=;
        b=BBl3ej8zQDWPZo8upaIo5tjPhaXMXHGwaMDs8N+rW59YOS+B3/VTUq1ZA/G2agDNm3
         QTchBpstlGThfU9R9t7AgV3cWC6OKoeRLISSbAhxHLeSld0gfE83hBrUdccuev90Zi63
         kMY/dq+HDfTq4NQHi5fPQDFyvDMNm8T/KqpbtyF207rKcGY6nG359FIRAVapZ48hqD3U
         mtysIkoVh54NG3c2qj/9QwvBjj7ZLpXI2SB56w3vqg1f0LbFK8T9pCwSVtz0ikYKuk8q
         5lBhRU5qzGcArLh6FCTLFqADCi1Ahuu1+YCJrRgFnMUt2YhCVswmLMto/tz5Gsk/Zc9r
         OBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741888903; x=1742493703;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W/aqvoIKuR6wHeO9Dw3liQGVZV24Y7M6R/uaPC7XW8g=;
        b=oW2WWYU/h8vlEH+eVFGgowcpUzVhwCtCZVhBG+9MPCFqAwEQEIlI42iLzNRFCbCwVx
         1acYFPASJaXgL8MmlfGH+h0+U60nnbmsSm7cN6e/1/6LccvHLI/gr7qlEsUJQd7DfU4/
         rUoiUzG1SSLSI0Sw9KRb+SdvxOaIC7UXYIK+msxcVW1oMXYtnpw8D0fwm9S8IGK0QLr5
         hQe7dg5htLJ8j81/4LZWAUSZ12B0s/M1t5eEQW9Kk2tXTYt9QVbDRvzM1u2KWxNpankN
         9oWpPfkI+1HxMgZRd236lDZbghH1zAV3UFWUYWVkXLIOhez2ZBUHntBQVRAwZCsee0k+
         9SIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJZ9VtVTwGmQ3EWMc3ZklvmRW3ZkYHQEZWvWbRKHWoynrmCnZo79N5JowZivuprNaz13J/QOU=@lists.linux.dev
X-Gm-Message-State: AOJu0YxPgoXojJW8JkyD4LT/QlgZIqE7tpdqTrpm/0lYr05TtfDGYdlT
	aMsj39ecP32mKHjJXOp2UJLvB701hCPLfOVL6jZ0yxKD4n9cGPCF
X-Gm-Gg: ASbGnctlecoLYOMlJG/7M0dKkH7/PZ5RNXXv2fUbt756FlnfixYx+4AcVjVTzASCm4s
	MWRiQqpW1qSi496XzZZoFIz8xZtagLddoUwddjrKyR3ITE/fODVGoDzroQWUPjTzqJDdRbwBq81
	LMRDRaFl0YK3QnNhnc32IOZO25xRq+zTh3Omun1SrJ3PnR/A0vcIKpFxplpJQwoePqNF7kOKJaw
	gfOzg8m+phyWUxe2+BnpgBZF6Z4WRXg4JtumQAUR17+JoSjv//Wpn5R9lZc8XebXMIvd82606V8
	VJ3Jg2BJebC1P1AbzpH9narUfdeC8bn+BjA6pt3NgVXoIn7qf6CsdG2JMBfqk5sKaAExrMO0YgA
	xsf+3hBk9TSRiTJNLrClAC8UYiesr4XIwzlzF2rGEvUUuxOg6ihDti9YpXjvI/gJlQQPgflZUON
	l5JqM2J9ia+Xwj8eJUlO4=
X-Google-Smtp-Source: AGHT+IFuZtAhl/EeTwlESgZEmFiH1TMtmKl7RGfRolizt1DBUCNDPnPwoWBarCBAea1UlBVhaKlHyA==
X-Received: by 2002:a05:6402:2550:b0:5e5:9c04:777 with SMTP id 4fb4d7f45d1cf-5e814d805b7mr3320106a12.6.1741888902566;
        Thu, 13 Mar 2025 11:01:42 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e81692e6d4sm945413a12.9.2025.03.13.11.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 11:01:41 -0700 (PDT)
Message-ID: <02b97708-1214-4fa4-a011-70388cff8f79@gmail.com>
Date: Thu, 13 Mar 2025 19:01:38 +0100
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 nf 00/15] bridge-fastpath and related improvements
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>,
 Ivan Vecera <ivecera@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Simon Horman <horms@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, bridge@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>, Vladimir Oltean <olteanv@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>
References: <20250305102949.16370-1-ericwouds@gmail.com>
 <897ade0e-a4d0-47d0-8bf7-e5888ef45a61@gmail.com> <Z9DKxOnxr1fSv0On@calendula>
 <58cbe875-80e7-4a44-950b-b836b97f3259@gmail.com> <Z9IUrL0IHTKQMUvC@calendula>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <Z9IUrL0IHTKQMUvC@calendula>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/13/25 12:11 AM, Pablo Neira Ayuso wrote:

>> What do you suggest?
> 
> Probably I can collect 4/15 and 5/15 from this series to be included
> in the next pull request, let me take a look. But it would be good to
> have tests for these two patches.
> 

These are not most important to bridge-fastpath, but it gives extra
possibilities. How about concentrating first on patch 2/15 (with 1/15
removing a warning and 3/15 cleaning up), adding nf_flow_encap_push()
for xmit direct? It is a vital patch for the bridge-fastpath.

Anyway, I will look into writing selftests for conntrack-bridge setup,
including various vlan setups. This will take me some time, which I
do not have in abundance, so for that I do not know if I get it done
before the merge window.

