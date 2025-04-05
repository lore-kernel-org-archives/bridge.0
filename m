Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728351C1F12
	for <bridge@lists.linux.dev>; Sat,  5 Apr 2025 08:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743840607; cv=none; b=LnPR9XjUUYEmDkpcmw/EQOq+DBweGf12FE8Ji0RR2pFejNRCEK2uINrmLvWdyOnNnReWfH6/NJlpeWL5MNb7aZyDahWBxliZJGhF+lGiFtziKQ+l1n2PJbaFh0FaSHjXcov2IpjaQ5vyKQjcp8jRz8/n4wOCDE1e8gmHSZDb+Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743840607; c=relaxed/simple;
	bh=p0vGFZ1wdWGbnt9FCH999EQ6UIOtZuI8vUy65LhLMKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FgwokavhOK+yo7g/wveJZFEai4kssHEkSx0m6TmWRzYvKS2qh9ECDf0OLRx1D0cNATB/vUX6rfeEWV6IkV/xZsdWP39/uputi580Wlx90OtpOVFl4H3wUIK3CxQBGYga/KGlWtkEJdug0wxrUxwTueW0h3ZIUiC/4Y+Eq/NoswI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=KmDKV3xW; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="KmDKV3xW"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so23755145e9.1
        for <bridge@lists.linux.dev>; Sat, 05 Apr 2025 01:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1743840604; x=1744445404; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=94b9wrxm3hp7XmByM5KKoGfNoSco8/rIY08sCXX4aJY=;
        b=KmDKV3xWiUcpdZDX/pDU2YFg56DJPiVQZ2ARt8eSk2WqbpP6XLzEr8QjZC9Oq91rR1
         q4hSyt1uo/HEKPC+L83MncgCog73C13d9YZCCfxgeI9bTpoBv+pXsdDn24jKkOAD//0A
         ysi9e7spJ5tauxCfzF9G34G/Zs8RIAw312vZYrcucNPgVbwK9TQlK1XSfSJ7cWma5lTK
         BbCLpR65VM9V9ideI0nIYz/sWzXBH9QQo6LSTHu1QMzFSp+AaEomX5/mwnCXYifqf9BU
         DYQOGcqKHa82LZzk4oQ2vguyOFfY2jT+gjuTk6sz6i6Pajw9AM+TDTxQLcYeCszh+Cww
         Tl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743840604; x=1744445404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=94b9wrxm3hp7XmByM5KKoGfNoSco8/rIY08sCXX4aJY=;
        b=PYqMZLDyvfyodvQiUmccmU1oBmtMl3dazKpEqYVYeeUGMgfBouGlW4wbykkh8gOn0U
         DjxMyEk3P3KSEReu/v7zFgKOSzb4lYxCyXfi4+UAMu3kgqW9W9LuerrixSx2+H5xJ+XI
         4u0Hy1VKrB3WXTVctgxU1scj4NYxZrHpiEQUGWGd3N4CLcrg4gbHy0iKBsfcMmGyPHMP
         +e54a+tjKW2HNzA/R1WnXZ8XEod5FwQU70794rODrFCI5MXtX7ai246xcTsj2Uuzly7m
         JyqZ3gklMnYst3QTk9292KH97qgpHkSFzLL5tDQC0VIQ5stFVCvCmI/fG0KM0cD1Tb8g
         TtCA==
X-Forwarded-Encrypted: i=1; AJvYcCU6EIoplt1V+MRb2bYehN0Cl9pqmWYUHrnnoTO7UZpbHIZcLln1mC+KEd9/0/3uOV7NV5XsQjQ=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+EXT99phl7DV8sWkuTLQ8uEj+CWVlPWUp9tI0eJcTtBFCycVk
	gUkJClyKbZP+mm012OnlRxjS1Op6qgJYert0P0RT2yRBGlOuIf1mQyc6SmCBNvM=
X-Gm-Gg: ASbGncvku3WNDKruNDADUYJqnjXIcWkCNmwJmo/kx+qFEOABoaywLq4I4iVp52Q1E4P
	mqSfmHnIXzsbkGrZbqzKqU/6xZMMjXi6ZnruXuAXU0YCzs0cvZXQV26XCwiI0RTEDIAayDk+7wR
	JGbw5gY71GbbOyxIVAgSjEJY7fTR8CgD7OfhFFp3vYTxE97GBDtwc/SaF8ATrJuzQdhFmmcQERg
	DT3QXTih1toNtUCTs2DtcrBn6/x8vNMlG1s+9EcMY4jaRc/8RO8vA8UmMPg/2ObG0iI5HlZoubY
	Prr4cqJOoHEMqDiI2gBwIuMZgGaN9XL+UX9R2r/gEmYF/AcY16B1E6fWp1Ka4yYid/skvmxsLmF
	W
X-Google-Smtp-Source: AGHT+IGr3yLaTLf/J+4e1A1EPE7Ku7r1udK/W1EmakfMPotykV3/dJ3b4bi31RRCYO2b3h8RKosMWw==
X-Received: by 2002:a05:600c:1d0d:b0:43c:ec28:d310 with SMTP id 5b1f17b1804b1-43ee063da68mr24847095e9.10.1743840603506;
        Sat, 05 Apr 2025 01:10:03 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34bf193sm65515795e9.24.2025.04.05.01.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Apr 2025 01:10:03 -0700 (PDT)
Message-ID: <2f0dfdbc-64fc-4371-ba4c-48f306e90599@blackwall.org>
Date: Sat, 5 Apr 2025 11:10:02 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 net-next 3/3] net: bridge: mcast: Notify on mdb offload
 failure
To: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Joseph Huang <joseph.huang.2024@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250404212940.1837879-1-Joseph.Huang@garmin.com>
 <20250404212940.1837879-4-Joseph.Huang@garmin.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250404212940.1837879-4-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/5/25 00:29, Joseph Huang wrote:
> Notify user space on mdb offload failure if
> mdb_offload_fail_notification is enabled.
> 
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
> ---
>  net/bridge/br_mdb.c       | 26 +++++++++++++++++++++-----
>  net/bridge/br_private.h   |  9 +++++++++
>  net/bridge/br_switchdev.c |  4 ++++
>  3 files changed, 34 insertions(+), 5 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

