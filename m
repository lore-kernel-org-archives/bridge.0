Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjIfc9bVDqxAkQp9AJV0erU3JosOeU8GAFNxw3Wmv8U=;
 b=QI2ZUxtKlQJc/unHeIg8qibj3msuG831pc5liMUiqxfPmFpNcyV1R9HICkDvF/JC/Ajwg4xGi2s6BAGQ9cTpsjMGo5nOe2DgdEPmUMCXGAdeio9Yi0AA/yzYQ/tXwZUgLaZGUjnqTVQiE43ZH8i7Zu1QV4qH+4ImHWiakbvLQ4g=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Sun, 13 Dec 2020 04:40:16 +0200
Message-Id: <20201213024018.772586-5-vladimir.oltean@nxp.com>
In-Reply-To: <20201213024018.772586-1-vladimir.oltean@nxp.com>
References: <20201213024018.772586-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH v2 net-next 4/6] net: dsa: exit early in
	dsa_slave_switchdev_event if we can't program the FDB
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

Right now, the following would happen for a switch driver that does not
implement .port_fdb_add or .port_fdb_del.

dsa_slave_switchdev_event returns NOTIFY_OK and schedules:
-> dsa_slave_switchdev_event_work
   -> dsa_port_fdb_add
      -> dsa_port_notify(DSA_NOTIFIER_FDB_ADD)
         -> dsa_switch_fdb_add
            -> if (!ds->ops->port_fdb_add) return -EOPNOTSUPP;
   -> an error is printed with dev_dbg, and
      dsa_fdb_offload_notify(switchdev_work) is not called.

We can avoid scheduling the worker for nothing and say NOTIFY_OK.
Because we don't call dsa_fdb_offload_notify, the static FDB entry will
remain just in the software bridge.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v2:
Patch is new.

 net/dsa/slave.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 99907e76770b..53d9d2ea9369 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -2129,6 +2129,9 @@ static int dsa_slave_switchdev_event(struct notifier_block *unused,
 
 		dp = dsa_slave_to_port(dev);
 
+		if (!dp->ds->ops->port_fdb_add || !dp->ds->ops->port_fdb_del)
+			return NOTIFY_DONE;
+
 		switchdev_work = kzalloc(sizeof(*switchdev_work), GFP_ATOMIC);
 		if (!switchdev_work)
 			return NOTIFY_BAD;
-- 
2.25.1

