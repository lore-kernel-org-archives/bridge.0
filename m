Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B10528513D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ADD598513C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TadKRB8UEYv9tZCxLyvhTgb1bm5Lzot5MqKfQkgfIuk=;
 b=e8DrkNgSuMeR69NZ3STuJhEi9cWQCXs6Xi1CEZWSROfF3NPd3TDgStPZO6h916kICk46dyXWp57XGWopaPUz0Db1bvaMUf7HiEcs43wcBNUknQvipmzdLcTHQM9OenHUmHClf7cTI9GUiJdHcI8zr7oTzWD6Le2L8CC1dprzY+HxydDRXKL7vpDvI9ivVqBSl+dQOKutIwe6lENPB3so9Wn6o4e6XPuO7qoLwWrrfDwtXOxoJLMu6HcgVMsKyhbTi3gCwTu6eyC5ALM3UOP7lvLdVE/7CYMDBn14pqsqwCziADZfqh1XdFiRN3kLI9HWpQQheDy3UnrybEflUep4EQ==
From: Ido Schimmel <idosch@nvidia.com>
Date: Wed, 25 Oct 2023 15:30:07 +0300
Message-ID: <20231025123020.788710-1-idosch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v2 00/13] Add MDB get support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@nvidia.com, razor@blackwall.org, Ido Schimmel <idosch@nvidia.com>, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

This patchset adds MDB get support, allowing user space to request a
single MDB entry to be retrieved instead of dumping the entire MDB.
Support is added in both the bridge and VXLAN drivers.

Patches #1-#6 are small preparations in both drivers.

Patches #7-#8 add the required uAPI attributes for the new functionality
and the MDB get net device operation (NDO), respectively.

Patches #9-#10 implement the MDB get NDO in both drivers.

Patch #11 registers a handler for RTM_GETMDB messages in rtnetlink core.
The handler derives the net device from the ifindex specified in the
ancillary header and invokes its MDB get NDO.

Patches #12-#13 add selftests by converting tests that use MDB dump with
grep to the new MDB get functionality.

iproute2 changes can be found here [1].

v2:
* Patch #7: Add a comment to describe attributes structure.
* Patch #9: Add a comment above spin_lock_bh().

[1] https://github.com/idosch/iproute2/tree/submit/mdb_get_v1

Ido Schimmel (13):
  bridge: mcast: Dump MDB entries even when snooping is disabled
  bridge: mcast: Account for missing attributes
  bridge: mcast: Factor out a helper for PG entry size calculation
  bridge: mcast: Rename MDB entry get function
  vxlan: mdb: Adjust function arguments
  vxlan: mdb: Factor out a helper for remote entry size calculation
  bridge: add MDB get uAPI attributes
  net: Add MDB get device operation
  bridge: mcast: Add MDB get support
  vxlan: mdb: Add MDB get support
  rtnetlink: Add MDB get support
  selftests: bridge_mdb: Use MDB get instead of dump
  selftests: vxlan_mdb: Use MDB get instead of dump

 drivers/net/vxlan/vxlan_core.c                |   1 +
 drivers/net/vxlan/vxlan_mdb.c                 | 188 ++++++++++++++++--
 drivers/net/vxlan/vxlan_private.h             |   2 +
 include/linux/netdevice.h                     |   4 +
 include/uapi/linux/if_bridge.h                |  18 ++
 net/bridge/br_device.c                        |   3 +-
 net/bridge/br_input.c                         |   2 +-
 net/bridge/br_mdb.c                           | 184 ++++++++++++++++-
 net/bridge/br_multicast.c                     |   5 +-
 net/bridge/br_private.h                       |  19 +-
 net/core/rtnetlink.c                          |  89 ++++++++-
 .../selftests/net/forwarding/bridge_mdb.sh    | 184 +++++++----------
 tools/testing/selftests/net/test_vxlan_mdb.sh | 108 +++++-----
 13 files changed, 608 insertions(+), 199 deletions(-)

-- 
2.40.1

