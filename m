Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB47E363C48
	for <bridge@lists.linux.dev>; Fri, 10 Jul 2026 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696610; cv=none; b=oocniZLrxa+Df5apeE+q0ccHKketxiskVuUL54NN70BE+TPg5crW/SnJrHZMsg8IJzzk5oWafA2x7QX1u9qRYwHJ2BQcZpKLRTUUqVmZucWv7/mLnHDf45XaSdMYzgEem7QCBvknQ+xtQMoOSGl54OvONO1w8vtWHnjHnKjF3wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696610; c=relaxed/simple;
	bh=1JtLlpRRACfvKsroXlBPtY0Dc9Plol0JKs7d++0dOtM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=P48TfFkpKm3+DjTyWvT0g/L3c4T3wWVns3kcY0VWz/XzTQVUCPd4pHiBRqvlpSl8OwKjE32DuR5l1kJQtIEKBB5x9WPwoInNQ0awSp6rPGJeQG5dNcviPA+zODkSZUZ+jQ6Qh2TC1zjNWhiV4epB/4AFUGbIo+nYCUL7m0ARhpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WvqlcEUV; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvqlcEUV"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c15cb6f5c12so184136166b.0
        for <bridge@lists.linux.dev>; Fri, 10 Jul 2026 08:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783696607; x=1784301407; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pzG2aZr0GYhbw005TMkhGo2BjpwTfepBU/AvlO3Dhu0=;
        b=WvqlcEUV5fE21dFoSycRlAjZMysilugnqKTaT3jIyyurnhzXC1PqoeqjqGAKztV+tC
         iMk44xrtUVZJi/T1y9BWLKCyUDtnOMjzNrj1qi/rPlMw4/AqObNVx9yAHERVrHeCOxfj
         0eG+Nd8s4tO4Mkbr3/mce3AUMxDK9oW7enOe5gz32tuD+KpKm0nHGgcV4lM1Dkdmt1X4
         5M1RHToBl0+RMPpKvfDFNoUhHbKe5Wl4wpkOut2/jNb50eTnmXDaCTu20HshuNnUqV2j
         HlNTGNPLQM+ukFWiF+5Kcepszv+qzaRUhIkQZbJI+pTKOM4RbagHmSQCcvMfmzTseNcx
         KfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783696607; x=1784301407;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pzG2aZr0GYhbw005TMkhGo2BjpwTfepBU/AvlO3Dhu0=;
        b=cZdxgFjTgUg0LD7Gzh5nDjScuX1xv0kaCE+WbEJhtYn6g7w1rRlxAnpSsSxmaB6Z7Z
         oT8h58mUkyN33Kc7UURaplqvjdD0ZE+TkpJRrpr6E0ppgj4ZXn6uAmBm8/zr9CKIU4kM
         gQTs4zjW0+CU2w1TGTkzut+KI3axqvc1vMHMYTu+DCw//c0NAntQQA8WisY8gaZYnjF9
         IFkvVR0S+thQi2rXGMkyrWZqVFyByyY/FEnGA8xv4QtYGCdjuIPVtDfqp66afhagJZYc
         Di2TP2muCqzmr0ySzEanExRK7xMVyG6cexAWbBztqGIEgwZgSN1RltR23a7WUHPUy5yD
         bzIg==
X-Forwarded-Encrypted: i=1; AHgh+Roa+YZCT2+47qMM5mM3t2C6pZ6c237/cT9qEiWi9pD2WTZogt+aUfFkjPNEbplqxm3IFy1AwZo=@lists.linux.dev
X-Gm-Message-State: AOJu0YwserOWmYT6YCxpvc68LIPM8av/klYNaAvCxez3hRItGYiWIiWc
	6vP9ye5GDlqVGWGZ56YiRGYET1a8m/lSDz0AS9aMke4IRK72oRmEOoQR
X-Gm-Gg: AfdE7clscEkB/vKNLxLHZ7HvKbMEsNPSAASKbX2LQ/a94fdRKvkc+/PVXpD7+NcKwPJ
	J4/xoPErtMKyHzsBXEdMP5cJkyaJ1GvaQqDCJppalC/aRwcGC6XNb0PdjXR/BE3dAnD3fG0glk8
	DuHiogb0zLRotxhZTMAZJD2HWI31uKltz+VbZnPuEwuN2rA0yQ8LgowWWZvjhtIKekuSmmF8ZRH
	UMTTac1YQiRrYekgSY7yNS+Ll3Q5sklplDESaukqkS44Ag7SJKs3kJ5Aw5B1yIHCgQf/bvbHUsQ
	rdjttcJxxJzTotqraL63lYa0J65kWo466K9OIbepC10j9kdVFiwXrc51LD3vEFN1sPwCSvLbjz5
	bZfCVYjmz176s17v93InAPsPbmjWTwFr40RVTnZ7a7xd4WBrcOgSPfxx+2YPaCTolflvszKem5t
	oCZ6NjoJw3FilY3HWtXW4LreIIvR4Lgc5ZPtgkp/qbiECpYNfT4oGfkX1TbKDy/4LSMj+2QLRLA
	jYsZL8W2Vuwr5aTP2ZbvJqHdWSFKx6iK3v/6VCnXuOQ8HdyUQArptUF1YtKu2c76XwbpdpHwiRS
	jB+zKs/Fy9pvZDAREkfNTzE=
X-Received: by 2002:a17:906:4fcf:b0:c15:b96f:c3d1 with SMTP id a640c23a62f3a-c15ce06ed7emr537056666b.41.1783696606976;
        Fri, 10 Jul 2026 08:16:46 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15f272141dsm204948866b.59.2026.07.10.08.16.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 08:16:46 -0700 (PDT)
Message-ID: <12451f0d-7e5b-4697-a734-8200944b204f@gmail.com>
Date: Fri, 10 Jul 2026 17:16:44 +0200
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
 <81c3bf65-b19b-4f80-aa8e-c0c4b3f5d6a7@gmail.com> <alC64Vg_xihR-huW@chamomile>
Content-Language: en-US
In-Reply-To: <alC64Vg_xihR-huW@chamomile>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/10/26 11:26 AM, Pablo Neira Ayuso wrote:
> Hi Eric,
> 
> On Wed, Jul 08, 2026 at 08:36:11PM +0200, Eric Woudstra wrote:
>> On 7/8/26 11:48 AM, Pablo Neira Ayuso wrote:
>>> On Tue, Jul 07, 2026 at 11:10:41AM +0200, Eric Woudstra wrote:
>>>> Add nf_flow_rule_bridge().
>>>>
>>>> It only calls the common rule and adds the redirect.
>>>
>>> I decided to use the new _unsupp() function, so we don't pretend
>>> bridge hw offload is already supported. We will need a driver before
>>> we can add this, this stub does not provide much. I guess your goal
>>> was just to avoid a crash here.
>>
>> No, I am already using hw_offload between bridged interfaces
>> on the mt7986 succesfully for almost 2 years.
>> It works dsa-port to direct interface (lan1 to eth1 on Bananapi R3) and
>> between direct interfaces (eth0 to eth1 on Bananapi-R3-mini)
> 
> Do you utilize the existing mt7986 driver in-tree without changes to
> achive this hardware offload? Or you have still have out-of-tree
> patches that need to be merged to achive this?
> 

I do not change anything about the mediatek drivers to achieve hardware
offload. No patch needed to fix hardware offload.

However I do have a small fix for the offloading towards the mediatek
wifi interface. This is a fix for the software fastpath already.
Also with hardware offload to wifi interface, once the software fastpath
is setup correctly (needs this patch), then the hardware offload functions
correctly without any further patch. See patch:

https://patchwork.ozlabs.org/project/netfilter-devel/patch/20260317101525.358016-1-ericwouds@gmail.com/

It is not reviewed yet.

>> It can also be tested with my bridge_fastpath.sh selftest script.
>> This script uses veth-device pairs to test the software fastpath.
>> It can also use 2 real interfaces interconnected in a loop of copper,
>> when chosen with commandline arguments. Then it tests software- and
>> hardware-fastpath. It also tests many different scenarios.
>>
>> So this is why I've added it, as it is already functional. If a software
>> fastpath is setup correctly, the hardware fastpath is also functional.
> 
> Thanks for explaining.
> 
> I am targetting at a minimal subset of the flowtable bridge support at
> this stage. There is a need to make progress with the
> nf_conntrack_bridge counterpart before the flowtable bridge can get
> more features (namely, bridge vlan filtering support).

I did send a newer version of my patch-set for nf_conntrack_bridge,
last version also adding support to defrag/refrag. See:

https://patchwork.ozlabs.org/project/netfilter-devel/cover/20260512103347.102746-1-ericwouds@gmail.com/

I've added testcases for defrag/refrag to the bridge_fastpath.sh selftest
script (v5), so I know it is functional.

For proper vlan filtering support, I do also believe you will need to
introduce DEV_PATH_BR_VLAN_KEEP_HW, or do something similar. See:

https://patchwork.ozlabs.org/project/netfilter-devel/patch/20260317101722.358640-1-ericwouds@gmail.com/

