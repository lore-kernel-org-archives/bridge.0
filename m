Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=jQkP0vk06hZhxt2sGgm6KzwCY+4bSqAX7W4iCZW27fQ=;
	b=RjC3Z3zrgULDfyAuJgH1c3Bzavr9yYxEozdhbwpKWb5fBqiO+p+Ubww/EVnWCa62MOlu8QUR5sjaMCSbL0kJ8O1iiyQsukAOKHB2n0pp0knNT+jfvEUL3vNKpmPvS0qJh3UUZGlytLSe7CsOiqWrmiovQ0T7P4EJvhlt17CNbK4=
From: Ido Schimmel <idosch@mellanox.com>
Date: Sat, 13 Oct 2018 17:18:19 +0000
Message-ID: <20181013171725.3261-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 00/18] mlxsw: Add VxLAN support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "ivecera@redhat.com" <ivecera@redhat.com>, "andrew@lunn.ch" <andrew@lunn.ch>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, mlxsw <mlxsw@mellanox.com>, Ido Schimmel <idosch@mellanox.com>, "vivien.didelot@savoirfairelinux.com" <vivien.didelot@savoirfairelinux.com>, "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Jiri Pirko <jiri@mellanox.com>, Petr Machata <petrm@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

This patchset adds support for VxLAN offload in the mlxsw driver.

With regards to the forwarding plane, VxLAN support is composed from two
main parts: Encapsulation and decapsulation.

In the device, NVE encapsulation (and VxLAN in particular) takes place
in the bridge. A packet can be encapsulated using VxLAN either because
it hit an FDB entry that forwards it to the router with the IP of the
remote VTEP or because it was flooded, in which case it is sent to a
list of remote VTEPs (in addition to local ports). In either case, the
VNI is derived from the filtering identifier (FID) the packet was
classified to at ingress and the underlay source IP is taken from a
device global configuration.

VxLAN decapsulation takes place in the underlay router, where packets
that hit a local route that corresponds to the source IP of the local
VTEP are decapsulated and injected to the bridge. The packets are
classified to a FID based on the VNI they came with.

The first six patches export the required APIs in the VxLAN and mlxsw
drivers in order to allow for the introduction of the NVE core in the
next two patches. The NVE core is designed to support a variety of NVE
encapsulations (e.g., VxLAN, NVGRE) and different ASICs, but currently
only VxLAN and Spectrum are supported. Spectrum-2 support will be added
in the future.

The last 10 patches add support for VxLAN decapsulation and
encapsulation and include the addition of the required switchdev APIs in
the VxLAN driver. These APIs allow capable drivers to get a notification
about the addition / deletion of FDB entries to / from the VxLAN's FDB.

Subsequent patchset will add selftests (generic and mlxsw-specific),
data plane learning, FDB extack and vetoing and support for VLAN-aware
bridges (one VNI per VxLAN device model).

Ido Schimmel (14):
  mlxsw: spectrum_fid: Allow setting and clearing NVE properties on FID
  mlxsw: spectrum_fid: Add APIs to lookup FID without creating it
  mlxsw: spectrum_router: Enable local routes promotion to perform NVE
    decap
  mlxsw: spectrum_router: Allow querying VR ID based on table ID
  vxlan: Export address checking functions
  inet: Refactor INET_ECN_decapsulate()
  mlxsw: spectrum_nve: Implement common NVE core
  mlxsw: spectrum_nve: Implement VxLAN operations
  mlxsw: spectrum_fid: Clear NVE configuration when destroying 802.1D
    FIDs
  mlxsw: spectrum_router: Configure matching local routes for NVE decap
  vxlan: Add netif_is_vxlan()
  bridge: switchdev: Allow clearing FDB entry offload indication
  mlxsw: spectrum: Enable VxLAN enslavement to bridges
  mlxsw: spectrum_switchdev: Add support for VxLAN encapsulation

Petr Machata (4):
  vxlan: Add switchdev notifications
  vxlan: Add vxlan_fdb_find_uc() for FDB querying
  vxlan: Support marking RDSTs as offloaded
  vxlan: Notify for each remote of a removed FDB entry

 drivers/net/ethernet/mellanox/mlxsw/Makefile  |   3 +-
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 125 +++
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  88 ++
 .../ethernet/mellanox/mlxsw/spectrum_fid.c    | 225 +++-
 .../ethernet/mellanox/mlxsw/spectrum_nve.c    | 982 ++++++++++++++++++
 .../ethernet/mellanox/mlxsw/spectrum_nve.h    |  49 +
 .../mellanox/mlxsw/spectrum_nve_vxlan.c       | 249 +++++
 .../ethernet/mellanox/mlxsw/spectrum_router.c | 138 ++-
 .../mellanox/mlxsw/spectrum_switchdev.c       | 552 +++++++++-
 drivers/net/ethernet/rocker/rocker_main.c     |   1 +
 drivers/net/vxlan.c                           | 177 +++-
 include/linux/netdevice.h                     |   8 +
 include/net/inet_ecn.h                        |  18 +-
 include/net/switchdev.h                       |   7 +-
 include/net/vxlan.h                           |  57 +
 net/bridge/br.c                               |   4 +-
 net/bridge/br_fdb.c                           |   4 +-
 net/bridge/br_private.h                       |   2 +-
 net/bridge/br_switchdev.c                     |   9 +-
 net/dsa/slave.c                               |   1 +
 20 files changed, 2643 insertions(+), 56 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c
 create mode 100644 drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.h
 create mode 100644 drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.=
c

--=20
2.17.2

