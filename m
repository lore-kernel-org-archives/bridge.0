Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C5BD9401C9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 064BE400D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHbYCIWMhA6l09LiALAANqrPHZSYZKq7H7AjC56bCpY=;
 b=tKPcJfwUih/+MQeOO9m95gywE+Q9MZn+fsyk0TPGX1pWLDnCD4WbBpDqqTwZpHoBcNDZVADPxNLXtIW19DspMe1X7xFxH9kC7fMAxxwbseLwfbsWGG2Kyio64wj3aUllHBORH45RQAJ8oBl8FyXjqawVt47XwZYcV9rGCTTFOnjKvYKZpANj/dbTLd35p3irdyw+veEkbDkwvLz0jO417ZaW9RbFp6FR528rbFpqP5dLEMzW/7W6qyIe4tbRmUyUmQp3qnS3UJG0dTi1jfOiaLTeU6jL6REpywKtUl0bFZHplYluJu0mp1m876lbS5sKlDX5t6bZP1IC/imlSvw6tg==
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue,  1 Nov 2022 21:39:20 +0200
Message-Id: <20221101193922.2125323-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 0/2] bridge: Add MAC Authentication Bypass
	(MAB) support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: vladimir.oltean@nxp.com, razor@blackwall.org, netdev@kapio-technology.com, Ido Schimmel <idosch@nvidia.com>, edumazet@google.com, mlxsw@nvidia.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

Patch #1 adds MAB support in the bridge driver. See the commit message
for motivation, design choices and implementation details.

Patch #2 adds corresponding test cases.

Follow-up patchsets will add offload support in mlxsw and mv88e6xxx.

Hans J. Schultz (2):
  bridge: Add MAC Authentication Bypass (MAB) support
  selftests: forwarding: Add MAC Authentication Bypass (MAB) test cases

 include/linux/if_bridge.h                     |   1 +
 include/uapi/linux/if_link.h                  |   1 +
 include/uapi/linux/neighbour.h                |   8 +-
 net/bridge/br_fdb.c                           |  24 +++
 net/bridge/br_input.c                         |  21 ++-
 net/bridge/br_netlink.c                       |  21 ++-
 net/bridge/br_private.h                       |   3 +-
 net/core/rtnetlink.c                          |   5 +
 .../net/forwarding/bridge_locked_port.sh      | 155 +++++++++++++++++-
 tools/testing/selftests/net/forwarding/lib.sh |   8 +
 10 files changed, 241 insertions(+), 6 deletions(-)

-- 
2.37.3

