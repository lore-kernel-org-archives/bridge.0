Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBAB1D8E10
	for <bridge@lists.linux.dev>; Sat, 28 Jun 2025 14:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751120498; cv=none; b=obQZnoPlZMyDo9Z8XhyZdc56gztMLatYN1PLZhMqMBf231cOWc+Xan8n/6fn4b7JGqPKOpEYTVhK9g9RnZSB+99afEblBsXkAa8ZH3Hj5OyP1bPK+EEiP/y4w6XiIoln5gybfRRPH1JLYauG/6ItKg2MMCxLgTBIlVIiAkpfbHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751120498; c=relaxed/simple;
	bh=7guzmn0y3Uw2E2oN/ica6GoK0GT09gtminZYHaPXseI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fSogEPW61oAOTbAD2QBxHgo+xzw9orEkWYk7bIyBuSpEaZ2+Nm5kshl0KbTirblPK9UQ1JrfgPQ1BtKDZrRkR8BdJMaKmoK/NvB+qormRspD40TZAohVbYsimCTuKAO3XLAyzTDFNHamdZbtfaDGKzG09sNWP98WAnwEpgTte8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCOH2AMR; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCOH2AMR"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae0ccfd5ca5so88489566b.3
        for <bridge@lists.linux.dev>; Sat, 28 Jun 2025 07:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751120494; x=1751725294; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cOFYFwTuqfFVnwMxVqk0n5iUPlamNNN/0+Br9x/oBUE=;
        b=KCOH2AMRyFzjju0bjYMi7IeZXFVx+7yv8hSO2hGMARu+9qwkJZgqRVVOnQ3mD68/It
         /Ux3ZGNxbGRnHOfT4owDMqCDtMYR8vxarJ5bW6NbbHUeH/rKi8WjRGz14d0Y8TllJf2J
         2dFpLDqiGzmK4NOv2/FNI/cP6p7ysXYgH3tIFk7+HYoAc/RDFsGvh0btpm5jED8HnuXv
         6mlAO4YIuun3I9Hj2JhFRcJZFOhshVIBxlpU2JTKL4bGwkdS6CqG/4nQrIQOQi95CSR8
         x6mLU4aHl5tfwRBH25BqhIehwddt4FjscL6IyNnPnTY69ilhNb6ywwpDEBEeHaYVQAcy
         fquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751120494; x=1751725294;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cOFYFwTuqfFVnwMxVqk0n5iUPlamNNN/0+Br9x/oBUE=;
        b=QIPUQyQOF2vGcXNJVEpdT+dI2dVLD2JATirUa9hiOKNIF8MlpXIH7YgLd1ELH8Zxj3
         MiJR2YR+2Gb2QYHDfWJhFKPLycFSb+i2iFGLjyZ+kUdmBUu4TEu0ce+52d0nPXbiyCuZ
         rC6OBoPRSabt9FVoxVanTR9jUOZVuO1Rr0/pHdGCTMd/J6HJekicujQALzz9xP/2S9v1
         voTbexfoLTujVp+XzeFnyc8oiKnOcXeMXdO1dWu7l/Zf++rchIipenvONNN46f/9jzhc
         tJdKnzbAn5naOoiHSvEtJUeVCyfJ3hBHtJRC/g/K5LxQQMxiRqfbT9770X/lmcwMkfPx
         dqyg==
X-Forwarded-Encrypted: i=1; AJvYcCWtHb5IJa08stHQLe2UPhMkTYZbG9MLdqKiM1dwJTutU+bLZFttnYiOKS5RCxKEI8ycpyppT5o=@lists.linux.dev
X-Gm-Message-State: AOJu0YzsumW7KLWqF30Rh4RJN7ENSjZAK9E9fkX/v/tt8Bmnq/FXxJ1B
	ItoEO1hiwtmAwFoFQ6w80YVUR5aSDTKUlYEtPLaBAuFwQUg+hdA4XIGh
X-Gm-Gg: ASbGnctnnbqQqKHNRsQdTT3xAkM1eNqzLR9G294XD4ckrciMyyQI5HE2ckMR78C2LMF
	AjiEygD91RmwkyRSdBVaLUWgvsuUMGWc4EdYi2wVkr6u9mtXsABApJtmzcospskkZV/z5TFkNQE
	mulnYenkJJTrf2ozqXTSrlgpI6UUNXml33vDd2/MA/k3hry5cdx0zhB/7xsxXXsBtTXWHmf4BB5
	Xq/qHmXXGv+3me9BpvtAzwLZaYlC0Q0wUBqoUIlSJybscbPSNfHIGfn7OIojmXew68Df+q5aL92
	RYDEJ/u+aT5PES1tPEbvTFc3XT4BjnQzqVHj+fHGx1FpXgE04DKUOX26MSvjXG2ErkT7J/utImY
	/FIR08tOnjioqnFQF8ygEbFv/RudRN8Xnr0/BRuf+hzfiOVkywV4lv3KRre7/ui1n28poC25FfB
	LZVIXlaVxxj41SJX5TT7D5jjaKQhw49iLV42dw
X-Google-Smtp-Source: AGHT+IGhTyxFeqR9igVeBqBWn+wUpKZqJaNd+eYzO2qyYs02RGa4YjcZR/aWps1y1BeKKPbYGZ8Tzw==
X-Received: by 2002:a17:907:3c89:b0:ade:3b84:8ef6 with SMTP id a640c23a62f3a-ae34fd9327fmr706973666b.23.1751120493828;
        Sat, 28 Jun 2025 07:21:33 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c831ed361sm3047060a12.59.2025.06.28.07.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jun 2025 07:21:32 -0700 (PDT)
Message-ID: <753902f3-4b11-44f7-9478-02459365a8ef@gmail.com>
Date: Sat, 28 Jun 2025 16:21:31 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 nf-next 1/2] netfilter: bridge: Add conntrack double
 vlan and pppoe
From: Eric Woudstra <ericwouds@gmail.com>
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>,
 Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org,
 bridge@lists.linux.dev, netdev@vger.kernel.org
References: <20250617065835.23428-1-ericwouds@gmail.com>
 <20250617065835.23428-2-ericwouds@gmail.com> <aFhksV47fCiriwJ4@strlen.de>
 <9866f2d2-eda8-470f-99fb-5a8d6756de56@gmail.com>
Content-Language: en-US
In-Reply-To: <9866f2d2-eda8-470f-99fb-5a8d6756de56@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/28/25 3:27 PM, Eric Woudstra wrote:
> 
> 
> On 6/22/25 10:16 PM, Florian Westphal wrote:
>> Eric Woudstra <ericwouds@gmail.com> wrote:
>>> -	if (ret != NF_ACCEPT)
>>> -		return ret;
>>> +	if (ret == NF_ACCEPT)
>>> +		ret = nf_conntrack_in(skb, &bridge_state);
>>>  
>>> -	return nf_conntrack_in(skb, &bridge_state);
>>> +do_not_track:
>>> +	if (offset) {
>>> +		__skb_push(skb, offset);
>>
>> nf_conntrack_in() can free the skb, or steal it.
>>
>> But aside from this, I'm not sure this is a good idea to begin with,
>> it feels like we start to reimplement br_netfilter.c .
>>
>> Perhaps it would be better to not push/pull but instead rename
>>
>> unsigned int
>> nf_conntrack_in(struct sk_buff *skb, const struct nf_hook_state *state)
>>
>>  to
>>
>> unsigned int 
>> nf_conntrack_inner(struct sk_buff *skb, const struct nf_hook_state *state,
>> 		   unsigned int nhoff)
>>
>> and add
>>
>> unsigned int 
>> nf_conntrack_in(struct sk_buff *skb, const struct nf_hook_state *state)
>> {
>> 	return nf_conntrack_inner(skb, state, skb_network_offset(skb));
>> }
>>
>> Or, alternatively, add
>> struct nf_ct_pktoffs {
>> 	u16 nhoff;
>> 	u16 thoff;
>> };
>>
>> then populate that from nf_ct_bridge_pre(), then pass that to
>> nf_conntrack_inner() (all names are suggestions, if you find something
>> better thats fine).
>>
>> Its going to be more complicated than this, but my point is that e.g.
>> nf_ct_get_tuple() already gets the l4 offset, so why not pass l3
>> offset too?
> 
> So I've tried nf_conntrack_inner(). The thing is:
> 
>>  	switch (skb->protocol) {
>>  	case htons(ETH_P_IP):
>>  		if (!pskb_may_pull(skb, sizeof(struct iphdr)))
>> -			return NF_ACCEPT;
>> +			goto do_not_track;
>>
>>  		len = skb_ip_totlen(skb);
>> +		if (data_len < len)
>> +			len = data_len;
>>  		if (pskb_trim_rcsum(skb, len))
>> -			return NF_ACCEPT;
>> +			goto do_not_track;
>>
>>  		if (nf_ct_br_ip_check(skb))
>> -			return NF_ACCEPT;
>> +			goto do_not_track;
>>
>>  		bridge_state.pf = NFPROTO_IPV4;
>>  		ret = nf_ct_br_defrag4(skb, &bridge_state);
>>  		break;
>>  	case htons(ETH_P_IPV6):
>>  		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
>> -			return NF_ACCEPT;
>> +			goto do_not_track;
>>
>>  		len = sizeof(struct ipv6hdr) + ntohs(ipv6_hdr(skb)->payload_len);
>> +		if (data_len < len)
>> +			len = data_len;
>>  		if (pskb_trim_rcsum(skb, len))
>> -			return NF_ACCEPT;
>> +			goto do_not_track;
>>
>>  		if (nf_ct_br_ipv6_check(skb))
>> -			return NF_ACCEPT;
>> +			goto do_not_track;
>>
>>  		bridge_state.pf = NFPROTO_IPV6;
>>  		ret = nf_ct_br_defrag6(skb, &bridge_state);
>>  		break;
> 
> This part all use ip_hdr(skb) and ipv6_hdr(skb). I could add offset to
> skb->network_header temporarily for this part of the code. Do you think
> that is okay?
> 
> Adding offset to skb->network_header during the call to
> nf_conntrack_in() does not work, but, as you mentioned, adding the
> offset through the nf_conntrack_inner() function, that does work. Except
> for 1 piece of code, I found so far:

A small correction, Adding offset to skb->network_header during to call
to nf_conntrack_in() also works. Then skb->network_header can be
restored after this call and nf_conntrack_inner() is not needed.

> 
> nf_checksum() reports an error when it is called from
> nf_conntrack_tcp_packet(). It also uses ip_hdr(skb) and ipv6_hdr(skb).
> Strangely, It only gives the error when dealing with a pppoe packet or
> pppoe-in-q packet. There is no error when q-in-q (double q) or 802.1ad
> are involved.
> 
> Do you have any suggestion how you want to handle this failure in
> nf_checksum()?
> 

