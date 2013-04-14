Return-Path: <stephen@networkplumber.org>
Date: Sat, 13 Apr 2013 17:06:07 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20130413170607.2a9294f6@nehalam.linuxnetplumber.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [PATCH net] bridge: make user modified path cost sticky
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

Keep a STP port path cost value if it was set by a user.
Don't replace it with the link-speed based path cost
whenever the link goes down and comes back up.

Reported-by: Roopa Prabhu <roopa@cumulusnetworks.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

---
 net/bridge/br_if.c      |    3 ++-
 net/bridge/br_private.h |    1 +
 net/bridge/br_stp_if.c  |    1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

--- a/net/bridge/br_private.h	2013-03-14 14:22:58.155958025 -0700
+++ b/net/bridge/br_private.h	2013-04-13 09:16:41.712531648 -0700
@@ -156,6 +156,7 @@ struct net_bridge_port
 #define BR_BPDU_GUARD           0x00000002
 #define BR_ROOT_BLOCK		0x00000004
 #define BR_MULTICAST_FAST_LEAVE	0x00000008
+#define BR_ADMIN_COST		0x00000010
 
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
 	u32				multicast_startup_queries_sent;
--- a/net/bridge/br_stp_if.c	2013-03-07 18:12:53.885287247 -0800
+++ b/net/bridge/br_stp_if.c	2013-04-13 09:19:58.437979528 -0700
@@ -288,6 +288,7 @@ int br_stp_set_path_cost(struct net_brid
 	    path_cost > BR_MAX_PATH_COST)
 		return -ERANGE;
 
+	p->flags |= BR_ADMIN_COST;
 	p->path_cost = path_cost;
 	br_configuration_update(p->br);
 	br_port_state_selection(p->br);
--- a/net/bridge/br_if.c	2013-04-09 16:10:57.553418004 -0700
+++ b/net/bridge/br_if.c	2013-04-13 09:24:07.274751368 -0700
@@ -67,7 +67,8 @@ void br_port_carrier_check(struct net_br
 	struct net_device *dev = p->dev;
 	struct net_bridge *br = p->br;
 
-	if (netif_running(dev) && netif_oper_up(dev))
+	if (!(p->flags & BR_ADMIN_COST) &&
+	    netif_running(dev) && netif_oper_up(dev))
 		p->path_cost = port_cost(dev);
 
 	if (!netif_running(br->dev))
