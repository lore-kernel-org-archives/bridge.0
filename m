Return-Path: <jmaxwell37@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=Y0ZcmZtzDJYXIxa5wuP+zJgiw+MARnPcC3V3OMM2pVw=;
	b=TpaAA3xbA2NxgOQ/vnRBhQNTOaJfmlhTJ44RLEu/Z6/MrfqUEzmbvqKKsZYgqfPTOa
	vmgdtnvPt5CW8wARHXV8DsgkEoMBIaUilGl2VtDbvHMBgjfflnQLM9KxHaplFeYzuDTx
	I3Zd6MP7uOqC09/QP+7BR7GbyxYJzMzUibF5LaW+q7373VhKoJj8LEUh/Wa3x2pfXcz5
	XMOQfnKjJthCHHleRwWI0VvnKy0ErWVOZ0ju81KvJJy0/zshsOKOX+Oe8JX/b8fZ6CPs
	5NSxci6EJnMjcsqHF2RrPTUaElfs310st/qllPYSI3CSikz3pHXpi0q/LiYMgHAk+vxN
	vUPg==
From: Jon Maxwell <jmaxwell37@gmail.com>
Date: Wed, 28 May 2014 08:45:49 +1000
Message-Id: <1401230749-19507-1-git-send-email-jmaxwell37@gmail.com>
Subject: [Bridge] [PATCH net] bridge: notify user space after fdb update
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: stephen@networkplumber.org
Cc: vyasevic@redhat.com, jpirko@redhat.com, netdev@vger.kernel.org, jmaxwell@redhat.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, jmaxwell37@gmail.com, davem@davemloft.net

There has been a number incidents recently where customers running KVM have
reported that VM hosts on different Hypervisors are unreachable. Based on
pcap traces we found that the bridge was broadcasting the ARP request out
onto the network. However some NICs have an inbuilt switch which on occasions
were broadcasting the VMs ARP request back through the physical NIC on the
Hypervisor. This resulted in the bridge changing ports and incorrectly learning
that the VMs mac address was external. As a result the ARP reply was directed
back onto the external network and VM never updated it's ARP cache. This patch
will notify the bridge command, after a fdb has been updated to identify such
port toggling.

Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
---
 net/bridge/br_fdb.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 9203d5a..f3ee2da 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -487,6 +487,7 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 {
 	struct hlist_head *head = &br->hash[br_mac_hash(addr, vid)];
 	struct net_bridge_fdb_entry *fdb;
+	bool fdb_modified = 0;
 
 	/* some users want to always flood. */
 	if (hold_time(br) == 0)
@@ -507,10 +508,15 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 					source->dev->name);
 		} else {
 			/* fastpath: update of existing entry */
-			fdb->dst = source;
+			if (unlikely(source != fdb->dst)) {
+					fdb->dst = source;
+					fdb_modified = 1;
+				}
 			fdb->updated = jiffies;
 			if (unlikely(added_by_user))
 				fdb->added_by_user = 1;
+			if (unlikely(fdb_modified))
+				fdb_notify(br, fdb, RTM_NEWNEIGH);
 		}
 	} else {
 		spin_lock(&br->hash_lock);
-- 
1.8.3.1

