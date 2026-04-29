Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727CC3BD22C
	for <bridge@lists.linux.dev>; Wed, 29 Apr 2026 09:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777453471; cv=none; b=XwHTr8koueJ4babswT0V0akeLN881fwZuOsyABzpG/PFn+/rQg0DM3fjJ/cKjLF4qxdnBeLonz707RPeZrOPTwenWX+w2U7uBjaFmUnhF7J3nZJn8IGX/L86gbbpPe5aNopjicO5AhgvVB4e65QRJKkZHNTAymq/+MPiJnsZpws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777453471; c=relaxed/simple;
	bh=qSb3SGcwsDkoHlK03XEymnt83+9LDsaxAxUN607t7f0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k8DKysEkLWoQN6RIEyvCXL0XzeZVN5Sd/P1DWaYvCS1Hn7MaaE9AYFm5VIZBKBj0FK1qvZX00X4h9Dh929HnzWDc6pPgpOJD/aobVeKODLYHxirISwNhgRTfnn4eLLZsk6eSHHlKco0U0ZVROD9RCSIPi8w+7XWc60RNiZas8ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=U6Ivx8EJ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="U6Ivx8EJ"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43fe3e22e33so7903026f8f.0
        for <bridge@lists.linux.dev>; Wed, 29 Apr 2026 02:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1777453468; x=1778058268; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dkrOQ/G+RJZornxNRPNTMjR8gIzBGAkvbEb+2nxyTLg=;
        b=U6Ivx8EJbkkIRHeDj/7gkQboKVgteen66dz8JIPZg24gMA7GxA7mTZNP24neHAeJRs
         a/t6vH9jnHWt06o7yy0nbJUT+jMIBZEsAMCAm5SRnUxruNnyx09kNe967Bk7AImzvDvK
         kkcnn1EsXQLEN/CKZgYjxmHVx2Oe+fTkY57ovYeVojiB6UFZODvaxW1MrsUbqRWTQ7pO
         aPEKo6GKr0c0wDhQOlioaTsIP0ZcQbyLMBMOxCH3FVlcsyawQM0KPb+j6BnC/wP14NaK
         qWZwm0l2ihjI5ZOORiDkI5oc+IBnnU3RSwoDCSZoZVOmdcA8V55IFDUkEh4vEQieEjZ0
         /zMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777453468; x=1778058268;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dkrOQ/G+RJZornxNRPNTMjR8gIzBGAkvbEb+2nxyTLg=;
        b=lzasbQ0/jjZQOXGrEl13o3Yuw2kbHA1cIo6jUtpC3MTuVTiFBfyAQUHxwsnbKkWMMu
         jRCVHoxcMiVZJY2Wk8ON0XGjlg5gn65la6B3Krg8/uAFNmpxEujQO2pUKNn/RdM/acVJ
         gwYxORvhFUVbHuPX8fsxmih8207OYBECnLGF3tOWZXNI7F2edHAGNYU7WcLWS5Q3jhXK
         GkcaQUCwAZmaiIX075v97sUS2HwoFJTOqnGqicHuh8/DNhfmKTBKkEH4n+9KYs+eBrF2
         gHUSvVEafTweoPordmxpppaeHY0DnRyQiLwREUppn+Z0asCtk7kKTfPoGcxUbioKVjZ0
         voLw==
X-Forwarded-Encrypted: i=1; AFNElJ/bVedyXPd8X3X4DgfPSCRFNzFhSCbJr8pIg6ND05m8mplqjJIX6cNas6FJOiEpktrxvMIP4bM=@lists.linux.dev
X-Gm-Message-State: AOJu0YwTrdnBc+0hIWs7cDnjb7DoBeNFbbwHzjlapphabwntaoOjlstL
	73wVBoiIgkcLixa0UkjXo39bVaZ1nen1+XUx1bok74dr8a0JB/LtAM9RJ0qsIObVBWc=
X-Gm-Gg: AeBDietOTGCCa1KNGK8r2+1rztJrfTEQQUGZdMPcmHxRrkW9QiD6gvMYxQa+9D6o9Ic
	NlatAQKsxW8Ws6rx3mQro+2M0KGvnqfUigMM8Rc50187d7UUeq51SXrZW6AcvvmtekPNEZz3icS
	OiJ/1aoGtuq6MKYyhKHabmt2Zyp5FtvjKJnf2IX4tRa+A+BoL/zqcike/pMZTPTtXQPnUo6G17Z
	yS8+juWjtIM3lDtiSi40nX2JspKJcSsqg6B8s6Ce8QQOI6z07P2DORzst1uk3BM0jWVZs1yc8MZ
	bFlc4DxLp8QgFUrinay8AvRRu8Kb9WkG0ZyL8aEoR91xvd+8dhHwTZcRZXOQL/oP72hT3cwSBrm
	NTjh/2yN2VsJOjCCFssaUwd/xKvSDKwqojtAQKVV7JXbUzsWxHtKGevFyEfHmCohk42JNeygJVV
	JTaMQ+a9yarqYVjJzHCgnypXUsPD/zHcA4MLsi6IT7wNU/Qam6krx6H8UxBK/tm+9O
X-Received: by 2002:a05:600c:4645:b0:48a:7aad:4425 with SMTP id 5b1f17b1804b1-48a7aad4537mr42583695e9.3.1777453467792;
        Wed, 29 Apr 2026 02:04:27 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c2d3811sm20967725e9.3.2026.04.29.02.04.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 02:04:26 -0700 (PDT)
Message-ID: <efa4eaf9-0c5f-4cea-ad9d-dd1052ccab76@blackwall.org>
Date: Wed, 29 Apr 2026 12:04:25 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] selftests: net: Add tests for ARP probe and
 DAD NS handling
Content-Language: en-US, bg
To: Danielle Ratson <danieller@nvidia.com>, netdev@vger.kernel.org
Cc: idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 bridge@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260429062405.1386417-1-danieller@nvidia.com>
 <20260429062405.1386417-3-danieller@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260429062405.1386417-3-danieller@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/04/2026 09:24, Danielle Ratson wrote:
> Add test cases to verify that ARP probes and DAD Neighbor Solicitations
> are handled correctly by the bridge neighbor suppression feature.
> 
> When neighbor suppression is enabled on a bridge VXLAN port, the bridge
> should reply to ARP/NS messages on behalf of remote hosts when both FDB
> and neighbor entries exist, and the answer is known. However, when
> either the FDB or the neighbor exists, ARP probes / DAD NS should be
> treated like regular ARP requests / NS and flood to VXLAN.
> 
> Add two new test functions:
> 
> neigh_suppress_arp_probe(): Tests ARP probe handling by triggering
> duplicate address detection using arping -D. Verifies that probes are
> flooded when the bridge doesn't know the answer, and suppressed when FDB
> and neighbor entries exist.
> 
> neigh_suppress_dad_ns(): Tests DAD NS handling by constructing DAD NS
> packets using mausezahn and verifies correct flooding/suppression
> behavior.
> 
> Before the previous patch:
> 
> $ ./test_bridge_neigh_suppress.sh -t "neigh_suppress_arp_probe neigh_suppress_dad_ns"
> 
> Per-port ARP probe suppression
> ------------------------------
> TEST: ARP probe suppression                                         [ OK ]
> TEST: "neigh_suppress" is on                                        [ OK ]
> TEST: ARP probe suppression                                         [FAIL]
> TEST: FDB and neighbor entry installation                           [ OK ]
> TEST: arping                                                        [FAIL]
> TEST: ARP probe suppression                                         [FAIL]
> TEST: neighbor removal                                              [ OK ]
> TEST: ARP probe suppression                                         [FAIL]
> TEST: "neigh_suppress" is off                                       [ OK ]
> TEST: ARP probe suppression                                         [FAIL]
> 
> Per-port DAD NS suppression
> ---------------------------
> TEST: DAD NS suppression                                            [ OK ]
> TEST: "neigh_suppress" is on                                        [ OK ]
> TEST: DAD NS suppression                                            [FAIL]
> TEST: FDB and neighbor entry installation                           [ OK ]
> TEST: DAD NS suppression                                            [FAIL]
> TEST: neighbor removal                                              [ OK ]
> TEST: DAD NS suppression                                            [FAIL]
> TEST: DAD NS proxy NA reply                                         [FAIL]
> TEST: "neigh_suppress" is off                                       [ OK ]
> TEST: DAD NS suppression                                            [FAIL]
> 
> Tests passed:   10
> Tests failed:   10
> 
> After the previous patch:
> 
> $ ./test_bridge_neigh_suppress.sh -t "neigh_suppress_arp_probe neigh_suppress_dad_ns"
> 
> Per-port ARP probe suppression
> ------------------------------
> TEST: ARP probe suppression                                         [ OK ]
> TEST: "neigh_suppress" is on                                        [ OK ]
> TEST: ARP probe suppression                                         [ OK ]
> TEST: FDB and neighbor entry installation                           [ OK ]
> TEST: arping                                                        [ OK ]
> TEST: ARP probe suppression                                         [ OK ]
> TEST: neighbor removal                                              [ OK ]
> TEST: ARP probe suppression                                         [ OK ]
> TEST: "neigh_suppress" is off                                       [ OK ]
> TEST: ARP probe suppression                                         [ OK ]
> 
> Per-port DAD NS suppression
> ---------------------------
> TEST: DAD NS suppression                                            [ OK ]
> TEST: "neigh_suppress" is on                                        [ OK ]
> TEST: DAD NS suppression                                            [ OK ]
> TEST: FDB and neighbor entry installation                           [ OK ]
> TEST: DAD NS suppression                                            [ OK ]
> TEST: neighbor removal                                              [ OK ]
> TEST: DAD NS suppression                                            [ OK ]
> TEST: DAD NS proxy NA reply                                         [ OK ]
> TEST: "neigh_suppress" is off                                       [ OK ]
> TEST: DAD NS suppression                                            [ OK ]
> 
> Tests passed:  20
> Tests failed:   0
> 
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> ---
>   .../net/test_bridge_neigh_suppress.sh         | 126 ++++++++++++++++++
>   1 file changed, 126 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

