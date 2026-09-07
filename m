Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F5E49DB8E
	for <bridge@lists.linux.dev>; Mon,  7 Sep 2026 13:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788788797; cv=none; b=Y1WuebOakTRqlMKh0Ogyid12YTeW4lYgR3BW94Vvc8nXojvQsIvlyJiaNYutJU0TjfaoKHqXbsGOyChVCAAYL8IOKEhdyWfNVd32jPy24anE5qUJvrqjtdZ/H+xi45nu7bH6GBu6HQU3rmjUkNUnrSpYkCCOLb9rifYdCorOOSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788788797; c=relaxed/simple;
	bh=ey+ea/XaUzKmLSSv/fmRwtg/pqMjVi9RuYBhFPeenHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g4UZs9Ad+9K4WEULDeTShv0pK+lgKHx9hoIiq0W7E8vTnlTIzGN1SXihf/vvBYG4uWP47XpjH+dHbPNObyabnyGlH42/TnNVud3tFy0N03mipl2OS50AvzK76unREycHoHgK64Xm1edlF8RwavMJ9z7xeWrnFKMOfuePEZIJu/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=UskI9T6I; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="UskI9T6I"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4843f205a5bso2094352f8f.1
        for <bridge@lists.linux.dev>; Mon, 07 Sep 2026 06:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788788789; x=1789393589; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HmOQIAWcEZHB6gZrTF2GCi64OHYKHOStwvoinD4q/34=;
        b=UskI9T6I4Trx+TVJsFLFYosN4tPy2LMbq2LZsih37Vqz49Guc/mexqTsjiXg2T3glq
         +VbQw9g7IlgJYSHWe+SckeHwAAPHlQXoas96J+/rvGCX3jcL/8eRrDBm/FlB7SpeeI29
         FU5yuetlvLSHsvesoWtXbPqxv4olfrHiCJuIovJjlp1DhOjMSYhpgUYl/UVtzVzx1mmm
         M+UVOzQjEUUMQjmWTN7vDvlPQt6SQCNKnyx2kegKWOv++ZSrj1g4UQa3/HIrH9SekUio
         o7kASLlMZAsTa4L49WzXLyODyb2pVtxXgAKRXv+Whn8ux+Vl4rZYHLA1ND5988bk91yN
         FMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788788789; x=1789393589;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HmOQIAWcEZHB6gZrTF2GCi64OHYKHOStwvoinD4q/34=;
        b=mSl+aykPHJcStsLUJNrCGp0MdGKDGLs6y2UTEODiIfGpbQg+YJ0kB+hOPbrugOcEmw
         k8k4jau3l/+HdckNImGLEqGNLLffK64U0vo09i+1Vk/6oM4wCKN+pANPEAr1Bu1tcQ1O
         /uZUl1+THcr1GoqrBqdTN10U3yyUVhm1mHPAPlbZTxiaILAaQPEvWvJe59Mp3MZ9DTbZ
         vlhzRcVQRaMXz4l04L8udOhFP1tuUbEqdjfApmRD1hRCKt3Jo4rQhuClkik0s99q+IQc
         XYygAnoLPdAI2naueW7T0VwJqKk+2hFJq/YCJXpa4u3ixzGAv6SBdT3pTpRhmg29g7Pv
         hsww==
X-Forwarded-Encrypted: i=1; AKwUvByrmyMy6sBrpU6ISuBxGDfHPd8H0bvcyrIAJjeBip1qQ5wUnUfHMrZm1b0NVOl90XK16mhx1f8=@lists.linux.dev
X-Gm-Message-State: AFuF++mfsIociCLdJANNrMmarEaFLGPprqP1ciT+h/boxHeDeMd3r0Oz
	8VqXgDt3JpGJje0X8t1QZTjlMuXizadI1fzaiVbQPEiRjhm01e9J+ISNf6iInR2BBro=
X-Gm-Gg: AYBFou3N2LK7LWr0IVl6og7aoN4gDfeU3M7vcW2kXnBVIZBbu3AH8mOzHyUMJkLvc1D
	gZv9N6fvopPS3XAhbmBDeFHp82CrC2kpO0KZnWmvnceUNAUluX2PJs3XLgm+XhG13Cw9IWQYY6j
	GOR67WalO+Px1MeKWuIiYLzMTihFCe2gYGGtyU6Z7WNO8a95SSFebxD6Pv0dF4PDTkMI8zWqrOc
	5Ecc/58GyNDnKCKKOvWJ8365HQ4V7PYsUmFRNkaGs+KJiZD/0sO7WxvdPrnxi1S9Bt9aEwux+Kz
	H9+wsuTB9juqkB9QnhblKRe6CgslJtMBMFxHWywG41Y9dhvtMsgtY1zqdO6XZ9N59anocHAYWnz
	N6Con5NUOiIxoXIHxYVrvJL/0ZHeeKU3HxR6TTO4U9xr6ZH2Z8KJTs6eMrmB4hO3EnwM1jTEhhl
	MY0Vuf7a34BGEug1FRfBiC5ef8UX4oNVHOhEKNz0n0ACPInQl3/n+YjF9dQjSqmkHgcNeyaQ5IC
	PrW6UoD2LYBEfXj2M3Y
X-Received: by 2002:a5d:5d09:0:b0:485:8a46:b3cb with SMTP id ffacd0b85a97d-4858a46b609mr22977040f8f.51.1788788788535;
        Mon, 07 Sep 2026 06:46:28 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485958f1493sm17273193f8f.37.2026.09.07.06.46.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 06:46:27 -0700 (PDT)
Message-ID: <76e98b59-9371-4700-92bf-20e41aaf0210@blackwall.org>
Date: Mon, 7 Sep 2026 16:46:26 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: bridge: bound the port VLAN lists in the
 IFLA_AF_SPEC nest
Content-Language: en-US, bg
To: Artem Lytkin <iprintercanon@gmail.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev,
 Ido Schimmel <idosch@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, "David S. Miller" <davem@davemloft.net>
References: <20260906224246.21719-1-iprintercanon@gmail.com>
 <ba2dcdb6-923d-4fc1-9c92-7a77c0b61a09@blackwall.org>
 <20260907133505.5291-1-iprintercanon@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260907133505.5291-1-iprintercanon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/09/2026 16:35, Artem Lytkin wrote:
> On Mon, Sep 07, 2026 at 11:47:24AM +0300, Nikolay Aleksandrov wrote:
>> I prefer a more explicit path - return error for both (RTM_GETLINK and notifications)
>> you'll have to plumb down extack but then user-space will know there are too many objects or lost
>> RTNL_LINK notifications and it should resync (e.g. use RTM_GETVLAN to dump the vlans if needed).
> 
> OK, v2 will do that: br_fill_ifinfo() fails with -E2BIG once the nest
> would pass 65535, kept distinct from -EMSGSIZE so the WARN_ON in
> br_info_notify() still means what it means today and the error goes to
> rtnl_set_sk_err(). For the dump, rtnl_bridge_getlink() can turn -E2BIG
> into the extack message itself, which keeps ndo_bridge_getlink() as it
> is; or do you want extack plumbed through the ndo? The size clamp and
> the doc text go away.
> 
> Artem

I'd prefer to plumb down the extack so the bridge can set it itself and be specific
if needed. Others might want to fill it with something different, there are only
a few drivers that implement it and some may decide to return user-friendly errors.
Please make sure to split the patches well, don't do everything in a single patch.

Thanks,
  Nik

