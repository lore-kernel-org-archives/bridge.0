Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363891624DD
	for <bridge@lists.linux.dev>; Thu,  6 Feb 2025 14:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852815; cv=none; b=lHDGpMPjxXqK0gknWp1xWYhVTo/nGpu2JdllH5Xw8GLTW8mSNe4REbeNygKg2Ce0gk53BtO3j6zdDwyyFmNxqSzZx0K+TF7xgAR83tan/VM5xDDl+WJBAboxIVVao1/Hu/p5g+ojbvJ7ioJTKbB52jZ+Zhh18HWnWxK8MSM8IV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852815; c=relaxed/simple;
	bh=JpAxptbFMmyvPyTMd0gAMzXIKL0NcJG3/A4LZYoGB/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iN9ZkSSTuFgaaA6Kv3d47sk9Gu4s1AWhuyYn+HQDUrU6S57OULZEB6HZiAvOXMxGNJ5Qgnr+DCVi+Oyf0KwXmkuJKZfFm4JYDdVsxCKdd6A5YjctwnMmpQxHconEvPV1MzsjCSqyg47WN8bSDLN4A8vlUps6oXER52Ok380Dots=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=O+FrbdXl; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="O+FrbdXl"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5dced61e5a3so1687517a12.0
        for <bridge@lists.linux.dev>; Thu, 06 Feb 2025 06:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1738852811; x=1739457611; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HaF9oK+ht+6PJAmQa8x2eJ5jIN8d/CbjvcAD/HIVPi4=;
        b=O+FrbdXl02tzeNzue2fIdwAw7uwFv6pl5IbSg8hshvPDKE5fLsA5FUZVg3OBk5802l
         m054EdPGuQBetsVp9AJTiyAWdpHPwLU5E2BMimzxlzD1NEzl0swFNxOog4t6+jLw1/Mq
         IDH+3mtjfTIceBSjBz4SUjI+QSmw5PsLGkmUmbzzQNZPkU+dx7NSYG9SeUMMpqvfnr1f
         MAl4gFiu52M8kHkYGniX7IuAnYLHOiUY1hdM14JASkEoXp3I4e+oYIQVShoIMLR3tfNm
         vOt3Vcrh9L4Oudm4q0V2f8jkcY4m0lFcwRzTISimblPwQcjyeujFkc3qJm3mcV/yEec1
         Vphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738852811; x=1739457611;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HaF9oK+ht+6PJAmQa8x2eJ5jIN8d/CbjvcAD/HIVPi4=;
        b=OiJgiFNne8c/3nGjowe68zcDH3ndGGICXU5KOYCnM8ucchkbg/OPBrKIschE/rSmjv
         VBJ79PSg7gnxbfWsgiMJIAgdqcT3hPTbo3KIuog9hpnVGi1y9ysriHOuosC3aPCphwCU
         cYwV9FjajKgXsaCutF3n6ylArpeRxBN8plGEWzaPZzHwkEjkAgt17r/+gOshSWbkUXs5
         9ObY/jqzjqz5aWBWZRpp91bqGgo+MZAKpEzQDVNJmzi/iq/yWwWALfmytYsFZlB5yXAM
         EUFsOC4y7mDTaotdRL3cMoXEgez2kSFherXufWORhaD+iJdrBLi1xsTDPDxgkkU42PWl
         lhSw==
X-Forwarded-Encrypted: i=1; AJvYcCVOJ0dCDKTklchWEkrL7Z7JiOD38Q66wVOOw10zGE4o6IU1fgDOi0GV6dTKxAzlH4CDqtCEOMY=@lists.linux.dev
X-Gm-Message-State: AOJu0YyDpiBycPjZNF74usQGHmcc71t3n56+OU9xVCHXOzcBnfHdgar/
	U68Xn+XkzNeegy1Pllz7mp4ylFgf+1tl8Nrnc28yoCpyn3Vk6l7JHF7l0dB7S88=
X-Gm-Gg: ASbGncsd81uE1nqKatTuWLck8WOpiTj7DkiZ7JuJ3dwMBgtIqqkT1y/U/avxlZFO1hD
	s+pgp5fVY6fyb5EJ3CRh0m5w3QBrJa4BGXhq1PfzbrLgxW8ZcSddm1dIJaRG2XlTtdLDF7kgMts
	h/Clt6lnBI1eiTVU65vet+s5LhGI4InI/L6N+iVfzmfjfIabkukhu2TaWHFnHn8zAq01syKs6kJ
	ObrtYLooDeTwG+AkuY+6D52ETQPqfgm4glJpFZEXkYCbQyBIcJfSfYAnkPpjSaZXX4hS2GRFcnn
	OERSTw7sr6dv0p8oqC9N6fzlS/oTRTCUkzPlS7JFdX7B/4Q=
X-Google-Smtp-Source: AGHT+IHgsuIEgT7GkKcahm86w7XZdDg7vZ/AvkvTuqQKdmdxISVptZgStfdEuYmSzkdA2CsT8SZ/Jw==
X-Received: by 2002:a17:907:7d90:b0:aaf:74d6:6467 with SMTP id a640c23a62f3a-ab75e347a2dmr784608966b.42.1738852811550;
        Thu, 06 Feb 2025 06:40:11 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7826ed43esm24954566b.58.2025.02.06.06.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 06:40:11 -0800 (PST)
Message-ID: <6cd38146-aec2-40ac-9372-13064dd99363@blackwall.org>
Date: Thu, 6 Feb 2025 16:40:09 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 09/14] netfilter: nft_flow_offload: Add
 NFPROTO_BRIDGE to validate
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
 <20250204194921.46692-10-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250204194921.46692-10-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 21:49, Eric Woudstra wrote:
> Need to add NFPROTO_BRIDGE to nft_flow_offload_validate() to support
> the bridge-fastpath.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  net/netfilter/nft_flow_offload.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

