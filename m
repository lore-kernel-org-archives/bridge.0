Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E43B3806D9
	for <bridge@lists.linux.dev>; Sun, 10 May 2026 11:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778413222; cv=none; b=s/Sc5vs/iK44Vh26kJeyEldgd7Fbb7jRG2hQac79NU9xjFLQfq/sZnPCLUSsnAoo1fu39KEOqwASpiWTUgDii7NiLyvjwp8DNsj7BWZHTqxubHiIRaZu0GfI6s+Ie4uK9vcY8a8WGKmyvkkZZShcFk3xJ7Ht/SSzco+jwOiYC98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778413222; c=relaxed/simple;
	bh=/Wo3+PBXbAXUlTotZqvdk9KEBPgZ8FLOpMFS4dkqvGk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lWplaa01zWa4Eh0V4IrZzlbWBK4O341GZhUvHuwqVsr4+Ye9rEnNFUcu+gPJyWvV0qwMDqLd6Ak9SiR55m2gJb6fnL4lJMLrqAEA014O6wockzvtBcSrhCkJJKjy3qWVoTmVK9dHur8gZhbKWRMqHnuc3ISSVnPYE1SdQCMR5es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=BFc65aRU; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="BFc65aRU"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-448528f4e69so2011167f8f.3
        for <bridge@lists.linux.dev>; Sun, 10 May 2026 04:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1778413219; x=1779018019; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MU0V5qtLR9exTpcGnpIFJuqzegnzuD5wERdsIC6ROXI=;
        b=BFc65aRUVA+lf3BDeXVeCtx+cG5PkOg+29wOzBk73SQ9YNRuhzjkJ3yr5frXHGWn/+
         Mrf4bTTwOvLq02QBUrxq5tAXMBAZH5Oop5A240kYsoOTw1erMcw1ehV1CyOcS0pTk5OW
         CjbiBenU82boZd3KuPwUfxW9pKYwJWOedZV3+dEjiqwMELxZjgc0MH+80IlExggp2tYx
         dJwIx5Rx0RAcobuu1A8uhL3paBsFdzxFAPx98P6y/IEcBtL3QJQJ7DLDd31UhchMDAgK
         G7FC/PYzqz0mTH0UlAnAv5l6k9koSuU8gmmQ41A32qD+wBWAZgD/nGTO2hD0XluMRbUs
         2sng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778413219; x=1779018019;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MU0V5qtLR9exTpcGnpIFJuqzegnzuD5wERdsIC6ROXI=;
        b=KRperI4gRuqId8nSIFUyQCfVAGHkSF4mcJ0GnMFw06EpJNYOMrOm+2SdlR5KRLHZ4Q
         +JPUPgIkOWtkD/WnFW0A18sgKRr7eu3h7MRXsUGxuUZsLaiT/wJmrBOuxaBepOY2jdYx
         6sUQn3odnCf3idYK5PflWpeTwEelK/NwTfJDTLPbQL4mbu/3RZzdUrWR8Hnj019E3X+i
         5AsmVszF/FqAUs+dJq1/Ja/swMPiYXq1St99XpDaKeovTQUeI6KNhInaHd/j6LBiU+Vw
         0F1MeJLbjD3Y8KHpY9mJAF1GK8qK3hMGTzt5gvenwsoH5W7z9a6u5vQxnCpxMerH4EfY
         KphA==
X-Forwarded-Encrypted: i=1; AFNElJ9oPl0BYnrLAN+wZ53OKHKxBEsiVel/eJB6Ehgi4HOFE38fD7+x52/IhZVOJF3k+PuhFgGBFiA=@lists.linux.dev
X-Gm-Message-State: AOJu0YzcM9FtzEKXDqlmCyJirr6Wh+7lUwmXXVMriiusruLnhGQPY8c7
	hQKaj0P+WouRkhoNlAiamHQIDyV9+Q1q1Z2EFxO5FlzuXzD+reyjoZy0xKt24eDqk0c=
X-Gm-Gg: Acq92OHfHLGQ8MhCxaCjkV7m472KebT84zBQxeXfMbu3LMaJqIhDQohzF3uebv+crUE
	BUdcrboBDx/zTYgPH3Us7AWF6T2z7XxRP2LK8Le5dtaT5HivCrJYEdGQNGKn5VyzXwdzpH/Xbn2
	sNUvLq6tutnZGYPPGarwn39OVlPdkJJ7weJtSUmVzfduGGtp4f1w3b0Q1hJ/KKo13GHz8OcSl/N
	zXOeDyIw+ZQnohzCxu7RJcJ35ClBZFpvqcPVsn7LYioywEq1W/VVCN+CV8frTrZUNzWTE22hsyP
	C/EA4u8zoYulLAOasUQHhtzkgBUcgdCg8iKT6DYwfkAKfeD+J0fyhgqAOgXgwzGqmVniWzDbMcE
	Q3TXqQ5FqSZ6DxA580+xnaLqiC19xa6rXCvj1YQWEl7goJcQsYqpB0TX6d1tzE1jPOCUmrn48KI
	HneQV4HorQx4ZR1Z1qnFfM1ZFLJykzWb9yCkuNrNEC8eRg/n210zINAg==
X-Received: by 2002:a05:6000:26cf:b0:44e:902f:e341 with SMTP id ffacd0b85a97d-45462c342a3mr15284725f8f.20.1778413218879;
        Sun, 10 May 2026 04:40:18 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4549130549bsm18054698f8f.18.2026.05.10.04.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 04:40:18 -0700 (PDT)
Message-ID: <9263d4c1-0c57-4926-930b-1d701e1f17db@blackwall.org>
Date: Sun, 10 May 2026 14:40:17 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net: bridge: cfm: use a per-bridge frame type
Content-Language: en-US, bg
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Ren Wei <n05ec@lzu.edu.cn>, bridge@lists.linux.dev, netdev@vger.kernel.org
Cc: idosch@nvidia.com, horatiu.vultur@microchip.com, kuba@kernel.org,
 henrik.bjoernlund@microchip.com, yuantan098@gmail.com, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, bird@lzu.edu.cn, ronbogo@outlook.com,
 zylzyl2333@gmail.com
References: <cover.1778378864.git.zylzyl2333@gmail.com>
 <7198fe2845c30c60c6b3833dd78cead8c5966931.1778378864.git.zylzyl2333@gmail.com>
 <e1f1b080-cfde-4ea4-b444-b64d43778b2f@blackwall.org>
In-Reply-To: <e1f1b080-cfde-4ea4-b444-b64d43778b2f@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/05/2026 13:05, Nikolay Aleksandrov wrote:
> On 10/05/2026 12:15, Ren Wei wrote:
>> From: Yilin Zhu <zylzyl2333@gmail.com>
>>
>> CFM registers a bridge frame handler when the first MEP is created and
>> unregisters it when the last MEP is deleted. The registered object also
>> contains the hlist_node used by the bridge-local frame_type_list.
>>
>> The CFM frame type is currently global, so enabling CFM on multiple
>> bridges links the same hlist_node into multiple bridge-local lists. A
>> later unregister on one bridge can then operate on list state belonging
>> to another bridge.
>>
>> Move the CFM frame type into struct net_bridge and register/unregister
>> the bridge-owned object. This keeps frame handler list membership local
>> to the bridge while preserving the existing first-MEP/last-MEP lifetime.
>>
>> Fixes: dc32cbb3dbd7 ("bridge: cfm: Kernel space implementation of CFM. CCM 
>> frame RX added.")
>> Cc: stable@kernel.org
>> Reported-by: Yuan Tan <yuantan098@gmail.com>
>> Reported-by: Yifan Wu <yifanwucs@gmail.com>
>> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
>> Reported-by: Xin Liu <bird@lzu.edu.cn>
>> Co-developed-by: Peihan Liu <ronbogo@outlook.com>
>> Signed-off-by: Peihan Liu <ronbogo@outlook.com>
>> Signed-off-by: Yilin Zhu <zylzyl2333@gmail.com>
>> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
>> ---
>>   net/bridge/br_cfm.c     | 14 ++++++--------
>>   net/bridge/br_private.h | 18 +++++++++++-------
>>   2 files changed, 17 insertions(+), 15 deletions(-)
>>
> 
> I think MRP suffers from the same bug, but I also think we can contain the
> fix within the packet type structure instead of making the already huge
> struct net_bridge even bigger. Also, linking a struct within net_bridge
> to a list within the same net_bridge looks weird.
> 
> IMO br_add_frame should take a type & a frame_handler, allocate a br_frame_type
> dynamically and link it, then br_del_frame should take a type instead of a ptr
> and remove that frame type and free it with kfree_rcu. That would require
> br_add_frame return value to be checked in the respective cfm/mrp functions.
> Warnings for already existing types on add or missing types on del should be
> added.
> 

Actually I have a better idea since these handlers can be added only once per
bridge, we can do away with a simple bitmask (e.g. use net_bridge's options
which is in a Rx hot cache line) and even reduce net_bridge size while fixing
these bugs, and also remove a conditional from the fast-path when CFM/MRP are
not compiled in. Would you like me to prepare it or do you want to give it a go?

> Would you please take care of MRP as well?
> 
> Cheers,
>   Nik
> 
>> diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
>> index 118c7ea48c35..547c7415c0ea 100644
>> --- a/net/bridge/br_cfm.c
>> +++ b/net/bridge/br_cfm.c
>> @@ -489,11 +489,6 @@ static int br_cfm_frame_rx(struct net_bridge_port *port, 
>> struct sk_buff *skb)
>>       return 1;
>>   }
>> -static struct br_frame_type cfm_frame_type __read_mostly = {
>> -    .type = cpu_to_be16(ETH_P_CFM),
>> -    .frame_handler = br_cfm_frame_rx,
>> -};
>> -
>>   int br_cfm_mep_create(struct net_bridge *br,
>>                 const u32 instance,
>>                 struct br_cfm_mep_create *const create,
>> @@ -558,8 +553,11 @@ int br_cfm_mep_create(struct net_bridge *br,
>>       INIT_HLIST_HEAD(&mep->peer_mep_list);
>>       INIT_DELAYED_WORK(&mep->ccm_tx_dwork, ccm_tx_work_expired);
>> -    if (hlist_empty(&br->mep_list))
>> -        br_add_frame(br, &cfm_frame_type);
>> +    if (hlist_empty(&br->mep_list)) {
>> +        br->cfm_frame_type.type = cpu_to_be16(ETH_P_CFM);
>> +        br->cfm_frame_type.frame_handler = br_cfm_frame_rx;
>> +        br_add_frame(br, &br->cfm_frame_type);
>> +    }
>>       hlist_add_tail_rcu(&mep->head, &br->mep_list);
>> @@ -588,7 +586,7 @@ static void mep_delete_implementation(struct net_bridge *br,
>>       kfree_rcu(mep, rcu);
>>       if (hlist_empty(&br->mep_list))
>> -        br_del_frame(br, &cfm_frame_type);
>> +        br_del_frame(br, &br->cfm_frame_type);
>>   }
>>   int br_cfm_mep_delete(struct net_bridge *br,
>> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
>> index bed1b1d9b282..a3ed9ee826f5 100644
>> --- a/net/bridge/br_private.h
>> +++ b/net/bridge/br_private.h
>> @@ -61,6 +61,9 @@ typedef struct bridge_id bridge_id;
>>   typedef struct mac_addr mac_addr;
>>   typedef __u16 port_id;
>> +struct net_bridge_port;
>> +struct sk_buff;
>> +
>>   struct bridge_id {
>>       unsigned char    prio[2];
>>       unsigned char    addr[ETH_ALEN];
>> @@ -70,6 +73,13 @@ struct mac_addr {
>>       unsigned char    addr[ETH_ALEN];
>>   };
>> +struct br_frame_type {
>> +    __be16            type;
>> +    int            (*frame_handler)(struct net_bridge_port *port,
>> +                         struct sk_buff *skb);
>> +    struct hlist_node    list;
>> +};
>> +
>>   #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
>>   /* our own querier */
>>   struct bridge_mcast_own_query {
>> @@ -585,6 +595,7 @@ struct net_bridge {
>>       struct hlist_head        mrp_list;
>>   #endif
>>   #if IS_ENABLED(CONFIG_BRIDGE_CFM)
>> +    struct br_frame_type    cfm_frame_type;
>>       struct hlist_head        mep_list;
>>   #endif
>>   };
>> @@ -926,13 +937,6 @@ int nbp_backup_change(struct net_bridge_port *p, struct 
>> net_device *backup_dev);
>>   int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff 
>> *skb);
>>   rx_handler_func_t *br_get_rx_handler(const struct net_device *dev);
>> -struct br_frame_type {
>> -    __be16            type;
>> -    int            (*frame_handler)(struct net_bridge_port *port,
>> -                         struct sk_buff *skb);
>> -    struct hlist_node    list;
>> -};
>> -
>>   void br_add_frame(struct net_bridge *br, struct br_frame_type *ft);
>>   void br_del_frame(struct net_bridge *br, struct br_frame_type *ft);
> 

