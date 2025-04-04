Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AAA19CCEA
	for <bridge@lists.linux.dev>; Fri,  4 Apr 2025 10:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743762615; cv=none; b=dCO+ilk3djzRD/I7UNZZJr9Ujfh07m2hKmn0KqoFykc0PaihMDbazk0N0EphaHyKv1d145tD3BsRSvD3KJpw+G0JWBEU6VgFhhIQd+23jjIl3zZ9Xa5ws5zxDXY2ZpOLgGryVDgZf0jihFMdM8JhLhtP4wjRY9OzZbKB/cVVQ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743762615; c=relaxed/simple;
	bh=Jnm3SNeDPY10Q0mQMbLx+uVmDQAAO8BKaaZ3pKCNKOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VMge0LwuOOCiSHdc9scZL6DdE2o4QoGQbP182e6mdh42JH8Z5O6uQVBDikJ53ikeD0EfBj2tNu/W/7uEWcW6Soga0+44AozHMb79/QDB/w0Cgg3m46Cr3hbKPQagEo7ac6HTd6z16Ygyq+Lsl/LdMtEuTpixuV9LamFhYIlWyrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=H1S17FE2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="H1S17FE2"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43ed8d32a95so1864025e9.3
        for <bridge@lists.linux.dev>; Fri, 04 Apr 2025 03:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1743762612; x=1744367412; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CMK7AiVAmQ13rPWb5TPToJIdxeUpbsGyWlsCzKZ+U4M=;
        b=H1S17FE2a0wOc1ecoyU4hRFyPhPa5p/MonQUiFYwcSpld6SjGlcC6EyUXqbtG8np8y
         RirRB5C8RAQ5jEz3qqMjfSxuAEC/iX8Hv4IVFZFqCO4KE7rSpoiu+EO2zXRsCSR63erW
         vUOYCWnpZHhidwjkdBRE4BnnooJxUnoUfr0EmQWUCnvqiuZMjQ8n7jPRNH+xjku5AJNA
         1FqdtOitOBRTLW8flLLQs2P+UJawarsivm68zCQY6oKs7mBy4pDap6k9DQchFjofOb3c
         GpPfvWhsDYCZMA2PlG7G3q9eD14zbQv/U+Iiu5shLvpxgaV3RvuPNOLni0++V9c1guOj
         DPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743762612; x=1744367412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CMK7AiVAmQ13rPWb5TPToJIdxeUpbsGyWlsCzKZ+U4M=;
        b=B1e9LR9U4oyM91sPS5puIZ0A2OpKqhQ4Ii8DcYng3zORK7H7o6Y8I8L8SMEvikgJ1S
         Mx3XLhJYpw6JzWm6XZJ/IE5ncm+W1a3voEU4nWRqj7C6T+qf6fTzTN0WnnJwPRjiLbGA
         /pLpDdP8kwtHbXF8XuZy3f5oDhZvSDd3N36kxdairSxVRc0YvMElt27OCdD7V32le2mS
         Ka7J5/R4ATD1FNMD8x5Gf7/k9E9HZKZmZYElvacxKgaAlKYvtWq6+eU1yvn2jJ+ROsC9
         vhXFRIfPhwfykG2NIx79jiCIyIpsSHkNCR6oRiokPX6swNYKbTgQ2lK0Y/vopxYWrMEI
         TSbg==
X-Forwarded-Encrypted: i=1; AJvYcCUNpvsdquZrbCTQQQUDKoF2SwiUSjIYUKCaG/1G5H0lt1BdmBT6rN35yy0GDZbejNvcnjk2Wfg=@lists.linux.dev
X-Gm-Message-State: AOJu0YxvJQOBmjRg1Gf241GQZk1I4AhUQEBY65jNBjFoAMPNa8jjlUag
	HSXeMZJ9cjCll+ZvsW4fc4ef9hkZwbT/R2jTH1QG8NnBhSKlumcXst7RD9MtE8Y=
X-Gm-Gg: ASbGncu8Ief5avB7QbR0MT6qKqA9tNwXZ9+kJ+PUqS06dWO/1rPgjDZcV+DpkhsnvIl
	gjHBYw/MVYJgJZWYMXfMgQZUOCXW8fHxXHJCdhrRAaZGOf3HwCYUGSKOqaVjv0WKX2e387U8NEq
	9Qx6KOQgq1eLZmzNu+LyraRCpvtOnViIziAKWiCnNC+b7aZvetIWOQijF4oUzuRULFIB4slU7Ku
	Tfbj2Atpwii3z2E3l+gigX652NLmv+10QGPPyMMB3+oA8yjbDKsFZPR3tBWYNoUOfv+CQNBpgtC
	NtEH6OAU2+5iLs3oYh7KPPKCs4N3nhA524WwOmu3KR/VQiwdNMbKLiLAPihrRtcI0i4sVynO6lj
	J
X-Google-Smtp-Source: AGHT+IHDcuoBi0zXRLBGMhr23rvc5D92TbkiRjVw3vqzvuPIUT8bKi7xRmZ7MxsqaFITZlX/YgKMJA==
X-Received: by 2002:a05:600c:1384:b0:43c:e9f7:d6a3 with SMTP id 5b1f17b1804b1-43ecf85f526mr22847775e9.13.1743762612015;
        Fri, 04 Apr 2025 03:30:12 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301a727bsm3984418f8f.27.2025.04.04.03.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 03:30:11 -0700 (PDT)
Message-ID: <d5d28034-66be-4ec5-8e79-a5b61bd24a6d@blackwall.org>
Date: Fri, 4 Apr 2025 13:30:10 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 net-next 1/3] net: bridge: mcast: Add offload failed
 mdb flag
To: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Joseph Huang <joseph.huang.2024@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250403234412.1531714-1-Joseph.Huang@garmin.com>
 <20250403234412.1531714-2-Joseph.Huang@garmin.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250403234412.1531714-2-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/4/25 02:44, Joseph Huang wrote:
> Add MDB_FLAGS_OFFLOAD_FAILED and MDB_PG_FLAGS_OFFLOAD_FAILED to indicate
> that an attempt to offload the MDB entry to switchdev has failed.
> 
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
> ---
>  include/uapi/linux/if_bridge.h |  9 +++++----
>  net/bridge/br_mdb.c            |  2 ++
>  net/bridge/br_private.h        | 20 +++++++++++++++-----
>  net/bridge/br_switchdev.c      |  7 ++-----
>  4 files changed, 24 insertions(+), 14 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
