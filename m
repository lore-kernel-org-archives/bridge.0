Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DAF13B5B3
	for <bridge@lists.linux.dev>; Thu,  4 Jun 2026 01:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780537968; cv=none; b=EmEtl1ZCdKouQVvcb3+B8WdRAhvUUQ56+aTGpXsmJ01Ty1Zguc+ZY+88xLwK0Qjg3yluCX3xYcVd7Vf7hRZvCEXIL0cwng5uaDiXYmkZHDBU8kCwetVkrGbuhiW0YqMeXGxWY7NkB44Qg+uITRsapUVPPy4E2BPusy/YyJigOBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780537968; c=relaxed/simple;
	bh=5SpROYMEKxmu0HLYw0TU7p5AejWLTbuQ9iBGb3rygBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sH+1cGf0PAxTU/H3HJ9BJ9g0sKNHRoJyCKMeJAHjEiBTHdOA+O2++Sbn9VOj2yApaB8PioBFqbLuaUVqOy6nUuZYKQnQgz3rOhvS8tlX8LJu4iPu/9hjK3/tpkcSx+SoShxxqf8yXiipJxrr198dcyYApH3cTsVYJeQZGjVZ60g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSJ9YZsa; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSJ9YZsa"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2bea7176c72so1087795ad.0
        for <bridge@lists.linux.dev>; Wed, 03 Jun 2026 18:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780537966; x=1781142766; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1VU/ORPdO9tKOsaR3dN6StpC2u7L99EsUXXUtJYK6E=;
        b=KSJ9YZsayFxFZejIgbonhIgnsf+x3FBqtnOfGVXGhDSYLi5I7fGFtoHmpfvA5z56Fs
         66kvvScI184neJkCmm+SQPxZRlilaHhPrjJdCeU03KHrjHZ78KAqyu0MRbYWZ0kWqwwV
         5DTZ2Lfer4nJpfKtpRLvaiHZbx2JG2DkZ3+wgfxU6YOBwK2Po84ad3FB6+glrjFuY0vQ
         chTJFIoB+Rd/WUXI+qDSl2w2J6hB5pce1ZMhmmHJU15savA/75RfoKqmG5GYlRZg83ky
         RLl/sysCKsa9DAZMn4ex/UKze5JxsHvf3LiWNOspxx4fjUXd9XmUcV/sOrlxhbOpL86c
         cDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780537966; x=1781142766;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R1VU/ORPdO9tKOsaR3dN6StpC2u7L99EsUXXUtJYK6E=;
        b=IrfmFkY2yi5kEBubkespDFtu30+D3ayCWQocGMwtoWoGi5RjtF3bmpFMvP3PWY5mvr
         9nAkHWgi25R0M6VBabu8fIAT5kwex61onyzImS5QGx7EwiQQuQ3aOn2Prmi9k5Bl2cBI
         WsNWlHXCIEYKqAVr5qsy3vNz+eIbFyPjLyxsAo2aIArzYXlzBlL3NH2Mbsc/fF7k5mx1
         XeCGwzhaZse7Ta7G7wLz7ip5lHZ5gygrFLGgxvxzoaLmjioTOm4a6iB5L4H/fNimcZKw
         SFWDmlS09YJ+XZcBVW5FwxvWHcSBSWso9RiX5v0GKrEAtsT5eLXHe0/lefisiFUQSVBx
         vipw==
X-Forwarded-Encrypted: i=1; AFNElJ+iIJ7lX0Z17cxvEAxlWeMOuZSPcYq3jGbBhPwqNqut0V2AEqhbE4bVjG+bjQnDzE10AUWe2lk=@lists.linux.dev
X-Gm-Message-State: AOJu0YyLX1HBUxCIfKsur0hiZ4I/I+MkN02+TcLn1CrdPvWbTc0GwLEH
	mjKHLbuwfPyrqzDhvrSmqdbHwMMAm/q2OhV9AlIUvFjqkLJjVtMx1T5E
X-Gm-Gg: Acq92OGSGq72tVcd+gj3Ult0m2GmD8Yr1X4CxPwlrJeI+/uvtFDSPHB6FndBVbSSATl
	/5zXJjg1KX/Htejydi0gt3t2AXSRoGbwLXMFyqJUuVdXOkPqraYd7Jt0uRTC80F02gwd9Arp5vk
	k/diWSGb/YKjU5p69v+6smKs7jKNH8h5MTg5FjJeeaa6+jF4h5WOr+Y291zoutUhvpYA09nv9vd
	gpRqStG6XebYVl2yazpp9LAUY3yV7tBpI2veAI1nT678nt2fi5SQZ++tPDSHMz5Hyaf/b6tpSZ7
	7u9GGLDTjeQLh3Km9pvBvZfpJgSYxTNxAh+m4heSR3VgqCz52AuMVe0a/Ss/HCg35zQjsNmQu5Q
	Yb0qPiPtrFWxcs/Diia7RNjdifDDLcD7neNpz7Y8RJ2Mh2uShJpRS9iMYFIupG3lvp6rk/fSyew
	k0QV2x4dGliUaqzuuTnA==
X-Received: by 2002:a17:902:f549:b0:2b4:5f96:184d with SMTP id d9443c01a7336-2c1639edf72mr63819855ad.5.1780537966352;
        Wed, 03 Jun 2026 18:52:46 -0700 (PDT)
Received: from [0.0.0.0] ([64.118.136.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629d042sm38955675ad.60.2026.06.03.18.52.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 18:52:46 -0700 (PDT)
Message-ID: <2bbc19cf-e098-46dd-ad76-a4862229786b@gmail.com>
Date: Thu, 4 Jun 2026 09:52:38 +0800
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nf v2 1/1] bridge: br_netfilter: move fake rtable off
 struct net_bridge
To: Florian Westphal <fw@strlen.de>, Ren Wei <n05ec@lzu.edu.cn>
Cc: netfilter-devel@vger.kernel.org, bridge@lists.linux.dev,
 pablo@netfilter.org, phil@nwl.cc, razor@blackwall.org, idosch@nvidia.com,
 stephen@networkplumber.org, sw@simonwunderlich.de, davem@davemloft.net,
 yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
 bird@lzu.edu.cn
References: <831936f111e6e1f435f4f6247d07fe6a6624d271.1779680014.git.royenheart@gmail.com>
 <ahagS3rGl2sG0OVS@strlen.de> <aiC7dFYZpiEHZeyG@strlen.de>
From: Haoze Xie <royenheart@gmail.com>
In-Reply-To: <aiC7dFYZpiEHZeyG@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/2026 7:40 AM, Florian Westphal wrote:
> Florian Westphal <fw@strlen.de> wrote:
>> Ren Wei <n05ec@lzu.edu.cn> wrote:
>>> Use rt_dst_alloc() so the fake dst reuses the core IPv4 rtable
>>> lifecycle, and release the bridge device reference during teardown via
>>> dst_dev_put() before dropping the bridge-owned dst reference.
>>
>> I think AI review is mostly correct:
>> https://sashiko.dev/#/patchset/831936f111e6e1f435f4f6247d07fe6a6624d271.1779680014.git.royenheart%40gmail.com
>>
>> - no need for constant refcount bump
>> - I don't think the ipv4 specific functions can be used safely here.
> 
> Are you going to send a new version or should this be treated as
> a bug report?
> 
> Thanks.

Sorry about the delay, we're testing and gonna to send a new
version.
