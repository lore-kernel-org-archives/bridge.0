Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=F8Bq9LOrbkQe2teXAwhBAJEVwZD45ZGkMkz1XIbZDow=;
 b=bOyLRLO05LKRkEOc74lMre1hcIgPlqFfHeSIbnHbPi4AW+sKiRM4lbixxkhMx7H0od
 1azpY0RF/jRISRaWzcsGdNGp7xnV3LvfYg88OepcmbC4JFAXjXXzqxFfwI7mP7QF8FK1
 8TseTb6TCbMVv/F6egydkf+4UBFwgYcOqsDAjnScKoq/rqEnhyEYK/+JLLj3TJZ+inI9
 qX33sDyKc1XhNva9UXUfZ1hMt1xT/ujw/979jSj6bcs9UVIe1mrSOFJTqP6czAWRYlD0
 XMBjY0snHCATCHI30IKkum3MRWwwR9wmTTtmRUe+TArp7dcFi5+x+J6lb2nRo20/S1qo
 ElKg==
From: Vladimir Oltean <olteanv@gmail.com>
Date: Tue, 29 Jun 2021 17:06:55 +0300
Message-Id: <20210629140658.2510288-13-olteanv@gmail.com>
In-Reply-To: <20210629140658.2510288-1-olteanv@gmail.com>
References: <20210629140658.2510288-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v5 net-next 12/15] net: dsa: include bridge
	addresses which are local in the host fdb list
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Vladimir Oltean <vladimir.oltean@nxp.com>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@idosch.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>

From: Tobias Waldekranz <tobias@waldekranz.com>

The bridge automatically creates local (not forwarded) fdb entries
pointing towards physical ports with their interface MAC addresses.
For switchdev, the significance of these fdb entries is the exact
opposite of that of non-local entries: instead of sending these frame
outwards, we must send them inwards (towards the host).

NOTE: The bridge's own MAC address is also "local". If that address is
not shared with any port, the bridge's MAC is not be added by this
functionality - but the following commit takes care of that case.

NOTE 2: We mark these addresses as host-filtered regardless of the value
of ds->assisted_learning_on_cpu_port. This is because, as opposed to the
speculative logic done for dynamic address learning on foreign
interfaces, the local FDB entries are rather fixed, so there isn't any
risk of them migrating from one bridge port to another.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v4->v5: none

 net/dsa/slave.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index ea9a7c1ce83e..d006bd04f84a 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -2398,10 +2398,12 @@ static int dsa_slave_switchdev_event(struct notifier_block *unused,
 		fdb_info = ptr;
 
 		if (dsa_slave_dev_check(dev)) {
-			if (!fdb_info->added_by_user || fdb_info->is_local)
-				return NOTIFY_OK;
-
 			dp = dsa_slave_to_port(dev);
+
+			if (fdb_info->is_local)
+				host_addr = true;
+			else if (!fdb_info->added_by_user)
+				return NOTIFY_OK;
 		} else {
 			/* Snoop addresses added to foreign interfaces
 			 * bridged with us, or the bridge
@@ -2425,9 +2427,15 @@ static int dsa_slave_switchdev_event(struct notifier_block *unused,
 				return NOTIFY_DONE;
 
 			dp = p->dp;
-			host_addr = true;
+			host_addr = fdb_info->is_local;
 
-			if (!fdb_info->added_by_user &&
+			/* FDB entries learned by the software bridge should
+			 * be installed as host addresses only if the driver
+			 * requests assisted learning.
+			 * On the other hand, FDB entries for local termination
+			 * should always be installed.
+			 */
+			if (!fdb_info->added_by_user && !fdb_info->is_local &&
 			    !dp->ds->assisted_learning_on_cpu_port)
 				return NOTIFY_DONE;
 
-- 
2.25.1

