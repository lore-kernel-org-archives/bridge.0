Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9325023AE9A
	for <bridge@lists.linux-foundation.org>; Sat, 16 Aug 2025 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755361260; cv=none; b=O8ffWKBgAepThNAhhxGZ8vDHtFELmM9006cCISVrp7u3HJFiMJ+PunuSVapWWY8SBXwjIeArjsqEaUDI4Tv9Ro9WJifibg1MAY9/AbYkNSL0xL9s55q07LobRjXWtB/mGcqF+DK4g/I7ZmI0iFn8E60MzD6o5Epn++11l9Jhq30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755361260; c=relaxed/simple;
	bh=QIQyVqvGPcDps6iIwEyiu67tal0bJZVozwf33kMwlww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mr7NlSgTKyKzCqVfRAdgmlSdDOyZJe4kkfpr2H+j8BU4fFHWHv4eqpQADQiAjZg63Nw5yojdS47dEfL4AKr4xzBmk4+JmkBR7QGRXdGWYzKtjvIKyEqVC/NNnc/C0K21iiSKWeYviVA74LAEQojTeTAC2Vxi/iaxJsk8CKQsbgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=RQr4TPDO; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="RQr4TPDO"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2351B612D0
	for <bridge@lists.linux-foundation.org>; Sat, 16 Aug 2025 16:20:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SOvzI7K6Ba6m for <bridge@lists.linux-foundation.org>;
 Sat, 16 Aug 2025 16:20:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com; envelope-from=stephen@networkplumber.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 30923612CC
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 30923612CC
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=RQr4TPDO
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 30923612CC
	for <bridge@lists.linux-foundation.org>; Sat, 16 Aug 2025 16:20:57 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3b9e4106460so2367094f8f.2
        for <bridge@lists.linux-foundation.org>; Sat, 16 Aug 2025 09:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755361256; x=1755966056; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAW99pktxnORz2JMcW6AE4MbCE1J5F4f+hfGP6yT0pI=;
        b=RQr4TPDOXM8YZd1vLMsqWaaPQC9bj5K1D8Rt89RXq8P/ciPgEJ7OybjkjhhZU3nq2T
         Cwl9Brd//dzwAUq3gFqC514xrs2k/CuC1jVnls04s9e9Fnrkg6DciKX4yJh3NGwIBf/S
         M1rn7rqn7aTfiUcGkRswKFa/AJK+gBlugVXUIaph1/MjBucXQ/WaPj5sJXkVplIUoLSg
         zRLSZEA0J2anJt17A2KiEGdXLbpgOU88BTZ+U89cR7ZOi4PihmIZ/CRlQoDcs5ISFDbt
         fLmFvhCOvqoilXE7dDPWUaM53t0TuGuFqMWceQIk3QlBd/gCgciAC+hRMReqkBjNuuGz
         UQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755361256; x=1755966056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAW99pktxnORz2JMcW6AE4MbCE1J5F4f+hfGP6yT0pI=;
        b=wrpeV/Fo1F3DNJtnwEfLeisUMHV4JpoBu8zM5WFA0t5e9+jXrGg38ycXOElkaPhRj6
         AuawA+RzAxmi8l0dH8Ij7B4baCDXDCV/S9oNF6MZy6Cz+Wa/2nHMfXEbqzF1c2yj85cz
         QhnytlKnnM+sOyDjh6AMD30+w7ONcOdclxdGVYQO9m3bjom0Q03l8Nqcj0SDQ/yMAnBP
         YaUUglggDCyD4cuGdEs0bxKCNcsPQb4gXKL911jVgO4rODzLK4fo5+fN4pDcxD1r4Vt1
         cmu7bYMaoMUtqPsDRFcpqz8zT1aa9l5mEEmBB8/gB5mXrRsF3SAln1GUUw1L1Yb7H9yq
         RafA==
X-Forwarded-Encrypted: i=1; AJvYcCWlSOZwaZFfpf32qLF4YVsGjrAPffzFqtip3yz18xJ7TVa6pX3BcCj6CFoiaKe0FcnbjCSrhsI=@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yy7L1ewcfi2LopVzS+J9B0+LGAttf7IpK4AJIZeC01Wp8DtxD2U
	I2DFkw/uAPHoakjxwKRSaBPph4la8yDpy8/+jQ1asG/YIer+eKQ43f6LM1V18G4UYVk=
X-Gm-Gg: ASbGncuIaqmqjyJn9hK4N7ZUv3acB4pGPb1ZtnZ26ODQqbc4eTU3l8LoDFivIXDB+bD
	MtB/vUzaYRpmXWM2+GZjvPqic7pRAxNpSaaHisEp9lbs3T9iRmZvXDxtgBZ/0bbblDELp6kyBs4
	w1UV4PMXsppnWzEDZo7/D6fmSvd06ICo0r5B1pRE+rZZsDS4VeR9rTn0oed1aJxGEOn26l5Iqj6
	fLq4XgG5vwWvPLtGu9dbjJHvh7b3MyPyrF47LhKdWzcUfn7AM1OGvLQcvkbGI4ZZR3wRn1JKu0Q
	/IR1qgHa3QFFsX1fwpQx2RHCUIH0ilDJI5lwqrYh6zS9jos60WvMiLnvywfHkpF8PkXDdtmRfWU
	gG1YI+EpNe9r8oOcmFml2p/9Ng4SZI806CMS9rrpugPUnFAnhvKxuptpZUjZxzyWkObb8twBVI6
	c=
X-Google-Smtp-Source: AGHT+IFIdLm/8s6uFqTKjY1SIvUTTq6eT0IObfEJpq371TF19ellWY9RGpF2V/ATCR8bWiT//jgWbw==
X-Received: by 2002:a05:6000:3110:b0:3b8:d69b:93b with SMTP id ffacd0b85a97d-3bb69c71c8cmr4696818f8f.52.1755361255973;
        Sat, 16 Aug 2025 09:20:55 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb64758436sm6326160f8f.1.2025.08.16.09.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 09:20:55 -0700 (PDT)
Date: Sat, 16 Aug 2025 09:20:51 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mrinmoy Ghosh <mrghosh@cisco.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org,
 mrinmoy_g@hotmail.com, Mike Mallin <mmallin@cisco.com>, Patrice Brissette
 <pbrisset@cisco.com>
Subject: Re: [PATCH iproute2] bridge:fdb: Protocol field in bridge fdb
Message-ID: <20250816092051.1a8e4ed3@hermes.local>
In-Reply-To: <20250816031145.1153429-1-mrghosh@cisco.com>
References: <20250816031145.1153429-1-mrghosh@cisco.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Aug 2025 03:11:45 +0000
Mrinmoy Ghosh <mrghosh@cisco.com> wrote:

> diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
> index 085bb139..1ff9dbee 100644
> --- a/include/uapi/linux/rtnetlink.h
> +++ b/include/uapi/linux/rtnetlink.h
> @@ -314,6 +314,7 @@ enum {
>  #define RTPROT_OSPF		188	/* OSPF Routes */
>  #define RTPROT_RIP		189	/* RIP Routes */
>  #define RTPROT_EIGRP		192	/* EIGRP Routes */
> +#define RTPROT_HW		193	/* HW Generated Routes */
>  
>  /* rtm_scope
>  
> diff --git a/lib/rt_names.c b/lib/rt_names.c
> index 7dc194b1..b9bc1b50 100644
> --- a/lib/rt_names.c
> +++ b/lib/rt_names.c
> @@ -148,6 +148,7 @@ static char *rtnl_rtprot_tab[256] = {
>  	[RTPROT_OSPF]	    = "ospf",
>  	[RTPROT_RIP]	    = "rip",
>  	[RTPROT_EIGRP]	    = "eigrp",
> +	[RTPROT_HW]	    = "hw",
>  };
>  
>  struct tabhash {

This is iproute2-next material.

Where is the kernel patch for this?
Iproute headers are synced from kernel headers.

If you add new RTPROT entry also need new line into etc/iproute2/rt_protos


