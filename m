Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E6217C225
	for <bridge@lists.linux.dev>; Sun,  9 Feb 2025 11:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739099444; cv=none; b=VJ1+dlDYKUKW1piOO2IMk4N8ZViOINNS/K6f1AiTN49sEuIkTlB4J+xgE+p6sAOFj0Z2nzlBRP7SkbBFi7g9BDi9F3SKEQO+Kzy2KnTkACXH0IGQ4thgvwgDXmnaN41IoTGadXx1mvW7oY8p+lhrzUyUQ+JV4ocj07sVGAiA9Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739099444; c=relaxed/simple;
	bh=rCDRU4XXH4rA0LN2XQHurDVJLZ31xGbReGd1pPmwDBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J+Z8OAhMfRzEUjE5anjmgvpGiyyjRXL0uHDaDBn+KB0sdpMRqiJbxMyhgNM5dPrXY+/ecHKReq0HuMC/je5AllnH8Qgr2zFj87tnFM7GH7rXxyjUAH0BD7BAlaVE5hCATZmrDAzEo9EnidgzlFYczwyMEpM+QGlStA4dPiapyk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBCdctZG; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBCdctZG"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5de4d4adac9so3861156a12.3
        for <bridge@lists.linux.dev>; Sun, 09 Feb 2025 03:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739099441; x=1739704241; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CyvKVSI33vZu8t/QmYGxOXMM6HMY8Y3GepsTnlkxCpQ=;
        b=WBCdctZGkotc6E7HAo38gVt3rANXNQ9KNgC6zRcda8K1awZU/mO0LvNnuTuOONPhS7
         ZMFvyR18OcUEivkDbvdcJD9M4ggqo94HcpJT7Gy3USDrO/TvSffsqjrR5TN59VXU0ZAQ
         9bIlpEN8KpBnSDLLShkrGMG5OSSgAzJ/02/D98PftHOBTAveGtPSo4f00Q/nIZVy5Ou7
         437JL7r2i5gXQ+HkrvRmTl1WOcFwOrPxPsk6mCj5yvxixJHfB9axXeQjmxBoZa0aj/9n
         9w03NzhcVhA+de2kKrDiyyhY5AEYQ+FPDUQ2IgyY+v4SjXv61Big8EWfTNpukeObfmy/
         x8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739099441; x=1739704241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CyvKVSI33vZu8t/QmYGxOXMM6HMY8Y3GepsTnlkxCpQ=;
        b=FEGRQBaUGAAagkIp31RAgnhnu6X1CrGiqG5wc7h7Xp+e0JT3W9XaP7Nqdfzi6JKVye
         uqw9qgvQ1Pg9Rbn779F1M4LyyrgQxdC/8+vRzxUWdDyJOIaRojpM6pl5vLqxWbpuhrY+
         pC9AFyjOLa/yk1Letre1Uq36s3yFcRg2aVDOh8iujQUFKRVlCswOEEnuOGYJP61Vt0gq
         yJ4B9QcM/JhnDSqrFpW3pQiSkYe71HhgnU81lRKS/EDPraiB0EXc7AMhnRxG5Su8aezx
         vIHO4tyYQbnRqlPO9HcUl7zEurhzAIKhS5g4u5MD5uAx74AfatOValz0FgUzm3haICGY
         oyNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkE8FTITiM22GeNrtb2BTnxuonrFgHPdFck3fi8e3tqLg2RDxAwHbVzbWWwUhVWX9pPDkeEKM=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/7vUhb4mnyJajTmQjQKFvYHcUI9ofg6TBRBzwJt7yDrVns7t6
	8hiA/CTcYX56oq85cTpWG0v9BzfP2wITvgFqJ+QIChIJyX0V+6jm
X-Gm-Gg: ASbGnct+fvYoh+U6XSYpDCBIvptPZEk+RDIN27qNfgmVkvcbiC9J7XwAmhQXHadsGA6
	ChNrXleP2KBKzuSiFoVLcfUFeQvz6B89WuDiSpw/eKgA1zhhyBsFp/70Y34mnxR0jDrea54t5mY
	AIk8VdOx+/srWaLXMKYwXAgSSaVSWGw3avAkKqtpWtcIrY+laKpkd8khwf+c+eK2lJNu03mTY7W
	clBc93pBoeUKcXGte7kQI5I5dK5k5Er98/lZl7BAndSXzb78N0LBB06pE9Sa+rYCDAxZabTCtea
	YNvOWq6taOM3OL8Y023DpzRV4liDCg7n3pO/JS76Trzkb4yn+Sq4UeqKFI4h2scpLLCnkuYEl3J
	ylUGcM17wzTOWUSfDWQS5e8xJWUwUTvSt
X-Google-Smtp-Source: AGHT+IEbNo/zNmhConkNcLHKgH3TnCUwIDNTGJ5Gx8cyqDGyWa7TYG5GlIYlUiiTBmfRe7hgt6Cw8Q==
X-Received: by 2002:a17:907:98b:b0:aa6:832b:8d76 with SMTP id a640c23a62f3a-ab789a9da54mr1139791266b.12.1739099440544;
        Sun, 09 Feb 2025 03:10:40 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab79afc7452sm357516366b.163.2025.02.09.03.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 03:10:40 -0800 (PST)
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
	Kuniyuki Iwashima <kuniyu@amazon.com>,
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
Subject: [PATCH v6 net-next 00/14] bridge-fastpath and related improvements
Date: Sun,  9 Feb 2025 12:10:20 +0100
Message-ID: <20250209111034.241571-1-ericwouds@gmail.com>
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

Eric Woudstra (14):
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

 include/linux/netdevice.h                  |   3 +
 include/net/netfilter/nf_flow_table.h      |   5 +-
 include/net/switchdev.h                    |   1 +
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
 16 files changed, 492 insertions(+), 60 deletions(-)

-- 
2.47.1

