Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F288634DCEE
	for <bridge@lists.linux.dev>; Thu, 11 Sep 2025 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757605294; cv=none; b=svUvImy1FwxgUw3uLVrzKY/dMCev/4am3PbUmXg2GxYhAISgTuP0Pr+QSOXSEFzzjRKyzMzWKI5mUH4eXapBrRjGocAf+su0vwOxj0TSPd0n50XXXI4/25A2+4FNuAy98zCgzxqTMLNtmrr95OOd2xbDqmeZ2K+0D5V48VXClJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757605294; c=relaxed/simple;
	bh=TAt1xvybF5A6IPhp1Tj8CnOrxrbMgnAq2MtsexDeswg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TUkVYRq7cfgpiw/U+28ocKUd9jcd8B8rmVYefwr5gWmgPeFeFO7U74kNwKYEYWA7mfSW/aYg47ncQjA4XB/xZAy/dFcZZPk2NirjxX/F1BII0CItHIa8j8kN7o8bI6WCs6MorHF4fuf/Dan1Zh8id1rQdS82ebo9Db1MrXJFzTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fb7lrVx/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fb7lrVx/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757605291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xqCLZ5lR/ej010vRnUI5sNuPZaZKzMiy4/gIS4eczMw=;
	b=Fb7lrVx/jlABTtVyNyxIZ4dU2RSE1gq+9Gmc2tjMQgSmSV07eJxrI7K99nvN0PSYXq/sYe
	NyYJo2bpMYavobSCgCOFPjZDYkIbLZLe2YMhCIrgSC0RSfnS6ncABnOJnSOJipD6LjNe8z
	r1+Xhi0or9CgihoVcBcc2XYY0BF3FkM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-0BGrSh9-M3iKuVz1hjwVfA-1; Thu, 11 Sep 2025 11:41:28 -0400
X-MC-Unique: 0BGrSh9-M3iKuVz1hjwVfA-1
X-Mimecast-MFC-AGG-ID: 0BGrSh9-M3iKuVz1hjwVfA_1757605287
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45df9e11fc6so5695635e9.3
        for <bridge@lists.linux.dev>; Thu, 11 Sep 2025 08:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757605287; x=1758210087;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xqCLZ5lR/ej010vRnUI5sNuPZaZKzMiy4/gIS4eczMw=;
        b=b6zg+6UOSO/wmU5jhEosgYZRaMF5BrDh0Hxdxs+bWJ9EczypZqeM1DNwpVIgZ6bbfe
         O40YI9EPFk9bJfyLCcDlRmlshW+pokVGGjUFGAlv5RkeKcNEe90l1v7CD7NaY3GIHaJY
         ggKJv9Z/xYq0FhnUZ6vovBfcb/SHwHrndjwQxIP/ZQfgCeQsOvjtkGdGJeMe74Vg5vZK
         kaSowlCA7t7VIqxP5AwrFyKnZU+1kVLnn1HSlu5cNF2oAsAIvL7IE1dJK7VUHJLm9Ulx
         bZYoAuDyZ6t2yPUGag1LZAcNCZHRtkhC1DB9WXn7CogBUqRDAFJlZw1NwL2gfphsN4j3
         qKww==
X-Forwarded-Encrypted: i=1; AJvYcCUvpjfXY/M7fANMbgjg9+Cp3XmqnLo3CluXRBU4yUYhsMUC/GWYoSg8NFzxo2KzcSD5cVdZz/k=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3XXE5eLe7xI5OItZ1C+Zfl/yIqKNs8mwC0DWo90QAI4TYFtO2
	H9eqk8PHnktj+ewLwMC1wlhzFKg/ID4UGLIYOwWsejdRLV3QzehqI6WkKsNZtb9ynQHnA4mk3GS
	jyD1rTJDQJhoYhXTcsRHD2hx/+jd5YlES9fXt6U9GF7yJNxAKkzomSlpRSA==
X-Gm-Gg: ASbGncupjMoZAxkcfdpDjZm16v4ldah6I7a9ZN/oO/UzDjR47T1VUbOuNm1hyriW/kN
	2x2j73e4c4upiKist2luHNK2k0VWfqMMyYrM5oMq8SnQd4XX1bUpFUfV9oZXRLdUOzIZ04+qUoJ
	DyTltZksUqg7sAilF1DRNQPdtFYaLgus4XoeEFHlzpY+Pj2sdFk48Bxtm1sGWGQzBlFXmrjLFQ4
	PR60xxE1DukqwpTi2waNrmig7jaxNqBC0f8UIJXBE/L8LvhISs3sNpctlfhI59hPWqFZJCfK6dN
	DtXZPO66fmhVxENuPDCjBMPjFoW5lJyLJecPTMkQwwE=
X-Received: by 2002:a05:600c:4750:b0:458:a7fa:211d with SMTP id 5b1f17b1804b1-45ddded6df8mr160615625e9.29.1757605287330;
        Thu, 11 Sep 2025 08:41:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3/syyS4kZMgaPRW3J7fU9zkQugCn/+nk/LBJjNNnNcoKhiA39KMLoKttFsUa5rSoKfoQvDw==
X-Received: by 2002:a05:600c:4750:b0:458:a7fa:211d with SMTP id 5b1f17b1804b1-45ddded6df8mr160615275e9.29.1757605286860;
        Thu, 11 Sep 2025 08:41:26 -0700 (PDT)
Received: from [192.168.0.115] ([216.128.11.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e016b5a2esm30986725e9.13.2025.09.11.08.41.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 08:41:26 -0700 (PDT)
Message-ID: <cd37574b-0c15-481d-84dd-8ccc830efd06@redhat.com>
Date: Thu, 11 Sep 2025 17:41:24 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 net-next 5/5] selftests/net: add offload checking test
 for virtual interface
To: Hangbin Liu <liuhangbin@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Stanislav Fomichev <stfomichev@gmail.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, bridge@lists.linux.dev,
 linux-kselftest@vger.kernel.org
References: <20250909081853.398190-1-liuhangbin@gmail.com>
 <20250909081853.398190-6-liuhangbin@gmail.com> <aMGR8vP9X0FOxJpY@krikkit>
 <aMJyC_YNjVWcB7pe@fedora>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aMJyC_YNjVWcB7pe@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YLL0mKT1bisvuLoiPrVGILomMmZtHhsi-pJ6B461IGA_1757605287
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/25 8:54 AM, Hangbin Liu wrote:
> On Wed, Sep 10, 2025 at 04:57:54PM +0200, Sabrina Dubroca wrote:
>> 2025-09-09, 08:18:52 +0000, Hangbin Liu wrote:
>>> +__check_offload()
>>> +{
>>> +	local dev=$1
>>> +	local opt=$2
>>> +	local expect=$3
>>> +
>>> +	ip netns exec "$ns" ethtool --json -k "$dev" | \
>>> +		jq -r -e ".[].\"$opt\".active == ${expect}" >/dev/null
>>
>> Sorry Hangbin, I should have noticed this when we discussed the IPsec
>> test, since the problem is similar for the other features set in
>> netdev_compute_features_from_lowers:
>>
>> `ethtool -k` does not test the dev->*_features (mpls, vlan, etc) set
>> in the new common function, it only checks dev->features and
>> dev->hw_features. So this will not test the new function.
> 
> Hmm, that make the selftest more complex. A very easy way to verify whether
> the feature is set is using tracepoint. But Paolo said adding new tracepoint
> is not welcomed.
> 
> Since all these flags are fixed after compute from lower devices. We need to
> find out a proper device and test the features are inherited.
> 
> The next question is how to test gso_partial_features, vlan_features,
> hw_enc_features, mpls_features (maybe also tso_max_segs/size in future)
> effectively.
> 
> The veth device only has hw_enc_features and mpls_features, while it's 
> hw_enc_features doesn't have NETIF_F_HW_ESP. The netdevsim device only have
> hw_enc_features.
> 
> 
> For mpls_features, seem we only able to test NETIF_F_GSO_SOFTWARE, but I'm not
> sure how to check mpls gso..
> 
> For hw_enc_features NETIF_F_HW_ESP. Does sending ipsec data and see if
> netdevsim has pkts count enough??
> 
> Any advices? Should we just drop the selftest?

Uhm... one possible way of testing netdev_compute_features_from_lowers()
correctness is transmitting over the relevant device (bridge/team/bond)
"arbitrary" GSO packets and verify that the packet is segmented (or not)
before reaching the lower.

GSO packet injection can be done with some work via the tun device (in
tap mode), and the virtio hdr.

That is limited to some GSO types (i.e. no ipsec pkts), and can become
easily very complex.

What about giving it a shot for UDP tunnel GSO types?

Thanks,

Paolo

