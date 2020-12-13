Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+5rd7hxSU1RvLcEtYHVa4mtvgaZoy4+z3dy9/uQ/gE=;
 b=JVkmiz6J4ikj7q5sP7zhiUM14KjbmVwAHga4YCpfYUc/3TF7KWE05ERl5vvvrvb+kpve58YKM4eU+ubcBk3xGpBtxUhXDjTaEjejs5sAIXzK8pkuwj54rO6/encrN0+gIBXiePiVZhtNJjvRg5vFUUBl7PGUQD4jxj3+6TB0mk4=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Sun, 13 Dec 2020 04:40:12 +0200
Message-Id: <20201213024018.772586-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH v2 net-next 0/6] Offload software learnt bridge
	addresses to DSA
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>, Vivien Didelot <vivien.didelot@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, "David S. Miller" <davem@davemloft.net>
Cc: Jiri Pirko <jiri@resnulli.us>, Alexandra Winter <wintera@linux.ibm.com>, Ido Schimmel <idosch@idosch.org>, Russell King - ARM Linux admin <linux@armlinux.org.uk>, Marek Behun <marek.behun@nic.cz>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Tobias Waldekranz <tobias@waldekranz.com>

This small series tries to make DSA behave a bit more sanely when
bridged with "foreign" (non-DSA) interfaces. When a station A connected
to a DSA switch port needs to talk to another station B connected to a
non-DSA port through the Linux bridge, DSA must explicitly add a route
for station B towards its CPU port. It cannot rely on hardware address
learning for that.

Initial RFC was posted here:
https://www.spinics.net/lists/netdev/msg698169.html

Vladimir Oltean (6):
  net: bridge: notify switchdev of disappearance of old FDB entry upon
    migration
  net: dsa: don't use switchdev_notifier_fdb_info in
    dsa_switchdev_event_work
  net: dsa: move switchdev event implementation under the same
    switch/case statement
  net: dsa: exit early in dsa_slave_switchdev_event if we can't program
    the FDB
  net: dsa: listen for SWITCHDEV_{FDB,DEL}_ADD_TO_DEVICE on foreign
    bridge neighbors
  net: dsa: ocelot: request DSA to fix up lack of address learning on
    CPU port

 drivers/net/dsa/ocelot/felix.c |   1 +
 include/net/dsa.h              |   5 +
 net/bridge/br_fdb.c            |   1 +
 net/dsa/dsa_priv.h             |  12 +++
 net/dsa/slave.c                | 167 +++++++++++++++++++++------------
 5 files changed, 124 insertions(+), 62 deletions(-)

-- 
2.25.1

