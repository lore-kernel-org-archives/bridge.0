Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394781DD526
	for <bridge@lists.linux.dev>; Sat,  1 Mar 2025 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740844060; cv=none; b=MApvnktU1ddzvrJeYfKDht4qKp2kuvF1BGqSnkfa7X4JAGEzacrg8HMLUYf5n/OEXrIxKlzx/mHP+Sz7eh9v4cXvwFE15aO6c7g/hl/XsWz71Jk4GlTLz6dpTcD5VpTPSnmIvh3ZrLGs1nFmPic64TErFZknwV767K8ldjwu3r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740844060; c=relaxed/simple;
	bh=qaYwzM0tPLZWBNtMZwEjySSIGmwDhWL+JeN07b9+R70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c1lkKMLyUCSBYmSKXItlTf0wwA+xdHmvK11XrUo9vuMGguPF2SW376l3alieSJCJVSUyPxwdl/NsMfrv/ndGlTephXITWQmnL7Nhtz73KfNJoD4Onwb/i61rQlu6Xilbpp5Lv5lVNnJ1WzSS31/brc8MxXqqUftOGghoBQNNN1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bb4DLi5n; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bb4DLi5n"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaecf50578eso584281266b.2
        for <bridge@lists.linux.dev>; Sat, 01 Mar 2025 07:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740844057; x=1741448857; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pvcp/Ow9PKUt0GAoY+iQqvy3UdZ1k/popr5tmmzvjdw=;
        b=bb4DLi5nPrk4++SbfXPYWLk4xJ+byD+MHTdZY7wIFrJZqjRKEUQlqv4CtxSVXVBcq/
         u2pRZxQDFRaoayechJGGn85MP/QSQaWb8E0gw2xOD0a961nD849/P4IU2k2qLb7b8V5B
         VKXA+MDSmz6mYeAz81Q/hUzneFPs0zX79Bcno+usn1T63g3roO1aMS79CUydHeOSrueT
         085Q5SonzUv/TuKHfzlBCy3PXw9UM61TLql5NaxuSV/l7HQcWk4iu4bfWXy0OhatZYQV
         RzxsZ2W7uqUwjApk0RgNfwc5mRN8/xvZGRzleVcbUaoiyPi5EhZf8Yklc+qqs0gtuUtq
         rnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740844057; x=1741448857;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pvcp/Ow9PKUt0GAoY+iQqvy3UdZ1k/popr5tmmzvjdw=;
        b=Yn9QaUY9zvgfJbODxDjOjZw9bB071rRSIxNE8BaHNHAU8h0182zryLGJjGnL0/EglZ
         xZOn61Q4YxEOI6Qse0wORzrRh64kImsjA8GVdTwD7X1MAzxegob6m9swVHwAHHO6+JEW
         3FtveeY/oNJoAmgrEAA3Ke1o3KgR5HmUrS5wFwx17WV/uzuP79qni8iEzqHg6qXIZ3Ci
         3ITGGODU1H5MGPhCeqwJpDrjwUg0Bo0/Fq8X36M19WhRRB6YauXRHudE8hUH5iu1nq9/
         OOOlL/7i2eVYGAbB8IlP2NPlaEbxLoxHBsh5+TR8Yc6vvGQoczJOBGxYOEAPE1a8iMBA
         ehlA==
X-Forwarded-Encrypted: i=1; AJvYcCUo1X+BnBQqziJiPWLWN2iKXPdmGy8w4P4ikdv8Ew+zvBcXAuU8apc24SAkUvk66javhFT9/ws=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7jIxG0ZWW87k4bLmlLNwUIm4reXTYme8ltGNudWkFahITxYVs
	9rz2UldwtM8acfd7FeMf2jomxuFHwps68ZoY2l/e42zoctdBwbKh
X-Gm-Gg: ASbGnct/32FGiL4KucCtnyNHKcKDYzBjNxXwK5gkN5S6rqRRa3LAz9mR3R4so9d1yZY
	jg4f6YGjFhDBUpzBoAEEYtiHJTKDZ45Spbg7sXtzjcAbyJtGx/I45b9HV7ziZPuq0uMGoF2/P6u
	3i4i5WW9A47SEwyGRZVPZM2eFWKaU9uVdXjartceBliY9bib1apjxOganTq3VqAL0bo+jMSUinz
	s00UjwY12ee6O1NPU6BwV20yYFxpHi1ugZ0J4vgkGtSVoZftQjbwXrGAu8TfqVPYtLWpEgToI3t
	HNfVe8qlwfaeklBU7RWnQECGbpXT7ryllAXuOaaQlvd8uazCptVKgDGYO/KvZyidt84UPwlFbjS
	uVDUU0TPvi2f1UEXDZru1QV3urnnj9/cWVQ987fm3MlH+QoQqxWkt6kqyL/rb83RtfxHdm68qRB
	F+gAXHw9bjwIvk/A/E6mw=
X-Google-Smtp-Source: AGHT+IG+eqrFeyO3A7KDD2S5BrzG0fkxCUE3rRFtAlmdPlWrBAor9q1vffWfk9dSAf3TW6qzlDGFvA==
X-Received: by 2002:a17:907:2d8c:b0:abf:4c5f:7546 with SMTP id a640c23a62f3a-abf4c5f7590mr317216866b.38.1740844057241;
        Sat, 01 Mar 2025 07:47:37 -0800 (PST)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b6d252sm4287355a12.26.2025.03.01.07.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Mar 2025 07:47:36 -0800 (PST)
Message-ID: <fc5129dd-35a8-4bcc-8e54-b8facda2cbc4@gmail.com>
Date: Sat, 1 Mar 2025 16:47:32 +0100
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 01/15] net: pppoe: avoid zero-length arrays in
 struct pppoe_hdr
To: Michal Ostrowski <mostrows@earthlink.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Jiri Pirko <jiri@resnulli.us>,
 Ivan Vecera <ivecera@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
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
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <20250228201533.23836-2-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/28/25 9:15 PM, Eric Woudstra wrote:
>  drivers/net/ppp/pppoe.c       | 2 +-
>  include/uapi/linux/if_pppox.h | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)

The maintainers email: Michal Ostrowski <mostrows@earthlink.net>
Returns 403: 550 5.5.1 Recipient rejected. This mailbox does not exist here.
