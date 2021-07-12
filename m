Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ab4neqNso9HPVLudAtgiKoIKBgR3rYQRHaMn/xx3sss=;
 b=Fu+/ydRgpynQP1/3cQxL82H04Ts+mhgKAoXrhMmWU7+onSJTqpBpCiu4QLBjFmEp+Rk4/9XO5FCtZu4m5bayl7Jy/bIAuQzCo7/OgXfxMILusMWwCClG9mY1yEqe0Ug3ypgyqUTcW9QLv6qn0wxBCt/7utW9cynuqzoo3jHOOVs=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 12 Jul 2021 18:21:28 +0300
Message-Id: <20210712152142.800651-11-vladimir.oltean@nxp.com>
In-Reply-To: <20210712152142.800651-1-vladimir.oltean@nxp.com>
References: <20210712152142.800651-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH v3 net-next 10/24] net: prestera: guard against
	multiple switchdev obj replays on same bridge port
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

Prepare the prestera driver, which supports LAG offload, to deal with
bridge switchdev objects being replayed on the LAG bridge port multiple
times, once for each time a physical port beneath the LAG calls
switchdev_bridge_port_offload().

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/marvell/prestera/prestera_switchdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_switchdev.c b/drivers/net/ethernet/marvell/prestera/prestera_switchdev.c
index ae117104a23a..4be82c043991 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_switchdev.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_switchdev.c
@@ -1074,6 +1074,9 @@ static int prestera_port_obj_add(struct net_device *dev, const void *ctx,
 	struct prestera_port *port = netdev_priv(dev);
 	const struct switchdev_obj_port_vlan *vlan;
 
+	if (ctx && ctx != port)
+		return 0;
+
 	switch (obj->id) {
 	case SWITCHDEV_OBJ_ID_PORT_VLAN:
 		vlan = SWITCHDEV_OBJ_PORT_VLAN(obj);
@@ -1110,6 +1113,9 @@ static int prestera_port_obj_del(struct net_device *dev, const void *ctx,
 {
 	struct prestera_port *port = netdev_priv(dev);
 
+	if (ctx && ctx != port)
+		return 0;
+
 	switch (obj->id) {
 	case SWITCHDEV_OBJ_ID_PORT_VLAN:
 		return prestera_port_vlans_del(port, SWITCHDEV_OBJ_PORT_VLAN(obj));
-- 
2.25.1

