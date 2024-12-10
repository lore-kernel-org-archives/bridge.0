Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B31278F23
	for <bridge@lists.linux.dev>; Tue, 10 Dec 2024 09:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823976; cv=none; b=uvX12EfIfD1ukAuzkYEwgVtIn524nK8sSejFNJ3wH2ZOPFSkWLb1tFasw4W41s4UMN18gm1kwzr/GHqkFEc3AUlJWzHqJ19WDXBSBHyVv6pA36pD3n3vGlTGIlsu8x8O5hEz949wnBKLV0dJx+5Zuw+qRZZbb0bBWxtMLh05FRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823976; c=relaxed/simple;
	bh=KeM3nCVomxM9bMY0OfFkkMpPTEaLh8sz1NtNJzSH1Tk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NnnGQhiggoi6dkZliB8gNwmrQyRTmW+EFmdb3GVazlJ1lCZ4L6pBTIkvv+cmVEVDYn10UjeZnDCOMvCs3i0RxuEPyupFhabQ5V8zUeUsVA/yMityLxCYO0YlZcqcbATmYGwOO3i0IBeuk8laMuQIEv6uzeVTUjHan1SY7Emhdq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzpUWkD2; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzpUWkD2"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3bbb0f09dso5496686a12.2
        for <bridge@lists.linux.dev>; Tue, 10 Dec 2024 01:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733823972; x=1734428772; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UocVRl+s36yfKdOwyD9w/O24SaGw6oRqRxZTrP2zIsQ=;
        b=NzpUWkD2lUAlPm9W7jv+j/3sr2JuFWT841UE/pzS3lPQc4iYRkdTprbn4wFHt1lIBK
         +WdDemNWU0sT0Q8v7cIQ/NAuiKz1E2RqUNUnphcX4blD6/RuP1wGIfVVSfRNSsqilKZx
         A3+AAm2g4NLTFoAzdnxgaXaMvGqInj35FIVwmituLcXc18HkMYtPt5fmNPuCiM8iTUnI
         o2ZiDNZ0OSG41mdVTtn9Ov/LEdj+9fvcMvlY71ghmsQnVhEgM1LHkfGWssgK3UCmyzdB
         3xOCAQG93iprnFSsLkJnUdszuIl0/l9OHd5u89wGNVCTUe9h0gNqm2T3vq1l+vNWLmI6
         j7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733823972; x=1734428772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UocVRl+s36yfKdOwyD9w/O24SaGw6oRqRxZTrP2zIsQ=;
        b=ezN/8OXtbrvs0SIo+RHNc8Ebb40WXRZWLkq/l6l0sLRq/Yrpl0Btptgt74k6RX2gHu
         ivfD6I30+wJS3VYR9tw77IzXLRvA7sJosfE/nzTLC4QFOAadfNfR97EVWnLjrF8arUXU
         vDXKC/MHqCGcSNWaDxDSOU9biTv+12KQRafxO99QJOwStYt8jNJexCBWUwGzLo2QhNjj
         cHb/UIKSZyIJZ4RZ0QPwNyUUBY0KVViNAU9p1nNJ0yQYu+266IWMV/6Fpkok+zCOKsGe
         nMadqzTHnc4k9aRdvI6/F1B6b4bM0T0R+rzx9zMO1BRHResriBqzFFZ6A8G0bplwgON5
         cvdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqAiHtDqp0s9f62UFRNdSDwKZYZOImkn6BCzpca7BcVCCddhAX64kfeGS2GKu8JzbXgl0ZQNs=@lists.linux.dev
X-Gm-Message-State: AOJu0YyyVJnWp3PpCg3SZN6FAz0N/lZNPg9S7LwALB7NXNJDCYFDzbdY
	IRgCMQcwDBOmdpWOTCSWOfwzJn2X3Floht0k2DeWfzfOVpBb0oxO/TZH8gXY
X-Gm-Gg: ASbGncuvlANQd1krxxOeQb/x2jNHFfIwA+T7Kk1HmKLkb8OEy9M4hEK5bzYrxlGXiPe
	rLF0QSPLZ4oDgYQdaUg8Lq5T+nbwWfgWyLfkmo8/TAyCYT+grrbhESLMTojP0WvgmVLaLSZUvdz
	/xjopk9nqPQElS2pRshse5ntu0eGWgH+B7eQXZkZK98//ObdaecgQ21O0G2K6JX9hYIXhHR7zTz
	IemAunG7F7Z3LMw92QsnMHgpUr2cnlgtK4AbfM7YlmIRAbAawWp1xlhhAeAWafqYcIyahJOmKro
	QLX6rAWdLMglPloxT6N/n5D/FU4kgnSQe4nLYzcySHtL12olkpFT/+qk2UhLZKVpsaEDro4=
X-Google-Smtp-Source: AGHT+IFCrrW6RNVZquoW/mErh5cCOuR46lfhdmTnJoE8ueHEeCps74gS5DZ/AuLUpkGnYzNZigdJOQ==
X-Received: by 2002:a05:6402:320d:b0:5d0:d91d:c195 with SMTP id 4fb4d7f45d1cf-5d3be73fd12mr15089760a12.32.1733823971640;
        Tue, 10 Dec 2024 01:46:11 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14b609e56sm7313936a12.40.2024.12.10.01.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:46:11 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Ivan Vecera <ivecera@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	David Ahern <dsahern@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Joe Damato <jdamato@fastly.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Frank Wunderlich" <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH RFC v3 net-next 00/13] bridge-fastpath and related improvements
Date: Tue, 10 Dec 2024 10:44:48 +0100
Message-ID: <20241210094501.3069-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset makes it possible to set up a software fastpath between
bridged interfaces. This also creates the possibility to have a hardware
offloaded fastpath between bridged interfaces.

To set up the fastpath with offloading, add this extra flowtable:

table bridge filter {
        flowtable fb {
                hook ingress priority filter
                devices = { lan0, lan1, lan2, lan3, lan4, wlan0, wlan1 }
                flags offload
        }
        chain forward {
                type filter hook forward priority filter; policy accept;
		ct state established flow add @fb
        }
}

Creating a separate fastpath for bridges.

         forward fastpath bypass
 .----------------------------------------.
/                                          \
|                        IP - forwarding    |
|                       /                \  v
|                      /                  wan ...
|                     /
|                     |
|                     |
|                   brlan.1
|                     |
|    +-------------------------------+
|    |           vlan 1              |
|    |                               |
|    |     brlan (vlan-filtering)    |
|    +---------------+               |
|    |  DSA-SWITCH   |               |
|    |               |    vlan 1     |
|    |               |      to       |
|    |   vlan 1      |   untagged    |
|    +---------------+---------------+
.         /                   \
 ------>lan0                 wlan1
        .  ^                 ^
        .  |                 |
        .  \_________________/
        .  bridge fastpath bypass
        .
        ^
     vlan 1 tagged packets

While testing direct transmit in the software forward-fastpath, it is
useful to enslave the wan interface to another bridge, brwan. This will
make sure both directions of the software forward-fastpath use direct
transmit.

To have the ability to handle xmit direct with outgoing encaps in the
bridge fastpass bypass, we need to be able to handle them without going
through vlan/pppoe devices. So I've applied, amended and squashed wenxu's
patchset. This patch also makes it possible to egress from vlan-filtering
brlan to lan0 with vlan tagged packets, if the bridge master port is doing
the vlan tagging, instead of the vlan-device. Without this patch, this is
not possible in the bridge-fastpath and also not in the forward-fastpath,
as seen in the figure above.

There are also some more fixes for filling in the forward path. These
fixes also apply to for the forward-fastpath. They include handling
DEV_PATH_MTK_WDMA in nft_dev_path_info(). There are now 2 patches for
avoiding ingress_vlans bit set for bridged dsa user ports and foreign
(dsa) ports.

Another patch introduces DEV_PATH_BR_VLAN_KEEP_HW, needed for the
bridge-fastpath only.

Conntrack bridge only tracks untagged and 802.1q. To make the bridge
fastpath experience more similar to the forward fastpath experience,
I've added double vlan, pppoe and pppoe-in-q tagged packets to bridge
conntrack and to bridge filter chain.

Note: While testing direct transmit in the software forward-fastpath,
without the capability of setting the offload flag, it is sometimes useful
to enslave the wan interface to another bridge, brwan. This will make
sure both directions of the software forward-fastpath use direct transmit,
which also happens when the offload flag is set.

I have send RFC v2 as I previously only owned a dsa device. I now have
obtained a switchdev supporting SWITCHDEV_OBJ_ID_PORT_VLAN, and found
there was more to do to handle the ingress_vlans bit and corresponding
vlan encap.

I am now sending RFC v3 as the previous RFC did not get any comment.

Changes in v3:
- Squashed the two 'port to port' patches to avoid build errors when only
   one of the two commits is applied.

Changes in v2:
- Introduce DEV_PATH_BR_VLAN_KEEP_HW for use in the bridge-fastpath only.
   It is needed for switchdevs supporting SWITCHDEV_OBJ_ID_PORT_VLAN.
- Different approach for handling BR_VLFLAG_ADDED_BY_SWITCHDEV in
   br_vlan_fill_forward_path_mode() for foreign devices. Introduce
   SWITCHDEV_F_NO_FOREIGN, BR_VLFLAG_TAGGING_BY_SWITCHDEV and
   br_switchdev_port_vlan_no_foreign_add(). The latter function can be
   used to make sure the vlan was added to a switchdev native device.
   When that fails, adding the vlan with br_switchdev_port_vlan_add()
   means it was added to a switchdev foreign device.
- Clear ingress_vlans bit and corresponding encap for dsa user ports.
- Add check for ingress_vlans bit to nft_dev_fill_bridge_path().
- Adapted cover letter description to make clear the patches apply
   to software fastpath, making hardware-offloaded fastpath possible.
- Fixed clang error for vlan_hdr * and struct ppp_hdr * by adding block.
- Updated !CONFIG_BRIDGE_VLAN_FILTERING version of
   br_vlan_fill_forward_path_pvid().
- Removed erroneous check netif_is_bridge_master(ctx->dev) from
   dev_fill_bridge_path().
- Cosmetic changes.

Eric Woudstra (13):
  netfilter: nf_flow_table_offload: Add nf_flow_encap_push() for xmit
    direct
  netfilter: bridge: Add conntrack double vlan and pppoe
  netfilter: nft_chain_filter: Add bridge double vlan and pppoe
  bridge: Add filling forward path from port to port
  net: core: dev: Add dev_fill_bridge_path()
  netfilter :nf_flow_table_offload: Add nf_flow_rule_bridge()
  netfilter: nf_flow_table_inet: Add nf_flowtable_type flowtable_bridge
  netfilter: nft_flow_offload: Add NFPROTO_BRIDGE to validate
  netfilter: nft_flow_offload: Add DEV_PATH_MTK_WDMA to
    nft_dev_path_info()
  netfilter: nft_flow_offload: No ingress_vlan forward info for dsa user
    port
  bridge: No DEV_PATH_BR_VLAN_UNTAG_HW for dsa foreign
  bridge: Introduce DEV_PATH_BR_VLAN_KEEP_HW for bridge-fastpath
  netfilter: nft_flow_offload: Add bridgeflow to nft_flow_offload_eval()

 include/linux/netdevice.h                  |   3 +
 include/net/netfilter/nf_flow_table.h      |   3 +
 include/net/switchdev.h                    |   1 +
 net/bridge/br_device.c                     |  23 ++-
 net/bridge/br_private.h                    |   5 +
 net/bridge/br_switchdev.c                  |  15 ++
 net/bridge/br_vlan.c                       |  29 +++-
 net/bridge/netfilter/nf_conntrack_bridge.c |  88 +++++++++--
 net/core/dev.c                             |  66 ++++++--
 net/netfilter/nf_flow_table_inet.c         |  13 ++
 net/netfilter/nf_flow_table_ip.c           |  96 +++++++++++-
 net/netfilter/nf_flow_table_offload.c      |  13 ++
 net/netfilter/nft_chain_filter.c           |  20 ++-
 net/netfilter/nft_flow_offload.c           | 166 +++++++++++++++++++--
 net/switchdev/switchdev.c                  |   2 +-
 15 files changed, 490 insertions(+), 53 deletions(-)

-- 
2.47.1

