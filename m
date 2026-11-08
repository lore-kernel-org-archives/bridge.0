Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794153227;
	b=Ua6wXYTUliXU10feLDNxm+pjm3B7C7jr49zG5hFDqtT4ecyhouCPwQ1WP6JeNRAUDU7C
	 8q0c648QDyv0+SCEGDHfIPhkX3O8XQ2B0ipFvxZ/LA5DTO1kT6urXBErDnNdRDsdsMy43
	 KNrN2K2ufvV9DG3gti7xJk727BvFck+4tv46uQbeTOf4c18NYh0DfuI5uWKSaVCk7oz+D
	 Xplw6sF/CQzYC+2KCrEjFuutOloWQ8ZK1FtPb1NMjHiMzH6vUl8nuOJ+hwrBK/F+QrYyK
	 hnW019Pzi+HHdm7jyRwHHkMnLCC4E1EIK/SfT7O4kJo717lCyX00DezPPiu//wMDN1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794153227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=K8tG0sBF7Y5GlP51WViElxhrHpfyEqUrzO/fBUEmVg8=;
	b=Q9dPKQkIP9xCuEwtZLSKNpoobi4/HCC4joHFKtcK1Qfiu0HAL9JYeu9tNQHiqi/I0gWm
	 JMnRWhnqlrg5SxeJdmQ6koE5ym9hoRtHTg/HisL7eMndCY9mTMniPIQR3c2ixUa1HE9X/
	 OB6AyGoaCirH4eXpd/UI4RyIDj62H4RS1HQWOkY5OonvCMdNxidniG5xTU4yUkqaJvzb/
	 NQFB5BjFTeAarQDt5XQIA01yMOYtX+hHEyghBBVvOvthKLk4MXTM3RBMmq3y4ZLCI60EE
	 WUGX1v5IDH98aZCNcj5m8k9cybyNP0vxsZvFvdP3V0QHX78E5G76WZDoO/esKpyT3jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=oIRd0PSt;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69905606A321
	for <bridge@lists.linux.dev>; Sun,  8 Nov 2026 15:53:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69905606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=oIRd0PSt
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c45551fa84eso19289166b.3
        for <bridge@lists.linux.dev>; Sun, 08 Nov 2026 07:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1794153225; x=1794758025; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=K8tG0sBF7Y5GlP51WViElxhrHpfyEqUrzO/fBUEmVg8=;
        b=oIRd0PStSlFIPP+xJ/tnDf9zsjN8yYf9mfoocPt3KwvjILEgjz60hkoXGWaTYofLwo
         HiQgUdBF5qtmqTWIXfamB0tKvOJvWSZK2+f41KVhZse4SeanevvajBLLrJpbSVcfgpvX
         /hupVCz5SI4QoDlzIS9atm8aBb+zg/9OiSoU20exrvIqI05uVw21oisgKB2ZLwT7wSbP
         dMXvz4WUcNa6kzXG6HxZZMwi9PUkMs9AzvqPlYCPPMH7hYyreBB//iWS7eDESJeYricB
         Gq0rTTdGw44Y3Nj62wsXbMwedwYnhMow1ep8aSaw+4UOPTBLgXLhANwJRj8GWd7ecD/0
         wxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794153225; x=1794758025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K8tG0sBF7Y5GlP51WViElxhrHpfyEqUrzO/fBUEmVg8=;
        b=nf4bmi8m83CSeGwfO9s8OcJyEFTHAbaIr+oU97SpMZYPh/vOEbGXkF+KKIh215FcCP
         YptUjaw+B6joAQaTaUzChHwh+iQnHpc7ZbJHvQTMcNw4SU1az2KcEEv2eI8jQVrDkSv7
         NX2skf5lA7VS+L4OvLOKFBCozK3fulP16eed9mewpaPaV4rmgGP22y8rnbFyE1Rf/coi
         obqfKE9VkXn9dtACtCK1kyjCqI5kDgBVGf0leJiXmObVFhXfgGKfTqzkatSxs7NSt70u
         cZtRffxFG7mH1uAeSOsFbt5cqjPH1MS5h8GdFLLV9MtxDaO0EP8YHuI4hNJyuVE6KEda
         oOWQ==
X-Forwarded-Encrypted: i=1; AL+hErH70a1vPNFhyb03KhwuSxI/ysegkFQr3oxmE3bbzDndWP1aeDNdfjBWQAs/pBjKwzpU1ZX4UYw=@lists.linux.dev
X-Gm-Message-State: APuU4Z+pHvkDeQyknWxSDjDVcukGvzkeZzVfHUsknfZoQWl8JeXbcy5w
	O+bUAAFjhjm9d5fYhZW4ng86RJyLkiodae3zlR+nZX3LIKc8G5jYBCtRh86aiNWvZQ==
X-Gm-Gg: AYBFou0kw2Iynqgy6GUhFXev1ds2fxv7zXNrzvAk8KbhsvYyvBk4kjetR7co7tSd/sO
	dd2k7OfC/uz/VBfU5qsJMgTyvwqqtniNMkSTJeAvuAVOqW2nAw4r2kc+JUbNlvK4UvjYnDRZku5
	e3uykQWQqMfsDgwt3Ygw3J+m7w9PlOrgUGkMiZBhEhvsmwSyM5VmSr6RyMDEaU3B7h8oAI4Dylv
	dbrY9DTW6dqAlnhhYxH7Og8zPWJSl12q2Lh7es3tfISl1ZtTmdrvG3W9ZA/XMaiyyu0Gj4LdUqq
	MJY1VPdV0tsfnZiePvmeLvOf6euOKQr1N4J8wuiKSFjYX401ir3uHUzfIwWgVwf8a8NxhsODYXO
	GUW0lTq5J+tAqhyS11yAclgvnfGxNjqN6PpJIBFWz8n/GDjzd3O2Q10vc3X2lLxMAVmJuuEUcAy
	2wtl8utHcZS3H9P9rZbthh4kKdqlqAfc30+6+QtfVc0+3FTkESdhCkvfefcgf+idkClNX3T0xxJ
	wrTdHHczAtga12VKmXSN1RzVccYVNOjopylbB6oKWZbUYDdPeDGHj4Jgc7wD+0F+mRE8HE1nONt
	whUf6axMsGqMfOBR4FyS2UoN+Y13Ex9bwuw3tj5Am32T9yFAqSqL4B7srcWhbUhr7mudoeC0P6t
	HEKgZZwUPipfQnJGcSQockT4PqxBFAiZVzdMDjcMqWBBXLIawZdSzbtORLjSjXhKKKxeUz9EznL
	3puPCu53HK/B+mR7vdeuJogjwWhAEfExhgwz2Z/HlNX+Zo1uU+UNGs/9gCY9J3Fs/3r60vQWzhZ
	9Lq3UGJyP6tsdpzNJRJAJkOagz7ELs4LwGw+O26XiLCCX6pk5OxM+JLq6cXH5QwitHL30i+9KQs
	RtKuG/bO92D00SS33Os=
X-Received: by 2002:a17:907:3e82:b0:c2d:bf61:24d1 with SMTP id a640c23a62f3a-c4d6d1aefcamr131880266b.1.1794153224347;
        Sun, 08 Nov 2026 07:53:44 -0800 (PST)
Received: from Desktop (p54aff56f.dip0.t-ipconnect.de. [84.175.245.111])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d68d52f4bsm71648166b.8.2026.11.08.07.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 07:53:43 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Eric Woudstra <ericwouds@gmail.com>,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev
Subject: [PATCH nf-next v9 0/2] netfilter: flowtable: tear down bridged flows on layer 2 roaming
Date: Sun,  8 Nov 2026 16:53:42 +0100
Message-ID: <20261108155344.35845-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A flowtable flow that transmits straight to a bridge port keeps sending
to the old port when the host moves to another port, for example a
Wi-Fi station roaming between access points.

Patch 1 makes the gc tear such a flow down. It is Pablo's patch with my
changes on top: it keeps his authorship, his Signed-off-by from his
posting and a note of what I changed, instead of the Co-developed-by
that v7 had. Patch 2 adds selftest cases.

The flow caches nothing about the bridge. The gc finds the bridge port
from out.ifidx through the vlan devices of the path and the bridge from
the port, and the tuple gains three bitfield members in free bits:
bridge_path (from Pablo's patch), bridge_vlan (the flag Pablo
suggested on v7) and port_vlans. struct flow_offload stays at 296 bytes
on x86_64.

Tested on nf-next 734bef548a96 in an x86_64 guest: nft_flowtable.sh
passes five runs out of five, two of them with PROVE_LOCKING, including
all twelve roaming cases in both of its passes, with no lockdep splat.
Without the port_vlans reset, the new stacked bridge case fails and the
other cases pass. net/netfilter and net/bridge build without warnings
with W=1 (x86_64 allmodconfig).

I used Claude (Anthropic) to help write these patches.

Changes in v9:
- reset port_vlans at each bridge in the forward path, so the gc checks
  the bridge the flow transmits on: with a vlan device of one bridge
  enslaved to another, v8 counted the vlans below both bridges, looked
  up the bridge port from the wrong device and read past encap[]
  (Sashiko)
- selftest: a bridge port that is a vlan device of another bridge
- selftest: the roaming cases give socat five times SOCAT_TIMEOUT, as
  roam_stop() ends it; on a loaded host a case took 109 s and the 60 s
  timeout ended the transfer before the check
- authorship: Pablo's patch is credited as such, with his sign-off
  from his posting and a note of my changes, instead of
  Co-developed-by; his paragraph on the switchdev notifier alternative
  is back in the commit message
- rebased onto current nf-next

Changes in v8:
- drop bridge_ifidx and bridge_vid (Pablo): the bridge port is found
  from out.ifidx through the vlan devices below the port, the vid comes
  from the encap stack (bridge_vlan bit) or is the pvid of an untagged
  port of a vlan_filtering bridge
- the fdb check sits in nf_flow_dst_valid() next to
  nf_flow_dst_check(), the hook is fdb_valid_dst() again, and the
  comments Pablo pointed out are gone

v8: https://lore.kernel.org/netfilter-devel/20261017235849.1066624-1-julius@bairaktaris.de/
v7: https://lore.kernel.org/netfilter-devel/20261014235628.197976-1-julius@bairaktaris.de/
v6: https://lore.kernel.org/netfilter-devel/20261004171605.3544792-1-julius@bairaktaris.de/
v5: https://lore.kernel.org/netfilter-devel/20260914072541.897040-1-julius@bairaktaris.de/
Pablo's patch: https://lore.kernel.org/netfilter-devel/20261014210256.1573072-1-pablo@netfilter.org/

Julius Bairaktaris (1):
  selftests: netfilter: nft_flowtable.sh: roam a host between two bridge
    ports

Pablo Neira Ayuso (1):
  netfilter: flowtable: tear down direct xmit flows when the fdb entry
    moves

 include/linux/netfilter.h                     |   7 +
 include/net/netfilter/nf_flow_table.h         |   8 +-
 net/bridge/Makefile                           |   2 +
 net/bridge/br.c                               |   2 +
 net/bridge/br_nf_utils.c                      |  38 +++
 net/bridge/br_private.h                       |  13 +
 net/netfilter/core.c                          |   3 +
 net/netfilter/nf_flow_table_core.c            |  45 +++-
 net/netfilter/nf_flow_table_path.c            |  20 +-
 .../selftests/net/netfilter/nft_flowtable.sh  | 251 ++++++++++++++++++
 10 files changed, 384 insertions(+), 5 deletions(-)
 create mode 100644 net/bridge/br_nf_utils.c


base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
-- 
2.53.0

