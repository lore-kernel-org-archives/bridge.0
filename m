Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1612902263; x=1644438263;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EHLVPvUVJez21AH8PebxAXBSYM5AvLzTmtWmafYTWPs=;
 b=YwYcsCaQVyflmkG8UJZeWem+5G+C9IYXwYCXFN9/jIOQvY6t5n7OLVEg
 i3M+FMtCMTv0bbUqNs9MJRo9STlMXAmICFk4uwvsucO7NETwheNHr/red
 pjXXMzxhm2MzFAhgHWAkHFo3UCOyrf1W9TcdqgeKn87anFZFzpZio6XeJ
 P7JW7grTFta9rcbLyTtzPKJMJpXV/XxaiDVRP2oBWcX2sZZC7UYBeke7m
 2/qXgcgQeKC/3Er0nBgdzjZlLkyXbTdOzmJbgujtXL8qyJB0LmUF7lJgg
 GRPlhnnt6UhNYMAt5sHgZgxRhp5TCYzyi9p93vaH2cljtLCIJ9zrqUu7z g==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Tue, 9 Feb 2021 21:21:09 +0100
Message-ID: <20210209202112.2545325-3-horatiu.vultur@microchip.com>
In-Reply-To: <20210209202112.2545325-1-horatiu.vultur@microchip.com>
References: <20210209202112.2545325-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v3 2/5] bridge: mrp: Add 'enum
	br_mrp_hw_support'
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: jiri@resnulli.us, ivecera@redhat.com, davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com, nikolay@nvidia.com, rasmus.villemoes@prevas.dk, andrew@lunn.ch, vladimir.oltean@nxp.com, claudiu.manoil@nxp.com, alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

Add the enum br_mrp_hw_support that is used by the br_mrp_switchdev
functions to allow the SW to detect the cases where HW can't implement
the functionality or when SW is used as a backup.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 net/bridge/br_private_mrp.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/bridge/br_private_mrp.h b/net/bridge/br_private_mrp.h
index 32a48e5418da..a94017f86cda 100644
--- a/net/bridge/br_private_mrp.h
+++ b/net/bridge/br_private_mrp.h
@@ -46,6 +46,20 @@ struct br_mrp {
 	struct rcu_head			rcu;
 };
 
+/* This type is returned by br_mrp_switchdev functions that allow to have a SW
+ * backup in case the HW can't implement completely the protocol.
+ * BR_MRP_NONE - means the HW can't run at all the protocol, so the SW stops
+ *               configuring the node anymore.
+ * BR_MRP_SW - the HW can help the SW to run the protocol, by redirecting MRP
+ *             frames to CPU.
+ * BR_MRP_HW - the HW can implement completely the protocol.
+ */
+enum br_mrp_hw_support {
+	BR_MRP_NONE,
+	BR_MRP_SW,
+	BR_MRP_HW,
+};
+
 /* br_mrp.c */
 int br_mrp_add(struct net_bridge *br, struct br_mrp_instance *instance);
 int br_mrp_del(struct net_bridge *br, struct br_mrp_instance *instance);
-- 
2.27.0

