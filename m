Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2155F3C5823
	for <bridge@lists.linux.dev>; Fri,  5 Jun 2026 08:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780647612; cv=none; b=MoXkzIMA7IgFiShYShNSPrS3hpIVc1yEyW3MC7UdQr9RRvtghUKfcW+blFXuoV2LwP6/DHz+Ya/nfMSd51EdTpZbLmyqJkI63zLEIVuFeCmVFQF2MT1q0itQPYlaRizOeWA68JLJVXLEs7OfXxkiCC5rYRWqAEowRfZHp1Tl8do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780647612; c=relaxed/simple;
	bh=Ad1nIwuhBFfO4iShVdGuS+I6zfiRoplsexotURrrbuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kDyye53pqfXO4qYicQ1qOcVKi/CAaWzNsIRlaZdzlutaf4A2P+iu/xS/NONjCC0paElHKBY/0gsAfrHdnDKZ4hHbXrngIKiVpQv3JEKfl4A2XtAgnDcdJClUJZKpjVmHuit5sgEhuvT6yNUyKjL3FKIW95Azx3y0DSzsqvyUGl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=RpdNJm/q; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="RpdNJm/q"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490aebf33e9so8759745e9.3
        for <bridge@lists.linux.dev>; Fri, 05 Jun 2026 01:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1780647609; x=1781252409; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HO+c1Ts8db7gdpq3ytaulcv5tyCH+8/4qMx4yWr0gHo=;
        b=RpdNJm/qTikbraRGEkIWHpyeSXKduEIl15hs0lcT2kFQ1SqM07idCW+jr/81nOgMmG
         VzEpPO9QKlY4JLrXYeobZ3TbFhpmJWyR+ej5DnnZ5AvVx5zPaPGyplOp0AHc0bommgTv
         shlgRiplCp1tl2aK5brwDbo143inp5hS7QLJP6CLDgAxswuKf2cAj6R5VDNB/zKh7dnX
         OBo23aqYTjGe7LBriEw9FOJLhUk+ItuBgXG0bpF6gw+WyPAMFNfiUUypuRcqGAS1wZgF
         EG8XY+cJiMcKxxkWMBq/Ih2wyfUno2l2fIeDfSM9fThamgjXuSu/igkm8qldSe0uVuWT
         bPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780647609; x=1781252409;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HO+c1Ts8db7gdpq3ytaulcv5tyCH+8/4qMx4yWr0gHo=;
        b=S3QGh8uLw3bEbyL5W6GYhUfpkDJCy8LWXTnNnqKLMygSo4RgotgCJGhLnL263Xlydy
         pALTqaMPuyN1xWBco8n5+JQbM1QWZwj77wiLJdjVsTeBLJ0btyZ5B5DtDgVMkDeefWlA
         eORZ37qQc6qfZ2JQm9nmIQu/0HH/t0yTEk9OtCE/MlJJrUcfzu6cFlbQixrfmehlqEqE
         PFDpTTqD5aRGyGw2PXXDeFD8SEDUqQw7DecAXBnze4GgulQNfHn2RgYIBB43GNEcthl6
         9Y2O0WXgZVREzdE4Uy9gc1RUfJXVl4/79adVj8uIigOv5eLE6vPr/5ZRDOoqgQP9ozGX
         FQLA==
X-Forwarded-Encrypted: i=1; AFNElJ8g0BKDOBQbpwlsnOCbPIc13yuUsAS2rX1BMlW0vuEU7KF/DcGnnHEoHy9ScF2xhYBzqI8hVQE=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyzo/JWZlfdzMyRqkjb4kFTMb3lwQ1/TnWKTjs6MrHQUZrI5NGF
	kYJcvR8oHxMQkS9283qdXQozmtmz4NNMz2nA0qd1/cr+Aoz3sgPelrkscwyu+YyObfo=
X-Gm-Gg: Acq92OECkwNLSpe7WmDjivQ3mBo5NAd9ZTPIlk/Wspy8T7oCXzGeVsO9UijptPpgk5p
	Mrd1Pod54m1om6Etn/ZFWbpux53fxYv9OM6CzBRsVVLYQ5ixWjGzx/tBgRrPiQnTcN7DzPakLto
	H7Ux62WecUrhIpimiuOwOFn06KabDkGGpMy9mZxYK/IyoyTweCpw17hny6k5VbGoQN8CpSxnPZs
	7YqiSAhlk84CZr7UJu4BVA7Gid9ijjNfMwkSIi+XLT3OR8dKwpNgynBGXTitHM55S/w3DUY4wv+
	xjcOkib/SQ7ceQlH3fidkQ/w0O3NunN3N0qPwoLep0qKYZ9D+D94k3oew/4zm/BXNqlh8K23Eo5
	3yvFFS4oPHsH4Fkx2Bhvyc9xg3H9h/p5OmXeg14m/xmcKelS2h40CPOW8tlzwu/Dki2bAdc5D8v
	xU/vDQ+0iIZ61EeBBoxVigEOf8n7rvmC3TQPw1ga+vYjn3YI6/pfXhWJ9u1zlUlmshgYuXlKIrU
	Z8=
X-Received: by 2002:a05:600c:6387:b0:490:b26f:a512 with SMTP id 5b1f17b1804b1-490c251d015mr39333285e9.0.1780647609238;
        Fri, 05 Jun 2026 01:20:09 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f345209sm23277449f8f.17.2026.06.05.01.20.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 01:20:08 -0700 (PDT)
Message-ID: <4d9067d9-2a4a-45e2-aa43-c456648989da@blackwall.org>
Date: Fri, 5 Jun 2026 11:20:07 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] net: bridge: Move long delayed work on
 system_dfl_long_wq
Content-Language: en-US, bg
To: Marco Crivellari <marco.crivellari@suse.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux.dev
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Simon Horman <horms@verge.net.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>
References: <20260507134815.295588-1-marco.crivellari@suse.com>
 <CAAofZF6CcyxoOsYr94KARUFtfi+=H1nF3mBQAtFWxEujdVgXUw@mail.gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <CAAofZF6CcyxoOsYr94KARUFtfi+=H1nF3mBQAtFWxEujdVgXUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/06/2026 11:16, Marco Crivellari wrote:
> Hi,
> 
> On Thu, May 7, 2026 at 3:48 PM Marco Crivellari
> <marco.crivellari@suse.com> wrote:
>> [...]
>>   net/bridge/br_fdb.c    | 2 +-
>>   net/bridge/br_stp.c    | 2 +-
>>   net/bridge/br_stp_if.c | 2 +-
>>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> Gentle ping.
> 
> Thanks!
> 

Ping about what? The patch is marked as RFC so it is not
going to be considered. It already got a reviewed-by one
of the maintainers, I'm ok with it too, so when sending it please add:

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

Cheers,
  Nik
