Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F2720F070
	for <bridge@lists.linux.dev>; Wed, 19 Mar 2025 19:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412629; cv=none; b=YKdDXgcQsVAmp0R3/c7SBdlgmH0XTYREtxoDen+tBGiojKOVxRluPUOt5q1mRrVJ15unwhIcx9+lxcNHFQSKZLU1ZJYfyXBCPcFBpQ4TyoC2EMhMbRHgL/Q2CGp5MquZrUmGuzfytv0VWfMr1xydSz+08rLRI0XpztMMLwO8nWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412629; c=relaxed/simple;
	bh=Rz7Yp1I80hzWgHGkG+CgxdDTBoc6y2B4a7XLDwScsJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=op3aGA2jMTYIN/EjnLmSOmNHNUAEMF8MY82BEoNbDrXOM1Rj7v6Tql6enU08Eb+VwlV/i2XtryiLGEji/Qc2OLQoQyN1RWSW/SzquyhgLkIqGZUP8sne7UofcuTb+rm04R78WKBVBjXJd1dMcdVjTNZaTMtHJhoR4PyLhkedAQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgiPpikt; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgiPpikt"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac3b12e8518so14536566b.0
        for <bridge@lists.linux.dev>; Wed, 19 Mar 2025 12:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742412626; x=1743017426; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JcRJhKVbE8LiKn0WB81Ry6++/HhaRWmyYNiRtC8fff8=;
        b=BgiPpikt20xo0tzcT5OM0c21lOBs5sb2tgasJIno4tYrDrCVOoDnvUucB2su0x6TGx
         KNTGVaAkIJmBUQLmsMB6yajvvABw4MTScGReoYw/4hba0Ps0WmCFFuOY1VvlF1T+fHUg
         oAQaOLSXGsQVxRCSoPMdxSGQWh3i8az9E8Mx9sF5X3JM9p1KJtlFFcgnf4/jzSkhykHJ
         w33qhislsUtgxfZ55jOb6hU72Zg0HKoQmdc082x1THPU4K9iBsQyV0WHVucbGQEr8e0k
         EJU3LrNdfv3qEDoQPNdLZdFalFAKtWIyf4UKEcsSl57/5COWwtCEMdL8yUwNk8F+rsmI
         jb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742412626; x=1743017426;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JcRJhKVbE8LiKn0WB81Ry6++/HhaRWmyYNiRtC8fff8=;
        b=RcHWnm9gb06FXUOgHScmkC5iswrETtPvq15hj//nT4wmYtiYlIQadncZ5hMSEFzXPV
         o/cY9plFfXTGzY5h/PiYKWnR4GxTcqai94lHArbRc8kqt+dtEHBu9ZuOVhnc2W5EWRnZ
         uPXYvZdDWmtilvfUoz1H9dFAq/fFR23bjBY9+uaL8KBM57ZKlHiXezZjalRsbYCEWtxj
         CilgGp0w4oSXcHMI8JAoDHKkdwdMmjotfS79SGFppUW8WBmefATTOjAgnf65LSbwLSmd
         tfybORIeN1oby2LfWVdGC7w/zod1/1UrizvW4c+FFlcWkm72jtDu08QzMWXKX9PY6qee
         PtzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ1AAj5u/7hYPnUyphc56IEcEpA+W4uc8Fe2rV3AVmeg7W6hQ91EHojzz6+vtwH4HQWEDDm1I=@lists.linux.dev
X-Gm-Message-State: AOJu0YyO0rebHPApswqRSiplpJz6Ih46mtbQ3FmWVj0UUvyiXoTqlBjv
	zgWX9jq2HoLTpx2DUIHknEsZvhKCRksS8qY+cKouwAwpuAXtS3HR
X-Gm-Gg: ASbGnctSupPI7B9eOHaiUVuSYYgBs+zMI0jf8NsYSAWyqiUNh6jJ9FodCPA/7S+I4KR
	t06g3L75V/MTXt0wO1kCnpSbQr49AZ8GySfTHMAkHLOC0JbddhfhxKyZ85NsUsXkh1epRj9ZHQW
	hcS1kVl21QVSP2I0WqsHknJwbE7X717HWx9s/nRZrh+/7kj4yVvp1vhoV2HjdZtxMVigANOrLln
	KcLQgP+vQ66aQmw1WciOj6pPXl1eKROAc2Y+WiaJCJwsJi8ot9+0F5cDegZo+XwfzFyQBZYqN2S
	PRdZ+I7GiQZPXkJAYtH7ha828J1Fgk6QFGCa/TXi4GPNK7YZzny954pB/6rw9wqosH4ruAVh5Jy
	Tbc0wfg3i2+RlPMwx3aUigqcOVezUXdwJaXlP74n/QQgPe1iE/Sc4dWK2PR+DbuGBREz4DU6klq
	42rDpFEDAvts7WxGF6MSA=
X-Google-Smtp-Source: AGHT+IHfY94z1fDRn6/5yWLXbj9lWPjuQfu08xCij4YrKfzU9oqQAqTzAP1SiocnoJAKedNXqvHa0w==
X-Received: by 2002:a17:907:2d9f:b0:ac3:b613:a651 with SMTP id a640c23a62f3a-ac3b7d72767mr373478666b.17.1742412625436;
        Wed, 19 Mar 2025 12:30:25 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149d0077sm1065324166b.93.2025.03.19.12.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 12:30:25 -0700 (PDT)
Message-ID: <6d16cf71-ce66-46fd-94b3-5757ef044bd5@gmail.com>
Date: Wed, 19 Mar 2025 20:30:22 +0100
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 nf-next 3/3] selftests: netfilter: Add
 conntrack_bridge.sh
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>, Roopa Prabhu <roopa@nvidia.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 netfilter-devel@vger.kernel.org, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250315200033.17820-1-ericwouds@gmail.com>
 <20250315200033.17820-4-ericwouds@gmail.com> <Z9n8qBrt-TK4XlRq@calendula>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <Z9n8qBrt-TK4XlRq@calendula>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/19/25 12:07 AM, Pablo Neira Ayuso wrote:
> On Sat, Mar 15, 2025 at 09:00:33PM +0100, Eric Woudstra wrote:
>> Check conntrack bridge is functional in various vlan setups.
> 
> Only conntrack bridge support is tested here, patch 2/3 does not seem
> to be covered :(
> 

I should add more details to this description.

I do add the nftables table bridge, chain forward, type filter
and check the counter for ct state established.

Without patch 2/3 this counter does not increase.

I can add more match criteria to the counter next version, to better
check patch 2/3 at l3 (and l4) level.

