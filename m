Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=qeGucNcR1Ixrosfg05/ynjm177ucrRZgoNcvbGuBl8E=;
	b=XXHYChJdUNonKzSSzYTv6hz00p34+KRTpCyczG7MuFTArT7PqyJcGifbGGPFOBzEMp
	tcnLKpqKoRyoSGaBltOIxQ28HQydVAgTOzwV4LSKaBg97OI0HR2p/1qiXYEW1B7aByGd
	2Mqp3aOJlSqpH399kBhqbPMrIk30SGyw8tChmrYFaVEyf9WG93l8/wEn43Fpi6ui6Gvj
	zdQlmreDRJKP42uZJ9K88GHOVcZ/elfJNXMZFGP7wJYNo4g1FeNd6+Q0dHHMCuHMTUMe
	Ees9BTraoc8YxW0NBC0hO4ufW2eBJ2pkpblLARcNuvjVrtOgEGy9Y/KOhFeMiIudQR6/
	RP3g==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 20 Feb 2019 16:58:18 -0800
Message-Id: <20190221005826.26317-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next v3 0/8] net: Get rid of
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
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, andrew@lunn.ch, Florian Fainelli <f.fainelli@gmail.com>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, vivien.didelot@gmail.com, Ido Schimmel <idosch@mellanox.com>, jiri@mellanox.com, "David S. Miller" <davem@davemloft.net>

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

David this does depend on Russell's "[PATCH net-next v5 0/3] net: dsa:
mv88e6xxx: fix IPv6".

Changes in v3:

- rebased against net-next/master after Russell's IPv6 changes to DSA
- ignore prepare/commit phase for PRE_BRIDGE_FLAGS since we don't
  want to trigger the WARN() in net/switchdev/switchdev.c in the commit
  phase

Changes in v2:

- differentiate callers not supporting switchdev_port_attr_set() from
  the driver not being able to support specific bridge flags

- pass "mask" instead of "flags" for the PRE_BRIDGE_FLAGS check

- skip prepare phase for PRE_BRIDGE_FLAGS

- corrected documentation a bit more

- tested bridge_vlan_aware.sh with veth/VRF

Florian Fainelli (8):
  net: switchdev: Add PORT_PRE_BRIDGE_FLAGS
  mlxsw: spectrum: Handle PORT_PRE_BRIDGE_FLAGS
  staging: fsl-dpaa2: ethsw: Handle PORT_PRE_BRIDGE_FLAGS
  net: dsa: Add setter for SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS
  rocker: Check Handle PORT_PRE_BRIDGE_FLAGS
  net: bridge: Stop calling switchdev_port_attr_get()
  net: Remove SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT
  net: Get rid of switchdev_port_attr_get()

 Documentation/networking/switchdev.txt        |  6 +-
 .../mellanox/mlxsw/spectrum_switchdev.c       | 32 ++++----
 drivers/net/ethernet/rocker/rocker_main.c     | 74 ++++++++++---------
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c       | 29 ++++----
 include/net/switchdev.h                       | 13 +---
 net/bridge/br_switchdev.c                     | 11 ++-
 net/dsa/dsa_priv.h                            |  2 +
 net/dsa/port.c                                | 12 +++
 net/dsa/slave.c                               | 25 +------
 9 files changed, 98 insertions(+), 106 deletions(-)

-- 
2.17.1

