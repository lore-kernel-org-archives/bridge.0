Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1611418795; x=1642954795;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=x1dQhUol+8VUXh7OWgoJGUChQ9yRIXGyOFo+E8lOWP0=;
 b=z07oDgvmawvnAcPBmBgBt4C4idl1BNjFncXMGF4eNgr7SYRoqeCGLMd/
 SxKCejG4P+vDPzk02fQRODKTD7DiJu9sstBzJbPfMfik+TB5QV2tseFEP
 etl7UJprgb/2idPCqQyJEfHl4ejgswL0OkPgRCyLFaVgQMeO1E9wpnE8J
 NOw9nWDVmCEgQsSlAMsFAt9LhMRurNyNAQZLIAizZOVju/tXRlCFI/bNS
 upYXa1aDSrlG87GMhEIQO0cb+1T0BCJLXRxskQbsVdpLT1sdt+/aCSm23
 FH+DrBJGEuvgTw0TJBhmOg6mZXTCVlpx5DDRw0ZWxWszRrhGT9HwSOfDj g==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Sat, 23 Jan 2021 17:18:10 +0100
Message-ID: <20210123161812.1043345-3-horatiu.vultur@microchip.com>
In-Reply-To: <20210123161812.1043345-1-horatiu.vultur@microchip.com>
References: <20210123161812.1043345-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 2/4] bridge: mrp: Add 'enum
	br_mrp_hw_support'
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: jiri@resnulli.us, ivecera@redhat.com, davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com, nikolay@nvidia.com, rasmus.villemoes@prevas.dk, andrew@lunn.ch, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

Add the enum br_mrp_hw_support that is used by the br_mrp_switchdev
functions to allow the SW to detect better the cases where the HW can't
implement this or when the SW is used as a backup.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 net/bridge/br_private_mrp.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/bridge/br_private_mrp.h b/net/bridge/br_private_mrp.h
index 1883118aae55..31e666ae6955 100644
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

