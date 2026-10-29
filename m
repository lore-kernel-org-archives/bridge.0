Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793263941;
	b=2maZOxLlcETF16HtStZVZCTtOqbLY/XKehk2m1ag17Z57yKmh4jiEQEI5Zq51nmybnEN
	 pkHnxwatBbsZpHIGEP7Ixk72MO/1szfZSTS6z9uTj57Pbl/8taINREDMzpTx58zVlmisg
	 ptwESDazeqjOILNYRC6rii7/sNPeaAApjixg0fL/ddzaevSt5/lXaUFJb1uc27OYswBfk
	 8Lp7Moc4x05D0BNH/KaEsRpJoDe7L3XcHzfgUCuoLHLK1aHkUeqWZQ6Jopie+7wppCIxO
	 M+wboFK3xQt+VA7P5ahvqD3+1TfxCD/y77Ng26kCg95huz5+0bJAYXTBIu/cTKvcAag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793263941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Gv8+m+QgPF+dHnlKjkvyxWOczusyoFg1Sgu0wSqQt2Y=;
	b=CFdjMF3in7y9wG1vM9JJjraBex65ccOMyE9xx0BZDJ8jCSuYt9fial1rrZ/6ihye5gyF
	 vBQnUpCXlxnwCKtoqxhVbZ8uxA5jvcrqP7uKv0aLoOdPVUQf8e7bQJx3jD9SZNPQeu1Bz
	 iuosPv2qTTWbNSvOBm0MlvYDhsVOJMONcX4trD8OkN3lxguhE8PhVT5gWzoQe7Mi5rlJL
	 bVFY56CUfz4sP/NKxWiV0tbi/rmpxuUrHB/gESaYB8Qkla2Dleo2A2JdrU7VrqSK2mvV2
	 sI8AqRrmBB9LbFen0DJ7zWysyB96LtFgD2E20/OG3Gdln1Bap+IAP0pK6tLTueroT2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=TY0E3nuY;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2C4606A31E
	for <bridge@lists.linux.dev>; Thu, 29 Oct 2026 08:52:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB2C4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=TY0E3nuY
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48e00eee27dso1355602f8f.0
        for <bridge@lists.linux.dev>; Thu, 29 Oct 2026 01:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1793263939; x=1793868739; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gv8+m+QgPF+dHnlKjkvyxWOczusyoFg1Sgu0wSqQt2Y=;
        b=TY0E3nuYq1825FhPD7y5fOMGESjEWJsa2RXClzUNzCHaSy0u1FNPVC/ySaYqkcOd8E
         kRFmPCIAIpyFrVJA5M+/EevRlMvV8U/KYIgoKdUK/ra6IUmEqqQvj8nbm6pD8OX5h3Jc
         zklhZeAzwY0lhhF1/UNwtJf4nQNrcwPh5M3qWd25gJTn2SvjXkqcdPAeOBSVgsyclPLw
         64TibnVHmdl53nYe+pZxB3LU2djmQm/d7u2MK+9Amp6h5TN/zbQWQnzKdOz55hLDmMxQ
         J0NFXsmKxf25MT9C4udy+WdUaeFumisHoIOX9Rh0h4rnY2+ydi7XWOoggdeTL8+WoMqN
         FrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793263939; x=1793868739;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gv8+m+QgPF+dHnlKjkvyxWOczusyoFg1Sgu0wSqQt2Y=;
        b=zogdhDtdRxv3LEs77rQHAeG9aoA0PS6a0FACCkWxVBwZq2Bc1vbKC0co8QPZTA/sUX
         sOFevQzMcv2Yna3m4SB7Y7934KoOOKegbavyEHzD1trwMD4RlbcczXoYKfRkvsfGvcsz
         zzEVE2+BXPMM1aYrcWNwpwPwFsKqQu3H+mDDsgb9t8N2WwKoN+pyl3qKybxUbZh/3eVp
         sSuX2GIlM/86/s8Y/fpuwIONc+Dn/DwnnnVG48Fp3GeKI/Smlet5bRSq3OvsvrbSJqrA
         xsZULbE9VdspM3ixKiZk+L4LKUaWuLUU3zC5dvHFbxKIEy6bhft1WOPHypi6pUqnIiOK
         XsNQ==
X-Forwarded-Encrypted: i=1; AKwUvBwiQmii644bkEs3hIHrx9FvWkWxZX6d88aMVJBiE6wWsj7hqo2mzlDrirR5hWcOFHo2BnNIqu8=@lists.linux.dev
X-Gm-Message-State: AFq9FYLNU2n/oHOKrViAOAoUG1sfzQUoal2CwoQ2haJedcd+gP1VVS+t
	/zLZhH1p9a3vHjFNy575B/oAyGnuQgU7CTN6B3SFFEjt9FiBogGtZiIakf1GuzQGT3Q=
X-Gm-Gg: AYBFou11x9/inRGEOuh3F4OQRJzN+s4CJQRN5zImtc6F+O9eTRmg+d2OpL2l5b377gS
	CzqeP236oEsBtiocKP/vuFPtWEwNDeALVrzxATgbLEGKhj05/MLwI+F7D6gbfx/1FhzosihsFr8
	+YOM4o0xI+/zRYBIdAJ13UdUHmFPKq0ixmwUvSqB6vnE6IgfYVohI+DYB6JlVVWm9yzab36+aB1
	t2Y8AtEv3G8Xzq+hrOxoHQnlPqxgUB31Np+EZilmAg070arg3XqlK2I6L+qgvVuQY9I1cMNobjX
	kxU/O5AqvZw415G9KGjZULxrCoFaXlCGFc+s4NTnix4LDcXz5cZKOl8C702Z0C+lM7OXMGEhdDY
	tgF/0sk28MAQhWN17DFDYlhyU/jQaO24wv1E0a+AUuozAC2IyhKXuNOIfzCgCkQUQvodElyJN++
	N/VIHGae8YpJKgsA6PPx2nZeGp8MUTPk+HRLh5/G1S2wZ31qowiIZQbOozCihAkaj0qVmbi8h3e
	8V0Cs0atCtzVPmycyWe/ggMweIMJvRDdPPMeEjdmewS0KJ0iwF5C06flWpUE7a0fBuOr4cu/o4T
	rbAXhB84ziR6wzbqlGyGSdVUKNVpagARQj2XAoVa785DxECWJKajbCzee7Y=
X-Received: by 2002:a05:6000:616:b0:48e:5c60:6a3b with SMTP id ffacd0b85a97d-48e5d5dfd9emr11686469f8f.46.1793263938677;
        Thu, 29 Oct 2026 01:52:18 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb8f387sm32992051f8f.4.2026.10.29.01.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 01:52:17 -0700 (PDT)
Message-ID: <12c35123-2c08-4d3a-b08f-c646b1a7b982@blackwall.org>
Date: Thu, 29 Oct 2026 10:52:15 +0200
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/2] bridge: cfm: correct CC receive monitoring
 transitions
Content-Language: en-US, bg
To: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
Cc: Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261028164730.253238-1-pocj8ur4in@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20261028164730.253238-1-pocj8ur4in@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/10/2026 18:47, Baek Kyu, Kim wrote:
> Two CC transition bugs affect CFM receive monitoring. When CC is
> re-enabled with a new interval, the first RX check uses the previous
> interval. After CC is disabled, a received CCM can still change peer
> status even when its RX work cannot be queued.
> 
> Patch 1 stores the new CC configuration before enabling peer RX work.
> Patch 2 keeps RX work disabled while CC is off and skips CCM status
> processing during that time.
> 
> The v1 submission covered the RX work restart. This revision also
> addresses the two review findings. The interval fix is a separate
> patch because it has a distinct failure condition.
> 
> The combined series passed 8 CC interval/transition checks and 3 CCM
> status checks under ARM64 QEMU/KVM with bridge/veth. The CCM status
> test failed 2 of its 3 checks on the v1 image as expected.
> 
> Baek Kyu, Kim (2):
>    bridge: cfm: Store the new CC configuration before enabling peers
>    bridge: cfm: ignore CCM while CC is disabled
> 
>   net/bridge/br_cfm.c | 22 ++++++++++++++++------
>   1 file changed, 16 insertions(+), 6 deletions(-)
> 
> ---
> v1: https://lkml.iu.edu/2610.3/01364.html
> v2:
>    - Add the CC enable interval fix as patch 1/2.
>    - Skip CCM status updates while CC is disabled in patch 2/2.
>    - Retain the RX work disable/enable fix from v1 in patch 2/2.
> 

Hi,
Are you actually using CFM anywhere in production? We have been discussing
deprecating cfm and mrp in the bridge as noone seems interested and they have
proven as sources of bugs over time. These don't seem like critical fixes
so I would target net-next when it opens up.

Cheers,
  Nik

