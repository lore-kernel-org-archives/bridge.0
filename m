Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794416441;
	b=ti6l+uNohKFtzewRoe8g85cEZazV9CjFPcDqbkdhFUv4lUIcKaNosJ1BcfAikLYZzb4j
	 G/2k+DBhL30Ho3yuqqfmw1g1O3FtI4QbkW5LcDRhRs6VzRZxcS4a73ecpEh7LsNRp0O/2
	 CSmY6bbPXKRbonCsvMca5TVK6kAy4t6pVHoLtk5K0EWo+0LEgZSAWhOZ0GAIDTsBpm92A
	 d/q3C275klyRBJR3ACfmMJiVoCpgUmw1fGMTxLPmebKEHn5sJFOOrY4JD+XiOjZ5nx2QV
	 RP5N56+mGGfxpgp0aV6n4887z6YQmiIV56N0CR1dUT+vAfii2qg1vYJOJkf/Krbj38w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416441;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version;
	bh=74FoFchhuSQQ2jSNjsBXa6BV1QiK2Fm+lk28fFAbdUE=;
	b=pdg4i3ySyy54F48GXH/FGayKrC+jT8is+nF20415MS4gniZZ868Fr7QM6ZF6Z+1rRruN
	 9xgJQf5sI+BN3y1Vh4IhX52X38P+17DTLwlNFjFDIk+oIh5RUI//ABcd6IOJq5LeB/6SI
	 5WG4I+QgbZRYDl0RmdXEzyAEr4tpIRUOpYGl5afBXH5RwUSU8CJ1aR1RXvrKEoLCSOB/r
	 SvaIwYK6p7L5un2CIocOD3Scw34VUgAAen1KXvZAtnrBrX2a58Xntz2048xEoZWgh4UpB
	 Lo3DGdDVijrk/zBeIOxWV3ILGrhwENBwezEOdCFtiQkMd99sxSdHrXaFecj52kpLjEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=KKDUZEPW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.30
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F517606A324
	for <bridge@lists.linux.dev>; Wed, 11 Nov 2026 17:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F517606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=KKDUZEPW
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6ABF2hrJ2306571
	for <bridge@lists.linux.dev>; Wed, 11 Nov 2026 09:00:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=74FoFchhuSQ
	Q2jSNjsBXa6BV1QiK2Fm+lk28fFAbdUE=; b=KKDUZEPWjFxEuM39SyRtvJ/r0/c
	+hQ8uhEGP6gr2JUPPDpEGcq0NTiQEyQ9i8Y2g3dv39QgOtx59p8EVdbDUQLa6L+t
	94/0SvdQaKFzm4Cv+3qMAatvhm6L/NQDjRHUOOvxpSMqYTskbxEpPNPMbZb8J28Q
	VEnA6gATK7C0rGaA8Xc8mBs9uwKNehQFzrIi16cEvw7v7laleiJrStlzJ6yosvTH
	sB1t+/ZON2DzbCDWmVTFGDgroxRJzYUeSJWeXZaQlf4jqciqfQuDmTSiFxExpl88
	c+tWUz6RkiMrJFompExetsSO2R/KCDNAgyE+nnENK5DPuycgfbYUa5suUXQ==
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	by m0001303.ppops.net (PPS) with ESMTPS id 4hv72prg3x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bridge@lists.linux.dev>; Wed, 11 Nov 2026 09:00:40 -0800 (PST)
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e29c25101so1715784f8f.3
        for <bridge@lists.linux.dev>; Wed, 11 Nov 2026 09:00:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794416439; cv=none;
        d=google.com; s=arc-20260327;
        b=ptX9ZwssprS0kOSl0y1NV69O5AG7aZiIh/eQzQ1HLX6kpCj3yRuCPNES5y1urbQ8kR
         85g11dJfHswLAeFau9lUnaTtZpGkzBAFnAr78HkLKXDM5KMm8Cf8wAp7RPHnzLMZYJTy
         ECFM4j82qAsGCkD99O+2qvTPkhnFo1ze3LZjquaVtaHKO6daZDqzjtRJZuM5w7G13w4K
         y9cI6oS5OWuaCZHNVFr0NaJTXaDXgZZdaGUMCElUNRlMETPNd7cys94L8sM0iUAQ63Bx
         ktyH92Corun2OJz4rsAbU6KjL0ULuh0m5/cV3mL34dHBfyuZdPl5IaX7NPxUCbNcnl1m
         EO3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=74FoFchhuSQQ2jSNjsBXa6BV1QiK2Fm+lk28fFAbdUE=;
        fh=sNk+33jG5CfYwRNnTdq7vMFlafwymiflFP87yEFzYn8=;
        b=o+wlcPSfL/yF/wEQdN0zWDOLZOUF7Jx/dzJksvjIrcq0PPCZ0+ZzUNegqmDpj4tljh
         zOUxlCPE32pwOLOuciQg19bWFwnylNFIoOYSjE2g3IocTKQQdCQj8aS9ivPu8rRdKYdp
         XErXGzg3ZmsEjFEoQZEgi4ZcuoBrvdvfedOssTusJlDzJRl5Z9PnziGyMi4SLUGcHURs
         KObIX9eCREVInQPPQklmDJAIcAE2GDfMjUVckxVWTMLIG/JqRTCkZp6uLKLHHtw8Tk3z
         +3bhIwfy1VgBAERPYNtjlEzlEk99pSw7RH5xUNmbJdsn3pbbLOEPotpaeEGeuVDNPwLY
         JhXQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794416439; x=1795021239;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=74FoFchhuSQQ2jSNjsBXa6BV1QiK2Fm+lk28fFAbdUE=;
        b=0eS7l5UEHhNSWU7rUum2AGvbtjNAP3Tlo2MwN2iDIgIycVKm90jnhXYNuMVspO41Kh
         y8HapoI+G5KKZTLahIElzyy0108JbKubX1JqCN/wNbuVU7l/KuNsD5FZbYt/PsQuebRV
         l26SFMt76VRH5YHQMFFr+PDzjscvvXeXMje6Wv+RTUcjLvcAfPyhgGzKB55Rgvd5a57i
         +TGYrsxn8Jj7rGCxOr4NKmXy8QAU5D1hc5KhoUHLeqDRzuUiP9RoI1Zm3BPJJgHSoBsP
         mTCDsjJlGuLrURvX4ty5T1iNa5lRYbe0Qn1k8Mj9s7fwhZfxDt6PjExxOAbfw8QP0L7c
         orTg==
X-Forwarded-Encrypted: i=1; AL+hErEmGGRPoG0skza7au40LntC+WgN/eVsJ0rtgjY0gghWHJhbg2Ebu003KF/T4nqjLq0E45vcZis=@lists.linux.dev
X-Gm-Message-State: APuU4Z/WzgmEAVrBlt6W7bel96Rhk+Phu6lrBvF3A1b7xo8GJDmrkTjh
	c71lnAI4LxU113/JO6BlJSJONuoJ8jHr3gbBla3B6u2tS2C7ktdMG8wL9/uUxP58P+vK0yuGLs2
	NMmLQSgCmlAEybjgFifRRQlybaygTwSIWDDExnj4EUJtWr/gLRBk+jKAhHvkam0wiOICXoAMmSh
	8rL/BLx9BoMuw6yVeCQWhXwP3kcN40XZE=
X-Gm-Gg: AYBFou2DmpMUoKTEczjKXvME/n3BDj2+76owQra8Mhi7BqMJppkNB/ol/17Um4WjiXh
	O7EPY54BlyxSrHpgjkXlbO7L4gLLlUdpDn2yXnA5YexqTCkNM3LaPoRkVnZu4xhefy/SCQgANJv
	1DFUAoWzjrPjcMRPCzWOFj/z6EohYe3F710ImL0KVTt2Kex35mlEutYVSmdDW2hPm8mc/ZNKdUd
	f9GUrTB4+q3LI8VaiINuYkoN+IIz0Qo
X-Received: by 2002:a05:6000:401e:b0:495:5c83:51bc with SMTP id ffacd0b85a97d-499c3b9ff3emr5473698f8f.5.1794416439115;
        Wed, 11 Nov 2026 09:00:39 -0800 (PST)
X-Received: by 2002:a05:6000:401e:b0:495:5c83:51bc with SMTP id
 ffacd0b85a97d-499c3b9ff3emr5473639f8f.5.1794416438735; Wed, 11 Nov 2026
 09:00:38 -0800 (PST)
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261111003111.3826942-1-toddfreed@meta.com> <179435738198.2168702.12439855185550580348@kernel.org>
In-Reply-To: <179435738198.2168702.12439855185550580348@kernel.org>
From: Todd Bert Freed <toddfreed@meta.com>
Date: Wed, 11 Nov 2026 09:00:26 -0800
X-Gm-Features: AclHuK8tjqwSs5WvfY5ngy_lWto0eQaig-gnzMnKLMUSIRvHhVTmNTSnDzSw4Ys
Message-ID: <CADh2yMyWd2JMajjp42yx-2JEa6NsMoX1JK+2qVaci9vths6WkA@mail.gmail.com>
Subject: Re: [PATCH nf-next 0/2] netfilter: don't send decrypted skbs in clear text
To: netdev-bot+sinfo@kernel.org
Cc: netfilter-devel@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Ido Schimmel <idosch@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Boris Pismenny <borisp@nvidia.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Zahka <daniel.zahka@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        coreteam@netfilter.org, bridge@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA2NyBTYWx0ZWRfX6a7bFPiBgOvp
 Q4qgAsL7RxomDZhmjDEBJv/Ww+++pcswGDTjP3ybqob+AmAxQBeNATNRlAjeVq9BLQxE71OrNhv
 HU1Z44iHW4HZLBEsB+QqL39811HEG5KnpFXJ8a7q5AghcibntCt2Fz9Wbt2UT7LyjJMnDp0fLD9
 oLfFy7mmyKwd7D1EF/ndNe7MAMNpCpJC5FCQA4iIPGPL8124iaV1ib9WJkacbptDxAWfEMFeu1g
 nr17dEIkeXvwApszMCmInbKv/7MU6I6wiBy7JHzcqhKmpFHCs1OzssmZQjzK2yRt3RlCNXMP519
 nyyEKbn6ynB+5uMv0E1A1kAaRER2/qlRu8n6D66i7KvqJxGMypEqzSBgNYFhTxWXo7n9dJ8IADc
 PJ8BhQ4fQAPQpU5hAaOjtmxs+4Kx9zWH2tpiYTPiFsBfDQRuvSVCZ3bNQu0/58lLsW2MLb/7qw2
 hc2Ip3rdRO4EANR5unQ==
X-Proofpoint-GUID: tQdDkH2uzQKdsd3fHR3g4QqFcMNftBhV
X-Authority-Analysis: v=2.4 cv=TtlzFzXh c=1 sm=1 tr=0 ts=6af49f38 cx=c_pps
 a=pX1sPZUoWPGeQgUnKQNIgA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_78whYxrdx1mplLwxq1U:22
 a=v81qpcjm-LW16Aac8AIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: tQdDkH2uzQKdsd3fHR3g4QqFcMNftBhV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA2NyBTYWx0ZWRfX/7v3qbZ1MOqu
 clIUKci5vKttQ1OqlS0c92wHjhTSFoKouq0SEdmZXeUEZIVp8yFi7dqXVpOY8XfISPZfqPOuB2u
 m7lbdytDMKDjxjHYywGQ/yYYFNQijpo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01

>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

Hit during development on crypto offloads on the net series that I
linked to.

-Todd
