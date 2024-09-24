Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3BE1A7278
	for <bridge@lists.linux.dev>; Tue, 24 Sep 2024 13:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727184783; cv=none; b=Adjz3VtGtM5LDFO9YK7VZOmhxFdIibiWdBzr8COjWvvHtUt552UZvjAWo9BIGYx1EzYKe40k9qBtc46k+DhHQ6Tgkcwejelj5r92zi4NoutmLgJ5P/nODqO6RUB4kGEDvUSTEPEKdtV7l4mOyaFVVrGI2+5PH7OEEpNV47gKofs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727184783; c=relaxed/simple;
	bh=zyF69t0jxLA0Sg61b0pLpjejIj55t5UUwOvTfHql5NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2bDzyARyAGe53AKSSdIUXnXe2s/FVHFKCBzJpvPGTi8Qv4YKAYoqaW7F/uj61Tve1RxcP0s7EGBQF0jduQzPZoB5oKSg3skWRvMmAOYozhXFGKlIiMf4AwQl8R5ks+43BJbgxNq2gNGkB3zfxqVf8EOahDQ1QzjmyHtXHNgat0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=0mQztA3M; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="0mQztA3M"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5e5a0519d00so1197281eaf.3
        for <bridge@lists.linux.dev>; Tue, 24 Sep 2024 06:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1727184781; x=1727789581; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFma2tLGVK6CuxpMi6SW8SNJuIb6p2HSu5tYW3xDL8c=;
        b=0mQztA3MPrsWmeCujXesJlz7V6rgChAd4s3uG46SzdHXJBEsRglgaoTKPH/vREKo5k
         ylz92eDdEhlH9r+FdSk+MmEXglhKWUFh6C/kjLb3QSWRwmFHTCJNql9FAClHHrX7ehP6
         8DzbTJv1vc5rTsTiPRhymZBkLir98NxLErYFAbifhdJOuwTsvsfM+kBgkBpQn4LMbW+u
         xiGTx2cJSI3whbBTV56jQLaG4tPhlHJm/5YIoSvMRI1nkWSWrtTOsRcgZN7ToUBViEWU
         sa1K4/4E00YpCc8e55Vr4GrFTZzbX4d67KSqX/z2xguSHDi+onaaFqL2W/CQTJ8eRFPO
         396Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727184781; x=1727789581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SFma2tLGVK6CuxpMi6SW8SNJuIb6p2HSu5tYW3xDL8c=;
        b=mWIHdAfoSwylqBvUxIQMrvpd/0mS+gR/adLMLKG8cjuYq/s2dmZiZ6cpu6g0Y9sRWJ
         QyphDOndfEqNPvh+jVZy9ci1jX0b4CCYtiDA0FPW1HFWBDwzyQJXIe8C8jvLfgClEMwI
         b80+VgT57Q/ogAjpKbQNuF5HaxjYQsp9Lk/Bxumecp1YpRL7rURCpU2DiYW/0DHtbIt9
         saynz2tpGuXmDRIxlNCQEMfM77g8+F0iKNVIGBwfUgIGlJq18FjInHae01AZU2urACUa
         86rpuk98/ExDEkUy2tRHpi6jL1ohhIa+IbxitHgsMpA3rJPCtm//AmJNYdbrLrXb0KSI
         zbqg==
X-Forwarded-Encrypted: i=1; AJvYcCUFLQgBHMpc40qU0QVTp2vlfyd9uLcHjWk0+QtlYkr6S9zB94Ci4cYeOXZM3ki1VAIWY/vjoxU=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywef/NduD3eeL2Yk9FdlpQ7uycK9DwA8wkCGtPeXXswFYaB0Ery
	v774+R5V3A1n2iaw0uhxvoBsX4p/la3EJcZ7N0EtJwwEPj6O8v+ZFHOH41qfG2Y=
X-Google-Smtp-Source: AGHT+IHyraTLMnSqfRhvqLf0XswmKqahjZtmkjaSKk0J9EX/vsul6nQxVKBsx4075Q17ZvK3zidHsA==
X-Received: by 2002:a05:6358:9107:b0:1aa:d6fe:f422 with SMTP id e5c5f4694b2df-1bc97627978mr258305755d.18.1727184780859;
        Tue, 24 Sep 2024 06:33:00 -0700 (PDT)
Received: from fedora ([173.242.185.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acde5cc309sm68452385a.84.2024.09.24.06.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 06:33:00 -0700 (PDT)
Date: Tue, 24 Sep 2024 06:32:58 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: yushengjin <yushengjin@uniontech.com>
Cc: pablo@netfilter.org, kadlec@netfilter.org, roopa@nvidia.com,
 razor@blackwall.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net/bridge: Optimizing read-write locks in
 ebtables.c
Message-ID: <20240924063258.1edfb590@fedora>
In-Reply-To: <14BD7E92B23BF276+20240924090906.157995-1-yushengjin@uniontech.com>
References: <14BD7E92B23BF276+20240924090906.157995-1-yushengjin@uniontech.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Sep 2024 17:09:06 +0800
yushengjin <yushengjin@uniontech.com> wrote:

> When conducting WRK testing, the CPU usage rate of the testing machine was
> 100%. forwarding through a bridge, if the network load is too high, it may
> cause abnormal load on the ebt_do_table of the kernel ebtable module, leading
> to excessive soft interrupts and sometimes even directly causing CPU soft
> deadlocks.
> 
> After analysis, it was found that the code of ebtables had not been optimized
> for a long time, and the read-write locks inside still existed. However, other
> arp/ip/ip6 tables had already been optimized a lot, and performance bottlenecks
> in read-write locks had been discovered a long time ago.
> 
> Ref link: https://lore.kernel.org/lkml/20090428092411.5331c4a1@nehalam/
> 
> So I referred to arp/ip/ip6 modification methods to optimize the read-write
> lock in ebtables.c.

What about doing RCU instead, faster and safer.
