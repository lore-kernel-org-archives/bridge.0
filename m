Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1D0161302
	for <bridge@lists.linux.dev>; Sat,  6 Sep 2025 18:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757182571; cv=none; b=SNb8xXtLKVZTqmbUh2Yg0CQveB8UwYEf8XwJ0o+FratnM9AVTyaWXk47f61RscCX5PsBNsoYjCOIOXu5TYOy8F0RJjRYxiYmWkEdIbeL5hXuo3Ux3xQsnUujCuZs6mjovJP5pfmw3ilbY17Tpu8xaoFiK2urilgrs+x7rwzEEyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757182571; c=relaxed/simple;
	bh=sLVlJOIfb0wnmZRP/NCp1+6QN0e+EXnyRYkTEW1plKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jaN4ZduT1KuSQ3JxFcb5LF9JdvpmaxwF88rGc4aNmrBm09A6GEX7gzYJC1/v21b5+BdRLQRK9uL7j3MOR0+FkAn5/EWs/ve/BLP8ovPCyhO+qCgkBQYAYoEZkYl9yLXFVr+tKnJPG/aFvbI66vI4LF6HIlH4kgrYbv4hm4TeFP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=C15I7y5d; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="C15I7y5d"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55f98e7782bso3709081e87.0
        for <bridge@lists.linux.dev>; Sat, 06 Sep 2025 11:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1757182567; x=1757787367; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MnGKTn3+bgw+22rMILf9kKNPy8LXxbHKQ6zGZbf2nxQ=;
        b=C15I7y5dF9b0VkYTMRiyxxDp8kpZeNVXnZXT6gy1KKgq3/zhhHuZQWZ7jyBBTHIfs4
         CB+mQ8UtK4xf5RxZdDnNzJwEg5cLVkzBCwIxA5mE6cYHXAn0TAxkvTbFHt/OdSAD5T9y
         CIjG7/VDXdSPcVjN7yHtPlp/6LcFWN0FPx6h+x7taaEEKC1f8kPqu56c6VZPXVL2u+n+
         kUsqo61/bFGdgAkw7cPn6828kbvbOU4F9lB1Pq/wiN/SV3uvC/YgnFoRFZ4DOBmgXZxM
         rOWw6uOLg1nYwNA22rRGL6bVGoKuwAP+AXVK4OklN/PNf2k0YvlKohL+JO3QLBpvk6t3
         SJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757182567; x=1757787367;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MnGKTn3+bgw+22rMILf9kKNPy8LXxbHKQ6zGZbf2nxQ=;
        b=VdK02cMfIgNDDcMAraiinr9qlCwwr8GsS6WMUnphReWejpPJ5Kar9ifw5HoGUInrsP
         aUydbrDlfi5rc6UTyAHV1GvdYaGgsZ0irkMVuWQb/ttJiDvuXjyIPQb/kI/UCkll/d+w
         K6orG0WkLrMmdwcB3ZdxFhSPFLJCSP5ZwcWqw7lQd3ju0Kc7onZV1PER87ZP7tzs5UyX
         anVbe91ubB40AGQj/eLQMiMmZfflRvQbNfQoN8gvDtrpwAA9iehmd8H6BfAXtS5BiABo
         5mu2KMg/C8U7TayhzLq3z7ZsmyqN9YW5VTkz3L2AxNW8JgoHWDnKKHAOvZ7oKPPWBF+r
         q+3g==
X-Forwarded-Encrypted: i=1; AJvYcCXcxw027vKmMe2fww5EU20g6fW0buKRbjQohQ5242fNnj3RQBLUZoQqGKUxV6xwaiJj5wKJAIQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YzVQ4YCE9FUXMufJoEauuiP4MMnZO6Y9o5R+GMzG9a0vc/J5Gy6
	cKGPEME+B+/VDy6xRKdIJRVZ/gD9KnkR+VdIKiqKH/Sf+jg/CjGCO0xXqr+EK/Nh7XY=
X-Gm-Gg: ASbGnctDL7utv3F9Bu2p+l5gVKRqKOgKDR3i0u33uk0/B6ZFSqVtWIksggXJwGs4X6G
	gno4wKXsDpLi5gCsTLBagIDWC/j0KuR6hBUHtv/oGHuhDv6Drob06QZ/efjCeABf3Aa0CkhBvxe
	+POtM2coZaJhXqPJNWycq+AJDtQC80iW1f+3/d1dcSzuCFo/Denni+OFK0+zw6Gs7LOheQ9AAUp
	hxN1pe7jV7sNViNl8tfqgeje0oYle5R0MNjPPQ2dtZ6i1IVJw0oWqVVpxtKKyUSWJif4VVlIock
	Z8u7MLmCx9TWjZ+A6OXwcbt7FB0gfQ5ZykFXQz/t1j1ViUzymrD5JCeexWChn4E91vO7MHZCLwG
	ooa2FhXyshw9L0cAJHYMIxRllN0F3d4yWKhrjoKZ0XcQ0osIpqDrQqrgal/1Ebf8H6Pg=
X-Google-Smtp-Source: AGHT+IHV+OhG2OvyVXOI/D5ARhgzsAIOJ5yDjRoPeJemLre0f0yTEO+fR5jy+1s91m2hQgDgJd40hw==
X-Received: by 2002:a05:6512:2211:b0:55f:5621:3db4 with SMTP id 2adb3069b0e04-56270058ed3mr721118e87.0.1757182566276;
        Sat, 06 Sep 2025 11:16:06 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ad4c652sm2491689e87.142.2025.09.06.11.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Sep 2025 11:16:05 -0700 (PDT)
Message-ID: <3b25fcd8-ec7e-40ba-8432-e1d489b12875@blackwall.org>
Date: Sat, 6 Sep 2025 21:16:03 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/10] bridge: Allow keeping local FDB entries
 only on VLAN 0
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 bridge@lists.linux.dev, mlxsw@nvidia.com
References: <cover.1757004393.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <cover.1757004393.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/25 20:07, Petr Machata wrote:
> The bridge FDB contains one local entry per port per VLAN, for the MAC of
> the port in question, and likewise for the bridge itself. This allows
> bridge to locally receive and punt "up" any packets whose destination MAC
> address matches that of one of the bridge interfaces or of the bridge
> itself.
> 
> The number of these local "service" FDB entries grows linearly with number
> of bridge-global VLAN memberships, but that in turn will tend to grow
> quadratically with number of ports and per-port VLAN memberships. While
> that does not cause issues during forwarding lookups, it does make dumps
> impractically slow.
> 
> As an example, with 100 interfaces, each on 4K VLANs, a full dump of FDB
> that just contains these 400K local entries, takes 6.5s. That's _without_
> considering iproute2 formatting overhead, this is just how long it takes to
> walk the FDB (repeatedly), serialize it into netlink messages, and parse
> the messages back in userspace.
> 
> This is to illustrate that with growing number of ports and VLANs, the time
> required to dump this repetitive information blows up. Arguably 4K VLANs
> per interface is not a very realistic configuration, but then modern
> switches can instead have several hundred interfaces, and we have fielded
> requests for >1K VLAN memberships per port among customers.
> 
[snip]
> All this FDB duplication is there merely to make things snappy during
> forwarding. But high-radix switches with thousands of VLANs typically do
> not process much traffic in the SW datapath at all, but rather offload vast
> majority of it. So we could exchange some of the runtime performance for a
> neater FDB.
> 
> To that end, in this patchset, introduce a new bridge option,
> BR_BOOLOPT_FDB_LOCAL_VLAN_0, which when enabled, has local FDB entries
> installed only on VLAN 0, instead of duplicating them across all VLANs.
> Then to maintain the local termination behavior, on FDB miss, the bridge
> does a second lookup on VLAN 0.
> 
> Enabling this option changes the bridge behavior in expected ways. Since
> the entries are only kept on VLAN 0, FDB get, flush and dump will not
> perceive them on non-0 VLANs. And deleting the VLAN 0 entry affects
> forwarding on all VLANs.
> 
> This patchset is loosely based on a privately circulated patch by Nikolay
> Aleksandrov.
> 

I knew this sounded familiar, I actually did try to upstream the original patch[1] way back
in 2015 and was rejected, at the time that led to the vlan rhashtable code. :-)

By the way the original idea and change predate me and were by Wilson Kok, I just polished
them and took over the patch while at Cumulus.

Now, this is presented in a much shinier new option manner with selftests which is great.
I think we can take the new option this time around, it will be very helpful for some
setups as explained.

The code looks good to me, I appreciate how well split it is.
For the series:

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

Thanks,
  Nik

[1] https://lore.kernel.org/netdev/1440549295-3979-1-git-send-email-razor@blackwall.org/

> The patchset progresses as follows:
> 
> - Patch #1 introduces a bridge option to enable the above feature. Then
>    patches #2 to #5 gradually patch the bridge to do the right thing when
>    the option is enabled. Finally patch #6 adds the UAPI knob and the code
>    for when the feature is enabled or disabled.
> - Patches #7, #8 and #9 contain fixes and improvements to selftest
>    libraries
> - Patch #10 contains a new selftest
> 
> The corresponding iproute2 support is at:
> https://github.com/pmachata/iproute2/commits/fdb_local_vlan_0/
> 
> Petr Machata (10):
>    net: bridge: Introduce BROPT_FDB_LOCAL_VLAN_0
>    net: bridge: BROPT_FDB_LOCAL_VLAN_0: Look up FDB on VLAN 0 on miss
>    net: bridge: BROPT_FDB_LOCAL_VLAN_0: On port changeaddr, skip per-VLAN
>      FDBs
>    net: bridge: BROPT_FDB_LOCAL_VLAN_0: On bridge changeaddr, skip
>      per-VLAN FDBs
>    net: bridge: BROPT_FDB_LOCAL_VLAN_0: Skip local FDBs on VLAN creation
>    net: bridge: Introduce UAPI for BR_BOOLOPT_FDB_LOCAL_VLAN_0
>    selftests: defer: Allow spaces in arguments of deferred commands
>    selftests: defer: Introduce DEFER_PAUSE_ON_FAIL
>    selftests: net: lib.sh: Don't defer failed commands
>    selftests: forwarding: Add test for BR_BOOLOPT_FDB_LOCAL_VLAN_0
> 
>   include/uapi/linux/if_bridge.h                |   3 +
>   net/bridge/br.c                               |  22 ++
>   net/bridge/br_fdb.c                           | 114 +++++-
>   net/bridge/br_input.c                         |   8 +
>   net/bridge/br_private.h                       |   3 +
>   net/bridge/br_vlan.c                          |  10 +-
>   .../testing/selftests/net/forwarding/Makefile |   1 +
>   .../net/forwarding/bridge_fdb_local_vlan_0.sh | 374 ++++++++++++++++++
>   tools/testing/selftests/net/lib.sh            |  32 +-
>   tools/testing/selftests/net/lib/sh/defer.sh   |  20 +-
>   10 files changed, 559 insertions(+), 28 deletions(-)
>   create mode 100755 tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh
> 

