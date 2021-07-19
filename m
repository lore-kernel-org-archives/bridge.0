Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mcWNza9gQmSxGt3bwRx61Kopd5OlGB2WGW5uMng2ew=;
 b=LAKmOlKypKvDRfZ6POm7X6LhpOgvXYVrHEXuUjMdu2s8PqlC1roe5rJdfZ6lQsLhdJDv+qwCQIWro8qIcWcTjHzGR1/RJrg9nQ3NEsMCf2mpMGIP2JxSFOkrq9oQomjkX8Z/KZi07e5cta41R2WXuEhnt7z1MiNdH5FT7QGgd2c=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Mon, 19 Jul 2021 16:51:38 +0300
Message-Id: <20210719135140.278938-2-vladimir.oltean@nxp.com>
In-Reply-To: <20210719135140.278938-1-vladimir.oltean@nxp.com>
References: <20210719135140.278938-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH net-next 1/3] net: switchdev: introduce helper for
	checking dynamically learned FDB entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, DENG Qingfang <dqfext@gmail.com>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@idosch.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>

It is a bit difficult to understand what DSA checks when it tries to
avoid installing dynamically learned addresses on foreign interfaces as
local host addresses, so create a generic switchdev helper that can be
reused and is generally more readable.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 include/net/switchdev.h | 6 ++++++
 net/dsa/slave.c         | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index e4cac9218ce1..745eb25fb8c4 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -238,6 +238,12 @@ switchdev_notifier_info_to_extack(const struct switchdev_notifier_info *info)
 	return info->extack;
 }
 
+static inline bool
+switchdev_fdb_is_dynamically_learned(const struct switchdev_notifier_fdb_info *fdb_info)
+{
+	return !fdb_info->added_by_user && !fdb_info->is_local;
+}
+
 #ifdef CONFIG_NET_SWITCHDEV
 
 void switchdev_deferred_process(void);
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index ffbba1e71551..feb64f58faed 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -2438,7 +2438,7 @@ static int dsa_slave_switchdev_event(struct notifier_block *unused,
 			 * On the other hand, FDB entries for local termination
 			 * should always be installed.
 			 */
-			if (!fdb_info->added_by_user && !fdb_info->is_local &&
+			if (switchdev_fdb_is_dynamically_learned(fdb_info) &&
 			    !dp->ds->assisted_learning_on_cpu_port)
 				return NOTIFY_DONE;
 
-- 
2.25.1

