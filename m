Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21511D6DC5
	for <bridge@lists.linux.dev>; Wed, 19 Feb 2025 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969457; cv=none; b=BVu2X8CuggjfEnQyDY8kXn8aND5VuIkV+XmfF1/407yT6wJioezw+fG/y1oAkkcqdJMsjIfODul3FwRQXtshJhReQ2YZ7hIoJk7gSNq+uh/1ZCn2MdqKOs5D0Xi9zGdLbvP6Dq4/udf0o8wnDXZX7Co5GpRlFymSGFpP0rcPQOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969457; c=relaxed/simple;
	bh=xkr//DIeJXWeI9t9OGQRsHzzt0mLyQ9yOF0ugDqOfuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WsbfHeGhhM7uxXSmluhMvvgJultVywv9SATUiAoIgXP3LvDctEn0P1sYO8k76HajmPyoyuBa3BdN56K4n3LpWnOM2lSCmNFNWzpH/dyMKtjWPBrdo4Tf035SgrCRj1hFnjpH7h3d2Ex+PDo57qj2ZZwfdu2xW+rTo2Kz7tga5d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+EEZkGB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+EEZkGB"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22104c4de96so70806245ad.3
        for <bridge@lists.linux.dev>; Wed, 19 Feb 2025 04:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969454; x=1740574254; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wOEjIz3jfJx7EGKo7QwRt3VtLNoT+pQ4mVUjPRekXyI=;
        b=O+EEZkGB1YAFVaG46vQ2V7QbQ5lOTcuLMY+VQIQ1d4NVOLHdLtFvdqul5FiGApcVqe
         GFCeHFBl4pZiy3R6e0kaXwBlqbfMTw92MViczqbiXBMIiNrzU+hkp9CqwjwFtxtdo7Ai
         NeDLbsk7ctsh2lCxMXQKu36KZQYXob5OmnTXK/yECck2O3DftVj3eD2xsOC99nWLlKbW
         l27cE3Zf2nGspQNoyPSgJ6wQ88myNfG51iGIhOQ/zvpn3OhmbP76mX9nPYyCpisd1moj
         Gu4STI3mlpxanExLz2VdG6qWk1Xcysa+GpH9w9MKfRFlL/Shd5KaErOOQGf5blx0HBGI
         x/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969454; x=1740574254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wOEjIz3jfJx7EGKo7QwRt3VtLNoT+pQ4mVUjPRekXyI=;
        b=ItSlhv6gjeSwpxPKP8pKTpDvP29KWOykfP2j/G93gmcOm92Jr66HXXfDqUwjkMILRL
         6svVWNFLa+NfRVws5pGOd6QHP5EQkKKrLv/UspqP6f68WIuIrEamrDjQ9uq5Z65hC0Vo
         qI972k+mUIfQGAtyhzMEdTG4koCOFwhStzBXlohHsr0V/PpRvcJzUHxkew89PodLeHe/
         ZLLqxZ0QONbKz3PuGf5lzQ5ryGwtLVEOz4V0OhPKh5M2Mj3R23s8g3olx9ISWFb7lGJP
         xiQ7UgVrTok3aZgJGBIPVIm1QIH3m5gdNZDRCMm7KbfmNe3RfsEY8OL5r7eAxaKsfmRt
         Sx+g==
X-Forwarded-Encrypted: i=1; AJvYcCWRo2OgheIdnz0u8i+SEt+7vNMjwVsN5S+15xTIeJmtq32JBriHNkMpDDRhZpy76ybuikQPuEk=@lists.linux.dev
X-Gm-Message-State: AOJu0YxNOu4+N2MfSzVYA8eBdsuiZCEpbAEv6gJ3liaAcpSl2cODQ59m
	ovnlQZHXyuFddLNfprl5ZuVmthtmn11BtsOkPEv3MbEpR+WCYqgW
X-Gm-Gg: ASbGncsCzljSZ8gpTLY/TrIg9ZJtFLUDhEKsB386fWYuDn+OHtE6P9bsd94AffME0RY
	yf4AMepIR26PLYSYXxA7GbCEOZViJew9W/pSgD3UCQ82swN6xp09Mfpk94/v43fZkBvIMVkCQ/w
	QKouzw/U6rnqN3dFMf6BP4N6Yv5MX5x/rAoxjXj4L+Yx45npVcV7xYzcbnK2vqAP/9yW1WDn8LS
	xjmS5EgfHgUF4OefhSoBj66s3UxdmuiXPWjrZW23u9BDZQ7qdfZGqAUWTrfjWGFYdEgGoD0QMvc
	Mxcbfw==
X-Google-Smtp-Source: AGHT+IGTzmUs09YpyFPrUkefpGaoWuBh2+9iqLpiW9iEBwyuEmzG/kObjhneqUPTdxqOS7kfr/mohA==
X-Received: by 2002:a17:902:d58b:b0:216:2426:767f with SMTP id d9443c01a7336-221040cec77mr301871725ad.49.1739969453951;
        Wed, 19 Feb 2025 04:50:53 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536436fsm103427175ad.64.2025.02.19.04.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:50:53 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-rdma@vger.kernel.org,
	linux-can@vger.kernel.org,
	osmocom-net-gprs@lists.osmocom.org,
	bpf@vger.kernel.org,
	linux-ppp@vger.kernel.org,
	wireguard@lists.zx2c4.com,
	linux-wireless@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	bridge@lists.linux.dev,
	linux-wpan@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v10 00/13] net: Improve netns handling in rtnetlink
Date: Wed, 19 Feb 2025 20:50:26 +0800
Message-ID: <20250219125039.18024-1-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series includes some netns-related improvements and fixes for
rtnetlink, to make link creation more intuitive:

 1) Creating link in another net namespace doesn't conflict with link
    names in current one.
 2) Refector rtnetlink link creation. Create link in target namespace
    directly.

So that

  # ip link add netns ns1 link-netns ns2 tun0 type gre ...

will create tun0 in ns1, rather than create it in ns2 and move to ns1.
And don't conflict with another interface named "tun0" in current netns.

Patch 01 avoids link name conflict in different netns.

To achieve 2), there're mainly 3 steps:

 - Patch 02 packs newlink() parameters into a struct, including
   the original "src_net" along with more netns context. No semantic
   changes are introduced.
 - Patch 03 ~ 09 converts device drivers to use the explicit netns
   extracted from params.
 - Patch 10 ~ 11 removes the old netns parameter, and converts
   rtnetlink to create device in target netns directly.

Patch 12 ~ 13 adds some tests for link name and link netns.

---

BTW please note there're some issues found in current code:

- In amt_newlink() drivers/net/amt.c:

    amt->net = net;
    ...
    amt->stream_dev = dev_get_by_index(net, ...

  Uses net, but amt_lookup_upper_dev() only searches in dev_net.
  So the AMT device may not be properly deleted if it's in a different
  netns from lower dev.

- In lowpan_newlink() in net/ieee802154/6lowpan/core.c:

    wdev = dev_get_by_index(dev_net(ldev), nla_get_u32(tb[IFLA_LINK]));

  Looks for IFLA_LINK in dev_net, but in theory the ifindex is defined
  in link netns.

And thanks to Kuniyuki for fixing related issues in gtp and pfcp:
https://lore.kernel.org/netdev/20250110014754.33847-1-kuniyu@amazon.com/

---

v10:
 - Move link/peer net helper functions to from patch 02 to 03.
 - Remove redundant tunnel->net assignment for IPv4 tunnels (patch 05).
 - Initialize tunnel->net before calling register_netdevice() for IPv6
   tunnels (patch 07).
 - Coding style fixes.

v9:
 link: https://lore.kernel.org/all/20250210133002.883422-1-shaw.leon@gmail.com/
 - Change the prototype of macvlan_common_newlink().
 - Minor fixes of coding style and local variables.

v8:
 link: https://lore.kernel.org/all/20250113143719.7948-1-shaw.leon@gmail.com/
 - Move dev and ext_ack out from param struct.
 - Validate link_net and dev_net are identical for 6lowpan.

v7:
 link: https://lore.kernel.org/all/20250104125732.17335-1-shaw.leon@gmail.com/
 - Add selftest kconfig.
 - Remove a duplicated test of ip6gre.

v6:
 link: https://lore.kernel.org/all/20241218130909.2173-1-shaw.leon@gmail.com/
 - Split prototype, driver and rtnetlink changes.
 - Add more tests for link netns.
 - Fix IPv6 tunnel net overwriten in ndo_init().
 - Reorder variable declarations.
 - Exclude a ip_tunnel-specific patch.

v5:
 link: https://lore.kernel.org/all/20241209140151.231257-1-shaw.leon@gmail.com/
 - Fix function doc in batman-adv.
 - Include peer_net in rtnl newlink parameters.

v4:
 link: https://lore.kernel.org/all/20241118143244.1773-1-shaw.leon@gmail.com/
 - Pack newlink() parameters to a single struct.
 - Use ynl async_msg_queue.empty() in selftest.

v3:
 link: https://lore.kernel.org/all/20241113125715.150201-1-shaw.leon@gmail.com/
 - Drop "netns_atomic" flag and module parameter. Add netns parameter to
   newlink() instead, and convert drivers accordingly.
 - Move python NetNSEnter helper to net selftest lib.

v2:
 link: https://lore.kernel.org/all/20241107133004.7469-1-shaw.leon@gmail.com/
 - Check NLM_F_EXCL to ensure only link creation is affected.
 - Add self tests for link name/ifindex conflict and notifications
   in different netns.
 - Changes in dummy driver and ynl in order to add the test case.

v1:
 link: https://lore.kernel.org/all/20241023023146.372653-1-shaw.leon@gmail.com/


Xiao Liang (13):
  rtnetlink: Lookup device in target netns when creating link
  rtnetlink: Pack newlink() params into struct
  net: Use link/peer netns in newlink() of rtnl_link_ops
  ieee802154: 6lowpan: Validate link netns in newlink() of rtnl_link_ops
  net: ip_tunnel: Don't set tunnel->net in ip_tunnel_init()
  net: ip_tunnel: Use link netns in newlink() of rtnl_link_ops
  net: ipv6: Init tunnel link-netns before registering dev
  net: ipv6: Use link netns in newlink() of rtnl_link_ops
  net: xfrm: Use link netns in newlink() of rtnl_link_ops
  rtnetlink: Remove "net" from newlink params
  rtnetlink: Create link directly in target net namespace
  selftests: net: Add python context manager for netns entering
  selftests: net: Add test cases for link and peer netns

 drivers/infiniband/ulp/ipoib/ipoib_netlink.c  |   9 +-
 drivers/net/amt.c                             |  11 +-
 drivers/net/bareudp.c                         |   9 +-
 drivers/net/bonding/bond_netlink.c            |   6 +-
 drivers/net/can/dev/netlink.c                 |   4 +-
 drivers/net/can/vxcan.c                       |   7 +-
 .../ethernet/qualcomm/rmnet/rmnet_config.c    |   9 +-
 drivers/net/geneve.c                          |   9 +-
 drivers/net/gtp.c                             |  10 +-
 drivers/net/ipvlan/ipvlan.h                   |   3 +-
 drivers/net/ipvlan/ipvlan_main.c              |   8 +-
 drivers/net/ipvlan/ipvtap.c                   |   6 +-
 drivers/net/macsec.c                          |   9 +-
 drivers/net/macvlan.c                         |  21 +--
 drivers/net/macvtap.c                         |   6 +-
 drivers/net/netkit.c                          |  14 +-
 drivers/net/pfcp.c                            |   9 +-
 drivers/net/ppp/ppp_generic.c                 |   9 +-
 drivers/net/team/team_core.c                  |   6 +-
 drivers/net/veth.c                            |   7 +-
 drivers/net/vrf.c                             |   5 +-
 drivers/net/vxlan/vxlan_core.c                |   9 +-
 drivers/net/wireguard/device.c                |   7 +-
 drivers/net/wireless/virtual/virt_wifi.c      |   8 +-
 drivers/net/wwan/wwan_core.c                  |  16 +-
 include/linux/if_macvlan.h                    |   6 +-
 include/net/ip_tunnels.h                      |   5 +-
 include/net/rtnetlink.h                       |  40 ++++-
 net/8021q/vlan_netlink.c                      |   9 +-
 net/batman-adv/soft-interface.c               |   9 +-
 net/bridge/br_netlink.c                       |   6 +-
 net/caif/chnl_net.c                           |   5 +-
 net/core/rtnetlink.c                          |  34 +++--
 net/hsr/hsr_netlink.c                         |  12 +-
 net/ieee802154/6lowpan/core.c                 |   7 +-
 net/ipv4/ip_gre.c                             |  22 ++-
 net/ipv4/ip_tunnel.c                          |   7 +-
 net/ipv4/ip_vti.c                             |   9 +-
 net/ipv4/ipip.c                               |   9 +-
 net/ipv6/ip6_gre.c                            |  26 ++--
 net/ipv6/ip6_tunnel.c                         |  18 ++-
 net/ipv6/ip6_vti.c                            |  14 +-
 net/ipv6/sit.c                                |  20 ++-
 net/xfrm/xfrm_interface_core.c                |  15 +-
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/config            |   5 +
 .../testing/selftests/net/lib/py/__init__.py  |   2 +-
 tools/testing/selftests/net/lib/py/netns.py   |  18 +++
 tools/testing/selftests/net/link_netns.py     | 141 ++++++++++++++++++
 tools/testing/selftests/net/netns-name.sh     |  10 ++
 50 files changed, 486 insertions(+), 181 deletions(-)
 create mode 100755 tools/testing/selftests/net/link_netns.py

-- 
2.48.1

