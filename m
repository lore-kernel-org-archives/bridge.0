Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE4E1D12EB
	for <bridge@lists.linux.dev>; Tue,  8 Oct 2024 14:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398749; cv=none; b=R9tQFpZBLKWYp7EGUUDSWYEHqREjzXVeXl0RKeU3cJvcANIGEL8+8P2nIo8xXkVhAQy+gOOrofIKPSp21ja2OkQbaBUY2BJd7MmpQGsC69z3nCqT+u9Z21VB0o8ODLEZ4PsxeNUSEzFkRV+Koa0VQFsMj6CUw67dVJfLH0AVP2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398749; c=relaxed/simple;
	bh=OEPIoOSafXbHth2X0cZbo48ef5bM+/sWgUUWroovlLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hrJDLz71qRNWLZw+ViiMlRXfZJuiLjaulNi7KemEU7ZOL4RWXzVtbwmb3KxsIY5wqBXbdwllbl69X1dxp2OlX07aYT0wa0QkAbIrZ6/CGZ/718PGFPT2FVAyCdnFcaX4Xs100JcAgcguDCePyTa4aBJTc2ftjb41H/7Vr8JLtno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=wb7MBK68; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="wb7MBK68"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d375ddfc0so261448f8f.2
        for <bridge@lists.linux.dev>; Tue, 08 Oct 2024 07:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1728398746; x=1729003546; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gyA0o4MkgtBHEt4wv5eC/jzDocCl8Fg8KhFwA03Dsp8=;
        b=wb7MBK68+LE2zG9RflpM/bIdPynQ4zTxwUy9OEXnUoRZULqu4aT0syBv7d7icgcjid
         Pp4DN0l2V7Xw2iuOUwoS/nXK3N+becLM1207r0Kv4oeUFuUxjTUJf9QpxUVZHj3dhfmL
         i7EdreKZ90I2SI/3QQhukcUnqTgclGaMCMztD5WHwQPTpv64cXsDTeP63BZ2MFu1WPJh
         SiybuYapVZ4yf6apHe/I8Wu4ZHLZ8NzgCndqZxX42kRlZZiP71Xcjh8uwZa7tA3UN86d
         0pCQU7BkXlv0nO1iwkrg9p2Wmm2GyH6TtuLrjofyHJbb2xxWg+egnZQV9pz/f88LKEgj
         VQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728398746; x=1729003546;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gyA0o4MkgtBHEt4wv5eC/jzDocCl8Fg8KhFwA03Dsp8=;
        b=RdNEBbJmSifu0Xbr/+HoNXjo4MNoN2hBizdhTm1hVKS/88TBsfkWh2sDgXADdHPCCl
         qf8tmhlZLd/J+0U/lhRZasV8l5WngG13TdI4fGYEkmbQ9ZoEhQumQu+eHN1HEdbAXotA
         oQZW9gkcp/K8Ra/Ya3V4tQ4BVVhptrGI/K4v6ur4/0OeNLLYjk/eHTWkdjB9JEMZ0CpS
         JqZwfuNNqhG7vve6LkYBT14goGHJatvosUTkmcBOAMgxYS9tX8QtPEEpxDwWuAFgg79s
         2XXp0z60ohO280r4q9mS5zMC6Nyiso0bsACRnqSuMG0DMmcUSbgJtpEsVPsFpXyQsdGe
         pDsA==
X-Forwarded-Encrypted: i=1; AJvYcCW7jkBFBrZgSFVlcI7OzDQ+jhh9d3E9XaJ/ud/47znwWqVVz+H/11XyIjoIwEhvnSxF/w69VIA=@lists.linux.dev
X-Gm-Message-State: AOJu0YxMvelL0e8RuwHR0rC4ApXeM2WixWUEC9aY2ptbZZj8pcyXibfs
	dUIYx59ckqNUixacsk6khWRjy320/E7snAGBsfZYPnOlX5ea4+0yYbTiwuny4Xg=
X-Google-Smtp-Source: AGHT+IHnpqRbMJPQQ/KRJ6k8Ul3NfjlAwYMFqUBQC1j92wKGfsiXs0AaFgp4Y7hJhUm28QP/eeU1yQ==
X-Received: by 2002:a5d:5c88:0:b0:37d:370a:5248 with SMTP id ffacd0b85a97d-37d370a5384mr837280f8f.39.1728398746139;
        Tue, 08 Oct 2024 07:45:46 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1697024fsm8246403f8f.95.2024.10.08.07.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 07:45:45 -0700 (PDT)
Message-ID: <8f285237-757b-4637-a76d-a35f27e4e748@blackwall.org>
Date: Tue, 8 Oct 2024 17:45:44 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bridge: use promisc arg instead of skb flags
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Amedeo Baragiola <ingamedeo@gmail.com>, Roopa Prabhu <roopa@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241005014514.1541240-1-ingamedeo@gmail.com>
 <c06d9227-dcac-4131-9c2d-83dace086a5d@blackwall.org>
 <ZwVCC3DYWw0aiOcJ@calendula>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ZwVCC3DYWw0aiOcJ@calendula>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/10/2024 17:30, Pablo Neira Ayuso wrote:
> Hi Nikolay,
> 
> On Sat, Oct 05, 2024 at 05:06:56PM +0300, Nikolay Aleksandrov wrote:
>> On 05/10/2024 04:44, Amedeo Baragiola wrote:
>>> Since commit 751de2012eaf ("netfilter: br_netfilter: skip conntrack input hook for promisc packets")
>>> a second argument (promisc) has been added to br_pass_frame_up which
>>> represents whether the interface is in promiscuous mode. However,
>>> internally - in one remaining case - br_pass_frame_up checks the device
>>> flags derived from skb instead of the argument being passed in.
>>> This one-line changes addresses this inconsistency.
>>>
>>> Signed-off-by: Amedeo Baragiola <ingamedeo@gmail.com>
>>> ---
>>>  net/bridge/br_input.c | 3 +--
>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
>>> index ceaa5a89b947..156c18f42fa3 100644
>>> --- a/net/bridge/br_input.c
>>> +++ b/net/bridge/br_input.c
>>> @@ -50,8 +50,7 @@ static int br_pass_frame_up(struct sk_buff *skb, bool promisc)
>>>  	 * packet is allowed except in promisc mode when someone
>>>  	 * may be running packet capture.
>>>  	 */
>>> -	if (!(brdev->flags & IFF_PROMISC) &&
>>> -	    !br_allowed_egress(vg, skb)) {
>>> +	if (!promisc && !br_allowed_egress(vg, skb)) {
>>>  		kfree_skb(skb);
>>>  		return NET_RX_DROP;
>>>  	}
>>
>> This is subtle, but it does change behaviour when a BR_FDB_LOCAL dst
>> is found it will always drop the traffic after this patch (w/ promisc) if it
>> doesn't pass br_allowed_egress(). It would've been allowed before, but current
>> situation does make the patch promisc bit inconsistent, i.e. we get
>> there because of BR_FDB_LOCAL regardless of the promisc flag.
>>
>> Because we can have a BR_FDB_LOCAL dst and still pass up such skb because of
>> the flag instead of local_rcv (see br_br_handle_frame_finish()).
>>
>> CCing also Pablo for a second pair of eyes and as the original patch
>> author. :)
>>
>> Pablo WDYT?
>>
>> Just FYI we definitely want to see all traffic if promisc is set, so
>> this patch is a no-go.
> 
> promisc is always _false_ for BR_FDB_LOCAL dst:
> 
>         if (dst) {
>                 unsigned long now = jiffies;
> 
>                 if (test_bit(BR_FDB_LOCAL, &dst->flags))
>                         return br_pass_frame_up(skb, false);
> 
>                 ...
>         }
> 
>         if (local_rcv)
>                 return br_pass_frame_up(skb, promisc);
> 
>>> -	if (!(brdev->flags & IFF_PROMISC) &&
>>> -	    !br_allowed_egress(vg, skb)) {
>>> +	if (!promisc && !br_allowed_egress(vg, skb)) {
> 
> Then, this is not equivalent.
> 
> But, why is br_allowed_egress() skipped depending on brdev->flags & IFF_PROMISC?
> 
> I mean, how does this combination work?
> 
> BR_FDB_LOCAL dst AND (brdev->flags & IFF_PROMISC) AND BR_INPUT_SKB_CB(skb)->vlan_filtered

The bridge should see all packets come up if promisc flag is set, regardless if the
vlan exists or not, so br_allowed_egress() is skipped entirely. As I commented
separately the patch changes that behaviour and suddenly these packets
(BR_FDB_LOCAL fdb + promisc bit set on the bridge dev) won't be sent up to
the bridge. I think the current code should stay as-is, but wanted to get
your opinion if we can still hit the warning that was fixed because we can
still hit that code with a BR_FDB_LOCAL dst with promisc flag set and
the promisc flag will be == false in that case.






