Date: Fri, 11 Mar 2005 10:26:36 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20050311102636.30934f12@dxpl.pdx.osdl.net>
In-Reply-To: <20050310185152.12ed9819.davem@davemloft.net>
References: <20050310154437.1223b6e9@dxpl.pdx.osdl.net>
	<20050310185152.12ed9819.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH] bridge: no update when hold time is zero
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@oss.sgi.com, bridge@lists.osdl.org

Some users, set hold time to zero on bridge so it always does
flooding. This is usually when using it with wireless.  The new RCU
based code changed the behaviour so the bridge would not flood for
one GC interval. This patch restores the original behaviour.

diff -Nru a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
--- a/net/bridge/br_fdb.c	2005-03-11 10:23:44 -08:00
+++ b/net/bridge/br_fdb.c	2005-03-11 10:23:44 -08:00
@@ -337,6 +337,10 @@
 	struct hlist_head *head = &br->hash[br_mac_hash(addr)];
 	struct net_bridge_fdb_entry *fdb;
 
+	/* some users want to always flood. */
+	if (hold_time(br) == 0)
+		return;
+
 	rcu_read_lock();
 	fdb = fdb_find(head, addr);
 	if (likely(fdb)) {
