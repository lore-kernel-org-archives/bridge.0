Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349C039283B
	for <bridge@lists.linux.dev>; Tue,  3 Feb 2026 07:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770105088; cv=none; b=ic8unmw/HiSNWrGV21ZnQqxdZluPEMahtqrO6VCHd1FE+NpNJIa47+qoNkVo8l3UdzJ9u4+ezM5W69o5rRBzEVt5LKMajCCaW7lkVsoySxPr8N47IpGsG6zgv9KpV6r+KoPkXGEX+mg5xGR+iBsRRDa4gkC8GOnd9+93uNx2vPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770105088; c=relaxed/simple;
	bh=WK1m/rfMy+nsMO0sFa47FzExdTA2TNlHubHOaplhbdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GVftlY4qLjvJq4396ahyPDiNlnckahaNduZuEMTSs+mzAmJXeepvV9pQ4mpmQtVz6Z2BGXWYiCJxLxDtfvCGryX3y9rKgPsEOAigPV3uV5k/JCwWm6YaFCxOxNj4MiMCz7k124NWT0N/ql9gGPWp8Yk3iUttpGJDwXLoeMI7vjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=AkLAujpm; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="AkLAujpm"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42fb6ce71c7so4346522f8f.1
        for <bridge@lists.linux.dev>; Mon, 02 Feb 2026 23:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1770105085; x=1770709885; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nVvoMu7jKyWYs7cJ4I1AmXisCkMpA/I5c//QtIjMPJc=;
        b=AkLAujpmzejL3UdpGPT0CMoXQid1/dot6gSNi8MXuOaSaIvxWhJ4rZtOBNvHoBmQhS
         dTZrvEEoyc8ExaDYmJm8omkJKAOWrzLGft4/NBpljDDAfNw07QC60bK+6dg9lPsPE4hu
         5WTJmJ+kIeCtwvZh62NU2lzlccqJBl4Lf7w5G4haeIYBNry1x3NinybhGn1fTNzH3T0I
         wZHrBJc2HZvRioENJ7QODAzowtgtJpLTiDM01eYHsiuoq/GUKVdv7h+pzYKCPYu6HzhE
         r2AOrQmiPLsQXRY0d+czjEfxRWEQnVL3jV5eDmsZVkW3gfVXx0wMxmZTfn+YGHZPRbCb
         AYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770105085; x=1770709885;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nVvoMu7jKyWYs7cJ4I1AmXisCkMpA/I5c//QtIjMPJc=;
        b=w2zTW36WDPV4bSb11ZK2U/2VhHJ32Fwl4Xg3iAYlYg3jaeQYIqsq+6FTb7IP9zvjnA
         qoVHdj9vPgNzfTW7SpNlPrIOvWN6ebjmWKM+2k/TO66C3/VPQRE8Wip6F9SwvmwBJun6
         PKe0Z5bm/LiF/S/3YcfY+Wrr/2oV03J1p9F+qFNYgW0z6MV7p8qEfYvqPRJRxJH5Lsww
         dHa+X9ODzsbL8titJNSpYBsppgSrDsw8GBq3zAmr7qgx1E8pyHnLl08sh8Pa2RH53QRf
         sLgEitpjMZI0jYsA6YuZP299NFlcESjNF/Yad+INgopRQW3di9womBsO7wHPhHTVO+ws
         pbbw==
X-Forwarded-Encrypted: i=1; AJvYcCX6m9bUWTfXkb0zIuSToqzRvy7TTcjDNDonWJ8gRZTEA9e1WBc1wghAH7oHT58UubZPICXfD+0=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9WXDUhsl/9ZxW8KCUu1xyjRHHGhT64ks0imjaePjNvArCsCDH
	RLnYGgZ928baxMv8z6xAtwakZjg76RWJjgooYAGRoQJfdIbwihPNzpY8WsFG8eM9XZs=
X-Gm-Gg: AZuq6aJqnY8B0Mhdf1W1c/oho3Xknay2blZbPwtL2X+kNtOSucfbJlEkX7FqQqph/5h
	8GgzSIhbHCFMjkfMQIuZMTKxO1YACEyt0NFvGB4sxQHYKPGpGo670qWgvqFhJmGYz2LwE6TnEZB
	qKNzjuD33mS5KOxmaZP3LkjlHGv8YzGeZ5/NsnMh3RAEo18+awWz+5Rmu9W+36tLixq65hEoChx
	dQ7Gx0hNBwuEe8Tn73lVtNE4a+xpEJETtLbO1j3FfX37NsaFp52TapE2KYx70vEZwU/+RrDfl0q
	N5gZHX6XisCOjh5J34PY/w/R82t80m0SaAxur1YWWlwE8wR9yySKkpF9kgyd9yHJxV/BHlwz7F4
	WEosA2hi3O2mo1zw4JTSMd0NEw7pRe6YyElvg+Sawr2VdF9bDLGiOAh7jbYxGX12UO5SbEIHwVC
	MriicYq4992L86RNIhY84FdAtQVfm1Loyo1EGhtTHosw==
X-Received: by 2002:a5d:5f83:0:b0:435:a83e:88e with SMTP id ffacd0b85a97d-435f3a6b975mr18413158f8f.2.1770105085362;
        Mon, 02 Feb 2026 23:51:25 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1048a54sm48458131f8f.0.2026.02.02.23.51.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 23:51:24 -0800 (PST)
Message-ID: <c3c66f54-1197-4123-bc31-2cd941b58ed7@blackwall.org>
Date: Tue, 3 Feb 2026 09:51:23 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: bridge: use sysfs_emit instead of
 sprintf
To: David Corvaglia <david@corvaglia.dev>, idosch@nvidia.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <0100019c1fc2bcc3-bc9ca2f1-22d7-4250-8441-91e4af57117b-000000@email.amazonses.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <0100019c1fc2bcc3-bc9ca2f1-22d7-4250-8441-91e4af57117b-000000@email.amazonses.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/02/2026 21:09, David Corvaglia wrote:
> Replace sprintf with sysfs_emit in sysfs show() methods as outlined in
> Documentation/filesystems/sysfs.rst.
> 
> sysfs_emit is preferred to sprintf in sysfs show() methods as it is safer
> with buffer handling.
> 
> Signed-off-by: David Corvaglia <david@corvaglia.dev>
> ---
> v3: Fix whitespace issue.
> v2: https://lore.kernel.org/bridge/0100019c1d2d46e0-a083f912-ac82-47e8-8cbb-ac9d70355ed3-000000@email.amazonses.com/
>      Fix alignment of sysfs_emit arguments.
> v1: https://lore.kernel.org/bridge/0100019c14f90490-950ddd9b-1897-4111-bddd-0d4b8abf380a-000000@email.amazonses.com/
>      This is my first patch to the kernel! I've been able to build and boot
>      with the patch. I also tested the sysfs reads and they seem to be
>      correct. Any feedback is appreciated.
> 
>   net/bridge/br_stp_if.c   |   8 +--
>   net/bridge/br_sysfs_br.c | 108 +++++++++++++++++++--------------------
>   net/bridge/br_sysfs_if.c |  32 ++++++------
>   3 files changed, 73 insertions(+), 75 deletions(-)
> 

LGTM
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

