Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LvWwr5ZxZfUuNRDtPZWKbgWda9RNbr0e0Q17P0MKR4=;
 b=R3z25tFj3lLcZM3g2tfHfxh94YnaXxfTTozJHFNE2XwXH0E/dnmQHV4ZIktlqih5T6Mvyry3WCZ70/0zddPOomytjM4JGvtCcyzKs6TBX+WD18q5wKiLduUVwFhmpRw3dJrAP8EkuX0Ytd3Q3JvhwESyQSlItsZlRqdHUk86iqU=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Sun, 13 Dec 2020 04:40:18 +0200
Message-Id: <20201213024018.772586-7-vladimir.oltean@nxp.com>
In-Reply-To: <20201213024018.772586-1-vladimir.oltean@nxp.com>
References: <20201213024018.772586-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH v2 net-next 6/6] net: dsa: ocelot: request DSA to
	fix up lack of address learning on CPU port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>, Vivien Didelot <vivien.didelot@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, "David S. Miller" <davem@davemloft.net>
Cc: Jiri Pirko <jiri@resnulli.us>, Alexandra Winter <wintera@linux.ibm.com>, Ido Schimmel <idosch@idosch.org>, Russell King - ARM Linux admin <linux@armlinux.org.uk>, Marek Behun <marek.behun@nic.cz>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Tobias Waldekranz <tobias@waldekranz.com>

Given the following setup:

ip link add br0 type bridge
ip link set eno0 master br0
ip link set swp0 master br0
ip link set swp1 master br0
ip link set swp2 master br0
ip link set swp3 master br0

Currently, packets received on a DSA slave interface (such as swp0)
which should be routed by the software bridge towards a non-switch port
(such as eno0) are also flooded towards the other switch ports (swp1,
swp2, swp3) because the destination is unknown to the hardware switch.

This patch addresses the issue by monitoring the addresses learnt by the
software bridge on eno0, and adding/deleting them as static FDB entries
on the CPU port accordingly.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v2:
Patch is new.

 drivers/net/dsa/ocelot/felix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index 7dc230677b78..bf48f2e86bcf 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -629,6 +629,7 @@ static int felix_setup(struct dsa_switch *ds)
 
 	ds->mtu_enforcement_ingress = true;
 	ds->configure_vlan_while_not_filtering = true;
+	ds->learning_broken_on_cpu_port = true;
 
 	return 0;
 }
-- 
2.25.1

