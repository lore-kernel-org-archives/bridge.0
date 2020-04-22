Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1587572508; x=1619108508;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=xoMFGgH5DELLbtoeobiA873J6IsfnJEOZCpVd+LRec0=;
 b=Kh6eHupfzz5RVxor0yr5pi9QV7FdB3j/YZSAvrFrbMcxG4a0oo3px8gk
 SsfKJ8BQ+SUd3CljZKnknjJ1ZFldqnPZaBHTALnYHIIvo2WtyIFtIkDxj
 CG+AqmQOKOwtvncubuCoQ92RNzgXNtYrfLfKL/N43kYp+iwqcEQCKVWaE
 b+daLKvb6U+7E7swiNCjyIQm+siY42iBP5ju7Y7n+GiljXxVLcDQfjsNh
 WVvMU4a3SxItfIDjLf335cZLVXeP/Pt2WskSf/u12Y034TtEEO13TnyZj
 KZ7CPcnYU+agxyiYcpMdfFJ3jv0jI8K1Nz3nS5K9tsVTOgKVkuRlizpWP A==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Wed, 22 Apr 2020 18:18:24 +0200
Message-ID: <20200422161833.1123-3-horatiu.vultur@microchip.com>
In-Reply-To: <20200422161833.1123-1-horatiu.vultur@microchip.com>
References: <20200422161833.1123-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v3 02/11] bridge: mrp: Update Kconfig
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

