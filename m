Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=JKaAtY0moZ2DYOu4EJF0uawv0g+P3IWtcBgji5g00hA=;
	b=JEsoGTDkngsbUPkmyGIQVFcw59hMabXF7uVWCkkpIL2+Crx6RzUWF7ASANq6ZUJyZN
	zdfeNLFcr1cGMTco8DY/thYpX1cwJHm7D7BEuY7jTXmusrM6WTU20XajQc50gUCuoeKK
	HkCKuXd7FbT3Euh6LoSiATsOsyhFKymnbFoDWS78VOtJXDI3v9sJJRDSlyABlFC4CihU
	WBYknvWPirdUxXLJnLiGtHY5T6OctLqGkwteDpiwuIow7IZ3ih/HH7A9nAvUNqBQjxkx
	I9Zz3BV2qh+1JPA81KLHlCzoNJUzLI8kLb2f92ea24IIY559pdAFnvbC+rjm8h3eURGG
	FeBA==
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon,  4 Feb 2019 15:36:21 -0800
Message-Id: <20190204233633.20421-1-f.fainelli@gmail.com>
Subject: [Bridge] [PATCH 00/12] net: Introduce ndo_get_port_parent_id()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Jakub Kicinski <jakub.kicinski@netronome.com>, John Hurley <john.hurley@netronome.com>, "open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@netronome.com>, Eric Dumazet <edumazet@google.com>, Ioana Ciornei <ioana.ciornei@nxp.com>, Tyler Hicks <tyhicks@canonical.com>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Ioana Radulescu <ruxandra.radulescu@nxp.com>, "open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, Amritha Nambiar <amritha.nambiar@intel.com>, Saeed Mahameed <saeedm@mellanox.com>, Dirk van der Merwe <dirk.vandermerwe@netronome.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Vivien Didelot <vivien.didelot@gmail.com>, Alexander Duyck <alexander.h.duyck@intel.com>, "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Simon Horman <simon.horman@netronome.com>, Roopa Prabhu <roopa@cumulusnetworks.com>, Satanand Burla <sburla@marvell.com>, Ido Schimmel <idosch@mellanox.com>, Jiri Pirko <jiri@mellanox.com>, Kirill Tkhai <ktkhai@virtuozzo.com>, Edwin Peer <edwin.peer@netronome.com>, Michael Chan <michael.chan@broadcom.com>, Christian Brauner <christian@brauner.io>, Felix Manlunas <fmanlunas@marvell.com>, Leon Romanovsky <leon@kernel.org>, Nic Viljoen <nick.viljoen@netronome.com>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, open list <linux-kernel@vger.kernel.org>, Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>, David Ahern <dsahern@gmail.com>, Joe Perches <joe@perches.com>, Derek Chickles <dchickles@marvell.com>, "David S. Miller" <davem@davemloft.net>

Hi all,

Based on discussion with Ido and feedback from Jakub there are clearly
two classes of users that implement SWITCHDEV_ATTR_ID_PORT_PARENT_ID:

- PF/VF drivers which typically only implement return the port's parent
  ID, yet have to implement switchdev_port_attr_get() just for that

- Ethernet switch drivers: mlxsw, ocelot, DSA, etc. which implement more
  attributes which we want to be able to eventually veto in the context
  of the caller, thus making them candidates for using a blocking notifier
  chain

Changes from RFC:

- introduce a ndo_get_port_parent_id() and convert all relevant drivers
  to use it

- get rid of SWITCHDEV_ATTR_ID_PORT_PARENT_ID

A subsequent set of patches will convert switchdev_port_attr_set() to
use a blocking notifier call, and still get rid of
switchdev_port_attr_get() altogether.

Florian Fainelli (12):
  net: Introduce ndo_get_port_parent_id()
  bnxt: Implement ndo_get_port_parent_id()
  liquidio: Implement ndo_get_port_parent_id()
  net/mlx5e: Implement ndo_get_port_parent_id()
  mlxsw: Implement ndo_get_port_parent_id()
  mscc: ocelot: Implement ndo_get_port_parent_id()
  nfp: Implement ndo_get_port_parent_id()
  rocker: Implement ndo_get_port_parent_id()
  netdevsim: Implement ndo_get_port_parent_id()
  staging: fsl-dpaa2: ethsw: Implement ndo_get_port_parent_id()
  net: dsa: Implement ndo_get_port_parent_id()
  net: Get rid of SWITCHDEV_ATTR_ID_PORT_PARENT_ID

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 28 +++++----------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  4 +--
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c  |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c | 12 +++----
 .../net/ethernet/cavium/liquidio/lio_main.c   | 22 +++---------
 .../net/ethernet/cavium/liquidio/lio_vf_rep.c | 25 ++++---------
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  | 31 ++++++----------
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 13 +++++++
 .../mellanox/mlxsw/spectrum_switchdev.c       |  5 ---
 .../net/ethernet/mellanox/mlxsw/switchx2.c    | 36 +++++++------------
 drivers/net/ethernet/mscc/ocelot.c            | 33 +++++++----------
 .../ethernet/netronome/nfp/nfp_net_common.c   |  4 +--
 .../net/ethernet/netronome/nfp/nfp_net_repr.c |  4 +--
 drivers/net/ethernet/netronome/nfp/nfp_port.c | 23 ++++--------
 drivers/net/ethernet/netronome/nfp/nfp_port.h |  4 ++-
 drivers/net/ethernet/rocker/rocker_main.c     | 17 ++++++---
 drivers/net/netdevsim/netdev.c                | 22 ++++--------
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c       | 17 ++++++---
 include/linux/netdevice.h                     |  6 ++++
 include/net/switchdev.h                       |  2 --
 net/bridge/br_switchdev.c                     | 11 +++---
 net/core/net-sysfs.c                          | 14 +++-----
 net/core/rtnetlink.c                          | 16 ++++-----
 net/dsa/slave.c                               | 18 ++++++----
 net/ipv4/ipmr.c                               | 14 ++++----
 net/switchdev/switchdev.c                     | 20 +++++------
 26 files changed, 169 insertions(+), 233 deletions(-)

-- 
2.17.1

