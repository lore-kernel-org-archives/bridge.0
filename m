Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A67628FD
	for <bridge@lists.linux.dev>; Sat,  4 Jan 2025 12:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735995468; cv=none; b=S6t3jWPUU4NH+stGNzEMHYQTeuw4VCfRHKrflxa7D1RHcyUpqIptUP2RmI+xTaL9wpfAdseL6vCLkDGN6FjRQO0dgptVyUZdx43DEzX/JZCMAeUY82x/kA4Gx4aJACjVYX4zKIww0fEiOIRLvhuldGYihefAV1mYTUFdL4cGGuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735995468; c=relaxed/simple;
	bh=78iDDWAiBGTMRDha9Obhylfd+VcFmHpySi4wHlZAMxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uPUyniJANUk2Ta9NG0+X0hRWyO1KOWW2LXQS9fvn3CPen4VCObXGLxf65/lwXeCfAkwyjN6ATuWIDd5pXp9wWACEitdL+muapFSC28b8lIBu5O2gRFDN5lb4VXLG2+gKZcjovxbwzQhSBmcy9weIkGKgGgxdpIT1wjcpyPrVCws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1tz7FiW; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1tz7FiW"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-216634dd574so121482125ad.2
        for <bridge@lists.linux.dev>; Sat, 04 Jan 2025 04:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735995466; x=1736600266; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=utMz9TCdnLzB+35RCtS5XbaQfGf7lVYnJhgTvLhC8qc=;
        b=K1tz7FiWHPx/VvPLnuN/6bLs62GbH1JVUT/8LOya3+LWGX9/jL0F8Ya4viz2YJgVSz
         GDjh2vxTCmbyRaWc790b2l7ZlwIhMcc0frzObamSJR0eligoUPdrblNUea8TzlekDSwf
         sbMcXwIexlKA61RohdEsK+OBw0lcZhVZfaKfP2A3UAPzGkxdgfpocV0I6uY0CIqzn3fJ
         MMRJ1qb3C3InpMfKMG980FWmxjw0Y8lWI90bgLV4CnGnSCX/x6LAnNPFBlCuHdZhxE6H
         Q3rd7EKUpk8CseuDtM2q9d/Ccah3tVJC3JDj4pQ16wGWyFCRnSlbtCipMLF78Ybjb+7c
         xfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735995466; x=1736600266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=utMz9TCdnLzB+35RCtS5XbaQfGf7lVYnJhgTvLhC8qc=;
        b=GV3avL/gjo4rWvkbCkrj1hR3yW2pETuI16yFNLi8imRk0TrNamzWyFdaOFyVy8dKjm
         om0ftc87hzAW2FA90j8zUKP21HY7CD05gc+JFlRW1qvsbX6CvFQjjzUw+n3usYYNpEgQ
         T2Ei3nxIbS5kGyGp2Iy7Ag6o9rGRKRsvZBU9em/B7EMWl33MSWSISwHvPwWtWpQ/O3p5
         lgkB5VtfNRrUuJWqYsszP0GtNtF7NJfZJsJ2lKH2+yFL1VevOav3L5Zu7LUJgwYx+G8e
         aVL2D5as+TfgOnaa6wLXcHBHIRDEAfzIaPE1RQ3oP8iUvEAoU8bUYcKsn7mXy0tvqG0F
         BoXA==
X-Forwarded-Encrypted: i=1; AJvYcCU7KmD/U9f+eQTvFbDcgmbpCPJbu3eTyACzZdSN66dyaNTCy4k3TSlkEbeO8xhOXi7LBw46KTo=@lists.linux.dev
X-Gm-Message-State: AOJu0YxtoMTC2ADPuvyfh7DlRjG44Crzd1I8Y2vrquK4AScWRDq3LZdo
	ue4hkudOZG+vIF+/dFhev68WbrAjiL5y3KjTWjKtlu8329lnCEKs
X-Gm-Gg: ASbGncsM6nO5NqBrmNobQqsKywtTmn21Yf+/VMPzPOl6aAut5CtoOVw4qao8OIi0cZr
	ddXjHuzw41qNFLRXl9Y02qyJ7IsfFWpDxpeMxh95jkfe29g602dHzqUYuF1J9R/xQ8m60KCBiWo
	h+A8ZrUeSRscha4Zw71ppqmuz+lzSibhz8cPhyhjJsFNtkM9kMH2ZZ0TL7I8kOxYzGK687CqkKN
	bqyKtW7cj89yXX/RrGBFd+g4pzbWKeYHDtu2I+h7Dv6Vyo=
X-Google-Smtp-Source: AGHT+IGcOHb1dyLQmVkG8bow/TLK/QHadko/AX65rHfAErCpy6bKIwin2B23ApYOFwq4e4AHjEiARA==
X-Received: by 2002:a05:6a00:3a02:b0:724:bf30:147d with SMTP id d2e1a72fcca58-72abddb20cfmr61551219b3a.11.1735995466219;
        Sat, 04 Jan 2025 04:57:46 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad830349sm27761344b3a.47.2025.01.04.04.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 04:57:45 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Hangbin Liu <liuhangbin@gmail.com>,
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
Subject: [PATCH net-next v7 00/11] net: Improve netns handling in rtnetlink
Date: Sat,  4 Jan 2025 20:57:21 +0800
Message-ID: <20250104125732.17335-1-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
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

Patch 01 serves for 1) to avoids link name conflict in different netns.

To achieve 2), there're mainly 3 steps:

 - Patch 02 packs newlink() parameters into a struct, including
   the original "src_net" along with more netns context. No semantic
   changes are introduced.
 - Patch 03 ~ 07 converts device drivers to use the explicit netns
   extracted from params.
 - Patch 08 ~ 09 removes the old netns parameter, and converts
   rtnetlink to create device in target netns directly.

Patch 10 ~ 11 adds some tests for link name and link netns.


BTW please note there're some issues found in current code:

- In amt_newlink() drivers/net/amt.c:

    amt->net = net;
    ...
    amt->stream_dev = dev_get_by_index(net, ...

  Uses net, but amt_lookup_upper_dev() only searches in dev_net.
  So the AMT device may not be properly deleted if it's in a different
  netns from lower dev.

- In gtp_newlink() in drivers/net/gtp.c:

    gtp->net = src_net;
    ...
    gn = net_generic(dev_net(dev), gtp_net_id);
    list_add_rcu(&gtp->list, &gn->gtp_dev_list);

  Uses src_net, but priv is linked to list in dev_net. So it may not be
  properly deleted on removal of link netns.

- In pfcp_newlink() in drivers/net/pfcp.c:

    pfcp->net = net;
    ...
    pn = net_generic(dev_net(dev), pfcp_net_id);
    list_add_rcu(&pfcp->list, &pn->pfcp_dev_list);

  Same as above.

- In lowpan_newlink() in net/ieee802154/6lowpan/core.c:

    wdev = dev_get_by_index(dev_net(ldev), nla_get_u32(tb[IFLA_LINK]));

  Looks for IFLA_LINK in dev_net, but in theory the ifindex is defined
  in link netns.

---

v7:
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


Xiao Liang (11):
  rtnetlink: Lookup device in target netns when creating link
  rtnetlink: Pack newlink() params into struct
  net: Use link netns in newlink() of rtnl_link_ops
  ieee802154: 6lowpan: Use link netns in newlink() of rtnl_link_ops
  net: ip_tunnel: Use link netns in newlink() of rtnl_link_ops
  net: ipv6: Use link netns in newlink() of rtnl_link_ops
  net: xfrm: Use link netns in newlink() of rtnl_link_ops
  rtnetlink: Remove "net" from newlink params
  rtnetlink: Create link directly in target net namespace
  selftests: net: Add python context manager for netns entering
  selftests: net: Add test cases for link and peer netns

 drivers/infiniband/ulp/ipoib/ipoib_netlink.c  |  11 +-
 drivers/net/amt.c                             |  16 +-
 drivers/net/bareudp.c                         |  11 +-
 drivers/net/bonding/bond_netlink.c            |   8 +-
 drivers/net/can/dev/netlink.c                 |   4 +-
 drivers/net/can/vxcan.c                       |   9 +-
 .../ethernet/qualcomm/rmnet/rmnet_config.c    |  11 +-
 drivers/net/geneve.c                          |  11 +-
 drivers/net/gtp.c                             |   9 +-
 drivers/net/ipvlan/ipvlan.h                   |   4 +-
 drivers/net/ipvlan/ipvlan_main.c              |  15 +-
 drivers/net/ipvlan/ipvtap.c                   |  10 +-
 drivers/net/macsec.c                          |  15 +-
 drivers/net/macvlan.c                         |   8 +-
 drivers/net/macvtap.c                         |  11 +-
 drivers/net/netkit.c                          |   9 +-
 drivers/net/pfcp.c                            |  11 +-
 drivers/net/ppp/ppp_generic.c                 |  10 +-
 drivers/net/team/team_core.c                  |   7 +-
 drivers/net/veth.c                            |   9 +-
 drivers/net/vrf.c                             |  11 +-
 drivers/net/vxlan/vxlan_core.c                |  11 +-
 drivers/net/wireguard/device.c                |  11 +-
 drivers/net/wireless/virtual/virt_wifi.c      |  14 +-
 drivers/net/wwan/wwan_core.c                  |  25 +++-
 include/net/ip_tunnels.h                      |   5 +-
 include/net/rtnetlink.h                       |  44 +++++-
 net/8021q/vlan_netlink.c                      |  15 +-
 net/batman-adv/soft-interface.c               |  16 +-
 net/bridge/br_netlink.c                       |  12 +-
 net/caif/chnl_net.c                           |   6 +-
 net/core/rtnetlink.c                          |  35 +++--
 net/hsr/hsr_netlink.c                         |  14 +-
 net/ieee802154/6lowpan/core.c                 |   9 +-
 net/ipv4/ip_gre.c                             |  27 ++--
 net/ipv4/ip_tunnel.c                          |  10 +-
 net/ipv4/ip_vti.c                             |  10 +-
 net/ipv4/ipip.c                               |  14 +-
 net/ipv6/ip6_gre.c                            |  42 ++++--
 net/ipv6/ip6_tunnel.c                         |  20 ++-
 net/ipv6/ip6_vti.c                            |  16 +-
 net/ipv6/sit.c                                |  18 ++-
 net/xfrm/xfrm_interface_core.c                |  15 +-
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/config            |   5 +
 .../testing/selftests/net/lib/py/__init__.py  |   2 +-
 tools/testing/selftests/net/lib/py/netns.py   |  18 +++
 tools/testing/selftests/net/link_netns.py     | 141 ++++++++++++++++++
 tools/testing/selftests/net/netns-name.sh     |  10 ++
 49 files changed, 550 insertions(+), 226 deletions(-)
 create mode 100755 tools/testing/selftests/net/link_netns.py

-- 
2.47.1

