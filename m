Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D146B1DE894
	for <bridge@lists.linux.dev>; Tue, 11 Mar 2025 08:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741681361; cv=none; b=jcD40o07Q9t5kf0MrdrRiK7KLKTC8X1QAiTQS5IejZw0/1SBPLrYvp6tlyBtYNE/UI2UHliDUw8PQEaKaPYE3WGPtwKxuuIXg4I+SzJIQ77QrWc+gEamcUbyyUwXv1V030CKijlZP2c983hS7NosFfxXg6VcPhuThjpk5fjY0Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741681361; c=relaxed/simple;
	bh=UFNNBRGR/6gDpDCHdvz/G/BUoK1siPWwMWJCgE09xoA=;
	h=Message-ID:Date:MIME-Version:Subject:Cc:References:From:To:
	 In-Reply-To:Content-Type; b=EKcB2N8oOmOeCHtpMThcfXpxzBNxWwlgbBEE+RG+GSuQxi7Wav7u0TfQLOoPjXMiCKDmuvwLr6p+tWYEG8PRdQLYchM01crCltLQ4aful1Do76zXNsOiGdVwZM534b21YWLqT2hbC7/vt03bL9uH2VbQGuYrZ7vFAV3yW+nhv2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOghFY+a; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOghFY+a"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e677f59438so3701250a12.2
        for <bridge@lists.linux.dev>; Tue, 11 Mar 2025 01:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741681358; x=1742286158; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:to:content-language:from
         :references:cc:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UFNNBRGR/6gDpDCHdvz/G/BUoK1siPWwMWJCgE09xoA=;
        b=kOghFY+aXArUCDYkbknTGHXtp9FTKm01MCFI0q8hLl49QKNCmdodXvTJuhVZZk2e3H
         wYz/VM2NCKs0oYFm3zWd6f/xXrX4pjsMNXUfmd+SzlmzwgkqYoSKbtZEhti/+RM/TOLn
         0EwHlbvtOjIiYfL8sFgrngfK/+psaFIVCJxdUqZ6MiO3GCKWPwtuhjL3xk4MOg/tGjc4
         v5oruJ8NRoCC2e7aaSzuIPtVNfEaHOiDvpoMQS3CxJOOQDhgjIfnvCU5IYKKH9MctdYp
         wPyLcQgTTQpU1ZYpTLNQpXwP0nL9rhemv0pDpoPHiLTtkbr59IDXDLN5boyY5RDePz2q
         Irdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741681358; x=1742286158;
        h=content-transfer-encoding:in-reply-to:to:content-language:from
         :references:cc:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UFNNBRGR/6gDpDCHdvz/G/BUoK1siPWwMWJCgE09xoA=;
        b=tdR2EsBC6f2DhkFUh5Ir8+xWgzA6ixyFcOPhlGm4rDQmL0JjbCW0Mq2mV2oV1c37qp
         ZO2Kq0kNQsi4EiboW+GJb8F8K3fs29NBI6IyWFesRZWVHILzohZ1DxIJUt6RfY+5yahl
         HHjDWcES3UbheE6OWBpEYY+hWVOvQIEbPz0pvG4kY+ETXOPVFXLbnKIeKMMfS0NQOJzV
         DggPDWKX9MIqAGbmNO9+E5xbI497baoCSf5ipUNbfAEOAyffvWZvg8byWkxt7jvR4Wvm
         uNGtTYOckQtT6Xbd8d3Lg0BgVfS2VQRBlucVQDBCHci8rN0sB4bVASOEW++2fC5qVpRO
         K2EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEtxK2RO5bAiuvmEnmWNc/tm0RThkNgI2Ekcx3poLjGszc5/ozn/RkZ9goCqFTNLdegqVy5QQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YxNPhWGm42mkm6TO4vAj0GBmIZt6Iv6aoan/uN7h2V7H8dLIZUr
	0ZsG0fWkQtHWeqEJCo4WyGG9yuASm7S5LgEF3Y58IQdwKxy618mp
X-Gm-Gg: ASbGncvPHclRWk4U9gbs3QzBeweduLQ9EtuLzEKjZUvAeT/p2rZBjYJJcxhYwKa/vED
	2o0hXbcMgWdTSx2OpOx9aCUZbA8NnZ2jG2FJufGaymG67G5dUvizNQGhjDugTR7IE+SNgY7nINH
	mMxXJRtyMVmZr/GiuFpVMkhW2MIr/siKI0rYEsD3V8iu/SEC00IvC2ABYMnesYicftmpde6lbXC
	JrRd6vzppTBnLzsVOXxzZpmzNOQfAS3HlGorIKgSQsZkmmUQjrTjdDWL8iidiCgyMyShUvHhj6B
	gKWOqxcCATCjRFZxOWlR3/KIcr6pGTwF0+TnYZqtDGdKj+Fin5ebFuyIDCFvtXcgnHuYX9pa37u
	I6T/vxQqMGWzqEhD5xnAc0z2NlDDCpAYp6QTbxTiddBG2C5jWNhuNGEguslM6EABiSgU5dVt4+K
	CqiWeg5MakoPO979XUjbc=
X-Google-Smtp-Source: AGHT+IHVZMV/MbyEPPexb7J3WeNZYZ5CxjZ+VTFaUFe+rZPsUq+igvni96NJQxPQP+jJ8ClbAvXlfA==
X-Received: by 2002:a05:6402:4302:b0:5e7:7262:3bb6 with SMTP id 4fb4d7f45d1cf-5e772625471mr1960367a12.29.1741681357815;
        Tue, 11 Mar 2025 01:22:37 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c76913bbsm7880931a12.78.2025.03.11.01.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 01:22:37 -0700 (PDT)
Message-ID: <897ade0e-a4d0-47d0-8bf7-e5888ef45a61@gmail.com>
Date: Tue, 11 Mar 2025 09:22:35 +0100
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 nf 00/15] bridge-fastpath and related improvements
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
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
To: Pablo Neira Ayuso <pablo@netfilter.org>
In-Reply-To: <20250305102949.16370-1-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/5/25 11:29 AM, Eric Woudstra wrote:
> This patchset makes it possible to set up a software fastpath between
> bridged interfaces. One patch adds the flow rule for the hardware
> fastpath. This creates the possibility to have a hardware offloaded
> fastpath between bridged interfaces. More patches are added to solve
> issues found with the existing code.


> Changes in v9:
> - No changes, resend to netfilter

Hi Pablo,

I've changed tag [net-next] to [nf], hopefully you can have a look at
this patch-set. But, after some days, I was in doubt if this way I have
brought it to your attention. Perhaps I need to do something different
to ask the netfilter maintainer have a look at it?

Best regards,

Eric

