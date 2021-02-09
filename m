Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AkDQjrnrduVZMAhweD9hW9j4GkN22HKFVzGcpRaV+qE=;
 b=e2T4P1lz4I17kuV+wPzF1odR3ie/Bvx7chGzyBa5nLxDS8zpjyOYw8E+gekxi6Njg9
 ulUBBz8A8aEw+NvwMpr0MF+G1OJwGToo92OHEW3NLxI0xqx1P7AlcP+NzOYNcxadP5AS
 WK4ofM/FGyYPIoMFl3mP0MWvBuXplNVio5f69uaUqTR5lFdls58Nv3Hq+Rte3izKImPA
 YCod4c7oT1Z/WDDmZAXNgyRjPW4RHyNLszvIPSVzKPBsTwQjxwKUEID5lzKBN7yCcaIp
 jouIKljFoOWvTyqSUDR8Brx2jsMHaYw06yglaGx/QJHduZF6+x0auRXnfR+gNzyUv8Vt
 FobQ==
From: Vladimir Oltean <olteanv@gmail.com>
Date: Tue,  9 Feb 2021 17:19:30 +0200
Message-Id: <20210209151936.97382-6-olteanv@gmail.com>
In-Reply-To: <20210209151936.97382-1-olteanv@gmail.com>
References: <20210209151936.97382-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v2 net-next 05/11] net: dsa: stop setting initial
	and final brport flags
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

With the bridge driver doing that for us now, we can simplify our
mid-layer logic a little bit, which would have otherwise needed some
tuning for the disabling of address learning that is necessary in
standalone mode.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v2:
None.

 net/dsa/port.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/net/dsa/port.c b/net/dsa/port.c
index 5e079a61528e..aa1cbba7f89f 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -132,11 +132,6 @@ int dsa_port_bridge_join(struct dsa_port *dp, struct net_device *br)
 	};
 	int err;
 
-	/* Set the flooding mode before joining the port in the switch */
-	err = dsa_port_bridge_flags(dp, BR_FLOOD | BR_MCAST_FLOOD);
-	if (err)
-		return err;
-
 	/* Here the interface is already bridged. Reflect the current
 	 * configuration so that drivers can program their chips accordingly.
 	 */
@@ -145,10 +140,8 @@ int dsa_port_bridge_join(struct dsa_port *dp, struct net_device *br)
 	err = dsa_broadcast(DSA_NOTIFIER_BRIDGE_JOIN, &info);
 
 	/* The bridging is rolled back on error */
-	if (err) {
-		dsa_port_bridge_flags(dp, 0);
+	if (err)
 		dp->bridge_dev = NULL;
-	}
 
 	return err;
 }
@@ -172,9 +165,6 @@ void dsa_port_bridge_leave(struct dsa_port *dp, struct net_device *br)
 	if (err)
 		pr_err("DSA: failed to notify DSA_NOTIFIER_BRIDGE_LEAVE\n");
 
-	/* Port is leaving the bridge, disable flooding */
-	dsa_port_bridge_flags(dp, 0);
-
 	/* Port left the bridge, put in BR_STATE_DISABLED by the bridge layer,
 	 * so allow it to be in BR_STATE_FORWARDING to be kept functional
 	 */
-- 
2.25.1

