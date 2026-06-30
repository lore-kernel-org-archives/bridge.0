Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D5F392C56
	for <bridge@lists.linux.dev>; Tue, 30 Jun 2026 06:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782802680; cv=none; b=tXN6HeRSu+1Zpbg+G/RJm4Tb2NzxoRXqioFSdJZGe2iKx/PDItNQkpxlA28RT1D31lO53SoylLifKoCbB0UvJfQO0sFLvxdjyQcjMHZ3TcMgyeLNkWjWkzpFQWJukglXTWr7RauOhUZe250qshJb2PBwLeZte5eRGG0sg69iYo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782802680; c=relaxed/simple;
	bh=AF8EzTYcmcfCcEiaIWGwus0xlZ0pc2RcYzxYiJaqerg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NQvBNhB8KY3Ig0ipWWAkHfDUaAzOdNf2W2j9QDAHNeIt/oh76zY+vkbs773V8t8Oq6RjKtSYNXfPsNDM1Wn9y8ErKuW+4NTatuUJkBQTOk4950SXGQHg84a9omE4wpNGoUxjrjKkTXHXoJNE3y9Z3Qiizk4M/m/K8obh3yVx5fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qdd72QOF; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdd72QOF"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4624a44e152so3788202f8f.2
        for <bridge@lists.linux.dev>; Mon, 29 Jun 2026 23:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782802677; x=1783407477; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wg2/qe+4da0BF+gj2Y7cJKdG+hCpLIZ0UIJ4logHsQY=;
        b=qdd72QOFpT0JMZb23JJT4B2V7gWk2JZfhENfyPGQdeDRTPKtCWf/d2P881Og4dyed3
         hUFPYCe51JDaK5wWED+lgdWEF51tLxRJPjWLOfL6o5m1dQR3hwdhuRIjpZ2usPYZAcOc
         Q0OfxJy+Z0eXCibwJfLHpGDPVjiWFxuQF26BFO7HeAae0fnz1YLjPv1kgLy0ogl2v/lb
         pbm5xkAWwPd9oqfg6+Tq+lrAlQfQtW8Wq5OwbdFzClpvDHPlG362d82J8thYrHRc4ldd
         Qp3tIcs6LIdip3oH/2xAHoKLs7LfYERaRlpLcLI9CxMJC7mjW6jwTf3ieMMYT+X9XtQD
         3uZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782802677; x=1783407477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wg2/qe+4da0BF+gj2Y7cJKdG+hCpLIZ0UIJ4logHsQY=;
        b=NZrxsEhfLSnKxfuL0Pv1aOUa/JguvPqy5qW/BcaGj9zEOiv7WCFbygs2QSijOtsUb0
         n9tICVwu7OHTERyDgRcUy+GNeS3kQwnyDU3DJi3txMtWT8xpB7fkDH+aCmp8D4LdnkAO
         CyDZ6uob1Tite+wdfoeZjkouDRZuKh+Jh9yxtP+kUvf6prKjHnwFCqBExqyYzCDG/Ota
         1c89Dgwgrl7Lo8jS44el5noIcRflnIdj0CmksiSuPXlEOCNvSBkMJ8YZxWKeUSzcyhBx
         16VcqhYCC3mcNPBJiGV+wtOk6N7uoZakp0VULpdUnGe8d6UKH25f/MYxO3jwbp2/4mbX
         iKCA==
X-Forwarded-Encrypted: i=1; AHgh+Rqu8at9w/wlCofGJiqtLrzjyXhoE4Lb+akKFte+1c21Fi7a5RyZnG5+JadrfZRnyuzce7ARP8U=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5CHEbDfC0kheUol/X0YujSB59qMemmLN376IIgjXgj0QFni73
	j1bIOVsW92YMxuctQrbz9qSPb85MV5dnkAf9Lw3lzvI6I2xT+zIkipUo
X-Gm-Gg: AfdE7cli8qjGnPVxS8vzz3VJwASU73DBN3pBodGLLecUWdWxPtwCcKO3x+SaER7Zt1j
	ypbiMIJ78UmzSryEb6/YWVI3MOzMVz/rrbCSbtDhAy/wvMrttyfoUPVgluUMq6cEPeFEhsWnk9P
	FxXiU3soBj8nuvo/BgMLnTjTyfIoa2A/LKfBniismBARJd59/iofF/sjvGiZYWrgw9hOHwK6z1d
	Cw+kuKZ21HUMoktxzsgU8yTYx72eXac73Uf+vk3lYN0AIutpq1pIv4pc7elonQ9Rc1Z2aNoAAOW
	Ms35eANrLC3T0tkC4975SyimW5/vFNctnlIaT8t6mbHHiIY/ljABroK6o/aaXoMWKwiIU7sUMlJ
	SNW6jgEx+PCL7qRzvh/MC4BQCDWyolnbw0mpQwMOxbuGOddPZjMRu5839w1eigKu/TQERX1VlVB
	cBzSWmg/o=
X-Received: by 2002:a05:6000:2dc4:b0:474:6a5b:85f8 with SMTP id ffacd0b85a97d-475506e98aemr3116459f8f.6.1782802676618;
        Mon, 29 Jun 2026 23:57:56 -0700 (PDT)
Received: from fedora ([46.205.218.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756636cf26sm4570949f8f.19.2026.06.29.23.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 23:57:56 -0700 (PDT)
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
Subject: [PATCH v2 0/5] netfilter: nf_flow_table_path: L2 bridge offload
Date: Tue, 30 Jun 2026 08:57:30 +0200
Message-ID: <20260630065735.3341614-1-pawlik.dan@gmail.com>
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

v2: Fix missing Returns: tags in kernel-doc comments for the three new
    bridge helpers (br_fdb_has_forwarding_entry_rcu,
    br_vlan_get_offload_info_rcu, br_vlan_is_enabled_rcu).

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
     and a dst leak fix. nft_flow_route() becomes a thin dispatcher.

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
 net/bridge/br_fdb.c                |  34 +++++
 net/bridge/br_vlan.c               |  47 +++++++
 net/core/dev.c                     |  32 +++--
 net/netfilter/nf_flow_table_path.c | 201 +++++++++++++++++++++++++++--
 6 files changed, 316 insertions(+), 23 deletions(-)

-- 
2.54.0

