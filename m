Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B0A23D281
	for <bridge@lists.linux.dev>; Tue,  2 Jun 2026 00:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780361070; cv=none; b=NypITAmRnG3YA0+o54aXsFERu4VOggxe04vsRsbkCz7ouRFU4kCvE4KLFofz8P3wfMuGWdCEbZwQSb3KXGzaPpIxwvTZCGxhpaAxCjhN0hgyfMh7BjptNkLagC8sY2AJ1DVv1QYOYhXz/uuA80A5GVRsXque2sYeenyXXu2mxSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780361070; c=relaxed/simple;
	bh=+yvfrARDNjLAM5hzlSCSmgRMJgjXz/9ld+SpFwiMcHY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z3JJU6y05ZdK0OjWX0+xbyqqSB7y1b6EPZzEQKaaif3krk50uV732BORQfrcKBU7sJE8peM1R9Wv03RHxNIdh41GcVamvtrL6YKKNBLNx5qkkiMMQePuAMDrhq22OzSBV2S8fpJcMnkgL1hlf/h98lCa6rJ25ehWvYhNpRD+Qm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=0I85DZY6; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="0I85DZY6"
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 6520hx8q030351
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 2 Jun 2026 01:44:01 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 6520hx8q030351
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780361047; bh=U5fbd+4OYwQo2IUaE6Gnue3M4uX5NasiSyDNmf693TA=;
	h=From:Subject:Date:To:Cc:From;
	b=0I85DZY6SdPLps5K7WH8vgtN/l2igfQSEe2MBbhZtcU1WkjVtTJjm506w+UnWAk9n
	 nXHJL7KYlZuphshBL5u81c3lY91p7t5qJJprH6l8ihyTjk3IMO0zxbfrM345V7GUza
	 qzYFX+Zh30iwXJbDmYQZZMjW7AffR/S94k6z5S3Cx1UaQ/G9p0q2QhuXjEepztohQ7
	 +qjLyCAe1FOm9bhIZ4I+M1XbhZLfiSI4ZzrpF/0MMj5hIoEK0OhFANEUEsizU5wPaQ
	 cAnsq1/icj78vMYi+iWtZjpniBISbvtCYRwmlRYT6K0QeC8RlVJCyJPDcNF9uRKTBf
	 +oe2mHfwTxbkA==
From: Luke Howard <lukeh@padl.com>
Subject: [PATCH net-next v2 0/6] net: dsa: mv8ee6xxx: MQPRIO and 802.1Qat
 support
Date: Tue, 02 Jun 2026 10:43:45 +1000
Message-Id: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEQnHmoC/02OQW7DIBBFr2KxLhJMnAF8lSgLPB5aKtmOgVhIU
 e5e3KZVl18z/73/EJlT5CyG7iES7zHHdWkB3jpBH355ZxmnlgUoQIUK5Lxby1hrlVaB3nyR83Z
 LcZU9BuoRJ6NYi1a/JQ6xfqMvYuEiF65FXH8u+T5+MpWD/PpNvN2bvbwKf/K25VD3JyV/If820
 JglaNAaHXmPdtj7gzf6zJLWeY5l6JRTSFqbYDWBZ2ScxuAtGO2CcWTOrMmd4Cyuz+cXLUkDHBA
 BAAA=
X-Change-ID: 20260602-mv88e6xxx-8021qat-mqprio-46fc466d70e1
To: Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bridge@lists.linux.dev, linux-kselftest@vger.kernel.org,
        Max Hunter <max@huntershome.org>, Kieran Tyrrell <kieran@sienda.com>,
        Luke Howard <lukeh@padl.com>
X-Mailer: b4 0.15.2

This patch series introduces the hooks necessary for a user space
implementation of the 802.1Qat Stream Reservation Protocol (SRP) to
enforce admission control of reserved streams using specific frame
priorities and destination MAC addresses. This is typically combined
with a traffic shaper such as the Credit Based Shaper (CBS) so that
bandwidth can be reserved for AVB/TSN streams.

The patch adds a new flag, MDB_FLAGS_STREAM_RESERVED, that marks a
multicast destination address as belonging to a "reserved" stream.
Ingress ports with the new BR_FILTER_STREAM_RESERVED flag set will
drop any frames whose 802.1p priorities map (via MQPRIO/TAPRIO) to
a non-zero traffic class, and whose destination addresses lack a
MDB entry with MDB_FLAGS_STREAM_RESERVED set.

802.1Qat admission control is implemented for both the software
bridge and the Marvell MV88E6XXX switch chips with AVB support.
New tests are added to the former.

Whilst 802.1Qat does permit the use of SRP for unicast destination
addresses, this is relatively uncommon in practice and is not
supported by this patch series.

In order to fully support 802.1Qat with hardware offloading on the
MV88E6XXX switch chips, we added support for MQPRIO to those chips
which have more than one transmit queue, with the following modes:

* AVB mode (MQPRIO DCB mode), which enables AVB features on supporting
  switch chips such as BR_FILTER_STREAM_RESERVED; traffic classes map
  to AVB classes, with TC0 representing non-AVB traffic. This is the
  only MQPRIO mode that supports 802.1Qat stream admission, but it can
  also be used for general traffic classification by not setting the
  BR_FILTER_STREAM_RESERVED on the switch ports. However, it is limited
  to three traffic classes, and the configuration is shared by all ports
  (even on the 88E6390 family of chips).

* Channel mode (MQPRIO channel mode), which does not enable 802.1Qat/AVB
  features but supports a more flexible priority to queue mapping,
  particularly on the 88E6390 family of switches where the mapping can be
  configured per port, rather than per chip. In this mode, traffic classes
  map directly to switch QPris (i.e. queues).

Changes since v1:
- dropped CBS implementation (this is provided separately by Cedric
  Jehasse's patch series [1], and is required for its definition of
  num_tx_queues and qav_info)
- added MQPRIO channel support, as well as per-port queue configuration
  for the 6390 family
- admission control is configured using a bridge port flag rather than
  a device tree entry
- software bridge support for admission control
- Link to v1: https://lore.kernel.org/all/cover.1779841530.git.lukeh@padl.com/

[1] https://lore.kernel.org/all/20260528-net-next-mv88e6xxx-cbs-v4-0-8bd13b906457@luminex.be/

Signed-off-by: Luke Howard <lukeh@padl.com>
---
Luke Howard (6):
      net: bridge: mdb: add MDB_FLAGS_STREAM_RESERVED flag
      net: bridge: convert mdb_entry host_joined to a flags field
      net: bridge: add 802.1Qat stream reservation admission control
      net: bridge: allow MDB_FLAGS_STREAM_RESERVED on host groups
      net: dsa: mv88e6xxx: MQPRIO support
      net: dsa: mv88e6xxx: honour MDB_FLAGS_STREAM_RESERVED for AVB streams

 drivers/net/dsa/mv88e6xxx/Makefile                 |   3 +-
 drivers/net/dsa/mv88e6xxx/avb.c                    | 221 +++++++
 drivers/net/dsa/mv88e6xxx/avb.h                    |  79 +++
 drivers/net/dsa/mv88e6xxx/chip.c                   | 507 +++++++++++++++-
 drivers/net/dsa/mv88e6xxx/chip.h                   |  68 ++-
 drivers/net/dsa/mv88e6xxx/global1.c                |  28 +-
 drivers/net/dsa/mv88e6xxx/global1.h                |   6 +-
 drivers/net/dsa/mv88e6xxx/global1_atu.c            |  17 +
 drivers/net/dsa/mv88e6xxx/global2.h                |   2 +
 drivers/net/dsa/mv88e6xxx/global2_avb.c            | 121 ++++
 drivers/net/dsa/mv88e6xxx/port.c                   |  18 +
 drivers/net/dsa/mv88e6xxx/port.h                   |   2 +
 include/linux/if_bridge.h                          |   1 +
 include/net/switchdev.h                            |   4 +
 include/uapi/linux/if_bridge.h                     |   7 +
 include/uapi/linux/if_link.h                       |   9 +
 net/bridge/Kconfig                                 |  22 +
 net/bridge/br_input.c                              |  61 +-
 net/bridge/br_mdb.c                                | 103 ++--
 net/bridge/br_multicast.c                          |  49 +-
 net/bridge/br_netlink.c                            |   8 +-
 net/bridge/br_private.h                            |  22 +-
 net/bridge/br_switchdev.c                          |  22 +-
 net/core/rtnetlink.c                               |   2 +-
 tools/testing/selftests/net/forwarding/Makefile    |   1 +
 .../net/forwarding/bridge_mdb_stream_reserved.sh   | 653 +++++++++++++++++++++
 tools/testing/selftests/net/forwarding/config      |   2 +
 27 files changed, 1933 insertions(+), 105 deletions(-)
---
base-commit: 0906c117f81c2ae6e6dbfa82719f79c75e1c9325
change-id: 20260602-mv88e6xxx-8021qat-mqprio-46fc466d70e1
prerequisite-change-id: 20260430-net-next-mv88e6xxx-cbs-2121169caa68:v4
prerequisite-patch-id: 8ad59c43368d4639e0cabcc59a7f6e487560d3f7
prerequisite-patch-id: 90cce4d7dadbead4f10cdd0493129b88abf0be75

Best regards,
--  
Luke Howard <lukeh@padl.com>

