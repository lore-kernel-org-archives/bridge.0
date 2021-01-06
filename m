Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EJz2f0BPU/V/WA7rRceP314TuPjibKG/K1RbisBajTo=;
 b=rQffNnMRM7oY9+l+SpdWettB2i1OKHz8Lz3g09zgPf3ec3ndhAnOqlOVCtp5BKqPAM
 GM31b+hc3zuVHBbAcpLec7UZYKcM3na7OcLpXOWW7Ra6EihpvYf2h2CwjUyaPkQRr4AW
 yNSOkgVn0HHWvWLHPGek3GC2pYiNMpP7dOPvo1nXCjHlKomgd1Znxc7FDR/AJOLuzZvp
 cvzV9WijdJ9epII9ZtODKpZytTr1MFouAn4P5mbxZ/MPaeZ1e3KkBgphqyTQpIgyDnR4
 1TGGWGRYZ+pj2w9/lL/ezmKT3iKMFaldyoxCcjtzkOJxVHrKmmlmCriikJbypo4rEfD4
 OKhg==
From: Vladimir Oltean <olteanv@gmail.com>
Date: Wed,  6 Jan 2021 11:51:36 +0200
Message-Id: <20210106095136.224739-8-olteanv@gmail.com>
In-Reply-To: <20210106095136.224739-1-olteanv@gmail.com>
References: <20210106095136.224739-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v4 net-next 7/7] net: dsa: ocelot: request DSA to
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
Cc: Jiri Pirko <jiri@resnulli.us>, Alexandra Winter <wintera@linux.ibm.com>, Ido Schimmel <idosch@idosch.org>, Russell King - ARM Linux admin <linux@armlinux.org.uk>, Marek Behun <marek.behun@nic.cz>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, UNGLinuxDriver@microchip.com, Tobias Waldekranz <tobias@waldekranz.com>

From: Vladimir Oltean <vladimir.oltean@nxp.com>

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
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
Changes in v4:
None.

Changes in v3:
s/learning_broken/assisted_learning/

Changes in v2:
Patch is new.

 drivers/net/dsa/ocelot/felix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index 7dc230677b78..90c3c76f21b2 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -629,6 +629,7 @@ static int felix_setup(struct dsa_switch *ds)
 
 	ds->mtu_enforcement_ingress = true;
 	ds->configure_vlan_while_not_filtering = true;
+	ds->assisted_learning_on_cpu_port = true;
 
 	return 0;
 }
-- 
2.25.1

