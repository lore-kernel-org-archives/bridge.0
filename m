Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533C73093CD
	for <bridge@lists.linux.dev>; Tue, 28 Oct 2025 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761651798; cv=none; b=cQpfrSsEygVabLnYzVosu6P4KXtvMFYMD1NF4VHKctDy67VBUroOmAOonjM1q4nUnS0oIOrYgP8fLSsZArjNkXEbc+jyy02CDbbrqJ+e+peFWAjXAFLN7touqp0BagyX4l/plOpRx0insoQKuzgYaanyxsrMCijl938m0KcBiVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761651798; c=relaxed/simple;
	bh=yGVq8gF2tUQexob86KGNBoc3W0yZw6td9K+Fy7ylHo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dGARqr86USPU8dSFVzJ7FjH4e7JhiewPa9hepNIOlSWqj5UP/hyRYU7Oen1oI7aUHn5Abg2RLeeaOpQ3JYwe2TvnO3Pj3F8OiuoaC3wfOea5H1Slt5mFwh7H8RgOl1d4tjNITIRafilWaDp0soTuoA+CdtPhZbKSLKIHI0ap/RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEcsztLR; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEcsztLR"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b6d345d7ff7so70889766b.1
        for <bridge@lists.linux.dev>; Tue, 28 Oct 2025 04:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761651794; x=1762256594; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bnZs2RMUETbMZcfBovNxnautSVDoIsvh/Vcc2VRjKM0=;
        b=bEcsztLR2e8qKeG7pV+gp2ThbMn8AlLXVYs3HMTf6pOYedk5TyEEtBd8qBG8lwofUL
         29gEv8tIRtLAwITAxXmoP7nD8uZaf02RVLgh0X/l5Bc5nqfTwTrwnvYMZ4OPPY54nHFZ
         AEI4J/3nSeyRYqsWdoYk+eUY4gB4UlI0HmWEBIJuaWvQpnJMoFRVMHvuskwrjYcXCuPS
         iBoEEIxkWHBsBvBMtAuY+iz1NE/S3qH1JHJU1GeniJnz++5LeTVnpm9fVN679Q7id0gk
         /dP5w9oksKou0NltAfeeT7BIP1BFXb17gRJ9dm+0tjMr71v1bxWpYv1PAcOSOrN3hMPa
         sJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761651794; x=1762256594;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bnZs2RMUETbMZcfBovNxnautSVDoIsvh/Vcc2VRjKM0=;
        b=jzl7BzvCF3Zw8jnYLsIKbG2Br2KqNhsAgM9jArjXXPkbhSKx4P4sFm6R6ks/lw801q
         USyG2FGEd4sfJlbONOoENpUl//mcbXzt+Y0zPV1HynSxCSgKoAoVbO7rymnGmH6LXiQd
         h8OvSxytegpjK6wvnvstfke7CWavLZqcfQ8HdMAwRNjXSeqGKkF8lP6oMlxt0gmPHqD8
         FjCa4eOA36abAmRDXMaxNgvLQQatZLKGteKGZ0GnfxGq/ODG7KJA+9oVWyMZLAPef2b2
         m+GHBKinJLlZreG8YJ72XrQygiL3H1bzYArspKoKQhqNhQZMNUXO52px9As+Bp5wB62S
         sP6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBNLOwHZXMau20gFI+n95jRwS9EDaB5OdtQFNW4JKTTeYOXF0URrDYc2EaKFUuQfxhwc8VzuU=@lists.linux.dev
X-Gm-Message-State: AOJu0YxzxdrnLmAbb7rgUG1y6VTvuimSFDqI3HoG3Bu8BtG/MeXGQa6z
	ZMPfpjIp1/BzlNR8Bm8P0UiMfQ7fDkaHWo5JGIkmdWfnWmA9o91Tsqlp
X-Gm-Gg: ASbGncvFfzRUAzPq7E6vcfN4bfxvBeK3K+Fn1UwdzKXLUHbaFmcAqZjAcoKqFAyuP3U
	41n4zsbdGud181r9i/BrXrd5bktx3H4iDq+uLKyoTa10ZOSNwtag+qbuUb+QHOnFQqtq5T+Xt/p
	EtJl4GdFR62Uo2xTakk5NXOxv59j4ZZYFkYoRbFqJzksiaMmhxxcU8nWuUXVQ2dQYOMT6PHAZnD
	pxWvU1XB03JpZru0EIqlnXlJYEDlK6bLVKBfZ6/OKiYQS4LzkuFHoeg6rrkoAf6aBvlhC1eTBa8
	ZK8geGa+pkacrY2xrhlp8T/O0JGByZBQU+nflz/5/Zv3ETqpyfu8plfSsTaIWa19Qc3LImiKS7M
	fnpszMVuD6qRnMP5LKV1XC6KuXxmRj9ceCy0v3/qG3CqygZMNcRd9uU1af+h07ZlZlleekx26uV
	h2hl7UKO6ekBiNX8obn7xqBR47hyLoIMEvrJCi/IW8GgdMfG4VYNUrkDJ6FUyY0HnmvxXd516sN
	/63MOXDDG56gY/7P81GgECPWknyxxhz1TUAMbHO1qGR/Z5kWEEOgQ==
X-Google-Smtp-Source: AGHT+IF3bVuUSQU+alNARg7/R6qmJGQ06NbQbI0VrYE7H37TwU5eAm2jU1tQRdun4pLRt3QQNki5aQ==
X-Received: by 2002:a17:907:958f:b0:b6d:f416:2f3 with SMTP id a640c23a62f3a-b6df416071fmr70842766b.19.1761651794317;
        Tue, 28 Oct 2025 04:43:14 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8548ed8fsm1084055466b.73.2025.10.28.04.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 04:43:13 -0700 (PDT)
Message-ID: <a4a3dce4-0f2c-4153-abbe-81e5d2715bbe@gmail.com>
Date: Tue, 28 Oct 2025 12:43:12 +0100
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 nf-next 3/3] netfilter: nft_chain_filter: Add bridge
 double vlan and pppoe
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>, netfilter-devel@vger.kernel.org,
 netdev@vger.kernel.org, bridge@lists.linux.dev
References: <20250925183043.114660-1-ericwouds@gmail.com>
 <20250925183043.114660-4-ericwouds@gmail.com> <aN425i3sBuYiC5D5@strlen.de>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <aN425i3sBuYiC5D5@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/2/25 10:25 AM, Florian Westphal wrote:
> Eric Woudstra <ericwouds@gmail.com> wrote:
>> This adds the capability to evaluate 802.1ad, QinQ, PPPoE and PPPoE-in-Q
>> packets in the bridge filter chain.
> 
> Same comment as previous patch, this needs to explain the why, not the what.
> 
> nft_do_chain_bridge() passes all packets to the interpreter, so the
> above statement is not correct either, you can already filter on all of
> these packet types.  This exposes NFT_PKTINFO_L4PROTO etc, which is
> different than what this commit message says.

So I have corrected the commit messages now, but:

> I also vaguely remember I commented that this changes (breaks?) existing
> behaviour for a rule like "tcp dport 22 accept" which may now match e.g.
> a PPPoE packet.
> 
> Pablo, whats your take on this?  Do we need a new NFPROTO_BRIDGE
> expression that can munge (populate) nft_pktinfo with the l4 data?
> 
> That would move this off to user policy (config) land.
> 
> (or extend nft_meta_bridge, doesn't absolutely require a brand new expression).
> 
Did you get any answer on this somewhere? I think that answer may affect
this commit, so I'll wait before sending the next version for now.

