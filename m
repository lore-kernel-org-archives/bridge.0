Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0449235955
	for <bridge@lists.linux.dev>; Mon,  9 Dec 2024 14:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733752950; cv=none; b=td2/AQbPBdPTKD+J35NNtVOJnR+H38jlMKnb5TMk3tkrDU03KTjWBmxIaGKRjE2XWmy8JuoMfcmsk8TIvAdj+5lUo6c4yqeFHP6KU53dNAZgwwMjKif01KznlFOGIWnDEo3SCC6Ww2eOjOokqoSXSBBcM4lHwb+IZoPDyrxQFJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733752950; c=relaxed/simple;
	bh=03xiu9pYOCrdNfcv/qw+gwiZHTNUJB2+YIld69kTu/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hYRgf5hx29N50KuLNLiVN89h/etY7Dcf5MY0SZPfjXCiRNzHcC66qbPdOFMVZitH/J1KY/hPl7eVYyfcnFKeO0hHc2G/rrujEi2f2hFUPe/gvHxDdF44M9VJ+eoaycnWquvD55Y/OjdnAq3O7Tfto8b6Ecfte3gHmOF0PRyrzHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAMLDQzB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAMLDQzB"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2165448243fso9430865ad.1
        for <bridge@lists.linux.dev>; Mon, 09 Dec 2024 06:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733752948; x=1734357748; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OAhPp2pGpsvDTqVI2eQ221kABd4Y8/kh7k1mWyeQzTw=;
        b=PAMLDQzBfJVJF9IEr7os7sHwScnYtbJ+ZUopBr/cF2wqrJLswC1qIDm8ySvnEZpPIN
         3vG1o8JsmLf74D1RSKqneBOb+DBv+C5D7zPT6idLss7wi2v58gZj7lSJ2pC1McwM/drR
         ph3rfun1kpVyRo0azasEopskJlllwmdC9119UU1lOEIG2jr307ON2Rx3T4jZhnMJAll2
         9n/CR7ZEIKnwbnNqmYgFKuvPi3Mb9LJsm9p+k2406/3VVSZd1prB90j7B2ftkOON68Aj
         0Ti3vVhMm1sTEy7Iwg/e38KN0egfSLSR6/wPQj1SJUArW32TKflGvUcAXOZAp7jZ4/hD
         LEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733752948; x=1734357748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OAhPp2pGpsvDTqVI2eQ221kABd4Y8/kh7k1mWyeQzTw=;
        b=JTyjsRjuR8R3D2HSm+hfEKAxt4Re+ZCqWAvjaWMpVQgmScsy4REe4jmYRWuDmLX3HZ
         bCpFXKmOI5Y9RWKw43aIKzsXFf31k4/5ljDB6zomtiVdLCUk4ocN27qMP7jRzE1bg2M9
         aNrkv0fD0ub+vWGjQxiXCgPyxvcHTDNDZI74QGvNp4LsHjv0RlQBQ7EMzQJEEV5KG8zK
         dCH4odEEq1LP0co3z3MfBdw6RfmdLD9D0fklgpiVi/3i2a1Lg+IxxkVlGmdjzub2GFx9
         42Q2VIrdBMjt0FwbHd3DfrUamZ3MT9Ow/KVDTqN7bFGW6VaK9PwrZlHPIXc9qaGCIaN7
         //hA==
X-Forwarded-Encrypted: i=1; AJvYcCVXLemK257vf1GYWO4c4aICPrJotYdexkuA2xkv1XSPQpN9i7ZHzVrV1MOeSodU75/TezNW/+E=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6LokzsH+/DLrAuGBFeVd03Gu6BfZltTD+W5ye7f5y3f24BdXz
	2e4zaFdRqmHEjtGfzllcroTUQSbAJRrIcS9U2lf4kENf7M44dcrr
X-Gm-Gg: ASbGncuBYeEEQ43YCbzqagrxo//9y85irsph50RjrbqBiXgCIywVgv52alAYejPdJKb
	+06SJZ2hxr07di+6HUL83X3KeUU7LgdRZX4qH1w7XXZqREEVHazatLCw0nkDVkHHy4PGxdHbkX8
	/qPjcJtkG7J9i/RcHMhnnRykkGjJ0Gi1aGPH4+DublG1TxwJv2aFvcM+g9C9FQ455Mp2q+l+UvO
	r8KkkEFM/AXoWO/pfg0kr5LPi5IktafZIcaOXWKy8Z8Rac=
X-Google-Smtp-Source: AGHT+IEziqjANISe8V7T1b1Vo9dS8nge43qoErTxjCtNhfTplDp9qnHGPIzO4tjQCtyFccSJFTBRCw==
X-Received: by 2002:a17:902:e74f:b0:216:4122:925f with SMTP id d9443c01a7336-21641229442mr90363145ad.14.1733752948110;
        Mon, 09 Dec 2024 06:02:28 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216221db645sm49605645ad.46.2024.12.09.06.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:02:26 -0800 (PST)
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
Subject: [PATCH net-next v5 0/5] net: Improve netns handling in RTNL and ip_tunnel
Date: Mon,  9 Dec 2024 22:01:46 +0800
Message-ID: <20241209140151.231257-1-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
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

v5:
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


Xiao Liang (5):
  net: ip_tunnel: Build flow in underlay net namespace
  rtnetlink: Lookup device in target netns when creating link
  rtnetlink: Decouple net namespaces in rtnl_newlink_create()
  selftests: net: Add python context manager for netns entering
  selftests: net: Add two test cases for link netns

 drivers/infiniband/ulp/ipoib/ipoib_netlink.c  | 11 +++--
 drivers/net/amt.c                             | 13 +++---
 drivers/net/bareudp.c                         | 11 +++--
 drivers/net/bonding/bond_netlink.c            |  8 ++--
 drivers/net/can/dev/netlink.c                 |  4 +-
 drivers/net/can/vxcan.c                       |  9 ++--
 .../ethernet/qualcomm/rmnet/rmnet_config.c    | 11 +++--
 drivers/net/geneve.c                          | 11 +++--
 drivers/net/gtp.c                             |  9 ++--
 drivers/net/ipvlan/ipvlan.h                   |  4 +-
 drivers/net/ipvlan/ipvlan_main.c              | 11 +++--
 drivers/net/ipvlan/ipvtap.c                   |  7 ++-
 drivers/net/macsec.c                          | 11 +++--
 drivers/net/macvlan.c                         |  8 ++--
 drivers/net/macvtap.c                         |  8 ++--
 drivers/net/netkit.c                          |  9 ++--
 drivers/net/pfcp.c                            |  8 ++--
 drivers/net/ppp/ppp_generic.c                 | 10 +++--
 drivers/net/team/team_core.c                  |  7 +--
 drivers/net/veth.c                            |  9 ++--
 drivers/net/vrf.c                             |  7 +--
 drivers/net/vxlan/vxlan_core.c                | 11 +++--
 drivers/net/wireguard/device.c                |  8 ++--
 drivers/net/wireless/virtual/virt_wifi.c      | 10 +++--
 drivers/net/wwan/wwan_core.c                  | 15 +++++--
 include/net/ip_tunnels.h                      |  5 ++-
 include/net/rtnetlink.h                       | 44 ++++++++++++++++---
 net/8021q/vlan_netlink.c                      | 11 +++--
 net/batman-adv/soft-interface.c               | 12 ++---
 net/bridge/br_netlink.c                       |  8 ++--
 net/caif/chnl_net.c                           |  6 +--
 net/core/rtnetlink.c                          | 35 ++++++++-------
 net/hsr/hsr_netlink.c                         | 14 +++---
 net/ieee802154/6lowpan/core.c                 |  9 ++--
 net/ipv4/ip_gre.c                             | 27 ++++++++----
 net/ipv4/ip_tunnel.c                          | 16 ++++---
 net/ipv4/ip_vti.c                             | 10 +++--
 net/ipv4/ipip.c                               | 10 +++--
 net/ipv6/ip6_gre.c                            | 28 +++++++-----
 net/ipv6/ip6_tunnel.c                         | 16 +++----
 net/ipv6/ip6_vti.c                            | 15 +++----
 net/ipv6/sit.c                                | 16 +++----
 net/xfrm/xfrm_interface_core.c                | 14 +++---
 tools/testing/selftests/net/Makefile          |  1 +
 .../testing/selftests/net/lib/py/__init__.py  |  2 +-
 tools/testing/selftests/net/lib/py/netns.py   | 18 ++++++++
 tools/testing/selftests/net/netns-name.sh     | 10 +++++
 tools/testing/selftests/net/netns_atomic.py   | 39 ++++++++++++++++
 48 files changed, 385 insertions(+), 211 deletions(-)
 create mode 100755 tools/testing/selftests/net/netns_atomic.py

-- 
2.47.1

