Return-Path: <troglobit@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version:organization
 :content-transfer-encoding;
 bh=KP4a5Nq5xLfHHBjrnafFha3MFdJr67mljPaP7U+xutA=;
 b=F1Dl0ogpPpEfisEpBYoUipD0dtHfWYZsL+vsWu36yEcuSnNWht4iB9T1IjrVDNe+oA
 wmM7GmbVwYTm+tzx12ALZ9nrfvLtBsh1cOkktEHvS7YhbjL+YtND53Wgg7IEe9rsOvvv
 LDdhVTta2Xu2Z4RDG0OmzHfuryBWnrogT1WHfoxfXTYa4IyIinbz5uRNw1QEvQQX3N9q
 KZyOPbrJhJHwxIcO/SHOqZbCCdW5rLHrJ5hK8bi2WMvc3wb+EYhaHhDl/2r7ylQc5MRH
 T57oax7TN3zqjTm/2bp6gct/420puw8j5X9LGnYpCmhF/vb9aF+XK2II+IJ15KhsSR7a
 oaDw==
From: Joachim Wiberg <troglobit@gmail.com>
Date: Mon, 11 Apr 2022 15:38:24 +0200
Message-Id: <20220411133837.318876-1-troglobit@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH RFC net-next 00/13] net: bridge: forwarding of
	unknown IPv4/IPv6/MAC BUM traffic
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Vladimir Oltean <vladimir.oltean@nxp.com>, Joachim Wiberg <troglobit@gmail.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

This is a proposal to improve forwarding control of BUM traffic to the
bridge itself.  Another, related, issue regarding loss of function when
an IP multicast router is detected, is also brought up here which can be
a separate series in v2.

First, we add BROPT_BCAST_FLOOD, BROPT_UNICAST_FLOOD, BROPT_MCAST_FLOOD
flags for unknown traffic to the bridge itself, with netlink support and
a selftest.  We ensure backwards compatible forwarding behavior is
preserved by enabling these flags by default.  Please note however,
these flags do not affect the behavior of IFF_PROMISC on the bridge
interface.

Second, and with the above in place, we set out to verify flooding of
unknown *and* known multicast to regular bridge ports, including the
bridge itself.  We use `tcpdump -p` in the tests to ensure we do not
trigger IFF_PROIMISC.  Unknown multicast should be forwarded according
to the MCAST_FLOOD flag, and known multicast according the MDB and to
multicast router ports.

We find that forwarding of unknown IP multicast stops[1] as soon as a
multicast router is known.  Affecting all ports, including the bridge
itself (this series).  The root cause for this is the classification
`mrouters_only` in br_multicast_rcv().

Dropping this classification of unknown IP multicast and moving the
multicast flow handling from br_multicast_flood() to br_flood() fixes
this problem.  The bridge now properly floods all unknown multicast, and
this can now be controlled using the MCAST_FLOOD flag on all ports
including the bridge itself.

The use of br_flood() opens up the need for the multicast 'rport' API,
but that is behind CONFIG_BRIDGE_IGMP_SNOOPING, which is the primary
reason for this being an RFC series.  I'd love some feedback on how to
go about all this, opening up that API and even the take on the issue as
a whole.

Honestly, despite taking great care to not change the bridge's default
behavior the patch series in itself propose quite radical changes that
alone mandate RFC status at this point.  There has been some discussion
already on this in 20220410220324.4c3l3idubwi3w6if@skbuf and I expect
more disucssion here.

Note: this series builds upon my previous patch for host l2 mdb entries,
      20220411084054.298807-1-troglobit@gmail.com, extending the test
      bridge_mdb.sh

Best regards
 /Joachim

[1]: MAC multicast is not affected.

net/bridge/br_device.c                        |   4 +
 net/bridge/br_forward.c                       |  11 +
 net/bridge/br_input.c                         |  11 +-
 net/bridge/br_multicast.c                     |   6 +-
 net/bridge/br_netlink.c                       | 170 +++++++---
 net/bridge/br_private.h                       |   7 +-
 net/bridge/br_switchdev.c                     |   8 +-
 net/bridge/br_sysfs_if.c                      |   2 +-
 .../drivers/net/ocelot/tc_flower_chains.sh    |  24 +-
 .../testing/selftests/net/forwarding/Makefile |   3 +-
 .../selftests/net/forwarding/bridge_flood.sh  | 170 ++++++++++
 .../selftests/net/forwarding/bridge_mdb.sh    | 321 +++++++++++++++++-
 tools/testing/selftests/net/forwarding/lib.sh |  33 +-
 13 files changed, 683 insertions(+), 87 deletions(-)
 create mode 100755 tools/testing/selftests/net/forwarding/bridge_flood.sh
 mode change 100644 => 100755 tools/testing/selftests/net/forwarding/lib.sh
