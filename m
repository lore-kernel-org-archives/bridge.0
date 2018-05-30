Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=dU0y7pQTa1mTAa9bV+5E80UGRsoPhRvIh6pCbMjZTRI=;
	b=KFAdtDtUxozVIoyfNWfT0oDv1ht6u7T1zMMsDpvaovCyjQgvS7J1P7Y1vL3rbOuLeYicF5jvqMGm464HY2E/7ZoE64erxAm9uKyDiSOaDO01n2rW0LrZs6Uf4iBNLHBdESfwjX9q+2g3spO4CFVlYwxaEXqk+koQG1KxIin0O9E=
From: Petr Machata <petrm@mellanox.com>
Message-Id: <cover.1527641426.git.petrm@mellanox.com>
Date: Wed, 30 May 2018 02:55:34 +0200
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v4 0/8] net: bridge: Notify about bridge
	VLANs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, devel@driverdev.osuosl.org, bridge@lists.linux-foundation.org
Cc: f.fainelli@gmail.com, andrew@lunn.ch, nikolay@cumulusnetworks.com, gregkh@linuxfoundation.org, vivien.didelot@savoirfairelinux.com, idosch@mellanox.com, jiri@mellanox.com, razvan.stefanescu@nxp.com, davem@davemloft.net, dan.carpenter@oracle.com

In commit 946a11e7408e ("mlxsw: spectrum_span: Allow bridge for gretap
mirror"), mlxsw got support for offloading mirror-to-gretap such that
the underlay packet path involves a bridge. In that case, the offload is
also influenced by PVID setting of said bridge. However, changes to VLAN
configuration of the bridge itself do not generate switchdev
notifications, so there's no mechanism to prod mlxsw to update the
offload when these settings change.

In this patchset, the problem is resolved by distributing the switchdev
notification SWITCHDEV_OBJ_ID_PORT_VLAN also for configuration changes
on bridge VLANs. Since stacked devices distribute the notification to
lower devices, such event eventually reaches the driver, which can
determine whether it's a bridge or port VLAN by inspecting orig_dev.

To keep things consistent, the newly-distributed notifications observe
the same protocol as the existing ones: dual prepare/commit, with
-EOPNOTSUPP indicating lack of support, even though there's currently
nothing to prepare for and nothing to support. Correspondingly, all
switchdev drivers have been updated to return -EOPNOTSUPP for bridge
VLAN notifications.

In patches #1 and #2, the code base is changed to support the following
additions: functions br_switchdev_port_vlan_add() and
br_switchdev_port_vlan_del() are introduced to simplify sending
notifications; and br_vlan_add_existing() is introduced to later make it
simpler to add error-handling code for the case of configuring a
preexisting VLAN on bridge CPU port.

In patches #3-#6, respectively for mlxsw, rocker, DSA and DPAA2 ethsw,
the new notifications (which are not enabled yet) are ignored to
maintain the current behavior.

In patch #7, the notification is actually enabled.

In patch #8, mlxsw is changed to update offloads of mirror-to-gre also
for bridge-related notifications.

Changes from v3 to v4:

- In patch #1, separate variable declarations from program logic.
- Add patch #2.
- In patch #7, add error handling around a newly-introduced call to
  br_switchdev_port_vlan_add().
- Rephrase commit messages of patches #3-#6 to explain motivation for
  the change.

Changes from v2 to v3:

- Add a fallback definition for br_switchdev_port_obj_add() and
  br_switchdev_port_obj_del() when !CONFIG_NET_SWITCHDEV.

Changes from v1 to v2:

- Rename br_switchdev_port_obj_add() and br_switchdev_port_obj_del() to
  br_switchdev_port_vlan_add() and br_switchdev_port_vlan_del(), and
  move from br_vlan.c to br_switchdev.c.

Petr Machata (8):
  net: bridge: Extract boilerplate around switchdev_port_obj_*()
  net: bridge: Extract br_vlan_add_existing()
  mlxsw: spectrum_switchdev: Ignore bridge VLAN events
  rocker: rocker_main: Ignore bridge VLAN events
  dsa: port: Ignore bridge VLAN events
  staging: fsl-dpaa2: ethsw: Ignore bridge VLAN events
  net: bridge: Notify about bridge VLANs
  mlxsw: spectrum_switchdev: Schedule respin during trans prepare

 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   |   8 +-
 drivers/net/ethernet/rocker/rocker_main.c          |   6 ++
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c            |   6 ++
 net/bridge/br_private.h                            |  13 +++
 net/bridge/br_switchdev.c                          |  25 +++++
 net/bridge/br_vlan.c                               | 103 ++++++++++++---------
 net/dsa/port.c                                     |   6 ++
 7 files changed, 121 insertions(+), 46 deletions(-)

-- 
2.4.11

