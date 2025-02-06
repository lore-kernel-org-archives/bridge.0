Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAFE23642E
	for <bridge@lists.linux.dev>; Thu,  6 Feb 2025 14:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852704; cv=none; b=WRa/GVqfboYo/tkMI273GpNyXb8H3Kw2oRfpMHBdwMtRls6b3kX+yKqct/C0t3VfSLys9HzLGpj5qLcuf0WmtDgk4UCvwmWM8jT60b8UKCGcmkISG3XNTU5lScCU+Y1fTz2ijlzi+LlGQb6bCFyze8orP+G6VRxJuO6utqV8QuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852704; c=relaxed/simple;
	bh=wQw2TdeuTizcqF3Q9lrwzFprE3cAuiPJ1x44hiY1wKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PbTJM/GQyZmfm/g9JkaptuMSG6zI+vtyUPI3Bkyrv+yaR89R5jU0XWbWObhCOw9+BY5l+ujjOzoaS/SfgeYlB+I26+dWXEwq81NeOwno/4sakGZKJCZTmemgfjySCwJGzUN15AS0wLqUSyW0SmLVDOaWOXMPxF7sNMWoOcxPDNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=tXrYIg/A; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="tXrYIg/A"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab7814aa2adso34263666b.0
        for <bridge@lists.linux.dev>; Thu, 06 Feb 2025 06:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1738852700; x=1739457500; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PGl8f7Yf7qIHwGS9qrFDj3Wy7/eEHYp4eEWPnG5nI64=;
        b=tXrYIg/Actq2buE9rOW+cB6V0RmMmudExLReno5OfdBhqhPpXkZtNnQRRoOSVWpKBi
         AWQB3A8pgx4RPjKz35TNN4i2yPHPSiHPNJRbgioQFX5LoP1dsCw2SpFxx+in8+q/DMlU
         3MMcedm7xCoei89VD+kZ7yUvEoJZqauDuDMsgK7TeBBhgDh/R3lfadOSCLVa57bhVbvd
         jup4R4+OebRvE755oDlQiWQQiJSUzJIS55LuY5YMjiEe7ifzZWnP/FogPL2/7rUJ63Ac
         wliaTlH7k7AwMyDsr5wTG0BdcvTt34/EcvDOnIRnK8F8ic9KD/ORKzdBiVlTlsRe/1D8
         lAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738852700; x=1739457500;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PGl8f7Yf7qIHwGS9qrFDj3Wy7/eEHYp4eEWPnG5nI64=;
        b=t0Sqb6fr4/88x7JGX5NXbMpbYhWjFsVOAhka5iAJAt29+2X5oU0sOKl4kWgkViiiaq
         tyelgcRAgEio0rK9JNpsr6h3x5//xx019OmPZ+wG6c1Xz4XKc+SIIiFBwIXdL2s63E3l
         7i9m+rpz8Z9lVW8kqJTXJzqnKlJVanR3taI9uCp4oQTboZRgkhJ6+4977w9ztT5+llCU
         OWpp5i2/SHkk7WsM8F9nP+0hr8oR4xpYxN48ENNoiXDm0hItrroHS371oiePVPgMtYc+
         OtgMtOjI7a6MDAS2fBCP1r7vQE95r/CuoJ+wmYZcObQ+OLkv1fnsaDNrTmjXL1Wv672g
         emwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJBMpPFfflTkjyg+6Mag25gCCHC0vfT3iBfABSvYfSoHOuo1ACoJzO/ApNFfhJIjakvGuwt84=@lists.linux.dev
X-Gm-Message-State: AOJu0YxvztNU6lutBnUfyAe6Hxr6sCabZUf/i6rljBy3cFk+9ZjSfdaG
	fRoywDTI7MJWFp/q3e+7pTCfo6H7aBRjVR6eoYOvmhhnBeNC/uvn9I5TLbFHh0Q=
X-Gm-Gg: ASbGncv2kvks7tsq2IpgnYG0qu2pIxQwRbL2cgF8pYjnys/7zkOSbp3D2hKsbUTKuwE
	dnSVeQTMD88bqZ+fmQpKW8SrYicdNzUnjJiMKwbB92aVe1I6EQ+cQbOQCcUSEcvlNmfOjz7ycPS
	+nkvKDI4tNa7jUHoTKqLYDnaASE96+1RzAAozK02EFhNTrj2PCB9LemqoZp7fsjpYD9/w/FiHMp
	26TZpS10BOZHNhO/qsYD+HcCwaGf0z8f4TJcnXtCi1/c9TDKXj6ahGtMfra1ekyHM65eWPJp/fc
	oL7Mn+Q6Tdevtgb9TVrR8Yur8yNN5MZlDXV/AK9I9+7zAiI=
X-Google-Smtp-Source: AGHT+IHtlKzpr7zCul0guNkxORZKS7E5zmeQUNtvu4QsPr2PA2enKb+nYgF0UWob2xBe5euOje74bg==
X-Received: by 2002:a05:6402:35c8:b0:5dc:89e0:8ea5 with SMTP id 4fb4d7f45d1cf-5dcdb6f9f8cmr18518934a12.3.1738852700066;
        Thu, 06 Feb 2025 06:38:20 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7732e7120sm108661666b.91.2025.02.06.06.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 06:38:19 -0800 (PST)
Message-ID: <568586b4-aeb4-43b8-b645-a2a0517e3fc7@blackwall.org>
Date: Thu, 6 Feb 2025 16:38:17 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 01/14] netfilter: nf_flow_table_offload: Add
 nf_flow_encap_push() for xmit direct
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
 <20250204194921.46692-2-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250204194921.46692-2-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 21:49, Eric Woudstra wrote:
> Loosely based on wenxu's patches:
> 
> "nf_flow_table_offload: offload the vlan/PPPoE encap in the flowtable".
> 
> Fixed double vlan and pppoe packets, almost entirely rewriting the patch.
> 
> After this patch, it is possible to transmit packets in the fastpath with
> outgoing encaps, without using vlan- and/or pppoe-devices.
> 
> This makes it possible to use more different kinds of network setups.
> For example, when bridge tagging is used to egress vlan tagged
> packets using the forward fastpath. Another example is passing 802.1q
> tagged packets through a bridge using the bridge fastpath.
> 
> This also makes the software fastpath process more similar to the
> hardware offloaded fastpath process, where encaps are also pushed.
> 
> After applying this patch, always info->outdev = info->hw_outdev,
> so the netfilter code can be further cleaned up by removing:
>  * hw_outdev from struct nft_forward_info
>  * out.hw_ifindex from struct nf_flow_route
>  * out.hw_ifidx from struct flow_offload_tuple
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  net/netfilter/nf_flow_table_ip.c | 96 +++++++++++++++++++++++++++++++-
>  net/netfilter/nft_flow_offload.c |  6 +-
>  2 files changed, 96 insertions(+), 6 deletions(-)
> 

Too bad the existing vlan push helpers can't be used. :)
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

