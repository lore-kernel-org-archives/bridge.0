Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832E7155CBD
	for <bridge@lists.linux.dev>; Tue, 27 Aug 2024 11:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724756628; cv=none; b=MtKv8uP9u4Q5O/IZWeozmeOvnLza0n02gN9PG7RQjCq2A+X69hPMqVI/qquSyxcOd5+sHAJUrzGnuzS19tumHQBe1/wAcfLpvMlDn4taxUQKG2EjAEjEqZNFWRziubq3GBOYJw6LovWZPmmAlNCCbdXoocIA7JlWgYSQwB2ICo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724756628; c=relaxed/simple;
	bh=A+MNWj+OQxto9jsh0jURUa7HxhqCaOn/gLNcSl4YUqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nA43qeOgceFMDr4SsZ+cWBsMSuwlk46zxVpwiiXf0LKSfUSeFoTplg3IojYkRaZoXL8iTQjik9ClZWKxzQ4aAxi/zwwfw5mc4OWyT8tkHyu2RrF99seKs9AJZvEjvHSLwnM4fj9AN3PLzMwr5r76LAi8ZOegENSWsu3iLSvY4VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PolZGFR2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PolZGFR2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724756625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UgSQAdyFzCk1B7hAbRKds1KXjrwE0OwyWBIAVqcPcqY=;
	b=PolZGFR292+kEKPTsYAPNtWevC0p8cU6y7io+Uumh6+M3UAuaQ+X5C9gMXHFITptXzZWGc
	DCi5FtlM/MJexMpqZZDZU5Xmnjy9TALajCP+KPuHS3AcbllZV6dc3iSkIuL42bYUddfOLO
	dAVnqRS7TxttkIyn8dDoTWXliD5BZHs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595--imySQfMNGWmhRv_Tpd4nA-1; Tue, 27 Aug 2024 07:03:44 -0400
X-MC-Unique: -imySQfMNGWmhRv_Tpd4nA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-428076fef5dso47235245e9.2
        for <bridge@lists.linux.dev>; Tue, 27 Aug 2024 04:03:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724756623; x=1725361423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UgSQAdyFzCk1B7hAbRKds1KXjrwE0OwyWBIAVqcPcqY=;
        b=j6bRIQkbVW9Ye+oZhT4wG1dXbRIuLstuAF1qcL7fKlnQ8jtXn8nyIrqogBjgFoODp3
         FHwlWZlmo63PFQGeTHUdcdmhXIiWdJfBnMrcA93LILhGROu2EbxgpoXvZ1ukjvurhkeB
         eXCPFNLHXqRDiY4S7ZOOeh4340rcDQJuNPHf+aANLmsXgAvoXra1uomnf6XU1xXhm6ZX
         sFqEbP1NW00/2h/xJOKfU2Cx5dwjJQVDqBAC4wQ1YGJwYy2JS5rWTjjSMbcafxgv1Hkz
         wuN0RdnOOIznOrL/27yuXLHWUuCj83D9wEs52qbxipQD6aF838FsE7pVOci4qOO/ZBvJ
         iOYA==
X-Gm-Message-State: AOJu0YwFmA9M3TbARglgcXaSggIhMwxf9MnI7cKUijOXyzWs9U/5P1qK
	OmAav6dtdebRWMQk9XHGZf908BvmAa50tE7HM2iWzVfI6nh2/VwCBLQKGbK6M+ANIpIG7ih6XnW
	rWrB2IiO7sbjXQjrZziSPi7vYsp7lQw8vFAy810J/rhvjB9gAimsEgg==
X-Received: by 2002:a05:600c:1906:b0:426:5416:67e0 with SMTP id 5b1f17b1804b1-42acca0228fmr88165295e9.31.1724756622871;
        Tue, 27 Aug 2024 04:03:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5rXVSWLGAoMAVG7lpEUZCl6uE3GH7MnHGgSFiGY/SippMRXHtMs4XqJiD5ahbRzNGg7baFg==
X-Received: by 2002:a05:600c:1906:b0:426:5416:67e0 with SMTP id 5b1f17b1804b1-42acca0228fmr88165075e9.31.1724756622350;
        Tue, 27 Aug 2024 04:03:42 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b67:7410::f71? ([2a0d:3344:1b67:7410::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42b9e7b7f87sm12193365e9.1.2024.08.27.04.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 04:03:41 -0700 (PDT)
Message-ID: <a7a33be8-6ef6-402e-b821-8ce9d4620a1b@redhat.com>
Date: Tue, 27 Aug 2024 13:03:40 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: bridge: fix switchdev host mdb entry updates
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
 Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: bridge@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240822163836.67061-1-nbd@nbd.name>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240822163836.67061-1-nbd@nbd.name>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 8/22/24 18:38, Felix Fietkau wrote:
> When a mdb entry is removed, the bridge switchdev code can issue a
> switchdev_port_obj_del call for a port that was not offloaded.
> 
> This leads to an imbalance in switchdev_port_obj_add/del calls, since
> br_switchdev_mdb_replay has not been called for the port before.
> 
> This can lead to potential multicast forwarding issues and messages such as:
> mt7915e 0000:01:00.0 wl1-ap0: Failed to del Host Multicast Database entry
> 	(object id=3) with error: -ENOENT (-2).
> 
> Fix this issue by checking the port offload status when iterating over
> lower devs.
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

This looks like a fix suitable for the net tree and deserving a fixes 
tag. Could you please repost adding both the target tree prefix and tag?

Thanks,

Paolo

