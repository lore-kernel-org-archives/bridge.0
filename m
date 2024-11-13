Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F936088F
	for <bridge@lists.linux.dev>; Wed, 13 Nov 2024 12:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731502658; cv=none; b=SKKxkumRxJ+Dikx/8r9+A2pc/yzj+O3P3/nB+SrwX+DBBL7d8DrURhT/ivDCYOuGukkh5BSCTCap9T7Z8/s93mZD1Kegt+Gokqu6wwi/AqG6nNMvg+P+jyuWrHbTJEgxAtNSGJJ8MvC5iLdzcOxAns0fCVNnb7rQK3n/0mOKRb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731502658; c=relaxed/simple;
	bh=LGhloGeZIC0Mz+li19UMoWZ/7zMlCQSy38g2HbfQ70Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D4TlTavCTtDrzYJcxiKeXdJ8Smn9ticsIcHJqgFwCDmnZfRLpRPB0EpOMYUpxTvI53YWCUshYEuquRtjnVb7H2So7iKPCuu28aBDYNPtzQDSRnU5vmOvFVpiHsrm23jkPSNo+Uut0YglGMLzsx9e5U3M34/bBFcb+Tqk/mbDujs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mc/3vcrO; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mc/3vcrO"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso503464a12.1
        for <bridge@lists.linux.dev>; Wed, 13 Nov 2024 04:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731502656; x=1732107456; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=16RIG7XtmkaIMsGLfFdWcl8EYTUAA5lDQMgC+uoAVXA=;
        b=Mc/3vcrO0mZS7EQCaRPK9v2VZiOuO0DOMVOClzJmHEMUKVJeYWBct9hhO4IrazMn7K
         sMOJG5BuqebCbPLxtJaiIuw8hiJ6benEFxev+YU9iUX7JJiPt4E2MhSj6gNwTT00bNGv
         ovN6OS3AdPusp4dzxuzaY28iAP0BFatGgJP9q5PA0MFM9wKVzUqjTI7RUoStbSspaSCX
         2YmbanQciSdhqhJ0b3STedmt/g5GWp2/1sTxMlsn0C8wFNfkZvjZDbhE6pJnTeJaZcHU
         8poHu9OZ0JXlvysNQ+h+Kny+OELbUv3FSyr8lMRXpRI/xc/F64t68KMtw25btlyTURiw
         90/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731502656; x=1732107456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=16RIG7XtmkaIMsGLfFdWcl8EYTUAA5lDQMgC+uoAVXA=;
        b=AwdMcm4cqSBOj5LLZmKzmIdVwlghVy2/gC5U6vT08t8aeTRtXHbJM3KNlpg5bWEf53
         6cNqXps3TByfU7PQaVeMUdqQk3+1RJBIpMpYsFfbmxeZJNdSBcS5lR8onQ63zMLR9esa
         CureVccLPqp/5JGyjioBvxKYpG3r7HddFfi5DJTBXD7PMYXdMVBf6ZsT+lA2V9d8Yx2W
         kMZwILTZW+wAsmiR2HS16WA9DNQSzY0EeOlj5oVzAgUgqVogDhCy/huuZBaKbgzsS6nB
         SXAaOVCyUWZu4Av10ddf2q04Z6fN0zc4KfN3ADTsPpkc7KSVGN1qsEokGNJWZOcAP9SC
         Io8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVySgV2W6i/xEwVzuMTUNlfwomayZKuSAohNkYSeY9nJhNNvmIJFyyv7Xu7L3Nb2HHlz8Mtcbg=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7xPm05CPJv2KZg3YChUEIOHmHaKfntGkOsiCgS6j0I/CaXdHj
	ZHijnVcCnwPNsCZlndPv6gNV6y+fUpSdu9AMCZc0Pah3csJ6KACc
X-Google-Smtp-Source: AGHT+IG1llNssb9d3itpdlPx9GEqMX+Zp38UcErZg9PjxNGttUHCL6O3wsgZQ/zCnjJA57EpkRZP1g==
X-Received: by 2002:a17:90b:2789:b0:2e2:bb32:73e7 with SMTP id 98e67ed59e1d1-2e9b1f844damr30704968a91.15.1731502656393;
        Wed, 13 Nov 2024 04:57:36 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9f3f8ed0esm1398632a91.40.2024.11.13.04.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:57:35 -0800 (PST)
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
Subject: [PATCH net-next v3 0/6] net: Improve netns handling in RTNL and ip_tunnel
Date: Wed, 13 Nov 2024 20:57:09 +0800
Message-ID: <20241113125715.150201-1-shaw.leon@gmail.com>
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

Patch 1 from Donald is included just as a dependency.

---

v3:
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


Donald Hunter (1):
  Revert "tools/net/ynl: improve async notification handling"

Xiao Liang (5):
  net: ip_tunnel: Build flow in underlay net namespace
  rtnetlink: Lookup device in target netns when creating link
  rtnetlink: Decouple net namespaces in rtnl_newlink_create()
  selftests: net: Add python context manager for netns entering
  selftests: net: Add two test cases for link netns

 drivers/infiniband/ulp/ipoib/ipoib_netlink.c  |  6 ++-
 drivers/net/amt.c                             |  6 +--
 drivers/net/bareudp.c                         |  4 +-
 drivers/net/bonding/bond_netlink.c            |  3 +-
 drivers/net/can/dev/netlink.c                 |  2 +-
 drivers/net/can/vxcan.c                       |  4 +-
 .../ethernet/qualcomm/rmnet/rmnet_config.c    |  5 +-
 drivers/net/geneve.c                          |  4 +-
 drivers/net/gtp.c                             |  4 +-
 drivers/net/ipvlan/ipvlan.h                   |  2 +-
 drivers/net/ipvlan/ipvlan_main.c              |  5 +-
 drivers/net/ipvlan/ipvtap.c                   |  4 +-
 drivers/net/macsec.c                          |  5 +-
 drivers/net/macvlan.c                         |  5 +-
 drivers/net/macvtap.c                         |  5 +-
 drivers/net/netkit.c                          |  4 +-
 drivers/net/pfcp.c                            |  4 +-
 drivers/net/ppp/ppp_generic.c                 |  4 +-
 drivers/net/team/team_core.c                  |  2 +-
 drivers/net/veth.c                            |  4 +-
 drivers/net/vrf.c                             |  2 +-
 drivers/net/vxlan/vxlan_core.c                |  4 +-
 drivers/net/wireguard/device.c                |  4 +-
 drivers/net/wireless/virtual/virt_wifi.c      |  5 +-
 drivers/net/wwan/wwan_core.c                  |  6 ++-
 include/net/ip_tunnels.h                      |  5 +-
 include/net/rtnetlink.h                       | 22 ++++++++-
 net/8021q/vlan_netlink.c                      |  5 +-
 net/batman-adv/soft-interface.c               |  5 +-
 net/bridge/br_netlink.c                       |  2 +-
 net/caif/chnl_net.c                           |  2 +-
 net/core/rtnetlink.c                          | 25 ++++++----
 net/hsr/hsr_netlink.c                         |  8 +--
 net/ieee802154/6lowpan/core.c                 |  5 +-
 net/ipv4/ip_gre.c                             | 13 +++--
 net/ipv4/ip_tunnel.c                          | 16 +++---
 net/ipv4/ip_vti.c                             |  5 +-
 net/ipv4/ipip.c                               |  5 +-
 net/ipv6/ip6_gre.c                            | 17 ++++---
 net/ipv6/ip6_tunnel.c                         | 11 ++---
 net/ipv6/ip6_vti.c                            | 11 ++---
 net/ipv6/sit.c                                | 11 ++---
 net/xfrm/xfrm_interface_core.c                | 13 +++--
 tools/net/ynl/cli.py                          | 10 ++--
 tools/net/ynl/lib/ynl.py                      | 49 ++++++++-----------
 tools/testing/selftests/net/Makefile          |  1 +
 .../testing/selftests/net/lib/py/__init__.py  |  2 +-
 tools/testing/selftests/net/lib/py/netns.py   | 18 +++++++
 tools/testing/selftests/net/netns-name.sh     | 10 ++++
 tools/testing/selftests/net/netns_atomic.py   | 38 ++++++++++++++
 50 files changed, 255 insertions(+), 157 deletions(-)
 create mode 100755 tools/testing/selftests/net/netns_atomic.py

-- 
2.47.0

