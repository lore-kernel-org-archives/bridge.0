Return-Path: <sfeldma@cumulusnetworks.com>
From: Scott Feldman <sfeldma@cumulusnetworks.com>
Date: Mon, 06 Jan 2014 11:00:32 -0800
Message-ID: <20140106190032.10912.1521.stgit@monster-03.cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH net-next 1/2] bridge: use spin_lock_bh() in
 br_multicast_set_hash_max
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, shm@cumulusnetworks.com

From: Curt Brune <curt@cumulusnetworks.com>

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
2. Set the "multicast query interval" to a low number, like 2.
3. Enable the bridge as a multicast querier.
4. Repeatedly set the bridge hash_max parameter via sysfs.

  # brctl addbr br0
  # brctl addif br0 eth1 eth2 eth3 eth4
  # brctl setmcqi br0 2
  # brctl setmcquerier br0 1

  # while true ; do echo 4096 > /sys/class/net/br0/bridge/hash_max; done

Signed-off-by: Curt Brune <curt@cumulusnetworks.com>
Signed-off-by: Scott Feldman <sfeldma@cumulusnetworks.com>
---
 net/bridge/br_multicast.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 4c214b2..ef66365 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1998,7 +1998,7 @@ int br_multicast_set_hash_max(struct net_bridge *br, unsigned long val)
 	u32 old;
 	struct net_bridge_mdb_htable *mdb;
 
-	spin_lock(&br->multicast_lock);
+	spin_lock_bh(&br->multicast_lock);
 	if (!netif_running(br->dev))
 		goto unlock;
 
@@ -2030,7 +2030,7 @@ rollback:
 	}
 
 unlock:
-	spin_unlock(&br->multicast_lock);
+	spin_unlock_bh(&br->multicast_lock);
 
 	return err;
 }

