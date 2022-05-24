Return-Path: <schultz.hans@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version:organization
 :content-transfer-encoding;
 bh=iIwfYVv7fNEx0HicZDp/iynxMZIWTs5X4JU/e8Toj3Q=;
 b=YaH1DgHLdkIdhEkYiJgKlTaJvj4NY2mznzZKESIAkDFw10sVbEHVoiK2zstW/JE8nu
 nRp07bJCs6GvOyurfm4MwvVX1zkyRRlntXwRIot1WglIJROzBtn5sJ9lRAgQd39vCf7H
 q0zswAaje5UcywXY1hwzEXbjPNaQ9WWT5ckeoPlZ4ZE3KnfpGmJep2L2k7lAGcJpT7uO
 0VgE0jnh7gFcc0LzgHgyrg+kXKXRFwFZmKBIkKODmpBHwcjYCjL0a8bxWnmYwFwZHWhT
 Wz0X99R6O2cLOjxYvmWp3ynXDiuJqB5egZ3ShbmqlOMdet2pU2rn8i7MsgLYUqDG/HjT
 jRrA==
From: Hans Schultz <schultz.hans@gmail.com>
Date: Tue, 24 May 2022 17:21:40 +0200
Message-Id: <20220524152144.40527-1-schultz.hans+netdev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH V3 net-next 0/4] Extend locked port feature with
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
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, linux-kernel@vger.kernel.org, Hans Schultz <schultz.hans+netdev@gmail.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>

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

Hans Schultz (4):
  net: bridge: add fdb flag to extent locked port feature
  net: switchdev: add support for offloading of fdb locked flag
  net: dsa: mv88e6xxx: mac-auth/MAB implementation
  selftests: forwarding: add test of MAC-Auth Bypass to locked port
    tests

 drivers/net/dsa/mv88e6xxx/Makefile            |   1 +
 drivers/net/dsa/mv88e6xxx/chip.c              |  40 ++-
 drivers/net/dsa/mv88e6xxx/chip.h              |   5 +
 drivers/net/dsa/mv88e6xxx/global1.h           |   1 +
 drivers/net/dsa/mv88e6xxx/global1_atu.c       |  35 ++-
 .../net/dsa/mv88e6xxx/mv88e6xxx_switchdev.c   | 249 ++++++++++++++++++
 .../net/dsa/mv88e6xxx/mv88e6xxx_switchdev.h   |  40 +++
 drivers/net/dsa/mv88e6xxx/port.c              |  32 ++-
 drivers/net/dsa/mv88e6xxx/port.h              |   2 +
 include/net/dsa.h                             |   6 +
 include/net/switchdev.h                       |   3 +-
 include/uapi/linux/neighbour.h                |   1 +
 net/bridge/br.c                               |   3 +-
 net/bridge/br_fdb.c                           |  18 +-
 net/bridge/br_if.c                            |   1 +
 net/bridge/br_input.c                         |  11 +-
 net/bridge/br_private.h                       |   9 +-
 .../net/forwarding/bridge_locked_port.sh      |  42 ++-
 18 files changed, 470 insertions(+), 29 deletions(-)
 create mode 100644 drivers/net/dsa/mv88e6xxx/mv88e6xxx_switchdev.c
 create mode 100644 drivers/net/dsa/mv88e6xxx/mv88e6xxx_switchdev.h

-- 
2.30.2

