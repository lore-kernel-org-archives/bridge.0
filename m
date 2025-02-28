Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F7D1C5D74
	for <bridge@lists.linux.dev>; Fri, 28 Feb 2025 20:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773781; cv=none; b=ie/wdT6UKpN1cWEK8XAUYE/jJ42/hh01Y0jfH1m4fE5Wf97BWyhAkKUPhBSe5Gb4e9WIGPwWC3myuDI2Fj2h3MTTEG4qN2otHwe0swD8Zq/R8KC3CVPHsMj9NrscmrgxdrVysXGJLl/lIefZ5cVfYD1hvXUI7Hyjl2Ya7XLIdw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773781; c=relaxed/simple;
	bh=0RFW5tcp4yACx/SekSzgDs+LjBg6Kit2ueqz1ipNL48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X5PIcoh08VPFqQnVixwNn24CC/+mZWD53H3zgsXq5mx7iTPtSY1bu3ey2f3gN1Xw7/XlJWNwP82qVDODkjIexAiNNpLgLjSHXhBjR7Hpmcmbt4N38C6ocAVbXPHs5tjUx2Oc52APwNNHo94rrHcpm6rTES/pv3hEol+x9D7Aj4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tgm0Xlnv; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tgm0Xlnv"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abf3cf3d142so106844566b.2
        for <bridge@lists.linux.dev>; Fri, 28 Feb 2025 12:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740773777; x=1741378577; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ukvxk53p9GnrKz00DuMW/t8KFJJE9KRed6XPl/L5xk4=;
        b=Tgm0XlnvKiv73E7Z5JmhSzOcHsUBRwUylpIrvvWAfySU+j2YGc+13aCt+HOGIUYIIy
         5nwrAZDI07ic8oQMNJsvEGc+ZtlnoOnD7N8NOjamJgbYwSjbtgM0LE0g0th0/GH33lUe
         B538GXrM+UwhNX8PVrLVfLb+EVKxRi2WneL1bLcXJCBvGqCPU2+5ZQRicT3dHASesHqa
         OJxpGNPxCUG8fUSx/pRqzt++1BqEn2CGivXLybuIJKn50WOPQcCv0jdUakHqsOXugYFD
         dFscxhk9qgulvgHtrICls80hSD/Fz0C781LK0ze8A5h83M8XmRODtd+thDMEKyzqWt0K
         t4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740773777; x=1741378577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ukvxk53p9GnrKz00DuMW/t8KFJJE9KRed6XPl/L5xk4=;
        b=dGNvDCAR37uivwZRMoLZjvhSGtIC3Wo1UIC2EhOWRL6UeG1JQsf1DJSRycleWJqLCO
         gt6ALQSuj7XwphwraX+iNcFOqIJweRY6BeHvKtzf4+UXWdIauzWRjxv0Dv2H7VsCUNKi
         qPYnMuTEZLzRxYIKAcYhIIMDpy9sOcPszlVxemiLlt5rwLFAQgCpaiiRFpln4nj69Scr
         6PAducLKjiGMezT7kVYFNDWvnYU90/3Fs9EUF6eCjhkLCW774xfm5wo2D3EYtbUgdIys
         emw5wZB8hwtX9qyQVnB9zevP/wT6kKfTbalSBdJD8cIHUXfJKsOaYM29wQ1XwbV2DQsI
         mSgA==
X-Forwarded-Encrypted: i=1; AJvYcCWNNrZpq2gItbbtO9b29pYHQ7bBZnJ+IYQcnhll9q5NqAqKreBnuVPE7u7TJ1D1n5R/tFv/whE=@lists.linux.dev
X-Gm-Message-State: AOJu0YxrnOI97aQN5vhq9KzLuMFSyOVGXQDqQxAoeZUSqmB8mJlkbr1z
	4IXUEG07sptIFXB0uG4CnNBvvG22QLxtoubSBm4p7tUr7CzBYoli
X-Gm-Gg: ASbGnctE/FzU2EaUh9xzNJkkh1jfbJDdOJcpEX6nr3uWAQItccn5/dpDqFV+e0MeMCC
	hVDwnpJx0ZqDzG0srWbMpaygLDWriYwQNY4gQKloqcB8ctcTJWN7dTcnwx1H1rjE5tIZ/Nb63+K
	ofxpjFI6+usPZL0gDN82KYm67AedpyqA6HKanP8tpGIpJ3GzXIu3OVSIKsRKYTYBkBgm8LLDyiL
	SbxG+cNoLHsSSq8H7ZxymEAo+nwBONNq9tzT3uJCEslXhELtVq0jDbeRn8jHTTG/J0qqMo/+U1q
	qC6Wc8PGBEAM5OSIUAmARAd7tlkM+uM5epFNE3Jlhr5jp59lSHTBD+WjuyeDCEPrKmdfEw7elyZ
	TIAmDvOjzsuwgSqX7ZcuWQIrsptH9qjbUKUV5W8R8EBQ=
X-Google-Smtp-Source: AGHT+IFi3QN94LoYUiIPRuS0EubYnvS4AeY8vcNVv01mDRusJEvQKVghy6Bwoph5/cT/4gpnxmhPPQ==
X-Received: by 2002:a05:6402:388a:b0:5e5:335:dad1 with SMTP id 4fb4d7f45d1cf-5e50335de57mr7321880a12.27.1740773776257;
        Fri, 28 Feb 2025 12:16:16 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c755c66sm340812666b.136.2025.02.28.12.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 12:16:15 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Michal Ostrowski <mostrows@earthlink.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
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
Subject: [PATCH v8 net-next 00/15] bridge-fastpath and related improvements
Date: Fri, 28 Feb 2025 21:15:18 +0100
Message-ID: <20250228201533.23836-1-ericwouds@gmail.com>
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

