Return-Path: <Joseph.Huang@garmin.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pps1; bh=8iNYorplWhEtYzy2kH7zXs3Mm5yOXeiK29CMkgf43V4=;
 b=jGNBDbIxNhnmUQ9EshosZcYvtJE2h7joP25r6IVRRcpVlksy3Cn5MFPT04GTY3Jw/X0d
 GoMl1xr/yfT8jxd/lBrVPsa0J+fHGG7IussM3Mov/Ugi+rdquF5z7RUKBUXFbYhpeOdw
 +FMhjagLOhBjqXGJKDsQ1LGtDWEshsfjfIOye4WXuMJ/ru4mNAFFZoynR7P0yLgwR4KS
 J05VoA8s48DRcQTRFuyZAd4+EXn2V8b+AHKFlB1GrndEUyij3wSFDB1je/D54tBENABH
 HsfT88/XgLjtKtiGXppGj6WqK0tZrlrAPYR+lAobcOGGUJM2KdX8ZR0TxIPo9X4i02Ox 5w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=garmin.onmicrosoft.com; s=selector1-garmin-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8iNYorplWhEtYzy2kH7zXs3Mm5yOXeiK29CMkgf43V4=;
 b=n1CzGvq5Q3MLlXWtyhcqdOawaU9z45soeUxzPkec8AklZQcNgbX/rs6zMadZjH0xpVhsKJNSA4ozFBTEXB1lKzWjH0lTbcjPr5cKIkcj18itUwQtQe61zOMLkzppZBMqm4hvg2fyS15iSKl284ce/sfCX3NaxcEv4OTLo82UDnwzUDBbDEHTl8eL6joxVF5d6/TMUGrYZuzeBhQoBbz8fYk8m9WQPOuq2NzqIWe3eMqQrtIAxZp+URrI5kJ7AGO3W9wZOuoW9g2czWIKC5LCn3g9xx1XAH+EJqdhjMXc4LBWEyKqLZxlKeCoNJ3t9R2iNjxjK40fZKJ9FPUFf2keKg==
From: Joseph Huang <Joseph.Huang@garmin.com>
Date: Tue, 4 May 2021 14:22:53 -0400
Message-ID: <20210504182259.5042-1-Joseph.Huang@garmin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net 0/6] bridge: Fix snooping in multi-bridge
	config with switchdev
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Joseph Huang <Joseph.Huang@garmin.com>

This series of patches contains the following fixes:

1. In a distributed system with multiple hardware-offloading bridges,
   if a multicast source is attached to a Non-Querier bridge, the bridge
   will not forward any multicast packets from that source to the Querier.

                    +--------------------+
                    |                    |
                    |      Snooping      |    +------------+
                    |      Bridge 1      |----| Listener 1 |
                    |     (Querier)      |    +------------+
                    |                    |
                    +--------------------+
                              |
                              |
                    +----+---------+-----+
                    |    | mrouter |     |
   +-----------+    |    +---------+     |    +------------+
   | MC Source |----|      Snooping      |----| Listener 2 |
   +-----------|    |      Bridge 2      |    +------------+
                    |    (Non-Querier)   |
                    +--------------------+

   In this scenario, Listener 1 will never receive multicast traffic
   from MC Source since Snooping Bridge 2 does not forward multicast
   packets to the mrouter port. Patches 0001, 0002, and 0003 address
   this issue.

2. If mcast_flood is disabled on a bridge port, some of the snooping
   functions stop working properly.

   a. Consider the following scenario:

                       +--------------------+
                       |                    |
                       |      Snooping      |    +------------+
                       |      Bridge 1      |----| Listener 1 |
                       |     (Querier)      |    +------------+
                       |                    |
                       +--------------------+
                                 |
                                 |
                       +--------------------+
                       |    | mrouter |     |
      +-----------+    |    +---------+     |
      | MC Source |----|      Snooping      |
      +-----------|    |      Bridge 2      |
                       |    (Non-Querier)   |
                       +--------------------+

      In this scenario, Listener 1 will never receive multicast traffic
      from MC Source if mcast_flood is disabled on the mrouter port on
      Snooping Bridge 2. Patch 0004 addresses this issue.

   b. For a Non-Querier bridge, if mcast_flood is disabled on a bridge
      port, Queries received from other Querier will not be forwarded
      out of that bridge port. Patch 0005 addresses this issue.

3. After a system boots up, the first couple Reports are not handled
   properly:

   1) the Report from the Host is being flooded (via br_flood) to all
      bridge ports, and
   2) if the mrouter port's mcast_flood is disabled, the Reports received
      from other hosts will not be forwarded to the Querier.

   Patch 0006 addresses this issue.

These patches were developed and verified initially against 5.4 kernel
(due to hardware platform limitation) and forward-patched to 5.12.
Snooping code introduced between 5.4 and 5.12 are not extensively tested
(only IGMPv2/MLDv1 were tested). The hardware platform used were two
bridges utilizing a single Marvell 88E6352 Ethernet switch chip (i.e.,
no cross-chip bridging involved).

Joseph Huang (6):
  bridge: Refactor br_mdb_notify
  bridge: Offload mrouter port forwarding to switchdev
  bridge: Avoid traffic disruption when Querier state changes
  bridge: Force mcast_flooding for mrouter ports
  bridge: Flood Queries even when mcast_flood is disabled
  bridge: Always multicast_flood Reports

 net/bridge/br_device.c    |   5 +-
 net/bridge/br_forward.c   |   3 +-
 net/bridge/br_input.c     |   5 +-
 net/bridge/br_mdb.c       |  70 +++++++++++++---------
 net/bridge/br_multicast.c | 121 ++++++++++++++++++++++++++++++++++----
 net/bridge/br_private.h   |  11 +++-
 6 files changed, 169 insertions(+), 46 deletions(-)


base-commit: 5e321ded302da4d8c5d5dd953423d9b748ab3775
-- 
2.17.1

