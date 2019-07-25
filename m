Return-Path: <Horatiu.Vultur@microchip.com>
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Date: Thu, 25 Jul 2019 13:44:04 +0200
Message-ID: <1564055044-27593-1-git-send-email-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH] net: bridge: Allow bridge to joing multicast groups
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com, davem@davemloft.net, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, allan.nielsen@microchip.com
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>

There is no way to configure the bridge, to receive only specific link
layer multicast addresses. From the description of the command 'bridge
fdb append' is supposed to do that, but there was no way to notify the
network driver that the bridge joined a group, because LLADDR was added
to the unicast netdev_hw_addr_list.

Therefore update fdb_add_entry to check if the NLM_F_APPEND flag is set
and if the source is NULL, which represent the bridge itself. Then add
address to multicast netdev_hw_addr_list for each bridge interfaces.
And then the .ndo_set_rx_mode function on the driver is called. To notify
the driver that the list of multicast mac addresses changed.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 net/bridge/br_fdb.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index b1d3248..d93746d 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -175,6 +175,29 @@ static void fdb_add_hw_addr(struct net_bridge *br, const unsigned char *addr)
 	}
 }
 
+static void fdb_add_hw_maddr(struct net_bridge *br, const unsigned char *addr)
+{
+	int err;
+	struct net_bridge_port *p;
+
+	ASSERT_RTNL();
+
+	list_for_each_entry(p, &br->port_list, list) {
+		if (!br_promisc_port(p)) {
+			err = dev_mc_add(p->dev, addr);
+			if (err)
+				goto undo;
+		}
+	}
+
+	return;
+undo:
+	list_for_each_entry_continue_reverse(p, &br->port_list, list) {
+		if (!br_promisc_port(p))
+			dev_mc_del(p->dev, addr);
+	}
+}
+
 /* When a static FDB entry is deleted, the HW address from that entry is
  * also removed from the bridge private HW address list and updates all
  * the ports with needed information.
@@ -192,13 +215,27 @@ static void fdb_del_hw_addr(struct net_bridge *br, const unsigned char *addr)
 	}
 }
 
+static void fdb_del_hw_maddr(struct net_bridge *br, const unsigned char *addr)
+{
+	struct net_bridge_port *p;
+
+	ASSERT_RTNL();
+
+	list_for_each_entry(p, &br->port_list, list) {
+		if (!br_promisc_port(p))
+			dev_mc_del(p->dev, addr);
+	}
+}
+
 static void fdb_delete(struct net_bridge *br, struct net_bridge_fdb_entry *f,
 		       bool swdev_notify)
 {
 	trace_fdb_delete(br, f);
 
-	if (f->is_static)
+	if (f->is_static) {
 		fdb_del_hw_addr(br, f->key.addr.addr);
+		fdb_del_hw_maddr(br, f->key.addr.addr);
+	}
 
 	hlist_del_init_rcu(&f->fdb_node);
 	rhashtable_remove_fast(&br->fdb_hash_tbl, &f->rhnode,
@@ -843,13 +880,19 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
 			fdb->is_local = 1;
 			if (!fdb->is_static) {
 				fdb->is_static = 1;
-				fdb_add_hw_addr(br, addr);
+				if (flags & NLM_F_APPEND && !source)
+					fdb_add_hw_maddr(br, addr);
+				else
+					fdb_add_hw_addr(br, addr);
 			}
 		} else if (state & NUD_NOARP) {
 			fdb->is_local = 0;
 			if (!fdb->is_static) {
 				fdb->is_static = 1;
-				fdb_add_hw_addr(br, addr);
+				if (flags & NLM_F_APPEND && !source)
+					fdb_add_hw_maddr(br, addr);
+				else
+					fdb_add_hw_addr(br, addr);
 			}
 		} else {
 			fdb->is_local = 0;
-- 
2.7.4

