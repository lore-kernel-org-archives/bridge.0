Return-Path: <Horatiu.Vultur@microchip.com>
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Fri, 27 Mar 2020 10:21:26 +0100
Message-ID: <20200327092126.15407-10-horatiu.vultur@microchip.com>
In-Reply-To: <20200327092126.15407-1-horatiu.vultur@microchip.com>
References: <20200327092126.15407-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [RFC net-next v4 9/9] bridge: mrp: Update Kconfig and
	Makefile
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, jiri@resnulli.us, ivecera@redhat.com, kuba@kernel.org, roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com, olteanv@gmail.com, andrew@lunn.ch, UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

Add the option BRIDGE_MRP to allow to build in or not MRP support.
The default value is N.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 net/bridge/Kconfig  | 12 ++++++++++++
 net/bridge/Makefile |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/net/bridge/Kconfig b/net/bridge/Kconfig
index e4fb050e2078..51a6414145d2 100644
--- a/net/bridge/Kconfig
+++ b/net/bridge/Kconfig
@@ -61,3 +61,15 @@ config BRIDGE_VLAN_FILTERING
 	  Say N to exclude this support and reduce the binary size.
 
 	  If unsure, say Y.
+
+config BRIDGE_MRP
+	bool "MRP protocol"
+	depends on BRIDGE
+	default n
+	help
+	  If you say Y here, then the Ethernet bridge will be able to run MRP
+	  protocol to detect loops
+
+	  Say N to exclude this support and reduce the binary size.
+
+	  If unsure, say N.
diff --git a/net/bridge/Makefile b/net/bridge/Makefile
index 49da7ae6f077..9bf3e1be3328 100644
--- a/net/bridge/Makefile
+++ b/net/bridge/Makefile
@@ -25,3 +25,5 @@ bridge-$(CONFIG_BRIDGE_VLAN_FILTERING) += br_vlan.o br_vlan_tunnel.o br_vlan_opt
 bridge-$(CONFIG_NET_SWITCHDEV) += br_switchdev.o
 
 obj-$(CONFIG_NETFILTER) += netfilter/
+
+bridge-$(CONFIG_BRIDGE_MRP)	+= br_mrp.o br_mrp_netlink.o br_mrp_switchdev.o
-- 
2.17.1

