Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095941C6FF8
	for <bridge@lists.linux.dev>; Thu,  6 Feb 2025 14:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738851708; cv=none; b=a8g6mV5oWCUSOs3/zmBziya5EYUqxiM+SRrya8YRrvJY56EZ71d6rtTAPDoLYXqJ7n/DIXeOy7uR+rmqN5H2pp9283Lr1RqhRd1AToJDE2fJBqzoHKyov9Tiw2DUN+mNL9gtzA4yu/FW5C35tkjQ4g9oWlQcUdweNIyg7KG2PXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738851708; c=relaxed/simple;
	bh=/TJhMhlC9yfWlzDzdRKnoTLdE7CVcxNUHvoHyyqOcac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KWCWz3ZZ0Duv6Psk+OGp+yDUyOLZntRdD+HLeCFqdEWt3DqMeoGxzAhnUU0MVc0Ns96v2HbvRsn0AcVhpb1hd37n6H3dCegQVG9/3dDHCEfDEtdSN6MdInYqaJxPjP/bkqkxiHhW3oisGnYIPNzO24bAGnjJANleQWbxBHgAJj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=gCX5DJBe; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="gCX5DJBe"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab737e78900so174611866b.0
        for <bridge@lists.linux.dev>; Thu, 06 Feb 2025 06:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1738851705; x=1739456505; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qzREIBb+bKP5i/Ck51DCfeo3RpAWV5APsV60x0FMqs4=;
        b=gCX5DJBee/i5IEVY3cq/OGx8ULfzyE6rP6sednDjg+LSQRt3k/Og6nzsviV/tqhQzf
         i8GWfUzYYx9K87lRfUg/HeXjHvuMejbTu26zp6Uu003tgE9oVS1hDy3NM/wi/+Pz2ZUg
         1+ZRp2w15Dx22JPQlM1ko03wt59z2PX8VsFfRvPZt7fhuJZ7QLEqxL+0qZQw3LZfRLhR
         1X0yFgQSo66O/LjWLQ+NHNrt2fFM6UN7ZaOfR9EuzMJxM/EBtsrFCSPI0KfV/JUSqePy
         ahJb1ar7CEU8LfucAZ6x/v4y+IUTH4ogzHUZhUjHiSBWsAm5qBGTHKT960ydNKWM2LZA
         SYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738851705; x=1739456505;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qzREIBb+bKP5i/Ck51DCfeo3RpAWV5APsV60x0FMqs4=;
        b=syhIeUKhNc4lDybICvxxisZwJ0K6gNiSIEg2wLmb+Lwl6sglHMMPffUFuchAMS8YNF
         sVuSXlpw1Jga7UL7FXp8HltI2Kv0HQbR8LIGt3YrJxnIqs+KyX3+tjLZ/96NJcRKxRjB
         iTEQRrOYvzvNRi5b+H8nbAAnchSSVipv4dIak+pdSCfSV/ElDQel/4S91ZvUG0GX7/JD
         4b+lJDmNevTcSx/ygbH3XR37LYX6Kh5cPPMf8Rw1yBdI7snGaqu8By0/o0evHAahFs4n
         3fS9oFZd2+j7UzC4oqG9rrNsBgZoO/NmS+IGLQ3x6/+LXzygrUEwqABWlqeJp33FS1m8
         gLgg==
X-Forwarded-Encrypted: i=1; AJvYcCUuc4775iREVe6LWRN1P/DfwcRlb7z6CofoMBYn2M09GCJ6IRxYq5u78B59UFuEyyyikJ3QDaQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YxrjiKoLRbUwnraqu9cKPehKNQ1954P+XxGJkVInFKtGSbdvBr9
	+Yl3jmesSkbb7x0+M3x0sA+RQaG9/RdUL5QatFvSo104soF1dopowmgPjz3AAV4=
X-Gm-Gg: ASbGncupt0sY7rBO4zKYCLmk4omNu0lCYV+kGtIOc5Dyuu6C4WBEd6pTGVEuAPlwqwF
	GYFF7w3Z+HqsAIq5EvRSaS7jVJkkDxLgjCoXtWtxa5OdMWTxA+5CUU6ET8AfCI3C3YphqTtipYR
	LALaBdndZNkUlrxHQ9Af+G0GbwSwLRmGaJLB3sOCIeMw7hdlc16MDXKjYi/I1dXvL96UsQPONX7
	EVZ74b19me9yDPWgCiQL9ZVt2wgYJ5lw7UKv0bzPbJNkrZHewueSwNC9zRgSTrtQh0IpOx71+YO
	J3yGNpwGFQTfz19aGNjIpomEH43QuQ80W7pkOBxdZO2S7FA=
X-Google-Smtp-Source: AGHT+IHYDakGj/X5YiewxYiKiang3LLrhidWY47Oe3DTivu/rcwezti/yOY3bxt3zD/zpLuTb7KrqA==
X-Received: by 2002:a17:906:6a16:b0:ab6:f59e:8737 with SMTP id a640c23a62f3a-ab75e262320mr699358866b.27.1738851705010;
        Thu, 06 Feb 2025 06:21:45 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7732e70bfsm106144666b.104.2025.02.06.06.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 06:21:44 -0800 (PST)
Message-ID: <fef59299-aac3-41b1-9783-3a3f35dbb7ac@blackwall.org>
Date: Thu, 6 Feb 2025 16:21:42 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 05/14] bridge: Add filling forward path from
 port to port
To: Eric Woudstra <ericwouds@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Jiri Pirko <jiri@resnulli.us>,
 Ivan Vecera <ivecera@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Joe Damato <jdamato@fastly.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Vladimir Oltean <olteanv@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 bridge@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250204194921.46692-1-ericwouds@gmail.com>
 <20250204194921.46692-6-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250204194921.46692-6-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 21:49, Eric Woudstra wrote:
> If a port is passed as argument instead of the master, then:
> 
> At br_fill_forward_path(): find the master and use it to fill the
> forward path.
> 
> At br_vlan_fill_forward_path_pvid(): lookup vlan group from port
> instead.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  net/bridge/br_device.c  | 19 ++++++++++++++-----
>  net/bridge/br_private.h |  2 ++
>  net/bridge/br_vlan.c    |  6 +++++-
>  3 files changed, 21 insertions(+), 6 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

