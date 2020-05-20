Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1589973080; x=1621509080;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=C39MMHsI3O/BWeqgZ3MtgggX0ZxcDyUus7tnUs3PLL8=;
 b=hCPDQAXkE2XLeCCsDySNraZzDboJLNWRMw3pNqYvHp5W/el2l8EojwKw
 BMfZl1hG4godSTX70Yi3JZ2ZLhbvXXXVedyLw8gm22ANIbfdR2iA09bUG
 tKCmtuus62/+n/kwkjU4dvSTt2mIZeWFBgAHWBpM74mHLGCn/2jJShWc6
 TXEBHL4uxMjMlUw1aRb1o/Xo/eRiRWpCNH430/vzipJFaDVe/OdHTmz8+
 abPId47ZOhzQQktZH2Qo5FvzI14iIUePvPtowGnd2e/7MX/nYD5p2LAIZ
 63zlPnnA06RtM51OiAIzQMy8vRgyriEIwZNUh8bMbYBK8eZk8164crx3r Q==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Wed, 20 May 2020 13:09:21 +0000
Message-ID: <20200520130923.3196432-2-horatiu.vultur@microchip.com>
In-Reply-To: <20200520130923.3196432-1-horatiu.vultur@microchip.com>
References: <20200520130923.3196432-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH 1/3] bridge: mrp: Add br_mrp_unique_ifindex function
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: jiri@resnulli.us, ivecera@redhat.com, davem@davemloft.net, kuba@kernel.org, roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com, andrew@lunn.ch, UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

It is not allow to have the same net bridge port part of multiple MRP
rings. Therefore add a check if the port is used already in a different
MRP. In that case return failure.

Fixes: 9a9f26e8f7ea ("bridge: mrp: Connect MRP API with the switchdev API")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 net/bridge/br_mrp.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
index d7bc09de4c139..a5a3fa59c078a 100644
--- a/net/bridge/br_mrp.c
+++ b/net/bridge/br_mrp.c
@@ -37,6 +37,32 @@ static struct br_mrp *br_mrp_find_id(struct net_bridge *br, u32 ring_id)
 	return res;
 }
 
+static bool br_mrp_unique_ifindex(struct net_bridge *br, u32 ifindex)
+{
+	struct br_mrp *mrp;
+	bool res = true;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(mrp, &br->mrp_list, list,
+				lockdep_rtnl_is_held()) {
+		struct net_bridge_port *p;
+
+		p = rcu_dereference(mrp->p_port);
+		if (p && p->dev->ifindex == ifindex) {
+			res = false;
+			break;
+		}
+
+		p = rcu_dereference(mrp->s_port);
+		if (p && p->dev->ifindex == ifindex) {
+			res = false;
+			break;
+		}
+	}
+	rcu_read_unlock();
+	return res;
+}
+
 static struct br_mrp *br_mrp_find_port(struct net_bridge *br,
 				       struct net_bridge_port *p)
 {
@@ -255,6 +281,11 @@ int br_mrp_add(struct net_bridge *br, struct br_mrp_instance *instance)
 	    !br_mrp_get_port(br, instance->s_ifindex))
 		return -EINVAL;
 
+	/* It is not possible to have the same port part of multiple rings */
+	if (!br_mrp_unique_ifindex(br, instance->p_ifindex) ||
+	    !br_mrp_unique_ifindex(br, instance->s_ifindex))
+		return -EINVAL;
+
 	mrp = kzalloc(sizeof(*mrp), GFP_KERNEL);
 	if (!mrp)
 		return -ENOMEM;
-- 
2.26.2

