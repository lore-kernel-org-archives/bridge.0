Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E43917D358
	for <bridge@lists.linux.dev>; Tue,  7 Jan 2025 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736240765; cv=none; b=Y1w3oZZ/TP+EDYZMYVqM/ewT4yFNManTHLCTJpl0zaf8vhFnMAH9dwkLK3T7c+S1plukH7BIGd0zVX+9OusgXE12JkWTz2OqRLxSDqaWJZkuY8ntDyfBA3pZSTqD0+NJWwNtPiJ/dqtTq+5JrLWZRr+QFaY/hCSHj8fKCV1gWUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736240765; c=relaxed/simple;
	bh=+lrAL1nhmjOwtuCrjSGBusJ4m7eSyo0LJzq6XREbXLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SClP6WbGTc9o4bf86FahgTf1i8MB4uwQXIthBegxjb/xZGl4vSOmQxzHa7JhhyO1VnRX5vL+uj6Hfeq4AynTOAAyMaxWrWCqxS8x6jKl3Uk1qUWw0bFJZeEbo/f35yy933lXuZGC6DzjIbxi3nwNe0xqBbappM2lr4OAjE7hx04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1MHqcb9; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1MHqcb9"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d3e6f6cf69so26588109a12.1
        for <bridge@lists.linux.dev>; Tue, 07 Jan 2025 01:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736240762; x=1736845562; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yf647nI7SHqGI80BBUzHOC/gY+pRTRu3FTTF5e5PvXw=;
        b=R1MHqcb9IH1UXMHjMBboKYoQ8MWLOW/GGSSd/g5G+v6vKWsvQ3r/s18Irw08AItm9E
         nJH4yPCT4Aez02KKooILnrWGK+hQldUZnUyyTmenPlFCSHfOxCbhyy6SVwTQ4Rip+FnH
         Ab55qzGc9E333GYchJmMb6XpVCtfARQs3lduLh85S7LME85xXxLcdfuaiNWWhyzTJ+Gz
         7y6FWbN6jj/9LjpmArAjUyeJ692+j4e32j7VAKU+k4q5TzrtpuxIJvH/+4whRd45Hnki
         Bgs2l1sErx105GeuCRhShXjWZh/Sqnze0WYToFtbJHctthd7dyUScHy06870xYWZvkgY
         XDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736240762; x=1736845562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yf647nI7SHqGI80BBUzHOC/gY+pRTRu3FTTF5e5PvXw=;
        b=vAHtXu3sm6ndB0yRhTGuHEJfJRgTyXKYXdyjQNvMgtuw8egZXIc58PKEQzUrf44CYR
         TlpjNb+ROi8vusJQnzvoMI5w3L0m/4ZKazJUznsvlMTDoS5mgPRSg18A3gnunjKOjaWz
         Sthz5kJ/RD2PHkeJiXFP3X6mHKeGO07jgM22TwvSx/B1FXsoTyTqvhiVvNtsPraD7lLK
         W+5qtnHIeZu0fehNKoy9iao0En+n+nCIPTDUpXynuBj4S4q8LradNAv46rpMRc0lKlW9
         U/dHhWOO+Q8EbI7CfwDiBC9odp2rPi+y3OYY2iT2Xx9/qbjMtukVEJuXq+IxkjWXi6VA
         KWUg==
X-Forwarded-Encrypted: i=1; AJvYcCVD9bJAKJhQv53qhH19YM/PfH/x3N5W/SSjS0ihArOluWXPWQT87R8vzeBDCaYZTUCr9lYzObM=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx9RQIf+ULeDrOpb9rBYs+1LyNbl0GHraJ+FePWv2z9vE7GDhET
	/VGX1lGVI3fJGtdq5U309Iaczku28M237wKUX786vXljwhpcyNmy
X-Gm-Gg: ASbGncvMeHrSqzNbP7LA3Jnee9oNNpWwr1awoe/5rY8i3N48k7JbWgWXYcr0OmMNbC8
	oVcsO6nIFTNiLMyEBW28C/Ab/r9rZID3sdbtRr8ea+K6KxqdzLgjjZftOtXxwe67/xX6NjN6TfH
	BcQuJSuE4YiYJB7NR35lJUdlRaPwt0u73vTodzwx5HbwElY6EctpR3CKuyrMspnnOXNEZWoj64L
	qXpUGcQP1MQvKJ5AJVRhQj5o5ZD8B6MfHTpETYrF4yFj7ZLjayWtlUBpsOI04U9JB+lb3RhvtGQ
	td1oXVOQkEaCs1WQfTM/wyLoOXegrvpACrYmUV815DHRbbYZzrdbNyAXP97Nj8xvEoIuhLIuvQ=
	=
X-Google-Smtp-Source: AGHT+IEqfnropOKSjHTeyHfKo1G2T5LbmT8gMHhBLT4HLZ1WLqNyAGZrwKDXof/oJBx8TuvP4LVrkw==
X-Received: by 2002:a05:6402:430c:b0:5d8:253:b7df with SMTP id 4fb4d7f45d1cf-5d81de22d07mr53758061a12.27.1736240761340;
        Tue, 07 Jan 2025 01:06:01 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80676f3f9sm24005333a12.23.2025.01.07.01.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 01:06:00 -0800 (PST)
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
Subject: [PATCH v4 net-next 00/13] bridge-fastpath and related improvements
Date: Tue,  7 Jan 2025 10:05:17 +0100
Message-ID: <20250107090530.5035-1-ericwouds@gmail.com>
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

I am now sending v4 as non-RFC as the previous 2 RFC's did not get any
comment.

Changes in V4:
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
 net/bridge/br_private.h                    |  12 ++
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
 15 files changed, 497 insertions(+), 53 deletions(-)

-- 
2.47.1

