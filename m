Message-ID: <4624B44A.9040509@sw.ru>
Date: Tue, 17 Apr 2007 15:49:30 +0400
From: Pavel Emelianov <xemul@sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [BRIDGE] Unaligned access on IA64 when comparing ethernet
	addresses
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>, shemminger@linux-foundation.org, Linux Netdev List <netdev@vger.kernel.org>
Cc: bridge@lists.osdl.org, devel@openvz.org

From: Evgeny Kravtsunov <emkravts@openvz.org>

compare_ether_addr() implicitly requires that the addresses
passed are 2-bytes aligned in memory.

This is not true for br_stp_change_bridge_id() and
br_stp_recalculate_bridge_id() in which one of the addresses
is unsigned char *, and thus may not be 2-bytes aligned.

Signed-off-by: Evgeny Kravtsunov <emkravts@openvz.org>
Signed-off-by: Kirill Korotaev <dev@openvz.org>
Signed-off-by: Pavel Emelianov <xemul@openvz.org>

---

--- a/net/bridge/br_stp_if.c	2006-09-20 07:42:06.000000000 +0400
+++ b/net/bridge/br_stp_if.c	2007-04-13 12:28:08.000000000 +0400
@@ -124,7 +124,9 @@ void br_stp_disable_port(struct net_brid
 /* called under bridge lock */
 void br_stp_change_bridge_id(struct net_bridge *br, const unsigned char *addr)
 {
-	unsigned char oldaddr[6];
+	/* should be aligned on 2 bytes for compare_ether_addr() */
+	unsigned short oldaddr_aligned[ETH_ALEN >> 1];
+	unsigned char *oldaddr = (unsigned char *)oldaddr_aligned;
 	struct net_bridge_port *p;
 	int wasroot;
 
@@ -149,11 +151,14 @@ void br_stp_change_bridge_id(struct net_
 		br_become_root_bridge(br);
 }
 
-static const unsigned char br_mac_zero[6];
+/* should be aligned on 2 bytes for compare_ether_addr() */
+static const unsigned short br_mac_zero_aligned[ETH_ALEN >> 1];
 
 /* called under bridge lock */
 void br_stp_recalculate_bridge_id(struct net_bridge *br)
 {
+	const unsigned char *br_mac_zero =
+			(const unsigned char *)br_mac_zero_aligned;
 	const unsigned char *addr = br_mac_zero;
 	struct net_bridge_port *p;
 
