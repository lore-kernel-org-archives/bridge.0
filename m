Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9apr4CU9ROkXpvdUS3JqoM5muZRLGcdC/mdCAjUO/2I=;
 b=qq/gRN94YuTLfdmLPHGrMIymx/OC2yPfwrCmUNWPUscQWFrnpX9Qp5prLEZZ5Smiqo
 +v48lKSnWO0bE2Yv4ibxQkAwGA4SuHUXkq/uoDWJyALgI/GCIuNFyEafXA0mWQbKTGsv
 AzVIlmgvxYH2bnlddkYkKKJss1qZQHIrqiaPtp0LoxhXt+cdWFUh4zl64DGC+L5Be7ym
 jWRZmZlxilq64BzvYo8meIs3IyHBvOzUAZ5xf3Sjt1pEAH++M6p4svBVQUhJN/OkeQ+Z
 LJDTJZ7Q+M2FTnRF/S5qeT/x4FQFCAT3v0OSc28sNm2WvN4suT9W58TDscjR/wDX0RFu
 j+Ag==
From: Vladimir Oltean <olteanv@gmail.com>
Date: Fri, 12 Feb 2021 17:15:57 +0200
Message-Id: <20210212151600.3357121-8-olteanv@gmail.com>
In-Reply-To: <20210212151600.3357121-1-olteanv@gmail.com>
References: <20210212151600.3357121-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v5 net-next 07/10] net: dsa: felix: restore
	multicast flood to CPU when NPI tagger reinitializes
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Vignesh Raghavendra <vigneshr@ti.com>, Vadym Kochan <vkochan@marvell.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Taras Chornyi <tchornyi@marvell.com>, Ido Schimmel <idosch@idosch.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, linux-omap@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>

From: Vladimir Oltean <vladimir.oltean@nxp.com>

ocelot_init sets up PGID_MC to include the CPU port module, and that is
fine, but the ocelot-8021q tagger removes the CPU port module from the
unknown multicast replicator. So after a transition from the default
ocelot tagger towards ocelot-8021q and then again towards ocelot,
multicast flooding towards the CPU port module will be disabled.

Fixes: e21268efbe26 ("net: dsa: felix: perform switch setup for tag_8021q")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v5:
Patch is new.

 drivers/net/dsa/ocelot/felix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index 386468e66c41..ae11d3f030ac 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -411,6 +411,7 @@ static int felix_setup_tag_npi(struct dsa_switch *ds, int cpu)
 	 */
 	cpu_flood = ANA_PGID_PGID_PGID(BIT(ocelot->num_phys_ports));
 	ocelot_rmw_rix(ocelot, cpu_flood, cpu_flood, ANA_PGID_PGID, PGID_UC);
+	ocelot_rmw_rix(ocelot, cpu_flood, cpu_flood, ANA_PGID_PGID, PGID_MC);
 
 	return 0;
 }
-- 
2.25.1

