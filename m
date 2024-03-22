Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D765146420
	for <bridge@lists.linux-foundation.org>; Fri, 22 Mar 2024 12:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711112311; cv=none; b=eAxTtGgC7nNLUxjSfrwhXq+H3OrV9MqsXqSmjih3GB2RCTOW/+3ZquG4wE2OPePFbzYXFKFMKc2RqPrFKnBde8FYVgUu+nREhS/0PLrrui3wI6CmvWUv7eQNt1BzftCLW0r+a/HvhObwroK5UBAH/n6bzdbRIfNIlX/gcfaphfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711112311; c=relaxed/simple;
	bh=qdq2a6bQB4zLF5y7rJfn6/zbx1ScX1p7uoT1aN+8DbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G5B7Nxe/D1nqbTsQWyw/B/9XAvAFQENhd+M80wnYxO/2j8pkl5ad3yVyOGPm1mS5EI5OgBhC9RSVhB2s/DdaUr8EUPFS4UsjeBiRjHv/4ICSQ6lvJNa8Tspzl/atkzXX9w5iLXc37mvoS1PBrjSAuRbnxFu77d1Ej5eWU382ZYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=s6qZQRpr; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="s6qZQRpr"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6A33E4043F
	for <bridge@lists.linux-foundation.org>; Fri, 22 Mar 2024 12:58:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DREiPJhiTKJB for <bridge@lists.linux-foundation.org>;
	Fri, 22 Mar 2024 12:58:28 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com; envelope-from=razor@blackwall.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 710BF40439
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=blackwall.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 710BF40439
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=s6qZQRpr
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 710BF40439
	for <bridge@lists.linux-foundation.org>; Fri, 22 Mar 2024 12:58:28 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a47062136c0so261731466b.2
        for <bridge@lists.linux-foundation.org>; Fri, 22 Mar 2024 05:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1711112306; x=1711717106; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8LUGwsxLnMUWkae2CSge+OitZs3lt/HylfNAJOAD4fw=;
        b=s6qZQRprELyk5xO4WLv05q58MnHSZlvfeyZmHARxuC2g6gqETLRKHJSejZGdPTuh4q
         z8Aq/Utl3UVw4Jr6RL+tUXEN5dsLf/NNJfz0GJ1cgyjqdNKKghEQV7WgcqwJcXcJFb3+
         OdJXrAQs2hsVeXDOsPTomoL1xBKB/9I3ZlJtu2pZ13TrTnNqCviMCT0TCwy5/mzNa6Ki
         QQAnRRMSl1a/0O3+6vRP2r9k4VQxhFcen8+ThjxF5uYHg2RT5qHJWUhU/nj7HzgJCo1u
         E7WSM8HY1INrTCc4h26IVze/8yQP2LEF/8lElX+us5pAJHaSgk34eLBfXyvYBcyzq8JB
         NAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711112306; x=1711717106;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8LUGwsxLnMUWkae2CSge+OitZs3lt/HylfNAJOAD4fw=;
        b=hsqOayWkQoxrLBEw9a/AtmBHsMD8ERufdIZoKepAF9TiZOtsGOoniTyiICuyakDhk3
         BCqeCmNOlv1j97BRtkk3zU760sFMLIckIYH2P53ONnn3VCgikvl5866d6OxWDIim+rlE
         rl3V/Xis20+TQ2YWKCvBhabtVveneQq2VI1TnvhUyKr8FTqgr1fFLVu/ydSeG1yxyUi5
         cwvu4nzW6KsnsNqTOL0cLWW8iCZjDm67rMJeA9EYJBIXLwUqevR4DQCMv6XYzCnYRaFU
         F6okv3uyrbovW7Urhjc87WaSbe2Usd5oSo7NJVcK6EHOBwXRzHKUuA7TaN5OiyPhZwaX
         EXOA==
X-Forwarded-Encrypted: i=1; AJvYcCWcFk0ebMge7n4ZJuxDbT5wtcnibifFLWqwCH2v3aaRPsEdkHi6l8jk9vxA7xJI5P4r/pN2zAo6Y6OTmCk5SwkzoOpOU6ngPHjMa3jOIJJWKQQ=
X-Gm-Message-State: AOJu0YxGh62ExMh3St91CnOPUDgkSJ9hfaXhj6zdtS0wkKWouVAce9CG
	2rxw2S2TN06wMsoobZ3H4pX5DSgsvLFF0vreSRrFMZ26qrDFmUzgbbTTjUbJLRY=
X-Google-Smtp-Source: AGHT+IFnlm+CULBYCrQvbVt0F/cdsUUhs/GbNE4xpUZg9du+9T7Z6vJNQjzykH1gIhhv//3ZXzIDwQ==
X-Received: by 2002:a17:906:340c:b0:a47:1d03:f37a with SMTP id c12-20020a170906340c00b00a471d03f37amr1785429ejb.47.1711112306339;
        Fri, 22 Mar 2024 05:58:26 -0700 (PDT)
Received: from [192.168.0.106] (176.111.182.227.kyiv.volia.net. [176.111.182.227])
        by smtp.gmail.com with ESMTPSA id e9-20020a170906c00900b00a4737dbff13sm229585ejz.3.2024.03.22.05.58.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 05:58:25 -0700 (PDT)
Message-ID: <95e8aab3-88cd-4120-a246-fd3589ff59ba@blackwall.org>
Date: Fri, 22 Mar 2024 14:58:25 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v2 0/2] bridge: vlan: add compressvlans
 manpage
Content-Language: en-US
To: Date Huang <tjjh89017@hotmail.com>, roopa@nvidia.com, jiri@resnulli.us
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
References: <MAZP287MB05039AA2ECF8022DD501D4BCE4312@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <MAZP287MB05039AA2ECF8022DD501D4BCE4312@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/22/24 14:39, Date Huang wrote:
> Hi maintainers
> 
> I followed Nikolay and Jiri's comment and updated the patch to v2.
> Please check it.
> 

Your cover letter should contain an overview of what the set is doing.

> Date Huang (2):
>    bridge: vlan: fix compressvlans usage
>    bridge: vlan: add compressvlans manpage
> 
>   bridge/bridge.c   | 2 +-
>   man/man8/bridge.8 | 6 ++++++
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 

Generally it is good to give people time to review and wait at least
24 hours before reposting another version. Also please write the
changes between versions, something like:

v3: ...
v2: split the patch into two separate patches
     changed the option in patch 01
     changed the man page description in patch 02

Keep the history from previous postings. Also you can note what changed
in each individual patch for the version under the first ---, for 
example for patch 02:
---
v2: changed the man page description

Cheers,
  Nik

