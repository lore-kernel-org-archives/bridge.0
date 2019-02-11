Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=SkmoCuGIG7bBgkarhLHVf2wX33rKnc3mr2F6ISg3h5w=;
	b=taMfTJfj4E+6QegTRVG2Wr9ySYJobUOvxco2ghCl1lfCGwEqglH/PXOhQ5HSPMYKg8
	45Tf2UPVyberzHQ8+x5vsvwYmCFjY/tNbuAubqsoN2KotHzI0qvwgmL2uitpMDxI/tQ4
	YMLQDD316l10/ZfuIfrS6ermOaK0fz4qw1cTsYE+y1kVfUDgaZToPgyGZFj4NbfN4ppC
	MdfQrnptrz88EXmr2vsJwCXGup/2RQWyqW1KsxK8FnkwFvFAUYvXfr7VRTa1Nvhc1MYq
	Grb6pAouoUBFcCLGKPmMgnQFDW+hYx9SBGuYJANfZBkCgGSJjba8w3Mc82LLELn3Q+3c
	Pw4Q==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon, 11 Feb 2019 11:09:52 -0800
Message-Id: <20190211191001.8623-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH net-next v4 0/9] net: Remove switchdev_ops
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

This patch series finishes by the removal of switchdev_ops. To get there
we convert the existing switchdev_port_attr_{set,get} switchdev_ops to
use a blocking notifier, thus making it consistent with how the objects
are pushed to the switchdev enabled devices.

Please review and let me know what you think!

David, I would like to get Ido's feedback on this to make sure I did not
miss something, thank you!

Changes in v4:
- removed double space in Documentation/networking/switchdev.txt
- added Jiri's Acked-by tags
- added fall through annotations where appropriate

Changes in v3:
- dropped patches removing te need to get the attribute since we
  still need that in order to support different sleeping vs.
  non-sleeping contexts

Changes in v2:
- fixed bisectability issues in patch #15
- added Acked-by from Jiri where necessary
- fixed a few minor issues according to Jiri's feedback:
	- rename port_attr_event -> port_attr_set_event
	- moved SWITCHDEV_PORT_ATTR_SET closer to other blocking events

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
2.17.1

