Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1A5280309
	for <bridge@lists.linux.dev>; Tue,  9 Sep 2025 09:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409459; cv=none; b=p497c0tzsPxdw5QvLyUXr5L9KZJ7VWlgetEB0oIX8rAWrmPyJtGdRPKTBziRPGGy+TBxg6KgQ2A/erpnQmLtOo+DozDzlOOwr/T9t3tQQQQ8y34hmA8FZFKGijKEV/dktseY9P9cqvF/BDpQsqRU583rxPEWOl3gWVfa/EPCKMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409459; c=relaxed/simple;
	bh=IslIkKU+Rjs6YxP9rj6x3SrZ3vjFO+B3Wb8sbTWyDBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KmEezjMGvoy+iqzIfa+XJ8swmF6N4Ij39crZZM0DhpvyZjxIkM0iY3nzAKjhb3NGfYyB2GXg8/DOCLzVxjRLuMMkDkY9NnUPw82zkYn+z1CeFNwbSxZehWK7mnMpWNSXc/W4ODoH+H+4quXVmf0hMfutNuxF/vZhrN649vflD0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlAWLwze; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlAWLwze"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6228de280ccso6328064a12.3
        for <bridge@lists.linux.dev>; Tue, 09 Sep 2025 02:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757409456; x=1758014256; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RfbsNx4Ej0BLDskNnIJhjW/8RtalgNanAogt81Ea4Yg=;
        b=dlAWLwzem6+HRDXIsyB1AMPbOV3HyjyKy4Y8Qyq/fq+RouzZVKB7M+EXA3CeYAYDVD
         3+spP9jPh2jftUkst+U3l69DC042Ffc3M4m8Vdk5NUT+uhV+/10UNKdpj4tO/W+xx58b
         75VOSnPfpqc3hRg14VlauILvacFCgekX7m5owTaRqUuHDUwya6fr+tfHpq4krOKZsKjK
         w7OMgjsysWCwtSYpj7Ba7hFzYUNhlv86/4q8AXMSXiAJOUBVvtH+74Q8L1u0RFBolZ8+
         +GaRHlJsEuTV5io2RXntRHyuPDKfMuTzAV0Ya6iJUga1mhQvgc2JmFqGL0EEDfEQNwiA
         j0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409456; x=1758014256;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RfbsNx4Ej0BLDskNnIJhjW/8RtalgNanAogt81Ea4Yg=;
        b=rwhspHxkbbNksU6+SZnO0y30ySzoHRg/zp/zSaF9bsKIwTGaunisQl4eJMNED/qtuY
         J6eFC7Jd3XHSIvSLDudIAgj5vzaEgKLVY4I1tFSSq5KChL7/9WwKcwmKrcQoNwvLLcSP
         ZNzWiwuPtMOS9X5JLDEt9xT1U9klCYU93pccMXCD2waBU1qrwftt3FTgcm3FAwfvidxS
         RcgGahKNugm5GTLtZ/wgRbyzMgxQ5FsjsCUvud6XxBb33TmW265SO1CI9qIyB2GUcrQD
         XMji1LWwNhciX7/BYaNdcRUb5d8Jw91TYbwD4gmCwVJ89H5BRi8pm7gk3B8L4rkZVX1N
         KYCg==
X-Forwarded-Encrypted: i=1; AJvYcCU10UkSdA8HW5hJvs6pjfRi7SKrCaJdXlCTPMXNf8etqQhoS0B3u9OJU9S38OpMavAq9471SNs=@lists.linux.dev
X-Gm-Message-State: AOJu0YzGUdeLSa7T2bWo0it8OUyhf6IEhfsVi39KqFfLtW/Jism59o3s
	JgrVd/2lAJdw3TXXCcPp7UBn5Gn9yPQ4OJY/m9nQe6Vcb0xT2l5qXE+7TJ/Zlg==
X-Gm-Gg: ASbGncsyRtNWbwT+DYAdcvGDTuKpdpP4RRj7cC4yQNCHN4cChsJ4VCHXEnsM0q3mB5a
	q6Tyav9MX42liMKftFfmK+KDu5fcwoOaSrcm59gAFCq/13o6d8sPZWmVn+eGC6ePWHN0adMMrYx
	7gfu4YWtj8+Z4rrOEy+93k1QIdQklRpiPeOLR87ddEu60Nr9FJJmSGs+GN3upkYtWkfwEVFmxmw
	UwV6HStxbEeTTENCrEjI8ivuOODNDyuxxR8J80DJkNuTs26p0WI+Vw5Dgpf6BuEy16VS/PNghH7
	SkdSyeEDRXaVviayA4O+4tZAyOha+VQaCHV4JC0JJxcnlE9Y90EOz8TPhxYDyJWRrMYV6i71OKE
	reS3kt4jkljfTN0+TYe4Z0oaAigLurIqS6rOAnhsyEkjPEcMOloB9HbohwlN5prSdttQTozQ2fW
	0+G0NXVeZO9lB0dOvhqPcAhlsBQUN3FPefXn+clXQlx+toY/oWQIgB3hnXtG7Ne846voheKmtfp
	YpJTpkU4H55lFZ8DlhfNYBmCnNXRb3a6F1p/jBggMGg05KCvgm6RA==
X-Google-Smtp-Source: AGHT+IE/jQZDFMcQ7ZjTIQ0R6zDdXt1M25FWMQrxtYZGtY8aZZ0XMyUZqgcncvmNU5vjzg8lOByEVA==
X-Received: by 2002:a17:907:98d:b0:af9:8438:de48 with SMTP id a640c23a62f3a-b04b1737677mr1226832366b.48.1757409455477;
        Tue, 09 Sep 2025 02:17:35 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff0d9b1b53sm2546820066b.96.2025.09.09.02.17.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 02:17:34 -0700 (PDT)
Message-ID: <49a5ae30-2fc7-4695-829f-1eb5b041aeaa@gmail.com>
Date: Tue, 9 Sep 2025 11:17:33 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 nf-next 2/3] netfilter: bridge: Add conntrack double
 vlan and pppoe
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>,
 Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org,
 bridge@lists.linux.dev, netdev@vger.kernel.org
References: <20250708151209.2006140-1-ericwouds@gmail.com>
 <20250708151209.2006140-3-ericwouds@gmail.com> <aLyjgj5CP5KIvUdl@strlen.de>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <aLyjgj5CP5KIvUdl@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/6/25 11:11 PM, Florian Westphal wrote:
> Eric Woudstra <ericwouds@gmail.com> wrote:
>>  	enum ip_conntrack_info ctinfo;
>> +	u32 len, data_len = U32_MAX;
>> +	int ret, offset = 0;
>>  	struct nf_conn *ct;
>> -	u32 len;
>> -	int ret;
>> +	__be16 outer_proto;
>>  
>>  	ct = nf_ct_get(skb, &ctinfo);
>>  	if ((ct && !nf_ct_is_template(ct)) ||
>>  	    ctinfo == IP_CT_UNTRACKED)
>>  		return NF_ACCEPT;
>>  
>> +	if (ct && nf_ct_zone_id(nf_ct_zone(ct), CTINFO2DIR(ctinfo)) !=
>> +			NF_CT_DEFAULT_ZONE_ID) {
>> +		switch (skb->protocol) {
>> +		case htons(ETH_P_PPP_SES): {
>> +			struct ppp_hdr {
>> +				struct pppoe_hdr hdr;
>> +				__be16 proto;
>> +			} *ph;
>> +
> 
> This function is getting too long, please move this to a helper
> function.

Ok. At the end of nf_ct_bridge_pre() I've added:

>> +	if (offset && ret == NF_ACCEPT)
>> +		skb_reset_network_header(skb);

to reset the network header, only when it had been changed.

Do you want this helper to return the offset, so it can be used here?
Or do you think it is more clean to always reset the network header like so:

	if (ret == NF_ACCEPT)
		skb_reset_network_header(skb);

(Same question for nft_do_chain_bridge())

