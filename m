Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2110E483816
	for <bridge@lists.linux.dev>; Sat, 17 Oct 2026 23:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792281538; cv=none; b=QvUbLYMN/wS/NVsBe2fBkhtoevEjr80fHC/q0OuTXKqbLoQzyXqhaNuu7XNUKEreffeHTo/cc7VIQAUaftek43Z0a8DkOiQz3L8CVTEZv0djQKirUatq8UB+G0ZdbqvVOVKCbPZGo0mDuPGPQmrqH31lerPLJ7eMjhrdZyep+z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792281538; c=relaxed/simple;
	bh=rOpiqxy5Hwt3SE0e9vZaPQFw0gt21K2h6bHhN6d7H3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kn0sxgAEeoMfS3AXL6ymvPaN+dRquWCrrwpsyqhPfTdX1CXoP8ZKszRBEgrRoiATc8pqs1aI75s9/6NLjlCeVvF0+glfzcU5UkEcEN6zztmco2BBr9G3hLhxr4VlavUXDQCi2qkOV6Yfxo6AoJfKEpMV66QEcSF/rHBWLyZsLLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=DnGisyEB; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="DnGisyEB"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c414e5d282eso112513866b.1
        for <bridge@lists.linux.dev>; Sat, 17 Oct 2026 16:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1792281535; x=1792886335; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5Sz/9HECOnKqBct7vdatnd4ZGB8n4Dp//SRsM9tOgzQ=;
        b=DnGisyEBp8U/2s5drB4Cp7ltsohlwtswZQNGMwIu3lLrreJa5TUxqhVLftlZCqJgRF
         jJNEj55HEt6hUpeY6veU2AdfCwEgrm638xAE6AWbT67mRsbRY0TyNPYB7vITKNARMlbw
         OK8aH86uCa8sAUhbTUUoBhP4MYLAKCUab5SG/EYkQvyAxXOLRyWiMxPbg2jQVY6Lfwtf
         iSPxj7VvVUboEJ6kb/xy+xkklEdU6hKaLFJAhUS8M1wUOzp/jWlPhXMGA4avz3qjSede
         1CDWvAIa0jWJF0y+jvKzhAFCeSWQkcORvhY/6S2qVWaWLA6y29qJBiXttL3dzhH7REaj
         Sq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792281535; x=1792886335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Sz/9HECOnKqBct7vdatnd4ZGB8n4Dp//SRsM9tOgzQ=;
        b=KAAoatVssoSD6syj0VH6vp3HzTzMj08+88CsmHdc+ITvGqrTAtDUwpz0e9wTNaaEK7
         IMisWrjj1JDqoRbPbhqGYO4E/LXqyoDu59ShBESZAd3t3+EmpNFXFxsD3v6fOveNWBAN
         v4dkSvaYKohEj4IVT998xq+dNiqClZdPoV9O83lt6aAAD1HOvCDSIoAyjcTW2u7TgYJT
         fzuarZmL81ibejhR2P6MSFWAnfvi2f/9ZmS5ftg+YekE9DuM1swiaxpV8HEdWrZIdi0k
         JKe/wMRgM+jwyvA2p2yvrhnIoLnksRlH2uBN3UWT9BJGHywnjfY63/ewbLb2WThkWtMl
         eVuQ==
X-Forwarded-Encrypted: i=1; AKwUvBzD6/7Hwpfosq2cEc4Y7fqymnNhGKVrUCY6aoIBzT4GyLPKBIXyheg45vqXRP6AveOD0mbMgTA=@lists.linux.dev
X-Gm-Message-State: AFq9FYL4W8psNWhVN9EDGMibEuh6IgUvW7ShnAxPapxbLUBCv5pPxE/s
	FO9qgaDJPJ2AhzFs5fcxr0F26CWOfJL72+fe6/SysKpSb5nXFf3m5rRFUQ71MusMtg==
X-Gm-Gg: AYBFou1oLesiTHfwLI4/j7kPRkGXOq5opvYtxDwUiHZjc824+a+yfvZnuRiHxbsBkEw
	Xd+tGi3/i8Utobb6GSS1gfJCZfWAtkKPWPjgfs9uNvsXQybsXCG9MazdaEkW2xnEb5T6gGSjna7
	D7myVl+f9ny/2i8VGYB+RrIoW6YyCFV+9m+gy0rB0HyL6xB12stfUYlsCFJ5kpyB531/vkOpBwE
	7trHwQ8yijdhmmFpm4qbl3piTFxBdyIpzkgXvHS7c+6Bmo+bIEW19S7/r3RZdy3w2U6E4uyOT0q
	IPmNeszG0ZbP3FAdKk7I5ddJtm00qhdJEODIdLw/w0oO5Xwt3hXKNxIsr99M9JyNsD6QHgarEWz
	DfHRFmfQxPXGEpcdUF/jhGqAZmmIVE/Xq/BFOxz+KxdhewJf47GH7ai/KAvJ82WEYZ5CMUYYJV+
	GgRP9svH26go8+D5OZWCPypt4WkAZ3GZKXDqq9pUbGGQnebZgmEa9gHfYp1UeMgxojNcF5u+/7L
	bpK6TY8UvvMEMiBgSt83bQTK2M8mQLtFhbeAzYidPt4jB8dbFFUXzC4dglxQ2hQGtwh1A2Hs64a
	eeUG6ynul1xX095YxaMpbs5WokevP+s2YjI5H3HlxeNhyeX1B79lVTX+RnTJ59ovF+eISj641Sj
	hXv6OjqJuXX6Va7dR/LRmxaAPRppul5kXqxQRZ1sW9dAibCfpGwuW3VacKjTkS5+FFxx29wSCvh
	88CLJmB9BMB3GczDJAo4I3F7WWasIvasn5swc9/DEAaRCAddP/GfC3hlTjP7lKsFZjT8U=
X-Received: by 2002:a17:907:944a:b0:c2a:ef15:2be0 with SMTP id a640c23a62f3a-c419e73e10emr273217766b.24.1792281534993;
        Sat, 17 Oct 2026 16:58:54 -0700 (PDT)
Received: from Desktop.fritz.box (p200300f24741261000ca3161c2b9b67f.dip0.t-ipconnect.de. [2003:f2:4741:2610:ca:3161:c2b9:b67f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c408e328780sm216534166b.6.2026.10.17.16.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 16:58:53 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	kadlec@netfilter.org,
	phil@nwl.cc,
	horms@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	razor@blackwall.org,
	idosch@nvidia.com,
	ericwouds@gmail.com,
	dqfext@gmail.com,
	netdev@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kselftest@vger.kernel.org,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH nf-next v8 0/2] netfilter: flowtable: tear down bridged flows on layer 2 roaming
Date: Sun, 18 Oct 2026 01:58:46 +0200
Message-ID: <20261017235849.1066624-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A flowtable flow that transmits straight to a bridge port keeps sending
to the old port when the host moves to another port, for example a
Wi-Fi station roaming between access points.

Patch 1 makes the gc tear such a flow down, using the bridge fdb lookup
from Pablo's patch. Patch 2 adds selftest cases.

Tested on nf-next a5e7d8e446af in an x86 guest with PROVE_LOCKING:
nft_flowtable.sh passes, including all eleven roaming cases, with no
lockdep splat. A kprobe on flow_offload_teardown sees no teardown of
the test flow during 10 s of steady traffic in any case. struct
flow_offload stays at 296 bytes on x86_64.

Changes in v8:
- drop bridge_ifidx and bridge_vid (Pablo): the bridge port is found
  from out.ifidx through the vlan devices the forward path has below
  the port (new port_vlans field), the vid comes from the encap stack
  (new bridge_vlan bit) or is the pvid of the port for an untagged port
  of a vlan_filtering bridge
- move the fdb check into nf_flow_dst_valid() next to
  nf_flow_dst_check(), and name the hook fdb_valid_dst() again (Pablo);
  it now takes the bridge port device instead of net and ifindex
- drop the comments Pablo pointed out
- selftest: vlan_filtering with tagged plain and vlan ports, the router
  address on a vlan device on the bridge, and vlan ports whose real
  devices are ports of another bridge; no forward chain packet is
  allowed once the flow is offloaded again

v7: https://lore.kernel.org/netfilter-devel/20261014235628.197976-1-julius@bairaktaris.de/
v6: https://lore.kernel.org/netfilter-devel/20261004171605.3544792-1-julius@bairaktaris.de/
Pablo's patch: https://lore.kernel.org/netfilter-devel/20261014210256.1573072-1-pablo@netfilter.org/

Julius Bairaktaris (2):
  netfilter: flowtable: tear down direct xmit flows when the fdb entry
    moves
  selftests: netfilter: nft_flowtable.sh: roam a host between two bridge
    ports

 include/linux/netfilter.h                     |   7 +
 include/net/netfilter/nf_flow_table.h         |   8 +-
 net/bridge/Makefile                           |   2 +
 net/bridge/br.c                               |   2 +
 net/bridge/br_nf_utils.c                      |  38 +++
 net/bridge/br_private.h                       |  13 +
 net/netfilter/core.c                          |   3 +
 net/netfilter/nf_flow_table_core.c            |  45 +++-
 net/netfilter/nf_flow_table_path.c            |  19 +-
 .../selftests/net/netfilter/nft_flowtable.sh  | 239 ++++++++++++++++++
 10 files changed, 371 insertions(+), 5 deletions(-)
 create mode 100644 net/bridge/br_nf_utils.c


base-commit: a5e7d8e446af9803e37a3b6a4d416fb41178348f
-- 
2.53.0

