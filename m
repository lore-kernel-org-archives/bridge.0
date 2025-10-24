Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806882EB867
	for <bridge@lists.linux.dev>; Fri, 24 Oct 2025 07:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291804; cv=none; b=ujiyVrTFwWrRYkq7mSHpPgi1Ot12GmG09C6jw4z5Mcq0W4qWcBHHwScmhpM97GD/ph6L8D8roPN6/U+8N2SP9cMmyWGiOE4qRArcrYeivvGh1YPTnMpLFBWW2W/dxqs8E1zDAkPfaEgO8HgAArRRqqEdl9Q7BJAtPx22EdNjatk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291804; c=relaxed/simple;
	bh=n9vrj8rw3vvgLnp0wFhiU0wr83DTSKQ91SlzmqgRO7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FM025cAUxSRfx+RY1QNJ4Ya968h+CgceOdV0+7Can6cSbvTdvOTrwBMwnmNGWwKJ4CcVs7chAjfxTiVutAfFV2RLeh7UDGa01K20irMbyhuvYrK/tPyseejVjt1AipojkwVgTLId4dlwNeJZKo9SeoJkY3cxE8C3Y6ZU8PkGSic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=inP88IBU; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="inP88IBU"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3e234fcd4bso326416966b.3
        for <bridge@lists.linux.dev>; Fri, 24 Oct 2025 00:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1761291800; x=1761896600; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=btg6WWXpIi0CWUiiHvKL1LewBs3OVn+no42TB4G5pPk=;
        b=inP88IBUvY3uFxQ/0bLiFcNTu7hdFfnZcHvRt+q1Ktv0UIPEOwps7Qrj2oTa6L1TU1
         GKndmL1sFDwyqLdNajWHg/6QSpI/SVoThPPypxNag3nvUFA7fhEPfuVMD8aIAdrz0BHR
         xZ0+JfSmsTInN0B1h81iN+UK6ytIr8InrlBXRM0gbpb7RCgoY2p1TYAuTSqNo2h/KU+v
         4AtnmGUgzlZs3SnyA8arIIZygSedmYhi8XARV00ikP9/1bY1kL1Df6x46ij+w1MDReau
         Rfa9E1yXEKchRs2Y+eVTCJ29QL9euhSKsASCJ9DWQt+LeTqsK2jHvcf0RU6RLFwGfomw
         bCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761291800; x=1761896600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=btg6WWXpIi0CWUiiHvKL1LewBs3OVn+no42TB4G5pPk=;
        b=RfqAAnvJvinu/stanLIZHHry09sq8KRtAis6JdmW3gMbCS6FDnR18aLTmpEybsBRRn
         cbrdxnXh3JNv+cKELkoPujSc60pL4rCTlehEaCj6ES5e9yCoOa3EAq6lU7GjDFHnhjpj
         vuRXqiABH9nGOiksgVMJyxOKUijfofReS0PHhLiO0zmYnuJgv2jy8NqDR+MzfEBowsqL
         lO2/6iMe5ZMDIu0sPEwOpzydZVwhm2DmcgWS85YcJY0EM4IU3D6Mg0c3p4eELI5ygMv6
         ou5Vd5ly3w+VOaKImZVj6DYZq+VTJbvKiU9HFpI3RKGtzA4q1PCMADBguq/R9eCFPSgX
         8E8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXjWxl1ZhvKsBGuMFj7jzR02l25bSz25eCm+qjX9GMLmzNCsR019a5jNwTeemLU8xbRyaUTLFU=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyq3BFNb39t8jkPKIASp20wPlLJPtcn2bJJl8H4FxTfr62RyGuO
	O5a2YOPV0KLqzQQNVyUY0YnRzWxNjrVWzqDtg5/a7kB5ZOLeFlZK/rerKYJ8VZ0suZ0=
X-Gm-Gg: ASbGnctLBVt37+zrgO8APLEwdgMXD5Ph5cXzbaCrHqGvGfuiKixqTX/yEpUlclNiA3o
	WqmAzhtGeMTG/IpJiUJT6bFni1+IrcQXiqYv1W8REk7PXGPN1zkOdaa8cpO/E5MahBWONfp4JRw
	6zRiv8/R4rMGPzGRv0h+ITkfVPj99PyDxg5Vs/v2Sx7dQJy/c4hKO81r2XuvUuL1/4nWjlvpvAf
	clpfAJ0iFxk9zxCLQwlsl1qjQbMZal/OZdNhXF5KrsBF8PpKyJ0x1O1q20K2cV6LlfXPgz4MP+s
	YpMbmUgsSsjK2xNLeQRwpDESzvvSFIlG/4PF4ybAglDIsK8Bp34MtThN2bNvbaM1Zb7OwMghESJ
	a/rGKdB8iTMg/aowFJlW/Vz0uhT9hqj9pF0n67vyZYEnqyTkEeVjB1/PHcIAxUsnnYQYT1A1bph
	MHzq6bMKfbByP8Pt6w/N2R2gw/N4o3ajClYHbf5h0jDy0=
X-Google-Smtp-Source: AGHT+IENVgAAY05iZMjJCVKA8oSGaw8hZMk+fKU5hdYwbKNdz8hghfeyg+3i0gPeAqEdHdSGOTqcCA==
X-Received: by 2002:a17:907:1c21:b0:b6d:536f:ada with SMTP id a640c23a62f3a-b6d536f1134mr702214066b.43.1761291799580;
        Fri, 24 Oct 2025 00:43:19 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e3f316847sm3676823a12.23.2025.10.24.00.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 00:43:19 -0700 (PDT)
Message-ID: <4cb007ea-c29a-44e7-933c-cfe3f728d42c@blackwall.org>
Date: Fri, 24 Oct 2025 10:43:18 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] selftests: bridge_mdb: Add a test for MDB
 flush on snooping disable
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 bridge@lists.linux.dev, mlxsw@nvidia.com, linux-kselftest@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>
References: <5e992df1bb93b88e19c0ea5819e23b669e3dde5d.1761228273.git.petrm@nvidia.com>
 <9420dfbcf26c8e1134d31244e9e7d6a49d677a69.1761228273.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <9420dfbcf26c8e1134d31244e9e7d6a49d677a69.1761228273.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/25 17:45, Petr Machata wrote:
> Check that non-permanent MDB entries are removed as IGMP / MLD snooping is
> disabled.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
> CC: linux-kselftest@vger.kernel.org
> CC: Shuah Khan <shuah@kernel.org>
> 
>  .../selftests/net/forwarding/bridge_mdb.sh    | 100 +++++++++++++++++-
>  1 file changed, 98 insertions(+), 2 deletions(-)
> 


Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

