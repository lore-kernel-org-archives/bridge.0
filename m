Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB60B215F45
	for <bridge@lists.linux.dev>; Tue,  4 Feb 2025 18:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738692489; cv=none; b=oWD6J8ma0T3IRsyP/4R8jdeWGm+7h8OcWZvLS9H8ko0ZO4PoQp9hStWtzaT8y8U79xIr85OBq1CWKEFLXmKlgWrm6DoGKsbcbBCDlJoPeCYkyfX/jNumK6w2oDnLu9/PkdCtsl+n3JEy6qo/ehfWD2O0sF/0/yYSsj6sSqJqMXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738692489; c=relaxed/simple;
	bh=1VGXBkRq/s1jR3x7uGpHUxPLi+TUi+JcOWI8Yiv2CT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BSPu0cWcxpRcWLYTfdMqZG7tLkIb447jYVQ42fUdySyY095qYBRZSfYSkVUR0UqfCcJjnc8B/Vi/tXlKZ1TOCtw1BoybW7DkbT/DiJBIC9Y/K1UL25DSjFnRP8xhM4mlqkQm/YRi633yuPg74ykBQ6bD4eZdHXoUA+2EJlo4KUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=iq+2KpbN; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="iq+2KpbN"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5dcd8d6f130so748151a12.1
        for <bridge@lists.linux.dev>; Tue, 04 Feb 2025 10:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1738692486; x=1739297286; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x7QYkGmY4zibo/xAorONcV5cpLaQpnZZHAwx6lprekc=;
        b=iq+2KpbN7L/kSlAaMbXzaggyaY/gjGEcgZwyx6sbBPh7KPFxqaFSHuYtkC+O0ruwIZ
         1SUVNsDiHAQoF0ImttLQbdVZLmnE5ZW13SuNFDfPakFuMg0BpZenkMr4XRec+Q0XQbO/
         kkf0mn0NRLxkmgUrRSOusLSMOsdSqnpG/X+EmInOMBOm/SzwvaX0Gomiwu3GEZsx+ThG
         nAnfHU+gAgwZrfLwd1hlP8J6S2/WWp//BBkznDXkivEEuHYSon72dRwKTwqFNafMZNL/
         tCR9ZXKzXFqcCeDbuaBCwDA5nBt4gBgBvKnR5tXTkJE7Q9mKzzRXkMww5zxvoSpIYWFs
         tRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738692486; x=1739297286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x7QYkGmY4zibo/xAorONcV5cpLaQpnZZHAwx6lprekc=;
        b=lluccb7O3YC4ytCmGBRkGfW/vQyOj+r/HsUxz+/3SbYWs5LzVPFm6OD3nU6CvaTs6Z
         MG4xwTZ0nTLDad0NM1LqeYcpdCbz8rYd6gZINret91l6v5a27MbcKkx9vz8Ke4+Nxx7A
         S6redoWoM8FsLpTmM9AG85oab38hUfJrFq4/6YF8WBnsG+TSQKCEa98eKc6phCnAnYFl
         SkK//aXe+44INB6X0xFBkQh/OjeWWmw47yCrNlvswJvoQ9TLrEwSzMVb/F5vgkQp1Ujy
         SSRB9y9ZnhLXzjlZpMephd9uv5t1lVLjxDvyogXSnkovXIFm7aEAqjiXZ6Dl4cgBYgy0
         54Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWHJgsM6FVKuJ0VaO54Y9FI82MYw5fHB/dErvXGCtC/6RRvQ6tqtwC4pYWRfLhPFxQRvFXvGqQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YxxJp3aYnnxg6H5jnW3MoL8OZBsmUs07MFEntlx0hHYHGLVIHe1
	nKO0Dc1QzxMrt6G9ZABYQ9nvqWIHI15ekrMgDFKGSSVdhS2LrHPXgD+uENEZkmM=
X-Gm-Gg: ASbGnctv2/1gLU/d5eZBEIrNgrWnROqICE+xmHMUpRc+nC0v4lBI8yLlX302oIcjnC3
	ZBxwmBQn77serq6o/t2NpL/JjpXox+z+gkDhkFmJAIKe+h92D74EXUxY/OB+JUyqp7rvYz6t/+3
	FABkVilsieGuiUmWl37iJ1b/bN7Rwkcrkb07x/EjXC0NecrT6DTqX3ao6RV7IOxF/xa4x6CvjO3
	usJiKoJ2WoUT7d3e1ZdVQo/qdwY0qY5eq530iuwbwxgEmJ6icIhso6MLdss7KPUvYNkqLG7+nxs
	Si/zenTwo/gQDk5t8cXeZaylnBuLSHRN72qCZlt4x3/3264=
X-Google-Smtp-Source: AGHT+IFmsnIFrcNvRs6vHTZJHc5B0fjL09YjTCpSYEodCVf4XR/gUoTqvRyswP6nP/tmC8wWftUZVQ==
X-Received: by 2002:a17:907:86a7:b0:ab6:dace:e763 with SMTP id a640c23a62f3a-ab6dacf0140mr3151797066b.38.1738692485897;
        Tue, 04 Feb 2025 10:08:05 -0800 (PST)
Received: from [192.168.0.123] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47a7b1asm959410466b.31.2025.02.04.10.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 10:08:05 -0800 (PST)
Message-ID: <f50c11c3-8619-4491-8607-c58867d01deb@blackwall.org>
Date: Tue, 4 Feb 2025 20:08:04 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] bridge: mdb: Allow replace of a host-joined
 group
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Cc: Roopa Prabhu <roopa@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
 bridge@lists.linux.dev, mlxsw@nvidia.com
References: <e5c5188b9787ae806609e7ca3aa2a0a501b9b5c4.1738685648.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <e5c5188b9787ae806609e7ca3aa2a0a501b9b5c4.1738685648.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 19:37, Petr Machata wrote:
> Attempts to replace an MDB group membership of the host itself are
> currently bounced:
> 
>  # ip link add name br up type bridge vlan_filtering 1
>  # bridge mdb replace dev br port br grp 239.0.0.1 vid 2
>  # bridge mdb replace dev br port br grp 239.0.0.1 vid 2
>  Error: bridge: Group is already joined by host.
> 
> A similar operation done on a member port would succeed. Ignore the check
> for replacement of host group memberships as well.
> 
> The bit of code that this enables is br_multicast_host_join(), which, for
> already-joined groups only refreshes the MC group expiration timer, which
> is desirable; and a userspace notification, also desirable.
> 
> Change a selftest that exercises this code path from expecting a rejection
> to expecting a pass. The rest of MDB selftests pass without modification.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_mdb.c                                  | 2 +-
>  tools/testing/selftests/net/forwarding/bridge_mdb.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
