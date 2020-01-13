Return-Path: <Horatiu.Vultur@microchip.com>
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Mon, 13 Jan 2020 13:46:16 +0100
Message-ID: <20200113124620.18657-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [RFC net-next Patch v2 0/4] net: bridge: mrp: Add support
	for Media Redundancy Protocol(MRP)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com, jakub.kicinski@netronome.com, vivien.didelot@gmail.com, olteanv@gmail.com, anirudh.venkataramanan@intel.com, andrew@lunn.ch, dsahern@gmail.com, jiri@resnulli.us, ivecera@redhat.com, UNGLinuxDriver@microchip.com
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

Based on the discussion on the first RFC[1], we have created a new RFC showing
what we were expecting to offload to HW.

This patch series contains the same patches plus another one which adds MRP
support to switchdev. MRP can now offload to HW the process of sending and
terminating MRP_Test frames. But based on the discussions from the previous
version, we decided to try to implement this in user space and extend bridge
netlink interface to be able to offload to HW the creation, sending and the
termination of the MRP_Test frames. Therefor this patch series is more like a
future reference.

We were thinking to extend the bridge netlink in such a way to be able to
offload to HW using switchdev. We were thinking to extend the families IFLA_BR_
and IFLA_BRPORT to add MRP support. Do you think that would be OK? Or should we
create a new family for the MRP?

changes from V2:
- Extend the patch series with another patch. The new patches extends switchdev
  interface for MRP. MRP will offload to HW the creating and sending of the
  MRP_Test frames.

[1] https://www.spinics.net/lists/netdev/msg623647.html

Horatiu Vultur (4):
  net: bridge: mrp: Add support for Media Redundancy Protocol
  net: bridge: mrp: Integrate MRP into the bridge
  net: bridge: mrp: Add netlink support to configure MRP
  net: bridge: mrp: switchdev: Add HW offload

 include/net/switchdev.h        |   52 ++
 include/uapi/linux/if_bridge.h |   27 +
 include/uapi/linux/if_ether.h  |    1 +
 include/uapi/linux/rtnetlink.h |    7 +
 net/bridge/Kconfig             |   12 +
 net/bridge/Makefile            |    2 +
 net/bridge/br.c                |   19 +
 net/bridge/br_device.c         |    3 +
 net/bridge/br_forward.c        |    1 +
 net/bridge/br_if.c             |   10 +
 net/bridge/br_input.c          |   22 +
 net/bridge/br_mrp.c            | 1543 ++++++++++++++++++++++++++++++++
 net/bridge/br_mrp_switchdev.c  |  180 ++++
 net/bridge/br_mrp_timer.c      |  258 ++++++
 net/bridge/br_netlink.c        |    9 +
 net/bridge/br_private.h        |   30 +
 net/bridge/br_private_mrp.h    |  224 +++++
 security/selinux/nlmsgtab.c    |    5 +-
 18 files changed, 2404 insertions(+), 1 deletion(-)
 create mode 100644 net/bridge/br_mrp.c
 create mode 100644 net/bridge/br_mrp_switchdev.c
 create mode 100644 net/bridge/br_mrp_timer.c
 create mode 100644 net/bridge/br_private_mrp.h

-- 
2.17.1

