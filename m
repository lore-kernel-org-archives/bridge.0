Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
	bh=xtS0AKMFurYPQXgy7J/PkK55o2jv2hNr69JpV33RHxg=;
	b=J7XMplgs9HYtcaSdoqgH40ex4fM9vHfoX3XbKZzJajPoE2eLhciIfSmM8AVYxmRFGxrOc6usLRU04MHw/A+m4T2qRyvYJy6HKVCQVMq9u8IQdneAiDIutZYs/WNJNP/mePHqx4jxa7i5Z0xYe8LYcbp4iAeR6mY86qlrKue73vM=
From: Ido Schimmel <idosch@mellanox.com>
Date: Fri, 27 Apr 2018 18:11:05 +0300
Message-Id: <20180427151111.22099-1-idosch@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v2 0/6] mlxsw: SPAN: Support routes
	pointing at bridges
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

Patch #1 introduces functions to get bridge PVID, VLAN flags and to look
up an FDB entry.

Patches #2 and #3 refactor some existing code and introduce a new
accessor function.

With patches #4 and #5 mlxsw calls mlxsw_sp_span_respin() on switchdev
events as well. There is no impact yet, because bridge as an underlay
device is still not allowed.

That is implemented in patch #6, which uses the new interfaces to figure
out on which one port the mirroring should be configured, and whether
the mirrored packets should be VLAN-tagged and how.

Changes from v1 to v2:

- Change the suite of bridge accessor functions to br_vlan_pvid_rtnl(),
  br_vlan_info_rtnl(), br_fdb_find_port_rtnl().

Petr Machata (6):
  net: bridge: Publish bridge accessor functions
  mlxsw: spectrum: Extract mlxsw_sp_stp_spms_state()
  mlxsw: spectrum_switchdev: Publish two functions
  mlxsw: spectrum: Register SPAN before switchdev
  mlxsw: Respin SPAN on switchdev events
  mlxsw: spectrum_span: Allow bridge for gretap mirror

 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     | 50 ++++++------
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h     |  1 +
 .../net/ethernet/mellanox/mlxsw/spectrum_span.c    | 95 ++++++++++++++++++++--
 .../net/ethernet/mellanox/mlxsw/spectrum_span.h    |  1 +
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   | 72 ++++++++++++++--
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.h   | 43 ++++++++++
 include/linux/if_bridge.h                          | 28 +++++++
 net/bridge/br_fdb.c                                | 22 +++++
 net/bridge/br_private.h                            | 11 +++
 net/bridge/br_vlan.c                               | 39 +++++++++
 10 files changed, 326 insertions(+), 36 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.h

-- 
2.14.3

