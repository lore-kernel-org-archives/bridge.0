Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5550648C3E3
	for <bridge@lists.linux.dev>; Tue, 12 May 2026 08:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778573373; cv=none; b=FM+TYzAYwOhSvn0n0IRaV3tWz+Q4illGESkCPbJ+ly2Y+oNdsEvKDVOZlleucMZ8GBHjUsEbjsOpRaMwwkpvTUhizhp60v4MA/WZYCTnHO5EzWdr0mb38Nmyf5Q0TXDKG72ivGNf/y59IwNtyhdz62uL+JUdOiO3C4XgKncuYt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778573373; c=relaxed/simple;
	bh=ZUTCCkwuqNmfBsfY6jp+rxUYWDMdjLQhQlLeBUQUQ2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UMCPLPSKRzjjWt9OijiWOCGi3n02ZyB9E9ZhT8zJHvwn1AXJCFYyiKi2V8D6aFzAYIsYrk5Iahs0mi6QZNf6G7jHmxzVbTkZgcwrFOGFea32T00WqWhhZGuJkAtwcNoM/LBOeO6IQJ3HjOzl6OOppxfgsx44OZFromDERCeUdac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=E5+r6ij3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="E5+r6ij3"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so46824185e9.0
        for <bridge@lists.linux.dev>; Tue, 12 May 2026 01:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1778573369; x=1779178169; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8HLRH4qz571roLdHI5gJO49x2xeNTOoHtjZq1yE+EvM=;
        b=E5+r6ij3d+daTGz9vGN5dxBzoSA+YfaM0xJ3eAG1s2Mdf67jPxJqmQWoNmOmkSQbCf
         7g58OCchEDEi1FM5vpONQicculo+luhiOa2nmlbKdkI5yO+YL/XhLjt4iTyhU+0MowRz
         5wuMfa6BU4xQ/DgHYJ4i2qDrhj4DCjNSDKmjIZ5+teT6kHiXxQXsDUrEmw3h+IeBfqBv
         3q9zjBToNhpyLXFb2ezSQbbyTxXRFFDuyWMWkbBbbvHl05piqOFXqt7EKZMYbR/3TBnc
         h3Tq/2Ah7PPhocMiMKNDSxm582iBjfoEPDg1AxPKaFn4TlK0dUxzbtT6gxR/pIwbF4ZT
         P+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778573369; x=1779178169;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8HLRH4qz571roLdHI5gJO49x2xeNTOoHtjZq1yE+EvM=;
        b=j00uUUiphQqZdQr2SA682nlMbCedTVeWbOGFakQjIv82NGT7ZnnwiZqKQ9BeFb9GXe
         vuWDFylNFBGeWZ6r2Crg1Y9PWtEUtRrsKlZp07CkV4AtIlNU6uYHDIJut1igFbyQ9K72
         XdtYznrLmxFJ+RaPp9NA1EjT0dc3k49dz4Cr2ou1XfpOvLgTHJuChdLgSGtV6uLwy5wM
         j2GItSQ2ODr11Q/pTXxjjjaoQt/Z5xOpuoopn8fmCkkfNOw2vgOVq49n9yps7Ze+qxvp
         jF4BAVgtPp+V67RHr4GiKCCdACSO9kzTYdFedSrSAFvRjsKI/l6DzkK9DVQIXggHxVy1
         GbpQ==
X-Forwarded-Encrypted: i=1; AFNElJ/VHjgEHTKh6v/JPz/pg2O18dEFlotr4mlh3tvOJmeakinb+FuXdTrXcZzRsygJEpnBNo/u4UY=@lists.linux.dev
X-Gm-Message-State: AOJu0YwNYEsCD40Vlj0U9nN1VGKstLDIjR7S3jCDwlzKffbUWqfLHhSC
	HGQRm1Wj6GkMSz3nJ9p6hDuWmZcLcy8wQF7UMnr6j7oyPcjUFASWICl0ZtdY5zapGww=
X-Gm-Gg: Acq92OELzhORG5ZHNs4ER0MYpCVcjuL2z0/eM9Q2CazIwdu91tXrcSdVjUciaTUsRii
	fgwjg88jj5rUGP2yaU/dPqqWYWqIUcv/nUmN+COVw9g4cXG/8CpFcuX+07KiIVYPFwJ1zJ7ajgw
	HyH7fn/6u0+UVFQqGNKFF2/D8P/EHqoJ5FTmmqzX/68F3Je/CLJeEeEdvN2qhWoL+0tOrYbyyaK
	e7RUPrrwzjD8wcIVMBT7yjW8LH7keEsK59PKhDHYPzjCBrMsYd7nrDecTliUUfhT7RDilSnIbyw
	UctGGBNOFPxDAVWi8ZaStSwHup1GpmnB0K3eVFJjChAGc+wyHL9VZ4Ku6Z5Ek+nEbWdiSi3cgGA
	dkH/1CL0cZ+8Ly9BS01hv0hxhwV5wddo62Y3Hae8h7IVQroGzq4dxG0dCFyZ2frLp1jMXIJis2X
	Awd6CvW/RzTSm1rNE/vQ6iGtHmITPPHjpkgi9H3VqTL6jFKYUJN0EBJw==
X-Received: by 2002:a05:600c:34c9:b0:48e:75fd:9f9e with SMTP id 5b1f17b1804b1-48e8fe7ca80mr29746505e9.20.1778573368095;
        Tue, 12 May 2026 01:09:28 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e90681760sm28982565e9.12.2026.05.12.01.09.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 01:09:27 -0700 (PDT)
Message-ID: <7ffc7cdc-8140-4ea2-b3bd-c86abe6e6cff@blackwall.org>
Date: Tue, 12 May 2026 11:09:26 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net: bridge: cfm: use a per-bridge frame type
Content-Language: en-US, bg
To: Yilin Zhu <zylzyl2333@gmail.com>
Cc: Ren Wei <n05ec@lzu.edu.cn>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, idosch@nvidia.com, horatiu.vultur@microchip.com,
 kuba@kernel.org, henrik.bjoernlund@microchip.com, yuantan098@gmail.com,
 yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn,
 ronbogo@outlook.com
References: <cover.1778378864.git.zylzyl2333@gmail.com>
 <7198fe2845c30c60c6b3833dd78cead8c5966931.1778378864.git.zylzyl2333@gmail.com>
 <e1f1b080-cfde-4ea4-b444-b64d43778b2f@blackwall.org>
 <9263d4c1-0c57-4926-930b-1d701e1f17db@blackwall.org>
 <CAAAOPT8mBxW9Fd9Sr=xWAb-fa4MUHCqKaQf86-DFNqaB9Xvgng@mail.gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <CAAAOPT8mBxW9Fd9Sr=xWAb-fa4MUHCqKaQf86-DFNqaB9Xvgng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/05/2026 08:21, Yilin Zhu wrote:
> On Sun, 10 May 2026 at 04:40, Nikolay Aleksandrov <razor@blackwall.org> wrote:
>>
>> On 10/05/2026 13:05, Nikolay Aleksandrov wrote:
>>> On 10/05/2026 12:15, Ren Wei wrote:
>>>> From: Yilin Zhu <zylzyl2333@gmail.com>
>>>>
>>>> CFM registers a bridge frame handler when the first MEP is created and
>>>> unregisters it when the last MEP is deleted. The registered object also
>>>> contains the hlist_node used by the bridge-local frame_type_list.
>>>>
>>>> The CFM frame type is currently global, so enabling CFM on multiple
>>>> bridges links the same hlist_node into multiple bridge-local lists. A
>>>> later unregister on one bridge can then operate on list state belonging
>>>> to another bridge.
>>>>
>>>> Move the CFM frame type into struct net_bridge and register/unregister
>>>> the bridge-owned object. This keeps frame handler list membership local
>>>> to the bridge while preserving the existing first-MEP/last-MEP lifetime.
>>>>
>>>> Fixes: dc32cbb3dbd7 ("bridge: cfm: Kernel space implementation of CFM. CCM
>>>> frame RX added.")
>>>> Cc: stable@kernel.org
>>>> Reported-by: Yuan Tan <yuantan098@gmail.com>
>>>> Reported-by: Yifan Wu <yifanwucs@gmail.com>
>>>> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
>>>> Reported-by: Xin Liu <bird@lzu.edu.cn>
>>>> Co-developed-by: Peihan Liu <ronbogo@outlook.com>
>>>> Signed-off-by: Peihan Liu <ronbogo@outlook.com>
>>>> Signed-off-by: Yilin Zhu <zylzyl2333@gmail.com>
>>>> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
>>>> ---
>>>>    net/bridge/br_cfm.c     | 14 ++++++--------
>>>>    net/bridge/br_private.h | 18 +++++++++++-------
>>>>    2 files changed, 17 insertions(+), 15 deletions(-)
>>>>
>>>
>>> I think MRP suffers from the same bug, but I also think we can contain the
>>> fix within the packet type structure instead of making the already huge
>>> struct net_bridge even bigger. Also, linking a struct within net_bridge
>>> to a list within the same net_bridge looks weird.
>>>
>>> IMO br_add_frame should take a type & a frame_handler, allocate a br_frame_type
>>> dynamically and link it, then br_del_frame should take a type instead of a ptr
>>> and remove that frame type and free it with kfree_rcu. That would require
>>> br_add_frame return value to be checked in the respective cfm/mrp functions.
>>> Warnings for already existing types on add or missing types on del should be
>>> added.
>>>
>>
>> Actually I have a better idea since these handlers can be added only once per
>> bridge, we can do away with a simple bitmask (e.g. use net_bridge's options
>> which is in a Rx hot cache line) and even reduce net_bridge size while fixing
>> these bugs, and also remove a conditional from the fast-path when CFM/MRP are
>> not compiled in. Would you like me to prepare it or do you want to give it a go?
>>
> 
> Hi Nik,
> 
> Thanks for the suggestion.
> 
> I'll give it a go. IIUC, the idea is to remove the shared
> br_frame_type list entries for CFM/MRP, track their per-bridge enable
> state with bridge option bits, and dispatch the CFM/MRP handlers directly
> from the receive path when the corresponding EtherType and option bit
> match.
> 
> I'll include MRP in v2.
> 
> Thanks,
> Yilin
> 

Great, thank you. That should simplify the code and give us 8 bytes of Rx hot
cache line back. The important point is that there haven't been any new
handlers since these were added back in 2020, and also these are not
common, so making their impact on the fast-path as small as possible
while fixing the bug sounds good.

A quick & dirty sketch of the fixes gives me:
5 files changed, 47 insertions(+), 66 deletions(-)

That can probably be improved (i.e. more deletions).

Just please make sure that if CFM/MRP are not enabled in .config, they
would not affect the fast-path at all.

Cheers,
  Nik

>>> Would you please take care of MRP as well?
>>>
>>> Cheers,
>>>    Nik
>>>
>>>> diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
>>>> index 118c7ea48c35..547c7415c0ea 100644
>>>> --- a/net/bridge/br_cfm.c
>>>> +++ b/net/bridge/br_cfm.c
>>>> @@ -489,11 +489,6 @@ static int br_cfm_frame_rx(struct net_bridge_port *port,
>>>> struct sk_buff *skb)
>>>>        return 1;
>>>>    }
>>>> -static struct br_frame_type cfm_frame_type __read_mostly = {
>>>> -    .type = cpu_to_be16(ETH_P_CFM),
>>>> -    .frame_handler = br_cfm_frame_rx,
>>>> -};
>>>> -
>>>>    int br_cfm_mep_create(struct net_bridge *br,
>>>>                  const u32 instance,
>>>>                  struct br_cfm_mep_create *const create,
>>>> @@ -558,8 +553,11 @@ int br_cfm_mep_create(struct net_bridge *br,
>>>>        INIT_HLIST_HEAD(&mep->peer_mep_list);
>>>>        INIT_DELAYED_WORK(&mep->ccm_tx_dwork, ccm_tx_work_expired);
>>>> -    if (hlist_empty(&br->mep_list))
>>>> -        br_add_frame(br, &cfm_frame_type);
>>>> +    if (hlist_empty(&br->mep_list)) {
>>>> +        br->cfm_frame_type.type = cpu_to_be16(ETH_P_CFM);
>>>> +        br->cfm_frame_type.frame_handler = br_cfm_frame_rx;
>>>> +        br_add_frame(br, &br->cfm_frame_type);
>>>> +    }
>>>>        hlist_add_tail_rcu(&mep->head, &br->mep_list);
>>>> @@ -588,7 +586,7 @@ static void mep_delete_implementation(struct net_bridge *br,
>>>>        kfree_rcu(mep, rcu);
>>>>        if (hlist_empty(&br->mep_list))
>>>> -        br_del_frame(br, &cfm_frame_type);
>>>> +        br_del_frame(br, &br->cfm_frame_type);
>>>>    }
>>>>    int br_cfm_mep_delete(struct net_bridge *br,
>>>> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
>>>> index bed1b1d9b282..a3ed9ee826f5 100644
>>>> --- a/net/bridge/br_private.h
>>>> +++ b/net/bridge/br_private.h
>>>> @@ -61,6 +61,9 @@ typedef struct bridge_id bridge_id;
>>>>    typedef struct mac_addr mac_addr;
>>>>    typedef __u16 port_id;
>>>> +struct net_bridge_port;
>>>> +struct sk_buff;
>>>> +
>>>>    struct bridge_id {
>>>>        unsigned char    prio[2];
>>>>        unsigned char    addr[ETH_ALEN];
>>>> @@ -70,6 +73,13 @@ struct mac_addr {
>>>>        unsigned char    addr[ETH_ALEN];
>>>>    };
>>>> +struct br_frame_type {
>>>> +    __be16            type;
>>>> +    int            (*frame_handler)(struct net_bridge_port *port,
>>>> +                         struct sk_buff *skb);
>>>> +    struct hlist_node    list;
>>>> +};
>>>> +
>>>>    #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
>>>>    /* our own querier */
>>>>    struct bridge_mcast_own_query {
>>>> @@ -585,6 +595,7 @@ struct net_bridge {
>>>>        struct hlist_head        mrp_list;
>>>>    #endif
>>>>    #if IS_ENABLED(CONFIG_BRIDGE_CFM)
>>>> +    struct br_frame_type    cfm_frame_type;
>>>>        struct hlist_head        mep_list;
>>>>    #endif
>>>>    };
>>>> @@ -926,13 +937,6 @@ int nbp_backup_change(struct net_bridge_port *p, struct
>>>> net_device *backup_dev);
>>>>    int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff
>>>> *skb);
>>>>    rx_handler_func_t *br_get_rx_handler(const struct net_device *dev);
>>>> -struct br_frame_type {
>>>> -    __be16            type;
>>>> -    int            (*frame_handler)(struct net_bridge_port *port,
>>>> -                         struct sk_buff *skb);
>>>> -    struct hlist_node    list;
>>>> -};
>>>> -
>>>>    void br_add_frame(struct net_bridge *br, struct br_frame_type *ft);
>>>>    void br_del_frame(struct net_bridge *br, struct br_frame_type *ft);
>>>
>>

