Date: Tue, 14 Feb 2006 17:43:29 -0500 (EST)
From: Adrian Drzewiecki <z@drze.net>
Message-ID: <Pine.LNX.4.44.0602141735400.17028-100000@truch.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Bridge] [PATCH] Fix deadlock in br_stp_disable_bridge
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org
Cc: shemminger@osdl.org

Looks like somebody forgot to use the _bh spin_lock variant. We ran into a 
deadlock where br->hello_timer expired while br_stp_disable_br() walked 
br->port_list. Anush can provide you with a test program.
Patch against 2.6.16-rc3 inlined.

diff -rup linux-2.6.16-rc3/net/bridge/br_stp_if.c 
linux-2.6.16-rc3-brfix/net/bridge/br_stp_if.c
--- linux-2.6.16-rc3/net/bridge/br_stp_if.c     2006-02-12 16:27:25.000000000 -0800
+++ linux-2.6.16-rc3-brfix/net/bridge/br_stp_if.c       2006-02-14 14:33:14.000000000 -0800
@@ -67,7 +67,7 @@ void br_stp_disable_bridge(struct net_br
 {
        struct net_bridge_port *p;

-       spin_lock(&br->lock);
+       spin_lock_bh(&br->lock);
        list_for_each_entry(p, &br->port_list, list) {
                if (p->state != BR_STATE_DISABLED)
                        br_stp_disable_port(p);
@@ -76,7 +76,7 @@ void br_stp_disable_bridge(struct net_br

        br->topology_change = 0;
        br->topology_change_detected = 0;
-       spin_unlock(&br->lock);
+       spin_unlock_bh(&br->lock);

        del_timer_sync(&br->hello_timer);
        del_timer_sync(&br->topology_change_timer);


