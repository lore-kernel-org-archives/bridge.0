Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVVFIz/Q/pDqurutfBde9vIxwGAg5CK6+yUwHAHk+P0=;
 b=oDev3WMBqte72/nvyIh9+CP9rAh4qddkxDvSFd9exhM3MpAIYjpwfeRr8V+WyJdvk1vNqX5m3rvukj/5GDRxVV3//dt0j97UzsYWNrpTi9KcMjN4X7MWQCwdoBs2rq5qFaaOisUkPare1+DcRcMdfBX3biCNulTSHC8BNBM0XpU=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 12 Jul 2021 18:21:23 +0300
Message-Id: <20210712152142.800651-6-vladimir.oltean@nxp.com>
In-Reply-To: <20210712152142.800651-1-vladimir.oltean@nxp.com>
References: <20210712152142.800651-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH v3 net-next 05/24] net: prestera: if the LAG
	that we're joining is under a bridge, join it
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@idosch.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>

Some switchdev drivers, like mlxsw, refuse to join a LAG that already is
under a bridge, while others, like DSA since commit 185c9a760a61 ("net:
dsa: call dsa_port_bridge_join when joining a LAG that is already in a
bridge"), prefer to handle that case and join the bridge that is an
upper of the LAG, if that exists.

The prestera driver does none of those, so let's replicate what DSA
does.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/marvell/prestera/prestera_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_main.c b/drivers/net/ethernet/marvell/prestera/prestera_main.c
index 226f4ff29f6e..979214ce1952 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_main.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_main.c
@@ -567,6 +567,14 @@ static int prestera_lag_port_add(struct prestera_port *port,
 	lag->member_count++;
 	port->lag = lag;
 
+	if (netif_is_bridge_port(lag_dev)) {
+		struct net_device *br_dev;
+
+		br_dev = netdev_master_upper_dev_get(lag_dev);
+
+		return prestera_bridge_port_join(br_dev, port);
+	}
+
 	return 0;
 }
 
-- 
2.25.1

