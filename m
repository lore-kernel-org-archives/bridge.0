Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3AA2DF13F
	for <bridge@lists.linux.dev>; Sat,  2 May 2026 06:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777701990; cv=none; b=LYtY5xEZrrmYc4gxmEekHFYR2+UlcjEFpXm3DlVBWH8bsTO7d8DeWfPJWA4+60lnnK+uk5Zh0Jmf5yW4iRis6NIPHE/9Gsd1cC8jO8p7VzuXqAD3cdF6CNSl/EHuSQpRfFsOcjEhAeQE+IJMfvTc+9YuJX9LdEDsQfzpnIU8MRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777701990; c=relaxed/simple;
	bh=KTOCjruETFFyA9eMpMwBg7rk2PGjXG1IZi/DfUc1peI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uhokYuA6ttPvLOrsaz1krNT0gpCA+D1JxbxN4kqlnn+q9rv/b9XphLPI90HI5/5VM22tPDjPqNiTV2aB2Dpl4WTbeBSrsoNIy1uXQdAy2NTwHUjwnj78yNcXVYINcL0QWaKDgK6iDGLsd1qML1qyBqzvnPvYKRjNBzShffbhJjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=fjjv1c9P; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="fjjv1c9P"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48909558b3aso25903035e9.0
        for <bridge@lists.linux.dev>; Fri, 01 May 2026 23:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1777701988; x=1778306788; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2x13DrMgH4CKBCggYi3SP9iAtnspCOSFTNkvACPndhs=;
        b=fjjv1c9PcUOwyb2XUOsf7QdOpOPJUIn01+JgPsU492qiXBepE9w32esNcSg2gkPRmW
         SFrto0xlKESHTRxr6rvDNE0DHPuX70IXmqxhReh3pVKM2gxVnKsOHdkJqDuLbqwH4ksX
         Z08hxTHym0GtAT0tCftrMKIBB1MEo8bXMNecMQOvTwJsbh/tC0/mxtOBZTslUoDqOYGd
         46QPAmaWhFUDyL1Cw5hEMRAtQn45k8jtr4lpEhABs1EaNDSFIVZbDFFEjwL0zmRsZcFF
         srm/MLrO1sRib5d3+nzUW/aza8bfeoDZGoDIpPz1W59hW5aYhY6ugnnLJMMDw7wvg483
         vRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777701988; x=1778306788;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2x13DrMgH4CKBCggYi3SP9iAtnspCOSFTNkvACPndhs=;
        b=e6sgaeY1Gbf5sUkfuOR3KPEs6ya18mgGIhVK2ATN97FLD0I5W7SsuEzf5xLgwR1hIJ
         UEwafuxGBO/CNhHaRvywEZigEtPQtPglHbWJcSGsFfIhre1YKdeV0wm1TCK+BKVaiLRQ
         yS//n9Jm2nLdLAcOiBmtOUeX4TRISEZjSoogvc7O398esYsiuQ8JAi7kfikFPHE/fzFj
         B3CPXQteBscErhPzYAqt8xRJ5SlffutX7kuD4oVqx0fQGt8uHCI6GvU3jWFKC+Es7cy/
         7NT2E0ZYR/wbBNJeP472Vq0iXOYgEVAWgjK4itkpiFSpcCeMOMIiSuMcZWYWaZmtO1hk
         8ODA==
X-Forwarded-Encrypted: i=1; AFNElJ/GQJMB3xZx2B6PY4MBVH/iuApkfkWwGZdzjNwAMcFvslFb60rH2KjTxt0cN7lZ14+GVESWyO0=@lists.linux.dev
X-Gm-Message-State: AOJu0YycSOvB+qOeh4VQhB/r1cOa/UKp+eExyoJ5fgt64t7xrh4LNWRp
	qHalhjiRj3qidiZPy5q0OlO7fjwt7IVePgcne0ecOuoKsqHiMMtdeqha7+dJELw1MFo=
X-Gm-Gg: AeBDieuoEGhxbsKIAX2LqpM76e69nJ/yihFh3ohVpnCTBuh0Xk23GgtLlIPTKgGvnvI
	sZV+LIv2e8zDlSKW9BHY5MwCiTWRTKG08BiN4qaL8nKAmYzZGEcwRDpKgfYA1CAYn0nj7SWr98y
	vD0Gv+bRZgSMs2zjFL05vzcTlW2hvgdUNqwXwwhGV+49KHt43sYTsJPSGyOAzaxNrB/POQuAge6
	dQqfYhlkHehVSHxKiJOZLnegPf/O532l/kgw0cL2Uej1XYqyV2S4u5yswHNeqd+vcujsQ9wud36
	cBvKFdQsphBabMOzUAy28i9+7Y4xhupuIyZP8rUiIa2qNfaVJb9KabOB65sHdHgiXHTM6OQgxnT
	LuMMA43wYxaWU8knclnU0IHS1At8++31iYe5V30GLnWxsT2ITfqFqy6qVMga3q4qMtQqigSpPIW
	1ZVGquD5iT89ryMRIaT2kuIvW1LCIueIfLQprFqbTx9Z0kDVo8gEZtQhsz2UYORe2eLknJhkH4E
	SA=
X-Received: by 2002:a05:600c:608a:b0:488:acbc:b2e with SMTP id 5b1f17b1804b1-48a9865d2ddmr24979785e9.17.1777701987611;
        Fri, 01 May 2026 23:06:27 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb3427fsm171888165e9.0.2026.05.01.23.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 23:06:27 -0700 (PDT)
Message-ID: <fc6c4143-d279-4e79-ad8b-c5c06949dcd6@blackwall.org>
Date: Sat, 2 May 2026 09:06:25 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 5/5] selftests: net: bridge: add MRC and QQIC
 field encoding tests
Content-Language: en-US, bg
To: Ujjal Roy <royujjal@gmail.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>,
 Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>
Cc: Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260501173130.3486-1-royujjal@gmail.com>
 <20260501173130.3486-6-royujjal@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260501173130.3486-6-royujjal@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/05/2026 20:31, Ujjal Roy wrote:
> Enhance vlmc_query_intvl_test and vlmc_query_response_intvl_test in
> bridge_vlan_mcast.sh to validate IGMPv3/MLDv2 protocol compliance for
> MRC and QQIC field encoding across both linear and exponential ranges.
> 
> TEST: Vlan multicast snooping enable                                [ OK ]
> TEST: Vlan mcast_query_interval global option default value         [ OK ]
> TEST: Number of tagged IGMPv2 general query                         [ OK ]
> TEST: IGMPv3 QQIC linear value 60(s)                                [ OK ]
> TEST: MLDv2 QQIC linear value 60(s)                                 [ OK ]
> TEST: IGMPv3 QQIC non linear value 160(s)                           [ OK ]
> TEST: MLDv2 QQIC non linear value 160(s)                            [ OK ]
> TEST: Vlan mcast_query_response_interval global option default value   [ OK ]
> TEST: IGMPv3 MRC linear value of 60(x0.1s)                          [ OK ]
> TEST: MLDv2 MRC linear value of 24000(ms)                           [ OK ]
> TEST: IGMPv3 MRC non linear value of 240(x0.1s)                     [ OK ]
> TEST: MLDv2 MRC non linear value of 48000(ms)                       [ OK ]
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Ujjal Roy <royujjal@gmail.com>
> ---
>   .../net/forwarding/bridge_vlan_mcast.sh       | 140 +++++++++++++++++-
>   1 file changed, 132 insertions(+), 8 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

