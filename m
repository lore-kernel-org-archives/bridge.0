Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830AF21CFF7
	for <bridge@lists.linux.dev>; Thu,  6 Feb 2025 14:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738851798; cv=none; b=O3OtZJRqh++R4wuMTFasKPeH12VzbZ75Jm/6MdJP0avVLlvNDLiRupktuBKyPZW++mF7odhtPtK2Wpm+x7i5SiImI0LgDqU1rbZugcRGfXIf4vsozpnjqifepSe8eUwZNshPS5XTztVNebRRUvyuC1jjxY6tZUFKyoM7QzjfjzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738851798; c=relaxed/simple;
	bh=hYNDYZyhU3vPLzYPSaPWEcPzJSNHuY39jWh45uxHumU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D+xgsc9tbArYkFPrAVTrvV3JdTrllCvuOY07CGomceXcg7V9UdEOecXZDWrrSyGlQFIfCrSNFWZSI6LCJpwrXQz0ixKV36VrpXx4oJgYo4qlVfklUmM42gDk6T0h9cDSBYKVlw83K0uXyfqr2QojlJnKJhtYvtxC/3/PhTnKvL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=CFf/Jo/b; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="CFf/Jo/b"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab77db6334dso68048266b.0
        for <bridge@lists.linux.dev>; Thu, 06 Feb 2025 06:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1738851794; x=1739456594; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gFMFd8yvXqVnAGCGrRETRe/V8KRYdG7T8ArDcX9VBwI=;
        b=CFf/Jo/bBc/Mh5b+qoFe2RemsLX2N302rCg3UwGmrDzUgot9zCsGaBXeFnASW4n6Vm
         09jlBVuYQ6QqP3CiVdEYLgWnmuGRHkX2zkQKMwCqcymI0dLavOiKExtMdC9Gjf03JLu7
         tH/VojF45L+f3Jaxo0uxooeC8gwExRhvGW8i/9DHgHgPiQo+fTxRnTTZBpWx9zgM1lhN
         9rbugPhz6ovmyK7awwj9rNB3Y16vzaK4ZyyQ5V5TA7C2GrHF1PT2mHtf2m9mBsdeppvv
         Yvl5WeyXztyliVS5KuBXLURicXnfz9gRG38tZoETBvQxbczB9E8c9BrFLCCj2rcLDLml
         n3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738851794; x=1739456594;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gFMFd8yvXqVnAGCGrRETRe/V8KRYdG7T8ArDcX9VBwI=;
        b=uHQUu2FefUKWMLXUnOm2oP4U3YzQWzLzP9WkcbZdUgxOgHWTuvGKNFjUbTv6bXLV/3
         Dds8Wl5l2SARb1TliNITUSW8hYMSF27c+VVS+RfaSeN/aDkYSDWme+Sw53NB4oOLFxbx
         OSIZj8CdupPMZZ7bMv98svokqM5dZk3pQEA7Cv+s/Tg3Q13zQ2LuRA+e/YmNNtcvCk3W
         etFn6J+Sus8ZC7CV1baSLLrmY42AZCDChDxpJLm3a3hLmxrA/sVa1gj/MoJVsnk78Wt5
         oQIKaihK/+sNROY7qKQCT24QMGzRueS168rAN/HJTchJbQNU/apRlGWIBYvbXTOrRZAW
         kTsw==
X-Forwarded-Encrypted: i=1; AJvYcCVf7K8XMiGyp4D+RiNsBlEJun8UN6NX6auZZWcqwVQkHhmd3hDDBMHyeJmjWWeruDUT/dRK914=@lists.linux.dev
X-Gm-Message-State: AOJu0YyZnK5E3M1W7BjGaCvqnOESrHpnrLmoT2NkFDFgetq5/4caUHfa
	1FuHDsl8uD2um//IvO+k9i799Sy10UJ4RVw3+NvLipD/PHzxtS9AJBi00h3kobM=
X-Gm-Gg: ASbGncvGAYbf/RbCdyZ08wHv5GHLK+kj7igG39unQS9ZJrQ8KkFZBwfUtbpOrGWNK2Q
	HacG9d7LCC2rnFxsQq4DS9GIp5qV1jeHAFZgqGKFVdEL60cPdas0x/Yw2vBfccv6jxOPS7+4pCn
	1t/5O981ngz3z8kHKTdgAqg1oUv8wdz2oFvwESwYSKZUjL3S602UDEsIpPjBTMngQJT9NODmrD1
	ni62wntplm6HoY844zrf+l/g2kL1pGcC+99ScgmHVQy6phl9JRp9d6aqW8qV8OiQ1OehsWzWHrw
	BFD9dxiuZBR34VTk1CJpI6RCU6y6Ob4lJvxVtQr17kV9rOU=
X-Google-Smtp-Source: AGHT+IFFyvQfINAl6lz2A01y9ohntI7gR0hYfp3ILlqctgCUIUMFbzNkfcNhO1QK5iS0p6NSxCJe9w==
X-Received: by 2002:a17:907:8694:b0:ab7:b93:f77d with SMTP id a640c23a62f3a-ab75e245be1mr816768366b.3.1738851793676;
        Thu, 06 Feb 2025 06:23:13 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab772f486c7sm106211766b.23.2025.02.06.06.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 06:23:13 -0800 (PST)
Message-ID: <5de6707a-6a77-41d1-8964-19667a0e91b2@blackwall.org>
Date: Thu, 6 Feb 2025 16:23:11 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 06/14] net: core: dev: Add
 dev_fill_bridge_path()
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
 <20250204194921.46692-7-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250204194921.46692-7-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 21:49, Eric Woudstra wrote:
> New function dev_fill_bridge_path(), similar to dev_fill_forward_path().
> It handles starting from a bridge port instead of the bridge master.
> The structures ctx and nft_forward_info need to be already filled in with
> the (vlan) encaps.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  include/linux/netdevice.h |  2 ++
>  net/core/dev.c            | 66 +++++++++++++++++++++++++++++++--------
>  2 files changed, 55 insertions(+), 13 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
