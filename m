Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=x63lLl9f+6cQ+FEOwh37vVD+gThLxL62LXc3QDA9ZeM=;
 b=KfCAY4lP33QDHT0k9N7q51JKgczm/uW6gJiBXvMUbxSn8ZP9vfh6DjeQFnIBTD4+8o
 LWIRUo8r9AdwNJF71j6r6ai21d1yC8WKXI2youqPwQ8UoLw9LeY2pDKQ4l974K/Xvmwn
 CBNaqO29UAxIOn7x1amAmU9BjKwQjJIBlp+ViCImGg53WCrkxFUrrxnVryHn7WMTpBlF
 6xZvyoUYLmGZJ/tC0xCdfH/wI20z/OrObo3qGI3dMVwTs5Wz3eWW2XEVCYmRjGWZs04N
 BD2vh2WiQUl5yjcAy/khsRgdykHfrZnvwByluiZIce8nlap7ZTBOERGQXVqN8G5uX27J
 ES1w==
From: Vladimir Oltean <olteanv@gmail.com>
Date: Fri, 12 Feb 2021 03:05:29 +0200
Message-Id: <20210212010531.2722925-8-olteanv@gmail.com>
In-Reply-To: <20210212010531.2722925-1-olteanv@gmail.com>
References: <20210212010531.2722925-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v4 net-next 7/9] net: mscc: ocelot: use separate
	flooding PGID for broadcast
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Vadym Kochan <vkochan@marvell.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Taras Chornyi <tchornyi@marvell.com>, Ido Schimmel <idosch@idosch.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, linux-omap@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>

From: Vladimir Oltean <vladimir.oltean@nxp.com>

In preparation of offloading the bridge port flags which have
independent settings for unknown multicast and for broadcast, we should
also start reserving one destination Port Group ID for the flooding of
broadcast packets, to allow configuring it individually.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v4:
None.

Changes in v3:
None.

Changes in v2:
None.

 drivers/net/ethernet/mscc/ocelot.c | 13 ++++++++-----
 include/soc/mscc/ocelot.h          | 15 ++++++++-------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 1654a6e22a7d..1a31598e2ae6 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -1716,7 +1716,7 @@ int ocelot_init(struct ocelot *ocelot)
 	/* Setup flooding PGIDs */
 	for (i = 0; i < ocelot->num_flooding_pgids; i++)
 		ocelot_write_rix(ocelot, ANA_FLOODING_FLD_MULTICAST(PGID_MC) |
-				 ANA_FLOODING_FLD_BROADCAST(PGID_MC) |
+				 ANA_FLOODING_FLD_BROADCAST(PGID_BC) |
 				 ANA_FLOODING_FLD_UNICAST(PGID_UC),
 				 ANA_FLOODING, i);
 	ocelot_write(ocelot, ANA_FLOODING_IPMC_FLD_MC6_DATA(PGID_MCIPV6) |
@@ -1737,15 +1737,18 @@ int ocelot_init(struct ocelot *ocelot)
 		ocelot_write_rix(ocelot, 0, ANA_PGID_PGID, PGID_SRC + port);
 	}
 
-	/* Allow broadcast MAC frames. */
 	for_each_nonreserved_multicast_dest_pgid(ocelot, i) {
 		u32 val = ANA_PGID_PGID_PGID(GENMASK(ocelot->num_phys_ports - 1, 0));
 
 		ocelot_write_rix(ocelot, val, ANA_PGID_PGID, i);
 	}
-	ocelot_write_rix(ocelot,
-			 ANA_PGID_PGID_PGID(GENMASK(ocelot->num_phys_ports, 0)),
-			 ANA_PGID_PGID, PGID_MC);
+	/* Allow broadcast and unknown L2 multicast to the CPU. */
+	ocelot_rmw_rix(ocelot, ANA_PGID_PGID_PGID(BIT(ocelot->num_phys_ports)),
+		       ANA_PGID_PGID_PGID(BIT(ocelot->num_phys_ports)),
+		       ANA_PGID_PGID, PGID_MC);
+	ocelot_rmw_rix(ocelot, ANA_PGID_PGID_PGID(BIT(ocelot->num_phys_ports)),
+		       ANA_PGID_PGID_PGID(BIT(ocelot->num_phys_ports)),
+		       ANA_PGID_PGID, PGID_BC);
 	ocelot_write_rix(ocelot, 0, ANA_PGID_PGID, PGID_MCIPV4);
 	ocelot_write_rix(ocelot, 0, ANA_PGID_PGID, PGID_MCIPV6);
 
diff --git a/include/soc/mscc/ocelot.h b/include/soc/mscc/ocelot.h
index bfce3df61bfd..9acbef1416f1 100644
--- a/include/soc/mscc/ocelot.h
+++ b/include/soc/mscc/ocelot.h
@@ -54,16 +54,17 @@
  * PGID_CPU: used for whitelisting certain MAC addresses, such as the addresses
  *           of the switch port net devices, towards the CPU port module.
  * PGID_UC: the flooding destinations for unknown unicast traffic.
- * PGID_MC: the flooding destinations for broadcast and non-IP multicast
- *          traffic.
+ * PGID_MC: the flooding destinations for non-IP multicast traffic.
  * PGID_MCIPV4: the flooding destinations for IPv4 multicast traffic.
  * PGID_MCIPV6: the flooding destinations for IPv6 multicast traffic.
+ * PGID_BC: the flooding destinations for broadcast traffic.
  */
-#define PGID_CPU			59
-#define PGID_UC				60
-#define PGID_MC				61
-#define PGID_MCIPV4			62
-#define PGID_MCIPV6			63
+#define PGID_CPU			58
+#define PGID_UC				59
+#define PGID_MC				60
+#define PGID_MCIPV4			61
+#define PGID_MCIPV6			62
+#define PGID_BC				63
 
 #define for_each_unicast_dest_pgid(ocelot, pgid)		\
 	for ((pgid) = 0;					\
-- 
2.25.1

