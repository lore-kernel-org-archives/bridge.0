Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1594027251; x=1625563251;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rT+zkN+mJUyB0ZWqxtGVHHzSd7amrOhD/J3nYFKzHLU=;
 b=b/ABYkgUWvVqDnYYsGFzsTJjavFnQOAJNoKuu+8wGPfeMMUKoMt9gbgu
 leX+4BWZkZpIZzo3IvtsxEAQQPgNvx9fCwpYuczTQ8BYOt+tU6XMllosM
 98Sl6CVRBnSKorycBzlrFy1yFwEr1nCQsY746liqGs1XayhEDBAXkIQaa
 IxkCZh2o7U857N67jVes0YZKfwYJmz/NaLLpblafRkWsKw1Voi4fu+0AW
 3qPfdXU6hO22XRRl0Gu4Bw8NhsWsIlj9OLuaeMrYsNBH4tNlP6SnqsYRZ
 21YT8oV8ioPgPyS+ZN0oeS2wDVK1o19Z852m/f/q5okhzYIIofpO+1CA4 w==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Mon, 6 Jul 2020 11:18:33 +0200
Message-ID: <20200706091842.3324565-4-horatiu.vultur@microchip.com>
In-Reply-To: <20200706091842.3324565-1-horatiu.vultur@microchip.com>
References: <20200706091842.3324565-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 03/12] bridge: mrp: Extend bridge interface
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org, jiri@resnulli.us, ivecera@redhat.com, andrew@lunn.ch, UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

This patch adds a new flag(BR_MRP_LOST_IN_CONT) to the net bridge
ports. This bit will be set when the port lost the continuity of
MRP_InTest frames.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 include/linux/if_bridge.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index b3a8d3054af0f..6479a38e52fa9 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -49,6 +49,7 @@ struct br_ip_list {
 #define BR_ISOLATED		BIT(16)
 #define BR_MRP_AWARE		BIT(17)
 #define BR_MRP_LOST_CONT	BIT(18)
+#define BR_MRP_LOST_IN_CONT	BIT(19)
 
 #define BR_DEFAULT_AGEING_TIME	(300 * HZ)
 
-- 
2.27.0

