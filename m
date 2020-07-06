Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1594027258; x=1625563258;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KXvHOUThZBG1JwN3D0CPyXX+5vP02M2Oe4vY5byDp8I=;
 b=CL3oFp5cwEY0Xd3MTg8fd0sK3SNNGpHGRPXqY0iyKS+XYTBfVTTEtphk
 isyvWkBgYpHFfyxglHd4cf8idsuU8/6+2N7jto6YNlh6QqzfkM3n+mr0L
 xNEKLpqewtN/hgNEoPrXOsnCB3QL6PaDtmi61eVAVhUTfRJYO3BtgSWWN
 SsfjlExxx+FGAOLTEzVzsZncMam33e93Ds5hgL8Dmd2I0vsXVtBfL92zn
 vwaclfklvjwzxwwjyiAAwBCpG09YbJ+e4Pa+VisrKpE09KmKAOtOe9g/6
 sDxrknKWnAQ5O+cnUkJkSg+mgQ0wj+l+FkGmc4tC3trEXdytZh2kvZxvE g==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Mon, 6 Jul 2020 11:18:35 +0200
Message-ID: <20200706091842.3324565-6-horatiu.vultur@microchip.com>
In-Reply-To: <20200706091842.3324565-1-horatiu.vultur@microchip.com>
References: <20200706091842.3324565-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 05/12] bridge: mrp: Rename
	br_mrp_port_open to br_mrp_ring_port_open
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

This patch renames the function br_mrp_port_open to
br_mrp_ring_port_open. In this way is more clear that a ring port lost
the continuity because there will be also a br_mrp_in_port_open.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 net/bridge/br_mrp.c         | 6 +++---
 net/bridge/br_mrp_netlink.c | 2 +-
 net/bridge/br_private_mrp.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
index 779e1eb754430..d4176f8956d05 100644
--- a/net/bridge/br_mrp.c
+++ b/net/bridge/br_mrp.c
@@ -213,7 +213,7 @@ static void br_mrp_test_work_expired(struct work_struct *work)
 		}
 
 		if (notify_open && !mrp->ring_role_offloaded)
-			br_mrp_port_open(p->dev, true);
+			br_mrp_ring_port_open(p->dev, true);
 	}
 
 	p = rcu_dereference(mrp->s_port);
@@ -229,7 +229,7 @@ static void br_mrp_test_work_expired(struct work_struct *work)
 		}
 
 		if (notify_open && !mrp->ring_role_offloaded)
-			br_mrp_port_open(p->dev, true);
+			br_mrp_ring_port_open(p->dev, true);
 	}
 
 out:
@@ -537,7 +537,7 @@ static void br_mrp_mrm_process(struct br_mrp *mrp, struct net_bridge_port *port,
 	 * not closed
 	 */
 	if (mrp->ring_state != BR_MRP_RING_STATE_CLOSED)
-		br_mrp_port_open(port->dev, false);
+		br_mrp_ring_port_open(port->dev, false);
 }
 
 /* Determin if the test hdr has a better priority than the node */
diff --git a/net/bridge/br_mrp_netlink.c b/net/bridge/br_mrp_netlink.c
index c4f5c356811f3..acce300c0cc29 100644
--- a/net/bridge/br_mrp_netlink.c
+++ b/net/bridge/br_mrp_netlink.c
@@ -368,7 +368,7 @@ int br_mrp_fill_info(struct sk_buff *skb, struct net_bridge *br)
 	return -EMSGSIZE;
 }
 
-int br_mrp_port_open(struct net_device *dev, u8 loc)
+int br_mrp_ring_port_open(struct net_device *dev, u8 loc)
 {
 	struct net_bridge_port *p;
 	int err = 0;
diff --git a/net/bridge/br_private_mrp.h b/net/bridge/br_private_mrp.h
index 5e612123c5605..d5957f7e687ff 100644
--- a/net/bridge/br_private_mrp.h
+++ b/net/bridge/br_private_mrp.h
@@ -74,6 +74,6 @@ int br_mrp_port_switchdev_set_role(struct net_bridge_port *p,
 				   enum br_mrp_port_role_type role);
 
 /* br_mrp_netlink.c  */
-int br_mrp_port_open(struct net_device *dev, u8 loc);
+int br_mrp_ring_port_open(struct net_device *dev, u8 loc);
 
 #endif /* _BR_PRIVATE_MRP_H */
-- 
2.27.0

