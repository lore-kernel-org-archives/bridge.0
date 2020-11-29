Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=JWvE4wkdTHgXND6Y4
 bjPsbiWmIMG3ggvyGEu9Fq8aWI=; b=mi1BAUBb2QpKhInOgWPOSFHzvFCiJqYGC
 qbJMVarRepEk5V9ansX6hKbMXL1PsT2qtJI69kiPrfKf2K4HeAO6f/F+ulhvAyJ4
 EeHFYttDKYEr2rQVxjYXR14/nYB7ybcyLavALnAyA3Sw/ra0MqJQO7yLbEX6VIli
 HjMhdO0+mAZDnfgEg3L07pLBoCXzBI8oa79ISmv2MCBbaJdCzzH7KACooBxzz/tR
 UppIAECK7BBzmpdFZxWoVEFlOdL6PEtiY3ZokiECl3EeBRejRgHVsKyh4c7ItnqG
 J9Zlw/tGrngbC8VHbPBegWpfnrggGdOGRxJ6t++DnAAwsmaO6jjcg==
From: Ido Schimmel <idosch@idosch.org>
Date: Sun, 29 Nov 2020 14:53:58 +0200
Message-Id: <20201129125407.1391557-1-idosch@idosch.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 0/9] mlxsw: Add support for 802.1ad
	bridging
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: ivecera@redhat.com, petrm@nvidia.com, amcohen@nvidia.com, danieller@nvidia.com, mlxsw@nvidia.com, Ido Schimmel <idosch@nvidia.com>, jiri@nvidia.com, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

From: Ido Schimmel <idosch@nvidia.com>

802.1ad, also known as QinQ, is an extension to the 802.1q standard,
which is concerned with passing possibly 802.1q-tagged packets through
another VLAN-like tunnel. The format of 802.1ad tag is the same as
802.1q, except it uses the EtherType of 0x88a8, unlike 802.1q's 0x8100.

Currently, mlxsw supports bridging with VLAN-unaware (802.1d) bridges
and with VLAN-aware bridges whose VLAN protocol is 802.1q. This set adds
support for VLAN-aware bridges whose VLAN protocol is 802.1ad.

From mlxsw perspective, 802.1ad support entails two main changes:

1. Ports member in an 802.1ad bridge need to be configured to classify
802.1ad packets as tagged and all other packets as untagged

2. When pushing a VLAN at ingress (PVID), its EtherType needs to be
0x88a8 instead of 802.1q's 0x8100

The rest stays the same as with 802.1q bridges.

A follow-up patch set will add support for QinQ with VXLAN, also known
as QinVNI. Currently, linking of a VXLAN netdev to an 802.1ad bridge is
vetoed and an error is returned to user space.

Patch set overview:

Patches #1-#2 add the registers required to configure the two changes
described above.

Patch #3 changes the device to only treat 802.1q packets as tagged by
default, as opposed to both 802.1q and 802.1ad packets. This is more
inline with the behavior supported by the driver.

Patch #4 adds the ability to configure the EtherType when pushing a PVID
at ingress.

Patch #5 performs small refactoring to allow for code re-use in the next
patch.

Patch #6 adds support for 802.1ad bridging and allows mlxsw ports and
their uppers to join such a bridge.

Patch #7 changes the bridge driver to notify about changes to its VLAN
protocol, so that these could be vetoed by mlxsw in the next patch.

Patches #8-#9 teach mlxsw to veto unsupported 802.1ad configurations and
add a corresponding selftest to make sure such configurations are indeed
vetoed.

Amit Cohen (6):
  mlxsw: reg: Add Switch Port VLAN Classification Register
  mlxsw: reg: Add et_vlan field to SPVID register
  mlxsw: spectrum: Only treat 802.1q packets as tagged packets
  mlxsw: Make EtherType configurable when pushing VLAN at ingress
  mlxsw: spectrum_switchdev: Create common functions for VLAN-aware
    bridge
  mlxsw: spectrum_switchdev: Add support of QinQ traffic

Danielle Ratson (3):
  bridge: switchdev: Notify about VLAN protocol changes
  mlxsw: Add QinQ configuration vetoes
  selftests: forwarding: Add QinQ veto testing

 drivers/net/ethernet/mellanox/mlxsw/reg.h     | 114 ++++++-
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 111 ++++++-
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |   7 +-
 .../ethernet/mellanox/mlxsw/spectrum_router.c |   9 +
 .../mellanox/mlxsw/spectrum_switchdev.c       | 123 +++++++-
 include/net/switchdev.h                       |   2 +
 net/bridge/br_vlan.c                          |  16 +-
 .../drivers/net/mlxsw/q_in_q_veto.sh          | 296 ++++++++++++++++++
 8 files changed, 657 insertions(+), 21 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/mlxsw/q_in_q_veto.sh

-- 
2.28.0

