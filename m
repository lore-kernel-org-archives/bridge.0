Return-Path: <Horatiu.Vultur@microchip.com>
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Fri, 24 Jan 2020 17:18:20 +0100
Message-ID: <20200124161828.12206-3-horatiu.vultur@microchip.com>
In-Reply-To: <20200124161828.12206-1-horatiu.vultur@microchip.com>
References: <20200124161828.12206-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [RFC net-next v3 02/10] net: bridge: mrp: Expose function
	br_mrp_port_open
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, jiri@resnulli.us, ivecera@redhat.com, davem@davemloft.net, roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com, anirudh.venkataramanan@intel.com, olteanv@gmail.com, andrew@lunn.ch, jeffrey.t.kirsher@intel.com, UNGLinuxDriver@microchip.com
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

In case the HW is capable to detect when the MRP ring is open or closed. It is
expected that the network driver will notify the bridge that the ring is open or
closed.

The function br_mrp_port_open is used to notify the kernel that one of the ports
stopped receiving MRP_Test frames. The argument 'loc' has a value of '1' when
the port stopped receiving MRP_Test and '0' when it started to receive MRP_Test.

This notification will eventually reach the userspace via netlink interface and
the userspace application will process this information.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 include/linux/mrp_bridge.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 include/linux/mrp_bridge.h

diff --git a/include/linux/mrp_bridge.h b/include/linux/mrp_bridge.h
new file mode 100644
index 000000000000..0508bbe6ecdb
--- /dev/null
+++ b/include/linux/mrp_bridge.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _LINUX_MRP_BRIDGE_H
+#define _LINUX_MRO_BRIDGE_H
+
+#include <linux/netdevice.h>
+
+/* The drivers are responsible to call this function when it detects that the
+ * MRP port stopped receiving MRP_Test frames or it started to receive MRP_Test.
+ * The argument dev represents the port and loc(Lost of Continuity) has a value
+ * of 1 when it stopped receiving MRP_Test frames and a value of 0 when it
+ * started to receive frames.
+ *
+ * This eventually eventually notify the userspace which is required to react on
+ * thise changes.
+ */
+
+#ifdef CONFIG_BRIDGE_MRP
+void br_mrp_port_open(struct net_device *dev, u8 loc);
+#else
+inline void br_mrp_port_open(struct net_device *dev, u8 loc)  {}
+#endif
+
+#endif
+
-- 
2.17.1

