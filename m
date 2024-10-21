Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18781E6338
	for <bridge@lists.linux.dev>; Mon, 21 Oct 2024 10:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507783; cv=none; b=Jrj/yb72NBlNhL4baBNfMY7hkIzUKotHshmgnrJJ6uyVNl6hYcPII8qsDO9GqqGiJlAH56vQDheo5tFC/y2C89DxsDG2Zs7u9WAoGgKFKORxPRT9yrd+4KAdf84eWRNZviD7EXdQptsUtwGUwNzdJ0A35PQ7XEc2fRFgJB4W0ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507783; c=relaxed/simple;
	bh=f25VOJ4jl4EZ6U5b3xJzeqopBjiOxy3HcpyoNBkD144=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=t7dvtZ5Hy+tQdqh7YNSmZXUUsoUyWRA5+CUV1g3jXnUSpL9QEkeg/0YKdJwJcE2Iws3C4QM1gC8XrhflSBZ1sFP6rwOKWLXC5a712rLWQR8qctZDmDeDg2cfK3hEH06ePUscFKLmvvAHncVTNkK69KCM3p3MtuIWkcKbP9Xrqy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OKY6yUX0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OKY6yUX0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729507780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zl8NkxhsjOVprDoWW2Qzq8vxlGshkjvvdBctdUvmGdo=;
	b=OKY6yUX0B7vLNczEYoQU/BU0wEFoV4vB0A3ZnGOIIqcOuQO4qvqC8yPXJNURfDkbzdakM/
	eq3GxMU0sjo82MQI/4MaQWqSmBz/dAn48WOE70/yjVKiihD69K40Xr2HmbLN+dPlSQDOox
	6UmzJQ4i9gcjiHBz2t32UqXEaz3jmJo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-ekydAmvlMymsHjxD_Jpf3g-1; Mon, 21 Oct 2024 06:49:39 -0400
X-MC-Unique: ekydAmvlMymsHjxD_Jpf3g-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4315e8e9b1cso20810765e9.1
        for <bridge@lists.linux.dev>; Mon, 21 Oct 2024 03:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729507778; x=1730112578;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zl8NkxhsjOVprDoWW2Qzq8vxlGshkjvvdBctdUvmGdo=;
        b=JQh+3vqCtBwhpHZbM5kDThBoQYZz0HRgSsmvHe5zgmMXn80dlvZDNB4gpJ8sg+XdIG
         CTLi+12HZ5Quo32u0+ykijO86pGyDJmok9/7hRGvTBXpqd2IXjuXeNR3zVK+Wajxbt/e
         Ik6hLTF6Udx3ipZa6sNH169Deq/SZYSGka0RDs3VgRkDlFt307D7S9I1qR6jxIkSoSHf
         HZo/RoHRMxNVQf86WCZer9wV2RzRV896HRJuS0sz+a/oPuNnxV4fwA1hfAXnoW/dbbTO
         ooyc3MObFD2m1HzT7+E1WfW+RGpjTSuCJrFJPmKiw/sUMcg4aaCrJiy6b4IXPh2MwU+x
         SbVg==
X-Forwarded-Encrypted: i=1; AJvYcCWbh/e+ND9WxHgf300d2w1bvkKmBkK99oRyIjyqKK6FyUSkeiUJsitSSeJhAb3EtcyxlxFGNAM=@lists.linux.dev
X-Gm-Message-State: AOJu0YzlyCfJwRkaHaj6bxEoUDek4nzWbcHTpVPXCCvvAHaao+TOveip
	2su+btNhDnBiGGwVOYsjTgbDxgWgE/ZO9XKDbnNJNWFw9N+EGD0jt88HENtB9eWiz5ngL/tMpA2
	IcPCR69PRsn68/7VG78PhP2EhcGuImKLq7FpNjVymkbaJyPaCi7oUow==
X-Received: by 2002:a05:600c:1d27:b0:431:44aa:ee2c with SMTP id 5b1f17b1804b1-4316163bb0bmr68211755e9.9.1729507778222;
        Mon, 21 Oct 2024 03:49:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPmc6ba7ssou9GTOtZg5r3s7a95KOOzPAX+9aC1kAiYD6uc9w3/zs/WO4t3sdTFuEXumAz/A==
X-Received: by 2002:a05:600c:1d27:b0:431:44aa:ee2c with SMTP id 5b1f17b1804b1-4316163bb0bmr68211595e9.9.1729507777852;
        Mon, 21 Oct 2024 03:49:37 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5c2cb8sm53805945e9.31.2024.10.21.03.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 03:49:37 -0700 (PDT)
Message-ID: <f792a828-8a61-4a14-bef8-ff318b5a4ac3@redhat.com>
Date: Mon, 21 Oct 2024 12:49:35 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 07/10] net: ip: make ip_route_input_noref()
 return drop reasons
From: Paolo Abeni <pabeni@redhat.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 dsahern@kernel.org, pablo@netfilter.org, kadlec@netfilter.org,
 roopa@nvidia.com, razor@blackwall.org, gnault@redhat.com,
 bigeasy@linutronix.de, idosch@nvidia.com, ast@kernel.org,
 dongml2@chinatelecom.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, bridge@lists.linux.dev, bpf@vger.kernel.org
References: <20241015140800.159466-1-dongml2@chinatelecom.cn>
 <20241015140800.159466-8-dongml2@chinatelecom.cn>
 <c6e8f053-32bb-4ebd-871b-af416d0b0531@redhat.com>
In-Reply-To: <c6e8f053-32bb-4ebd-871b-af416d0b0531@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/21/24 12:44, Paolo Abeni wrote:
> On 10/15/24 16:07, Menglong Dong wrote:
>> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
>> index e0ca24a58810..a4652f2a103a 100644
>> --- a/net/core/lwt_bpf.c
>> +++ b/net/core/lwt_bpf.c
>> @@ -98,6 +98,7 @@ static int bpf_lwt_input_reroute(struct sk_buff *skb)
>>  		skb_dst_drop(skb);
>>  		err = ip_route_input_noref(skb, iph->daddr, iph->saddr,
>>  					   ip4h_dscp(iph), dev);
>> +		err = err ? -EINVAL : 0;
> 
> Please introduce and use a drop_reason variable here instead of 'err',
> to make it clear the type conversion.

Or even better, collapse the 2 statements:

		err = ip_route_input_noref(skb, iph->daddr, iph->saddr,
				   ip4h_dscp(iph), dev) ? -EINVAL : 0;

There are other places which could use a similar changes.

Thanks,

Paolo

