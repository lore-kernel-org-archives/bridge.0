Message-ID: <4D4C2210.8010705@parallels.com>
Date: Fri, 04 Feb 2011 18:58:08 +0300
From: Pavel Emelyanov <xemul@parallels.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH] bridge: Don't put partly initialized fdb into hash
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>, David Miller <davem@davemloft.net>
Cc: Linux Netdev List <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org

The fdb_create() puts a new fdb into hash with only addr set. This is
not good, since there are callers, that search the hash w/o the lock
and access all the other its fields.

Applies to current netdev tree.

Signed-off-by: Pavel Emelyanov <xemul@openvz.org>

---

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 2872393..88485cc 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -328,12 +328,12 @@ static struct net_bridge_fdb_entry *fdb_create(struct hlist_head *head,
 	fdb = kmem_cache_alloc(br_fdb_cache, GFP_ATOMIC);
 	if (fdb) {
 		memcpy(fdb->addr.addr, addr, ETH_ALEN);
-		hlist_add_head_rcu(&fdb->hlist, head);
-
 		fdb->dst = source;
 		fdb->is_local = is_local;
 		fdb->is_static = is_local;
 		fdb->ageing_timer = jiffies;
+
+		hlist_add_head_rcu(&fdb->hlist, head);
 	}
 	return fdb;
 }
