Return-Path: <Horatiu.Vultur@microchip.com>
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Mon, 26 Aug 2019 10:11:12 +0200
Message-ID: <1566807075-775-1-git-send-email-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH v2 0/3] Add NETIF_F_HW_BR_CAP feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com, davem@davemloft.net, UNGLinuxDriver@microchip.com, alexandre.belloni@bootlin.com, allan.nielsen@microchip.com, andrew@lunn.ch, f.fainelli@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

When a network port is added to a bridge then the port is added in
promisc mode. Some HW that has bridge capabilities(can learn, forward,
flood etc the frames) they are disabling promisc mode in the network
driver when the port is added to the SW bridge.

This patch adds the feature NETIF_F_HW_BR_CAP so that the network ports
that have this feature will not be set in promisc mode when they are
added to a SW bridge.

In this way the HW that has bridge capabilities don't need to send all the
traffic to the CPU and can also implement the promisc mode and toggle it
using the command 'ip link set dev swp promisc on'

v1 -> v2
  - rename feature to NETIF_F_HW_BR_CAP
  - add better description in the commit message and in the code
  - remove the check that all network driver have same netdev_ops and
    just check for the feature NETIF_F_HW_BR_CAP when setting the network
    port in promisc mode.


Horatiu Vultur (3):
  net: Add NETIF_HW_BR_CAP feature
  net: mscc: Use NETIF_F_HW_BR_CAP
  net: mscc: Implement promisc mode.

 drivers/net/ethernet/mscc/ocelot.c | 26 ++++++++++++++++++++++++--
 include/linux/netdev_features.h    |  6 ++++++
 net/bridge/br_if.c                 | 11 ++++++++++-
 net/core/ethtool.c                 |  1 +
 4 files changed, 41 insertions(+), 3 deletions(-)

-- 
2.7.4

