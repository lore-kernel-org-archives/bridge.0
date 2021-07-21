Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+m37hXapyTt5O+cMcG7dLEszPk9ZyjZ0YENIGqE4H70=;
 b=q5uz9yBCqfQsVoGYZVLjy80OeqUclOrhAiHp/RK/yKAO9kV6LYSF4EPLzgaLTni/Xhi1mXcffzdlTb24DWALEjjvh674ITDegObbNrFI4+UWizOylPuHi60Nlo8eNVbToi67UZFaC6dFGmXlT7UGci9Eq4lanlf1HrIxJE+Sjhk=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Wed, 21 Jul 2021 19:24:02 +0300
Message-Id: <20210721162403.1988814-7-vladimir.oltean@nxp.com>
In-Reply-To: <20210721162403.1988814-1-vladimir.oltean@nxp.com>
References: <20210721162403.1988814-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH v6 net-next 6/7] net: bridge: guard the switchdev
	replay helpers against a NULL notifier block
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, DENG Qingfang <dqfext@gmail.com>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@idosch.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Marek Behun <kabel@blackhole.sk>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>

There is a desire to make the object and FDB replay helpers optional
when moving them inside the bridge driver. For example a certain driver
might not offload host MDBs and there is no case where the replay
helpers would be of immediate use to it.

So it would be nice if we could allow drivers to pass NULL pointers for
the atomic and blocking notifier blocks, and the replay helpers to do
nothing in that case.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/bridge/br_fdb.c  | 3 +++
 net/bridge/br_mdb.c  | 3 +++
 net/bridge/br_vlan.c | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 2b862cffc03a..47f190b6bfa3 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -760,6 +760,9 @@ int br_fdb_replay(const struct net_device *br_dev, const struct net_device *dev,
 	unsigned long action;
 	int err = 0;
 
+	if (!nb)
+		return 0;
+
 	if (!netif_is_bridge_master(br_dev))
 		return -EINVAL;
 
diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index d3383a47a2f2..09358c475787 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -617,6 +617,9 @@ int br_mdb_replay(struct net_device *br_dev, struct net_device *dev,
 
 	ASSERT_RTNL();
 
+	if (!nb)
+		return 0;
+
 	if (!netif_is_bridge_master(br_dev) || !netif_is_bridge_port(dev))
 		return -EINVAL;
 
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index e66b004df763..45ef07f682f1 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1856,6 +1856,9 @@ int br_vlan_replay(struct net_device *br_dev, struct net_device *dev,
 
 	ASSERT_RTNL();
 
+	if (!nb)
+		return 0;
+
 	if (!netif_is_bridge_master(br_dev))
 		return -EINVAL;
 
-- 
2.25.1

