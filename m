Date: Fri, 21 May 2004 15:45:11 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20040521154511.1d7b896d@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [1/11] bridge - handle delete of multiple devices with
	same address
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "David S. Miller" <davem@redhat.com>
Cc: netdev@oss.sgi.com, bridge@osdl.org, David Woodhouse <dwmw2@infradead.org>, Diego Liziero <liziero.diego@unimore.it>

This fixes the issue discovered when removing bluetooth devices from a bridge.
Need to add special case code when forwarding table is being cleaned up to 
handle the case where several devices share the same hardware address.

(Could fix on 2.4 if there is demand for it)
 
diff -Nru a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
--- a/net/bridge/br_fdb.c	2004-05-20 08:43:46 -07:00
+++ b/net/bridge/br_fdb.c	2004-05-20 08:43:46 -07:00
@@ -157,9 +157,28 @@
 		hlist_for_each_safe(h, g, &br->hash[i]) {
 			struct net_bridge_fdb_entry *f
 				= hlist_entry(h, struct net_bridge_fdb_entry, hlist);
-			if (f->dst == p) {
-				fdb_delete(f);
+			if (f->dst != p) 
+				continue;
+
+			/*
+			 * if multiple ports all have the same device address
+			 * then when one port is deleted, assign
+			 * the local entry to other port
+			 */
+			if (f->is_local) {
+				struct net_bridge_port *op;
+				list_for_each_entry(op, &br->port_list, list) {
+					if (op != p && 
+					    !memcmp(op->dev->dev_addr,
+						    f->addr.addr, ETH_ALEN)) {
+						f->dst = op;
+						goto skip_delete;
+					}
+				}
 			}
+
+			fdb_delete(f);
+		skip_delete: ;
 		}
 	}
 	write_unlock_bh(&br->hash_lock);
