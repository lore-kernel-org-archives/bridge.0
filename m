Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4E80D812D1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0BF2880E46
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMsqm4DkU7H9QVImeZAVmQ+Ff0bNqKwHMI9/LrUdPR4=;
 b=Iwf5SSWDW22ECk568HFofGKt/U/tO7FTlnllqMXDo+57LHmPrbDI7usH5AmcemVZYgKMUsJ30DR3LtMsmLcwlGqiNXhfHtsKzc1XQ1uXJTJ5dhTc7s+noZwuVug2EoEQqGrN3Oyp+Lo+Q9gy5tivD57CWxFSoLPh2dnoFcCKQVKRqk6xZHTpNjWsreSRm2EyRlsCoZJeUp+jE7z7AEIeGAVOPvYJ4VWilFUYQtN6oMNNWIsRqD2BkFKqOoSoOQ9lVskbDUMxW/sInFc2LCuupYLOAlXxLuIlZWsowkfaQcIVuvaM0HVu6EcpuAfiz/MqYQ+IRH0y8I7em/Ygk8yBEQ==
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue, 25 Oct 2022 13:00:08 +0300
Message-Id: <20221025100024.1287157-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH net-next 00/16] bridge: Add MAC Authentication
	Bypass (MAB) support with offload
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, ivecera@redhat.com, netdev@kapio-technology.com, razor@blackwall.org, roopa@nvidia.com, Ido Schimmel <idosch@nvidia.com>, vladimir.oltean@nxp.com, edumazet@google.com, mlxsw@nvidia.com, jiri@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

This patchset is based on Hans' work from [1][2]. It adds MAB support in
the bridge driver and 802.1X (with MAB) offload support in mlxsw.

Patchset overview
=================

Patch #1 adds MAB support in the bridge driver. See the commit message
for motivation and design choices.

Patch #2 adds a selftest.

Patches #3-#4 extend the switchdev interfaces to allow device drivers to
install locked FDB entries in the bridge driver. Required for MAB
offload support.

The rest of the patches add 802.1X and MAB offload support in mlxsw.
Specifically:

Patches #5-#6 add the required packet traps for 802.1X.

Patches #7-#11 are small preparations.

Patch #12 adds locked bridge port support in mlxsw.

Patches #13-#16 add mlxsw selftests.

Future work
===========

The hostapd fork by Westermo is using dynamic FDB entries to authorize
hosts [3]. Changes are required in switchdev to allow such entries to be
offloaded. Hans already indicated he is working on that [4]. It should
not necessitate any uAPI changes so I do not view it as a blocker (Hans,
please confirm).

Merge plan
==========

We need to agree on a merge plan that allows us to start submitting
patches for inclusion and finally conclude this work. In my experience,
it is best to work in small batches. I therefore propose the following
plan:

* Add MAB support in the bridge driver. This corresponds to patches
  #1-#2.

* Switchdev extensions for MAB offload together with mlxsw
  support. This corresponds to patches #3-#16. I can reduce the number
  of patches by splitting out the selftests to a separate submission.

* mv88e6xxx support. I believe the blackhole stuff is an optimization,
  so I suggest getting initial MAB offload support without that. Support
  for blackhole entries together with offload can be added in a separate
  submission.

* Switchdev extensions for dynamic FDB entries together with mv88e6xxx
  support. I can follow up with mlxsw support afterwards.

[1] https://lore.kernel.org/netdev/20221018165619.134535-1-netdev@kapio-technology.com/
[2] https://lore.kernel.org/netdev/20221004152036.7848-1-netdev@kapio-technology.com/
[3] https://github.com/westermo/hostapd/blob/bridge_driver/hostapd/hostapd_auth_deauth.sh#L11
[4] https://lore.kernel.org/netdev/a11af0d07a79adbd2ac3d242b36dec7e@kapio-technology.com/

Hans J. Schultz (3):
  bridge: Add MAC Authentication Bypass (MAB) support
  selftests: forwarding: Add MAC Authentication Bypass (MAB) test cases
  bridge: switchdev: Allow device drivers to install locked FDB entries

Ido Schimmel (13):
  bridge: switchdev: Let device drivers determine FDB offload indication
  devlink: Add packet traps for 802.1X operation
  mlxsw: spectrum_trap: Register 802.1X packet traps with devlink
  mlxsw: reg: Add Switch Port FDB Security Register
  mlxsw: spectrum: Add an API to configure security checks
  mlxsw: spectrum_switchdev: Prepare for locked FDB notifications
  mlxsw: spectrum_switchdev: Add support for locked FDB notifications
  mlxsw: spectrum_switchdev: Use extack in bridge port flag validation
  mlxsw: spectrum_switchdev: Add locked bridge port support
  selftests: devlink_lib: Split out helper
  selftests: mlxsw: Add a test for EAPOL trap
  selftests: mlxsw: Add a test for locked port trap
  selftests: mlxsw: Add a test for invalid locked bridge port
    configurations

 .../networking/devlink/devlink-trap.rst       |  13 +++
 drivers/net/ethernet/mellanox/mlxsw/reg.h     |  35 ++++++
 .../net/ethernet/mellanox/mlxsw/spectrum.c    |  22 ++++
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |   5 +-
 .../mellanox/mlxsw/spectrum_switchdev.c       |  64 +++++++++--
 .../ethernet/mellanox/mlxsw/spectrum_trap.c   |  25 +++++
 drivers/net/ethernet/mellanox/mlxsw/trap.h    |   2 +
 include/linux/if_bridge.h                     |   1 +
 include/net/devlink.h                         |   9 ++
 include/net/switchdev.h                       |   1 +
 include/uapi/linux/if_link.h                  |   1 +
 include/uapi/linux/neighbour.h                |   8 +-
 net/bridge/br.c                               |   5 +-
 net/bridge/br_fdb.c                           |  46 +++++++-
 net/bridge/br_input.c                         |  15 ++-
 net/bridge/br_netlink.c                       |  13 ++-
 net/bridge/br_private.h                       |   5 +-
 net/bridge/br_switchdev.c                     |   1 +
 net/core/devlink.c                            |   3 +
 net/core/rtnetlink.c                          |   5 +
 .../drivers/net/mlxsw/devlink_trap_control.sh |  22 ++++
 .../net/mlxsw/devlink_trap_l2_drops.sh        | 105 ++++++++++++++++++
 .../selftests/drivers/net/mlxsw/rtnetlink.sh  |  31 ++++++
 .../net/forwarding/bridge_locked_port.sh      | 101 ++++++++++++++++-
 .../selftests/net/forwarding/devlink_lib.sh   |  19 ++--
 tools/testing/selftests/net/forwarding/lib.sh |   8 ++
 26 files changed, 535 insertions(+), 30 deletions(-)

-- 
2.37.3

