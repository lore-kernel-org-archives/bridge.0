Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D927A290DBB
	for <bridge@lists.linux.dev>; Tue, 26 May 2026 01:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779759458; cv=none; b=ku8fnLQ1dFzCZsNxurLcaEdpUXrp7IoZDP/M7DUFCf3Aqnsk4qmpNDdEYWkbrygOcoPfhZePznVAdQ8UIqSmNTSXv1fIJo/XCUeTsXogFpUWs04vDXVjEOe05MKRLzIt4FML5rwCWBQyPPmv2EnUeyFMzNuzSHFr64UWqjpTni8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779759458; c=relaxed/simple;
	bh=BWKCvt6HRmgWze8IpIsTe5xreQIsSX7X9eb2z1DNGnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rYRPXYKBFNCDGYNkWflKciT2pRku2QgkM6/7FSFBLR4fIL7P+KwfFWlXX1VUlQhD91dxutTPO3KdT6YGIZuGul2BQIQENbuTZawKfJGLitSjG06FvSPI1ls5yVHGhVmfAOSy5x5K58lT1uy+xEQySZYRol7oYM36CjrjdYnbXn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rEFwovZo; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rEFwovZo"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-3665a90bcd3so10966271a91.1
        for <bridge@lists.linux.dev>; Mon, 25 May 2026 18:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779759456; x=1780364256; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/fKHZpFYcaaYSyTuT6n/F6PsnCS6G44pjbUMI/9Wfs=;
        b=rEFwovZoC7oGsM3Y9lzLdyBiaWHvBwJxNvizq9IoZxdmosRb/2oJnRNuVRjI55klzd
         ge8CeCHnYyCN9Le1FFihuiwPvAs+CITYtSsgz6VSt86WoOPQhfmxi70TmjbdQcvxTiMn
         4Sb0cbNpRYzjyAmDzt1kLJqIILzAtsRqr5V5SrV1jpsdirgxYjo6LLovdryJH6IfNksp
         iowQNLOu03lZKGHiFuD4qECW/WJftChGgLSeUtEi1qIQWhdu2XoPdqWWbyc/q0vr8wYE
         B3FuI8YsnzFiQ4o5oyOS1ptGdFQeBmElNfZQz4CapX9FYiQq+alvluvknMpjsBew9wJE
         ZjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779759456; x=1780364256;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H/fKHZpFYcaaYSyTuT6n/F6PsnCS6G44pjbUMI/9Wfs=;
        b=iP1kU82TTVgzslVAupk/tFHlnTuSl/JI52aCegdE5kGojLmnFNO2kDTtOx2B+ZSrb6
         /DbGsF3d9vHjs8cOODZjSAwlNJKGvbTxRu15S5DLwARR1omTtvh/iUZp2QzTS9avqqpE
         iv0mRTHYPSyP/yyUtQ1u8wWRQYjILjIltjMqHmj2IDYpI48TVQ8DT5bqjxgiINx6ncaQ
         nA/Mv+EMaOi94PdoVXBsQowQA9xWIwauWSQ38hg4AVy9s10wyAlo2nhCMU1osj2StgK2
         UYpSconq+xlAowbHWRlqtMQkTpN8J+8zdGvgZ0UmtmzNzA+35KTpVu9MlMrnbIWbaJ2x
         vIug==
X-Forwarded-Encrypted: i=1; AFNElJ9kcOzAo0yUjbgaigQcQWtHUQk1vr3x2T9rTtXmqv2GCMWJkk2ASNg712tx36Vq6xZhFnD+WJg=@lists.linux.dev
X-Gm-Message-State: AOJu0YxogFNzmKmztuC2c0kUbv+m5RXwOqkV8aktYpuj+QAfTe4yq0K/
	n6yzFnHPGm0KHnGrqzs86MlNq8SFv/u1WFXxIJWWj9dmUIw6APXs8Dke
X-Gm-Gg: Acq92OESrplSjpJRZNfJNJkTHP9wBD4fb7d6TEYtivRDntjFJIzCE/NFwsfyGGEHKDw
	3nZj1Z3UJK4gl/ORP4ag9sVEAd1WjJsyfpQTQN0DrjtaqqAH9NUFlYWKru9ViLUqU9SE5YK/39R
	h27hWvdK0zgW67p6oUe++CmWtIS9LlOb/HOOL9DrPGDYpCQz/17B+CgOKOu2zsk94jWkklG3KD3
	sun3tgntwoSId1L5gq56Hc3bcfbwgvJZLkaMfaeqfVRw7VEnMvL+FeejfvnIFaa7H9XnJ5ws2l6
	VI/dCrB/ADcYq/OCnOvFdUgefkgEFw0ZetZSw+uxrdyIugrnGSbsqj4JSrqFoB/Vl/YthjoAhNu
	kXwfD+E4iPfmzrck19IxwCzW5ED4CxgTs4nuJyryru0SmC67bhjBX4BYTsS06oizUILAWEdtcxf
	kLUnil9h8+dJ2eTYqE6Q==
X-Received: by 2002:a17:90b:4c87:b0:369:7421:75c3 with SMTP id 98e67ed59e1d1-36a67602377mr15566466a91.16.1779759456109;
        Mon, 25 May 2026 18:37:36 -0700 (PDT)
Received: from [0.0.0.0] ([64.118.136.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36ac1fe6df3sm5388404a91.2.2026.05.25.18.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 18:37:35 -0700 (PDT)
Message-ID: <05392cd8-a4b6-4087-b038-fcf8dfe73b36@gmail.com>
Date: Tue, 26 May 2026 09:37:28 +0800
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nf 1/1] bridge: br_netfilter: give fake rtable its own
 lifetime
To: Florian Westphal <fw@strlen.de>, Ren Wei <n05ec@lzu.edu.cn>
Cc: netfilter-devel@vger.kernel.org, bridge@lists.linux.dev,
 pablo@netfilter.org, phil@nwl.cc, razor@blackwall.org, idosch@nvidia.com,
 stephen@networkplumber.org, sw@simonwunderlich.de, davem@davemloft.net,
 yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
 bird@lzu.edu.cn
References: <cover.1778687139.git.royenheart@gmail.com>
 <783d76ac83917b7302c1ec647794bd773bb1875a.1778687139.git.royenheart@gmail.com>
 <agy4FOL639LtWbU5@strlen.de>
From: Haoze Xie <royenheart@gmail.com>
In-Reply-To: <agy4FOL639LtWbU5@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/20/2026 3:20 AM, Florian Westphal wrote:
> Ren Wei <n05ec@lzu.edu.cn> wrote:
>> From: Haoze Xie <royenheart@gmail.com>
>>
>> The bridge netfilter fake rtable is currently embedded in struct
>> net_bridge even though packets can keep using it after bridge teardown.
> 
> How?  Please elaborate a bit, it is unexpected.
> 

The fake rtable is attached to bridged skbs in the br_netfilter
prerouting restore path via bridge_parent_rtable() +
skb_dst_set_noref().

If such a packet is queued to NFQUEUE, __nf_queue() upgrades that fake
dst with skb_dst_force(). From that point on, the queued skb can hold a
real dst reference even after bridge teardown starts freeing the
backing struct net_bridge storage. When the verdict path later drops or
reinjects the skb, dst_release() can still touch that freed fake dst.

>> Give the fake rtable its own allocated lifetime and make
>> bridge_parent_rtable() return a referenced dst. This way the bridge and
>> any packets that still carry the fake dst each hold their own reference,
>> so bridge teardown no longer leaves a dangling fake dst behind.
> 
> If we have to do this it would be better to move this kludge into
> br_netfilter.c completely and get rid of the fake rtable hack in bridge
> for good.
> 

I reworked the patch for v2 to keep the lifetime handling in
br_netfilter and to address the issues from the previous version.

Instead of adding a separate br_netfilter-private dst lifetime scheme,
v2 moves the fake rtable out of struct net_bridge, makes
bridge_parent_rtable() return a held dst reference, and switches the
callers to skb_dst_set().

To avoid the extra lifetime issues in the previous version, the new
fake dst is allocated with rt_dst_alloc(), so it reuses the core IPv4
rtable lifecycle instead of custom br_netfilter dst_ops state. During
teardown, br_netfilter first detaches the fake rtable from the bridge,
then calls dst_dev_put() before dropping the bridge-owned dst
reference.

> Please also see various AI comments at
> https://sashiko.dev/#/patchset/783d76ac83917b7302c1ec647794bd773bb1875a.1778687139.git.royenheart%40gmail.com
> 

I also went through the Sashiko comments you pointed out. The v2 change
is specifically meant to avoid both the bridge-private storage UAF and
the follow-up lifetime problems from the previous approach.

I will send v2.

Thanks,
Haoze

> [ I would like to zap bridge_netfilter but it seems its too popular ... ]

