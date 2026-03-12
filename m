Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B3F347BD4
	for <bridge@lists.linux.dev>; Thu, 12 Mar 2026 09:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773308451; cv=none; b=mBpzURMTAFevVCwUMCdqf+CYHkyOtyCFxBIjt2qEsE7pO/gsiI2HBJY9cG82bG6ykHMnOBvg5nFE3k0HGG9hUkeP/FSzFJHVJ18SB94Op70f8HEEugectZLMghfHYvLSFByoGF/7rD++tAErwHng9vXwuhxFMPrvGxL1e+Uemdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773308451; c=relaxed/simple;
	bh=ddEVo4L1jDTJ75CDuotLTBCt2IwHCurzLzGzvhrGLB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RbmigLvF0dlapTrhpw2t5MW2/suGhecpilnTGWFDqvZwHuQId9fjz7XZ1A/WYhaqCZCfUSN+TqweuGlQdrc+YiCauw1wvOAMbCp2TEM2WUTtQzvlawYMI930EMAGGSeUQxxxOVURGKJ3ena7DRhmtP8tKXdwZ/PtNnL7og+Y+8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=habS9Tvi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="habS9Tvi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773308449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e6EdyD35EC+SpPH1TY5bENOyft6Ge/0pFEQiQDyadAk=;
	b=habS9TvitoXdA0y1Ol2EBDShvBplk6Z9I7msfNJw56LwzALTv28ogf+TP4aGY64qGBQlnc
	x6AUi36K9fjLu3y64VX9m1SJPFkXyKza5MpwVXfOKO/vNmdp5kYZHe909By9qeN/uCMg1b
	2KwPMaHAJBtVm0/6ILBOMt2oh5zXen0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-bF7i2gZ3MOKcRSOuF8RpCA-1; Thu, 12 Mar 2026 05:40:48 -0400
X-MC-Unique: bF7i2gZ3MOKcRSOuF8RpCA-1
X-Mimecast-MFC-AGG-ID: bF7i2gZ3MOKcRSOuF8RpCA_1773308447
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-439a9182148so507451f8f.2
        for <bridge@lists.linux.dev>; Thu, 12 Mar 2026 02:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773308447; x=1773913247;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e6EdyD35EC+SpPH1TY5bENOyft6Ge/0pFEQiQDyadAk=;
        b=KIHyt/fRjHBVeaXKdNx8UP/+tifA6hdYBi7Omz/J2YRkuVGntTox3dncsb2FUXvUPh
         yy4rfpAWstStcHE5n/kji4ltiUYO8xqxr95oTZRYEGBmHMSx5c9dPL1gPZudgU9YNDMw
         lXJX4WQSIhrlqd0nElXMuPyVnNybkB642X5KDwDJtRcXwPTcJnIBkOQ3rtr/LRQlqpVJ
         NY2C5PoVra/DEdMJT+8iySxn5Ex/2i9CeBw711Q1b+oi5GoZ/VAcVJJjO3ICWY9Vku0k
         81cmpEnG+s7ZtRIiSKyGcC1W38DZ0AyOSm1RUgtaUUuq07WJsqTo/x091PcPgQoZSZU4
         NFjA==
X-Forwarded-Encrypted: i=1; AJvYcCX8Ap7Z5s/SPCCpL3KqA+Epm5lTNEm9Ef8uJKLYs1j/qb3lb3IRGD+PbPvmvtXSAhVcIToxNgg=@lists.linux.dev
X-Gm-Message-State: AOJu0YyreiPRC7pz1cEpXujM087ihQb5S6/HK73b8d/IXsBgKFtVHBdP
	krSxaAe5H+K0GaPBZ+wR37isAzs/Z5XHvCPDpqrTPI1c19BKk/7rlIUbjlLingRyA3IsY8nbF0w
	UsXNPfUVq9oVw/f0uJGPO9yoyNHCRKl9MSIXbhNNkbOvCtLV34sCGhTaBxQ==
X-Gm-Gg: ATEYQzxd0ivtQKUGiO2inlPXnS7MGoYOFfYei1jpaSA+HhaxFB+mehqCggDOHPfNATA
	vhLQp71U8jweUFhQ8w8VtZJW2Qw/0vwiCt8yWoT9FJ2cy5zUJgVzQVlHW7LlYB/97rHfQwdB6c0
	Rw6o9NtDO+pH4Q4QVT/3UqHC/GRmCd3J1YpS3G8rLatb/ydwsOBLGb+BHDfRpmKQI7ExgwtYxOK
	o5OA7lJreEhhPjYmTFIpjgGQrkOjKwFmBQdIrLiZ70zoyszzQVlfHoc5RaCYEMualMV5D4q1lKR
	LAcUp7krJPM3jex5qnzdEEkY6c7qvkc0w+ZZLOOnWN7JIGiKHE2ySnmzT1DX73jNwMf9EIWk0hv
	lbKqlT4n11P2hELjPxE8tBaeZ+YR8CtE8cXbcNQuTBJhTqXYhE92vujg=
X-Received: by 2002:a05:6000:228a:b0:439:ca64:967c with SMTP id ffacd0b85a97d-439f822b9d9mr9932350f8f.44.1773308446726;
        Thu, 12 Mar 2026 02:40:46 -0700 (PDT)
X-Received: by 2002:a05:6000:228a:b0:439:ca64:967c with SMTP id ffacd0b85a97d-439f822b9d9mr9932296f8f.44.1773308446263;
        Thu, 12 Mar 2026 02:40:46 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe22f3a4sm7155566f8f.38.2026.03.12.02.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 02:40:45 -0700 (PDT)
Message-ID: <bcc536ac-dde1-4b63-8fed-70850818472b@redhat.com>
Date: Thu, 12 Mar 2026 10:40:43 +0100
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot ci] Re: net: move netdev_compute_master_upper_features to
 ndo_set_features
To: Sabrina Dubroca <sd@queasysnail.net>, Hangbin Liu <liuhangbin@gmail.com>
Cc: syzbot ci <syzbot+ci098fa7c1795eceac@syzkaller.appspotmail.com>,
 andrew@lunn.ch, bridge@lists.linux.dev, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, idosch@nvidia.com, jiri@resnulli.us,
 jv@jvosburgh.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, razor@blackwall.org, sridhar.samudrala@intel.com,
 syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
References: <20260310-offload_compute-v1-0-3df79c09ea65@gmail.com>
 <69b04e91.a70a0220.51e36.0000.GAE@google.com> <abBuLV3P6aTzUg3W@krikkit>
 <abC7rdjxv9ENw-tA@fedora> <abHcP3GTO29rfKML@krikkit>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <abHcP3GTO29rfKML@krikkit>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -aI9FajIwrWlKKeV8-rFD7RRAF41vQadhWBJ2YS8hqE_1773308447
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/26 10:18 PM, Sabrina Dubroca wrote:
> 2026-03-11, 00:47:41 +0000, Hangbin Liu wrote:
>> On Tue, Mar 10, 2026 at 08:17:01PM +0100, Sabrina Dubroca wrote:
>>> 2026-03-10, 10:02:09 -0700, syzbot ci wrote:
>>>> batman_adv: batadv0: Not using interface batadv_slave_1 (retrying later): interface not active
>>>> hsr_slave_0: entered promiscuous mode
>>>> hsr_slave_1: entered promiscuous mode
>>>> ------------[ cut here ]------------
>>>> err == -EMSGSIZE
>>>> WARNING: net/core/rtnetlink.c:4421 at rtmsg_ifinfo_build_skb+0x218/0x260, CPU#0: syz-executor/6496
>>>
>>> I'm not sure this one is caused by this series, but either way,
>>
>>
>>  rtnetlink_event+0x1b7/0x270
>>  notifier_call_chain+0x1be/0x400
>>  netdev_change_features+0x95/0xe0
>>  __netdev_upper_dev_link+0xb20/0xc80
>>  netdev_upper_dev_link+0xb0/0x100
>>
>>
>> This patch calls netdev_change_features() after __netdev_upper_dev_link(),
>> Which trigger a NETDEV_FEAT_CHANGE notify and calls rtmsg_ifinfo_event()
>> to fill the new link info. Maybe the event is a bit early and macsec has
>> data not ready?
> 
> But this would still mean that there's a mismatch between
> if_nlmsg_size() and rtnl_fill_ifinfo(), and your patch is only
> revealing it.
> 
> I'll send fixes for the stuff I mentioned, no idea if that's what
> syzbot saw since we don't have a repro.

It looks like even the nipa CI is reproducing the issue, i.e.:

https://netdev-ctrl.bots.linux.dev/logs/vmksft/net-dbg/results/554921/17-rtnetlink-sh/

more failures here:

https://netdev.bots.linux.dev/contest.html?pw-n=0&branch=net-next-2026-03-12--06-00&pw-n=0&pass=0

the fail in mascsec-offload looks quite deterministic, could you please
have a look?

/P

