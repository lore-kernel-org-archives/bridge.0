Return-Path: <Henrik.Bjoernlund@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1602511607; x=1634047607;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=z/azl5BnzVm0a/cB4wNJ4rLs6sepOzbuELGnaeDal8k=;
 b=gLf1eQiE3VQo7bNCt03eTTMS/wr6IPGb8mo0gt19Ae527lZeDnew7KNE
 begB1WoTR7MigoyTVEj31sNuCS+Vy0efWSFUDv1A1qoVF+xZG7wuoDfaH
 m/V3L+EFUY263olj/bKLV0JAY/T2A6oGcjFgDHq3hrtm02bERVJTweng0
 ORJ+THbDXwH8MZr+HX4wn+4Oj44/Afz64cjDDSw5Z2A6kX0CkTKtRg0L1
 PyspuzacYcNbWjCcuZQdAenJQ6jUTEcfgm9kNFwCdRFE2hXV9ng+ayfwX
 w+y8L4Ei1n3/wChOMTEKsoY0TTcujO1NmoBgVuPMzLd5krQAN+Vsyc3R7 g==;
From: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>
Date: Mon, 12 Oct 2020 14:04:18 +0000
Message-ID: <20201012140428.2549163-1-henrik.bjoernlund@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v5 00/10] net: bridge: cfm: Add support
	for Connectivity Fault Management(CFM)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com, nikolay@nvidia.com, jiri@mellanox.com, idosch@mellanox.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, UNGLinuxDriver@microchip.com
Cc: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>

Connectivity Fault Management (CFM) is defined in 802.1Q section 12.14.

Connectivity Fault Management (CFM) comprises capabilities for detecting, verifying,
and isolating connectivity failures in Virtual Bridged Networks.
These capabilities can be used in networks operated by multiple independent organizations,
each with restricted management access to each other’s equipment.

CFM functions are partitioned as follows:
    — Path discovery
    — Fault detection
    — Fault verification and isolation
    — Fault notification
    — Fault recovery

The primary CFM protocol shims are called Maintenance Points (MPs).
A MP can be either a MEP or a MHF.
The MEP:
    -It is the Maintenance association End Point
     described in 802.1Q section 19.2.
    -It is created on a specific level (1-7) and is assuring
     that no CFM frames are passing through this MEP on lower levels.
    -It initiates and terminates/validates CFM frames on its level.
    -It can only exist on a port that is related to a bridge.
The MHF:
    -It is the Maintenance Domain Intermediate Point
     (MIP) Half Function (MHF) described in 802.1Q section 19.3.
    -It is created on a specific level (1-7).
    -It is extracting/injecting certain CFM frame on this level.
    -It can only exist on a port that is related to a bridge.
    -Currently not supported.

There are defined the following CFM protocol functions:
    -Continuity Check
    -Loopback. Currently not supported.
    -Linktrace. Currently not supported.

This CFM component supports create/delete of MEP instances and configuration of
the different CFM protocols. Also status information can be fetched and delivered
through notification due to defect status change.

The user interacts with CFM using the 'cfm' user space client program,
the client talks with the kernel using netlink.

Any notification emitted by CFM from the kernel can be monitored in user space
by starting 'cfm_server' program.

Currently this 'cfm' and 'cfm_server' programs are standalone placed in a cfm
repository https://github.com/microchip-ung/cfm but it is considered to integrate
this into 'iproute2'.

v1 -> v2
    Added the CFM switchdev interface and also added utilization by calling the
    interface from the kernel CFM implementation trying to offload CFM functionality
    to HW. This offload (CFM driver) is currently not implemented.
    
    Corrections based on RCF comments:
        -The single CFM kernel implementation Patch is broken up into three patches.
        -Changed the list of MEP instances from list_head to hlist_head.
        -Removed unnecessary RCU list traversing.
        -Solved RCU unlocking problem.
        -Removed unnecessary comments.
        -Added ASSERT_RTNL() where required.
        -Shaping up on error messages.
        -Correction NETLINK br_fill_ifinfo() to be able to handle 'filter_mask'
         with multiple flags asserted.

v2 -> v3
    The switchdev definition and utilization has been removed as there was no
    switchdev implementation.
    Some compiling issues are fixed as Reported-by: kernel test robot <lkp@intel.com>.

v3 -> v4
    Fixed potential crash during hlist walk where elements are removed.
    Giving all commits unique titles.
    NETLINK implementation split into three commits.
    Commit "bridge: cfm: Bridge port remove" is merged with
    commit "bridge: cfm: Kernel space implementation of CFM. MEP create/delete."

v4 -> v5
    Reordered members in struct net_bridge to bring member frame_type_list to the
    first cache line.
    Helper functions nla_get_mac() and nla_get_maid() are removed.
    The NLA_POLICY_NESTED() macro is used to initialize the br_cfm_policy array. 
    Fixed reverse xmas tree.

Reviewed-by: Horatiu Vultur  <horatiu.vultur@microchip.com>
Signed-off-by: Henrik Bjoernlund  <henrik.bjoernlund@microchip.com>

Henrik Bjoernlund (10):
  net: bridge: extend the process of special frames
  bridge: cfm: Add BRIDGE_CFM to Kconfig.
  bridge: uapi: cfm: Added EtherType used by the CFM protocol.
  bridge: cfm: Kernel space implementation of CFM. MEP create/delete.
  bridge: cfm: Kernel space implementation of CFM. CCM frame TX added.
  bridge: cfm: Kernel space implementation of CFM. CCM frame RX added.
  bridge: cfm: Netlink SET configuration Interface.
  bridge: cfm: Netlink GET configuration Interface.
  bridge: cfm: Netlink GET status Interface.
  bridge: cfm: Netlink Notifications.

 include/uapi/linux/cfm_bridge.h |  70 +++
 include/uapi/linux/if_bridge.h  | 125 +++++
 include/uapi/linux/if_ether.h   |   1 +
 include/uapi/linux/rtnetlink.h  |   2 +
 net/bridge/Kconfig              |  11 +
 net/bridge/Makefile             |   2 +
 net/bridge/br_cfm.c             | 884 ++++++++++++++++++++++++++++++++
 net/bridge/br_cfm_netlink.c     | 726 ++++++++++++++++++++++++++
 net/bridge/br_device.c          |   4 +
 net/bridge/br_if.c              |   1 +
 net/bridge/br_input.c           |  33 +-
 net/bridge/br_mrp.c             |  19 +-
 net/bridge/br_netlink.c         | 115 ++++-
 net/bridge/br_private.h         |  77 ++-
 net/bridge/br_private_cfm.h     | 147 ++++++
 15 files changed, 2194 insertions(+), 23 deletions(-)
 create mode 100644 include/uapi/linux/cfm_bridge.h
 create mode 100644 net/bridge/br_cfm.c
 create mode 100644 net/bridge/br_cfm_netlink.c
 create mode 100644 net/bridge/br_private_cfm.h

-- 
2.28.0

