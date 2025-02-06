Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8696236433
	for <bridge@lists.linux.dev>; Thu,  6 Feb 2025 14:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852721; cv=none; b=QJdqpZLbbXyn7IwpdAS7txjwkI1huFNbDW1DjpJZPvCbk9TDhvRBLomEoueSkPmmvooKvcIUCV5lZQadGfPdQVyPwwxF68/YA9oF2zPcMa+4Hrt9heiiHYrbrETqc/OOv7nKt0YXDxtQS27sifjGMt2u2X0qhVWK/EG+c68VgSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852721; c=relaxed/simple;
	bh=TPNQfdWjJ8Yhd7t0wOyWnRcoTfWf/QHkmP+F+4/taO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VlxzuiHyQXbv+/TQhHfrRNPi7zAXfh/jTtz0jTrd1v8R0U/GfP2L2TEstC1XPuqf1rEj5zZPNT0KrL4kiXLoACu1ga9TXCqRvH5tlOk2vbX+fszZhJPxnfyTTPHdr8wL23lQgLA7NOc0YzhjHkeLq6aHliz+tBlZ/8YMluudb9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=n7vvRr53; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="n7vvRr53"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab76aa0e6fcso136054366b.3
        for <bridge@lists.linux.dev>; Thu, 06 Feb 2025 06:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1738852718; x=1739457518; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uw/h4QDTlZnL53fcJ2QvA+6Beq+Nqrk3rFi+DoZZ9Nk=;
        b=n7vvRr53n5QPufXmUzTPVleVKZ0jGRJzJyEjcAErVTL24l7wmKN0D8uSa6dFiN4XEB
         FbTUi4/c43WgXKhhZG1n9Z5dlB2/kp0v10449hYE37JgXCa9XGWCnLs04NxqP0ggmCHX
         M4bXmCiMnyrvR6A9G5sfQ3DaTmRta5yDuYRYEVLMZROk/eJU6k4Y1L0r7msWmvpe8JEn
         bma80wgN+0ygVR2+FKxG56M9I/M46JNOJoakF5awLBAuD9CUOODsbri4RCzJGGAPBIox
         Lj9JVrD8dx0xk4jhfeUZOBCGAHMnHrJs/qkT7FQuhAmOppj4efHK7naM5QO7XUr8EvZs
         CF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738852718; x=1739457518;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uw/h4QDTlZnL53fcJ2QvA+6Beq+Nqrk3rFi+DoZZ9Nk=;
        b=RLdiDbNZA2HRraqI20UgOa1rJ0M8xlPkbYm+TSjp9T538AO82v5iV80Y0PF1uCgi/o
         9WwJMZBhgUANGqH9Wc4CABbvQiyXmX/WzncbFC/I5P6n+FWkaqESVrzqOB8x0cuNZtkJ
         YvJX4STmj5X6D1LjyNp3ocD9Xzgwny0JHd3vWzEGoIaYJiTCjU7DsIzQ9LPet8ReEVdj
         KxeqI113L5PPsSjFypuWfzBAbFmExwO5UtMp6p+LtMyILW4uXPL8aqiUNd9lD5WnQDzZ
         xng3jJDWUGxcYn6iQDFutWJXefBYgqHSHrwchtfH2QPjduSU5EL+CVrfEHHFu7s5hcO7
         /+tw==
X-Forwarded-Encrypted: i=1; AJvYcCWuMaATDIqfS/nPO9EiFWiMyglJ5YrRyAKqg1StVHvTfdMHdvHa5QfTbyA3VveVlmbYBIi71AQ=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5hK7Cbskfl9d04HPW/nhQ7oCFcyvK68118BOgzY3enRe3Zqfe
	e+cJGhFQfbriXXkBidoolPIspBLhmXqmXqF3KjE8+sEP3yLxxyLh5Uxai9d3O+g=
X-Gm-Gg: ASbGncvhrTEq4yRHALi3g9FJLnlLhf56n+ykKlgrX62gsaquRKBMp7IXPbI5XGtXyUT
	0EChCU61k6w/3NFtC+j/2q/xdftj0LhWP2WONc5CA1zgRetUmljaweKhVpr5SzvA1JmTPcF2nem
	ajRe9ksX8W48Yyo+/ouzvMrm7qIR5NSgu5jNotGlDiJMdR3/V16u1FCUCHI2QhSNXRtmXemWCOg
	dWcG1o8zX6r4unsR77MpxTv/7YSv/M49/L8rVk3Yu5/k3kWDeOnuoFJMYAXsmXE0ERvk+HL1aqR
	d6uoYFSw4fMEsIFU3og8BvzRBkRTZdM9eyTNJyf5hifX4PE=
X-Google-Smtp-Source: AGHT+IE870Ofos2AH3n3TMWHfx6tIRQtGQ55FfR3imiLRJSMot66fT9h5iAgoSCOr6Lm1A/3Jqz+PQ==
X-Received: by 2002:a05:6402:4486:b0:5dc:6e27:e6e8 with SMTP id 4fb4d7f45d1cf-5dcdb762a5fmr17852032a12.24.1738852718101;
        Thu, 06 Feb 2025 06:38:38 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7732e7196sm106659366b.89.2025.02.06.06.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 06:38:37 -0800 (PST)
Message-ID: <2f58633a-83a4-4128-9a1a-bd0612793bbf@blackwall.org>
Date: Thu, 6 Feb 2025 16:38:35 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 02/14] netfilter: flow: remove hw_outdev,
 out.hw_ifindex and out.hw_ifidx
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
 <20250204194921.46692-3-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250204194921.46692-3-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 21:49, Eric Woudstra wrote:
> Now always info->outdev == info->hw_outdev, so the netfilter code can be
> further cleaned up by removing:
>  * hw_outdev from struct nft_forward_info
>  * out.hw_ifindex from struct nf_flow_route
>  * out.hw_ifidx from struct flow_offload_tuple
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  include/net/netfilter/nf_flow_table.h | 2 --
>  net/netfilter/nf_flow_table_core.c    | 1 -
>  net/netfilter/nf_flow_table_offload.c | 2 +-
>  net/netfilter/nft_flow_offload.c      | 4 ----
>  4 files changed, 1 insertion(+), 8 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

