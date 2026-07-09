Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FF63C2782
	for <bridge@lists.linux.dev>; Thu,  9 Jul 2026 09:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590073; cv=none; b=hTAwKGCAzhhyd+VzLgnCFIqZS6aqVYNiE9oSm7Z09QylkyCOh8wqZDnheAw+58EC60c9XVSQc5n8+nTj+3of4JiRmWZXxG46b18hC/J2Kex2HvOvWsnHGAXMwNFMtInx0sovHvxFSLQ40YdihZ2WkIKbv/TR4YqQ434W7UeZ24k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590073; c=relaxed/simple;
	bh=/8dM9Z/CoF2L+7WNN7ITyoWlNjxyJTQlQwpQFvzkRD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W8rGYMBzPJrEKlxkZgzAZqCMQFWAM0a850CyKvH8eq0H6xmmHlL7AA1uEvkjJXR529o2MewTS6LLFvvOGxSPVsPtBkM1XrLq2aNvgVgFnUHWg+iJS6SJdftN6xrAyCJTsf//Rc5pQsFUw1SuqnbWAZ+rW3TSMtGO38LjVkKCIV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=eyLs1gSI; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="eyLs1gSI"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47df440fcd5so693971f8f.3
        for <bridge@lists.linux.dev>; Thu, 09 Jul 2026 02:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1783590071; x=1784194871; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dpTA2UFoD8jIxn6LzSQQQ69wwcU0vV5c/nqe3IqCP2Q=;
        b=eyLs1gSIRgvXubNBEXL4/+8tIQMib3FSnR/Ffm6xYxwqjvj7vzdVmQlSv8VcEismft
         P5RiQQMIX6168HmLPtpv8aJpMppqqJQ4PDLbDOueK73lnCyMJhO0txNA3MN/UQU3cRlQ
         B6Ozf3PhTEMWUQBz2/eITgDsCq4QyW9qS0Hm6sT0JpFKBSUuFGKqLnBWbmepGYRQj72h
         epYR8AQ8YgE3RXo/zEtlM6imlo/e6Vs9NezDBLHmis6s1JUy9vk5BAhFDUx2eZWwZYch
         NuHgnC/wQg7gS2QcEo1YpiKV00MFYkYgUGq/K2Dh0aS2HaQS5OGIKR+ew7dt3LyX+vOh
         jmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590071; x=1784194871;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dpTA2UFoD8jIxn6LzSQQQ69wwcU0vV5c/nqe3IqCP2Q=;
        b=aP0gLvYovCV0v7XlZR3ZXVMAb4d6/Ul3CeMwkDxLfgRy8Zx47ry0ti5feyRbjjwumy
         IBvpwQgXYyM8pvQMKuWa/PGXu7MyIszjtB6m9flsF9riyXmVyFN78qK1AZ0WQf/9VFOA
         VTR9KIh1aQ4FUhbw8SV9wKHpYcPiNSXN1+hDlEfPlFEBteG/yZQSK6K1RYVwrDfLJQ56
         SvN8BHvJgZXvRGnpIEF79/t4H54HAClYvpwpStWLcDez2e0qWhY/XXfwfah7IBG8w6Ej
         +eu+JvuW4xTzhuoAWwXp9MlZurEfA461K4x9LX4YfRuQK5lzSgQIWXEEf7nzPbVYSakr
         6YJw==
X-Forwarded-Encrypted: i=1; AHgh+RrImFo8KUBVAKM2YSDmz6ZivB0FH/R3aMCIOQKOXrMRmL7VUWlWrskdRG/osLRIgnp6/OlRvnk=@lists.linux.dev
X-Gm-Message-State: AOJu0YyEZCUJ5tUE4QOaUjAE0XVDydiT1VPEbTfvbjH5EuKlXsT0qG40
	qYqdOYdtQjw7tqziMv+BFq1Jzo6pALs1vLqK7Ulu6EfZLEAUEHFhCYJJe1fQA4sOEEI=
X-Gm-Gg: AfdE7clHh/hG7QdxlRKiTrrUkX8VYVr2gyIX9PrDv3FN9RhJkbtYuXOCpkKdLrTHh6v
	hMvjGIxQh8JzDdOo0bntTsCHaT05n7SqdTDflj2UoZyttJraTiE0iGwoNiMOyXGyEEeCWlEXISX
	d2uY7PF4ctWfnJ8mMeraM1Rz6xn45EfPWl+wtafe/CQXEZqazuO5r5JmtBFK3Gaw87/PWlhj5RH
	2e04ptZ1uJWHAgks0NmEndfFLf5FzXmTP/5n0ky0MnIjscPni3b51B6LbX5QaibftTy+ugv4b+q
	B6Fq7RgMNWmdgdsQ1J1o/5E3btIY1vCy/FI/jnHj4AjW+036zdGqcebsD5hx0pUHW2WsM/Xs9iY
	RtS4cKYoKDdlm8qdgTydlMJKsnbLjnVcc9rO+uq1J5CPexfhc3GyD3s2gy6gC+ZYG6yQyt/9+pk
	1AA0U6+2QqnIfHaUj0ftOspEol/a/wKKXOi/BAbpi4b9soh6RyHBhFoA==
X-Received: by 2002:a05:6000:2407:b0:475:f100:3604 with SMTP id ffacd0b85a97d-47df081ba52mr7354428f8f.51.1783590070132;
        Thu, 09 Jul 2026 02:41:10 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d8f1sm50701835f8f.3.2026.07.09.02.41.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 02:41:09 -0700 (PDT)
Message-ID: <b0f45a47-ef6f-43df-9738-67b28df1891d@blackwall.org>
Date: Thu, 9 Jul 2026 12:41:08 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 nf-next 1/7] bridge: Add filling forward path from
 port to port
Content-Language: en-US, bg
To: Eric Woudstra <ericwouds@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
 Ido Schimmel <idosch@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Stanislav Fomichev <sdf.kernel@gmail.com>,
 Samiullah Khawaja <skhawaja@google.com>, Hangbin Liu <liuhangbin@gmail.com>,
 Krishna Kumar <krikku@gmail.com>, Martin Karsten <mkarsten@uwaterloo.ca>
Cc: netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
 bridge@lists.linux.dev
References: <20260707091045.967678-1-ericwouds@gmail.com>
 <20260707091045.967678-2-ericwouds@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260707091045.967678-2-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/07/2026 12:10, Eric Woudstra wrote:
> If a port is passed as argument instead of the master, then:
> 
> At br_fill_forward_path(): find the master and use it to fill the
> forward path.
> 
> At br_vlan_fill_forward_path_pvid(): lookup vlan group from port
> instead.
> 
> Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>   net/bridge/br_device.c  | 19 ++++++++++++++-----
>   net/bridge/br_private.h |  2 ++
>   net/bridge/br_vlan.c    |  6 +++++-
>   3 files changed, 21 insertions(+), 6 deletions(-)
> 

Just FYI please see my reply [1] to Pablo's email about this patch. I think
there might be a problem that needs to be fixed.

Cheers,
  Nik

[1] https://lore.kernel.org/netdev/b0774436-bc41-462f-820b-6a037b6082bb@blackwall.org/T/#mfbfb071107713d420bf26c060b1b980b270ab172


