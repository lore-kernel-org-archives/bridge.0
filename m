Return-Path: <avagin@openvz.org>
From: Andrew Vagin <avagin@openvz.org>
Message-Id: <1320940083-3719823-1-git-send-email-avagin@openvz.org>
Subject: [Bridge] [PATCH] bridge: Fix potential deadlock on
	br->multicast_lock
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Thu, 10 Nov 2011 15:46:39 -0000
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: avagin@openvz.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, devel@openvz.org

multicast_lock is taken in softirq context, so we should use
spin_lock_bh() in userspace.

call-chain in softirq context:
run_timer_softirq()
	br_multicast_query_expired()

call-chain in userspace:
sysfs_write_file()
	store_multicast_snooping()
		br_multicast_toggle()

Signed-off-by: Andrew Vagin <avagin@openvz.org>
---
 net/bridge/br_multicast.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 995cbe0..2eefe27 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1770,7 +1770,7 @@ int br_multicast_toggle(struct net_bridge *br, unsigned long val)
 	int err = 0;
 	struct net_bridge_mdb_htable *mdb;
 
-	spin_lock(&br->multicast_lock);
+	spin_lock_bh(&br->multicast_lock);
 	if (br->multicast_disabled == !val)
 		goto unlock;
 
@@ -1806,7 +1806,7 @@ rollback:
 	}
 
 unlock:
-	spin_unlock(&br->multicast_lock);
+	spin_unlock_bh(&br->multicast_lock);
 
 	return err;
 }
-- 
1.7.1

