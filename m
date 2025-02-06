Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C687A23644E
	for <bridge@lists.linux.dev>; Thu,  6 Feb 2025 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852912; cv=none; b=dUHilCgPa+7c3xqDW0NRXeuDMWKetBVlEq5LjMTxS1hsovyu78xogGgAAL9wWIz6zyQpjNQ0bu6Pwc5sJuwAE9deJvP814sifoEGqPEJ9yZqj4h496Gmmk1kf/9IXYYbx7iqZmKidZqUCqcwpBUCP0VLUjnEUO+fz3zeWjzZvvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852912; c=relaxed/simple;
	bh=S9K6uTA8VvFJVDz2rVYNypE/HkViC5gyXPCZe+4fWCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHX50zoYCYnhv6eCgy2cIGVJockzUJwLYnIMNs0CGo7w0ZrXMJEFE6eCUBjgXm0/jshUBmjBJLa6ZTBRY0qttDvxQDqaTeNqnn0xQWpO9CPRLEmpaUl0t6bdmD8hQXUV/njQ4t5xuTWXdBe37pfG05/ddLi9aGS332Bdd8ACH3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=q5ikqvOM; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="q5ikqvOM"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaec111762bso245463366b.2
        for <bridge@lists.linux.dev>; Thu, 06 Feb 2025 06:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1738852909; x=1739457709; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8rlKArYVbbfkMOQLEil2R2SAvQ0afSCP1rUmme1+B8A=;
        b=q5ikqvOMinS01cDGJzNBRazH8TNIcQZmHNDGFUjh4qMfBUFA76ZgZO+DOiKLUmnm+r
         IAfY+BFDRKOhO7h1N0Ng5R0IeJl8rjHotCtQXo1PuvpAddaQB0XGmxca535klpPkdHqE
         CpaR5k6dmp0lRvO0/Dki95nBG8fVG9tmIv4deUpJOccgfcKgbBANgeeh5FM4cUHMfNAK
         Yt1zotUyw0MOmT1y39YM3JXJzyECBB7eu8671+5H9fJtL2gvpQAS+w6ee/hOFZLV9cJo
         LfA6L9KHm8+EUfJ+RxsV+QrWJ+Zr3BT7u27BcDdy760q9IGSIWuGcsQYKjw9v3T2CxTP
         ZWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738852909; x=1739457709;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8rlKArYVbbfkMOQLEil2R2SAvQ0afSCP1rUmme1+B8A=;
        b=RCGPSppXFSut4CqZpBcXjpP4yjZAo3LyUPhGif5p0ejNMOLl5YcMymm5f3UhdBloVv
         EnyAf3cjxqydwrukP/mM6rMw7G+tXfvvnefRWTXuejVBoGjWYropdmldQV5jK1lssI00
         CgboCI38m6av9zqdThNKq5U3iVhfumzXNAdeTARlMD2KHSdzea7mtvGQTNDWZYQL0P5z
         ED18RFSyvFbreFJNe8pPLETT8o0HJAnbSEw9ZIW39UKwIGCNcY4MJKISpbBOEsDbT9q+
         L+4fPW5cGJ14B8BQYOnUdZJ6Zb4cV0JTa0iwmXj2gqb3v7eJYnSPIAcWDVw1q7jVJtE2
         ujHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZwUISSSebAis1O5ZwbNdaj6BBoaYm0thIniBAO3xQVHThndiiIPxOYBiRIRd3m4ppVcPEvME=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyp2c/XmFIaVeAbOlASSrGeWyszO1l/Fj2AS6QeJuEIDr2JNwOl
	Nn88T8VoEBgxvl35FeqBg+j2yw3zfu19kQy2GCfA7XQ1lxqk5EO4nFiHBvjWFDI=
X-Gm-Gg: ASbGncsOf/M5CcnEi/WrT0PTj8TqWgQ8hc9kR8bCmDUJa77G7MAmvv5/6i3lpqZiRxO
	Hk1tPMZjAPPU9t4pqDyBTEvjP5grjDjp6jga4Um0cc6vJVlXTR0AM9n8fws299kb5pvIoHdJLS1
	euNpZfM3uE1powcxWKmEEPCvn1QTCdoPQYWCI8KoP2SDu49EBINEr+sGl9qhQP19js/MLDYNWMC
	u64hdbiiIfomVMtG68cWKl/mc4M1SyFdnzH/Hevn4rVGv0OU0Rkk5DkuFC6eH6rsAjVsI7V91zs
	j/2Z0Jpu5jvqaimh9RvtU0XJrgAZS1auGoPLMTZS5R/ufCM=
X-Google-Smtp-Source: AGHT+IGYS6d4HsD5MEqTfuQgUgTGOYMkujVYUnjTnyeKJRhPZPj1m191dnJjgGKyqlpsKlnGfxYIDA==
X-Received: by 2002:a17:907:c23:b0:aa6:a7ef:7f1f with SMTP id a640c23a62f3a-ab75e233e41mr751067866b.11.1738852909025;
        Thu, 06 Feb 2025 06:41:49 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab772f484acsm109660266b.11.2025.02.06.06.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 06:41:48 -0800 (PST)
Message-ID: <ffcafced-51a2-4a09-ba45-1aafc8f39081@blackwall.org>
Date: Thu, 6 Feb 2025 16:41:46 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 11/14] netfilter: nft_flow_offload: No
 ingress_vlan forward info for dsa user port
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
 <20250204194921.46692-12-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250204194921.46692-12-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 21:49, Eric Woudstra wrote:
> The bitfield info->ingress_vlans and correcponding vlan encap are used for
> a switchdev user port. However, they should not be set for a dsa user port.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  net/netfilter/nft_flow_offload.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


