Return-Path: <curt@monster-01.cumulusnetworks.com>
Date: Sat, 28 Dec 2013 14:37:32 -0800
From: Curt Brune <curt@cumulusnetworks.com>
Message-ID: <20131228223732.GA30591@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] [PATCH 1/1] bridge/br_multicast: use spin_lock_bh() in
 br_multicast_set_hash_max()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: bridge@lists.linux-foundation.org, Shrijeet Mukherjee <shm@cumulusnetworks.com>

br_multicast_set_hash_max() is called from process context in
net/bridge/br_sysfs_br.c by the sysfs store_hash_max() function.

br_multicast_set_hash_max() calls spin_lock(&br->multicast_lock),
which can deadlock the CPU if a softirq that also tries to take the
same lock interrupts br_multicast_set_hash_max() while the lock is
held .  This can happen quite easily when any of the bridge multicast
timers expire, which try to take the same lock.

The fix here is to use spin_lock_bh(), preventing other softirqs from
executing on this CPU.

Steps to reproduce:

1. Create a bridge with several interfaces (I used 4).
2. Set the "multicast query interval" to a low number, like 1.
3. Enable the bridge as a multicast querier.
4. Repeatedly set the bridge hash_max parameter via sysfs.

  # brctl addbr br0
  # brctl addif br0 eth1 eth2 eth3 eth4
  # brctl setmcqi br0 1
  # brctl setmcquerier br0 1

  # while true ; do
  >   echo 4096 > /sys/class/net/br0/bridge/hash_max
  > done

Signed-off-by: Curt Brune <curt@cumulusnetworks.com>
---
 net/bridge/br_multicast.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 4c214b2..ef66365 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1901,136 +1901,136 @@ static void br_multicast_start_querier(struct net_bridge *br,
 	struct net_bridge_port *port;
 
 	__br_multicast_open(br, query);
 
 	list_for_each_entry(port, &br->port_list, list) {
 		if (port->state == BR_STATE_DISABLED ||
 		    port->state == BR_STATE_BLOCKING)
 			continue;
 
 		if (query == &br->ip4_query)
 			br_multicast_enable(&port->ip4_query);
 #if IS_ENABLED(CONFIG_IPV6)
 		else
 			br_multicast_enable(&port->ip6_query);
 #endif
 	}
 }
 
 int br_multicast_toggle(struct net_bridge *br, unsigned long val)
 {
 	int err = 0;
 	struct net_bridge_mdb_htable *mdb;
 
 	spin_lock_bh(&br->multicast_lock);
 	if (br->multicast_disabled == !val)
 		goto unlock;
 
 	br->multicast_disabled = !val;
 	if (br->multicast_disabled)
 		goto unlock;
 
 	if (!netif_running(br->dev))
 		goto unlock;
 
 	mdb = mlock_dereference(br->mdb, br);
 	if (mdb) {
 		if (mdb->old) {
 			err = -EEXIST;
 rollback:
 			br->multicast_disabled = !!val;
 			goto unlock;
 		}
 
 		err = br_mdb_rehash(&br->mdb, mdb->max,
 				    br->hash_elasticity);
 		if (err)
 			goto rollback;
 	}
 
 	br_multicast_start_querier(br, &br->ip4_query);
 #if IS_ENABLED(CONFIG_IPV6)
 	br_multicast_start_querier(br, &br->ip6_query);
 #endif
 
 unlock:
 	spin_unlock_bh(&br->multicast_lock);
 
 	return err;
 }
 
 int br_multicast_set_querier(struct net_bridge *br, unsigned long val)
 {
 	unsigned long max_delay;
 
 	val = !!val;
 
 	spin_lock_bh(&br->multicast_lock);
 	if (br->multicast_querier == val)
 		goto unlock;
 
 	br->multicast_querier = val;
 	if (!val)
 		goto unlock;
 
 	max_delay = br->multicast_query_response_interval;
 
 	if (!timer_pending(&br->ip4_querier.timer))
 		br->ip4_querier.delay_time = jiffies + max_delay;
 
 	br_multicast_start_querier(br, &br->ip4_query);
 
 #if IS_ENABLED(CONFIG_IPV6)
 	if (!timer_pending(&br->ip6_querier.timer))
 		br->ip6_querier.delay_time = jiffies + max_delay;
 
 	br_multicast_start_querier(br, &br->ip6_query);
 #endif
 
 unlock:
 	spin_unlock_bh(&br->multicast_lock);
 
 	return 0;
 }
 
 int br_multicast_set_hash_max(struct net_bridge *br, unsigned long val)
 {
 	int err = -ENOENT;
 	u32 old;
 	struct net_bridge_mdb_htable *mdb;
 
-	spin_lock(&br->multicast_lock);
+	spin_lock_bh(&br->multicast_lock);
 	if (!netif_running(br->dev))
 		goto unlock;
 
 	err = -EINVAL;
 	if (!is_power_of_2(val))
 		goto unlock;
 
 	mdb = mlock_dereference(br->mdb, br);
 	if (mdb && val < mdb->size)
 		goto unlock;
 
 	err = 0;
 
 	old = br->hash_max;
 	br->hash_max = val;
 
 	if (mdb) {
 		if (mdb->old) {
 			err = -EEXIST;
 rollback:
 			br->hash_max = old;
 			goto unlock;
 		}
 
 		err = br_mdb_rehash(&br->mdb, br->hash_max,
 				    br->hash_elasticity);
 		if (err)
 			goto rollback;
 	}
 
 unlock:
-	spin_unlock(&br->multicast_lock);
+	spin_unlock_bh(&br->multicast_lock);
 
 	return err;
 }
-- 
1.7.10.4
