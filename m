Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD882F90CE
	for <bridge@lists.linux.dev>; Tue,  4 Nov 2025 19:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762283415; cv=none; b=qUuYTu/fexSs/3VitmcImZdW47Fz0P9dWe78WRiA3Rp5pxKyONlVEbPYZe2Rj+oTWFTAvTnZELERED3Gkt8oUCCg31KYlXRcqODywI9SkiltvuC6WFrw2EOaInIClVBSaWTfb6U77dcCa3jERAtayenRc7azjJAmzzL5WyQ6Brg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762283415; c=relaxed/simple;
	bh=9LWKCVKfpkLorLNhfnXcCyl5zFVxqyoqSkP/ChRZHu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LU25ZIQd8WeFQTkJ34UTkdiBafygfIP0AVOJLl3vNH/GuSscDgSS9UjIQ33frZ6q9amOmmAFtMNBjmJOHwKZgSCZ04gg+pxEhnMSJ4PhbfUmCiV8qotwfAnni4vTzVS+zEJrbVqcCNb2mDoOg/YJyvpJr19T5cyuA9pg5SkB2ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=T575Vh5f; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="T575Vh5f"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b64cdbb949cso1048144166b.1
        for <bridge@lists.linux.dev>; Tue, 04 Nov 2025 11:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1762283411; x=1762888211; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pHPzEXIUZ9pzwlZg85xxsGY9keDqq8RNI/L/RPCgfS8=;
        b=T575Vh5fvuCxpC6QMhGva1E2D6iOcKyBqV070n8fR65/lefFm8pnhxD/zbtD7xCh3T
         +KtjdExsESI9+wJSeYZ148x2JRFf7sFsTOMhukwfZzxYjtTcSd/Pytf7GjtDbuHRGe5B
         etLes5LN1iy2pA+4rmHtnqkbiHNj2CJJscAJvvALT/AIu5PYdHeAIkrshg8eYOOn9ObM
         YM3qiIgCxBhrmT3+fxrVa+k5eB70X1/LT70RcIn/OO4tN/nMb1AdMew4ENM99vhVctjw
         9TACMEL0bxmKSxfxOSJYhRtWeh6X6ugLnR9aOglbTu0hjIrsVxRAo8KShu0JesEN4xpn
         PBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762283411; x=1762888211;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pHPzEXIUZ9pzwlZg85xxsGY9keDqq8RNI/L/RPCgfS8=;
        b=OEVc90ZjF0RIK3DF3jUOAr60NNpstibKGqtVKA7VBg6CpyzML5VbdyVKb+NNbdmmcw
         1TiC9zLJrEQnvuj00FBqKf6ueAmgwKMa7pvvhhRzLzU/N4qXlhKcTJjHp3ibmkxMw6kq
         0fwH07lArL841dzLjIkbbC2Y3J56apeUI8XPLYD8Yec0e1tvt6zfr5HAZoJ2vGO/ZKuG
         kA6ml+Icv/g7CckGy6KkBgio6cjcne555dO0brz7dglL1Fp2SecxvCSGvpschoshR+/i
         HFsjUs13lhmX/Q+6LJW39dVH6M7EDWHya0a3jEmwNh8P7R9qtUYEynmkyjynIKHKta8d
         4l6g==
X-Forwarded-Encrypted: i=1; AJvYcCUzSh179+MD2gUMqw36MHZZb9GQZ58vuSMHM1Ajx7wzfehyUokae4jlSZ6/wEKPim34m0YG8hQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YyVWy1mkmDWS6iFD2025iOIwmiuNpDR1p9zwlpMn0kLhFpleqFU
	b64OtYlwtsW75TtU43YQ4+Uv3ssBymz90EePCzfZv2Y9PLTCTjs4i9fq9hIKENqMLi4=
X-Gm-Gg: ASbGncto37UuDemaF52BSH7hsa97Zb83WHxT5BU1wtygKalUb+N+6czSrkeX2+YCjPi
	pKmqw/59h8hKVASvluoGJTxF9ajy1b4MHTS6AiOTd5jiH4eIENDZzHcXNQuyDH7k8RrRy866w3o
	NDAvuge22UcLwy/QgmqMqg5/ie7Ck+A+2LgBtcZAO2mo73JEDxNjoaB1jINdghyf7rd08UF39e3
	WDniCiE15AmDcNOV5YqPJ85/IMS4J1B0k37d1tPLuWa+K1VMOKLch6bFCMtvdaL8/A/e4u/4ZX4
	V33diF3VDBcLKBlUwZK/0HyyVyPwy0SiXQiyamrq9t1+RP3Euxzvx0RKj97tq8oT55/F4YikJs5
	AaWtU34CinX/s2qKLksri1j0XhR+1oPG0+CcVeIcNPhNH6RuZrGLypxT12QyzTunyqq5bSZL9wg
	CaK59ZpePQ1r4oed7kKzM9CkpW9gXr6l9D
X-Google-Smtp-Source: AGHT+IGVSDgEL05gD1VP583K60Rshyb4V0TRe73xfvSbKrRc1EoanFAlaR1O1a/+yOYg6dakhlj2rg==
X-Received: by 2002:a17:907:72c6:b0:b70:b4db:ae83 with SMTP id a640c23a62f3a-b7265605335mr26751966b.60.1762283410700;
        Tue, 04 Nov 2025 11:10:10 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d7030adsm289300666b.24.2025.11.04.11.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 11:10:10 -0800 (PST)
Message-ID: <2252e81c-fe49-40aa-944e-4c94d5de563d@blackwall.org>
Date: Tue, 4 Nov 2025 21:10:09 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] selftests: forwarding: bridge: add a state bypass
 with disabled VLAN filtering test
To: Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, tobias@waldekranz.com, idosch@nvidia.com,
 kuba@kernel.org, davem@davemloft.net, bridge@lists.linux.dev,
 pabeni@redhat.com, edumazet@google.com, horms@kernel.org
References: <20251104120313.1306566-1-razor@blackwall.org>
 <20251104120313.1306566-3-razor@blackwall.org> <87qzudn256.fsf@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <87qzudn256.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/25 19:15, Petr Machata wrote:
> 
> Nikolay Aleksandrov <razor@blackwall.org> writes:
> 
>> Add a test which checks that port state bypass cannot happen if we have
>> VLAN filtering disabled and MST enabled. Such bypass could lead to race
>> condition when deleting a port because learning may happen after its
>> state has been toggled to disabled while it's being deleted, leading to
>> a use after free.
>>
>> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
>> ---
>>  .../net/forwarding/bridge_vlan_unaware.sh     | 35 ++++++++++++++++++-
>>  1 file changed, 34 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/net/forwarding/bridge_vlan_unaware.sh b/tools/testing/selftests/net/forwarding/bridge_vlan_unaware.sh
>> index 2b5700b61ffa..20769793310e 100755
>> --- a/tools/testing/selftests/net/forwarding/bridge_vlan_unaware.sh
>> +++ b/tools/testing/selftests/net/forwarding/bridge_vlan_unaware.sh
>> @@ -1,7 +1,7 @@
>>  #!/bin/bash
>>  # SPDX-License-Identifier: GPL-2.0
>>  
>> -ALL_TESTS="ping_ipv4 ping_ipv6 learning flooding pvid_change"
>> +ALL_TESTS="ping_ipv4 ping_ipv6 learning flooding pvid_change mst_state_no_bypass"
> 
> I think you'll need to adjust this test for v2, can you please change
> the above line to the following while at it?
> 

ack

> ALL_TESTS="
> 	ping_ipv4
> 	ping_ipv6
> 	learning
> 	flooding
> 	pvid_change
> 	mst_state_no_bypass
> "
> 
>>  NUM_NETIFS=4
>>  source lib.sh
>>  
>> @@ -114,6 +114,39 @@ pvid_change()
>>  	ping_ipv6 " with bridge port $swp1 PVID deleted"
>>  }
>>  
>> +mst_state_no_bypass()
>> +{
>> +	local mac=de:ad:be:ef:13:37
>> +
>> +	# Test that port state isn't bypassed when MST is enabled and VLAN
>> +	# filtering is disabled
>> +	RET=0
>> +
>> +	# MST can be enabled only when there are no VLANs
>> +	bridge vlan del vid 1 dev $swp1
>> +	bridge vlan del vid 1 dev $swp2
> 
> Pretty sure these naked references will explode in the CI's shellcheck.
> I expect they'll have to be quoted as "$swp1".
> 

Oh haven't written selftests in awhile, I've missed the shellcheck stuff. :)

>> +	bridge vlan del vid 1 dev br0 self
>> +
>> +	ip link set br0 type bridge mst_enabled 1
>> +	check_err $? "Could not enable MST"
>> +
>> +	bridge link set dev $swp1 state disabled
> 
> Here as well. And more cases are below.
> 
> I've got this in my bash history. Might come in handy.
> 
>     cat files | while read file; do git show net-next/main:$file > file; shellcheck file > sc-old; git show HEAD:$file > file; shellcheck file > sc-new; echo $file; diff -u sc-old sc-new; done | less
>
 
Thanks for the hint. I'll add this to my patch review process as well.

Cheers,
 Nik

>> +	check_err $? "Could not set port state"
>> +
>> +	$MZ $h1 -c 1 -p 64 -a $mac -t ip -q
>> +
>> +	bridge fdb show brport $swp1 | grep -q de:ad:be:ef:13:37
>> +	check_fail $? "FDB entry found when it shouldn't be"
>> +
>> +	log_test "VLAN filtering disabled and MST enabled port state no bypass"
>> +
>> +	ip link set br0 type bridge mst_enabled 0
>> +	bridge link set dev $swp1 state forwarding
>> +	bridge vlan add vid 1 dev $swp1 pvid untagged
>> +	bridge vlan add vid 1 dev $swp2 pvid untagged
>> +	bridge vlan add vid 1 dev br0 self
>> +}
>> +
>>  trap cleanup EXIT
>>  
>>  setup_prepare
> 

