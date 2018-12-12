Return-Path: <petrm@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=QEyRgPBhh2LUll3KQt9qpxfjW/KS9FjdSDDq4TzcAMs=;
	b=b/mxpJMOYjjzjV4Sel90Jofi/7ljv8BBS9HW3QqTuJqOyP5gijKbzD3zs3itsjnI7HI7zGYFZ2OkCgUCPWEx0hio9+GQF4C8d2XdBmERLo8ScfLQjPtQiTLRl2qwBglxSSJ8fifA0hkeqiTD7ReB9v4ShKXUjpEdWsCf2CRzoio=
From: Petr Machata <petrm@mellanox.com>
Date: Wed, 12 Dec 2018 17:02:46 +0000
Message-ID: <cover.1544632917.git.petrm@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 0/9] Pass extack to
	SWITCHDEV_PORT_OBJ_ADD
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>
Cc: "ivecera@redhat.com" <ivecera@redhat.com>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, Ido Schimmel <idosch@mellanox.com>, Jiri Pirko <jiri@mellanox.com>, "dsa@cumulusnetworks.com" <dsa@cumulusnetworks.com>, "davem@davemloft.net" <davem@davemloft.net>

Drivers may need to do validation as a result of port object addition.
An example is mlxsw, which needs to check the configuration of a VXLAN
device attached to an offloaded bridge. Without a mapped VLAN, the
invalidity of the device is not important, but as soon as a pvid,
untagged VLAN is configured for the device, it has to be validated and
offloaded. Should the validation fail, there's currently no way to
communicate details of the failure to the user, beyond an error number.

Because currently, extack is not available at all in that area of code,
this patch starts down at the RTNL level and progresses up towards the
driver(s).

In patch #1, ndo_bridge_setlink is updated to include extack, and
callbacks of all clients are updated as well (ignoring the argument).

In patch #2, the bridge driver is updated to propagate the extack
through to the switchdev border, br_switchdev_port_vlan_add().

Patches #3, #4 and #5 then gradually extend switchdev to pass the extack
argument through to the switchdev blocking notifier chain.

Patches #6 and #7 then update mlxsw to pass the extack argument from
VXLAN events resp. port events on to mlxsw_sp_bridge_8021q_vxlan_join().

Finally in patches #8 and #9, the code paths from the previous two
patches are verified to yield an error message.

v2:
- Patch #1:
    - In ndo_bridge_setlink(), keep the whole extack declaration on the
      same line.

Petr Machata (9):
  net: ndo_bridge_setlink: Add extack
  net: bridge: Propagate extack to switchdev
  net: switchdev: Add extack argument to switchdev_port_obj_add()
  net: switchdev: Add extack to struct switchdev_notifier_info
  net: switchdev: Add extack to switchdev_handle_port_obj_add() callback
  mlxsw: spectrum_switchdev: Propagate extack on VXLAN VLAN events
  mlxsw: spectrum_switchdev: Propagate extack on port VLAN events
  selftests: mlxsw: extack: Test VLAN add on a VXLAN device
  selftests: mlxsw: extack: Test VLAN add on a port device

 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  2 +-
 drivers/net/ethernet/emulex/benet/be_main.c        |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  4 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |  3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |  3 +-
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   | 53 ++++++++++++------=
-
 drivers/net/ethernet/mscc/ocelot.c                 |  3 +-
 drivers/net/vxlan.c                                |  1 +
 include/linux/netdevice.h                          |  5 +-
 include/net/switchdev.h                            | 25 ++++++---
 net/bridge/br_if.c                                 |  2 +-
 net/bridge/br_mdb.c                                |  4 +-
 net/bridge/br_netlink.c                            | 30 ++++++-----
 net/bridge/br_private.h                            | 25 +++++----
 net/bridge/br_switchdev.c                          |  5 +-
 net/bridge/br_vlan.c                               | 59 ++++++++++++------=
---
 net/core/rtnetlink.c                               |  6 ++-
 net/switchdev/switchdev.c                          | 38 +++++++++-----
 .../testing/selftests/drivers/net/mlxsw/extack.sh  | 61 ++++++++++++++++++=
++++
 19 files changed, 229 insertions(+), 102 deletions(-)

--=20
2.4.11

