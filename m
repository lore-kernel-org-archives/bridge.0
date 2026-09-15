Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C11947F3A0
	for <bridge@lists.linux.dev>; Tue, 15 Sep 2026 10:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789467801; cv=none; b=Fh3oZWCGs6xzYlWdsissGnlv97I1fx7/bwdES73UjKXsCdQrD5mNXGgGNdEkizNT829ffB40Pl71i+prJwPRgjXdOtUK3uLPJLjGkpmqYmPOeK/DBPontY9+HqnuLPJ3JHyF8GMdHFgajpCOhQAWl9zHl0eZdNTaeFjDSKk0xZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789467801; c=relaxed/simple;
	bh=VOUBpyRp34OXryxgM5Zw0tpiAqDS/kFSwbZiQ9LEYEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bOlXG6GSY6M5ZcfDfBYu1Ch8RXmf325fE35haQUyHKOmpguFzbfqLWjNzaLK4A4o654nJbA+crtJZVbASW0AjYhSUPaIo4VINml4BlNGCfdesyyTypca1XtvMPMwulC/Kf00Zwn/n6eOQbgU5Rl8kkBEF0V+pwmiSEq6JmDPelA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YncPpsIF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YncPpsIF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789467799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8iyB1VIdARn1Y5KDniNBe9GaBJ6kkLcc88CEhktHYls=;
	b=YncPpsIF9CsH5HhfpGfNneFzjeWtjBBi4xknOzuRya9ioZYSYD4Y/r4xCtkuocp/zXju8i
	/Y8z/caR0REibmfiDWw/NYDoFI/gDFd0CCaJ/Wjoth09kNeuNfJMUYmxwlnO+BfHyWGjVw
	uiw/5qBIoME0+TVORfHXAmoGWLh0Q3E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-UPeVvSYPM4qB7dZltv4BXg-1; Tue, 15 Sep 2026 06:23:17 -0400
X-MC-Unique: UPeVvSYPM4qB7dZltv4BXg-1
X-Mimecast-MFC-AGG-ID: UPeVvSYPM4qB7dZltv4BXg_1789467797
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49d156c917cso4062535e9.1
        for <bridge@lists.linux.dev>; Tue, 15 Sep 2026 03:23:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789467796; x=1790072596;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8iyB1VIdARn1Y5KDniNBe9GaBJ6kkLcc88CEhktHYls=;
        b=lh7auwKsXi+cFHYAHf1ACMqt6IdOqRAEve+4Umo+akGqc+iH2v3d1N2afQ1PwmGsQO
         k+LiwauZtIcR5c40tzVSL2gDuOcb/pFLLKWJcQb7/h/W2VJs+qLHvREes1S9sO4P/eey
         znqandGokJFG/7kWR6HHK4dn9LMjmsahNfZjkQiL6sgLR6ZVbv7OYQbBtJillWpRu1bn
         FDKciwFhQqKuvz7qKFd/hUxzOtVL5aSxeUHoOF8I2iCf5PVyrqlvQioeIi3x5fleTJML
         t8vkauGdCQJXIUYsk2i0r7Lu6lQad7ywtIxNrvnq6TvCQ79ISOeCYr146ki0Ed5uSXmG
         VHXg==
X-Forwarded-Encrypted: i=1; AKwUvBzjtO3ZL0Wc6BzdmghLGPAzEA3CG8KisDjvTP01Ek4S3v60V7DHwyRydeczEH9C1DSJ1Ly5Wwk=@lists.linux.dev
X-Gm-Message-State: AFuF++n0ft12oitzzGNSQEDl5uNP6B7wNLikLrnxuudetQddQ/wwoY+B
	n6Ubbvf2KfANzfEFJvWhNV8PNd7pc37GxSATZREw7U8UQpaQmbT81e+cyPOS+cMbgQ25OtI4BFx
	s7zKN4VvU1Z3G2uR0yf4N3zkbaH2TrexUuuqEfQoBeLjaIiNQjyO4Tscs6A==
X-Gm-Gg: AYBFou3O6dQveNzKpl9nvEZRjUxSMGkru7gbwRd0A3/iDYykLBgKRz+iiVNfYNY569L
	QAeUbm+M86pRgq5CQ5VeU2WTuSPapVthKCuqaiex1OVyLt1z9J6M9fAfmJKhhAHJ7QPfQ4TpqGi
	LKXHcjhHHdTwCUTRoeDH3ZZVm0mfGh1h9zNUHYCcFnoFOCmESK4NLU9jMASDFneSPyGT0flD7jU
	7Vyr3QhBcKGR8ZBg6FScMite5be7WciEqzLrfkKiL0f0eDy4BFB7A1cBIqX+J8//073SSIK/vHI
	OzQh3ZlOxhlWW5TY8/I+eDLB6BFlpxp+LrkVQ9svK4Vo2ded521s0Q3MmE7KB8vwOgx/7FKZC4g
	CnUrD6LtJ8xid9zpEDJ91mzg2fskIbPnV2nZr7RSo9ADqAClEXabjOyHsBsv5WXgZwdMMf4zNEg
	==
X-Received: by 2002:a05:600c:e557:20b0:49d:1916:2133 with SMTP id 5b1f17b1804b1-49e7d7332f7mr26989255e9.8.1789467796476;
        Tue, 15 Sep 2026 03:23:16 -0700 (PDT)
X-Received: by 2002:a05:600c:e557:20b0:49d:1916:2133 with SMTP id 5b1f17b1804b1-49e7d7332f7mr26988995e9.8.1789467796028;
        Tue, 15 Sep 2026 03:23:16 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7d66a4a3sm72734105e9.1.2026.09.15.03.23.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 03:23:15 -0700 (PDT)
Message-ID: <7043a1fb-fd55-4a4a-82bf-c5428f67a035@redhat.com>
Date: Tue, 15 Sep 2026 12:23:14 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: mst: move switchdev call outside rcu
To: Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org
Cc: idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, tobias@waldekranz.com,
 bridge@lists.linux.dev
References: <20260911105021.1385934-1-razor@blackwall.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260911105021.1385934-1-razor@blackwall.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GH1_xpDZjAYimWH6JWq_oxw_xenrnTMOG8SPLOIWl3c_1789467797
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/26 12:50 PM, Nikolay Aleksandrov wrote:
> This is a follow-up of one of sashiko's pre-existing bug reports.
> br_mst_set_state() calls switchdev_port_attr_set() for nonzero MSTIs
> while holding rcu_read_lock() which invokes the blocking switchdev
> notifier chain and may sleep. Nonzero MSTI changes come from netlink
> with rtnl held. Move the switchdev call before entering the rcu section and
> assert that rtnl is held.
> 
> The call cannot be deferred because netlink needs its error and extack.
> Also DSA reads the old bridge MST state during the callback and checks it.
> A deferred callback will be late and will see the updated state.
> 
> Fixes: 7ae9147f4312 ("net: bridge: mst: Notify switchdev drivers of MST state changes")
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
Clashiko noted that the fixes tag looks inaccurate, should be:

Fixes: 3a7c1661ae1383 ("net: bridge: mst: fix vlan use-after-free")

do you agree? I can fix the tag while applying the patch no need to repost.

/P

