Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02498331EC3
	for <bridge@lists.linux.dev>; Sun, 26 Jul 2026 09:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785058804; cv=none; b=e0/gZs+n0eGJ6PznAeYW+lTVmuj8i+ptBFyuUYyUifw8tcVoszhgBnDDqgQ9qMpMJkU8AA1cPAPZmAHoCMKcFX8IAOOGsdYuy6E8n+Qe1klhW+bUYsvHyU1sl//bU5Mas5naPvj56GRVaJoIvVuQy2NLAl/jh7FpIyFHuko+tpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785058804; c=relaxed/simple;
	bh=3OwFQ5mBOcOXXMKcgunF0FyB50swdeCOl1+H3ELbnJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3dEpo9RBqi3F3K6Ymhf3VgUmUeoh9RHcxrN9c5G8NeXgCZ5P8z0wQMFFYDCPJV+hjkEKvOQFWiDAPkouWMd3dvhylv6RGYTFmaxhbgqki9ath5K7ELEzPGv4Uf9+mbwWMW5X6FCl23gnRm+i3wtBPejqTT+EiWxlSOzu1i/xWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=IwJadmtn; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="IwJadmtn"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4954d383e64so11337905e9.1
        for <bridge@lists.linux.dev>; Sun, 26 Jul 2026 02:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1785058801; x=1785663601; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W9EbBcFAYSv/DDp1rQAfTtxvwF2ptTiblYa9/W6HiBI=;
        b=IwJadmtnaNhU0PF110AvHdl/IrUjce3WZgRe1Hi6+O/cFEXkczLrRdf99xmZp6AN2z
         Na2AvQLWsfAhh5MGyRvdp2/41x7b85l/ct522iz1j9h07SzM+ngGw2HucmddV8J9rvLQ
         rLrco3PgThz4USqwQmkBhDsryrm0lFZmDh+uckD42LCSXqLzeKP9p3UyLIetQ+n1pY4t
         FGXl5R2T+0JGaR6gXtTxIH+tUeOqX0dKlb8JphAEHJbRi7CRX3sKAXThBgMY6CJKV8LG
         Uv+zj7CWGmGiKfQi3af5A3Mfh6/HNZaUwvsGHalmD3/V2cbiF03tnb2HTxhO3+WqC2X1
         h1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785058801; x=1785663601;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W9EbBcFAYSv/DDp1rQAfTtxvwF2ptTiblYa9/W6HiBI=;
        b=G74tVQnIQoEL7ycHcZ29eRp4MflrEUz0PBX73fCKJZwJ7yoiE9315yw+loL1eXfjBS
         BMcurGxFmnRGoIMYuI+N9llCH+63FiOMWPp0k7VDXnrQJIHKNk2S44eh6iTK7lAccmbX
         W/R+54Z7WMFI12stPQeDq41VV5cLWFCuPOOkS++JU0qkoT/pQWrsLyty9v7BzY4Sq2bN
         QM3eww0iszYtRk6FHfDnfDzQ1S+235+D2uKZCx2TU8w/J9OFT+pMFvKkKqLfruW43E56
         zudONHeISJGyLiA5bSWioWmu8kf2emTOdnLZCn+V5+8VUwuP2WSkY7gexX1n4vpTBuKe
         CRgA==
X-Forwarded-Encrypted: i=1; AHgh+RqyqQlkPI5wTKVHlXWOnZkgx1XHgKD3eGlkz9BDegXXUTsxFz3yVQ7GmMX8HNWAidv+Z3zYiLQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YwVYU3ifCfDPaN6byPgDWXUBrPPQ7FxVsfZp7NK64kzTJhpT7z2
	oh+j72lbujYz+ZwQucoe94T0kPtMKUqNW6J3prVO+g1g8BkD7NRbZVw7Ta0CzrK/gRE=
X-Gm-Gg: AR+sD13ryFGR2SyD1eGetby0IDfKTJSR06oLCvc6tfvCWy4nwTXCeBwImpXgZRrPqq3
	8/VG8gRXAF1xkvQIZq9t3OSAcNOEZZ26nRscVBNCF0eMnPWtBd/QgV9SzJB5/s7q52gXXvkiJeS
	QKzte7ogW9O/bvLoSALwjNQljvFc4s1WuRciXI9Wdc0+4YYtKH7pLgUiE/FL4bZSzkfk0teIymN
	rmW4xjFM6As3uidb3wpFHit0PyTi0KkAfB4zd0Jrh59sDsT/z7oLI5Qb5esPXzLBwRv5ErUpLA3
	+0KrWXD7wW0hDOxg5nryqKkg8t7SFaX1e/wKWDxtwoDbmOsHQiSuW1fWERmGP8IIsEOQTUq59VV
	S4PRJpnPP9LWWExcJLlj34SFBiWbz+5iXFhRhWRZ7zrn7SYguWF2ZscDvjMqTTGHcfeyn6k3Tqw
	==
X-Received: by 2002:a05:600c:1d0d:b0:493:f0f5:f2d7 with SMTP id 5b1f17b1804b1-496b56b1b23mr60004835e9.7.1785058801109;
        Sun, 26 Jul 2026 02:40:01 -0700 (PDT)
Received: from localhost ([109.160.73.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957bffc501sm137035665e9.4.2026.07.26.02.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 02:39:59 -0700 (PDT)
Date: Sun, 26 Jul 2026 12:39:58 +0300
From: Nikolay Aleksandrov <razor@blackwall.org>
To: David Corvaglia <david@corvaglia.dev>
Cc: Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, bridge@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: bridge: mrp: fix Option TLV length in
 MRP_Test frames
Message-ID: <amXV7nnXDWaaH68a@penguin>
References: <20260726062605.2746-1-david@corvaglia.dev>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260726062605.2746-1-david@corvaglia.dev>

On Sun, Jul 26, 2026 at 06:26:05AM +0000, David Corvaglia wrote:
> oui is a pointer, so sizeof(oui) is the pointer size. The MRA
> Option TLV thus advertises a wrong length (15 vs 10 on x86_64),
> causing misparsing of the frame on peers. Fix is to replace
> with sizeof(*oui).
> 
> Fixes: f7458934b079 ("net: bridge: mrp: Update the Test frames for MRA")
> Signed-off-by: David Corvaglia <david@corvaglia.dev>
> ---
> v2: target net and add Fixes header
> v1: https://lore.kernel.org/bridge/20260724051202.61946-1-david@corvaglia.dev/
> ---
>  net/bridge/br_mrp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
> index 3f7126a7d720..179d2470b724 100644
> --- a/net/bridge/br_mrp.c
> +++ b/net/bridge/br_mrp.c
> @@ -215,7 +215,7 @@ static struct sk_buff *br_mrp_alloc_test_skb(struct br_mrp *mrp,
>  		struct br_mrp_oui_hdr *oui = NULL;
>  		u8 length;
>  
> -		length = sizeof(*sub_opt) + sizeof(*sub_tlv) + sizeof(oui) +
> +		length = sizeof(*sub_opt) + sizeof(*sub_tlv) + sizeof(*oui) +
>  			MRP_OPT_PADDING;
>  		br_mrp_skb_tlv(skb, BR_MRP_TLV_HEADER_OPTION, length);
>  
> -- 
> 2.55.0
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
