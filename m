Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566AD4FECD8
	for <bridge@lists.linux.dev>; Fri, 18 Sep 2026 15:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745397; cv=none; b=kAPYGhvUK4xWoKiW/PIT3KYssVscjyuv0lD8LDeyNOWrCvSE8XNvkItUt45xdsBH6txMeImJtJEbtwTeeElb4nurtdhYCtomewEbYFKN+4cKEslEnmY07mznBmUYXlKZJ5WNXvz4RZ4CxYahVYI9TpMwAjY2/MuGH1iyQ8rakMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745397; c=relaxed/simple;
	bh=h4Hul5ymOgHYSxbq3YsFSVLjmu007RktR/VKhv22gZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TzP9B3xT0BvNyvWfUyVa8cnoA68b/8iNe/gwx/sQAuiEGODHYHMlCTog9lwj/xizswWzWmhzLi88IDkXYAjHn0y7fEbiwdFfs493aj7fMTjN+OiWGQCVm1U76mkNrK4XG4pRCCDyyqGkIMSTGXZU05UVs285X0H9onzTMvEh+Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=mNBtIzoH; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="mNBtIzoH"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4834977ae75so507555f8f.3
        for <bridge@lists.linux.dev>; Fri, 18 Sep 2026 08:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1789745393; x=1790350193; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D9Jm+7uInTFBw95bHk7NJezgWP/D2xV6bT/6FlAArL4=;
        b=mNBtIzoH6NJZ+Xi3d0Kmw+ekzby8hdgBl8Y1iVrT7LXdf5qTP+jorwDirJfzcUK581
         rkZBO4PbdDnFWQdX6iRm1JpFrQDEKpxOWwD9+f82fD/VyQiYddb9hjAIxKlVZ6jVwtb4
         hxHUujZayP0ETnnha+cINULJ1muNGQbjVnKoy/xHzGFYcWbEa0fCbAwDD4FXc/Gxd3ts
         xzmSdEnW2t87sLudZPpx12SLyxFoWeDiRTs4Wvx/3KtndF8wfjAf/JPW0ONqjPNanaCC
         S1JiihV0DR0kcguixE0qqCJteIPrnBTPCHjrlylIZ86M2bTnUaB6BqoEaT7RobwaUGOf
         URcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789745393; x=1790350193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D9Jm+7uInTFBw95bHk7NJezgWP/D2xV6bT/6FlAArL4=;
        b=RvQrStGmjXuA0ZqXPGA3BP2t8k0JfmySDIOJCbAPsaw4wq2dz9iEfk0vjgvRx+wrzX
         LDVgEfm0n7OWxCFev7wio75HWWLF/A2iLZM6QL5pP3o5YkGEzdaHy4/udD160vj2czy3
         UUyoCur7xXE2S/zv0Q3HCjtyQM+XpH2Lax8tRm8eTpqXvmCM1pSDDuujdxfrPZpo+fRj
         8GRWswFx1jEMhd1PLyV+gN7atHunckShEER4Ud+fLUbkLsLCf3s8IzO5D7WBDZaUD3lN
         v/uMf5k8sqwenwXv4P8rP8SqEgp3ny4HRCZCRyqnF7giPBE/yFhFH52XzoxoL2rNgZLb
         Y35w==
X-Forwarded-Encrypted: i=1; AKwUvBxuh8QGQFGGj36bXrL1XqTRbx1ESQadLlZSzgSrKeUuMVAcOCDgmR4giPc+CmBt3VTUDRkj+SA=@lists.linux.dev
X-Gm-Message-State: AFuF++mHHWyLxgNTyUTcUa5TmGjbzL5VU4BHlsdeL5wyHvxX9zo+JBBR
	6y3O7SbYLaHcAD4KDaIXg4c/xowU2dNaG+VvCgRsH2ncQ/BTJJC7VLZjBHUFyg43/g0=
X-Gm-Gg: AYBFou3gmcUJXL8ulR6XBp93BO0Aa61133yyLH/gql/jNCjBhM3/nh9yrOZFr9eXC87
	tg8lvLrn0o+FhnaN7KgsKZdQA50bdp/3DAB10YzfQEHVsY6EoMLr0xnSL0qK/+tswBcw4aGNSIF
	XNUr9luyYCYnKipH+jhP8yvcDXo3u6rAWAgjiyshlsEIm1cjnolTs+85QUxWgE2fjXtj8u+6S9Y
	xsvc4tpngyZWgqNmcTon2Ikw9Zq4OZMyPM2T8Qo33tvBo9Kh8j5T2aHQpKg2/SL+3J40E+Iosv5
	ujuCUJesD3hJEj3n/cCBV9wI7hx+HYO+7LyHyw8oqsBtMrqAUnpiDZxhxyS9OCa0Q4BUZlrsIfa
	9ovGS6zGM2A9yo0FXClZp2/Tl6KMQKEL7YggOvQheIefzGtQp6DI3CMjHmMNpKyOqd3ySwA01aR
	8uHrnfNeS5Z88ux7URfTZ2aCCglBuJ00x28KpkhUKK8ns+IfvXyHVVCSiy0zuj2waliNev83DmQ
	1g6DjE+6iBZT+eF7zuuXQ==
X-Received: by 2002:a05:6000:24c1:b0:487:a0f:82ff with SMTP id ffacd0b85a97d-4871e25e2b4mr7676612f8f.17.1789745393227;
        Fri, 18 Sep 2026 08:29:53 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48720072652sm4978901f8f.23.2026.09.18.08.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 08:29:52 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 0/9] net: bridge: vlan: broadcast fwding path optimizations
Date: Fri, 18 Sep 2026 18:29:41 +0300
Message-ID: <20260918152950.1938259-1-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
This patch-set is the first step to removing unnecessary VLAN hash lookups
from the bridge fast-path and also provides additional broadcast path
optimization by considering only the port-VLANs that actually participate
in the VLAN instead of all bridge ports. Combined these changes bring
considerable improvements[1] and open the path to do the same for the most
common fdb forwarding path. As expected the pathological cases have the
largest gain, e.g. if we have 1 client / VM facing port and 1 upstream port
only participating in a VLAN with many other bridge ports, we consider only
those 2 when broadcasting in that VLAN.

For up to 8 ports we only use the port-VLAN list as the array doesn't make
much of a difference and is unnecessary. Note that the array is rebuilt on
every member add or delete when >8 members, I tested that and could do
2000 VLAN add/delete with 64 port-VLAN members / sec on my test VM.
If it ever becomes a problem we can optimize it further, for the time
being I prefer it is simpler.

Patches 01-02: factor out flooding code into helpers that will be used
               later (no functional changes intended).
Patch 03: Cache the pvid VLAN entry directly so VLAN ingress can return
          it without a lookup while using the entry as the single source
          of VLAN state.
Patch 04: Introduces a VLAN's port-VLAN rcu list, used to build rcu array
          and as a fallback when flooding without array.
Patch 05: Consider only port-VLAN members when broadcasting, the first
          major optimization, especially in bridges with more ports.
Patch 06: Build RCU array of current port-VLAN members to be used for
          flooding when ports are > BR_VLAN_PORT_ARRAY_THRESHOLD (8).
Patch 07: Introduce a bridge forwarding dst structure used to pass around
          port and VLAN (later could be used for more state) enabling the
          next patch to remove VLAN lookups.
Patch 08: Use the port-VLAN carried in the forwarding destination to remove
          two redundant VLAN hash lookups in the fast-path when
          broadcasting. Same optimization will be made for the common fdb
          forwarding path in a following patch-set.
Patch 09: Avoid unnecessary VLAN hash lookups in the flood neigh
          suppression path.

Thanks,
 Nik

[1] Test measurements, also present in patch 08's commit message

  The series were tested in a two CPU VM with packet generation and bridge
  forwarding on separate pinned CPUs. The results are medians of seven runs
  with 300000 64b tagged broadcast packets.

                   Mpps                   br_flood TSC cycles/input
  VIDs Ports  before    after    gain   before  after  reduction
     1  8/2   1.209298  1.636580   35.3%     1444    845      41.5%
     1  8/4   0.843175  0.986541   17.0%     3036   2527      16.8%
     1  8/8   0.508857  0.559844   10.0%     5999   5465       8.9%
     1 32/2   0.893896  1.586532   77.5%     3013    841      72.1%
     1 32/16  0.250567  0.282339   12.7%    13670  11137      18.5%
     1 32/32  0.135351  0.148461    9.7%    25429  22320      12.2%
     1 64/2   0.555010  1.603776  189.0%     5001    837      83.3%
     1 64/32  0.123831  0.149639   20.8%    27674  22602      18.3%
     1 64/64  0.069122  0.076047   10.0%    51508  45138      12.4%
    64  8/2   1.044185  1.500468   43.7%     1528    851      44.3%
    64  8/4   0.802680  0.977700   21.8%     3178   2546      19.9%
    64  8/8   0.479748  0.555419   15.8%     6283   5635      10.3%
    64 32/2   0.861074  1.561266   81.3%     3063    849      72.3%
    64 32/16  0.234011  0.280027   19.7%    14332  11165      22.1%
    64 32/32  0.126145  0.148085   17.4%    27225  22613      16.9%
    64 64/2   0.530587  1.496179  182.0%     4377    826      81.1%
    64 64/32  0.121105  0.147943   22.2%    29286  22541      23.0%
    64 64/64  0.063626  0.077051   21.1%    56147  45520      18.9%
  1024  8/2   1.008693  1.358408   34.7%     1538    879      42.8%
  1024  8/4   0.785636  0.943545   20.1%     3280   2704      17.6%
  1024  8/8   0.448194  0.521765   16.4%     6678   6011      10.0%
  1024 32/2   0.840864  1.417311   68.6%     2756    859      68.8%
  1024 32/16  0.195786  0.247129   26.2%    16269  12639      22.3%
  1024 32/32  0.097978  0.122742   25.3%    35249  29273      17.0%
  1024 64/2   0.536947  1.400985  160.9%     4421    849      80.8%
  1024 64/32  0.093962  0.123383   31.3%    37425  29197      22.0%
  1024 64/64  0.045147  0.057867   28.2%    72626  59198      18.5%


Nikolay Aleksandrov (9):
  net: bridge: factor out common flood completion handling
  net: bridge: factor out port flooding
  net: bridge: vlan: cache the pvid vlan entry directly
  net: bridge: vlan: introduce a list of port-VLANs in the master VLAN
  net: bridge: consider only port-VLAN members when flooding
  net: bridge: vlan: use an RCU array for large flood sets
  net: bridge: introduce a forwarding destination structure
  net: bridge: avoid egress VLAN lookups when flooding
  net: bridge: avoid VLAN lookups for flood neighbour suppression

 net/bridge/br_arp_nd_proxy.c |  51 ++++---
 net/bridge/br_device.c       |   8 +-
 net/bridge/br_forward.c      | 272 ++++++++++++++++++++++-------------
 net/bridge/br_input.c        |   4 +-
 net/bridge/br_mst.c          |  13 +-
 net/bridge/br_private.h      |  59 +++++---
 net/bridge/br_vlan.c         | 155 ++++++++++++--------
 net/bridge/br_vlan_options.c |  12 +-
 8 files changed, 347 insertions(+), 227 deletions(-)

-- 
2.47.3

