Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1587395517; x=1618931517;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=xoMFGgH5DELLbtoeobiA873J6IsfnJEOZCpVd+LRec0=;
 b=yJCzIVIJ0iaaRXr9NF+wjn/48ndoGk74JT+oPtw7R4f8nNY+oCZiCA2c
 iijINzVM/QxmirgoiD5Hz9E80n2KODLAZ2hOEIq5bPvmmCVxR9gqxBSZx
 TgADaLnGclK5VjHIVXFYqOnhPgNGP8mdhhcLAOw+gV+VJD9qu3CTTMeB4
 lGd3KYsPeDAxqrVOVjdMb35SjkwMhhH2QrKDn7uOrx+Sb8Uhn8s3rSZ5m
 0ndjuraLWZpS98DROnOZKmdRLYOABSP/cL/Agy7JfQcQxajudP6crudCE
 8CvmNC80FHzaWkzGJzKlaENkP0g83PWs1pdkPSfHzVLp7Xzhyq+odJwlz g==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Mon, 20 Apr 2020 17:09:37 +0200
Message-ID: <20200420150947.30974-4-horatiu.vultur@microchip.com>
In-Reply-To: <20200420150947.30974-1-horatiu.vultur@microchip.com>
References: <20200420150947.30974-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 03/13] bridge: mrp: Update Kconfig
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

Add the option BRIDGE_MRP to allow to build in or not MRP support.
The default value is N.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 net/bridge/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

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
-- 
2.17.1

