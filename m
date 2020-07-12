Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1594562979; x=1626098979;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=c4X1KegbRVo2rPHVO+76/AY6f9Y7hMIp5vMhUVrwmVo=;
 b=tKlSmziwLxD1OcvnL6kIyOAgPPUge10yuYfvNGnnlNYJkWGgsorhWzlD
 keT/RY438uqPPg6tPj2tTkxg5xCjJoKmYY2zuKlyJYEctJ4nqO7SWWYBu
 i+T2TFPWhpwU6EFNTg8OYN7BP1UzqR064cB+u9SFItCQultyX+IwhI2Ch
 4zvD0zKpzCfky5/BEg0vyXUUDencMNmqEWuq34LHLcEdmO8kaTEdLdcg1
 PHcTgiV+YWhc9bchxKguEZRN6LuJnCnrmI94K6TDzHuVCvSBac9db3Mpz
 g+ua4D/Me8dBMBwsnuU5nEunl8GDauS2sKMpvJQTyDhiFlYFng8234tR2 g==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Sun, 12 Jul 2020 16:05:50 +0200
Message-ID: <20200712140556.1758725-7-horatiu.vultur@microchip.com>
In-Reply-To: <20200712140556.1758725-1-horatiu.vultur@microchip.com>
References: <20200712140556.1758725-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v3 06/12] bridge: mrp: Add
	br_mrp_in_port_open function
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

This function notifies the userspace when the node lost the continuity
of MRP_InTest frames.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 net/bridge/br_mrp_netlink.c | 22 ++++++++++++++++++++++
 net/bridge/br_private_mrp.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/net/bridge/br_mrp_netlink.c b/net/bridge/br_mrp_netlink.c
index acce300c0cc29..4bf7aaeb29152 100644
--- a/net/bridge/br_mrp_netlink.c
+++ b/net/bridge/br_mrp_netlink.c
@@ -389,3 +389,25 @@ int br_mrp_ring_port_open(struct net_device *dev, u8 loc)
 out:
 	return err;
 }
+
+int br_mrp_in_port_open(struct net_device *dev, u8 loc)
+{
+	struct net_bridge_port *p;
+	int err = 0;
+
+	p = br_port_get_rcu(dev);
+	if (!p) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	if (loc)
+		p->flags |= BR_MRP_LOST_IN_CONT;
+	else
+		p->flags &= ~BR_MRP_LOST_IN_CONT;
+
+	br_ifinfo_notify(RTM_NEWLINK, NULL, p);
+
+out:
+	return err;
+}
diff --git a/net/bridge/br_private_mrp.h b/net/bridge/br_private_mrp.h
index e93c8f9d4df58..23da2f956ad0e 100644
--- a/net/bridge/br_private_mrp.h
+++ b/net/bridge/br_private_mrp.h
@@ -75,5 +75,6 @@ int br_mrp_port_switchdev_set_role(struct net_bridge_port *p,
 
 /* br_mrp_netlink.c  */
 int br_mrp_ring_port_open(struct net_device *dev, u8 loc);
+int br_mrp_in_port_open(struct net_device *dev, u8 loc);
 
 #endif /* _BR_PRIVATE_MRP_H */
-- 
2.27.0

