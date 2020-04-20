Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1587395512; x=1618931512;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=I+CGxBoZd30PrmJpCWLZZXkNEaYyfUWmvp7NQzpTBRk=;
 b=1X3ERxk5lIa5Y7kTBarcvh2s4QmL/gc5RYAviz3DsIpADFSs7lHlPZXr
 iwIvfGD+7+uekc152wZrPfgBT2QsrSIYHN0VNoSK5p14D/4bvqe88xxcN
 LljC6vb9xNnIKrENch2aHDxGla6L39p1kcOUSIOZrDQJ8726lSVNjllHQ
 JxgYKhzZbp7kcQw+V8K+rx7+oZEiZZudiseTG0QoRTSHFzFzITUXzHo4Y
 F5LEHnCpWzUHssLoc0VnvK2WwFUimOrv9iZwVqr385jC1sXqGjV/jJx8U
 PIDv4lNio7JC3XqOy9sSSmOTpNtDatn2u0/4E3rWRZPK+sPZXJiQp1JUt g==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Mon, 20 Apr 2020 17:09:38 +0200
Message-ID: <20200420150947.30974-5-horatiu.vultur@microchip.com>
In-Reply-To: <20200420150947.30974-1-horatiu.vultur@microchip.com>
References: <20200420150947.30974-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 04/13] bridge: mrp: Expose function
	br_mrp_port_open
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com, davem@davemloft.net, jiri@resnulli.us, ivecera@redhat.com, kuba@kernel.org, roopa@cumulusnetworks.com, olteanv@gmail.com, andrew@lunn.ch, UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

In case the HW is capable to detect when the MRP ring is open or closed. It is
expected that the network driver will notify the SW that the ring is open or
closed.

The function br_mrp_port_open is used to notify the kernel that one of the ports
stopped receiving MRP_Test frames. The argument 'loc' has a value of '1' when
the port stopped receiving MRP_Test and '0' when it started to receive MRP_Test.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 include/linux/mrp_bridge.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 include/linux/mrp_bridge.h

diff --git a/include/linux/mrp_bridge.h b/include/linux/mrp_bridge.h
new file mode 100644
index 000000000000..61c1f0d395c7
--- /dev/null
+++ b/include/linux/mrp_bridge.h
@@ -0,0 +1,27 @@
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
+ * Needs to be called with rcu_read_lock().
+ *
+ * This eventually notify the userspace which is required to react on these
+ * changes.
+ */
+
+#if IS_ENABLED(CONFIG_BRIDGE_MRP)
+int br_mrp_port_open(struct net_device *dev, u8 loc);
+#else
+static inline int br_mrp_port_open(struct net_device *dev, u8 loc)
+{
+}
+#endif
+
+#endif
-- 
2.17.1

