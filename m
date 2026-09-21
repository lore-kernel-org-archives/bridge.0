Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F6D4A2A52
	for <bridge@lists.linux.dev>; Mon, 21 Sep 2026 13:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999066; cv=none; b=k8RgH5bdLbQR1CumAw6ukWWhFZkfBs+yV1W7QZ2mbC9UoxgPAoeuINUrX0BNGkFewSzawuMWQuMtXGtN6eCI83uLqscjsYWLidAdL5dSNFKl40DXBZ1keMqQqmN+Vw8N3cCFl7+lP3NiaCAhsj8+x/C4wcxQxriFsk5M9endbDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999066; c=relaxed/simple;
	bh=Tb+naUYdOEbqWhCgBQoqJYUsxvDutMO2RLyfrlwQ7pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fWqysa8SkhxpVkYc3474q+XgKdYzrruWc5ooGvOsWaWqraHnRNxnZEoQq1K1D5z4otO59E4sX6fyDea0tdwMzGtwPdK158XASUpyB8qxD4ZJpCg9CHKCNxjxDpQcncWFUYgaOH/B+8Nh7XQcJcoxhIX9JlwZ9JmC3cXeAk81oEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=TtbGLmfM; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="TtbGLmfM"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7bcb94d3so20884625e9.2
        for <bridge@lists.linux.dev>; Mon, 21 Sep 2026 06:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1789999063; x=1790603863; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bv3nJ81FTi9YRl87roXZd095J9UesWmHL2qfxaLM+IU=;
        b=TtbGLmfMkibK2acGuFMzQG6tU2AOyxaaDL1aFHO+Dj/4wofHB9r85WkrEPL+lFj0ve
         tr4l6vaMFiChqerrmou0VJKXJj2nAkEueJ1BT1+Zue3WbxdTSKu6Wrv/cEDidIam9rmn
         gCzO+w7aLjdRPXruggngLFnNNQQHc8t6tdsNz2nDMH97RgcTPSRfLQw3x00efRI34URy
         nEXaI/1UqYhQprIraov5PGwd1yvN0Lnp5dxV4TOLm+XmNLZoWB67MOHBsy/PHvf/tp7Q
         SM1s5URpr9ASndI3mcaqq+2sZ2X8ltZ1uQgM9OF6lh8D+WyTmuddDoDt/bJ/7b3h2wWf
         eUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789999063; x=1790603863;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bv3nJ81FTi9YRl87roXZd095J9UesWmHL2qfxaLM+IU=;
        b=iW6BzoX5y8E9siJY8MEmRSTy9hVD9hCuJo7hIZEFWjNw6gv2OZgg/G+1Z4jrVKUOJ7
         N0W8VGRriFwDnZakMUx+GM4XQGfztzq621BYSkzPUV6t69mq9oClBRUJL1bQ9ED8eis8
         adSCL7xNC1pvtq2ODDjYaf9xnSTBypBYP9j8pdetFm8L/6vohjZeiITDssiL81FFTEgO
         NAVdQc1AHyEkk1qzZNtH7uoDHqnTG0L/Pn9uwANIPdIBSUQsfT3FN4zzO72+bH8mdjLw
         Pg6gXCdeRBNKz1UpbbCisD85oiSChF3DVm/pTCu1KTKHnNOd+LrhJ5zvYPtY1kFDVu6K
         Zpfg==
X-Forwarded-Encrypted: i=1; AKwUvBxa8qc8INuWpZJRfJixinLx6kylvEBMealUNkC6p3U5V7Cj09XxnFnnO0tPp2lqZmIa3AAbY7E=@lists.linux.dev
X-Gm-Message-State: AFuF++niNBcvMNPb73xMWrToWXGtjdmTXt++JXtfpxYlt7GGmwcJ5PkQ
	UOW/F5eA7QRP8VDw1Jfr1k2JU1tQHMg1x8dcqntXnGWyfEkjQCZml5wPsErOEoEjGto=
X-Gm-Gg: AYBFou0P9ZVtQC6dz6x42ZILMFNlt3tNiuNUZufPcmRphG0N+0/gVcX5QCdCicwedD8
	/f5TI2j2pkA5Q2OfPygVzrCWo772n7Q8l1WCWp6DZpZuFSH8FFbfvfCAYNSajvPof55T8f37Z/d
	wZpkhmPGKsA+5YQyANzPlcgcXzd0ckN1QC/reJ2FtYpKEz0UBBBAUPfdT86fwBT9rFEquM9EW2H
	y8kqWgjpgE9PeD4Nz5iyISJ54ufv890d3No+j0qSL5ELo0//2GFKVMaDgw4XN/u9l7diEuMrqDS
	XQv1nRzGYAE/mAT50QQoH5EvE7htMEtBU5SLBpoXe0pp2ci0RSo4dVBWf4ICv892YL7DBQx4EXS
	9oovgsqtAE2qTkEEU4gHjSTbxlvTeqoW39X1w1p2LMa0m6SShQ/R1s563PLTL9gfz6RkkquzBGv
	L15lhyyCX31uemaMkrqG4OtKRlxaemRqk0wqy+PyVYXYanzPAgaklHYTV4R4OsKxAztO3SIUZaJ
	Nhoibs53Gr1//mXIEmBuWYTnplw/Q==
X-Received: by 2002:a05:600c:81c5:b0:49d:1a02:4797 with SMTP id 5b1f17b1804b1-49fc5737cd1mr132113045e9.17.1789999062539;
        Mon, 21 Sep 2026 06:57:42 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc585920fsm619266685e9.4.2026.09.21.06.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 06:57:42 -0700 (PDT)
Message-ID: <3d92300f-a3bc-420e-b94d-f59d7b928229@blackwall.org>
Date: Mon, 21 Sep 2026 16:57:41 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/9] net: bridge: vlan: broadcast fwding path
 optimizations
Content-Language: en-US, bg
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bridge@lists.linux.dev
References: <20260918152950.1938259-1-razor@blackwall.org>
 <20260921134458.GA2199421@shredder>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260921134458.GA2199421@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/09/2026 16:44, Ido Schimmel wrote:
> On Fri, Sep 18, 2026 at 06:29:41PM +0300, Nikolay Aleksandrov wrote:
>> Hi,
>> This patch-set is the first step to removing unnecessary VLAN hash lookups
>> from the bridge fast-path and also provides additional broadcast path
>> optimization by considering only the port-VLANs that actually participate
>> in the VLAN instead of all bridge ports. Combined these changes bring
>> considerable improvements[1] and open the path to do the same for the most
>> common fdb forwarding path. As expected the pathological cases have the
>> largest gain, e.g. if we have 1 client / VM facing port and 1 upstream port
>> only participating in a VLAN with many other bridge ports, we consider only
>> those 2 when broadcasting in that VLAN.
>>
>> For up to 8 ports we only use the port-VLAN list as the array doesn't make
>> much of a difference and is unnecessary. Note that the array is rebuilt on
>> every member add or delete when >8 members, I tested that and could do
>> 2000 VLAN add/delete with 64 port-VLAN members / sec on my test VM.
>> If it ever becomes a problem we can optimize it further, for the time
>> being I prefer it is simpler.
> 
> Very nice!
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> 

Thank you!

> A couple of nits that you can handle later (or not):
> 
> 1. Patch #3:
> 
> __vlan_delete_pvid(vg, rtnl_dereference(vg->pvid));
> 
> Can be simplified to:
> 
> RCU_INIT_POINTER(vg->pvid, NULL);
> 
> 2. Patch #7:
> 
> Initially I thought that 'fwd.vlan' is never set, but then I realized
> that in the only place where this field is actually set it's called
> 'dst.vlan', which is a bit confusing given that in the context of the
> bridge driver 'dst' is usually an FDB entry. I would probably rename it
> to 'fwd' to be consistent with the rest of the code.

Ack, I will deal with these in a follow-up, I have another set that removes
the two egress vlan hash lookups for standard unicast fdb path and will add
these as cleanups to it.

Cheers,
  Nik

