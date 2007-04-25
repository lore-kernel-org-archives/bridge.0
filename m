Message-Id: <20070425234950.847694502@linux-foundation.org>
References: <20070425234737.727790594@linux-foundation.org>
Date: Wed, 25 Apr 2007 16:47:41 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Content-Disposition: inline; filename=br-sysfs-rtnl.patch
Subject: [Bridge] [PATCH 4/4] bridge: missing rtnl
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@linux-foundation.org

Writing to /sys/class/net/brX/bridge/stp_state causes a warning because
RTNL is not held when call br_stp_if.c

Signed-off-by: Stephen Hemminger <shemminger@linux-foundation.org>

---
 net/bridge/br_sysfs_br.c |    2 ++
 1 file changed, 2 insertions(+)

--- bridge-2.6.22.orig/net/bridge/br_sysfs_br.c
+++ bridge-2.6.22/net/bridge/br_sysfs_br.c
@@ -149,9 +149,11 @@ static ssize_t show_stp_state(struct dev
 
 static void set_stp_state(struct net_bridge *br, unsigned long val)
 {
+	rtnl_lock();
 	spin_unlock_bh(&br->lock);
 	br_stp_set_enabled(br, val);
 	spin_lock_bh(&br->lock);
+	rtnl_unlock();
 }
 
 static ssize_t store_stp_state(struct device *d,

-- 

