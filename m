Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1616488538; x=1648024538;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9lxgTCKRb/dXejM+dtq7XdfnshCfyP/EiqkevaxcJeg=;
 b=la+h9dmkbJRiJYttmM9x2qiqRZqOKWfolWah80JYH8s/3MJz5wPD06Iy
 i6oC0KKJbDL9aPJcfR7seU540GB3gAP0R5ZvT85pAAghKZehS+BwyAqut
 bU1PNPuwLLOX6KBa2W8MKQN/B5vLguAyd6P1G70wML3qEsLBqWvsy3bNV
 oJwkECr1YB5VOFNuGlisnZxwaVU7dvwvT4Js5Mx3/YqRclNszIUQTkolw
 dn3pSGRT/CScV7X9XwYK3hS+SZETL9PCbNrHWDBUYd9D/MlTdacQeqpq8
 jw3uZw+6lV3ZV3lVA9eAE0tMTIj2V7iuKYqJ5LOeeI7tPKujRUybXAW3C w==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Tue, 23 Mar 2021 09:33:46 +0100
Message-ID: <20210323083347.1474883-2-horatiu.vultur@microchip.com>
In-Reply-To: <20210323083347.1474883-1-horatiu.vultur@microchip.com>
References: <20210323083347.1474883-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 1/2] bridge: mrp: Disable roles before
	deleting the MRP instance
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com, nikolay@nvidia.com, vladimir.oltean@nxp.com, claudiu.manoil@nxp.com, alexandre.belloni@bootlin.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Horatiu Vultur <horatiu.vultur@microchip.com>, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com

When an MRP instance was created, the driver was notified that the
instance is created and then in a different callback about role of the
instance. But when the instance was deleted the driver was notified only
that the MRP instance is deleted and not also that the role is disabled.

This patch make sure that the driver is notified that the role is
changed to disabled before the MRP instance is deleted to have similar
callbacks with the creating of the instance. In this way it would
simplify the logic in the drivers.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 net/bridge/br_mrp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
index 12487f6fe9b4..cd2b1e424e54 100644
--- a/net/bridge/br_mrp.c
+++ b/net/bridge/br_mrp.c
@@ -411,6 +411,13 @@ static void br_mrp_del_impl(struct net_bridge *br, struct br_mrp *mrp)
 	cancel_delayed_work_sync(&mrp->in_test_work);
 	br_mrp_switchdev_send_in_test(br, mrp, 0, 0, 0);
 
+	/* Disable the roles */
+	br_mrp_switchdev_set_ring_role(br, mrp, BR_MRP_RING_ROLE_DISABLED);
+	p = rtnl_dereference(mrp->i_port);
+	if (p)
+		br_mrp_switchdev_set_in_role(br, mrp, mrp->in_id, mrp->ring_id,
+					     BR_MRP_IN_ROLE_DISABLED);
+
 	br_mrp_switchdev_del(br, mrp);
 
 	/* Reset the ports */
-- 
2.30.1

