Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 646A941E22
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0998F41DB2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qrEMH4BQbSQbJiTLD3+R9DLamA6We3+0Ydw66iZgbo=;
 b=rtp3+mit0HHb6OYOxIkDZ5UgfgTK0Fq0lP9PxoOy6pcrxsr2MOuThZ2U+0P0pQjmgfDVIB6To7e+aFEK8gIlAE/ZlJzln6mERUXKfKjK8qD4QnF08ho6SjZ/FEPpWHlnCBzmXggKpspAae7LtXqHuhqcn9XK3xvVQt/2GWzaZ+7w9dOlIS2TFNOv87NhAogxRUiBySVJzY6Gu9U4ewZL6wECROqwiELsI1K8XyhT8vc26oOub/vOFZ33HLWsUhB97lpDne5Kn2i8Dkeh+p1un+WNXAJ7qQxA8yWyqeQqNESfAFbyn0gWiiVvcprOKZfE/HrBWrBbBigyEs+AWI1mpg==
From: Ido Schimmel <idosch@nvidia.com>
Date: Wed, 19 Apr 2023 18:34:51 +0300
Message-Id: <20230419153500.2655036-1-idosch@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next v2 0/9] bridge: Add per-{Port,
	VLAN} neighbor suppression
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

Background
==========

In order to minimize the flooding of ARP and ND messages in the VXLAN
network, EVPN includes provisions [1] that allow participating VTEPs to
suppress such messages in case they know the MAC-IP binding and can
reply on behalf of the remote host. In Linux, the above is implemented
in the bridge driver using a per-port option called "neigh_suppress"
that was added in kernel version 4.15 [2].

Motivation
==========

Some applications use ARP messages as keepalives between the application
nodes in the network. This works perfectly well when two nodes are
connected to the same VTEP. When a node goes down it will stop
responding to ARP requests and the other node will notice it
immediately.

However, when the two nodes are connected to different VTEPs and
neighbor suppression is enabled, the local VTEP will reply to ARP
requests even after the remote node went down, until certain timers
expire and the EVPN control plane decides to withdraw the MAC/IP
Advertisement route for the address. Therefore, some users would like to
be able to disable neighbor suppression on VLANs where such applications
reside and keep it enabled on the rest.

Implementation
==============

The proposed solution is to allow user space to control neighbor
suppression on a per-{Port, VLAN} basis, in a similar fashion to other
per-port options that gained per-{Port, VLAN} counterparts such as
"mcast_router". This allows users to benefit from the operational
simplicity and scalability associated with shared VXLAN devices (i.e.,
external / collect-metadata mode), while still allowing for per-VLAN/VNI
neighbor suppression control.

The user interface is extended with a new "neigh_vlan_suppress" bridge
port option that allows user space to enable per-{Port, VLAN} neighbor
suppression on the bridge port. When enabled, the existing
"neigh_suppress" option has no effect and neighbor suppression is
controlled using a new "neigh_suppress" VLAN option. Example usage:

 # bridge link set dev vxlan0 neigh_vlan_suppress on
 # bridge vlan add vid 10 dev vxlan0
 # bridge vlan set vid 10 dev vxlan0 neigh_suppress on

Testing
=======

Tested using existing bridge selftests. Added a dedicated selftest in
the last patch.

Patchset overview
=================

Patches #1-#5 are preparations.

Patch #6 adds per-{Port, VLAN} neighbor suppression support to the
bridge's data path.

Patches #7-#8 add the required netlink attributes to enable the feature.

Patch #9 adds a selftest.

iproute2 patches can be found here [3].

Changelog
=========

Since RFC [4]:

No changes.

[1] https://www.rfc-editor.org/rfc/rfc7432#section-10
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a42317785c898c0ed46db45a33b0cc71b671bf29
[3] https://github.com/idosch/iproute2/tree/submit/neigh_suppress_v1
[4] https://lore.kernel.org/netdev/20230413095830.2182382-1-idosch@nvidia.com/

Ido Schimmel (9):
  bridge: Reorder neighbor suppression check when flooding
  bridge: Pass VLAN ID to br_flood()
  bridge: Add internal flags for per-{Port, VLAN} neighbor suppression
  bridge: Take per-{Port, VLAN} neighbor suppression into account
  bridge: Encapsulate data path neighbor suppression logic
  bridge: Add per-{Port, VLAN} neighbor suppression data path support
  bridge: vlan: Allow setting VLAN neighbor suppression state
  bridge: Allow setting per-{Port, VLAN} neighbor suppression state
  selftests: net: Add bridge neighbor suppression test

 include/linux/if_bridge.h                     |   1 +
 include/uapi/linux/if_bridge.h                |   1 +
 include/uapi/linux/if_link.h                  |   1 +
 net/bridge/br_arp_nd_proxy.c                  |  33 +-
 net/bridge/br_device.c                        |   8 +-
 net/bridge/br_forward.c                       |   8 +-
 net/bridge/br_if.c                            |   2 +-
 net/bridge/br_input.c                         |   2 +-
 net/bridge/br_netlink.c                       |   8 +-
 net/bridge/br_private.h                       |   5 +-
 net/bridge/br_vlan.c                          |   1 +
 net/bridge/br_vlan_options.c                  |  20 +-
 net/core/rtnetlink.c                          |   2 +-
 tools/testing/selftests/net/Makefile          |   1 +
 .../net/test_bridge_neigh_suppress.sh         | 862 ++++++++++++++++++
 15 files changed, 936 insertions(+), 19 deletions(-)
 create mode 100755 tools/testing/selftests/net/test_bridge_neigh_suppress.sh

-- 
2.37.3

