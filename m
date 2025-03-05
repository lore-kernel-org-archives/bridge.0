Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0DA20764A
	for <bridge@lists.linux.dev>; Wed,  5 Mar 2025 10:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170606; cv=none; b=d3ey6LP5N/blOC/ltpZA5c6pZFtwWUBFtyV6xV6MCE6PJI22IBa4rQLfNombAFZgllW4WNoFsnwgvV2yor5Zwoq9QFsnv72cjFIH+A1BdjkcoAcMUrvL0eGzRAf1iuOp03urA+da4dWBvtCDfb+2MqSf371IhY4wExC8dGbfWfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170606; c=relaxed/simple;
	bh=B4lHCixB5/kv3w+j2VP5bFx9obnTAvFYkuUSOEerqWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XgUKWaJvsyIyyShGu1x+qLL8FllQr8CzetpECAtH/f6Znxkwbv04jkTnZkwnuS4V5H5m2WyRmHjR5HyKUFWysvdh32atdnSjn2h7hz3hgUZmGzJsd4wOnfd7THgRROvrzfPDwN2WJXTQ0EQr5zCA1kl8Vk6uEspu6s3+Jmh6aOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Be5ZO/Fx; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Be5ZO/Fx"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abfe7b5fbe8so439031766b.0
        for <bridge@lists.linux.dev>; Wed, 05 Mar 2025 02:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741170602; x=1741775402; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6sanML2Dhh94iBJereFlvYHp/47BSYsKw+xHcTZ++gc=;
        b=Be5ZO/Fxi5hVZEQu+3dlnAx+5nm3kWmboIf47ChdU+wFXXSNrZOugbOzV7rbGTuk83
         sIegkV5/TwV8GY+Y/HGw0HE70h0sYFCWTr8RBKi/VsxYxpD5/Qdx9iQoZWXoH7JoKY+P
         bc2VZyZ9C8sSVHSpQ9+T9Fqw9uoliSNrTjAV2VkABQ9eNZqKw/h8QvsbgwNuz+ewiEci
         fByXCVjXET0ZZPh1nYayXeWSQDceQ0kXT587bopNH/1B9uCqKys8Ws2vxKAFO5FVj2uJ
         FUL1LOT1ZxTh8RNMfTHeEzDPNfQPNgBvoaVxqyJBZHo/sz9pcT1qGxJs7IOCuVWhmPF2
         bwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741170602; x=1741775402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6sanML2Dhh94iBJereFlvYHp/47BSYsKw+xHcTZ++gc=;
        b=tujGH+0KD0fiKWmq/lmdBj3VMaQBa5eVUw//Ay36AX9geCdWHjRrIzjxSgmJ8kEuhV
         8hqfXKzehs74uGA0zwb9tsxUryAXPmxBCPqU1iMoGZ57iqVYmI2KhWgitJSSCnBwp24M
         SJSF0u/2p4uNIkrWdYO+jYMlzzqYx3CktNMb9D8jodrlrWQ0Io9CYLyeT5VP0+CloMF0
         ieEFlvtMLF7kK4oMbqU5gf9NwyMNna0xASA4MDWWxqR3XW/cu49PaqTCxEocgtkdk5xB
         L1GZFyrXbveI8k7N9Rae2AXxx66tFGNr2eJUyu83IgP06uMH5wMYi7OugRrhFdHIzsBJ
         AOyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXBH6LyBes+LaJ9S0tlJ1tNDZ0tybp0ldmCNVFuXb1kmEo0QGsM+b+XzgFX0Vl71ztiVco+4E=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+y+PwLaNygzoOarFDyv/I5speol6bKvf/K5GpeLNrb31CARhl
	HIaLKaivEGiLFvvdTc8crWmqOVYD7QVSysndkEUwmm93PDCP03X/
X-Gm-Gg: ASbGncv0wAxWs/MHfFUvmWQbuN1jOgBAeF67KPNTkBTims1p3vefLWx7Gt+mfsyKYcd
	5RAbDIp2KgRnOYakARLPZQu1KB38K5KADTlG9yNtXxZvGPIoRQYXB32U4+IJ2zic95h7Nn7HCXH
	VCUZ5Fnj+l2eIm+zJNpnvgYlrNfsrgbvWd2c26XJjUFAmFGAtS/n2hGbHkod4fT+zr+twHcYYQ9
	N63ktZ9igly4n85I2zYAMdmkqJqp2G7oC/fM3ZnggQAvCY/BSUDHOHw7yjLS7S8+PwyNNZP8yS2
	GFYnnF3jfXREwoY7F9DODNuj0hb57BIfNzt5Cmi53lotGKxsCUBf6Nh9eA5XVq1M6jKnUsU+Rju
	m0tg3ehFScrp+mCt6mwSR3Uej6PShvIXO4pmcftzTFRmy/yGfEGvRYekl1bZ+ug==
X-Google-Smtp-Source: AGHT+IEquGmXyo0QZO6D8xBnPc2YdJ5ns+5Q/gwbofncoh7rX6vx5H6gyD7FpADTdefnpFFr3FhJMg==
X-Received: by 2002:a05:6402:2351:b0:5e4:af36:2315 with SMTP id 4fb4d7f45d1cf-5e59f3d4a3dmr6307326a12.12.1741170601891;
        Wed, 05 Mar 2025 02:30:01 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1f7161a4esm247154266b.161.2025.03.05.02.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:30:00 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Ivan Vecera <ivecera@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
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
	linux-hardening@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v9 nf 00/15] bridge-fastpath and related improvements
Date: Wed,  5 Mar 2025 11:29:34 +0100
Message-ID: <20250305102949.16370-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset makes it possible to set up a software fastpath between
bridged interfaces. One patch adds the flow rule for the hardware
fastpath. This creates the possibility to have a hardware offloaded
fastpath between bridged interfaces. More patches are added to solve
issues found with the existing code.

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

I send v4 and above as non-RFC as the previous 2 RFC's did not get any
comment.

Changes in v9:
- No changes, resend to netfilter

Changes in v8:
- Added commit on top: Avoid zero-length arrays in struct pppoe_hdr.

Changes in v7:
- Inside br_vlan_fill_forward_path_pvid(), replaced usage of
   br_vlan_group() with br_vlan_group_rcu() and
   nbp_vlan_group() with nbp_vlan_group_rcu().

Changes in v6:
- Conntrack double vlan and pppoe patch: Set ph and vhdr after the calls
   to pskb_may_pull().

Changes in v5:
- Conntrack double vlan and pppoe patch: Moved pskb_may_pull() up to the
   first switch statement, to the start of the cases. Removed the second
   switch statement. Replaced 0xffffffff with U32_MAX.
- Added patch removing hw_outdev, out.hw_ifindex and out.hw_ifidx members.
- Fix error path returned from nft_flow_offload_bridge_init().
- Cosmetics.

Changes in v4:
- Added !CONFIG_NET_SWITCHDEV version of
   br_switchdev_port_vlan_no_foreign_add().

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

Eric Woudstra (15):
  net: pppoe: avoid zero-length arrays in struct pppoe_hdr
  netfilter: nf_flow_table_offload: Add nf_flow_encap_push() for xmit
    direct
  netfilter: flow: remove hw_outdev, out.hw_ifindex and out.hw_ifidx
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

 drivers/net/ppp/pppoe.c                    |   2 +-
 include/linux/netdevice.h                  |   3 +
 include/net/netfilter/nf_flow_table.h      |   5 +-
 include/net/switchdev.h                    |   1 +
 include/uapi/linux/if_pppox.h              |   4 +
 net/bridge/br_device.c                     |  23 ++-
 net/bridge/br_private.h                    |  12 ++
 net/bridge/br_switchdev.c                  |  15 ++
 net/bridge/br_vlan.c                       |  29 +++-
 net/bridge/netfilter/nf_conntrack_bridge.c |  83 ++++++++--
 net/core/dev.c                             |  66 ++++++--
 net/netfilter/nf_flow_table_core.c         |   1 -
 net/netfilter/nf_flow_table_inet.c         |  13 ++
 net/netfilter/nf_flow_table_ip.c           |  96 +++++++++++-
 net/netfilter/nf_flow_table_offload.c      |  15 +-
 net/netfilter/nft_chain_filter.c           |  20 ++-
 net/netfilter/nft_flow_offload.c           | 168 +++++++++++++++++++--
 net/switchdev/switchdev.c                  |   2 +-
 18 files changed, 497 insertions(+), 61 deletions(-)

-- 
2.47.1

