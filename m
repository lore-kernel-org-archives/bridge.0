Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E835779C4
	for <bridge@lists.linux.dev>; Thu, 20 Mar 2025 06:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742451448; cv=none; b=UxPpBhfoo+vlSFqp/FMFuL0LFN3vRaQF7c3hUG/VBGWwdSk6ypbJ1qPMRHyZXY7qzi4KVb1ZOPUZaQCHRa7NJ2OIILNWOsxVHxO7czv2wDEetNsQ0/8YUBhVDX7yf/Wy3VBozll35u/2Ey+SzBvTKfAdQ7sLhrC00g1ayb+KE0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742451448; c=relaxed/simple;
	bh=u0U9bVg2lTqsZtEo43vyK265DyxWNPo+6MP9a1qN1ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eOEHYqailCZFi6NB/YHQIu6o/8QUnESKDU+x+bD62L1l4aifPPEtO94LuOqOqILs2OPNwdneBMvKeW8Nu1sifHrXsxQUJBEHoZL6IkpqilI+jNsMDgkBVyCCC/cs01S6lsS9E3JGqcKDSdFe2f7cg2Vrl2EI7qoh0f0pAjY2+j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=YGZ6yWZK; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="YGZ6yWZK"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso3084525e9.1
        for <bridge@lists.linux.dev>; Wed, 19 Mar 2025 23:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1742451444; x=1743056244; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Df7/nJm6vBgqBIBBRK3eHSwVNX23gpqGbDFzSsS2AQ=;
        b=YGZ6yWZK2u1MU6IqZEd2lcmAus8TrhZ9AnJXYwnXCCXpwOV+6RGF3jP3c1zXJi/4vj
         TsB9M6qY5p9uSRtqXXek1u2ymUY0qc0q8g3SlK9Lsvj8Hh5Gs137VjzwZqojil+dcSKG
         XgC9bqbo5XlR8nQv3R3LezzdZw+CbZrx8dPxEEr6RIptq6uAOfdSyh6m16TvnH0JpZlL
         R12yMP6ChMt31UQIyfeqwWf2gL35fIWuli+AFTdt/pIhNwH6nA2jHiaCFKXcxazWbkU1
         mJD4zbRHyXsR6gX9iq3ICtThOgvbyvDj+YoiA1QHkxWX6MbipkApfzlHgcRo/eMu8cSo
         1Lgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742451444; x=1743056244;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Df7/nJm6vBgqBIBBRK3eHSwVNX23gpqGbDFzSsS2AQ=;
        b=UhmK+eS0J+7ri/ZbQuP9t82034lu3on1q8dmoUK4s6v43Z5+bfM9O62qwQXg4oX+eh
         nfPYW+YEanAerZGsh3oQZ0do/gBG4i6Po+BCRoKBl2bckPMyadMIbtcLHJ+aYAIA0Yv+
         0AJfEH8yStwXCL3r3xVvsyOjE8NG2gTfao8U0iBtUbEOYH9vgoeD/1agN5YTeBya85fG
         kUTOU3nKWoJ2g4Zb2VdOhwzePA2ESEgcXJm1eaNgCmCwJ+9r2cTzDx76ABl0DNMMv5Z/
         0CTGGjjnnalqmH1oHG7UP8wGE9+2HV1lMmNSgVvrt5nNhFRTeRaYliAmUOpF6l7Z7nDi
         Uufw==
X-Forwarded-Encrypted: i=1; AJvYcCVlssDJpJac4Ucz5OjraG36XUpE5XFsgfLxAZ5UGaq7gSFrTBlCriWqP5N2Eoa6CVwGus5YNdo=@lists.linux.dev
X-Gm-Message-State: AOJu0YwhQEnw0uZzWqvxnzaezx96m6E0E/DhT61y+69C+4EFx48NrLwa
	BA6I1som8KS8ZsBYSyvNA1Cpp5qb/7pMN6iE65qyrwgo7hxCXQhDct7DqmZGGr0=
X-Gm-Gg: ASbGncu3gW2tz8Xmu+FyLkqiK+HN4+XJtYR5l3jDAZZOmJPw4P39u6T6UljcClcnDJG
	25xt2BieE13HALrBgWUjOQSJBRyE0R15i5CPMRJo29rcJb/7wdP8oJR+sWt8TSXSAthAF4vZDlt
	OcA9iQ2WekeIAnpVZScT7M+5h6mMucud5x/7k256MQ1WeMFXxLs80oS/ZmPWgQoRqPdlTtMWRFI
	7eLtYF/KzBSFc7PW1d5aO3Jh7aL8OJyeZ3Vs1AlIL3Uc4gnAzJdSj54rMrR7uVdpjeUWAOJJVmg
	COsZ4Do9pm8tp+40sddl2kxDZXkbb/rbZJwlZMvliYJCo6DAarOnZxCZ8fSTXWzvaV0zBtOxn79
	j
X-Google-Smtp-Source: AGHT+IFwempKLPIhGnUTH6lwknWETQgWZuRBG0LDbF84yzf+Q+5WGmrF5EoT6BHx9aMLp2qTRB+XVQ==
X-Received: by 2002:a05:600c:4503:b0:43c:fffc:7855 with SMTP id 5b1f17b1804b1-43d437c3327mr58255665e9.15.1742451443872;
        Wed, 19 Mar 2025 23:17:23 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43d803f6sm39439615e9.0.2025.03.19.23.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 23:17:23 -0700 (PDT)
Message-ID: <039a0673-6254-45a0-b511-69d2a15aa96d@blackwall.org>
Date: Thu, 20 Mar 2025 08:17:22 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net-next 0/3] Add support for mdb offload failure
 notification
To: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Joseph Huang <joseph.huang.2024@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250318224255.143683-1-Joseph.Huang@garmin.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250318224255.143683-1-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 00:42, Joseph Huang wrote:
> Currently the bridge does not provide real-time feedback to user space
> on whether or not an attempt to offload an mdb entry was successful.
> 
> This patch set adds support to notify user space about successful and
> failed offload attempts, and the behavior is controlled by a new knob
> mdb_notify_on_flag_change:
> 
> 0 - the bridge will not notify user space about MDB flag change
> 1 - the bridge will notify user space about flag change if either
>     MDB_PG_FLAGS_OFFLOAD or MDB_PG_FLAGS_OFFLOAD_FAILED has changed
> 2 - the bridge will notify user space about flag change only if
>     MDB_PG_FLAGS_OFFLOAD_FAILED has changed
> 
> The default value is 0.
> 
> A break-down of the patches in the series:
> 
> Patch 1 adds offload failed flag to indicate that the offload attempt
> has failed. The flag is reflected in netlink mdb entry flags.
> 
> Patch 2 adds the knob mdb_notify_on_flag_change, and notify user space
> accordingly in br_switchdev_mdb_complete() when the result is known.
> 
> Patch 3 adds netlink interface to manipulate mdb_notify_on_flag_change
> knob.
> 
> This patch set was inspired by the patch series "Add support for route
> offload failure notifications" discussed here:
> https://lore.kernel.org/all/20210207082258.3872086-1-idosch@idosch.org/
> 
> Joseph Huang (3):
>   net: bridge: mcast: Add offload failed mdb flag
>   net: bridge: mcast: Notify on offload flag change
>   net: bridge: Add notify on flag change netlink i/f
> 
>  include/uapi/linux/if_bridge.h |  9 +++++----
>  include/uapi/linux/if_link.h   | 14 ++++++++++++++
>  net/bridge/br_mdb.c            | 30 +++++++++++++++++++++++++-----
>  net/bridge/br_multicast.c      | 25 +++++++++++++++++++++++++
>  net/bridge/br_netlink.c        | 21 +++++++++++++++++++++
>  net/bridge/br_private.h        | 26 +++++++++++++++++++++-----
>  net/bridge/br_switchdev.c      | 31 ++++++++++++++++++++++++++-----
>  7 files changed, 137 insertions(+), 19 deletions(-)
> 

Hi,
Could you please share more about the motivation - why do you need this and
what will be using it? Also why do you need an option with 3 different modes
instead of just an on/off switch for these notifications?

Thanks,
 Nik

