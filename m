Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2FD40DFD2
	for <bridge@lists.linux.dev>; Sat, 28 Mar 2026 06:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774678714; cv=none; b=YN4hvuIn4X2Fg+LTmcEnIqjbtJXkVW4rIPpqe1Rw7Ap5qzQ19YBCGViPE3hCbKrOfgZwCBROdL/Hch0fv/c4UWvMNXy6OA+tzKyeXU1skFozmNXWr4oZGjU+llflpsjKKVaA9yphTpcX4zazjQ9Khs+klfXVziqM3xJaipZ0pbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774678714; c=relaxed/simple;
	bh=fpWGD4WzwufnasbHIbkLS6WpSJ/8pnZ3W3U3rLEMYmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f40ZGqGznGvqnDEAdOJmP1SNtXVRPiyBHnjIDbknMS6AQgiWPkE23WqHEU0cFBgQ25tFnYxchbOVjZL8wavxhKKE3H2ghh2YL44wQzu3a+d+BkcrMX6GTonFz9f6WuzwbqGshdHKA2SwR5mMX/1KDXdzN1TaQXrGlImkz/OXks8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=VIzAjxHt; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="VIzAjxHt"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439fe4985efso2120147f8f.3
        for <bridge@lists.linux.dev>; Fri, 27 Mar 2026 23:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1774678711; x=1775283511; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O+7pAhqIKsXBo8wnUBwzZQUNvGJtnEKbwOvep909ul0=;
        b=VIzAjxHtMWUiZKaACcIrDwAi1bx1NVr8m6kZrPHM8l0SsNZgL6mZbjjjVSThmb7m1T
         HALy12wvqiZo/m67mbbWfvTzUDPVLArmvIYua6oG0nAjdXCBDKoEcDBma4VsDi++Ga49
         L5RE1FY0EcgescB3GMwX7rMIfl6Io0+HqmnkOAFMI3F0L2lC3q7MjcbwGhqKcmZYnyeE
         fbyHPZd5gMgb+w2ZDB2pskn2itFzh4ramiwb/Zf1GCEbstI3AdMlsK9uZ4W3d9LbAE2A
         uGp6rr2QrnpGMuxG/+CXtUJ38xfAqpDva15SPxdw9S+7OcszDwF9vwZ8uI2H8SPwdyQ+
         tTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774678711; x=1775283511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O+7pAhqIKsXBo8wnUBwzZQUNvGJtnEKbwOvep909ul0=;
        b=aIMBdwbYlFksjjAzQiwW7sTijg9CnOM5x3jE2J8e9tdQgciuCEiLZ+n0buBiqWHpfD
         NFAEptI1FD7ymkOWVvvy/e3REXVRW1myJslgy14JZ1V00W+ckNhAsSihrLOxIqi87w5m
         NmiX8oLMxnJ5FbbXJo7hV/sAccfQd32w+fhmyJ3B1Ejw+NA3c1rLkgvFm78j4rqmnuj6
         AZSs6u+213Fb9Q7zLtc7yIKyfDBnePouAocTsSsNYzbCCuaKJumVz1BPiaVqdxeFNv8L
         psCSxlG4CFckLrRgWGe6mzpVG8cKdHjnnQ+lMSr05MrV4J0OeX6cSg3qk5nc82TuG/rH
         OQIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+4mM5Dxuw2FZ3Ry/KP9j6Brkyq2wH6nrtN4e+AekD/pQMlk84qedsiauiXR6TyuAJ14ZjFlI=@lists.linux.dev
X-Gm-Message-State: AOJu0YzO+amD59N2c22Q2jPDDm5Qgy8zlg7Ur5NOKghP26HUd9ClhiVk
	21ll0aK17AlBzA/B+cWXXUUMRgaAMEpO52yPQ5gJgHygxyRny1dt/zUZPNQMU+2cjfs=
X-Gm-Gg: ATEYQzzIWD33l7Bgt1rXYCiy/cUGvzPypoHkOBfr/zSrcdXGPTM7Y2kTS90nO/ZyCtW
	k39azH+8HH/VVkw1o6s1eU+ZfEzuWt82tNqLhY9U5F9cEbVGf/mSYtOqIEjymy7HTH439patpKM
	gLAa6e9UwE6KRW+PLIAIO8t9YBTHW0z/Qp5KRPHLvkFEr5XqCE4JTRaQSXeSACVpvYyqLAim2du
	AkRUCfE348lJuDwhlhhENzJgDSLvYXUudSX6NcAm6nuuzPsO6HEgm3P9FC01VFY9yo4bs6D5P0t
	v1UIpd1P+65VfBh1o1SawbNZUGwk71t66jdqy6btlm1ed8lxxzQKjKaecHnkeNq8pa7Mlhut7HU
	p6fYdMnJPB3fdQgb+VJHE8t6gW5mFz3nnvftKHRVkpPP1MHix7S4iIQ5nniIDjUetNs0pE/kp3L
	NSuYgdKk5i8AUw29zOV2dFqk1zhzS1UudxpFuuuI/rfahuq/RY8rELKw==
X-Received: by 2002:a05:6000:26c1:b0:43b:3a65:8c9d with SMTP id ffacd0b85a97d-43b9e9e90b8mr8793617f8f.19.1774678710530;
        Fri, 27 Mar 2026 23:18:30 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf245f87esm3003997f8f.22.2026.03.27.23.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 23:18:30 -0700 (PDT)
Message-ID: <85e823e3-394f-4bff-a8ab-90bbd2e1ab0d@blackwall.org>
Date: Sat, 28 Mar 2026 08:18:28 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bridge: mrp: reject zero test interval to avoid OOM
 panic
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Xiang Mei <xmei5@asu.edu>,
 netdev@vger.kernel.org, bridge@lists.linux.dev, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 bestswngs@gmail.com
References: <20260326032438.3307549-1-xmei5@asu.edu>
 <20260327113412.GD567789@horms.kernel.org>
 <f7fea291-bde9-4f95-8a59-1b209407ee27@blackwall.org>
 <20260327171917.7575d715@kernel.org>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260327171917.7575d715@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/03/2026 02:19, Jakub Kicinski wrote:
> On Fri, 27 Mar 2026 13:46:39 +0200 Nikolay Aleksandrov wrote:
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
>>
>> +1
>> More so with CAP_NET_ADMIN you can cause all sorts of OOM and high-cpu usage
>> conditions. This is a configuration error and OOM doesn't lead to panic unless
>> instructed to. I don't think this is worth changing at all.
> 
> Then again if there's no practical use for 0 we should consider
> the risk of getting this sort of submission over and over again?
> Dunno..

Sure, I'm fine either way. To that end the patch looks good, just need the
fixes tag as mentioned earlier.
