Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C043A7584
	for <bridge@lists.linux.dev>; Tue, 12 May 2026 09:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778576620; cv=none; b=jiHUi8IzLUWRtfC9Jecjk0HxbYCyHsGA2dKcyqNjy6jAIfEC4tiWdZc7/pJPhao4Cyf58c1nebHhJPI6oP5tkW9GFjPeYG0FcJBdaK977HEMnJJQ7NJYqufd3CrPhyoah8pgT7bMucKRL0n3XxVc2lFR7hfL5UMaw5eVvWIxaFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778576620; c=relaxed/simple;
	bh=YaRdS6/HU0UNCZq6d8R/5etKgU5iBv+kQofVt3WrOag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ukr7Q6mBsf/Zh+1fA2V4KbaAgZlF0UrWa70vFzLOMvT6+BOl86t94zPsUQgVvaqFSKIdPu1g0Fhetcjx8ILm+YFiZFAgg/fm2Lbo95pHyXpFKhCYwUu2lT7D0CwIcuu58dKIRyOSwPOK4P68npMXdYiL96sJ3k0VDVyialgJ0Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=f7IdmjJh; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="f7IdmjJh"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d7e23defbso3071262f8f.0
        for <bridge@lists.linux.dev>; Tue, 12 May 2026 02:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1778576615; x=1779181415; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GeQwgR3LsQgqn0nKN4yhs8JLip5DYYktZ+hVFenxoUM=;
        b=f7IdmjJh0tKtLszn1gel/UxcjA8b7+uGQCsRbrmBCi8h7fPKZuQqwBuIUGWTXrxAaj
         m02p5aQxszn3uEPZA5ZcHFhuI5rrl5ayt1qJtFi664UBzQxZRlkaTtR+D7JMaiFzA480
         p6LPF0q8XtaqLXPD1FaIihh1Xqke6JFVbmAmgqs3tydw2qLWD79+Gt6RGRUoW2plXdqh
         H7UCRAo5aaXHkOsZ+Pyv+kY4INnXuoKWXzWycKMgivzgJ1HvCvRWAzgnGEtdZXWfA4QQ
         l47a9MN3ESQpPiDba4nD9hQpvimLz4ty0NIKKjA44RyRzcCOTo21aKiTW9xJAXsyoAE9
         dUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778576615; x=1779181415;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GeQwgR3LsQgqn0nKN4yhs8JLip5DYYktZ+hVFenxoUM=;
        b=nPBgjeEJyx960O3kdyc4dB2A5Sqa27s3uGp57z/91KZ3HFDLZdO4oJ8Ig5MFo79MQX
         gKGUjONWt3eo24Gnbx7FpjAbRugRc+KRyv02y7a73knqPdmgDUQ3k4MfSWawk3h7ey3+
         0sEK+iL1SsdgAg3SUd6Ro4SvpJDb6BPVcpyqHow+q+ynEe0KKi+741HJ9tvl7STsfQ+J
         Fo+MwIdJ5a203HiZCN6C/Czx7nS5f1uwlZVpF0AwSKG5MlYQTxZcpoa8j+W8uTpbbrM5
         Vp4/nk8ATtg0qXXLxSn98JYke3+Lm10gQtf0u3NCw1P92ESKnKWpnIDm88Cj/nAAj2Fz
         6cng==
X-Forwarded-Encrypted: i=1; AFNElJ9SMpxT7tv5r35mpfFAKzWvYzMAI/Av74fx9CN/uUPb7M2MDkD0k4TgosVOqYMGkP8c+noD2Jc=@lists.linux.dev
X-Gm-Message-State: AOJu0YwYi/dKMkRfnWleafWVGrPXvHXq4QTTm7x8IBUnc1VusYgnLGxl
	n2zoOJHRm/328hZjPH59y1Z9aZ5mAr7hsK5K1GVv9sD6ng4rMuf0Qo0NRX3jr7oM3JQ=
X-Gm-Gg: Acq92OFGc7M3K3/xnX2rONQv/LpAJ4mdp6NPqy7o1IhgiD29WxFT0SzVOeV8kXBsGNv
	W5v74erz66v1zE3uAfLjvH7yK9CJ/0bfR3eE8S9mBK/k+GSHFs+QHTfpPdXZBoy5c6f8oHUVsCF
	jNuSlNTHwaxwER8MyLa22wSNvSbrPOydvmWOILEvkFCHPziLfPOtQ7r/HTZWrFoo5mUbySWriA1
	C8iWiy7HttoxeJA1bVn2rgfPRL7lgT5wHlz4kEhPzCvCw+GRHWxAT4hmJqG+XLmzjJNcvDL/iVo
	RMVHKrBVgBA+XZBsld5eTcpaFokAqdYkxGGUgI1+R2N7ELjwu5HBJ+Fql2lpbradQK3YiQrmDHh
	926Z9uDfJWiDsJkOFENJBSXE54YMqWWcF4zfupCVlxygOCTgzZfAw9P/fKSBgNx7lgSkJ+bAoJz
	VLEj+41sUiV9mV94qgP4RDR/PrCNEMpaiwg/7SKxsIIWsImKTLzwBhoQ==
X-Received: by 2002:a05:6000:430a:b0:455:8733:2026 with SMTP id ffacd0b85a97d-4568a93e624mr18843331f8f.15.1778576614746;
        Tue, 12 May 2026 02:03:34 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-454917d57aesm31618975f8f.26.2026.05.12.02.03.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 02:03:34 -0700 (PDT)
Message-ID: <c2bbd2ab-e4f9-4142-a3d4-531f3d5ce6d7@blackwall.org>
Date: Tue, 12 May 2026 12:03:33 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net: bridge: guard local finish against missing
 port
Content-Language: en-US, bg
To: Yuan Tan <yuantan098@gmail.com>
Cc: Ren Wei <n05ec@lzu.edu.cn>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, idosch@nvidia.com, fw@strlen.de,
 davem@davemloft.net, yifanwucs@gmail.com, tomapufckgml@gmail.com,
 bird@lzu.edu.cn, tonanli66@gmail.com
References: <cover.1778504155.git.tonanli66@gmail.com>
 <ad183a40c4d906f39e03590b371fdcfdffb863c6.1778504155.git.tonanli66@gmail.com>
 <1bfd86a2-e7f8-42ef-8486-4d7fa91b2199@blackwall.org>
 <CAPuPA7JzZC1veoLtdmsGdqZ4xuy7Znu=z=+7FsyX0_iUQxcZAQ@mail.gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <CAPuPA7JzZC1veoLtdmsGdqZ4xuy7Znu=z=+7FsyX0_iUQxcZAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/05/2026 11:57, Yuan Tan wrote:
> On Tue, May 12, 2026 at 1:29 AM Nikolay Aleksandrov <razor@blackwall.org> wrote:
>>
>> On 12/05/2026 07:31, Ren Wei wrote:
>>> From: Nan Li <tonanli66@gmail.com>
>>>
>>> The bridge local receive path may be deferred by netfilter and resumed
>>> later. By the time br_handle_local_finish() runs, skb->dev may still be
>>> valid while its bridge port association has already been removed.
>>>
>>> br_handle_local_finish() unconditionally looks up the bridge port from
>>> skb->dev and dereferences it for source learning. If the port is no
>>> longer attached to the bridge, the lookup returns NULL and the deferred
>>> local receive path can no longer rely on the port state being present.
>>>
>>> Skip the learning step when the bridge port lookup fails. In that case
>>> there is no port state left to learn on, so returning early preserves
>>> the normal behavior for existing ports while avoiding access to stale
>>> state.
>>>
>>> Fixes: 8626c56c8279 ("bridge: fix potential use-after-free when hook returns QUEUE or STOLEN verdict")
>>
>> I don't think that is the correct commit, it seems to me this bug
>> has existed for a very long time. From a quick search I think (Florian
>> please correct me if I'm wrong, but I think NF_QUEUE existed back then)
>> it was introduced in 2010 by:
>>    f350a0a87374 ("bridge: use rx_handler_data pointer to store net_bridge_port
>> pointer")
> 
> 
> After checking the history, I believe f350a0a87374 is indeed the
> commit that introduced the underlying root cause.
> 
> The 8626c56c8279 commit in the patch is the one that actually made the
> bug reachable in practice. I am a bit unsure which commit should be
> used in the Fixes: tag. We have run into this situation several times
> already, where the commit that introduced the root cause is different
> from the commit that actually made the bug triggerable/reachable.
> 

Hmm could you please elaborate? How did that commit make it reachable?
I can see the call was done before it as well:
                 /* Deliver packet to local host only */
-               if (NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_IN,
-                           dev_net(skb->dev), NULL, skb, skb->dev, NULL,
-                           br_handle_local_finish)) {
-                       return RX_HANDLER_CONSUMED; /* consumed by filter */
-               } else {
-                       *pskb = skb;
-                       return RX_HANDLER_PASS; /* continue processing */
-               }
+               NF_HOOK(NFPROTO_BRIDGE, NF_BR_LOCAL_IN, dev_net(skb->dev),
+                       NULL, skb, skb->dev, NULL, br_handle_local_finish);
+               return RX_HANDLER_CONSUMED;

NF_HOOK() would return 1 for NF_QUEUEed packet so essentially it was doing
the same, how would did it make the bug triggerable?

> What do you think would be best?
> 
> Also, if the Fixes: tag should be changed, would you prefer that we
> resend the patch, or would you rather have the committer adjust the
> Fixes: tag when applying it in order to reduce traffic on netdev?
> 
> 

You should update the Fixes: tag but also wait 24h before re-posting another
patch version.

>>
>> because that commit removed the same check for a NULL port.
>> The patch itself is ok, it restores the check that was there before the commit
>> I mentioned.
>>
>>> Cc: stable@kernel.org
>>> Reported-by: Yuan Tan <yuantan098@gmail.com>
>>> Reported-by: Yifan Wu <yifanwucs@gmail.com>
>>> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
>>> Reported-by: Xin Liu <bird@lzu.edu.cn>
>>> Signed-off-by: Nan Li <tonanli66@gmail.com>
>>> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
>>> ---
>>>    net/bridge/br_input.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
>>> index 2cbae0f9ae1f..5b0d7450de5f 100644
>>> --- a/net/bridge/br_input.c
>>> +++ b/net/bridge/br_input.c
>>> @@ -247,6 +247,9 @@ static void __br_handle_local_finish(struct sk_buff *skb)
>>>        struct net_bridge_port *p = br_port_get_rcu(skb->dev);
>>>        u16 vid = 0;
>>>
>>> +     if (unlikely(!p))
>>> +             return;
>>> +
>>>        /* check if vlan is allowed, to avoid spoofing */
>>>        if ((p->flags & BR_LEARNING) &&
>>>            nbp_state_should_learn(p) &&
>>
>>

