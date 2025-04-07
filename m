Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7861C2550D2
	for <bridge@lists.linux.dev>; Mon,  7 Apr 2025 18:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051238; cv=none; b=abT0Q2fIx4RNecdvU6d4Kh6lFvgMqMMzkUUqZhWIJz4GcnzN/T193YhQ1UONJE/20WBdTSl5UV2nv/Wln7OhETQJsr60fmn6zNnfoBL4Qq8hitHhf21Y2E1QxwY8ebEpLB05jG1/2p+tpbIYliEYfAq6NDIMyRMNn726XUiTP14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051238; c=relaxed/simple;
	bh=KVvTyyF0VkafWFfOugua/YDD0iLrXHMzMWGuCOsrYSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQugTYZ7unLP0YaJTqRdajapxPq4wEvXhffo5AKHvu7vkfS0TS+hQryhSyP1fi6rR0zX4AjZ8z9FLvpNUQEG9TEho4iwBgdgbluNg8hG6bs22k0JGnlpIL+jhpEmEt/yxuImaM6BCngF7BkdiNjYWpaseRr1cfmSckO4sj8I4bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CE7M+GT7; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CE7M+GT7"
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-e609cff9927so3265860276.3
        for <bridge@lists.linux.dev>; Mon, 07 Apr 2025 11:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744051235; x=1744656035; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/KJ1Yxh0RTA5B17N4EwbA//OrbDLUv7EVB4eL3fHgUo=;
        b=CE7M+GT7pJqeR9eEweejyMxlw8oEftINCL6E3QhUuyyepPwWG9jyDEE423Y8mhnexk
         xSYHlBhfzUdxXpjVq6nC+f1x4ngEB5l8LK5kpnkCODT2Rfl5Z1dV0NWYqL3W3uRWk9QR
         5mddijLv0e+DBI3UXkmRZZ1ifNbJsA1nkYYiNzMlhvsJhwABdjPNlV2Fx57Gr87hfudK
         Icj3Su7jvSHYHu4ioVLj81RZzJezn0GKuaeheguobaEgOxCehpHSIWNzVc05KgPWrCjX
         QvASHbHjTgbVN4Y396SG3U8VYfWSuvUiE6sHB+sgiIKUAfJPLtXOe/POm4wWkUIA0TI3
         eQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744051235; x=1744656035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/KJ1Yxh0RTA5B17N4EwbA//OrbDLUv7EVB4eL3fHgUo=;
        b=Z0iMpbA+mbTLc8Uf1wVgMsHdEwxbbp+fvpzj7vY4lFOR1lNaP0Y/qEi139UcDkXF6+
         4e39i7oOmvSvrUUQoajK+vNVY3h0xSe4DA2OntrLBSrZgCptyzL/wxmoSxMlNbKVC/by
         lCn7a04Ke8IK3Wmq3qBygazjHmHF8d6iv4AKGCfYbUWcfJY7Qob5gzMCGm3TjdGHPcM7
         dJ1rzXdwV33XIm/vV3phJhxBZqyV/MtQkJ89yi/xGQzd+M5eQGZuq1fdPhwHXZ9w5Jfx
         QC7IyyaXyTZSVel0MY3YOOPLh4/y79ph5p2uhjOLFlCZUTHaw9VbHoIx8zL2VBHbFwBX
         zn8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHFm2VN9ux22M7N6a6PeCHbEbKPtDinjFUpV9d2/VL7LZOOlMvZ0wQDH9/VCIRIXn2VBJil0U=@lists.linux.dev
X-Gm-Message-State: AOJu0YwovOpoEsBn1b3v48WKTi7LQRHlpyepSH3nm3Oh1uU/ud1NQXfy
	JYJFKIIK8kit67ipT5A8BgLRWDUOi9K6MQ+Dh9CTm7FGSPrSJZdj
X-Gm-Gg: ASbGncszHy9IKRzGfZLg2nL0LYe58Or4YyM1aLh/j8xHfcvZM2+2RjbX3C9kgu+NNBs
	Yow5LLDLzxg0rY318sgX+FpNVqyrUj7Lc4XoN3zb1/+eQAn1Ek5Q7nsQUPDlW4dEkPJqyJuq/GD
	l5KCmzlimorUEgaFpcDLK00yRU36YYNiShs+tKU3Oyz2lKBWQ2J04er+idL6YZo91Q/OBqmCRcC
	4dNP0XJjZkg0bWTQnHv777yQLF3Z31ZmokiupjwAHYJHATMOtnWmpzc51stsrL/5esIRp8wLJ2G
	pwp0NfLvM5WVuu/HMJkUfExORC79lKB7A/3quwuXZ9wqWhSGSs0sIAU1j9ZB7iBirgE=
X-Google-Smtp-Source: AGHT+IEA/4VSGPViRd6mU6bh7fnFDXSOD8VnOzbhsOivdiFta/wUWZmqwIG46N9Ui62wNQSHOr70hA==
X-Received: by 2002:a05:6902:a86:b0:e6d:ddb7:357c with SMTP id 3f1490d57ef6-e6e1c457da3mr23929156276.48.1744051235400;
        Mon, 07 Apr 2025 11:40:35 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e6e1c22c23csm2145425276.42.2025.04.07.11.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 11:40:35 -0700 (PDT)
Message-ID: <70d1fca7-5549-4b3f-b376-38443ca3a171@gmail.com>
Date: Mon, 7 Apr 2025 14:40:34 -0400
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 net-next 0/3] Add support for mdb offload failure
 notification
To: Jakub Kicinski <kuba@kernel.org>
Cc: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250404212940.1837879-1-Joseph.Huang@garmin.com>
 <20250407102941.4331a41e@kernel.org>
 <af01e665-08bb-4b60-ba0b-1784dd8a5ce3@gmail.com>
 <20250407113758.2fee3e4a@kernel.org>
Content-Language: en-US
From: Joseph Huang <joseph.huang.2024@gmail.com>
In-Reply-To: <20250407113758.2fee3e4a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/7/2025 2:37 PM, Jakub Kicinski wrote:
> On Mon, 7 Apr 2025 14:15:31 -0400 Joseph Huang wrote:
>> - Should the re-post be v3 (no change) or v4 (bump)?
> 
> Doesn't matter much, but probably v4 is less confusing.
> 
>> - Do I re-post after 6.15 is released? Around what time frame (so that I
>> can set a reminder)?
> 
> No, no, I mean very soon. Like tomorrow. The merge window is when
> maintainers merge their tress up, rather than when we merge code
> from contributors. It's a bit confusing. Merge window open ==
> normal contribution closed, and vice versa.

Got it. Thanks for the clarification. Will re-post tomorrow.

Thanks,
Joseph
