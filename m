Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1035229992A
	for <bridge@lists.linux.dev>; Sat, 28 Mar 2026 06:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774679937; cv=none; b=Vw8FADwWXX4UBLTETvDH8iuCLSWmToFSNYdEtceM7T8vobIHoBVwpvPQUyiSJGaL2d/hClBPlOFPgxZbmeheiZLAGN6usZHoVp4g8y4tyQMVPDJrhK0fQ/FIh5jUn+O4VpCm2yzB6rb2VoQ/2R6Mw5inTET1VLekjJzqz3xGws0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774679937; c=relaxed/simple;
	bh=Aqyxlcb9LcJkPu/f/zZ50VxBX8awcFdKj2BpXcy+8wI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gsie9eZm2Sl2lxJR5neBxd7Dp7+CIZ63zHw5Ki7zzGfxJ6Atu9k6VwQukH/rQ0wps25+ZQuVwyEW67sy41wV2DFKuMFZWMtIE4UqYdBZorQ8yvLT4MjapsiI7A+6/lHFt62nFHHHbGLvhbM33pRqc5cBX71X8KWkSk1fMUK8WG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=OyLuplBE; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="OyLuplBE"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4852afd42ceso21469745e9.2
        for <bridge@lists.linux.dev>; Fri, 27 Mar 2026 23:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1774679933; x=1775284733; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WBLFnQ9HQVhO7qgyA4SBdWPPQilh86mTKClSB0mCE3E=;
        b=OyLuplBECP8BtyMFSNPQI0ZkxUavAm3Thqydp77WBlTvfVrVmg+yDEasJgzw2g3405
         Ip36vJfu2fTXI9ZZECtSl4i5KNBsZKr41YwP1viGn96y1nAKrfJBxN4OX8hGatc/zP7A
         1zu3z9JuNgKLwZC21AqwFB21598qstL8/HbTV46f4TPKT3mmKnzQNrQjPwgQV5cF/y/z
         yvbBsZxH2h8HxfsftcrUFG/ErX+sSrmqlKV4foOcr+9uiMHygGO64fQkDlUbhLp2L/Ok
         /S1XYsAx9YwYuqOFKhSCIDiYb7Bcgha20+R3ou9yvz7iH4NPRtJUFdG8GualBuxxFkRu
         OyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774679933; x=1775284733;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WBLFnQ9HQVhO7qgyA4SBdWPPQilh86mTKClSB0mCE3E=;
        b=tVxZ6acY+4I4nNKM+CupXwnYY2C0gcm0Xtsbrdsk5MfUWEyKfsw82hisAF1qB3CJEZ
         WnHcdqlQKzJOV8W5Q112wYFo8LdJ1cwgJ0mBDwjTIooECO1rP2aHpojRmsif6rGvOgL+
         E7AeiZ+/6M/S7qgGQFcEIbXQSSgcWrjxYIXBCCBmwslydAVgxLw83T5clP1U7ZPAmxEH
         v/5aszecelAoq5hyJdHdDbX0/1zPSBcEZYye6TkyulqMMPDRrnligY/6EU9Rjgpm7T0N
         VLuvehYEvTn/wDLkJ5MDHYKqe2wReRvWLEp4+EagcIa3TzJ6NxhI4rhCrr86zlpjTusq
         BeCg==
X-Forwarded-Encrypted: i=1; AJvYcCW4h4UGBQownrYGZrVHlVtjxnSU+AO0t5ePHhvGUuNgItvfn+Ac6dq/E4RuYXiqrXvz59k+ifY=@lists.linux.dev
X-Gm-Message-State: AOJu0YyWUp54vJGfxI2zWun3JdIWm0xJOPTBm3eg5XtnRyzgTn28CGjd
	T+CClaoFF2xeo1c0gzHrGM5tRtn9FxKMQeLjHGab/9gZliz1zt9CVyUY69MT1kNwUSc=
X-Gm-Gg: ATEYQzzVzijTD0YEx6bLGSkra1GPs/HyCJWbiISK8K7uQXecbZZfFlvicJfCHifsJe8
	izDoRlEfqO60LgvdZZxUlo0gyO9I5YkiCdfnhQq8uJot239h6BLPEFyyCTZmd9RBDaonVw8pSdp
	ff1w3WTBUeokYvhL5L/NAcaUZNG1dNtQ8Pmz8dCRaP1K237KtE9U3L3cV5ITYdA7LDAmP+OFYFu
	Q3XgkouFVa5X+kVhYVLQQfrdPctv71h3rpu88cILZYhk+aS5jR3tpiOjO59heB8ggmSggqigc0S
	pKstv7FD9alYL1XiCPtzrAIZoG7fFoGzXUv24e7BcrOZOmzooj644QxjyjH6U4xyXz0iryJf/bw
	F8s832Re2zsGiOTZiwm1EQjaY0CEEvtKQhg/WY5rpMML132lC79FrvmUozQ7Y7l0POqbwU5Ni0O
	d84c+uPDDmMjvuHHSy97z1F/ovPqks0u1vRb4+cGlYikwK3hUVE3cB4g==
X-Received: by 2002:a05:600c:a010:b0:485:3bb5:92cf with SMTP id 5b1f17b1804b1-48727e95a5dmr86834275e9.12.1774679933402;
        Fri, 27 Mar 2026 23:38:53 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487271a583asm30301225e9.34.2026.03.27.23.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 23:38:52 -0700 (PDT)
Message-ID: <1fee7395-ea68-460e-a47c-a61c191f5f43@blackwall.org>
Date: Sat, 28 Mar 2026 08:38:51 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bridge: mrp: reject zero test interval to avoid OOM
 panic
To: Xiang Mei <xmei5@asu.edu>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 bridge@lists.linux.dev, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, bestswngs@gmail.com
References: <20260326032438.3307549-1-xmei5@asu.edu>
 <20260327113412.GD567789@horms.kernel.org>
 <f7fea291-bde9-4f95-8a59-1b209407ee27@blackwall.org>
 <cxf6kerzseqczgsdgznoqaxcgnx3hql65tbupt7rk4arjp6www@5jnc3nkrvljt>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <cxf6kerzseqczgsdgznoqaxcgnx3hql65tbupt7rk4arjp6www@5jnc3nkrvljt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/03/2026 08:19, Xiang Mei wrote:
> On Fri, Mar 27, 2026 at 01:46:39PM +0200, Nikolay Aleksandrov wrote:
>> On 27/03/2026 13:34, Simon Horman wrote:
>>> On Wed, Mar 25, 2026 at 08:24:38PM -0700, Xiang Mei wrote:
>>>> br_mrp_start_test() and br_mrp_start_in_test() accept the user-supplied
>>>> interval value from netlink without validation. When interval is 0,
>>>> usecs_to_jiffies(0) yields 0, causing the delayed work
>>>> (br_mrp_test_work_expired / br_mrp_in_test_work_expired) to reschedule
>>>> itself with zero delay. This creates a tight loop on system_percpu_wq
>>>> that allocates and transmits MRP test frames at maximum rate, exhausting
>>>> all system memory and causing a kernel panic via OOM deadlock.
>>>
>>> I would suspect the primary outcome of this problem is high CPU consumption
>>> rather than memory exhaustion. Is there a reason to expect that
>>> the transmitted fames can't be consumed as fast as they are created?
>>>
>>
>> +1
>> More so with CAP_NET_ADMIN you can cause all sorts of OOM and high-cpu usage
>> conditions. This is a configuration error and OOM doesn't lead to panic unless
>> instructed to. I don't think this is worth changing at all.
> 
> Thanks for your review. This path is reachable from an unprivileged user
> namespace. The capability check goes through rtnetlink_rcv_msg() ->
> netlink_net_capable() -> netlink_ns_capable(), which checks
> CAP_NET_ADMIN against the network namespace's user_ns, not init_user_ns.
 > An unprivileged user can create a user+net namespace, get CAP_NET_ADMIN> 
within it, set up a bridge with MRP, and trigger the zero-interval loop.
> This is not a privileged misconfiguration scenario.

Technically this is also conditional on configuration. It depends first if users
can create namespaces at all, then on the effective and inheritable caps.

Anyway, as I said in a previous reply, I'm fine either way. Please resubmit
with the fixes tag.

> 
> Also, the PoC can crash a kernel without "oops=panic" with this bug.
> 
>>
>>>>
>>>> The same zero-interval issue applies to br_mrp_start_in_test_parse()
>>>> for interconnect test frames.
>>>>
>>>> Use NLA_POLICY_MIN(NLA_U32, 1) in the nla_policy tables for both
>>>> IFLA_BRIDGE_MRP_START_TEST_INTERVAL and
>>>> IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL, so zero is rejected at the
>>>> netlink attribute parsing layer before the value ever reaches the
>>>> workqueue scheduling code. This is consistent with how other bridge
>>>> subsystems (br_fdb, br_mst) enforce range constraints on netlink
>>>> attributes.
>>>>
>>>> Fixes: 7ab1748e4ce6 ("bridge: mrp: Extend MRP netlink interface for configuring MRP interconnect")
>>>
>>> I think you also want
>>>
>>> Fixes: 20f6a05ef635 ("bridge: mrp: Rework the MRP netlink interface")
>>>
>>> As highlighted by AI review.
>>>
>>>> Reported-by: Weiming Shi <bestswngs@gmail.com>
>>>> Signed-off-by: Xiang Mei <xmei5@asu.edu>
>>>
>>> ...
>>

