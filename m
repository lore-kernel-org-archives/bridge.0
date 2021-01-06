Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wFYVdNCGZo254Md4m2v48sFF9I2fZhhCJRCbYo96ynw=;
 b=r2hEt3YhyZtRbtTbKEgM7AOCqI7maZ7J138o7yqh2U812EyJXex68bYOO1VKErnc7a
 TyfLHIvKIAN4jpLN8ISxdbLNv5IGt6zkxgcqC8Zfj+O0TPMTrjyfeYatRMLY3rPQnPV9
 WHooaDbovRFSuCmtx1hbVe13OkZL+o8IkJwLi5v2X2etGgPp7z61ORFGyvkwknDoqaTy
 OZgvBQoXxLT2LhjIOllhwVtZBGj7ehBLwJ8dh0AJZzj2qqWbu/Aj5n6inx9EBArJQlW/
 EWDrGYPKnqKaayDO+8Ke/iXzt1PnKp22uvAd/uQlcBfKvO1YD7AYlqDdKMdg+UHGP8JK
 9zLg==
From: Vladimir Oltean <olteanv@gmail.com>
Date: Wed,  6 Jan 2021 11:51:29 +0200
Message-Id: <20210106095136.224739-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v4 net-next 0/7] Offload software learnt bridge
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
Cc: Jiri Pirko <jiri@resnulli.us>, Alexandra Winter <wintera@linux.ibm.com>, Ido Schimmel <idosch@idosch.org>, Russell King - ARM Linux admin <linux@armlinux.org.uk>, Marek Behun <marek.behun@nic.cz>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, UNGLinuxDriver@microchip.com, Tobias Waldekranz <tobias@waldekranz.com>

From: Vladimir Oltean <vladimir.oltean@nxp.com>

This series tries to make DSA behave a bit more sanely when bridged with
"foreign" (non-DSA) interfaces and source address learning is not
supported on the hardware CPU port (which would make things work more
seamlessly without software intervention). When a station A connected to
a DSA switch port needs to talk to another station B connected to a
non-DSA port through the Linux bridge, DSA must explicitly add a route
for station B towards its CPU port.

Initial RFC was posted here:
https://patchwork.ozlabs.org/project/netdev/cover/20201108131953.2462644-1-olteanv@gmail.com/

v2 was posted here:
https://patchwork.kernel.org/project/netdevbpf/cover/20201213024018.772586-1-vladimir.oltean@nxp.com/

v3 was posted here:
https://patchwork.kernel.org/project/netdevbpf/cover/20201213140710.1198050-1-vladimir.oltean@nxp.com/

This is a resend of the previous v3 with some added Reviewed-by tags.

Vladimir Oltean (7):
  net: bridge: notify switchdev of disappearance of old FDB entry upon
    migration
  net: dsa: be louder when a non-legacy FDB operation fails
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
 net/dsa/slave.c                | 174 +++++++++++++++++++++------------
 5 files changed, 130 insertions(+), 63 deletions(-)

-- 
2.25.1

