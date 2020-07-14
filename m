Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1594712349; x=1626248349;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rT+zkN+mJUyB0ZWqxtGVHHzSd7amrOhD/J3nYFKzHLU=;
 b=JxwlPnROO58/6tiag1X7+FgYJlMgutV5hmr5/83/N8fVXL6dXLbKDrQ/
 62CEyQS0c4Fn2nUinKDATS3a605riYo34lq/HcuR+w9BGd0ni0jRxqn+4
 +DTJAh7OUt+5fQWFl1yuL9c5qzoNVYoKk12gNIr22o3pXJTe6JqmrOF7l
 3lagI9KWbF6+z3J6KzpTYXNQJjH7SHpdJBLkc6hybrfyM0BTkQ0ilLMDW
 BMI0CjKVfT2J8xlf0/Pz+SOSHDQrvWdJkok/QNwNTdM53Y6VAmAClIPsS
 hz/6G8gNnOAB1OXNeq0YND8HpK0A5ZPOMyae1CiRD/HAoDK5/vDUC2QV3 Q==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Tue, 14 Jul 2020 09:34:49 +0200
Message-ID: <20200714073458.1939574-4-horatiu.vultur@microchip.com>
In-Reply-To: <20200714073458.1939574-1-horatiu.vultur@microchip.com>
References: <20200714073458.1939574-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v4 03/12] bridge: mrp: Extend bridge
	interface
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

