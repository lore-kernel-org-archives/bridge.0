Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1586863640; x=1618399640;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=1BR/cROdhCyfHaruTl2nwBlZr33q3GBAyi/Fdo/0EBs=;
 b=Sxx+bmhFrFiDOtNx8DIOtFmKLaLWd6R9EjSkGqVmz3rcvMisbW7Pe60b
 +SnL379uC/1DUOwe2ZhT2iHuHDnkaDgbUMPdY4T9kVSh0DjjVPy29zU29
 s16sARZe9Hlxxr6PIvpPcNLw2yKcUTiSyZIPmVMedDbDT/znyvxDc/UQ9
 A5A9ljRWgy1PZ5eMLYfxfE4SdZMf7UrZdt6nys5QFgaSp4k7btALIQrXm
 pvEmLftyUQAFKJqfx28QWmsZPLeBGCwPvj8S7pNRuAptF2iiGXZUTIQnK
 W1ndYMTdhzjiRpc45mIHHdYACqFimKQj7q0/X5tyK7s3i3BtWzMTNP3+m Q==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Tue, 14 Apr 2020 13:26:12 +0200
Message-ID: <20200414112618.3644-4-horatiu.vultur@microchip.com>
In-Reply-To: <20200414112618.3644-1-horatiu.vultur@microchip.com>
References: <20200414112618.3644-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [RFC net-next v5 3/9] bridge: mrp: Expose function
	br_mrp_port_open
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com, davem@davemloft.net, jiri@resnulli.us, ivecera@redhat.com, kuba@kernel.org, roopa@cumulusnetworks.com, olteanv@gmail.com, andrew@lunn.ch, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, UNGLinuxDriver@microchip.com
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

In case the HW is capable to detect when the MRP ring is open or closed. It is
expected that the network driver will notify the SW that the ring is open or
closed.

The function br_mrp_port_open is used to notify the kernel that one of the ports
stopped receiving MRP_Test frames. The argument 'loc' has a value of '1' when
the port stopped receiving MRP_Test and '0' when it started to receive MRP_Test.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 include/linux/mrp_bridge.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 include/linux/mrp_bridge.h

diff --git a/include/linux/mrp_bridge.h b/include/linux/mrp_bridge.h
new file mode 100644
index 000000000000..23d46b356263
--- /dev/null
+++ b/include/linux/mrp_bridge.h
@@ -0,0 +1,24 @@
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
+ * This eventually notify the userspace which is required to react on these
+ * changes.
+ */
+
+#if IS_ENABLED(CONFIG_BRIDGE_MRP)
+int br_mrp_port_open(struct net_device *dev, u8 loc);
+#else
+inline int br_mrp_port_open(struct net_device *dev, u8 loc)  {}
+#endif
+
+#endif
-- 
2.17.1

