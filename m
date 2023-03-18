Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8A5A960899
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7D5E760A6F
From: "Hans J. Schultz" <netdev@kapio-technology.com>
Date: Sat, 18 Mar 2023 15:10:04 +0100
Message-Id: <20230318141010.513424-1-netdev@kapio-technology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v2 net-next 0/6] ATU and FDB synchronization on
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
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, "Hans J. Schultz" <netdev@kapio-technology.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Ido Schimmel <idosch@nvidia.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Hauke Mehrtens <hauke@hauke-m.de>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "maintainer:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>, "open list:RENESAS RZ/N1 A5PSW SWITCH DRIVER" <linux-renesas-soc@vger.kernel.org>, Vladimir Oltean <olteanv@gmail.com>

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

LOG:
	V2:	Ensure the port is locked when using the feature as we
		must ensure that learning is enabled at all times for
		the interrupts to occur. This was missed in the previous
		version.

		Instead of ignoring unsupported flags, ensure that
		drivers are only called when supporting the feature.
		As 'dynamic' flag is legacy, all drivers support it at
		least by their previous handling.

Hans J. Schultz (6):
  net: bridge: add dynamic flag to switchdev notifier
  net: dsa: propagate flags down towards drivers
  drivers: net: dsa: add fdb entry flags incoming to switchcore drivers
  net: bridge: ensure FDB offloaded flag is handled as needed
  net: dsa: mv88e6xxx: implementation of dynamic ATU entries
  selftests: forwarding: add dynamic FDB test

 drivers/net/dsa/b53/b53_common.c              |  4 +-
 drivers/net/dsa/b53/b53_priv.h                |  4 +-
 drivers/net/dsa/hirschmann/hellcreek.c        |  4 +-
 drivers/net/dsa/lan9303-core.c                |  4 +-
 drivers/net/dsa/lantiq_gswip.c                |  4 +-
 drivers/net/dsa/microchip/ksz_common.c        |  6 +-
 drivers/net/dsa/mt7530.c                      |  4 +-
 drivers/net/dsa/mv88e6xxx/chip.c              | 20 ++++--
 drivers/net/dsa/mv88e6xxx/chip.h              |  9 ++-
 drivers/net/dsa/mv88e6xxx/global1_atu.c       | 21 +++++++
 drivers/net/dsa/mv88e6xxx/port.c              |  6 +-
 drivers/net/dsa/mv88e6xxx/switchdev.c         | 61 +++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/switchdev.h         |  5 ++
 drivers/net/dsa/mv88e6xxx/trace.h             |  5 ++
 drivers/net/dsa/ocelot/felix.c                |  4 +-
 drivers/net/dsa/qca/qca8k-common.c            |  4 +-
 drivers/net/dsa/qca/qca8k.h                   |  4 +-
 drivers/net/dsa/rzn1_a5psw.c                  |  4 +-
 drivers/net/dsa/sja1105/sja1105_main.c        | 11 ++--
 include/net/dsa.h                             |  9 ++-
 include/net/switchdev.h                       |  1 +
 net/bridge/br_fdb.c                           |  5 +-
 net/bridge/br_switchdev.c                     |  1 +
 net/dsa/dsa.c                                 |  6 ++
 net/dsa/port.c                                | 28 +++++----
 net/dsa/port.h                                |  8 +--
 net/dsa/slave.c                               | 20 ++++--
 net/dsa/switch.c                              | 26 +++++---
 net/dsa/switch.h                              |  1 +
 .../net/forwarding/bridge_locked_port.sh      | 36 +++++++++++
 30 files changed, 258 insertions(+), 67 deletions(-)

-- 
2.34.1

