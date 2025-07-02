Received: from mail-yb1-f195.google.com (mail-yb1-f195.google.com [209.85.219.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CA430AAD2
	for <bridge@lists.linux.dev>; Wed,  2 Jul 2025 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751468318; cv=none; b=Utz2TWj5se2NmIQqUmmbMxGiN4exzJSDdddAMHhmaPwSoenJdjcx7w9BNQHRxRBdD70Kex8aKTG3kqZ3eiDRPhjcB2u7C3yn4KNQf0D128AJzlHniJqPEScShzXfmjtDRo7eUaVojzgNSFSbJp4Llc9hGn5AAa/x/szIkF+ZFxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751468318; c=relaxed/simple;
	bh=oX/ZAtWzwJdsQhtNvalvhpcwa8JeOFlisMtV8cvuNIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J3KSujmNWkbU6uUda6vCdZ2ewoeYTwNTbXuXGLAH5CoGHo1CnEV9OLBltL7jLx7xl4QaurjwWZ5e/UwLIX6omEJhZe80WB8PWyCI2/plU9pNZzHk4J2QvlOmi7uYoqKciHfaeygHwHT/FeJkEgXMDXuufJDbHldr/ydsdSzPDMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUJvRktQ; arc=none smtp.client-ip=209.85.219.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUJvRktQ"
Received: by mail-yb1-f195.google.com with SMTP id 3f1490d57ef6-e8600c87293so5232751276.1
        for <bridge@lists.linux.dev>; Wed, 02 Jul 2025 07:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751468314; x=1752073114; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T1WkFzcqoZ9zfZk6rKFoEV4a3LB4LFCO7cfh2fSf18M=;
        b=WUJvRktQK3WAZruRf8utJfR8fYUOho56r3BdXJP7zn9+UE9AtaZm8c0lC+ey7pnm5i
         rMYggZief1kLYqZIsAR5fJTn0j9kU53Qca+qUWXIsYPiV1zqnc7cVUhMLge8or07zTud
         44h92ZCAYYPij4zz1+c6lTr7cdc4qPSnevCzX3Mp5W4RY+Cr26Kre4qPt+YdwHm2Pxtl
         cek0t5GfhAwmda8k86fG4+7o8UH6dblS9E+hkPsFxRQ/UGRkY7QmgrP3K9wv+0kgULGZ
         osQFVnC1ihpv1YdN6NJPUyX6la7oQ6tU2nLS+avC/YInARlatBpeQ7LZ/8e69KIsNmK/
         z52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751468314; x=1752073114;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T1WkFzcqoZ9zfZk6rKFoEV4a3LB4LFCO7cfh2fSf18M=;
        b=Ea0auE0u2eb0G7i7Ltb9+BEnO23n9DbWrGeSnMZn2lMfeduGsuiYju/O9XSZ+HF5MV
         A/yzP7FpqI02QITCSYaV7joUoN0Ip8WgcjCAs/8jVRCn8NBktNkBdHH+8b1qH/Pa68ZC
         ZT4YP6nqa6xXWC559iuAuCGGftMelHDefkFLF2j3u1XJk7+htozpE7E0UrdCPduXNUIp
         YVIxqp3EepxgvozvcvX3MxdYFvXyov/eZ2HMWWxQ7L4bMfBe7qHE7NX2CMrsjomVlDqu
         FZMQ7qvR8U37GIss+nstjkUa54VDokNC/RU2As2M1tK009dqCxR5ghcohTNfJmriTTLA
         +Ovg==
X-Forwarded-Encrypted: i=1; AJvYcCWFSpEXnf5gtsK2sCpAOyt6d+yiHHBm1AgIvlOoOGCt9flJ5DLkNpxX8uzKZLNGaDJU3uwRmHo=@lists.linux.dev
X-Gm-Message-State: AOJu0YwIrVL32zlyOG2d0q2BHUhSCtGLZwVHaFIwbcMKkQDFylUiL91A
	sK+eX8M5rVPhEu7VV/OkNqzCCNApX7UCGu0iCwAZg9uQ5lT0LSk9IU5/
X-Gm-Gg: ASbGncvyHaxTnBWAEfptDYxspJUAGGFiEyzXQyFU2drpz7TzM4PeTMr41OHRe9cSBaq
	sCFoMrcRNnKVX+NICvPRZzPrvJnjO1RW6QCYouj5qVdF9P2pWbxTN3+iF7zjcvecn4ozNGczB0c
	JbFp5z4c+q4g1DkH3UFaZ0qYgpZZiE3IKz1yV1L6wuwHfYXZiXc8myGAy2fgmT7uTkVTZ2VsN7t
	Tt7qO7pI5+bK8JIzTwVDWTFS8WRVgLQuym8Vko1ATA2ffjyAFYeVmEJeElwKS7mNwcI89m3VyM3
	Q2GF3vBLq1Mo8Sw6RdJLHCltdYzFDeVyi5uy+FHCz+jKmkA6e/FOac+adWUNpEigcKa//h0JGuD
	3mFFzYatR
X-Google-Smtp-Source: AGHT+IGlSboF2WeQ17XUS4xFc2PW/wJIU1k/DVuD4yqPbLcGVoiUFPieioZSCcoMk0Qg2yQY9vZcjg==
X-Received: by 2002:a05:6902:728:b0:e89:8cc2:8082 with SMTP id 3f1490d57ef6-e898cc2856cmr885356276.41.1751468314365;
        Wed, 02 Jul 2025 07:58:34 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8980a99c80sm480883276.56.2025.07.02.07.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 07:58:34 -0700 (PDT)
Message-ID: <9c43747a-f73d-476d-a1dc-1646fcfb771f@gmail.com>
Date: Wed, 2 Jul 2025 10:58:33 -0400
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: Do not offload IGMP/MLD messages
To: Tobias Waldekranz <tobias@waldekranz.com>,
 Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, bridge@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250701193639.836027-1-Joseph.Huang@garmin.com>
 <87a55nyofq.fsf@waldekranz.com>
Content-Language: en-US
From: Joseph Huang <joseph.huang.2024@gmail.com>
In-Reply-To: <87a55nyofq.fsf@waldekranz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/2025 4:41 AM, Tobias Waldekranz wrote:
> On tis, jul 01, 2025 at 15:36, Joseph Huang <Joseph.Huang@garmin.com> wrote:
>> Do not offload IGMP/MLD messages as it could lead to IGMP/MLD Reports
>> being unintentionally flooded to Hosts. Instead, let the bridge decide
>> where to send these IGMP/MLD messages.
> 
> Hi Joseph,
> 
> Do I understand the situation correctly that this is the case where the
> local host is sending out reports in response to a remote querier?
> 
>          mcast-listener-process (IP_ADD_MEMBERSHIP)
>             \
>             br0
>            /   \
>         swp1   swp2
>           |     |
>     QUERIER     SOME-OTHER-HOST
> 
> So in the above setup, br0 will want to br_forward() reports for
> mcast-listener-process's group(s) via swp1 to QUERIER; but since the
> source hwdom is 0, the report is eligible for tx offloading, and is
> flooded by hardware to both swp1 and swp2, reaching SOME-OTHER-HOST as
> well?

That's exactly what's happening with my setup.

Also, IIRC, the querier port (a.k.a. mrouter port) is not offloaded to 
the switch (at least not for DSA switches). So depending on the 
multicast_flood setting on the (querier) port, the Reports may not even 
reach the querier if they are tx offloaded.

Thanks,
Joseph
