Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F52E4690
	for <bridge@lists.linux.dev>; Wed, 18 Dec 2024 22:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734562268; cv=none; b=IfsMKy7pL1H4lHMrH8iozZweowzWPbW5pyYGJP4A2+JcgHA9kUOG+P6QmBW74w7t8YjFkcz+XOUER0YK0H4kXm+ODhdrIpg9R5iuZMWZa4P1IetS4XVuBTYB72sw0I2meA2KvhRQ39O+wEU1uLxzibOXZC2ypXlCjCrztVA2OEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734562268; c=relaxed/simple;
	bh=pfeu6CphBx8XYONSfLNbyc2r+5uhzWSh9Moeo5Nw6iE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqcSQNCUUkU12eovlbSTrsLladPeY/GMMDhEx+mMaf97sXVUOS0VINyeLb9vkcDaQC7Z1v/8BwAMh8sG73LZADE3uAYfV2C/O8AalvazXMqyol8j2MHxmHPGL3Qj2JUPfgkTKdoFJO9Zfz09eBIbXNqDQD0c8VsUjgL3hRTDUS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=yYb623Uv; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="yYb623Uv"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso1193735e9.0
        for <bridge@lists.linux.dev>; Wed, 18 Dec 2024 14:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1734562262; x=1735167062; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Sh2lkKWrEXVfvaNZPxnHHh567ZFTU/Ul8OTfVOu238=;
        b=yYb623UvJFNTmLGZ2b2bhIDKktgFKEHpFiIwiLu3xtaUSWAcamOv2TwSVtVGgxO1Sm
         p8JBjCEOTSMeu6V4xz5MVoHRNghOHjwZvdbMbMQGYbAi/yjvtgwEyLeqyWUKMRSaX/pW
         JRuixzwGu49rZbhDYnlnf78udDqHghXfs6DPf443qrXNBZuc9nolLXifjxhh4JQ66Ys3
         pK45ChW2mA5gY1E3EusK4w8xjGdGIPjDyWpNyeIcwi6RlvbwSZf8ILKXmGW9ApnfSgeM
         0U7w2jT5eajAczG1VsuGPdlM9DdXjTc/v0XjIhepJUwytjHL6lRoUKLo53fnznJ+wzME
         AsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734562262; x=1735167062;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Sh2lkKWrEXVfvaNZPxnHHh567ZFTU/Ul8OTfVOu238=;
        b=KLDFRWsT9jReZ7MA2EQ4uZQi0r+Gym/6wLVX3VmftDoOC4AXPtl7wD7p1uq5pDV37b
         WgF4VL0M3wty6aXtZr1frIZ7C4mIYdCLDtPwDqgwaDD01fk7JpIT/lrjL3NGy2sGqGLe
         qYmGG9Tlb30Z9980lvJYJyTzUDaf5Hjs4nPMO+4NeEa/jh3XKkaDtU0HdjuwtU973q5/
         w78OaWkPrf78TBYwN3dchPqlrxHBb0A7e9okC93kJNXlkasfmgtCXbAUuerLiud//NuT
         We0rurZy0BFNHHqB3Dw+5EbPzCBYfWUm9JBQVOGkBkICJYCF2hKEqp8CAlcdmRG6/21l
         iZ+g==
X-Forwarded-Encrypted: i=1; AJvYcCWB5cRvtVXnUDa62Fclh53FFCp/EF7T8eIslvk5tKyx6BePPocY1sTuGsXFe0abLJBMraW0to0=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2vHh1WMFTLzChrsLnikwJm6fcBSVVW+CXvIl8gRHYJfPt4D2K
	+dCIyc4cF9s4VMcj+95B8UScNpmbMnLy9KpBjyBbHwvPIpLBqHfpHzIZK8TuYCo=
X-Gm-Gg: ASbGncvFvV69rA1Dx2UsRs2YgS9MbZM4fhushcZ9yk5VX4O1fI3UeYaecklSwPhE49K
	toK+jbxUPtdsyVDIsCF+IpfZd6QSnEfFZzU8pm6BxK0tLMiokoxFZxZs9NfgtIadyR2VGZymhOu
	A5GBX5RIDNo0L67Pkg23/M9rnrsQMDLFkwBC2j8Vlu78vMyVPFm/0B6Qw6g8HupNQmdLW2JTyex
	dytHQXwhym+USfmReaBxW87hUY0QgeLcS/F5AW1mkMIrkyejesH8pKWhTFQZcCyd7LLvUA2ufBL
	YwqC8lpgxJwj
X-Google-Smtp-Source: AGHT+IHuZVsxI+GEQrhRWdTxRTCg3/MtW0+1GHNr42Nv6drkEzWGgoKTkPpYOZRJlGGFAR5E4/1P7Q==
X-Received: by 2002:a05:600c:1c1f:b0:434:f1e9:afb3 with SMTP id 5b1f17b1804b1-43655347f59mr44852415e9.3.1734562261748;
        Wed, 18 Dec 2024 14:51:01 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656af6d02sm34241395e9.1.2024.12.18.14.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 14:51:00 -0800 (PST)
Message-ID: <0b0dd0fa-cf7b-4654-ab25-3e6d80615bf1@blackwall.org>
Date: Thu, 19 Dec 2024 00:50:27 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net: bridge: add skb drop reasons to the
 most common drop points
To: Ido Schimmel <idosch@idosch.org>, Radu Rendec <rrendec@redhat.com>
Cc: Roopa Prabhu <roopa@nvidia.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
References: <20241217230711.192781-1-rrendec@redhat.com>
 <20241217230711.192781-3-rrendec@redhat.com> <Z2MEOvn4dNToq5Fq@shredder>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <Z2MEOvn4dNToq5Fq@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/24 19:19, Ido Schimmel wrote:
> On Tue, Dec 17, 2024 at 06:07:11PM -0500, Radu Rendec wrote:
>> @@ -520,6 +522,16 @@ enum skb_drop_reason {
>>  	 * enabled.
>>  	 */
>>  	SKB_DROP_REASON_ARP_PVLAN_DISABLE,
>> +	/**
>> +	 * @SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL: the destination MAC address
>> +	 * is an IEEE MAC Control address.
>> +	 */
>> +	SKB_DROP_REASON_MAC_IEEE_MAC_CONTROL,
>> +	/**
>> +	 * @SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD: the STP state of the
> 
> s/SKB_DROP_REASON_BRIDGE_INGRESS_PORT_NFWD/SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE/
> 
>> +	 * ingress bridge port does not allow frames to be forwarded.
>> +	 */
>> +	SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE,
>>  	/**
>>  	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
>>  	 * shouldn't be used as a real 'reason' - only for tracing code gen
>> diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
>> index e19b583ff2c6d..3e9b462809b0e 100644
>> --- a/net/bridge/br_forward.c
>> +++ b/net/bridge/br_forward.c
>> @@ -201,6 +201,7 @@ void br_flood(struct net_bridge *br, struct sk_buff *skb,
>>  	      enum br_pkt_type pkt_type, bool local_rcv, bool local_orig,
>>  	      u16 vid)
>>  {
>> +	enum skb_drop_reason reason = SKB_DROP_REASON_NO_TX_TARGET;
>>  	struct net_bridge_port *prev = NULL;
>>  	struct net_bridge_port *p;
>>  
>> @@ -234,8 +235,11 @@ void br_flood(struct net_bridge *br, struct sk_buff *skb,
>>  			continue;
>>  
>>  		prev = maybe_deliver(prev, p, skb, local_orig);
>> -		if (IS_ERR(prev))
>> +		if (IS_ERR(prev)) {
>> +			WARN_ON_ONCE(PTR_ERR(prev) != -ENOMEM);
> 
> I don't think we want to see a stack trace just because someone forgot
> to adjust the drop reason to the error code. Maybe just set it to
> 'NOMEM' if error code is '-ENOMEM', otherwise to 'NOT_SPECIFIED'.
> 

+1


