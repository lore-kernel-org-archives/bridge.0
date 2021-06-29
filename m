Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ExBxfgEAQTeIcUqZy35cgliNZw5pKEc8pvrekt89wDM=;
 b=hHj7Fs0zMwlg1N14gH3jx9xGdI7XkmEm8PzB+RALPqNc0IAHNCDd8bKAMlUz6P1qcn
 VeOEL0jG778JVmkwvSzYVwoFtDk3uxfZlA9jGl6l33juRtkWsQgimncnk6niKur2IMGR
 EqOaqnB1vS5augQiQzsagOD7DmOKigoiQCDDycoTT7MB9qX95qbReK2m5dY4kac8s1EY
 NoIplKBlUIO9gv3yXmto1o5Us714Vjk1xb6WQD8WuP2iVJK8fFRwNrl/bZV2jj5aC203
 v/ffQ58zYbpRJcoUVPDmgzemgkOtRcEnDrm7cbnsRNw09xqK+V5FAfg5HykFmHQO39xY
 o+UQ==
From: Vladimir Oltean <olteanv@gmail.com>
Date: Tue, 29 Jun 2021 17:06:56 +0300
Message-Id: <20210629140658.2510288-14-olteanv@gmail.com>
In-Reply-To: <20210629140658.2510288-1-olteanv@gmail.com>
References: <20210629140658.2510288-1-olteanv@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v5 net-next 13/15] net: dsa: include fdb entries
	pointing to bridge in the host fdb list
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

From: Vladimir Oltean <vladimir.oltean@nxp.com>

The bridge supports a legacy way of adding local (non-forwarded) FDB
entries, which works on an individual port basis:

bridge fdb add dev swp0 00:01:02:03:04:05 master local

As well as a new way, added by Roopa Prabhu in commit 3741873b4f73
("bridge: allow adding of fdb entries pointing to the bridge device"):

bridge fdb add dev br0 00:01:02:03:04:05 self local

The two commands are functionally equivalent, except that the first one
produces an entry with fdb->dst == swp0, and the other an entry with
fdb->dst == NULL. The confusing part, though, is that even if fdb->dst
is swp0 for the 'local on port' entry, that destination is not used.

Nonetheless, the idea is that the bridge has reference counting for
local entries, and local entries pointing towards the bridge are still
'as local' as local entries for a port.

The bridge adds the MAC addresses of the interfaces automatically as
FDB entries with is_local=1. For the MAC address of the ports, fdb->dst
will be equal to the port, and for the MAC address of the bridge,
fdb->dst will point towards the bridge (i.e. be NULL). Therefore, if the
MAC address of the bridge is not inherited from either of the physical
ports, then we must explicitly catch local FDB entries emitted towards
the br0, otherwise we'll miss the MAC address of the bridge (and, of
course, any entry with 'bridge add dev br0 ... self local').

Co-developed-by: Tobias Waldekranz <tobias@waldekranz.com>
Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v4->v5: none

 net/dsa/slave.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index d006bd04f84a..a7b5d2a41472 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -2415,7 +2415,11 @@ static int dsa_slave_switchdev_event(struct notifier_block *unused,
 			struct net_device *br_dev;
 			struct dsa_slave_priv *p;
 
-			br_dev = netdev_master_upper_dev_get_rcu(dev);
+			if (netif_is_bridge_master(dev))
+				br_dev = dev;
+			else
+				br_dev = netdev_master_upper_dev_get_rcu(dev);
+
 			if (!br_dev)
 				return NOTIFY_DONE;
 
@@ -2443,8 +2447,13 @@ static int dsa_slave_switchdev_event(struct notifier_block *unused,
 			 * LAG we don't want to send traffic to the CPU, the
 			 * other ports bridged with the LAG should be able to
 			 * autonomously forward towards it.
+			 * On the other hand, if the address is local
+			 * (therefore not learned) then we want to trap it to
+			 * the CPU regardless of whether the interface it
+			 * belongs to is offloaded or not.
 			 */
-			if (dsa_tree_offloads_bridge_port(dp->ds->dst, dev))
+			if (dsa_tree_offloads_bridge_port(dp->ds->dst, dev) &&
+			    !fdb_info->is_local)
 				return NOTIFY_DONE;
 		}
 
-- 
2.25.1

