Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BEA1F5845
	for <bridge@lists.linux.dev>; Wed,  5 Mar 2025 08:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741162899; cv=none; b=cwHNE884VR0m0gPjWuTVyHwOvB+gO+TS6aJOer3z3ApaPga7lpRd2PjiAzmdHZPziZszRi6mMB7FKU3tv/OSEurMQO4Xo7Pg2mq4HC2oTlT9KktT+YSIgRy5XeKiPQw64YKLIr672QO08RO+0CvlzHx2aouatqf3FODj02HrhFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741162899; c=relaxed/simple;
	bh=Dd3fU7x3Zyy9J91IPT2gBtr3RmiUZhQvAeaOmlAbIPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BC5aSKoJy8cKh2xdLgWb+z5yTK65w3txHlOakHfo4as8kNPLZWbRUHd4TUJYYE0onreBNKRhCQiF3f9BVTHa80oi2QOpLQeVwpFyqkrzuCqhTnkjeA77Vmh46WjYafFmGQgKKfOiHY3ddBeoLBs1/RPqjACb96dafpr7mEE9JfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=gb0rTmLv; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="gb0rTmLv"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac0b6e8d96cso431720666b.0
        for <bridge@lists.linux.dev>; Wed, 05 Mar 2025 00:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1741162896; x=1741767696; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nsv6iruxF/55s5GG7wPPBagKb4juSNlpcghKgAFq1qg=;
        b=gb0rTmLvIj46mP40/QCnmAi6VMEne8M/haeFSXipUEh1JWyg6zwjxw/mWkaWMVHj6y
         eJ2Pur8RJA9a2UR0KRTPPtUXB3uBcnJC2/M7rrRTsTHQoVA2h5CtOiKSdCyUt3KYS5Hm
         PobmYh3SXA3tCfcbG8xjKfQvyHRlL5TYg0TJmGVo+rHDt9DVGFQIyP1kQeNGMepicjB6
         DDPyefkUfs856M1D+3G02MuYH+gjboePnw9ZCX09APhhoLqoifLXKRQymbhm09FPcIlC
         KdKnjkgNypVm99onAREEnFcbd9A2wGmmYBvdvgEyFE/9dUPSAXlH04a8gF3sTL2LG9fF
         CSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741162896; x=1741767696;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nsv6iruxF/55s5GG7wPPBagKb4juSNlpcghKgAFq1qg=;
        b=ue+fBz20e2LXmKZ918/tCNkFAE7gkM1zpcUzHVQb1G8rDq7HKIKbu7FVCOkKWTrj9a
         0ceHWUOYpEHIbLNP3Mo4sUHWdU3FTKGaK4ZqHsscJlCheznoDsplgU8iUQLCgKe4/q47
         iV2bp7qmnPKMOT2zCxv0OWLbkYvekAVPm6cDUrq/eU8dYEh3LHlmshN5Q9LwPcls3kYL
         8dCeO/cfyfMn3d5+Z/t7tHzGHt3IaD+ofYhHAxD3DIawLBlhI2jgSEWg4Ms0jXWKdONy
         iJnmfdvyGupAODfIY/ZI1os79DeGAvjqEi7QEq7v2+Zvz2HeHza3Z4C/kynlhnB3ZOjf
         fy5A==
X-Forwarded-Encrypted: i=1; AJvYcCXOyiAFn2/WHQ90dAsDOjfTVdOj1QkUJz3c1Ov8sM9IWuNtpsbgmykfbRVbWJMcRbqjWPhB+S8=@lists.linux.dev
X-Gm-Message-State: AOJu0YzIq/bhiUGTCAr4i3uA7NdJj76VqkMhmmWZNx/WiGSE+g/53xwp
	g7+JMBjOI7YXP3ZCQ3ph/cftdhW+vQfl7pre2s2/UdD4SG0HiUrPGa2DKv1D8xc=
X-Gm-Gg: ASbGnctVyrbRCalUZBVmIf9E7jaYyF0PvfKOh9D9R8akkbb/EAZ9tg2snzCTRyRUY7M
	57bt1SjWKQlzpVW46u1DXZMbjD6MR+nc30mCVFpZwESJh7RUHUso4kT94B1SzmF2Giu1WeTQJ9p
	NYA933nk6+BVO9eaX50BuZmqxrTNzKGRfAc8ceje1TpT7BAnqOJ5frAKmCd+EOOP703pf8h+Ag4
	EjvgaYmJpDc6rVeToNQeDlrNXxcCjlbfeTuEikmZQS2RnOy680nYIMwyiR0loIlJEVA/ewtG0VE
	CK/4OqkGIBh2UVKcCDy5AbgubRwLEBbBFStzonTvFXUZD8k1tjJV49AoUBHj+bpo55vA8NL8y+g
	j
X-Google-Smtp-Source: AGHT+IGaoXnq3lSxzaaUwAuVfK+jenlYaXFrv+TPSgSHSnmbmoUQLeCI462sahYSphebEzq/qYnUHQ==
X-Received: by 2002:a17:907:7f0b:b0:ac1:fb60:2269 with SMTP id a640c23a62f3a-ac20d925048mr217259766b.27.1741162895402;
        Wed, 05 Mar 2025 00:21:35 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf58804b49sm693744066b.26.2025.03.05.00.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 00:21:34 -0800 (PST)
Message-ID: <b3b5418c-65d5-48bf-8868-2d9abcb4f758@blackwall.org>
Date: Wed, 5 Mar 2025 10:21:33 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 01/15] net: pppoe: avoid zero-length arrays in
 struct pppoe_hdr
To: Eric Woudstra <ericwouds@gmail.com>,
 Michal Ostrowski <mostrows@earthlink.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Jiri Pirko <jiri@resnulli.us>,
 Ivan Vecera <ivecera@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Ahmed Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Vladimir Oltean <olteanv@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 bridge@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20250228201533.23836-1-ericwouds@gmail.com>
 <20250228201533.23836-2-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250228201533.23836-2-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/28/25 22:15, Eric Woudstra wrote:
> Jakub Kicinski suggested following patch:
> 
> W=1 C=1 GCC build gives us:
> 
> net/bridge/netfilter/nf_conntrack_bridge.c: note: in included file (through
> ../include/linux/if_pppox.h, ../include/uapi/linux/netfilter_bridge.h,
> ../include/linux/netfilter_bridge.h): include/uapi/linux/if_pppox.h:
> 153:29: warning: array of flexible structures
> 
> It doesn't like that hdr has a zero-length array which overlaps proto.
> The kernel code doesn't currently need those arrays.
> 
> PPPoE connection is functional after applying this patch.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  drivers/net/ppp/pppoe.c       | 2 +-
>  include/uapi/linux/if_pppox.h | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

