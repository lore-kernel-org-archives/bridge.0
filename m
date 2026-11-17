Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794937761;
	b=aOkbB2bcJFFHzNZA0WaR0NrEKX0xc7qGKgbaMulXEzckVnLnkK5V4MxmtwXPRfoGGwF2
	 EoqJx3Q0wUh0nDrOo5cl9ZVzrQSFG9u53J0jo+c2AeWYgb0e9C9WlOJxJHVeTeZpNLb/O
	 0/p/ueJaOVW3rYHgz/Acvv0s5V0RDJmBxDdlmu7JVYsfweb0Xqvs3gNpAmp0GQTnEfNp/
	 XQK45hURsT5wiRaFPkMyFZLU1Wb6346+kN0YKYsmQ21KqEcykiHvn8bi2bU5+CkkWTkvC
	 gKKLuK3gvGmWMj6/rbLwYtYanB+NdQ5VyWcvtiAB3JQGmFfGHuYE2Du5KHwIev9eAjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937761;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5rmXe4SVtybipEf84HgdD3RWzcvPSP8W7SzBl5mqv2U=;
	b=RogvpxD1RRtqXKd9adjuiEFgK5SVGPYSC1Jh4XPS1KuExiLCin1caIqmhuxOKgmSHpzr
	 EZ2xQWhQCygeWR8sDnekL7SA4M1rzkEPuktl5sqxdw/39bT3u5AfLqqRbJPtAnVrUU7FP
	 PHIgDFICI9mPeihdwot/vhGaZ7LZtvXtYvbm+hUQRK1wS0Kg7tyjYD1d53Y7y+CDNe2kP
	 TNbIMX0DGizR4nTWYE0QJvR6TKfd3jqLl5vCfDNWZ2R4diMjN66XFKDp7jrIhJ4ADwvEM
	 ZgORW0301v4QBgc9dV/G6Y58o8//SDSf2cdaSL8eX7+tH0MUd5xI6kXO4ZI9ya9GX0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dama.to;
	spf=none smtp.mailfrom=dama.to;
	dkim=pass header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fJTtISw4;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30100606A882
	for <bridge@lists.linux.dev>; Tue, 17 Nov 2026 17:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30100606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fJTtISw4
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8b904d10882so32921b3a.0
        for <bridge@lists.linux.dev>; Tue, 17 Nov 2026 09:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20260707.gappssmtp.com; s=20260707; t=1794937760; x=1795542560; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5rmXe4SVtybipEf84HgdD3RWzcvPSP8W7SzBl5mqv2U=;
        b=fJTtISw4yLuIKbaFiULqlV+trFOvfWHVzk5kJ225YUymQezd80rdzS7HvFtq8PNIvo
         p4TWkRZrBeiSWAeLHaMHyGgVyNIBxmJW4Ucr1JUMJuGOrayZuTNsUHA1s35/DP3Jpsga
         ScyLpwkTCqrxIARjzUDE++z0+QB4EbQYHJYgUCYDFIsw3ea5lIvQ3cYNVRtBhMxgXi6I
         o0xpPUBkZqfVEPiUt8qro92chDUT/eYaT/ITbF99buTHXWmB9WiSOKWm/syurh55966E
         pYpFMqGt9WdF2LCiR82rv5/BpqyA11F7VNeqrTnqZlnBtlorujTbq4vaq7V8JV+swabm
         OykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794937760; x=1795542560;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5rmXe4SVtybipEf84HgdD3RWzcvPSP8W7SzBl5mqv2U=;
        b=SWjAS4mLIEjf6iLuiLVKoXQkM5YjrrQdlg0ztn46Ok2Qwi3yOgzbdPmApamg18iiCh
         bsxM8bri3/P1L9SLcNaL2AU5nXbbvtLal9M2uv8Une90pZF2Ol9XyorVTbOg30ZHO4ts
         f2pvAtZ7/yMS2R4Gt9/hxjBJsUXwTpL2ANMMP8xKiy58QbKIClqy0TfuEktTvUjZ4cq6
         8yFcXAN3epbS26pfpaWc7RwBWapUFWa3O8ngAmGSEZO3vJHY1d9dPlPV1S7hQdEkhQc1
         AhgVTsusCHRgxx8y5gYU8NkeHH+jcpQnbpDqeoObZt0MJaCci+olSfrlZpttYMm1SaqR
         qU4g==
X-Forwarded-Encrypted: i=1; AL+hErFMqm3MwDiv/IWGqLCZlOE9zmT0WfEvGcCh2zZrQPTNqHHoflERTkj8aBMGURWx6L6VdWf8/pk=@lists.linux.dev
X-Gm-Message-State: APuU4Z8DzsVvgqAQ+Qnqu2RxjBgU54A8mKaT7djPYJ8lk8zmsg/Q6qkt
	w/Sc3U9x1gxJlN6th+kkfyGT/kgLId2CYx0aMnNVsCAHeEmGLtwFCeNpvhybDEMWbLM=
X-Gm-Gg: AYBFou1odtYaFJB0oDdWwg/Ya/2xYladkjLWwQo+IZzC6hpuPeTliveDbbJuWlit46f
	bwgGJKf3T3FIa4jxa8izErJqKKapANmFIf6oKVJilPyc6zQ5qEIMqhkituXU+IzTmG7VNdl5Q2K
	EMeoZX5UjS/FU9yVDnQomIyk9N1vV/853w3b+/SdX4NpYjQH7x2GCe7vYByZmXrsmDJDJVcChz8
	VptfO8H8vJ4JfnS93RcggzWQdfDduaHSAyYGh+PDXFpWEeQDwZ8I8fR/KuPK8T+1u6Mz2jJf6XX
	ctUYU5Nuc0yvqs4cXkiWwI9oMYciFHTtonUpaI+e4NspB9I9A+vRAzbb7hyjGgukXwhjLiAVMNb
	2f9Pztp+3imuBnta56BMUlMKB7eB+a9Yz+s1eF7dXmNwVbFhwaYdZ559nOz8W8jsPGLDOPXrqq+
	OfTSs/zxrQMyiknuFubDHQP/ya8TGdjs/yGntBhACYAfrkbPwL6Gqjz5+YUfi0/hNv5cKoGANnd
	0MMF2jyzNUXJNCH9gY6G4M/BRLq/c4Zx4yBRI25qlBHDpH0+lsWBzBUDsJWDVszIItPFKS/ausr
	ONIDm4l1DP6PELPxx+s+epGnOcgfaJgljzt8on4aY8E=
X-Received: by 2002:a05:6a00:94d3:b0:89c:d875:602a with SMTP id d2e1a72fcca58-8beb56cd09cmr14335328b3a.11.1794937760420;
        Tue, 17 Nov 2026 09:49:20 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:47::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c5cb54e413sm7290b3a.43.2026.11.17.09.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 09:49:19 -0800 (PST)
Date: Tue, 17 Nov 2026 09:49:18 -0800
From: Joe Damato <joe@dama.to>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH] net: bridge: avoid redundant strlen() in
 show_backup_port()
Message-ID: <avyTnnR3xnUSnPmU@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux.dev,
	netdev@vger.kernel.org
References: <20261117165106.635733-1-dmantipov@yandex.ru>
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117165106.635733-1-dmantipov@yandex.ru>

On Tue, Nov 17, 2026 at 07:51:06PM +0300, Dmitry Antipov wrote:
> In store_backup_port(), prefer strchrnul() over strchr() to
> avoid redundant call to strlen().

a couple things:

- i dont't think the change is worth it because it feels like unnecessary
  churn in a path that isn't a hot path. how many bytes are we really avoiding
  counting here?

- commit message mentions store_backup_port but subject line says
  show_backup_port, so commit would need to be respun

but imho i think this should be dropped
