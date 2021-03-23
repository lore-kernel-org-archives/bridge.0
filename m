Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1616488541; x=1648024541;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eP8Cr4YL2a0w4yi+/hKrPPiwiCM67cN8kXpAO4EXfHk=;
 b=QnV544ynisfdBu1mZsQ3ws27VkyJj7Xmeo/foOawyjLpqcAoXkqTpQ8q
 UNeyXuTZQInTinNDhOvNnaasXP3O9wu5OxTS4yCFih+CfwwhVEDLDB8BP
 1b8VURN4jGXWD6mfUoMi8HpCWdVYov2UXESpE5p3LnXz30/Qbwd6DZ+YP
 a+RNRfYKWOM89RXcqKIsUAR2wmSkUODU1JvS74Wq1JJBQXe1zQSNVb+wj
 svWJIwKqr1IAk/QHkJ2VYnVSrjpLeNi3hcpjIEkstsHrwfrSpvTi3KpIc
 a3BDvPhJNiIWgL1tNWYuLy2t2FmCE7oQicY1P8CVGGgEk9MjfYRRgqA0J w==;
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Tue, 23 Mar 2021 09:33:47 +0100
Message-ID: <20210323083347.1474883-3-horatiu.vultur@microchip.com>
In-Reply-To: <20210323083347.1474883-1-horatiu.vultur@microchip.com>
References: <20210323083347.1474883-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 2/2] net: ocelot: Simplify MRP deletion
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

Now that the driver will always be notified that the role is deleted
before the ring is deleted, then we don't need to duplicate the logic of
cleaning the resources also in the delete function.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/ethernet/mscc/ocelot_mrp.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_mrp.c b/drivers/net/ethernet/mscc/ocelot_mrp.c
index c3cbcaf64bb2..08b481a93460 100644
--- a/drivers/net/ethernet/mscc/ocelot_mrp.c
+++ b/drivers/net/ethernet/mscc/ocelot_mrp.c
@@ -154,7 +154,6 @@ int ocelot_mrp_del(struct ocelot *ocelot, int port,
 		   const struct switchdev_obj_mrp *mrp)
 {
 	struct ocelot_port *ocelot_port = ocelot->ports[port];
-	int i;
 
 	if (!ocelot_port)
 		return -EOPNOTSUPP;
@@ -162,23 +161,8 @@ int ocelot_mrp_del(struct ocelot *ocelot, int port,
 	if (ocelot_port->mrp_ring_id != mrp->ring_id)
 		return 0;
 
-	ocelot_mrp_del_vcap(ocelot, port);
-	ocelot_mrp_del_vcap(ocelot, port + ocelot->num_phys_ports);
-
 	ocelot_port->mrp_ring_id = 0;
 
-	for (i = 0; i < ocelot->num_phys_ports; ++i) {
-		ocelot_port = ocelot->ports[i];
-
-		if (!ocelot_port)
-			continue;
-
-		if (ocelot_port->mrp_ring_id != 0)
-			goto out;
-	}
-
-	ocelot_mrp_del_mac(ocelot, ocelot->ports[port]);
-out:
 	return 0;
 }
 EXPORT_SYMBOL(ocelot_mrp_del);
-- 
2.30.1

