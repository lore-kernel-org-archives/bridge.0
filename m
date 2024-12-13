Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2841DE2C1
	for <bridge@lists.linux.dev>; Fri, 13 Dec 2024 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734089126; cv=none; b=DvyhduCuca8gBa0tB8py7UBrXxLtabxmmyJLcFQICrdl9H4aCqNHViq2XC3qA36t4Bwmh/1tj7WnBjldVC7VGmFj7G7LcBaSc66Ym+ubHaEddptkxxNRcdMe3ATwUBwt1+vZl3uL5H7mln8auR7MbIGu9csDOWsfkH2mjhg2H6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734089126; c=relaxed/simple;
	bh=jVVDkd4GtPcl/Ya2Cyzmdc1drC5cqvneJpMuXxxZFQU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NkqTm9p3RjjHA4DiKTjqmnH2OkwIO5AxdLmqFRYZWs7YJOvjHT6Tng75CuSzq8NekQatkjGUDKHNLaXVMqOse5DCiIhY7vE54Nx3iz/G4x5qvYavODbMxTtg/9c8wDS49tkfxQ9w9wpa/4k7DHBdAkn6e/1NvewQ2HBAZpJHhHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bisdn.de; spf=none smtp.mailfrom=bisdn.de; dkim=pass (2048-bit key) header.d=bisdn-de.20230601.gappssmtp.com header.i=@bisdn-de.20230601.gappssmtp.com header.b=fYz5vVow; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bisdn.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bisdn.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bisdn-de.20230601.gappssmtp.com header.i=@bisdn-de.20230601.gappssmtp.com header.b="fYz5vVow"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-387897fae5dso108672f8f.2
        for <bridge@lists.linux.dev>; Fri, 13 Dec 2024 03:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bisdn-de.20230601.gappssmtp.com; s=20230601; t=1734089122; x=1734693922; darn=lists.linux.dev;
        h=content-transfer-encoding:content-language:in-reply-to:autocrypt
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6279siDW6hDqPjOPyrhG12adHJ/zO5tbDEQWXP7oa5Y=;
        b=fYz5vVowZpoYAGvGgJ5FMa+Y6ZdCjYOX0wXgxv2OUY97Hc2PVy/KQbfbCf/ssnR9p9
         Fpr4RJWbutHLQiAndmr96IK+iuYaIsbj8ubSw4QP8a1qG0CrzQ+pHaH9abi1hyV42d2j
         TZzJQQsyqcjM0kUWZvUNx8sYKv10C+3iAV8Q/hlRKY+kZAjswKiaOK8QRx5VFgjP35nm
         K49HKcYjoJhgdWly1u1REAwqFISD3XiuNESfAx6YeZE1v9MhDYSyAxpKOfRPpyG7X6tJ
         2l9DNZKo1VU1R1ovqxyIkkMyS5UjbGQq77sz+KjKm1UCUfhJkV4cFFnWaXFXJMzBZHPE
         DadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734089122; x=1734693922;
        h=content-transfer-encoding:content-language:in-reply-to:autocrypt
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6279siDW6hDqPjOPyrhG12adHJ/zO5tbDEQWXP7oa5Y=;
        b=T6Jmu8uWkRSk5L9lM5SrLY83nWFqV8tw4WTKZ0Zbi/3P+19qZsSlm3/yFD2jCuK6hn
         daQtnbd6KxcZ4wmP7Yi+MpFSETk3Ww5VMIDDpOqSwGwNGGNBG/VUQJXUDt/CaTbqHwLn
         e1VnNIrTPmtlZ/PXo9X98n4sr78hyPOEGfYiKUpUqdeT0GIqVCXcYd7Pmp4cpk4P8Zm7
         g1ybAs4+PJ/249kdaIcIuszN5KIsorrNwtYjgBMg1yWNE4w2aKIyQvIRPP69BBJVlq3A
         W4eBTPtWiWE2/BMlw/5Kz2va4EaxwaOnTxg5vJWy1zh1OiRHopdnov0z7fPAHo2hxc+i
         0Yeg==
X-Forwarded-Encrypted: i=1; AJvYcCWzO82OZqSEr7nFTwyN7HtYvsVLZ7VyhXqIm07Cbr0ARqcJgCIRVrg3g+wVdUW2YGnH86GXx0w=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7pikRI1FZ08JTrByjM8OKP1N5xowyGrdzQ/YP4Xr1lri/EBOh
	JpA0cCg/Ex0TSKYTxr+PzlE3UkQpkp1Evz60BZyD5k4ceG77kAmJGNXMSp118axv+shCsX0/vTi
	aQxrWp8MqSXnVeHu9Iyfoc/DgbZ/aSqLwkyqcdt2g7WCC8e4=
X-Gm-Gg: ASbGncsv3e2Iewn/CyY8e88v7pBcVhXQmTfVW+Ou2E8JhqbpjPCSVQL2Y6x+RhfGEpu
	d2vym1NKTzRtRfs9KzKoszhx5NRoZalVTvP/g5C7rKRLZeyHNwmDbi0lhzdeRo3G3/A2H4NmNeY
	+zSgUWqO+wATFpUXUzwH/FneUBqtoDElUUpmhvxKeO0KVl/mj/tAxKyDYxBsAjrOIvB8mn81/WC
	e2KEXx0eak/mLrIFhQBfyvrm8E+ywV1tMUeUQZapKflgT14jX+t+G4pc0a+svo=
X-Google-Smtp-Source: AGHT+IG2n1+TronxhEygzTlzgQL6OyWDwWWHO3T6emy4eTRieOlanhn10eScWY8HoOhk8275H5ilog==
X-Received: by 2002:a05:6000:2ad:b0:385:fd31:ca30 with SMTP id ffacd0b85a97d-3889ad36430mr554250f8f.14.1734089122349;
        Fri, 13 Dec 2024 03:25:22 -0800 (PST)
Received: from [172.16.103.202] ([62.80.99.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824a5085sm6790399f8f.38.2024.12.13.03.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 03:25:21 -0800 (PST)
Message-ID: <3bdc6e3c-49d4-46ec-9c36-85e324e5e2b4@bisdn.de>
Date: Fri, 13 Dec 2024 12:25:20 +0100
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jonas Gorski <jonas.gorski@bisdn.de>
Subject: Re: [PATCH RFC] net: bridge: handle ports in locked mode for ll
 learning
To: Ido Schimmel <idosch@nvidia.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Roopa Prabhu
 <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Hans Schultz <schultz.hans@gmail.com>,
 "Hans J. Schultz" <netdev@kapio-technology.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241210140654.108998-1-jonas.gorski@bisdn.de>
 <20241210143438.sw4bytcsk46cwqlf@skbuf>
 <CAJpXRYTGbrM1rK8WVkLERf5B_zdt20Zf+MB67O5M0BT0iJ+piw@mail.gmail.com>
 <20241210145524.nnj43m23qe5sbski@skbuf>
 <CAJpXRYS3Wbug0CADi_fnaLXdZng1LSicXRTxci3mwQjZmejsdQ@mail.gmail.com>
 <Z1lQblzlqCZ-3lHM@shredder>
 <CAJpXRYRsJB1JC+6F8TA-0pYPpqTja5xqmDZzSM06PSudxVVZ6A@mail.gmail.com>
 <Z1mmnIPjYCyBWYLG@shredder> <fb085904-e1c2-4bbf-b826-b6ba67d283b5@bisdn.de>
 <Z1rWRorUo7ivWJdO@shredder>
Autocrypt: addr=jonas.gorski@bisdn.de; keydata=
 xjMEZxdk5BYJKwYBBAHaRw8BAQdAPu67BaIt3vpOuFNykN1bTGnMCt3SfaTAdTgdx7x3aM3N
 JEpvbmFzIEdvcnNraSA8am9uYXMuZ29yc2tpQGJpc2RuLmRlPsKPBBMWCAA3FiEEFDg1Kr+u
 iVjQpdfy5Kt7/8+fcMYFAmcXZOQFCQWjmoACGwMECwkIBwUVCAkKCwUWAgMBAAAKCRDkq3v/
 z59wxkUZAP4uDlkfv1WhuDjPUaeL9uL33RUo4mUwIYQLAR8gKQk5lgEAiQvKbFvrB2Zz8Tbs
 anWvhWddIu1L9D4KMdoayMpCqQrOOARnF2TkEgorBgEEAZdVAQUBAQdAQSvRRbcsAY5GLbFn
 qnD2JZ3hGcjOviBjgQpPQV48MSMDAQgHwn4EGBYIACYWIQQUODUqv66JWNCl1/Lkq3v/z59w
 xgUCZxdk5AUJBaOagAIbDAAKCRDkq3v/z59wxuVgAP9D6DwrhASXLN8c5uy/BYuaMznIfqf5
 6R95DltdAG2xigD/TCGATSNdLFd253kU+qiZPLWwcqNouB2cTa1ItM1N/AU=
In-Reply-To: <Z1rWRorUo7ivWJdO@shredder>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable


On 12.12.24 13:25, Ido Schimmel wrote:
> On Thu, Dec 12, 2024 at 10:50:10AM +0100, Jonas Gorski wrote:
>> The original patch (just disabling LL learning if port is locked) has
>> the same issue as mine, it will indirectly break switchdev offloading
>> for case 2 when not using MAB (the kernel feature).
>>
>> Once we disable creating dynamic entries in the kernel, userspace needs
>> to create them,
>=20
> But the whole point of the "locked" feature is to defer the installation
> of FDB entries to user space so that the control plane will be able to
> decide which hosts can communicate through the bridge. Having the kernel
> auto-populate the FDB based on incoming packets defeats this purpose,
> which is why the man page mentions the "no_linklocal_learn" option and
> why I think there is a very low risk of regressions from the original
> patch.
>=20
>> and userspace dynamic entries have the user bit set, which makes them
>> get ignored by switchdev.
>=20
> The second use case never worked correctly in the offload case. It is
> not a regression.

Ah, I just noticed I incorrectly assumed that unlocking an entry just=20
means removing the locked flag, but any change from user space also=20
implicitly adds the user bit. So they would never get offloaded.

So there currently is no way to get offloaded dynamic entries with=20
locked ports, regardless of MAB or not. And implementing that is=20
definitely not a oneliner.

>> FWIW, my proposed change/fix would be:
>>
>> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
>> index ceaa5a89b947..41b69ea300bf 100644
>> --- a/net/bridge/br_input.c
>> +++ b/net/bridge/br_input.c
>> @@ -238,7 +238,8 @@ static void __br_handle_local_finish(struct sk_buff =
*skb)
>>   	    nbp_state_should_learn(p) &&
>>   	    !br_opt_get(p->br, BROPT_NO_LL_LEARN) &&
>>   	    br_should_learn(p, skb, &vid))
>> -		br_fdb_update(p->br, p, eth_hdr(skb)->h_source, vid, 0);
>> +		br_fdb_update(p->br, p, eth_hdr(skb)->h_source, vid,
>> +			      p->flags & BR_PORT_MAB ? BIT(BR_FDB_LOCKED) : 0);
>=20
> IIUC, this will potentially roam FDB entries to unauthorized ports,
> unlike the implementation in br_handle_frame_finish(). I documented it
> in commit a35ec8e38cdd ("bridge: Add MAC Authentication Bypass (MAB)
> support") in "1. Roaming".
Good point, missed that br_fdb_update() will automatically clear the=20
locked flag on roaming regardless of flags including it.

So disregard that idea as well, and we would need to do what I=20
originally proposed to allow locked learning via link local traffic.

But since there is no difference between kernel entries that userspace=20
unlocked and dynamic entries userspace added as I now found out, it also=20
isn't needed at all. Userspace can just add dynamic entries if needed.

So in conclusion, I agree with the original patch. Shall I resend it?=20
Should I extend the commit message?

Best Regards,
Jonas

--=20
BISDN GmbH
K=C3=B6rnerstra=C3=9Fe 7-10
10785 Berlin
Germany


Phone:=20
+49-30-6108-1-6100


Managing Directors:=C2=A0
Dr.-Ing. Hagen Woesner, Andreas=20
K=C3=B6psel


Commercial register:=C2=A0
Amtsgericht Berlin-Charlottenburg HRB 141569=20
B
VAT ID No:=C2=A0DE283257294

