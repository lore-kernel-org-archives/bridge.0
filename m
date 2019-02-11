Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=Dk33WpR7T6/ZBSK4ANXuVhEiabNiC++NqI2VNDCsbEo=;
	b=vcGK190fzb6qPmbRgU8H1IIYd1aRWwkutxxkc3qOLUpH7aFk8LgRuePLOfJ7OlCDF2
	ELWQ9CdD2sfrWO5c4x1wTm/p7ngbPTqs8NPHXKvSeyzSk0v2g6Y51n1ta3S3JVWVNrvT
	VWMkUpJ2JOkCTlWMsNOPD8Uu/bzbuDV3DdMrA1HRoG9MUyEVN5kpdGQq/4fGKS9RA3Iy
	1YBmQUeDRlIlXoxdWjfDnT9h9rCuPlNdFQLy9iuYomabgo67i5e1sDcG9OZ+JK+15qCC
	genOlZFzEFjBvY4AMZOZZLE+0nLI2olJIeZ0q4N/XcIx+dg7AMvMnyXXJL+BfTusU2VL
	FbNA==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon, 11 Feb 2019 13:17:46 -0800
Message-Id: <20190211211749.19847-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next 0/3] Remove getting
	SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS
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

AFAICT there is no code that attempts to get the value of the attribute
SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS while it is used with
switchdev_port_attr_set().

This is effectively no doing anything and it can slow down future work
that tries to make modifications in these areas so remove that.

David, there should be no dependency with previous patch series, but
again, feedback from Ido and Jiri would be welcome in case this was
added for a reason.

Thanks!

Florian Fainelli (3):
  mlxsw: spectrum_switchdev: Remove getting PORT_BRIDGE_FLAGS
  rocker: Remove getting PORT_BRIDGE_FLAGS
  staging: fsl-dpaa2: ethsw: Remove getting PORT_BRIDGE_FLAGS

 .../mellanox/mlxsw/spectrum_switchdev.c         | 17 -----------------
 drivers/net/ethernet/rocker/rocker.h            |  2 --
 drivers/net/ethernet/rocker/rocker_main.c       | 15 ---------------
 drivers/net/ethernet/rocker/rocker_ofdpa.c      | 10 ----------
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c         |  5 -----
 5 files changed, 49 deletions(-)

-- 
2.17.1

