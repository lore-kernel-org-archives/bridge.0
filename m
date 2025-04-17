Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD9F21C162
	for <bridge@lists.linux-foundation.org>; Thu, 17 Apr 2025 09:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744883744; cv=none; b=a2BtWw5wy/8e6OtNc4QMHFApZ/iCh6fFE7/a3E/r2deMAOkFfQCa+k1bwEiqbeePNQcfjWrG9zfqxMD2msIpxcHh3Ifdp+kCjwbPnENt34fPy8/uaXWqdtYqARUCtXKm2J5opvHdj3APwsTAKPprRDPrNe102VNsVACbrnD3tjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744883744; c=relaxed/simple;
	bh=xxsIdljAYpjErYCzAnr/13dolIYliMjk/4F9ECcibgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mxtRuk/rdqwUKPvR5z2180BQcLXdDaE1/MH/GEl4efYAXk/Ux4k4pbdvQJ4kTckacVpUtNjbQuhzQU4uxaLMGIEM1CTzqEDwPlJsQdXXWX4heSnw1PYjPK+5Yk7uVKG6OQvudI6nzUCWlsERm8aqUKdR7m2YDU3pp4/K6MLtWTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=3c1tE9UJ; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="3c1tE9UJ"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D7D1C40383
	for <bridge@lists.linux-foundation.org>; Thu, 17 Apr 2025 09:55:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h7xVNuaEnYA6 for <bridge@lists.linux-foundation.org>;
 Thu, 17 Apr 2025 09:55:42 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=razor@blackwall.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7F2A440C7E
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=blackwall.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7F2A440C7E
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=3c1tE9UJ
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7F2A440C7E
	for <bridge@lists.linux-foundation.org>; Thu, 17 Apr 2025 09:55:41 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5e5cded3e2eso981588a12.0
        for <bridge@lists.linux-foundation.org>; Thu, 17 Apr 2025 02:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1744883739; x=1745488539; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lQ2mg/xbhZUudvvozY8bxjrUVYqrKSPwWo0JmfCbuZg=;
        b=3c1tE9UJhErjTcxG3WMigfXCCtnPljVRoXNmMZLDl8iik6xOYezQAGJY3MmRl2bsLB
         TvsX881YU+fSSBITpEZtNoE3dMVXVzf+g2EdIWX4+dSPOpBXPPjqMWHEgtWpURxMKB0Z
         PxrYSXwz/p6cJ2vMgb5IbvvwMJoWApBlneh/k1zimyHPeOhm44tflv747jva9GDTtPPl
         JkweHmtiZrjnWxFoiwXt/5x4jziDeMM7pmfADQBFhMjzoU5trhYhMI3zxlcyGjljghUz
         Dodq/s33UAa78Yozwn6uiEx+2laVRnh60UHC5GGt6QNDQXMdzlUbIgL9IeDgJ6FUqtJp
         +NiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744883739; x=1745488539;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lQ2mg/xbhZUudvvozY8bxjrUVYqrKSPwWo0JmfCbuZg=;
        b=xPIR2Ojxjne46nBIFaeRUxtbXC7M0tysvhRrGNtR2cvZV6XiH/LUb/GczdOgkgzN2o
         Igq/NUzW2JRAZbxZoak9xUsKTW5hd5/hkJkA1Sz44r8ioPhBKkFugmdk3LDHIpBCYd+u
         TMv/Q8UoVASMhB3W5L+QyGhxZP4NYB3v4KvqFr1eOXTSNl0Ap+BsdlsAhWCKoUsbKn3p
         YtlmV9840avj6BnJzwa7YHT+jX9fnB0DaD5OTbFdxZmI0nqo1wT/sZN1r2xT1hVG5zrA
         MVkgchl3u+SAfzNpgJeI14hRQL6K9TbHPxvzciRPxkXkU46l9CBYY0QdrV/QLroQqIjS
         dWtA==
X-Forwarded-Encrypted: i=1; AJvYcCVl74aX+WbFBlCUG4/tQaLfVa9Qdco9dmJ3G9gpNbA35Dy2w5Rrekiopbf6/4I1Om5MfizcfHA=@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YycN3LrDlbeScCRF8C2pmcQGF5UYwl6LqQrhhUKxlBH4Y1H7voS
	aSk+76E6QgXZIEm1SmrIahO7gNAoLREDL0ciwqnP8sGdAIqLDBmaZtrPQMDj328=
X-Gm-Gg: ASbGncuKqrzDw5nV7wSKO7twlOvDtwfR3cVtKc6PPdT7T4jCGqeMj69zU7c3OmMQaVc
	lKkylsE/Z/cpA+v8M05nzsPG9YplaSeZb9Fy2kMV9fYuZmCtMaJagIdp22NyPoMZBzulSvP/UWO
	aWMxEGO+zYYdCwgLIjpg+Biq9TaRPD6yrlTW0JMatAkvShQHKWW1fUaX7u5fcMkwGFEQZZVPai4
	oX0PgJ2WuyM2cYbS30B5BTYuU3aLbMWqt8nzWk3oy7FE9IbzLjYaDlI9W0j3AbTPn+mydb0j5Yd
	pP8DeKUl797IcAjLFQ7XAYpcat5Q5pKPH2+G6koEgotj/fTx2K42mmvNPGsoXqTeUuWBcO4i
X-Google-Smtp-Source: AGHT+IHiPcIRzUjZ9l/y3Kb1Zp9PXVFu+VjCeI3N8mu+9K2K1k0Y9An6INL7rP7SHCShGclwmsoHig==
X-Received: by 2002:a05:6402:4408:b0:5f3:26bc:4b0d with SMTP id 4fb4d7f45d1cf-5f4b75a72f9mr4730440a12.19.1744883739248;
        Thu, 17 Apr 2025 02:55:39 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36f52a48esm10067924a12.79.2025.04.17.02.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 02:55:38 -0700 (PDT)
Message-ID: <c33bfc41-46e5-4a69-9a73-63ac24512e78@blackwall.org>
Date: Thu, 17 Apr 2025 12:55:37 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v4 iproute2-next 2/2] iplink_bridge: Add
 mdb_offload_fail_notification
To: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org,
 Joseph Huang <joseph.huang.2024@gmail.com>
References: <20250415144306.908154-1-Joseph.Huang@garmin.com>
 <20250415144306.908154-3-Joseph.Huang@garmin.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250415144306.908154-3-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/25 17:43, Joseph Huang wrote:
> Add mdb_offload_fail_notification option support.
> 
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
> ---
>  ip/iplink_bridge.c    | 19 +++++++++++++++++++
>  man/man8/ip-link.8.in |  9 +++++++++
>  2 files changed, 28 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

