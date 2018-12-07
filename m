Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=TuJHTdqKTMkFc4iDik+sbrgO6RH4W15uczhJS5wWfCc=;
	b=fJ8pw3VAmyw/TT2t6oouUXc1eBXuZVb/lu1k6WFEe6+rn10YpyshTEHf7kphINOPmZwAOuXBcZabl7xPyLqVjvMJeLPqJib2+3p8iEMjwadQwduaNOMVd1YUaTqhUeX2f91O89PmDj43ZRk9xV49b8CeMJRUAdguKJBUemOhBcM=
From: Ido Schimmel <idosch@mellanox.com>
Date: Fri, 7 Dec 2018 19:55:01 +0000
Message-ID: <20181207195433.22540-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 00/12] mlxsw: Un/offload FDB on NVE
	detach/attach
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>
Cc: "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, Ido Schimmel <idosch@mellanox.com>, Jiri Pirko <jiri@mellanox.com>, Petr Machata <petrm@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

Petr says:

When a VXLAN device is attached to a bridge of a driver capable of
offloading such, or upped, the FDB entries already present at the device
need to be offloaded. Similarly when an offloaded VXLAN device ceases
being interesting (it is downed, or detached, or a front-panel port
netdevice is detached from the bridge that the VXLAN device is attached
to), any offloaded FDB entries need to be unoffloaded and unmarked. This
attach / detach processing is implemented in this patchset.

In patch #1, a code pattern is extracted into a named function for
easier reuse.

In patch #2, vxlan_fdb_replay() is added to send
SWITCHDEV_VXLAN_FDB_ADD_TO_DEVICE for each FDB entry with a given VNI.
The intention is that the offloading driver will interpret these events
like any other and thus offload the FDB entries that existed prior to
VXLAN attach.

In patches #3 and #4, the functions vxlan_fdb_clear_offload() resp.
br_fdb_clear_offload() are added. These clear the offloaded flag at
matching FDB entries.

In patches #5-#9, we introduce FID-type-specific and NVE-type-specific
ops necessary to properly abstract invocations of the replay/clear
functions.

Finally patch #10 implements the FDB management.

In patch #11, the mlxsw-specific test case is extended to check that the
management of offload marks under the newly-supported situations is
correct. Patch #12, from Ido, exercises the new code paths in actual
functional test.

v2:
- Patch #1:
    - Modify vxlan_fdb_switchdev_notifier_info() to initialize the
      structure through a passed-in pointer argument, instead of returning
      it as a value.
- Patch #2:
    - Adapt to API change in vxlan_fdb_switchdev_notifier_info()

Ido Schimmel (1):
  selftests: forwarding: Add PVID test case for VXLAN with VLAN-aware
    bridges

Petr Machata (11):
  vxlan: Add a function to init switchdev_notifier_vxlan_fdb_info
  vxlan: Add vxlan_fdb_replay()
  vxlan: Add vxlan_fdb_clear_offload()
  bridge: Add br_fdb_clear_offload()
  mlxsw: spectrum: Track NVE type at FIDs
  mlxsw: spectrum_switchdev: Publish mlxsw_sp_switchdev_notifier
  mlxsw: spectrum_nve: Add mlxsw_sp_nve_ops.fdb_replay
  mlxsw: spectrum_nve: Add mlxsw_sp_nve_ops.fdb_clear_offload
  mlxsw: spectrum: Add mlxsw_sp_fid_ops.fdb_clear_offload
  mlxsw: spectrum_nve: Un/offload FDB on nve_fid_disable/enable
  selftests: mlxsw: vxlan: Test FDB un/marking on VXLAN join/leave

 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  16 +-
 .../ethernet/mellanox/mlxsw/spectrum_fid.c    |  44 ++++-
 .../ethernet/mellanox/mlxsw/spectrum_nve.c    |  44 ++++-
 .../ethernet/mellanox/mlxsw/spectrum_nve.h    |   2 +
 .../mellanox/mlxsw/spectrum_nve_vxlan.c       |  20 ++
 .../mellanox/mlxsw/spectrum_switchdev.c       |   2 +-
 drivers/net/vxlan.c                           | 110 ++++++++---
 include/linux/if_bridge.h                     |   6 +
 include/net/vxlan.h                           |  15 ++
 net/bridge/br_fdb.c                           |  20 ++
 .../selftests/drivers/net/mlxsw/vxlan.sh      | 177 ++++++++++++++++++
 .../net/forwarding/vxlan_bridge_1q.sh         |  70 +++++++
 12 files changed, 495 insertions(+), 31 deletions(-)

--=20
2.19.1

