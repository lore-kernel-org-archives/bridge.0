Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119E213C675
	for <bridge@lists.linux.dev>; Mon, 15 Jul 2024 08:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721030671; cv=none; b=lqZ5mYBpcR1Lx+F6SpbMDsGRBcwMoPN8PbJi7TG/r0UVkL+a5CmY+drw8TsBoVXkMGVsXbeU/pAbr+ARwNLZuSjFJkdKEUpy9YwuHZ0+oXDrZz5Aizlge/B3n7oKnprDpvgTUqtRR8i/eiN/p2mrNS4NjLFGoL+xy1sVZpvvGAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721030671; c=relaxed/simple;
	bh=pfgmG4zZrrqRhVkanoP0xDLU9g9d+TR1rmNzguVilz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ByC8mWRIyL1GdcfbjBatczH8Imi6dOOmKHyheD0hT7GwK1WaMKwhaex+M+cuOKyS2BzqJS6W2FHoi/7hBIC4RU7w/heWG8/JoW/SpWUqBot/IdJRFC3AIlDH28CRjS74ixWQ44Up/XvdRnWnAcDE3GWLY9ImaYzS8lqk3eMlXQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=P23ZozZs; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="P23ZozZs"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-58b0dddab8cso6249637a12.0
        for <bridge@lists.linux.dev>; Mon, 15 Jul 2024 01:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1721030668; x=1721635468; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YiwcX9F4LtfC80GM31isd5gHfQz+XWLWe2fZmeMxBV0=;
        b=P23ZozZso7kcCpJC7afZew90XJvF93OPPFXIYMmMacMyqg8VJlvl/0q8Ad7Xb8vGZG
         r8Hhy8QJjbrkyPFF29eJnW9kzhNJajOVNGGiticYQPAwLVDoH+2DU2QKg1sZEq7G+4Ze
         NC4tenX/U/kkjvxles4Batc1v+lYtrrkhIsbq11XM6Udk9iJx9S80xomj1pX7eRQTto6
         1Ashnt+VR4q5OPovYifcrL6KKHEkOF1PpRr8f20zeRtK+HG2OAgET1hoeIZBKju6ubv7
         8ldFaNFTqnfQILnBLl0Elh+CNjBW+nwJB2ajqsLjPB1mQI8diByy5nz2vj0eKKeGW1o8
         EiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721030668; x=1721635468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YiwcX9F4LtfC80GM31isd5gHfQz+XWLWe2fZmeMxBV0=;
        b=PptHfKiaTVYW6Q1mMNxI96sULCIuFhbyNpUH9iLjMHLcy+4KSK06ENwbTmZ/nlun4O
         teaT1nhB3iSuZkJC9BFXRUndZ/7fMpedmd091yv7isvxE5e37NGwZQtD+MBygAE65Im/
         Yziv6byou0LBmiZCZesxXEpvna0jjdR/qn6pyuh3rreltWNoOOGEwlNJ5bqQdbs4OYMN
         RocoW24QijTZ62cnmnYozo1lErOjZLHjQtMpYSPiFO2Tv805DK5z9JYIx/t6WftEEHsx
         JjrDCvFnqGHinBFlVcirABIWlOWL77H22hal1pFAoUV+PHJqqZTuS7V3laTPOqkqKNlD
         l0Aw==
X-Gm-Message-State: AOJu0YwEZah9SKIuhOr0VxjREdCtkG0c5/nRgm+5CAEDOGFdxa/XNjmK
	7Qk7fvniJBbgL0KvLt+e0+EaUEi8R18v0PcJnoy0L0xdvV5dyqDpj7IavUMe4rU=
X-Google-Smtp-Source: AGHT+IGfLMp93Lvm4ZRrsDZSB1JnFiH19NTLePtvoM//z2ksSs/I+r4ZV/EUEPuFeQJ8h0publy2Mw==
X-Received: by 2002:a05:6402:350b:b0:58f:ebaa:64bf with SMTP id 4fb4d7f45d1cf-594ba9975bamr13862271a12.2.1721030668208;
        Mon, 15 Jul 2024 01:04:28 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b26f621c3sm3070229a12.89.2024.07.15.01.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 01:04:27 -0700 (PDT)
Message-ID: <7476d4f9-3a45-4586-99c5-9e878d4e02ac@blackwall.org>
Date: Mon, 15 Jul 2024 11:04:26 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: bridge: remove unnecessary cast from netdev_priv()
To: Chen Ni <nichen@iscas.ac.cn>, roopa@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240715024457.3743560-1-nichen@iscas.ac.cn>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240715024457.3743560-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/07/2024 05:44, Chen Ni wrote:
> Remove unnecessary cast of void * returned by netdev_priv().
> 
> Fixes: 928990631327 ("net: bridge: add notifications for the bridge dev on vlan change")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  net/bridge/br_netlink.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
This is not a fix, the code isn't broken and it doesn't violate
anything.

Nacked-by: Nikolay Aleksandrov <razor@blackwall.org>

