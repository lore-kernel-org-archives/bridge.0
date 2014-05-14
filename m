Return-Path: <vyasevic@redhat.com>
From: Vlad Yasevich <vyasevic@redhat.com>
Date: Wed, 14 May 2014 11:09:28 -0400
Message-Id: <1400080168-16625-9-git-send-email-vyasevic@redhat.com>
In-Reply-To: <1400080168-16625-1-git-send-email-vyasevic@redhat.com>
References: <1400080168-16625-1-git-send-email-vyasevic@redhat.com>
Subject: [Bridge] [PATCH net-next 8/8] bridge: Automatically manage promisc
	mode when vlan filtering is on.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Vlad Yasevich <vyasevic@redhat.com>, mst@redhat.com, bridge@lists.linux-foundation.org, jhs@mojatatu.com, john.r.fastabend@intel.com, shemminger@vyatta.com

If the user doesn't enable vlan filtering, we have to place all
bridge ports in promsic mode so that we retain the capability of
of receiving tagged frames.
When vlan filtering is enabled, the each port will be provided with
necessary vlan configuration and would be able to receive tagged
traffic without promiscuous mode set, thus allowing us to automatically
turn promiscuity on or off depending on the configuration.

Signed-off-by: Vlad Yasevich <vyasevic@redhat.com>
---
 net/bridge/br_if.c      | 12 ++++++++----
 net/bridge/br_private.h |  9 +++++++++
 net/bridge/br_vlan.c    |  1 +
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 7759144..a9bf8cc 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -131,12 +131,16 @@ static void br_port_clear_promisc(struct net_bridge_port *p)
 void br_manage_promisc(struct net_bridge *br)
 {
 	struct net_bridge_port *p;
+	int set_all = false;
+
+	/* If vlan filtering is disabled or bridge interface is placed
+	 * into promiscuous mode, place all ports in promiscuous mode.
+	 */
+	if ((br->dev->flags & IFF_PROMISC) || !br_vlan_enabled(br))
+		set_all = true;
 
 	list_for_each_entry(p, &br->port_list, list) {
-		if (br->dev->flags & IFF_PROMISC) {
-			/* PROMISC flag has been turned on for the bridge
-			 * itself.  Turn on promisc on all ports.
-			 */
+		if (set_all) {
 			br_port_set_promisc(p);
 		} else {
 			/* If the number of auto-ports is <= 1, then all other
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 9c1fda0..bda08e4 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -643,6 +643,10 @@ static inline u16 br_get_pvid(const struct net_port_vlans *v)
 	return v->pvid ?: VLAN_N_VID;
 }
 
+static inline int br_vlan_enabled(struct net_bridge *br)
+{
+	return br->vlan_enabled;
+}
 #else
 static inline bool br_allowed_ingress(struct net_bridge *br,
 				      struct net_port_vlans *v,
@@ -723,6 +727,11 @@ static inline u16 br_get_pvid(const struct net_port_vlans *v)
 {
 	return VLAN_N_VID;	/* Returns invalid vid */
 }
+
+static inline int br_vlan_enabled(struct net_bridge *br);
+{
+	return 0;
+}
 #endif
 
 /* br_netfilter.c */
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 4a37161..24c5cc5 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -332,6 +332,7 @@ int br_vlan_filter_toggle(struct net_bridge *br, unsigned long val)
 		goto unlock;
 
 	br->vlan_enabled = val;
+	br_manage_promisc(br);
 
 unlock:
 	rtnl_unlock();
-- 
1.9.0

