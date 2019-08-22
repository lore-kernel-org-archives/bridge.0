Return-Path: <Horatiu.Vultur@microchip.com>
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Thu, 22 Aug 2019 21:07:27 +0200
Message-ID: <1566500850-6247-1-git-send-email-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH 0/3] Add NETIF_F_HW_BRIDGE feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com, davem@davemloft.net, UNGLinuxDriver@microchip.com, alexandre.belloni@bootlin.com, allan.nielsen@microchip.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

Current implementation of the SW bridge is setting the interfaces in
promisc mode when they are added to bridge if learning of the frames is
enabled.
In case of Ocelot which has HW capabilities to switch frames, it is not
needed to set the ports in promisc mode because the HW already capable of
doing that. Therefore add NETIF_F_HW_BRIDGE feature to indicate that the
HW has bridge capabilities. Therefore the SW bridge doesn't need to set
the ports in promisc mode to do the switching.
This optimization takes places only if all the interfaces that are part
of the bridge have this flag and have the same network driver.

If the bridge interfaces is added in promisc mode then also the ports part
of the bridge are set in promisc mode.

Horatiu Vultur (3):
  net: Add HW_BRIDGE offload feature
  net: mscc: Use NETIF_F_HW_BRIDGE
  net: mscc: Implement promisc mode.

 drivers/net/ethernet/mscc/ocelot.c | 26 ++++++++++++++++++++++++--
 include/linux/netdev_features.h    |  3 +++
 net/bridge/br_if.c                 | 29 ++++++++++++++++++++++++++++-
 net/core/ethtool.c                 |  1 +
 4 files changed, 56 insertions(+), 3 deletions(-)

-- 
2.7.4

