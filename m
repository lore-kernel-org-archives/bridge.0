Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE54D388E62
	for <bridge@lists.linux.dev>; Tue, 18 Aug 2026 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064360; cv=none; b=GiriTUYQydmLVFSv56KTTr58bh4gPZMPYNuKIdDisUtcncDMD4dO6TO3dUpuk4rIHyvJxxg6Se1SdL5h2a9PUWzXvPU0v9wUMCs3TXwPPYPwKqQ5uAEh5IaWbtHOS1rZlurX22WZCAS/8ahF5OMg8jTutSwfNnLwLGJcZY8sHwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064360; c=relaxed/simple;
	bh=0FQbJHW7AurjhwQOLkDMV+ncEldqI856h0Ld9RBIa2U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=o63nTKMpvuAF3qMR/yhWrQN31YueV9lzz1i+7etHrQbg1ToiQtQqcjin9wL0zXNBTei+MWtdV7+y4Mbq01Kk/nDeoT9YOzFNPf2Ox0PDg9k4y6wYW9bERJE3hvmUooqpPjn8/TpsRqLqgvLEdF+mRu3XBDopfq7lR7/m6jsKjks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=YYJfop2x; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="YYJfop2x"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-476a130c138so4863223f8f.0
        for <bridge@lists.linux.dev>; Tue, 18 Aug 2026 07:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1787064357; x=1787669157; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=75cy4pdMpPQco440xxfjThx3YDct50m5fV83t3H3aRA=;
        b=YYJfop2xjJRZjMO8yKglCs4INGH47fWRRQKYEkYUsqmgYdco4+itpAAAn24Re2RVhf
         ghb0A5Xy0+fKlokJljWmN+QJ8Rc3vWgNWbNYRiaUVyKBU66P6O3mFFZPTQDBx0t3ZWGi
         +BmI7PfhFTjqyqxFeSTtXifkkZsPnL/d/14/QPmrnMW83QsTY2S31BvuJ1GojhPYi0jZ
         Qqq9x9fImfciw1gclQw7wf7sIORL+BMlVNFvAESHDlPSIQVgS3Lbxws13Xi3W/5Z+8ds
         H8fYDyA0HhmhgCCbhm06K0SHJkqPynPDIyt/T8ANgvtO0V4vTHUW6NGwxqvBUSAwRp/T
         QNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787064357; x=1787669157;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=75cy4pdMpPQco440xxfjThx3YDct50m5fV83t3H3aRA=;
        b=PETdzI0JNjLNA7oeuTn04WPNadhuzN4zivorrwN5fL0NZs415EE6bVmVFcJFPMf8WA
         e3DSt/91DApLEnBkoIlTn9hhYz0xFfITTsZaVRd+MB6pdPv4nZX4bwnVpjnWbXYtbNFs
         aFQMgCmgeaMV8/7JS5rSpKMbd/jvgwvAzLWEhl4hYTRHU9ew7ueSGl6UATVGBlG+9nYB
         uoxc/WykbwZjygpRph48xbW/HnUxJZRxFEw1z68mkHNhO0/K150g/Jd/5ya8Xsr26hXP
         6TbymkvTI8uD+D5WSWpf58M3WKorrIPKK88z2U8aE+xdLsBi7kfRcuoM7wGswoKI9CfP
         m/7A==
X-Forwarded-Encrypted: i=1; AHgh+Rr1cxcRQiSgf4hcZQyKtMlnDaA3q+DmxMtlpZ+hsgXZK08AXMTrzQXwalKJNjP4rfCYm6FmxP8=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx37/uQc8ixi4NT052/4dJywcELt+5aMaJu9VpG0jR6Mx74H+UW
	jMp8p5Kk0HV8udOnQ+7IrzUOY4NPqLLenzaP7hLy2gJqkyzraC7GNqNGZ7QdfV+vvmQ=
X-Gm-Gg: AR+sD13ll3/H02LfgZPtcSRZQBS/RxGrsVZZyxNCVu2elZTHEsPamMviRGxoLTvfeVg
	Z0MUJX3j9WcVrgeIPBWLNjPpyMMMXyFmmb/GSpBjzL0OP0bdiDRR9RPWao0pEtSU0tL4EhQxMW3
	/QeoDKvhBlwkTny1JXKR9a2DTAYMNlebkvaAFyJrXcyohWZYulqAQKmyiz/YR+dvIwN0VTmoSZq
	A0x2kVjGUIup5Ox1bEj8oYyd/Xs84ZPishtddrNTNoTm2pWgjkzZkLRP3jjwXHV+U00hkH5TAR9
	qTEjK38ERm6IbHVqI4C1Sty/ynbGSL7QdpSKOULBu8Q+stpXXQDIiDeB9QlN54Gq6VuFjCdKDkO
	QthgWxGHhu3WoEvZlOEX1PGUyxejtVJXhIkoPr7NRh8soJv+W+u1y+wL1blCCkiXKf7xFqYYS6a
	UnwbI7ApJ8Iglk+TQNvljddjr0SM0Fu7gC31qFjjCRjHxHmwAtYpV7721IO0Ccq4/4OM2eJ+9sI
	EQJushCuI3UFYmBkbiB/nd9gVYlHg==
X-Received: by 2002:a05:6000:46cc:b0:47f:f3f9:ae37 with SMTP id ffacd0b85a97d-48160705704mr38770799f8f.7.1787064356707;
        Tue, 18 Aug 2026 07:45:56 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a3158asm12955103f8f.7.2026.08.18.07.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 07:45:56 -0700 (PDT)
Message-ID: <c1e62798-d1ab-4ec7-b50f-c54b360f96bd@blackwall.org>
Date: Tue, 18 Aug 2026 17:45:55 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/2] bridge/vxlan: fix reading neigh ha without
 synchronization
Content-Language: en-US, bg
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, roopa@nvidia.com,
 bridge@lists.linux.dev, andrew+netdev@lunn.ch
References: <20260817143613.685769-1-razor@blackwall.org>
 <0543351c-2c7f-48db-891b-4d8a60776b3d@blackwall.org>
In-Reply-To: <0543351c-2c7f-48db-891b-4d8a60776b3d@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/08/2026 18:25, Nikolay Aleksandrov wrote:
> On 17/08/2026 17:36, Nikolay Aleksandrov wrote:
>> Hi,
>> Neigh ha address must be read using the seqlock to get a stable snapshot.
>> Both the bridge and vxlan read it directly and can see partial updates.
>> I reproduced both issues with running neigh updates and exercising these
>> paths in parallel and saw partial addresses, e.g. updating between
>> neigh A: 02:00:00:00:00:00 neigh B: fe:ff:ff:ff:ff:ff was able to observe
>> 02:00:ff:ff:ff:ff and fe:ff:00:00:00:00 in packets. Noticed this initially
>> in the bridge, then checked vxlan and its arp/neigh_reduce functions have
>> the same bug, route_shortcircuit is doing the right thing already.
>>
>> Cheers,
>>   Nik
>>
>> Nikolay Aleksandrov (2):
>>    net: bridge: arp/nd proxy: fix reading neigh ha
>>    vxlan: fix reading neigh ha
>>
>>   drivers/net/vxlan/vxlan_core.c | 20 +++++++++++++-------
>>   net/bridge/br_arp_nd_proxy.c   | 24 ++++++++++++++----------
>>   2 files changed, 27 insertions(+), 17 deletions(-)
>>
> 
> (-CC bouncing emails)
> 
> Hmm perhaps it's better to use ETH_ALEN instead of MAX_ADDR_LEN to explicitly
> show the expected len everywhere, it cannot be different anyway.
> I'll do it for v2 after 24h.
> 
> Cheers,
>   Nik
> 
> 
> 

Sashiko brought up valid alignment questions (ether_addr_copy expects 2-byte align).
I'll fix that up before sending v2.

Thanks,
  Nik

