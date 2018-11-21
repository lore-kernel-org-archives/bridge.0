Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=APRJhmcntCx0BJ1QhffNXkyCTTjgKnRAipBo5VeDzG0=;
	b=Wx6HIN4ieONuHSgbNtAaJX6cDnvYbiRzuOHq0Hn07TVPLdW1Zx31Fwhuxt1fWjxp5R0tfgembryGxpE/MMaDRXmhhsGbKd3j9CY5gOIqxJaqKVlZX+EFayby62W/ied5U1jTWGWkIKPs9Oz/CZ1ZGzXjcjC3OyGsI9FVgASukyk=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 21 Nov 2018 08:02:32 +0000
Message-ID: <20181121080141.16676-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 00/16] mlxsw: Add VxLAN learning support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>
Cc: "ivecera@redhat.com" <ivecera@redhat.com>, Ido Schimmel <idosch@mellanox.com>, mlxsw <mlxsw@mellanox.com>, "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, Jiri Pirko <jiri@mellanox.com>, Petr Machata <petrm@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

This patchset adds VxLAN learning support in the mlxsw driver.

The first five patches from Petr add the required switchdev APIs which
allow device drivers to notify the VxLAN driver about learned / aged-out
FDB entries.

First in patch #1, an unnecessary argument is dropped from
__vxlan_fdb_delete().

In patches #2-#4, the VxLAN FDB handling code is extended to make
sending the switchdev events configurable; to mark user-added entries as
such; and to make sure HW-learned FDB entries do not take over
user-added ones.

Finally in patch #5, the necessary switchdev notifications are added and
handled by VxLAN, similarly to how this is handled in the bridge driver.

Patch #6 allows changing of the VxLAN's device ageing time since it is
useful for the selftest in the last patch.

Patch #7 adds support for querying bridge port flags of a given
netdevice, as a new entry should not be learned and notified to the
bridge driver in case learning is disabled on the bridge port.

Next patches gradually add learning support in mlxsw.

The last patch adds a new test case for VxLAN learning.

Ido Schimmel (11):
  vxlan: Allow changing ageing time
  bridge: Allow querying bridge port flags
  mlxsw: reg: Add definition of unicast tunnel record for SFN register
  mlxsw: spectrum_fid: Store ifindex of NVE device in FID
  mlxsw: spectrum_fid: Allow FID lookup by its index
  mlxsw: spectrum_nve: Add API to resolve learned IP addresses
  mlxsw: spectrum_switchdev: Process learned VxLAN FDB entries
  mlxsw: spectrum_switchdev: Allow deletion of learned FDB entries
  mlxsw: spectrum_nve: Allow VxLAN learning
  selftests: mlxsw: Consider VxLAN learning enabled as valid
  selftests: forwarding: vxlan_bridge_1d: Add learning test

Petr Machata (5):
  vxlan: __vxlan_fdb_delete(): Drop unused argument vid
  vxlan: vxlan_fdb_notify(): Make switchdev notification configurable
  vxlan: Mark user-added FDB entries
  vxlan: Don't override user-added entries with ext-learned ones
  vxlan: Add hardware FDB learning

 drivers/net/ethernet/mellanox/mlxsw/reg.h     |  64 ++++++
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |   8 +-
 .../ethernet/mellanox/mlxsw/spectrum_fid.c    |  56 ++++-
 .../ethernet/mellanox/mlxsw/spectrum_nve.c    |  16 +-
 .../mellanox/mlxsw/spectrum_nve_vxlan.c       |   8 +-
 .../mellanox/mlxsw/spectrum_switchdev.c       | 206 ++++++++++++++++--
 drivers/net/vxlan.c                           | 192 ++++++++++++----
 include/linux/if_bridge.h                     |   6 +
 include/net/switchdev.h                       |   2 +
 include/net/vxlan.h                           |   1 +
 net/bridge/br_if.c                            |  12 +
 .../selftests/drivers/net/mlxsw/vxlan.sh      |   2 +-
 .../net/forwarding/vxlan_bridge_1d.sh         | 108 +++++++++
 13 files changed, 606 insertions(+), 75 deletions(-)

--=20
2.19.1

