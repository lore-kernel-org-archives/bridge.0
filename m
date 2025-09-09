Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB0927B4EE
	for <bridge@lists.linux.dev>; Tue,  9 Sep 2025 09:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408870; cv=none; b=LrxmDr3AO7RJSeUEkWszztrK7rUnx/JU8MBECpW3PPzdheU+xsL67OmJGTSBCu2Qy3vrZqNsqFZVmdT6J8nPyH93HPrcACY/v3cCHDoVWB+GQIqAyEPPfsIS6S2TqkTAJOQonIhHzd6jEyVdAnbY8ysLYZmGVAxh6sZq8cxeBAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408870; c=relaxed/simple;
	bh=B09GrDM+Gl2PH3qjxQkF8GMC+ho4Vz4J3tbOnPVxw+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bm0t97fmUgKvWtDL2uPV3RpW0+BxO/lsx74WdtL3OvzW21aViVEcfPucbDJeV0kZkZFJmKkRE6OE53mTFsA/7ZywIVYZWlS6ADZkkS/GGrmZJ/mGXGuerJeaVaOvbpquCEiYptZDv5Fy7aKyApkX5lbm0MrNzPoaKzffTloWNog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=aLgU6X5O; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="aLgU6X5O"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55f7b6e4145so2761909e87.1
        for <bridge@lists.linux.dev>; Tue, 09 Sep 2025 02:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1757408866; x=1758013666; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aXS1CYgcUklnGpIeCza9yYOT777kwRmP6OwfUG9WUvs=;
        b=aLgU6X5OvqN04xvaMJmRa/5891l04i6ehpBia2hbUKKem1up0ygmPktw7e9R8AUG9H
         jNq3v8mDZ5VT3y2ajkXi+O6wFs6YPaVVl/bVXv1FSI2ji8IuYD6X3wSHKrRe6lvil0wV
         YO0RGMBLPVpbuwJF/vPKnajmL6HVrDiOJnVjfxlrOPcMSXfIF2nURq26SRxDxiZuAaqC
         hDQ43K4+VsvoZcbpDig+sqdmUw1qpGBLnL+ParxW75TnYy3DmXob8QWCuj1JWcc3grsg
         rAZ6JEoRzVIn0sEVZFx29F7P77zPdV6Aj3XVTJoz3VLWdDfPLgC0mT9UdVHLAVhpyi4S
         y7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757408866; x=1758013666;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aXS1CYgcUklnGpIeCza9yYOT777kwRmP6OwfUG9WUvs=;
        b=V2qeUmhtGipLgzOj/cbTPXtXQgS9WlKIaR14OsC2tJ8pG5fATKFjWeZVK7Ndezq2yG
         yDyD+eWkD55bnN17QQ+sraPgpyNi5eY/ZsvpM7qZDRfR8ei+fLHmJm+g3II1tflrOXkR
         uZ9VmHtQ27KQUhkQ/qEntlXJyYw6+YDPdRy27S5V6fLw5YOl4mBYqq0S2jNBFVdsnSPG
         8HlCI6iUqq9LvJ18x3iG5pQt1K3cijiD71+STqkm5ZK8XXvQ+ehj5L4c6D8xXN76x5LB
         ZeojqPkdFvLcNSkyS1yCFZ63Vd4tPHUiBN57LwggiilcI9CEdwHXOEu7zWWMMmWcwBEL
         J8uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtzDmLleQZyHbG2sD3O8qC1K4TTSagENU5+93ViIawBVxUzHH1VO1GZ16u8prZMTTlmWMpffY=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+iDgpJERMap3iE1RSWDL4B3IBRb9m9oc5AeUNiuYa4KFMYIo+
	1f9F8y0lghiRCMQHy9wkZKd8ar/PTxMSYmZ1vtLl/2nLcDISbtW1Xl8bdjkF9ER6fQk=
X-Gm-Gg: ASbGncvzwNeD5Rofa3/1D76IyfRW3dbu2bEVX3M8tkOTtkS5bybqKqnGY/raUfqgL8N
	IAYKnGtzVoDIHv64SCYOplLIwNVZIlEiNAjNBdYw5Y8apRqWMFZW6goK3upe+eS+rDLeqdOgO2o
	BWOeWFjHdxF4QouL2FrROBhOtyVBUbNHm/JiScmE5po84ChWcxB2Qo79SPzK++4+4A3ok94THbA
	Z5PsL63/5hcSeF+pdOckEHTAZfXzFNwaM2vJpytNr+z7BpBpZ87+pLDbE4/BOwRsvyMlicCaDak
	yyV7SZTC5AB7ZVAHzmo2u6KdljS/ZrU+ApBsxgC8roXvFGaikNP82NI7zU4x+KRW+bE0ITMBgOv
	/rT4CTQg49oCjIjS1C3gaE7wn2xRzz25klK68ak8/JZ5iGpSE+13Sh7P+ZLavg/4aVP+GEafHwt
	XS/w==
X-Google-Smtp-Source: AGHT+IF1YxMAnlg1qyBzbrHJljZUzCNBwbGGA/25YFm9LDOCgIfpPGjQ5Dcd3urek9oxqCQknz+G1A==
X-Received: by 2002:a05:6512:130b:b0:55f:3e4d:fb3b with SMTP id 2adb3069b0e04-562637cbf70mr3443518e87.30.1757408866099;
        Tue, 09 Sep 2025 02:07:46 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5680cfe2496sm394362e87.61.2025.09.09.02.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 02:07:45 -0700 (PDT)
Message-ID: <3213449c-57bd-4243-ac8f-5c72071dfee5@blackwall.org>
Date: Tue, 9 Sep 2025 12:07:43 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/10] bridge: Allow keeping local FDB entries
 only on VLAN 0
To: Jakub Kicinski <kuba@kernel.org>, Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux.dev, mlxsw@nvidia.com,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
 Jiri Pirko <jiri@resnulli.us>
References: <cover.1757004393.git.petrm@nvidia.com>
 <20250908192753.7bdb8d21@kernel.org>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250908192753.7bdb8d21@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/25 05:27, Jakub Kicinski wrote:
> On Thu, 4 Sep 2025 19:07:17 +0200 Petr Machata wrote:
>> Yet another option might be to use in-kernel FDB filtering, and to filter
>> the local entries when dumping. Unfortunately, this does not help all that
>> much either, because the linked-list walk still needs to happen. Also, with
>> the obvious filtering interface built around ndm_flags / ndm_state
>> filtering, one can't just exclude pure local entries in one query. One
>> needs to dump all non-local entries first, and then to get permanent
>> entries in another run filter local & added_by_user. I.e. one needs to pay
>> the iteration overhead twice, and then integrate the result in userspace.
>> To get significant savings, one would need a very specific knob like "dump,
>> but skip/only include local entries". But if we are adding a local-specific
>> knobs, maybe let's have an option to just not duplicate them in the first
>> place.
> 
> Local-specific knob for dump seems like the most direct way to address
> your concern, if I'm reading the cover letter right. Also, is it normal
> to special case vlan 0 the way this series does? Wouldn't it be cleaner
> to store local entries in a separate hash table? Perhaps if they lived
> in a separate hash table it'd be odd to dump them for VLAN 0 (so the
> series also conflates the kernel internals and control path/dump output)
> 
> Given that Nik has authored the previous version a third opinion would> be great... adding a handful of people to CC.

My 2c, it is ok to special case vlan 0 as it is illegal to use, so it can be used
to match on "special" entries like this. I'd like to avoid the complexity of maintaining
multiple hash tables or lists just because of this issue, it is not a common problem
and I think the optional vlan 0 trick is a nice minimal way to deal with it. We already
have fdb filtering for dumps, but that requires us to go over all fdbs and with
fdb duplication the local ones alone can be a pretty high number.

The pros are that we don't have fdb duplication (much smaller number of fdbs),
we use standard bridge infra available to store and find them (the fdb rhashtable,
with local entries tagged as vlan 0) and code-wise it is pretty simple to maintain.
This solution has worked for over 10 years at Cumulus, it is well tested.

It needs to be optional though as it changes user-visible behaviour for local fdbs.
Any other solution would probably have to be optional as well.

And obviously I am biased, so good alternatives are welcome too. :-)

Cheers,
  Nik




