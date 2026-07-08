Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F9F4C9018
	for <bridge@lists.linux.dev>; Wed,  8 Jul 2026 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783535776; cv=none; b=UCPdH8O8eKjiWBiB1yGVKclGO8lLow7wmhS87bLuW5k8kV8g7am8YSfBJt4HTj2P5aTYg6dT2QJvwzRQtnJVVTW3D4hxsrFgsQVv4KPw7KWGHUzvLgzzJIRhiiQFkupiN3pqQXD/BZfSlIKvlotFboXKZXaZE5RTDFo81r/9oX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783535776; c=relaxed/simple;
	bh=G2H2imZ4fo8dNzfLfERwGQavgPhokh01V8hq8+UsP8A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=f4NGW0IaVp7Z3bsCswyc1jeLW9HRt8F+b7zzYk5xy82E3lV+JDqNMi77XCd0WIxT5n5N7xP/48zwvoSFc/QV1ZOCQBLeg8QbkmmiJ3hLPZAHci8hlcqloVTHzdbWgAWYYTslXmyfB+MOxDXbh4kXfMH5aCaLRGusQuWSTY/TgOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rH3ivirS; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rH3ivirS"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c12614b81c9so188969966b.3
        for <bridge@lists.linux.dev>; Wed, 08 Jul 2026 11:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783535773; x=1784140573; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ynaYupb3vfef1dEfTEhXs8EICy43K01H4C9YfW8Cml0=;
        b=rH3ivirS1IzV4Nf8XUiAxed4sp37YNucjNIvd1nm/gUxx1JO2yI9fXG6MIx4X4u/O9
         lKWJlo9l/TckwhhMzf8jKKcAlklz/WMdU6TYj0/kYMnPM1GkVO2r5n92bnjEUmBPP1A3
         38XNCFaCT0ekt7/2OzijWSUE5DmuCm/BQrv3vu+3cfy+n3mzNgW8D2oigOp3bJ7QPWCZ
         I+vL4mjiuo/zh3uP9DZ8rY5z67EMVSGqgMKnhqBUNiZSXIBJRVQDt1UgsMwPVoZMygG4
         u9FW+ZFImU/BKTt33c6VP8yvuzeuZK7+h2E1ORQoV2e+okn2E0sZT4puhDUJjdQn3x69
         UWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783535773; x=1784140573;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ynaYupb3vfef1dEfTEhXs8EICy43K01H4C9YfW8Cml0=;
        b=PkbYKulm8v0QlmPuFPK2Eg327k9VOYPlrSVR2oPYuyJGzzWERU/lQKnpgyl+tydzfl
         iwVsTNe0BxjV/NIXk0HhG8R5YI3nCBefyEHNl74UG7XAJF4KB59vXi1citDAeCukutAH
         4KWbZJhkyJXlrSncalIHPZuVFJqHyn8iIiuRnQnS65wYHgAt04U9hWJ0lM5tq5iQWUnI
         jnBq0Yd9b+VWDnAjVJNVTOnY3tcumdbLfSojeHmPehLsLh22zQODg99yCCKRDJBSHHMJ
         V/k2wSa9X+8/ajn9nFapw/VzQhoyoDTMFZ0OMRpsg05+1jGed5HrAIYrj0EtYtTl13CL
         iPZA==
X-Forwarded-Encrypted: i=1; AHgh+Rro2AHmBFjF4yF5nBzGia0wleffkgG5i4SfxC8O9A1oWjs3X6/UyZdYxP0Id0/iu20bpJ9R1FA=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6j1IAH8XVHsWOMqEp7Rgr2Iym36uO/KdJ/6cTBhd+HAhlx2B1
	/IM3FwS3t6+lVUVxU1WcauNxmhNjo/3cQniyuH2fWh2HRdTNZr6cFUNrz/HFCA==
X-Gm-Gg: AfdE7cm0uvt8L1B+zexmMnR+n6AoV4cVgtCWhD7qN5CECzeXtC3UQne0ZLnj9KObzVn
	Yy/g5dLHt3kICyooPMq0S28LhZo7YHq6uf5WDXAq7RCrRvEv/0nOuVc94SLvrV+0zpnZUI76NsW
	6/0MjSvliYqdM4xP6npqcyxi+tHJGiwHy2TEv/PwwlFgd8vBEHWmmnzizbk8MQXb6cZM2HKiaJ0
	AF9FYIWzF6ykpkZu8LrJEfgR1hIqZpaf04pp+KhbPKo7InjochBcoklF86ZJit8isRV3c5oV6wi
	kGwMCcx4O1EyzL+RsESZJBn8jsocnKdnARwpqwi+M/rL9iAGqP9uLI1CEMBIyDake8PFLgrN/GE
	K/hjsZzEf+d5GbXDMBpWs/18XlJ9dM+swjCm90CF2Nw17nAP3rrhuVxbzi0ON0Kd6j3500Dvv2S
	q8nK2ff2UAfXfd8E0lXPX3xuh5RpwfPlEgf9XNp6NeF2G4ofgtcTf6G3ZTBcZIL6VwAxAGHqaeG
	WpkZkhIXcsxChSkdEVwvvCgfZqD5BApHfPPDzXQztUxIiI5hhMtGyQVJ4cnLovgvJoye3ytl8sb
	KlQqkZPHk5mwUP5/C50v9k8NXFUUMvpnLA==
X-Received: by 2002:a17:906:2e9a:b0:c15:c3bb:c90a with SMTP id a640c23a62f3a-c15ce18c8b7mr128361266b.35.1783535773134;
        Wed, 08 Jul 2026 11:36:13 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15d5de95e6sm115505766b.39.2026.07.08.11.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 11:36:12 -0700 (PDT)
Message-ID: <81c3bf65-b19b-4f80-aa8e-c0c4b3f5d6a7@gmail.com>
Date: Wed, 8 Jul 2026 20:36:11 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Eric Woudstra <ericwouds@gmail.com>
Subject: Re: [PATCH v12 nf-next 3/7] netfilter: nf_flow_table_offload: Add
 nf_flow_rule_bridge()
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
 Phil Sutter <phil@nwl.cc>, Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Stanislav Fomichev <sdf.kernel@gmail.com>,
 Samiullah Khawaja <skhawaja@google.com>, Hangbin Liu <liuhangbin@gmail.com>,
 Krishna Kumar <krikku@gmail.com>, Martin Karsten <mkarsten@uwaterloo.ca>,
 netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
 bridge@lists.linux.dev
References: <20260707091045.967678-1-ericwouds@gmail.com>
 <20260707091045.967678-4-ericwouds@gmail.com> <ak4dAXHDmTDRr7-b@chamomile>
Content-Language: en-US
In-Reply-To: <ak4dAXHDmTDRr7-b@chamomile>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/8/26 11:48 AM, Pablo Neira Ayuso wrote:
> Hi,
> 
> On Tue, Jul 07, 2026 at 11:10:41AM +0200, Eric Woudstra wrote:
>> Add nf_flow_rule_bridge().
>>
>> It only calls the common rule and adds the redirect.
> 
> I decided to use the new _unsupp() function, so we don't pretend
> bridge hw offload is already supported. We will need a driver before
> we can add this, this stub does not provide much. I guess your goal
> was just to avoid a crash here.
> 

No, I am already using hw_offload between bridged interfaces
on the mt7986 succesfully for almost 2 years.
It works dsa-port to direct interface (lan1 to eth1 on Bananapi R3) and
between direct interfaces (eth0 to eth1 on Bananapi-R3-mini)

It can also be tested with my bridge_fastpath.sh selftest script.
This script uses veth-device pairs to test the software fastpath.
It can also use 2 real interfaces interconnected in a loop of copper,
when chosen with commandline arguments. Then it tests software- and
hardware-fastpath. It also tests many different scenarios.

So this is why I've added it, as it is already functional. If a software
fastpath is setup correctly, the hardware fastpath is also functional.

>> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
>> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
>> ---
>>  include/net/netfilter/nf_flow_table.h |  3 +++
>>  net/netfilter/nf_flow_table_offload.c | 13 +++++++++++++
>>  2 files changed, 16 insertions(+)
>>
>> diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
>> index 7b23b245a5a86..5c6e3b65ae85b 100644
>> --- a/include/net/netfilter/nf_flow_table.h
>> +++ b/include/net/netfilter/nf_flow_table.h
>> @@ -368,6 +368,9 @@ void nf_flow_table_offload_flush_cleanup(struct nf_flowtable *flowtable);
>>  int nf_flow_table_offload_setup(struct nf_flowtable *flowtable,
>>  				struct net_device *dev,
>>  				enum flow_block_command cmd);
>> +int nf_flow_rule_bridge(struct net *net, struct flow_offload *flow,
>> +			enum flow_offload_tuple_dir dir,
>> +			struct nf_flow_rule *flow_rule);
>>  int nf_flow_rule_route_ipv4(struct net *net, struct flow_offload *flow,
>>  			    enum flow_offload_tuple_dir dir,
>>  			    struct nf_flow_rule *flow_rule);
>> diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
>> index 002ec15d988bd..5566ebda7b7d3 100644
>> --- a/net/netfilter/nf_flow_table_offload.c
>> +++ b/net/netfilter/nf_flow_table_offload.c
>> @@ -740,6 +740,19 @@ nf_flow_rule_route_common(struct net *net, const struct flow_offload *flow,
>>  	return 0;
>>  }
>>  
>> +int nf_flow_rule_bridge(struct net *net, struct flow_offload *flow,
>> +			enum flow_offload_tuple_dir dir,
>> +			struct nf_flow_rule *flow_rule)
>> +{
>> +	if (nf_flow_rule_route_common(net, flow, dir, flow_rule) < 0)
>> +		return -1;
>> +
>> +	flow_offload_redirect(net, flow, dir, flow_rule);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(nf_flow_rule_bridge);
>> +
>>  int nf_flow_rule_route_ipv4(struct net *net, struct flow_offload *flow,
>>  			    enum flow_offload_tuple_dir dir,
>>  			    struct nf_flow_rule *flow_rule)
>> -- 
>> 2.53.0
>>

