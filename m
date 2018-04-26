Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
	bh=qaB5z8QeHUoWKcysoCcJvBTB5ukJVtgug9YLCnPqSwo=;
	b=co6f8RtkzZilEyH5ZZyQREPledTQDMSWIBgADhZxGC51Bd/YVW6oG+1kGzweS3vGhczbEuh819nFkKttrntMu0PNzc2I/M+HIUxHZ8g17aKmHt8pwjbUTR6/xCL1AP6aHE7DHd7TWJvU2z6mXF8D2vJda60JJq+Lj8S2X9bC8Dw=
From: Ido Schimmel <idosch@mellanox.com>
Date: Thu, 26 Apr 2018 12:06:31 +0300
Message-Id: <20180426090637.25262-1-idosch@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 0/6] mlxsw: SPAN: Support routes pointing
	at bridges
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Ido Schimmel <idosch@mellanox.com>, mlxsw@mellanox.com, nikolay@cumulusnetworks.com, jiri@mellanox.com, petrm@mellanox.com, davem@davemloft.net

Petr says:

When mirroring to a gretap or ip6gretap netdevice, the route that
directs the encapsulated packets can reference a bridge. In that case,
in the software model, the packet is switched.

Thus when offloading mirroring like that, take into consideration FDB,
STP, PVID configured at the bridge, and whether that VLAN ID should be
tagged on egress.

Patch #1 introduces a suite of functions to query various bridge bits of
configuration: FDB, VLAN groups, etc.

Patches #2 and #3 refactor some existing code and introduce a new
accessor function.

With patches #4 and #5 mlxsw calls mlxsw_sp_span_respin() on switchdev
events as well. There is no impact yet, because bridge as an underlay
device is still not allowed.

That is implemented in patch #6, which uses the new interfaces to figure
out on which one port the mirroring should be configured, and whether
the mirrored packets should be VLAN-tagged and how.

Petr Machata (6):
  net: bridge: Publish bridge accessor functions
  mlxsw: spectrum: Extract mlxsw_sp_stp_spms_state()
  mlxsw: spectrum_switchdev: Publish two functions
  mlxsw: spectrum: Register SPAN before switchdev
  mlxsw: Respin SPAN on switchdev events
  mlxsw: spectrum_span: Allow bridge for gretap mirror

 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     |  50 +++++-----
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h     |   1 +
 .../net/ethernet/mellanox/mlxsw/spectrum_span.c    | 102 +++++++++++++++++++--
 .../net/ethernet/mellanox/mlxsw/spectrum_span.h    |   1 +
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   |  72 ++++++++++++++-
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.h   |  43 +++++++++
 include/linux/if_bridge.h                          |  55 +++++++++++
 net/bridge/br_fdb.c                                |  25 +++++
 net/bridge/br_private.h                            |  17 ++--
 net/bridge/br_vlan.c                               |  32 +++++++
 10 files changed, 356 insertions(+), 42 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.h

-- 
2.14.3

