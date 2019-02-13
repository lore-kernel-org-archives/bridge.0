Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=yH0+HAx5nlwub69336QwKNCKOG2nZFkQBO4sLZZiCxQ=;
	b=DAMYPy44Dh8jB5zXG7Vw6j3qR/lSAeS1xx+A74NqsGs98Os0bCd+SFSmc6prkHZpWy
	g4Kh5cPkLSde4mc4L4iX5GVlWps2mjyh7LPidLNtzAU3l9j/L6gt3AFdYmg6LDRk+hRL
	PChCcKaewiwYkPglASE+h+hIsGFfIjudGjtquvDZlpSu6Weg4gBW5cotwLXKt1G0T3hw
	mUr1i7+qNeaXStCFGUfCPK8mAufmzN/bklcifhcO/7NTYmCpT13dbeQdEUK8hWpWVskj
	R8NVbEnbwPCa/a/BtoESHXExviQ4lmkKPbl0OUCIn2BvAKIDPIoj/O+vUTRiaSWPU7Ys
	JKdQ==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 13 Feb 2019 14:06:29 -0800
Message-Id: <20190213220638.1552-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next 0/9] net: Get rid of
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

Florian Fainelli (9):
  Documentation: networking: switchdev: Update port parent ID section
  net: switchdev: Add PORT_PRE_BRIDGE_FLAGS
  mlxsw: spectrum: Check bridge flags during prepare phase
  staging: fsl-dpaa2: ethsw: Check bridge port flags during prepare
  net: dsa: Add setter for SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS
  rocker: Check bridge flags during prepare phase
  net: bridge: Stop calling switchdev_port_attr_get()
  net: Remove SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT
  net: Get rid of switchdev_port_attr_get()

 Documentation/networking/switchdev.txt        | 15 ++---
 .../mellanox/mlxsw/spectrum_switchdev.c       | 30 +++------
 drivers/net/ethernet/rocker/rocker_main.c     | 67 +++++++++----------
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c       | 27 +++-----
 include/net/switchdev.h                       | 13 +---
 net/bridge/br_switchdev.c                     | 16 ++---
 net/dsa/dsa_priv.h                            |  3 +
 net/dsa/port.c                                | 11 +++
 net/dsa/slave.c                               | 22 ++----
 9 files changed, 88 insertions(+), 116 deletions(-)

-- 
2.17.1

