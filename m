Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1613511840; x=1645047840;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xU9OI21zE49z1khz1tGdwEbVYbu5HKURTo6lpbHNH84=;
 b=PMl5SUvdXRQPTdCjlZ9EZFqh70Kj/CfFflWjdBbHyJtKDDxavgJBlklh
 2uF8xR78xB3C/3gAap8OBjAsfhmszWDT2gqCBGmYxYrLjFstnu8L8hBac
 sQiY4xmc3JXFa+BUTgFYXnfqIOOilMNkKXTWFn/OaMXXrrOl7bf5mTzbI
 l3Yve4VJu5dGql3BVk4XB0k6qitqKs7u4EWe0oSlup5QudbjdwdDj+ODJ
 sRMcIieEkGemN0LJ8DxZ21eYactUz/ef/VmCT5zQWeQnbUvoNnKKzuChd
 U/BuKlr76Uh4MQFnAXVY7WR9ONAaq9EJuEH+6AwFkFnkmI6JNPTvsrNNa w==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Tue, 16 Feb 2021 22:42:00 +0100
Message-ID: <20210216214205.32385-4-horatiu.vultur@microchip.com>
In-Reply-To: <20210216214205.32385-1-horatiu.vultur@microchip.com>
References: <20210216214205.32385-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v4 3/8] bridge: mrp: Add 'enum
	br_mrp_hw_support'
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org
Cc: ivecera@redhat.com, andrew@lunn.ch, alexandre.belloni@bootlin.com, f.fainelli@gmail.com, jiri@resnulli.us, rasmus.villemoes@prevas.dk, vladimir.oltean@nxp.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, claudiu.manoil@nxp.com, netdev@vger.kernel.org, nikolay@nvidia.com, roopa@nvidia.com, Horatiu Vultur <horatiu.vultur@microchip.com>, vivien.didelot@gmail.com

Add the enum br_mrp_hw_support that is used by the br_mrp_switchdev
functions to allow the SW to detect the cases where HW can't implement
the functionality or when SW is used as a backup.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 net/bridge/br_private_mrp.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/bridge/br_private_mrp.h b/net/bridge/br_private_mrp.h
index 2514954c1431..966444304c38 100644
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

