Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC071C5F1E
	for <bridge@lists.linux.dev>; Wed, 12 Mar 2025 16:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741796495; cv=none; b=b9i9zhxV5Vahsr+37YrNmOgq5gNGs7m3BGd11PgntMmXpZ//R+rpkMlDifBs9hIutXczfS/rX+tFhd6+xWLSVFWLrXfvRng1SrE8UGUvdXFTn0netI5fAMITzEF5znPkoZjnXh/5TbLKICAPUrxz64bHvm4IH0vCRLYB9mvm5wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741796495; c=relaxed/simple;
	bh=AA0MJOsn9jCYm6rQxqAqvA15NsJHoc5M1iB3UxZTL80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UWE+rfQ/xajbWE83aBPog+LL+4f2rztVTMykh6Bq1xorRDA29H/V/EaFLp0KfDkIsYSPM8G99WDPTblKdaV2gmiwEcmcTwn7xVC5cGA5PY3MPzpaNYRbbelTqQfT+EDouCxiHUkpzRstuBPq638R+V5BZdVHCK+a5Ex6FZM37wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/eqmsJK; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/eqmsJK"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaecf50578eso5537766b.2
        for <bridge@lists.linux.dev>; Wed, 12 Mar 2025 09:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741796492; x=1742401292; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g+vFr6C40IK/QoHRZZXYgKsZ4IfXSOBUm8PFsyPbVxQ=;
        b=D/eqmsJKF5beoAsOxRre4zA24RPHV7WpKk8sQmHyuubyaAFf/uuNhleYADvZm9Lvso
         vQ6U0ldF8FaeR+5VSQg881bK2sQOA914TygPnTfCivXf2NEGYszq2UM/N7PG8TOP/q8r
         tHnoZMggGBz8Ed+rvbUlciJM5IL6k/1RWuDClQU91nlKEr3ZAJNGI/jXzxRHmcV4YitT
         GPSWDK4yCqTXoNHgwcl/gMPNQPCbgK86UBmk+5UU2dOcaxX0Mvagx7VY/hymVjM5duTe
         D6t3LmBoxEJumm1vXjoUHMSkSSJgGlr7Jv50CP2QEUYNjP00yf8WrQJMA+Oy67TC+w0V
         ffsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741796492; x=1742401292;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+vFr6C40IK/QoHRZZXYgKsZ4IfXSOBUm8PFsyPbVxQ=;
        b=Uxmc3+c5gyaceNEC1629Lk7INy0DZBOVi2Ye5a2ltAXAFtbmDDkVbrUXgkdBoba8dU
         fPMZ9979+TUs8HmQmUyRS4kTq0yGXJ2rEsF+oy7AbdQac3atQg7VUq39nr+oeoZt1+Gb
         EsxRmJJPoPQKmM+VExU+FE7Btr5dhVGgVH85wHU5kyDkswNmyyocqfcMjHXKd6EwJfzy
         Y3t+Qd0Ta8ezeUVIU6mA1ON5WoOlI71VVJbeKITKUwlZY3KrhwNR6jCi8m67zqkvbtbL
         fcnacMQ6WA5D00JnLZYwfaefyqy3K5yG1BJ4ZGQYhsPHxqontLY75Nhei5KvWElrJgI4
         PnjA==
X-Forwarded-Encrypted: i=1; AJvYcCW2DCszCjUvT93KjqqpXvzkNsdzAwfQpD7/B9DdxCXTr4AQDQGE+g99Cc4fFXhkoJrU6Ue//rI=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+q++h/DAQAjNtiCyotpzK65lHidOgaLxJxAsmkXKE4gOqLFeN
	1yuRcl8ShtQjbcOwtqdf63EgcZ7nf1AO5IFc7iQNcmn03+sbJ8TN
X-Gm-Gg: ASbGncsprFSKgHETtdHUX4wQLSIp07FpawiAKwyDKd3j/bx/mdHuIoypkVoU1W/VqS5
	8d/GIk08BCOWX3TmQqahRo78/b7L0Dq8g9HaHlzAub3se+xNWuM12NjQsieAn4SyR9jCCx/iXvg
	ENrH/maXAuPvRqq+a5Pym39IgJPNPKxc1g4Wa3YcE3/DWbBXqcwaxizTh/V4yrXRUwXD4rtQQig
	4+ymVTjb6QiGbnwt14HzyQA6DXdCcva4/PaB+LoRwlxE4LZgulg4pl9xjvpzJINHAQ1kEvRo2Hu
	Jg+yJIvDOBAziI1wrSh4bm9kZNMcNGOmNOtZ/swpROLD8gH+85nOis4h89urCToqtjDnMIhrPBw
	+bNGpsBuMSQsC8NcLslagwN9YcEGfAis+KRUJy5LkEaTM8ztKIPTLbEWVsFLUxHEe5FmWRYlVkB
	fo5eEVOH0vHtXMyEpvwSGSQx3teqkKCg==
X-Google-Smtp-Source: AGHT+IEaEC38X6pFHkhcOdl/BcwH+TXUrXY3YHVZyCJc94P4HbdEGDzPYfpH7BevKXGOFc1f9RUFvg==
X-Received: by 2002:a17:907:1b16:b0:abf:607b:d0d with SMTP id a640c23a62f3a-ac252a884cfmr2996838866b.16.1741796492007;
        Wed, 12 Mar 2025 09:21:32 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23943945asm1081554266b.22.2025.03.12.09.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 09:21:31 -0700 (PDT)
Message-ID: <58cbe875-80e7-4a44-950b-b836b97f3259@gmail.com>
Date: Wed, 12 Mar 2025 17:21:29 +0100
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
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <Z9DKxOnxr1fSv0On@calendula>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/12/25 12:44 AM, Pablo Neira Ayuso wrote:
> Therefore, I suggest you start with a much smaller series with a
> carefully selected subset including preparatory patches. I suggest you
> start with the software enhancements only. Please, add datapath tests.

Then I will split it in:
1. Separate preparatory patches and small patch-sets that apply
     to the forward-fastpath already.
2. One patch-set that brings the bridge-fastpath with datapath tests.

> P.S: You work is important, very important, but maybe there is no need
> to Cc so many mailing lists and people, maybe netdev@,
> netfilter-devel@ and bridge@ is sufficient.

Ok, but my main question then is which tree should I work in, and
therefore which tag should I give my patches, [nf] or [net-next].
I think it will get more complicated if I split my patch-set and half of
the patches go to [nf] and another half to [net-next].

What do you suggest?

