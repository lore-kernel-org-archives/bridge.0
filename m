Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=e9XiWgYMfVUBSKTt2/GH7FXs22RSflWWzqO+GytFND8=;
 b=hrNsNNr92ti6PuUoJlwmbCFI/0za7J7d0/Mr1fl7pIVF/V67yqcNAU7YeBI1zSE4BR
 vSgZbG8ewwmWuad2Q2X9OSAP4c84PibFdy8bnfSPBkaQ9FmMBRHaN3w/O9cdp6mm9EV8
 peKBNbGwlC6Vf40m7+O7ezFrNYLrfBDQGu+ob/LKU8JvBMEyGf3HXYSNIAPqbIBS7vif
 3Eri2/HMq/LZ13WJHBIo1J5K9kcfOKCIJav6wJ+e3tptTsOgagQ5kZPg9d+zYB7WFel+
 pb0WnbEwHIyu8EbFSKaQgXu1bBNnxT99UcGWQbSWSZ1xu9g3g6ZWAW8/5kh+P6vKWZ9M
 uU4g==
From: Vladimir Oltean <olteanv@gmail.com>
Date: Mon,  8 Feb 2021 01:21:35 +0200
Message-Id: <20210207232141.2142678-4-olteanv@gmail.com>
In-Reply-To: <20210207232141.2142678-1-olteanv@gmail.com>
References: <20210207232141.2142678-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 3/9] net: dsa: stop setting initial and
	final brport flags
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

