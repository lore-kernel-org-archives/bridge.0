Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979BD382394
	for <bridge@lists.linux.dev>; Fri, 27 Mar 2026 11:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774612004; cv=none; b=Hv6bVNj6evGQV6cYh3vxdwnTJWjq/fmZJEJhkg7AdANEYQGR6hZODzbv4caaWl8PExYG/ujiATqxyjIewnJEWfsXOsNywiPzqM2nqX/WhbhlLLdQGC3/Zu7FoKPO3Et6Kx/SJJ235kobMJwzzCRhNPKRKBQoyyBNnepL7Nt0wb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774612004; c=relaxed/simple;
	bh=eKAy6z3eeID/ZV+oMTzobfIHdZrDrSWFIIM6feni8JE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a6JgBHmPBbBFOz5CIKKjLsuZd6/LRzqG8jVFCq5WZt0NUkGWKNyYb1l+KryFJaf2MEGpaFPWHOJiSB3iQEzBTSkznLd1mDFiUjSSmQ2NxJU/JpNmPt1j1Wmxzshth2WYimucABtLgiGzWefxfYSdXRBDgFqwA2PvNOGzJe+qins=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=E5kZ3LIG; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="E5kZ3LIG"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-486b9675d36so17863355e9.0
        for <bridge@lists.linux.dev>; Fri, 27 Mar 2026 04:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1774612001; x=1775216801; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dc8kZiAOVDqJfTCwQ4sp4VFOqE7cbWv8ZLlFBvNl/+g=;
        b=E5kZ3LIGDiOYgiIk40wC5bZh4HuGBhs4fwI++wVysRDyrPYLc9rGMTnOBL/VAlw4Hj
         jrx0h161Zsbl3k7tha9ah1uFEWbZMqcrlD7RIf8HWt9F3fLtib2eW2oVMTDiuS0DoHB9
         FiALT+hpYQ3g/I45aOCBOQtxzSahJ5YMc8ljbAIqflZAuHGYWDCpFxxO9rCqLW4HCWlX
         xlcNkY4tH6nHeY/aHUcbnx4986gaXjEx8QnK4ncnWAbx//0UqsxEovBh6ygHVtmeHyO2
         3AeddmYvaeF3yH15MUtugrard0biUJ8k1/Hr8mujzXiEMhzw/vzVT89RIqqZiEZyfmfN
         HCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774612001; x=1775216801;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dc8kZiAOVDqJfTCwQ4sp4VFOqE7cbWv8ZLlFBvNl/+g=;
        b=pN1yxK2Zbd2n0gKqBZspDX87exz/C/kMWsd81RzwdV1WOQ7klRPdH5m0+ucRkBJypt
         rxHLQys3Ay7+j2/yXgdFC2F6iEogeUv5utW5slG6VEdiFDYhXR6LiLwxF8CCoJT4ku4r
         x6lM/6cxYenTqS9SQY3h5lWNOHsENICuJYscaVSRDddUNv+tynf7TLYxcdZp114quulj
         g2Mx8QKbMUkiyBq8Sz2QMTOc6v+qNS38zIRrxfQQXlgBrh6AZBOBt0fTA2VLG13NLDUa
         RdWrE1R+PXxONCkkBBaJk6lW23OjEXdyXgNPJChfFzCmN8jneD6dsm9oFzbJB+SDtFPM
         8XYg==
X-Forwarded-Encrypted: i=1; AJvYcCWlwIEwx81EoHjb3QO1HCLTXT2IGLUZqc83Tc0q7vrXQqPUaBWO7J5ImMmfnzUjgYfG/8lfyrw=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx6L+vmdl5rIPZmkdxy/hxr2jfT42SoPukHIYsZDDnP9qgzovPZ
	O0phLNsrCzFqgNmc35gLodeyih6fve93HEQ+ANwdExU9QZDU+i844TGwFnwnl38dD2Y=
X-Gm-Gg: ATEYQzzny5oI9ZqlUpjpYRM+0u8XEwiFA+fYur9GrxNbm+47lScKNivNndLv+JU+4Qi
	Pzqgz+Osg2zTtx27YucZJOEfeGjaGJnGKqdmuw8+5DXEsAMgXsslI/ZUfBRqRT25jYl6ZeixkcI
	hf6lUGeTY9xYz0NoZa+bwsEShRkYa/jZyMA4ZH7GaU++ZjyMF2YYBwr0nFvroGCE9/6U8NofRCw
	jxGnzigH19D1Edq7bsCzwDEssu7V+4QqCJNWd1t6GEQjDsTNisZblFGC1Om4bAZ1y/s1lHEY+EB
	ZyWX0rgNIYHCgRGUMI55+3MB19YsXWNkmYDhj/CmS8pyjgKuhzovVWEHvHjCCQmJSlkXoLR+1eq
	9Gu4xaRfzKzOkwMsfAPoHFsaMlSnkHOE9mOop2jRj6FNgJFlLgLyuX6J3LdUq5P7Ettm4v92rzL
	LjbQogI4uKLxqCVWvfUM6KuqZUzkEvRA2a2rZQiSOi/cCJg22hOe7m5w==
X-Received: by 2002:a05:600c:3f0a:b0:485:2f4a:6ae6 with SMTP id 5b1f17b1804b1-48727d5941emr40047055e9.6.1774612000783;
        Fri, 27 Mar 2026 04:46:40 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722cb0d83sm83129465e9.13.2026.03.27.04.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 04:46:40 -0700 (PDT)
Message-ID: <f7fea291-bde9-4f95-8a59-1b209407ee27@blackwall.org>
Date: Fri, 27 Mar 2026 13:46:39 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bridge: mrp: reject zero test interval to avoid OOM
 panic
To: Simon Horman <horms@kernel.org>, Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 bestswngs@gmail.com
References: <20260326032438.3307549-1-xmei5@asu.edu>
 <20260327113412.GD567789@horms.kernel.org>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260327113412.GD567789@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/03/2026 13:34, Simon Horman wrote:
> On Wed, Mar 25, 2026 at 08:24:38PM -0700, Xiang Mei wrote:
>> br_mrp_start_test() and br_mrp_start_in_test() accept the user-supplied
>> interval value from netlink without validation. When interval is 0,
>> usecs_to_jiffies(0) yields 0, causing the delayed work
>> (br_mrp_test_work_expired / br_mrp_in_test_work_expired) to reschedule
>> itself with zero delay. This creates a tight loop on system_percpu_wq
>> that allocates and transmits MRP test frames at maximum rate, exhausting
>> all system memory and causing a kernel panic via OOM deadlock.
> 
> I would suspect the primary outcome of this problem is high CPU consumption
> rather than memory exhaustion. Is there a reason to expect that
> the transmitted fames can't be consumed as fast as they are created?
> 

+1
More so with CAP_NET_ADMIN you can cause all sorts of OOM and high-cpu usage
conditions. This is a configuration error and OOM doesn't lead to panic unless
instructed to. I don't think this is worth changing at all.

>>
>> The same zero-interval issue applies to br_mrp_start_in_test_parse()
>> for interconnect test frames.
>>
>> Use NLA_POLICY_MIN(NLA_U32, 1) in the nla_policy tables for both
>> IFLA_BRIDGE_MRP_START_TEST_INTERVAL and
>> IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL, so zero is rejected at the
>> netlink attribute parsing layer before the value ever reaches the
>> workqueue scheduling code. This is consistent with how other bridge
>> subsystems (br_fdb, br_mst) enforce range constraints on netlink
>> attributes.
>>
>> Fixes: 7ab1748e4ce6 ("bridge: mrp: Extend MRP netlink interface for configuring MRP interconnect")
> 
> I think you also want
> 
> Fixes: 20f6a05ef635 ("bridge: mrp: Rework the MRP netlink interface")
> 
> As highlighted by AI review.
> 
>> Reported-by: Weiming Shi <bestswngs@gmail.com>
>> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> 
> ...

