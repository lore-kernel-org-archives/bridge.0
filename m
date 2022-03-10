Return-Path: <schultz.hans@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version:organization
 :content-transfer-encoding;
 bh=1DB/xtUlg/bv2cuDVJn+P6RhKyQoRLt8abFtk957r6s=;
 b=KBGIzYMTJcy4uw8dS+TAg5MvLQFgLkwp2dDT3D+ltBEnHvsAQgnYDBZONyDk4w0Axx
 PVVD6ezuq5vH+cvZ8jHllKjdd9G/oTQggbuVa29313tGszcpcO5A+42DVTsP4sEtPJHF
 rFjfeJuRAa5OeLyH49lDkzNLaQ+ThCDPZaQZkOxXNmni4mfRJIJ2M+kpomLff6L1IyaI
 IU6tc5P1rlt0jsPyBlbYcETV/4IuQE/F2ezJU9KzTltndoCqOhlqnl4s3BW80ekQ1MX4
 Q9fbbhfYZdo9jE310hgPS9x8zUdqvoRiuNEGZUeWuslxgEBq1cjHHLvNNBpY6gAUvjyL
 mkWg==
From: Hans Schultz <schultz.hans@gmail.com>
Date: Thu, 10 Mar 2022 14:36:14 +0100
Message-Id: <20220310133617.575673-1-schultz.hans+netdev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH iproute2-next 0/3] Extend locked port feature with
	FDB locked flag (MAC-Auth/MAB)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Hans Schultz <schultz.hans+netdev@gmail.com>, Roopa Prabhu <roopa@nvidia.com>, Vladimir Oltean <olteanv@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>

This patch set extends the locked port feature for devices
that are behind a locked port, but do not have the ability to
authorize themselves as a supplicant using IEEE 802.1X.
Such devices can be printers, meters or anything related to
fixed installations. Instead of 802.1X authorization, devices
can get access based on their MAC addresses being whitelisted.

For an authorization daemon to detect that a device is trying
to get access through a locked port, the bridge will add the
MAC address of the device to the FDB with a locked flag to it.
Thus the authorization daemon can catch the FDB add event and
check if the MAC address is in the whitelist and if so replace
the FDB entry without the locked flag enabled, and thus open
the port for the device.

This feature is known as MAC-Auth or MAC Authentication Bypass
(MAB) in Cisco terminology, where the full MAB concept involves
additional Cisco infrastructure for authorization. There is no
real authentication process, as the MAC address of the device
is the only input the authorization daemon, in the general
case, has to base the decision if to unlock the port or not.

With this patch set, an implementation of the offloaded case is
supplied for the mv88e6xxx driver. When a packet ingresses on
a locked port, an ATU miss violation event will occur. When
handling such ATU miss violation interrupts, the MAC address of
the device is added to the FDB with a zero destination port
vector (DPV) and the MAC address is communicated through the
switchdev layer to the bridge, so that a FDB entry with the
locked flag enabled can be added.

Hans Schultz (3):
  net: bridge: add fdb flag to extent locked port feature
  net: switchdev: add support for offloading of fdb locked flag
  net: dsa: mv88e6xxx: mac-auth/MAB implementation

 drivers/net/dsa/mv88e6xxx/Makefile            |  1 +
 drivers/net/dsa/mv88e6xxx/chip.c              | 10 +--
 drivers/net/dsa/mv88e6xxx/chip.h              |  5 ++
 drivers/net/dsa/mv88e6xxx/global1.h           |  1 +
 drivers/net/dsa/mv88e6xxx/global1_atu.c       | 29 +++++++-
 .../net/dsa/mv88e6xxx/mv88e6xxx_switchdev.c   | 67 +++++++++++++++++++
 .../net/dsa/mv88e6xxx/mv88e6xxx_switchdev.h   | 20 ++++++
 drivers/net/dsa/mv88e6xxx/port.c              | 11 +++
 drivers/net/dsa/mv88e6xxx/port.h              |  1 +
 include/net/switchdev.h                       |  3 +-
 include/uapi/linux/neighbour.h                |  1 +
 net/bridge/br.c                               |  3 +-
 net/bridge/br_fdb.c                           | 13 +++-
 net/bridge/br_input.c                         | 11 ++-
 net/bridge/br_private.h                       |  5 +-
 15 files changed, 167 insertions(+), 14 deletions(-)
 create mode 100644 drivers/net/dsa/mv88e6xxx/mv88e6xxx_switchdev.c
 create mode 100644 drivers/net/dsa/mv88e6xxx/mv88e6xxx_switchdev.h

-- 
2.30.2

