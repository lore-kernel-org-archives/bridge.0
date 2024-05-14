Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73EE10949
	for <bridge@lists.linux.dev>; Tue, 14 May 2024 07:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715672781; cv=none; b=h44Uydiv0OGyZBFYxHYEPDhWENTfhL3Otf9fKUtHxZVQ61d8Cw3ESbF69y/QReXnThiFsTcE+jyF4P09Ut4aIeVyzmZ3tWZRrbjzZLxj2qGPIamgUflDUgkAFlW0D9GNw/u+AM42ufO/K4BIMXz4ehvVvA3bGThO4x0uwVWOE+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715672781; c=relaxed/simple;
	bh=TI7CuHv7Bc8Mde29ebJ3dkKcJVDO0enjEg10beUDF1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fsr42CGqjBZxide69o+v2xf0WHmRh4HoHUJTmkuQ7bThLGX3BlOzsoWiixe/v5vtxWKuXc4DI8Mv4BlRZTHc4t88P5U8uS32K/qG/1WtC/4yP0VSt1qxvSjwdXPiUpTxFZ9gh1KXdq4HC2R1yuaJStY1u+cvesTBBABkWWerApE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=mn8Rb2R8; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="mn8Rb2R8"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e52181c228so40784311fa.0
        for <bridge@lists.linux.dev>; Tue, 14 May 2024 00:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1715672777; x=1716277577; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oh4KgwiBO6fXkK0I7THVbAVuWnA2rhOlc36ThKqDO4E=;
        b=mn8Rb2R8+YGnQ47i5AQ+Hz0Y3RDLGhvv4/z8D0QiorBLY8IFMkc6VdgQIevvGCSls2
         ATujNZrnv6UdkeTAh391VHuAVHd4CzdpktBCmrNX2ZBdhbyFvvMWs7zzmru4tNij/2SA
         AeyDiGrWPE3M7SlsM51EHWob8qv0nyQ3FN/Xxeqslt2P6RC68/HTRda+7lOjONWTp4RB
         uqvsjCTA19wUcKOOWc/YZQsJADixgF+U95DIfa3rFXtjbI/uqsvBmFOtEMdjMThA1Oo2
         R7ad4mzKEYb73yHLTI1aMDOuKl0BUV40CrUl20bC80Fj9hZE3sXJmj1s8w4Kba6GQYCm
         dWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715672777; x=1716277577;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oh4KgwiBO6fXkK0I7THVbAVuWnA2rhOlc36ThKqDO4E=;
        b=Tu6Ifo6ZXfTNTGupcWbUpo53ikp3nkibDeiMgaTSRR5OndxGVYwgVhK/N6Le3qRscm
         kORC7CFDB8s0xhHEqMpzn9uZp7KP2d3leCSts/7iXh3Ersno6GwRtyu8WuQbgHTGPF9U
         HqPAG8Pp+/Z6lr+cveWEFIrRxdA+sQFHD/TFoAKWffB5icMnKMZJkkFnkjBFw35Vvkk6
         piXqKiJ2mANFJeBiAL6H/Qhog21CAOBAXUz9ylQvxb81xjem4xLoM+ZQHwZBHSjA5AT6
         RNEkQuMY8x/qzGadI8EACRfjf3450OZPAm5FLWobrRVJOPdQi9py3ZD7Gjwgj/uMxNuD
         5rHg==
X-Forwarded-Encrypted: i=1; AJvYcCUSHMbLiGvwMp6VuKTFV0gHLTVuYw5ymsE4E/aRak2hAsHJabK3FtfVfAm742VBS0ZsTSg3vziYDzKKBSh1g+KAtXE0V3T6
X-Gm-Message-State: AOJu0Yz1RibBfKSJgYn3ufK+PVlNTs2SBpH++DTlxp1Lem5DmUjUGHML
	Eh/ZIeK/HT7Fd8E3Eei9WamdTUWaOHgj6KT6UoiRXOydSKRBNtv8KGaEmr2huy0=
X-Google-Smtp-Source: AGHT+IE6axpZtcVur4TM4/t0tdWY/ue3itmUJ3ARJHqWpp7ofCKUnixF9GDsVa0PpM8niYm+DeWWyA==
X-Received: by 2002:a2e:730b:0:b0:2dd:409:3b25 with SMTP id 38308e7fff4ca-2e51fd42038mr82575501fa.4.1715672777029;
        Tue, 14 May 2024 00:46:17 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce2449sm185175325e9.16.2024.05.14.00.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 00:46:16 -0700 (PDT)
Message-ID: <186278b5-b2d5-408e-8d89-8cdff6efe41a@blackwall.org>
Date: Tue, 14 May 2024 10:46:15 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: net: bridge: increase IGMP/MLD exclude
 timeout membership interval
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, roopa@nvidia.com,
 bridge@lists.linux.dev, edumazet@google.com, pabeni@redhat.com
References: <20240513105257.769303-1-razor@blackwall.org>
 <ZkKzcJm5owdvdu6B@Laptop-X1>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ZkKzcJm5owdvdu6B@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/05/2024 03:42, Hangbin Liu wrote:
> On Mon, May 13, 2024 at 01:52:57PM +0300, Nikolay Aleksandrov wrote:
>>  	$MZ $h1 -c 1 -b $ALL_MAC -B $ALL_GROUP -t ip "proto=2,p=$MZPKT_ALLOW2" -q
>> -	sleep 3
>> +	sleep 5
>>  	bridge -j -d -s mdb show dev br0 \
>>  		| jq -e ".[].mdb[] | \
>>  			 select(.grp == \"$TEST_GROUP\" and \
>> diff --git a/tools/testing/selftests/net/forwarding/bridge_mld.sh b/tools/testing/selftests/net/forwarding/bridge_mld.sh
>> index e2b9ff773c6b..f84ab2e65754 100755
>> --- a/tools/testing/selftests/net/forwarding/bridge_mld.sh
>> +++ b/tools/testing/selftests/net/forwarding/bridge_mld.sh
>>  
>>  	$MZ $h1 -c 1 $MZPKT_ALLOW2 -q
>> -	sleep 3
>> +	sleep 5
>>  	bridge -j -d -s mdb show dev br0 \
>>  		| jq -e ".[].mdb[] | \
>>  			 select(.grp == \"$TEST_GROUP\" and \
> 
> Maybe use a slow_wait to check the result?
> 
> Thanks
> Hangbin

What would it improve? The wait is exact, we know how many seconds
exactly so a plain sleep is enough and easier to backport if this
is applied to -net.
