Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD201E47CE
	for <bridge@lists.linux.dev>; Mon, 21 Oct 2024 10:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507976; cv=none; b=fDO3QRbfKumPhCjIB0eRb9Jftx7O/Ny4rlixJZhNRwYHC/f9plCm9Sxx2Hv9t9bd1cxsCs5K/EAa9+urDy0TsmjL6DmCCvmP9vIxdeVFEjAbfkMvrjlwN/icopWG/B9scNXDsytKBuJ/KYekfsz3VMmeAP1HGqHSy1rladnuRio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507976; c=relaxed/simple;
	bh=XV1S6Zw+g3mH55uWg3ccT7dNJYp0UXWhsGtCGN4+4GQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K3QWCEsFqE8ML6yf2AyXLr0IskG0M4FOHb4k6HP64uc+CzSu2Rm5RaWE03XUhtPfeWgeej/QQn4nxyvne3008jb3N4rsvxdN/ccg97VKcYjV+p0wOIilatGvz2SJBPGTvD8Ai9zH9G8L6mEo/8Op9E8VaES32KsuZzKPZEj04Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HJ3bezE2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJ3bezE2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729507974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Io9Wjovsf8+IWCVdGDtutv8zva9MNZWk0eG1/vRQng0=;
	b=HJ3bezE2qJhLpENxlwvDobDODtHgQWFjLM/FW5w5YT+H9JINy31H70wO6wC3TejSN7K8BN
	DcMd1Fn43QSK4znLgdsh7I/hoYof660S2u2sc/B5itHYG0qFqo174CQzoBE0LwMjgW2aXw
	gfXFcL6MGVYLGJgrtY2zy/VYDDcdUvA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-bw5ZGAShNh2cA5JPelq8VA-1; Mon, 21 Oct 2024 06:52:51 -0400
X-MC-Unique: bw5ZGAShNh2cA5JPelq8VA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d5ca192b8so2290527f8f.1
        for <bridge@lists.linux.dev>; Mon, 21 Oct 2024 03:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729507970; x=1730112770;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Io9Wjovsf8+IWCVdGDtutv8zva9MNZWk0eG1/vRQng0=;
        b=N7WLtMSKtoIwuUYFmhUIRUpUKXDFVq++78bksk9JC2QE0GfOKJ7c9p+qIeIyg0Utpa
         v2R2mXeNP4s6C1gPgoSpwEbdq7JngKTRxaik9FRWxEODNtxoeqnfDsc5/Vuqr8gDZotD
         uIWHMlRHUqwhmoIZehiNPBebk4Rpj4PVrxglvKDAMtgZLEGiLduv8w/BBRyb1p5gzZlz
         iQEaT8kms73UT8vbNt0hIJawLzgK/ynvgQwDRhBpVao0cGpxLfdF44KA8b8yRy1ecfq5
         TLKoSPGqvsBUM5MhMr0+jpuAqOZZXB9+mj7kjNsYMguidyP+sw4xcP7h3ZV3ohlk1bIp
         4cTA==
X-Forwarded-Encrypted: i=1; AJvYcCWdyAjhPC1yMrxH8azkVCMKQkfeH1mtq8mHsRGFc+TYI7TJm+VIN+G5Gxd8768Y4mvGo7DWg98=@lists.linux.dev
X-Gm-Message-State: AOJu0YwbA6pfthIfBm9JxgMpTFO2W4nB+qAUSQkKZbxX2ndDqPpvOnX1
	6dmlLKLsV7AWHpVp0XseRUg7hcEzioF/etETqI0ot6n/TadDX6ko9j7uVqbgibTao/Unfan05qg
	FCAQUpZuhw0v/dhPbslSDb8E2pZqXDHpNOb9KM0pdFMmyvk8vzSNcGg==
X-Received: by 2002:a05:6000:183:b0:376:dbb5:10c2 with SMTP id ffacd0b85a97d-37ecf08650fmr7003023f8f.29.1729507969837;
        Mon, 21 Oct 2024 03:52:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdA0NxQjeMM/mp9d3cx0ocUBlXzwmAevgDKmJdOzzdQKq8l1oOAE/WjVMpBUAWAdDgbNEdlQ==
X-Received: by 2002:a05:6000:183:b0:376:dbb5:10c2 with SMTP id ffacd0b85a97d-37ecf08650fmr7003008f8f.29.1729507969505;
        Mon, 21 Oct 2024 03:52:49 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a37b07sm4065797f8f.1.2024.10.21.03.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 03:52:49 -0700 (PDT)
Message-ID: <20d9ed5f-abde-43ee-854f-48a9f69e9c04@redhat.com>
Date: Mon, 21 Oct 2024 12:52:47 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 05/10] net: ip: make ip_route_input_slow()
 return drop reasons
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 dsahern@kernel.org, pablo@netfilter.org, kadlec@netfilter.org,
 roopa@nvidia.com, razor@blackwall.org, gnault@redhat.com,
 bigeasy@linutronix.de, idosch@nvidia.com, ast@kernel.org,
 dongml2@chinatelecom.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, bridge@lists.linux.dev, bpf@vger.kernel.org
References: <20241015140800.159466-1-dongml2@chinatelecom.cn>
 <20241015140800.159466-6-dongml2@chinatelecom.cn>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241015140800.159466-6-dongml2@chinatelecom.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/15/24 16:07, Menglong Dong wrote:
> @@ -2316,19 +2327,25 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
>  		err = -EHOSTUNREACH;
>  		goto no_route;
>  	}
> -	if (res->type != RTN_UNICAST)
> +	if (res->type != RTN_UNICAST) {
> +		reason = SKB_DROP_REASON_IP_INVALID_DEST;
>  		goto martian_destination;
> +	}
>  
>  make_route:
>  	err = ip_mkroute_input(skb, res, in_dev, daddr, saddr, dscp, flkeys);
> -out:	return err;
> +	if (!err)
> +		reason = SKB_NOT_DROPPED_YET;
> +
> +out:	return reason;

Since you are touching this line, please rewrite the code with a more
natural indentation:

out:
	return reason;

Thanks,

Paolo

