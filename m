Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA17F26AD0
	for <bridge@lists.linux.dev>; Mon, 18 Nov 2024 14:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731940396; cv=none; b=C2Us2rIYUYWF9nMqGm0rhuUggQvpGg3mUHTlNDB1I/HzP4kNBiU4XyfK3OmWBeZUrWrX9JQxuwPq50OYn0TiNwcEIcWWKnI+iSlhRrE3WNvm4qHwHlVhoh2XOq5cLhfby9W96kOcV+9E+MOWDhjMXnXVeAwMxJGvEdpSipzhXCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731940396; c=relaxed/simple;
	bh=H5grSha4QDuPkq2DfKzCYvgmrrgrNiB2wWuyJ/9mn2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DV1goXcHwIRMiCIRPZNT8E/WrzAH6/rbGm4usAZqodj7yiV6jiq2oYxpcVeWxbnrtPjsr06mJQeEXYvGydTaGZZ+cV/+UoRlKRY/RcAfG2yIt9jDjUohKvTDJsNbNMKUeGzwfcf6FKGRexhDhkb07kqCaoH020tDU8Nvl8G9L2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4RHy3no; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4RHy3no"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-720cb6ac25aso3364068b3a.3
        for <bridge@lists.linux.dev>; Mon, 18 Nov 2024 06:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731940394; x=1732545194; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hNYrzSG3D47KB6oeOVj5/5Bj4MnSM/SMkHnb6rGgzb8=;
        b=a4RHy3no22CwJ8imaWmbNoxgMwhXaEyOQxAdWIt2VcEZ5ergvvdy5PssPcmLEwf0Wn
         EW8gL9jCt9kCA7amJRVVFD/1ccccbpCc24tuSYVA6uG/JVchA4nrPtVlZOoEiQKmTH23
         uPgZ7nuoN2zZ0TVBOLAgJVQ0UJCP6QB5On1lzTxirLx0n1vvH639L9DkF5Z06K8kCMTT
         xw8fpBGO8WJlEDrxhhzowyro4uCVT7/5Lpk6F5GnonaNENW6jNZeE6eawJsErlR+G30F
         tU2N6OSyGbZmWj10ffToSGgZk2UaH1IkTARkr7pojJA5ur3xJybgozqS4f60C4zPBwGc
         YKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731940394; x=1732545194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hNYrzSG3D47KB6oeOVj5/5Bj4MnSM/SMkHnb6rGgzb8=;
        b=ZhfBQ1JEulk5JH+SkBN8GC4fJ4eDRd14RCegLV2rt5E3gv+9mjCUFD/Bw0TkPY1Uok
         J6T+/4VZ6Px/s4pnQQyfC8I89bKza0Y2x0Or47CzkUWRtmRfys6LSOgn/qXImkRTYDxV
         x1DVBzRTJey14jUipEanYxx6diHBerVnXzLL4thWRf4tpB6pB39qBqHm5pFkVvi95SH9
         CEovguT2NG29USlbOqiPOvXCdZnwELTVgxqk7IQizGDRoD013Yh80ReUSJ6I5U+nGPvJ
         2GAM9iTQxNi7I+NspmzHclSOsI34Fbqa2enGywGlEdujguoYe2ilfqX2oCv/5UUoTGnn
         E0fg==
X-Forwarded-Encrypted: i=1; AJvYcCWBkCSpBsq3ArNfUt+xDW2OL07/2ius/fxJCpEmpDmOT6fJiA/HnGCC+powN+yHQvt7lR9CRdI=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2nr0kcGH0R8I0tuXkf6DBUVh/86T2EgkBQlW8vsIQbQCss+jY
	IJ7mLOQ3zgAK67zE1tKDhR6tERDYe8SbkyGUZyratFHtzmQyz1tH
X-Google-Smtp-Source: AGHT+IEgW/YjRV6I5AmJ/mBzBZGEWBcDxNEAGQpANYhMnRAlvyIjyPQThvC+SjMr0Xf12bRSa0kQgg==
X-Received: by 2002:a17:90b:52c6:b0:2ea:5dcf:6f74 with SMTP id 98e67ed59e1d1-2ea5dcf7122mr6227597a91.3.1731940393805;
        Mon, 18 Nov 2024 06:33:13 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea81b0e2fasm1616926a91.52.2024.11.18.06.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 06:33:13 -0800 (PST)
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
Subject: [PATCH net-next v4 0/5] net: Improve netns handling in RTNL and ip_tunnel
Date: Mon, 18 Nov 2024 22:32:39 +0800
Message-ID: <20241118143244.1773-1-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series includes some netns-related improvements and fixes for
RTNL and ip_tunnel, to make link creation more intuitive:

 - Creating link in another net namespace doesn't conflict with link names
   in current one.
 - Refector rtnetlink link creation. Create link in target namespace
   directly. Pass both source and link netns to drivers via newlink()
   callback.

So that

  # ip link add netns ns1 link-netns ns2 tun0 type gre ...

will create tun0 in ns1, rather than create it in ns2 and move to ns1.
And don't conflict with another interface named "tun0" in current netns.

---

v4:
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


Xiao Liang (5):
  net: ip_tunnel: Build flow in underlay net namespace
  rtnetlink: Lookup device in target netns when creating link
  rtnetlink: Decouple net namespaces in rtnl_newlink_create()
  selftests: net: Add python context manager for netns entering
  selftests: net: Add two test cases for link netns

 drivers/infiniband/ulp/ipoib/ipoib_netlink.c  | 11 ++++--
 drivers/net/amt.c                             | 13 ++++---
 drivers/net/bareudp.c                         | 11 ++++--
 drivers/net/bonding/bond_netlink.c            |  8 ++--
 drivers/net/can/dev/netlink.c                 |  4 +-
 drivers/net/can/vxcan.c                       | 11 ++++--
 .../ethernet/qualcomm/rmnet/rmnet_config.c    | 11 ++++--
 drivers/net/geneve.c                          | 11 ++++--
 drivers/net/gtp.c                             |  9 +++--
 drivers/net/ipvlan/ipvlan.h                   |  4 +-
 drivers/net/ipvlan/ipvlan_main.c              | 11 ++++--
 drivers/net/ipvlan/ipvtap.c                   |  7 ++--
 drivers/net/macsec.c                          | 11 ++++--
 drivers/net/macvlan.c                         |  8 ++--
 drivers/net/macvtap.c                         |  8 ++--
 drivers/net/netkit.c                          | 11 ++++--
 drivers/net/pfcp.c                            |  8 ++--
 drivers/net/ppp/ppp_generic.c                 | 10 +++--
 drivers/net/team/team_core.c                  |  7 ++--
 drivers/net/veth.c                            | 11 ++++--
 drivers/net/vrf.c                             |  7 ++--
 drivers/net/vxlan/vxlan_core.c                | 11 ++++--
 drivers/net/wireguard/device.c                |  8 ++--
 drivers/net/wireless/virtual/virt_wifi.c      | 10 +++--
 drivers/net/wwan/wwan_core.c                  | 15 +++++--
 include/net/ip_tunnels.h                      |  5 ++-
 include/net/rtnetlink.h                       | 34 +++++++++++++---
 net/8021q/vlan_netlink.c                      | 11 ++++--
 net/batman-adv/soft-interface.c               |  8 ++--
 net/bridge/br_netlink.c                       |  8 ++--
 net/caif/chnl_net.c                           |  6 +--
 net/core/rtnetlink.c                          | 29 +++++++++-----
 net/hsr/hsr_netlink.c                         | 14 ++++---
 net/ieee802154/6lowpan/core.c                 |  9 +++--
 net/ipv4/ip_gre.c                             | 27 ++++++++-----
 net/ipv4/ip_tunnel.c                          | 16 ++++----
 net/ipv4/ip_vti.c                             | 10 +++--
 net/ipv4/ipip.c                               | 10 +++--
 net/ipv6/ip6_gre.c                            | 28 +++++++------
 net/ipv6/ip6_tunnel.c                         | 16 ++++----
 net/ipv6/ip6_vti.c                            | 15 ++++---
 net/ipv6/sit.c                                | 16 ++++----
 net/xfrm/xfrm_interface_core.c                | 14 +++----
 tools/testing/selftests/net/Makefile          |  1 +
 .../testing/selftests/net/lib/py/__init__.py  |  2 +-
 tools/testing/selftests/net/lib/py/netns.py   | 18 +++++++++
 tools/testing/selftests/net/netns-name.sh     | 10 +++++
 tools/testing/selftests/net/netns_atomic.py   | 39 +++++++++++++++++++
 48 files changed, 377 insertions(+), 205 deletions(-)
 create mode 100755 tools/testing/selftests/net/netns_atomic.py

-- 
2.47.0

