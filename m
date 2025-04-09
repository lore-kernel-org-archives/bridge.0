Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9DE245012
	for <bridge@lists.linux.dev>; Wed,  9 Apr 2025 10:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744194822; cv=none; b=XeTgxr0z9gUtZOf8ncXU8UjwhYr49w05koZ61Zvzps6RQ4Dj8yYezYK4/XVBjSxInSxUZwM+N/jzEGdXVOknfSSeMqSFIGYEJFH7p6k4o6OFhrcL2ZlHxvpD3l8/Uj23grD+4E+JaR+hU/0GPLVgZugt1L/Mh0oOxuAcqRbHpr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744194822; c=relaxed/simple;
	bh=eJiiSL2hEBM31QpdZjTGxkNCHrjWvXRhsnysYFnGW1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MNYMO9jK/kBONvpHZw2gIwG7lG1TSnsmR2H1BIHmISW0MsTjdEsoOC9wE3zsb1Yd3b3ACNqAtxo+QGujHT2CMarCsT39OQBZQQOnY36ymw2qkc+ArahstBXaftG/1SbKm+w7lQL6fFu/EM+HBaOWN8A7BRFrXHgr7eLb9aS8dgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=g9yUQvS0; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="g9yUQvS0"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-399737f4fa4so3646615f8f.0
        for <bridge@lists.linux.dev>; Wed, 09 Apr 2025 03:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1744194819; x=1744799619; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iNYfYAHMIpD9FdvT1GsMuzUjrwnA51rOxuoeTYQFk9o=;
        b=g9yUQvS0eYIJDO1CN6JNl3CYUqUmqwe+Qjcu+m6XA2RwaOFFG8mJJkI7Hng+ZksCUT
         HARHFKqA9trI919opT5/YVViLm/DQWHVqUJ0nm8MNmli3sxZG82fqFN3sc++9Mx2ZIUN
         IRPKO0EMYRfuAuRxe9aKKE8DuwoW4hxJ7S+P9f2ImyKfAWg0fp0c/gUK1lbvZUFAiSwp
         Gee8C1EhioUeXBGKCdLvZ5vN9ADutMWVXiTu/MYRJz2F0aaascSpDU0EFVCRcg3z1F6M
         071F7l5AQY/f3+vp6ECcP6Rg22I0ziDf3tYQa58nTzAYtV/bFpxiOmPxkQdHDCps2Z4L
         TZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744194819; x=1744799619;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iNYfYAHMIpD9FdvT1GsMuzUjrwnA51rOxuoeTYQFk9o=;
        b=dX2evLjVq+x6YDHGYWDs88BEDyCT3YKcjtpvH926ARMqqsaiTS0O7N18f3O9OT/iv0
         mt3ZnMtwbtGE2DEaLXXRBa9U+G51yHLdlvkP+EZ8T0RzVfcaN2CKC3pQXKQgo8J2L5fs
         R/5O/Hwil9tKn9IJogUX6+RS31sJ3XszAedaDW5FSVNBk4ZxOjRMY48uj04qR3Ug8R5E
         kWzCI4gi9//yyWeqjK7ewZwDvSi5s8nxAAXXz3NGZ/HHDrqYoUS/z/C5b7ZKojvMjdse
         jByM2U2NG1Mey+1bLn5wUFbJlNVTBlhg6pHRVMyX+1Cww2QuBQHylxZ666xXBI0d0SoD
         P8IQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZNzWl1+LIXF1oEiCUyERRzb45nXDW6+Z/WHydVhXbXgXhTiaVptOE+El8eeoFhfbjUFciNBY=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4Q4QghGIw/G0rJ4FUIOEhWzI3SbENK74LvO73gfjxwB7I/zK1
	BW0oqVzU003bZw01mUaOHZwc8zWl8QCFm7YpDgPrIDEOWwsHiv6dYLytXrc9jvQ=
X-Gm-Gg: ASbGncvpvg3vzUzjR6iWWyvZX1OMo4TgtQ4Xzglqr2/7jiJDJDaKq5SpsLSqXkmelT9
	mFQFXP6TGXDKWDizUbMgc3rXN96Ct3GLsQBYNTkT4+w7luYzLWiVoM/wohQUKuyEKIAPJGPm09J
	a61KwH3sMMmhnB5sJNX7ev1gzo7UxU0HDvqI4lSPD8mzOuxNvxW08LYQv2qZMTmzdYILr5IRKdB
	zbPa9rQMTt+tkUKaHHbb193ogHeA05b7rIwNy70l1zwbCsztoKHIyQ74Uxqo0qEsng04RHS/rX0
	TbPvLVeN9OfTiDkrvYRrvLLE/a0Kjh1qgYCES3keGhaLTejoCdnAqpVopZjFhDQ7FMxgm8bJ
X-Google-Smtp-Source: AGHT+IGOViq/FFxXMmab/4pISxbhFgAUX7J2o72U3BiWbwrZb7f0t75b8fXgPQvEBnKDhmE/5Yxtmg==
X-Received: by 2002:a05:6000:2508:b0:39c:223f:2770 with SMTP id ffacd0b85a97d-39d87aa7b97mr2230265f8f.15.1744194818617;
        Wed, 09 Apr 2025 03:33:38 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d893773absm1263777f8f.31.2025.04.09.03.33.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 03:33:38 -0700 (PDT)
Message-ID: <4ee836f0-9d28-4e40-bcca-1b4eadd040f3@blackwall.org>
Date: Wed, 9 Apr 2025 13:33:37 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] selftests: test_bridge_neigh_suppress: Test
 unicast ARP/NS with suppression
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux.dev,
 mlxsw@nvidia.com, Amit Cohen <amcohen@nvidia.com>
References: <cover.1744123493.git.petrm@nvidia.com>
 <dc240b9649b31278295189f412223f320432c5f2.1744123493.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <dc240b9649b31278295189f412223f320432c5f2.1744123493.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/8/25 18:40, Petr Machata wrote:
> From: Amit Cohen <amcohen@nvidia.com>
> 
> Add test cases to check that unicast ARP/NS packets are replied once, even
> if ARP/ND suppression is enabled.
> 
> Without the previous patch:
> $ ./test_bridge_neigh_suppress.sh
> ...
> Unicast ARP, per-port ARP suppression - VLAN 10
> -----------------------------------------------
> TEST: "neigh_suppress" is on                                        [ OK ]
> TEST: Unicast ARP, suppression on, h1 filter                        [FAIL]
> TEST: Unicast ARP, suppression on, h2 filter                        [ OK ]
> 
> Unicast ARP, per-port ARP suppression - VLAN 20
> -----------------------------------------------
> TEST: "neigh_suppress" is on                                        [ OK ]
> TEST: Unicast ARP, suppression on, h1 filter                        [FAIL]
> TEST: Unicast ARP, suppression on, h2 filter                        [ OK ]
> ...
> Unicast NS, per-port NS suppression - VLAN 10
> ---------------------------------------------
> TEST: "neigh_suppress" is on                                        [ OK ]
> TEST: Unicast NS, suppression on, h1 filter                         [FAIL]
> TEST: Unicast NS, suppression on, h2 filter                         [ OK ]
> 
> Unicast NS, per-port NS suppression - VLAN 20
> ---------------------------------------------
> TEST: "neigh_suppress" is on                                        [ OK ]
> TEST: Unicast NS, suppression on, h1 filter                         [FAIL]
> TEST: Unicast NS, suppression on, h2 filter                         [ OK ]
> ...
> Tests passed: 156
> Tests failed:   4
> 
> With the previous patch:
> $ ./test_bridge_neigh_suppress.sh
> ...
> Unicast ARP, per-port ARP suppression - VLAN 10
> -----------------------------------------------
> TEST: "neigh_suppress" is on                                        [ OK ]
> TEST: Unicast ARP, suppression on, h1 filter                        [ OK ]
> TEST: Unicast ARP, suppression on, h2 filter                        [ OK ]
> 
> Unicast ARP, per-port ARP suppression - VLAN 20
> -----------------------------------------------
> TEST: "neigh_suppress" is on                                        [ OK ]
> TEST: Unicast ARP, suppression on, h1 filter                        [ OK ]
> TEST: Unicast ARP, suppression on, h2 filter                        [ OK ]
> ...
> Unicast NS, per-port NS suppression - VLAN 10
> ---------------------------------------------
> TEST: "neigh_suppress" is on                                        [ OK ]
> TEST: Unicast NS, suppression on, h1 filter                         [ OK ]
> TEST: Unicast NS, suppression on, h2 filter                         [ OK ]
> 
> Unicast NS, per-port NS suppression - VLAN 20
> ---------------------------------------------
> TEST: "neigh_suppress" is on                                        [ OK ]
> TEST: Unicast NS, suppression on, h1 filter                         [ OK ]
> TEST: Unicast NS, suppression on, h2 filter                         [ OK ]
> ...
> Tests passed: 160
> Tests failed:   0
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>  .../net/test_bridge_neigh_suppress.sh         | 125 ++++++++++++++++++
>  1 file changed, 125 insertions(+)
> 

Thanks,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

