Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178D51F4FC2
	for <bridge@lists.linux.dev>; Fri, 11 Oct 2024 06:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728629183; cv=none; b=o58m4b26mtc4fwmhhmC3CENFQzshbxKvDkRH8KhEAeqm2jm/tE126bgpbykzSmtGAW+tUSI/rqcC6g5uFF5XkbWTw/K/CTFqv3J9TKwYqHey8B/pjJAZ0D0+FLaURLMfAAG8w/brpFcm9TY2KEgqRd1ZRBJsa8/AiA34UAM/m/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728629183; c=relaxed/simple;
	bh=AEJZCH5SmAg2ybzZzH0bZgBAbTh2RrGU19StDW8noJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NRfgjwUKj0zYw6g1gAgHxFJJhCIT8dI0fs43TDsjpTEw4aInTszdMLVQVhO7IONbLzVYGe0Y2ul6iO/wP+cwPyUtUFgbO1tr9XkW9XY5KDxrHKPwg7edKdraomkwRibdYzlbwT2uQsd6J9mMkYh3Z4bySJzYMJYXOjJl5dKJGY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=pUGtBBrX; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="pUGtBBrX"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a995f56ea2dso269711166b.1
        for <bridge@lists.linux.dev>; Thu, 10 Oct 2024 23:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1728629179; x=1729233979; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6GOWm4Ez93j7w3ubgDJn8cAypKzj1qTyE1Gp4WKBx7g=;
        b=pUGtBBrXSiBXVXSAWqaZZnWLsQ3Q5m+mkSAHny+lySi/D6YXd27bRK3IRH8keL4DxD
         iQun1KbVp/vgk9+drhiXzrfvYuuyOIrjLZg7j/Hk68txHT97EFlu4QCYxxqi2i54TH3H
         WedPk5IEy0qlUMbvKuXwRlV2YBXj20eROy07VDKr8A/Pidrehs6bF4pfASBc6ZTLFHrb
         4UP/N8/j/bW0Kugzru5PzyLBi259KIvshCSSaHdEyliQEtJ4Eb52aXW9MGk3eOIrUbSI
         Nu4+yyaswGy+avaSfC5lUYaK5+p5axwb0PZC79vigOGxVU1eAfY0nZuLPeg2CfYMM7XV
         epwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728629179; x=1729233979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6GOWm4Ez93j7w3ubgDJn8cAypKzj1qTyE1Gp4WKBx7g=;
        b=PhCtwFU5brTc8WDYhnhqqodY0H+IVTyTFqc+oNQg9XuvlS9RHmweTec6fnW3/0vYqs
         T4Xt3j7TBjxtirtSv/K9CTzfZe4Ti7JAqdThKeBj5Rfu6bsy/7L9aKAzoBFKZQv7DxkM
         Vo13ixNA6jTa9o/vt4/k3/ucO170O8Zc/9P8FDbP82nIKCeHauVRvwEplhJi/wyUNRqD
         PfJ1nm/dPNCZOjoyWDCPTDgnFaSonijiv7feE8i05asfz6JkeuRL8tAMstg9ThN3ANxW
         2gkVT7DEy0PnVO15SJSqF2q/V9bQR0JWWGsyqNidffIL3cZoMEW80iZZqyGq6NInNwc3
         5exw==
X-Forwarded-Encrypted: i=1; AJvYcCWlhGY6byNPPHpqlfmoxgnK7hioVCyYM/akT+v2i1fGMt7zmBOlzcYmlJbUgIYDxx2hDRliEjo=@lists.linux.dev
X-Gm-Message-State: AOJu0YzcH9hNXYSQoMNVugYAqz1Bw9dgPnuYAjmQCAzDiqNTxMEGLJ8/
	4RGureBWQpNLDCbCs4/fLrl4raD+b6zxJgicb5KaP6CjnfHQIJk0QfJ7qAeehuA=
X-Google-Smtp-Source: AGHT+IEzuJ8la1znR5wLTnUyCcTrPupabLqIjUuyNTVH+msXYchYUvqgyfXMo/4f3fgzmWTAWOExYQ==
X-Received: by 2002:a17:907:d599:b0:a99:5773:3612 with SMTP id a640c23a62f3a-a99b93d4235mr119056166b.36.1728629179096;
        Thu, 10 Oct 2024 23:46:19 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7edde0fsm176951666b.40.2024.10.10.23.46.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 23:46:18 -0700 (PDT)
Message-ID: <de96919b-c4c2-4ee3-b114-a575fe61701b@blackwall.org>
Date: Fri, 11 Oct 2024 09:46:17 +0300
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
 <8f285237-757b-4637-a76d-a35f27e4e748@blackwall.org>
 <ZwVTUt_ie0sMsjbk@calendula>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ZwVTUt_ie0sMsjbk@calendula>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/10/2024 18:44, Pablo Neira Ayuso wrote:
> On Tue, Oct 08, 2024 at 05:45:44PM +0300, Nikolay Aleksandrov wrote:
>> On 08/10/2024 17:30, Pablo Neira Ayuso wrote:
>>> Hi Nikolay,
>>>
>>> On Sat, Oct 05, 2024 at 05:06:56PM +0300, Nikolay Aleksandrov wrote:
>>>> On 05/10/2024 04:44, Amedeo Baragiola wrote:
>>>>> Since commit 751de2012eaf ("netfilter: br_netfilter: skip conntrack input hook for promisc packets")
>>>>> a second argument (promisc) has been added to br_pass_frame_up which
>>>>> represents whether the interface is in promiscuous mode. However,
>>>>> internally - in one remaining case - br_pass_frame_up checks the device
>>>>> flags derived from skb instead of the argument being passed in.
>>>>> This one-line changes addresses this inconsistency.
>>>>>
>>>>> Signed-off-by: Amedeo Baragiola <ingamedeo@gmail.com>
>>>>> ---
>>>>>  net/bridge/br_input.c | 3 +--
>>>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
>>>>> index ceaa5a89b947..156c18f42fa3 100644
>>>>> --- a/net/bridge/br_input.c
>>>>> +++ b/net/bridge/br_input.c
>>>>> @@ -50,8 +50,7 @@ static int br_pass_frame_up(struct sk_buff *skb, bool promisc)
>>>>>  	 * packet is allowed except in promisc mode when someone
>>>>>  	 * may be running packet capture.
>>>>>  	 */
>>>>> -	if (!(brdev->flags & IFF_PROMISC) &&
>>>>> -	    !br_allowed_egress(vg, skb)) {
>>>>> +	if (!promisc && !br_allowed_egress(vg, skb)) {
>>>>>  		kfree_skb(skb);
>>>>>  		return NET_RX_DROP;
>>>>>  	}
>>>>
>>>> This is subtle, but it does change behaviour when a BR_FDB_LOCAL dst
>>>> is found it will always drop the traffic after this patch (w/ promisc) if it
>>>> doesn't pass br_allowed_egress(). It would've been allowed before, but current
>>>> situation does make the patch promisc bit inconsistent, i.e. we get
>>>> there because of BR_FDB_LOCAL regardless of the promisc flag.
>>>>
>>>> Because we can have a BR_FDB_LOCAL dst and still pass up such skb because of
>>>> the flag instead of local_rcv (see br_br_handle_frame_finish()).
>>>>
>>>> CCing also Pablo for a second pair of eyes and as the original patch
>>>> author. :)
>>>>
>>>> Pablo WDYT?
>>>>
>>>> Just FYI we definitely want to see all traffic if promisc is set, so
>>>> this patch is a no-go.
>>>
>>> promisc is always _false_ for BR_FDB_LOCAL dst:
>>>
>>>         if (dst) {
>>>                 unsigned long now = jiffies;
>>>
>>>                 if (test_bit(BR_FDB_LOCAL, &dst->flags))
>>>                         return br_pass_frame_up(skb, false);
>>>
>>>                 ...
>>>         }
>>>
>>>         if (local_rcv)
>>>                 return br_pass_frame_up(skb, promisc);
>>>
>>>>> -	if (!(brdev->flags & IFF_PROMISC) &&
>>>>> -	    !br_allowed_egress(vg, skb)) {
>>>>> +	if (!promisc && !br_allowed_egress(vg, skb)) {
>>>
>>> Then, this is not equivalent.
>>>
>>> But, why is br_allowed_egress() skipped depending on brdev->flags & IFF_PROMISC?
>>>
>>> I mean, how does this combination work?
>>>
>>> BR_FDB_LOCAL dst AND (brdev->flags & IFF_PROMISC) AND BR_INPUT_SKB_CB(skb)->vlan_filtered
>>
>> The bridge should see all packets come up if promisc flag is set, regardless if the
>> vlan exists or not, so br_allowed_egress() is skipped entirely.
> 
> I see, but does this defeat the purpose of the vlan bridge filtering
> for BR_FDB_LOCAL dst while IFF_PROMISC is on?
> 

Yes, it does, but it is expected behaviour with promisc on.

>> As I commented separately the patch changes that behaviour and
>> suddenly these packets (BR_FDB_LOCAL fdb + promisc bit set on the
>> bridge dev) won't be sent up to the bridge.
> 
> I agree this proposed patch does not improve the situation.
> 
>> I think the current code should stay as-is, but wanted to get your
>> opinion if we can still hit the warning that was fixed because we
>> can still hit that code with a BR_FDB_LOCAL dst with promisc flag
>> set and the promisc flag will be == false in that case.
> 
> Packets with BR_FDB_LOCAL dst are unicast packets but
> skb->pkt_type != PACKET_HOST?

BR_FDB_LOCAL just marks the skb to be passed up the stack (terminated
locally) with the bridge device set in skb->dev, it may or may not be PACKET_HOST.


