Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD9740627B
	for <bridge@lists.linux.dev>; Mon, 29 Jun 2026 12:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782736388; cv=none; b=kCBDHz2sQqJOaP0QfGtQEnHNwL5CIw78P+kBG8/pe2Lq1CruFPSIf4URt0IURhr3rtvBxQdT6C+UxUA4ypot9MtaNcN0FbQstS9x2+b46qJWjeuERHAKz3qOXblguZ+ufYNu1i+TZvbZyhkYxvgEWm91NsyAi9HgTmlONwJXu90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782736388; c=relaxed/simple;
	bh=mM7T15Z9HB8xLCpzDyCHSZPcHgPKPfrCug4yAJDcmQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E3mpT+dMZljhqMl+dp2h3liqdLKUD/L5F0Lu628UcEawMuB1bD0LcsKOIYPTO3OQ0iFkhHuOpR7/MM8Hk9xz2B38c8/0DrOybvTQug/iEXiWyhtKU82iYXuYONMs73hnO5WjRIw9UBiW/k1GfawnQsIp5ir6BUlfXeo0uGHUW+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Whef3Mt4; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Whef3Mt4"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c12620ed112so127050966b.3
        for <bridge@lists.linux.dev>; Mon, 29 Jun 2026 05:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782736385; x=1783341185; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W6yfFGpGsowdA7nocV8Q2ZeGgDt/heljVkQt2pc3Sqk=;
        b=Whef3Mt4ylbhvBgAYKBd8W4fetF+oJ8WHHaqIk8r6Hi7d5zxtyCyQAzsOF/59mf13d
         t7InlZzLq3WsyROnBykp3kAl5SJeFUzz4bOvumrVohmBsUMLB2wGl18JUEctyyybcU7c
         0AiX3REKM73VY+dzPawbg2PtIjAoTj1Y4prOwHs20DvZD8YRpKmHaMwhtbQw33H/W8ek
         GQaee/zByoFvnZHqZ/BceVOJjTkV/oROy1fOvsd4l7IuN/g78mSupXmKWBgJAJ2V2W2u
         G1phmwbGRCKhIQtBJr8mHGk4nipCjpVElshk/1A1PkgWZE05eAeQWuraJ3J16fN5hwVi
         zJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782736385; x=1783341185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6yfFGpGsowdA7nocV8Q2ZeGgDt/heljVkQt2pc3Sqk=;
        b=K5xxGnpA4M+lpqjRZFUprwex4G+V1RfnxGW9CWsdbkUqHC2c0g6Th3cPkKigskpzeA
         3T4ORg79BkzGSZ+lY2K7yQ+KHtbGeWoKltb8TrrRpBMLQGrhHujzDxnTGpSO5eXfL7Wg
         qJxKnWyAE3/sctE6JwgfFUDo/7AGbvqVwLA+j5epEvmZw2virrWzqmnzvwiYp50H6p6h
         cQwotu0CS6CUcJD0wkXFTDHTAO00nPlttBtvMDVtrjSdCo8izbAQaoNMvuDW6XbuFjVt
         cs3bUW5STqB+P0uLb8WxWBJDmbSmpvKizxjNR5H4R1h3J1f0LQJdLZ2/dGYNmC+YkwgR
         y3FA==
X-Forwarded-Encrypted: i=1; AHgh+RqNw9U3dRuRjdr4ntBKFXLUuCbadq1eR1B4y4hQn6XZRBTajBSJj7Tf/pktR1YYoo63+LEVLWA=@lists.linux.dev
X-Gm-Message-State: AOJu0YzL871KYfvq5TbB8T3yLyL1aXGwZypldVrbOJw8gZgybXhvNZmr
	SsHr8cH8JHnySSqNJa0mGoO4WIrohIpnDKRaAbOWLulTHCvMXPxOjsuf
X-Gm-Gg: AfdE7ckFTSRqsvlkagBZftx2wSIGlUNeqSlqrounlcg2QCZQqBXSODH1lm2W8WvU/ZE
	yCG1kCXTowqb7enm8HanxD5FQ5za1hagfZYcHiibb9mz6uSmbzuv2s3jDC1LC3jMx84HT6hikpO
	bwWdIbaTvWeHdDfr44xpNxpzk2WldNxcSaLbhNXA604Ja6nOnMs/o3zmn3zex5cVbEzehyWZJd8
	fmT6fs5XM8poOxmLrmmpuOgUpV0F754n2TZQM0/O7qQs+Bdo7WXD4et+wZrQcNG57pSntXycrSo
	p3SJGCo7Uflat+caXIVpawtHelWckwJdz8QhwBSCQeqx2gNGRbhWdNZXC4ijLOsFB6hKTuR8Vjb
	Y6n5auBymReqJN0wd/sB9P58PAy32Ul3oWj5ulIpCUm8YSjy/O+AxMR1rg7yJsq7VCxEtcCyizq
	RKLgjVkfs=
X-Received: by 2002:a17:906:f116:b0:c12:2b66:352b with SMTP id a640c23a62f3a-c123342a062mr351983366b.5.1782736384619;
        Mon, 29 Jun 2026 05:33:04 -0700 (PDT)
Received: from fedora ([46.205.218.111])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbe05c22sm773866566b.39.2026.06.29.05.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 05:33:04 -0700 (PDT)
From: Daniel Pawlik <pawlik.dan@gmail.com>
To: netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	razor@blackwall.org,
	idosch@nvidia.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	bridge@lists.linux.dev,
	coreteam@netfilter.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	rchen14b@gmail.com,
	lorenzo@kernel.org,
	Daniel Pawlik <pawlik.dan@gmail.com>
Subject: [PATCH 0/5] netfilter: nf_flow_table_path: L2 bridge offload
Date: Mon, 29 Jun 2026 14:32:48 +0200
Message-ID: <20260629123253.1912621-1-pawlik.dan@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds L2 bridge offload support to nft_flow_offload, allowing
bridged IPv4/IPv6 flows to be accelerated by the flowtable fast path
without requiring L3 routing.

Background
----------
Hardware flow offload engines (e.g. MediaTek PPE) can accelerate bridged
traffic but require that nft_flow_offload detect and handle bridged flows
differently from routed ones: no routing table lookup, MAC addresses from
the Ethernet header, and VLAN context pre-populated from the bridge port.

Patches
-------
1/5  net: export __dev_fill_forward_path
     Refactors dev_fill_forward_path() to expose __dev_fill_forward_path()
     which accepts a caller-supplied net_device_path_ctx, needed to
     pre-populate VLAN state before the forward path walk.

2/5  net: bridge: add flow offload helpers
     Adds br_fdb_has_forwarding_entry_rcu(), br_vlan_get_offload_info_rcu()
     and br_vlan_is_enabled_rcu() to expose bridge state to nft_flow_offload
     without requiring inclusion of net/bridge/br_private.h.

3/5  netfilter: nf_flow_table_path: add L2 bridge offload
     Core of the series. Adds nft_flow_offload_is_bridging() detection,
     nft_flow_route_bridging() which avoids nf_route() (fails for
     bridged-only subnets), MAC/VLAN pre-population for bridged flows,
     and a dst leak fix (allocation references in dsts[] were never
     released after nft_default_forward_path() transferred ownership).
     nft_flow_route() becomes a thin dispatcher.

4/5  netfilter: nf_flow_table_path: handle DEV_PATH_MTK_WDMA in path info
     Fixes zero-source-MAC in PPE entries when a bridged flow traverses
     MT7996/MT7915 WiFi WDMA hardware.

5/5  netfilter: nf_flow_table_path: add VLAN passthrough support
     Records VLAN encap info for passthrough-mode bridge ports so hardware
     offload entries include the correct VLAN tag.

Rebase note
-----------
Originally developed against OpenWrt pending-6.18 patches by Ryan Chen
<rchen14b@gmail.com> and Bo-Cun Chen <bc-bocun.chen@mediatek.com>.
Rebased to current upstream: path discovery infrastructure moved to
nf_flow_table_path.c in commit 93d7a7ed0734 ("netfilter: flowtable: move
path discovery infrastructure to its own file"), so all netfilter changes
now land in that file rather than nft_flow_offload.c.

How to enable bridge offload
-----------------------------
1. Load kmod-br-netfilter so that bridged IP traffic traverses the
   netfilter forward chain.

2. Enable netfilter hooks on the bridge:
     echo 1 > /sys/class/net/<br>/bridge/nf_call_iptables
     echo 1 > /sys/class/net/<br>/bridge/nf_call_ip6tables

3. Register bridge member interfaces in the nft flowtable:
     table inet filter {
         flowtable f {
             hook ingress priority filter
             devices = { eth0, wlan0 }
         }
         chain forward {
             type filter hook forward priority filter
             meta l4proto { tcp, udp } flow add @f
         }
     }

Daniel Pawlik (1):
  net: bridge: add flow offload helpers

Ryan Chen (4):
  net: export __dev_fill_forward_path
  netfilter: nf_flow_table_path: add L2 bridge offload
  netfilter: nf_flow_table_path: handle DEV_PATH_MTK_WDMA in path info
  netfilter: nf_flow_table_path: add VLAN passthrough support

 include/linux/if_bridge.h          |  23 ++++
 include/linux/netdevice.h          |   2 +
 net/bridge/br_fdb.c                |  32 +++++
 net/bridge/br_vlan.c               |  45 +++++++
 net/core/dev.c                     |  32 +++--
 net/netfilter/nf_flow_table_path.c | 201 +++++++++++++++++++++++++++--
 6 files changed, 312 insertions(+), 23 deletions(-)

-- 
2.54.0

