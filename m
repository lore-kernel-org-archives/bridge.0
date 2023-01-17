Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CE8B98128B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 123AB8129E
From: "Hans J. Schultz" <netdev@kapio-technology.com>
Date: Tue, 17 Jan 2023 19:57:09 +0100
Message-Id: <20230117185714.3058453-1-netdev@kapio-technology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [RFC PATCH net-next 0/5] ATU and FDB synchronization on
	locked ports
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, "Hans J. Schultz" <netdev@kapio-technology.com>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "maintainer:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, "open list:RENESAS RZ/N1 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>, Vladimir Oltean <olteanv@gmail.com>

This patch set makes it possible to have synchronized dynamic ATU and FDB
entries on locked ports. As locked ports are not able to automatically
learn, they depend on userspace added entries, where userspace can add
static or dynamic entries. The lifetime of static entries are completely
dependent on userspace intervention, and thus not of interest here. We
are only concerned with dynamic entries, which can be added with a
command like:

bridge fdb replace ADDR dev <DEV> master dynamic

We choose only to support this feature on locked ports, as it involves
utilizing the CPU to handle ATU related switchcore events (typically
interrupts) and thus can result in significant performance loss if
exposed to heavy traffic.

On locked ports it is important for userspace to know when an authorized
station has become silent, hence not breaking the communication of a
station that has been authorized based on the MAC-Authentication Bypass
(MAB) scheme. Thus if the station keeps being active after authorization,
it will continue to have an open port as long as it is active. Only after
a silent period will it have to be reauthorized. As the ageing process in
the ATU is dependent on incoming traffic to the switchcore port, it is
necessary for the ATU to signal that an entry has aged out, so that the
FDB can be updated at the correct time.

This patch set includes a solution for the Marvell mv88e6xxx driver, where
for this driver we use the Hold-At-One feature so that an age-out
violation interrupt occurs when a station has been silent for the
system-set age time. The age out violation interrupt allows the switchcore
driver to remove both the ATU and the FDB entry at the same time.

It is up to the maintainers of other switchcore drivers to implement the
feature for their specific driver.

Hans J. Schultz (5):
  net: bridge: add dynamic flag to switchdev notifier
  net: dsa: propagate flags down towards drivers
  drivers: net: dsa: add fdb entry flags incoming to switchcore drivers
  net: bridge: ensure FDB offloaded flag is handled as needed
  net: dsa: mv88e6xxx: implementation of dynamic ATU entries

 drivers/net/dsa/b53/b53_common.c        | 12 ++++-
 drivers/net/dsa/b53/b53_priv.h          |  4 +-
 drivers/net/dsa/hirschmann/hellcreek.c  | 12 ++++-
 drivers/net/dsa/lan9303-core.c          | 12 ++++-
 drivers/net/dsa/lantiq_gswip.c          | 12 ++++-
 drivers/net/dsa/microchip/ksz9477.c     |  8 ++--
 drivers/net/dsa/microchip/ksz9477.h     |  8 ++--
 drivers/net/dsa/microchip/ksz_common.c  | 14 ++++--
 drivers/net/dsa/mt7530.c                | 12 ++++-
 drivers/net/dsa/mv88e6xxx/chip.c        | 24 ++++++++--
 drivers/net/dsa/mv88e6xxx/global1_atu.c | 21 +++++++++
 drivers/net/dsa/mv88e6xxx/port.c        |  6 ++-
 drivers/net/dsa/mv88e6xxx/switchdev.c   | 61 +++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/switchdev.h   |  5 ++
 drivers/net/dsa/mv88e6xxx/trace.h       |  5 ++
 drivers/net/dsa/ocelot/felix.c          | 12 ++++-
 drivers/net/dsa/qca/qca8k-common.c      | 12 ++++-
 drivers/net/dsa/qca/qca8k.h             |  4 +-
 drivers/net/dsa/rzn1_a5psw.c            | 12 ++++-
 drivers/net/dsa/sja1105/sja1105_main.c  | 19 ++++++--
 include/net/dsa.h                       |  6 ++-
 include/net/switchdev.h                 |  1 +
 net/bridge/br_fdb.c                     |  5 +-
 net/bridge/br_switchdev.c               |  1 +
 net/dsa/port.c                          | 28 +++++++-----
 net/dsa/port.h                          |  8 ++--
 net/dsa/slave.c                         | 17 +++++--
 net/dsa/switch.c                        | 30 ++++++++----
 net/dsa/switch.h                        |  1 +
 29 files changed, 298 insertions(+), 74 deletions(-)

-- 
2.34.1

