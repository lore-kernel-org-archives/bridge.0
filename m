Return-Path: <idosch@mellanox.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=eiNOhCp9fMW4v4rrvwZuJJ9c1aKAmab019jcURrBLHE=;
	b=TyV4ZwPB08BKC29S4LP0MYr/moq8mmW6kqkwbWpyECOGbSIvNI1b4An1zQYE8k1AwhX3kOoP9+coVX5QAS4z8U6pTpBQ1WWChp96799yNDYBiC/v4DXrvYP84lfU2gTRnWfdx6pzeNKWq25V769+k+DZUeTZsSCFJJZYE2Ip0cQ=
From: Ido Schimmel <idosch@mellanox.com>
Date: Wed, 28 Nov 2018 20:06:56 +0000
Message-ID: <20181128200558.31343-1-idosch@mellanox.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 0/8] mlxsw: Add VxLAN support with
	VLAN-aware bridges
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>
Cc: mlxsw <mlxsw@mellanox.com>, "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, Ido Schimmel <idosch@mellanox.com>, Jiri Pirko <jiri@mellanox.com>, Petr Machata <petrm@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

Commit 53e50a6ec24d ("Merge branch 'mlxsw-Add-VxLAN-support'") added
mlxsw support for VxLAN when the VxLAN device was enslaved to
VLAN-unaware bridges. This patchset extends mlxsw to also support VxLAN
with VLAN-aware bridges.

With VLAN-aware bridges, the VxLAN device's VNI is mapped to the VLAN
that is configured as 'pvid untagged' on the corresponding bridge port.
To prevent ambiguity, mlxsw forbids configurations in which the same
VLAN is configured as 'pvid untagged' on multiple VxLAN devices.

Patches #1-#2 add the necessary APIs in mlxsw and the bridge driver.

Patches #3-#4 perform small refactoring in order to prepare mlxsw for
VLAN-aware support.

Patch #5 finally enables the enslavement of VxLAN devices to a
VLAN-aware bridge. Among other things, it extends mlxsw to handle
switchdev notifications about VLAN add / delete on a VxLAN device
enslaved to an offloaded VLAN-aware bridge.

Patches #6-#8 add selftests to test the new functionality.

Ido Schimmel (8):
  net: bridge: Extend br_vlan_get_pvid() for bridge ports
  mlxsw: spectrum_fid: Add API to lookup 802.1Q FIDs without creating
    them
  mlxsw: spectrum_switchdev: Unify VxLAN leave function
  mlxsw: spectrum_switchdev: Prepare function for VLAN-aware bridges
  mlxsw: spectrum: Enable VxLAN enslavement to VLAN-aware bridges
  selftests: mlxsw: Consider VLAN-aware bridges as valid
  selftests: mlxsw: Add a test for VxLAN configuration with a VLAN-aware
    bridge
  selftests: forwarding: Add VxLAN test with a VLAN-aware bridge

 .../net/ethernet/mellanox/mlxsw/spectrum.c    |  53 +-
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  26 +-
 .../ethernet/mellanox/mlxsw/spectrum_fid.c    |   6 +
 .../mellanox/mlxsw/spectrum_switchdev.c       | 407 +++++++--
 net/bridge/br_vlan.c                          |   6 +-
 .../selftests/drivers/net/mlxsw/vxlan.sh      | 206 ++++-
 .../net/forwarding/vxlan_bridge_1q.sh         | 790 ++++++++++++++++++
 .../forwarding/vxlan_bridge_1q_port_8472.sh   |  10 +
 8 files changed, 1441 insertions(+), 63 deletions(-)
 create mode 100755 tools/testing/selftests/net/forwarding/vxlan_bridge_1q.=
sh
 create mode 100755 tools/testing/selftests/net/forwarding/vxlan_bridge_1q_=
port_8472.sh

--=20
2.19.1

