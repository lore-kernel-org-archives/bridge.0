Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1587907433; x=1619443433;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=Cs2IxwzEDfKTybGbgmEWRRh58Im0y8KqYjlGzy87Z/Q=;
 b=Qw5JHa85EsWgcvJvWy5BQwjDkz9xYuCHaOLowQfLgMB2TghMZgH149N7
 NCdYL2LBBKS+Oyvll5usMTXezBwAzaftLrOrsU/wJrPkw+3gQHTi2u4h7
 dsiYUEDC72G8K1gOkiZzHoXAY5ewI4u+3ndwAy1mo1kOZQ3F6LaMnfcKP
 BPUjLIWQpEyYu1wfd9PKEr0sajpjwDpGhKgsHqT6mBSvtltbDaqies3mN
 ivh+aRpMu21JBWfj5EOQVcqI9Vy6xELDVODWIlyXNUat6EPe8CmxGWjRf
 g0EroI6VgaHrAH5pchdd5qNIi0ptn+4yUtkJf49VP4YKmYop9ru989Rha Q==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Sun, 26 Apr 2020 15:21:59 +0200
Message-ID: <20200426132208.3232-3-horatiu.vultur@microchip.com>
In-Reply-To: <20200426132208.3232-1-horatiu.vultur@microchip.com>
References: <20200426132208.3232-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v4 02/11] bridge: mrp: Update Kconfig
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

Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
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

