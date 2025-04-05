Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3C41B4F3D
	for <bridge@lists.linux.dev>; Sat,  5 Apr 2025 08:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743840589; cv=none; b=e3rBaVEQeOIWlpyXvmYOg08Txc4IHmaH9CdRqokdHRdSei2do4LuqJD2fkOyY5t8iHaA0Vp6VrRMXhmB7GBsfeTtzNHZV5bFLz8vMSRZx8KswczKHVrd/+OrVMW++d21txFcDlSCEp0ofwMAEd1cjCm/V5ScuPlEqow0OSP/fi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743840589; c=relaxed/simple;
	bh=xpYMAwtnNfE9chsuIaMja5VW7WUGODl8F8mPADK0ESA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DDFsBCsq3/UcWJbLBnBAjq7ghLE7+AhNR8SAfDCYMrOKIEHbG7AJEpoSagxF5hAIgdbr1tGGR0vdhkwhn92vtkLQcn1Q5wD/1CvE+2Fer+X0NVbPBRBAJuVsQ31cLsFP9kYpEaQaP3znAe1NtCNsKT+x0hTn5QaXXok1QC+pOt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=e982sgmy; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="e982sgmy"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso17161195e9.0
        for <bridge@lists.linux.dev>; Sat, 05 Apr 2025 01:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1743840586; x=1744445386; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/QZsIuICHFoqyu64ZjWWku6z9fVSAzGTu2pQOtSacSA=;
        b=e982sgmysMfrLy14ME6Jkr5zICYPs77vXlY5x1aQnlt67/8uOCwHNaaUSJYKJtczGg
         D5iLtOTY/x5FGyNaM3TpX0bwD3UYNU6BnjOatpgVCc43gd+WN2WhJRZXITeEDdITj/7E
         ED8uHQv8l07U+4/mg+G6zvC4tXcNRiIb4RmAx97qzDaXPzh5zeYx/f8XEByRoovldZEO
         2/eYXhYLClf9rdXKN2eoq/ptV6PhNvwFkPju9mTwQNNyhFAAW4V+JmhL5gGm4hB8owPE
         vZ6Wko5lyYl73qJDkXdgHPokDAeSVclk9u7Rz1JxRLCPUNehw1qEKir29NNdi3GiAehW
         zAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743840586; x=1744445386;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/QZsIuICHFoqyu64ZjWWku6z9fVSAzGTu2pQOtSacSA=;
        b=agHc2rvEToHCUz8nEcvcNTX6ljMSVktut8xBvepi92D+czNg9z1ku3LFJNH9nue7yn
         1uo6CVWsjJNgl6uXyeBQpegWpXh/EZeUi/9YWQ1kxsSO823sqJFrcTHmT8bnPnIIsUTk
         u7PIu3SVuCycrue8Ho1wjPqqyajRv3z6ngwkFj2zMJl6cJEmGq36xghtZtdG55s49TH1
         U5xqrG1Y4kmWpadq4mce1Ls6hyp2+j+tVqsv9m1v5+2oXSmimeMI4Uf+VmbfSURi2Yqo
         O/kV81e6pcLDrXFZp5TUtL23Z8HbSdJoLnup2TAhqXzn15xitMUnNabgimWN14uZEcmu
         FjwA==
X-Forwarded-Encrypted: i=1; AJvYcCWopl62R2+3OH7BgHnRV/D5198PbPVoMsojjD1Ml20hyL7+bE+Tq8qp2R2n05KkiWIJqbXKXn4=@lists.linux.dev
X-Gm-Message-State: AOJu0YwjpxCgKJCxoLzfGE9pnNbKyw2IdI1aPfGsL/mGvpg9q605WMzH
	Zxq+yDEeXrgKLWzVxHIuOdcOtXfoNVFXcwUWONpIG2KAq1YvMIDBhrTklyZBCzM=
X-Gm-Gg: ASbGncsdpcNYTogq3o9o/AapzKAn/ScU8K1IJikxAU0dBddJcwNTI+6W+o8xqU+EvFb
	zFFLSvYjd6A7XmOorH7aFgusdtzct5kCUkXbg+bjSy1JXkSNUzKe5AiGKgkwxqsFUSyhu78YPyf
	wb/UzKpDDXsqk77MZwNYB/6rCe2TNe3m+UB/kWOylrUvh/0RiJMWrIRMSZQ4KdMTDjH9vRaqhLA
	J++XifOOnauKSZLABvzVX6FqIlQT4+UfX684nu6wULZ8o0EJQxuZZXqgJmPUVaTT76X0UuBAdxf
	JlK9rS8ZM0G6UNqrc8CpjDT4sFSmFdd/MxRn4WLhjm7GIQ7NCdfBRAs0540OT+0+yqjkrCWsWIg
	i
X-Google-Smtp-Source: AGHT+IFHXyrO4duwB/8ct3hbp2ZVFrHLWPnHZ+LzJPJBWsvwvWdFic7KtYfCRYh4AG6VhKDgfHE1gw==
X-Received: by 2002:a05:6000:270d:b0:39c:1257:dba9 with SMTP id ffacd0b85a97d-39d14762337mr3053384f8f.57.1743840585714;
        Sat, 05 Apr 2025 01:09:45 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301a7045sm6325826f8f.39.2025.04.05.01.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Apr 2025 01:09:45 -0700 (PDT)
Message-ID: <0c42671d-31cf-401d-8c40-be43b9c83ab3@blackwall.org>
Date: Sat, 5 Apr 2025 11:09:43 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 net-next 1/3] net: bridge: mcast: Add offload failed
 mdb flag
To: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Joseph Huang <joseph.huang.2024@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250404212940.1837879-1-Joseph.Huang@garmin.com>
 <20250404212940.1837879-2-Joseph.Huang@garmin.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250404212940.1837879-2-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/5/25 00:29, Joseph Huang wrote:
> Add MDB_FLAGS_OFFLOAD_FAILED and MDB_PG_FLAGS_OFFLOAD_FAILED to indicate
> that an attempt to offload the MDB entry to switchdev has failed.
> 
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
> ---
>  include/uapi/linux/if_bridge.h |  9 +++++----
>  net/bridge/br_mdb.c            |  2 ++
>  net/bridge/br_private.h        | 20 +++++++++++++++-----
>  net/bridge/br_switchdev.c      |  9 +++++----
>  4 files changed, 27 insertions(+), 13 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


