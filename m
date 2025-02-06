Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55A0236443
	for <bridge@lists.linux.dev>; Thu,  6 Feb 2025 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852785; cv=none; b=BLCjGgK9mWEzY9Fud/6IQqXUvo6ARm86tkfvpRZzGGAU9YAMC1O4vONifwR4VBRjGfxIFkAQrSRmkdpMwf5rBlDQaG9ZItMv+GxXqcRlt3KwU4YLuO6AK78vhrUhy2mbzx8r+wYTuEHKaJN0IEGcMbKLWzIB/XCgv5ApWLecdrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852785; c=relaxed/simple;
	bh=czZSa8RE8rPjUA6bt67Tw98QD1nGxDQA7k8TsCfdCzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MtIs+FXpaVfzesCcLSALMua7Q6zCKcoQ3ejIdb2WhvkZnmClWboF8/EruLC+woNKDY0u3YRWXpKGWEKJ6Fz4RblnB5NtHV6OQ0RYIFTlW+HeIgOxi2TOeArcNca/aIpSUYjnBbKb6cjt0aXuHdtvW9ey/QSsPEr40uLpDNN2pDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=mHX7Xl3O; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="mHX7Xl3O"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab744d5e567so182864866b.1
        for <bridge@lists.linux.dev>; Thu, 06 Feb 2025 06:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1738852782; x=1739457582; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qwM9ak9hrD3h4qVx1yCYkLliO4mOGlB4YCv6ISmSjO4=;
        b=mHX7Xl3Op/uDMztBoSOt3KXmxYsv/tEQfIzjkA8InDcNhBvpjyeDrFY474/2Q8G/Gl
         A5qt/gqugpesxQddU5r9aKvDQI7L1S3r8Gnl6q+x6dvau6tlFzPZqr0tguZsk9WU3G9Y
         m+tnIfzomGoN5xAl0ptUrgKb1nRj4HGzT4w2S7ZA+wzZjCdfx3S+WwgqDXl2tkdwUFXP
         kA3NddEfQTAbShAZlaUgoNIJDH5RMYNGktQk2Qe6uPoDi9B/d3foidhoHFsttMSTw1YD
         OjJjm+Gn+upmg1JmNZYWmYnOMwb2U1b8cAskev8Q6EZ7XbbmWYQgvwW3wcfRap6pP6qM
         rSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738852782; x=1739457582;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qwM9ak9hrD3h4qVx1yCYkLliO4mOGlB4YCv6ISmSjO4=;
        b=ZTWYV/DwuA6ydnOV1TQxtl+KBehxokySEYT8TOvkoBncHmUaMpnzvHWkv+oSVDYBjI
         nkX3kLmPd+eV8KFNsQ1eSfcWPbuj2KQHWwi0x8tznXQR/m5YQ56R8dlZNlhQXBligPAn
         zPuI1tbJ5ZRX9F2xzt/ckAJGjOGK1D1muUn1JQXxWNvgr6YOlyc4DNdaModQWitTyKyX
         +f2ysSJVZYpg0Mrsd8c9W8/ksuVtV9H6XAGPhBzjn2mpAmvQ8dERPU58h204f6Wew6aW
         dIuCXOQTZR099xns0XEY84gVscN2b+nRAH2tT8Nct4o0D+riZxA9AxKOp8fJ7FB0DDem
         c0+g==
X-Forwarded-Encrypted: i=1; AJvYcCUTNiK+y88LIV856tEwaU4jcM2rylQ3if2Efw22rs59kRov9NxDZXBV/b5PKapONA003Xqx05g=@lists.linux.dev
X-Gm-Message-State: AOJu0YxcikLhkTeUHFINuYYN5au0F6/9ZBNHyYX8FMUulBCVfL7GvckP
	Upg96ovOJX5X+AsdyYHwNQu4y6j0KLTmzsA+Y8jzjK6kiobBVE4cGOwjw4gyYqo=
X-Gm-Gg: ASbGncvSmqm3PehPuQxtI2AZ1Dk1Qrj2zY1Z7fvaBqTv+JLP4wBYXRNTDRprBdie3p7
	xO85erZY6BoDwxY7xFAv1TibqEpsKzF+gXu+GDgv1916S3piaUJWTOBAR01HM4ubKlQ5rToo7lo
	eJ8Ctu9g82dV8ZN8OoSw1Y+kfJWz1oA2WuDgaYuzgJ636knvIEeGmgdtXVxbUVKMK67+yZnEPJu
	ZpBWSeP7gVr/7nynf1A0H4Dx0+mNPYYTmT7wXgHCcR7noqZcM8AHywwEHcd2KrVBNPTj365OuEp
	Fw0xcLWuixd9bn1TCs2LSzjrFdCTJJg5Acgz1Q70T7gZT44=
X-Google-Smtp-Source: AGHT+IGWp5+1BVne358ySyNOgZ1qVjbCgfUJUnYbiNP8cDVB4maBnu+CTyhvHYo+RSuyGyXRNdH4eA==
X-Received: by 2002:a17:907:9611:b0:ab3:61e2:8aaf with SMTP id a640c23a62f3a-ab76e9dbe8amr395071966b.25.1738852782052;
        Thu, 06 Feb 2025 06:39:42 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7732e70e7sm108777266b.87.2025.02.06.06.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 06:39:41 -0800 (PST)
Message-ID: <46b7042c-8284-4523-b54f-38f97e70075a@blackwall.org>
Date: Thu, 6 Feb 2025 16:39:39 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 08/14] netfilter: nf_flow_table_inet: Add
 nf_flowtable_type flowtable_bridge
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
 <20250204194921.46692-9-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250204194921.46692-9-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 21:49, Eric Woudstra wrote:
> This will allow a flowtable to be added to the nft bridge family.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  net/netfilter/nf_flow_table_inet.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

