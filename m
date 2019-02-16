Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=RNG4klDGEv3kNGo5+FcMdjwL5gIJg7XptcxvkwMC+hY=;
	b=AeeoVOnW+7IZAlDl8y1mm89//9WY4i78VAFEVoyGppcNMJsIDtu+GZ17Ml70RTjUJ9
	2WGxwjhaGDFL0RHbwkT4S7c3b1FD76CdnyGJkddbXHnAwKwNP2I6AZSir7NN0M4kI/IV
	irPGJ0OwpNnyEG/6UN4ZlulFanJzWkyvHMhfCnhv0zKzZeieS3aCRwCDPAINBGzVIpvE
	Hxa/uTzuZLTS9qrAwDTUgTGSF4wIQRok8nfQ8FOPVd6Oqiksn/fi0+UjYnLgiplLLe7D
	zE9QtVfWfnUyegS3K4oirjt87YRIzzqRre5wQg/6hEYPaZVluqcrkKooBwZg/cPe3PJD
	wFvA==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Fri, 15 Feb 2019 20:55:47 -0800
Message-Id: <20190216045556.3514-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v3 0/9] net: Get rid of
	switchdev_port_attr_get()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: devel@driverdev.osuosl.org, andrew@lunn.ch, Florian Fainelli <f.fainelli@gmail.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, idosch@mellanox.com, jiri@mellanox.com, vivien.didelot@gmail.com

Hi all,

This patch series splits the removal of the switchdev_ops that was
proposed a few times before and first tackles the easy part which is the
removal of the single call to switchdev_port_attr_get() within the
bridge code.

As suggestd by Ido, this patch series adds a
SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS which is used in the same
context as the caller of switchdev_port_attr_set(), so not deferred, and
then the operation is carried out in deferred context with setting a
support bridge port flag.

Follow-up patches will do the switchdev_ops removal after introducing
the proper helpers for the switchdev blocking notifier to work across
stacked devices (unlike the previous submissions).

Changes in v3:
- fixed build failure in mlxsw/spectrum_switchdev.c due to left over
  argument

- fixed unused variable in rocker

Changes in v2:

- differentiate callers not supporting switchdev_port_attr_set() from
  the driver not being able to support specific bridge flags

- pass "mask" instead of "flags" for the PRE_BRIDGE_FLAGS check

- skip prepare phase for PRE_BRIDGE_FLAGS

- corrected documentation a bit more

- tested bridge_vlan_aware.sh with veth/VRF

Florian Fainelli (9):
  Documentation: networking: switchdev: Update port parent ID section
  switchdev: Add SWITCHDEV_PORT_ATTR_SET, SWITCHDEV_PORT_ATTR_GET
  rocker: Handle SWITCHDEV_PORT_ATTR_GET/SET
  mlxsw: spectrum_switchdev: Handle SWITCHDEV_PORT_ATTR_GET/SET
  net: mscc: ocelot: Handle SWITCHDEV_PORT_ATTR_GET/SET
  staging: fsl-dpaa2: ethsw: Handle SWITCHDEV_PORT_ATTR_GET/SET
  net: dsa: Handle SWITCHDEV_PORT_ATTR_GET/SET
  net: switchdev: Replace port attr get/set SDO with a notification
  net: Remove switchdev_ops

 Documentation/networking/switchdev.txt        |  10 +-
 .../net/ethernet/mellanox/mlxsw/spectrum.c    |  12 --
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |   2 -
 .../mellanox/mlxsw/spectrum_switchdev.c       |  36 +++---
 drivers/net/ethernet/mscc/ocelot.c            |  26 ++++-
 drivers/net/ethernet/rocker/rocker_main.c     |  30 ++++-
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c       |  30 ++++-
 include/linux/netdevice.h                     |   3 -
 include/net/switchdev.h                       |  28 ++---
 net/dsa/slave.c                               |  30 ++++-
 net/switchdev/switchdev.c                     | 107 ++++++------------
 11 files changed, 168 insertions(+), 146 deletions(-)

-- 
2.19.1

