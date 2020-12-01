Return-Path: <Joseph.Huang@garmin.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pps1; bh=sgWCCi2xvV7fzi41aFxypPrNSj2F+DZVhWOB0ye5l7I=;
 b=JmDj2TyMK8ewSYXRv7gkhjjlHAkwJxMCQO+qtjwIEfGIEe2IoRkfH2eeKq/vN7d1OLaO
 oq79RSv5Q9Qchnk746ug4ycwOccja+iqdV70PujXmzfFwoRFuIhTnzVovRg9FGIniLd2
 tQB6+1jI3TYJPpLreNZQ7VpHnhXn6S9Hr7rRyyXGfYyIBXNaCLy7YWpE9ySGxFacTTCC
 npdQLerCmLpUPH92GdIoKWm+J99BbnM+bsYGaEREsUlvQj6/k/HIMd24fyyc8T4jITm1
 GCJwJgrV3jJ/dd3vDKI7NnhF5PQ4uhOIwXvQbuwMoqZVeG/fHv6BdQSVjaby53ZeRq1f Ww== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=garmin.onmicrosoft.com; s=selector1-garmin-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgWCCi2xvV7fzi41aFxypPrNSj2F+DZVhWOB0ye5l7I=;
 b=DW9uZ0+bMFqEe0QYFMPm2DC5akOYCbQ08tC4MnnZsN0ptc+Q94QdGdMgoUTl/JwpYwvt7dkn+dBRZBH/UlDla9tslnjhiGnCt9fwb/2cuDYa2a9nSmHx1QoLRndfBdcljqYVWA7ekBJS6ge82H8FQb+I5G5FWFxRbIx1IeXfdORfYP1yMlaazS10yVXxp3UG2NK+EhmNDXLVIGxMOny8kfcmQE3C9QEbFVGCCvil4ACDA35wsBE27cLCdb4HYMexMDWnDm1XkMtBaA9aPReb3jQysrDjRiIgvzMvpB5F9IYGEYh9IxIXr6WT3Ft/H9iSTRRyyAT0yq8l8/fW5/VYkQ==
From: Joseph Huang <Joseph.Huang@garmin.com>
Date: Tue, 1 Dec 2020 16:40:47 -0500
Message-ID: <20201201214047.128948-1-Joseph.Huang@garmin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH] bridge: Fix a deadlock when enabling multicast
	snooping
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Joseph Huang <Joseph.Huang@garmin.com>

When enabling multicast snooping, bridge module deadlocks on multicast_lock
if 1) IPv6 is enabled, and 2) there is an existing querier on the same L2
network.

The deadlock was caused by the following sequence: While holding the lock,
br_multicast_open calls br_multicast_join_snoopers, which eventually causes
IP stack to (attempt to) send out a Listener Report (in igmp6_join_group).
Since the destination Ethernet address is a multicast address, br_dev_xmit
feeds the packet back to the bridge via br_multicast_rcv, which in turn
calls br_multicast_add_group, which then deadlocks on multicast_lock.

The fix is to move the call br_multicast_join_snoopers outside of the
critical section. This works since br_multicast_join_snoopers only deals
with IP and does not modify any multicast data structures of the bridge,
so there's no need to hold the lock.

Fixes: 4effd28c1245 ("bridge: join all-snoopers multicast address")

Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
---
 net/bridge/br_device.c    | 3 +++
 net/bridge/br_multicast.c | 8 ++++----
 net/bridge/br_private.h   | 5 +++++
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 7730c8f3cb53..8d3ec29d3875 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -177,6 +177,9 @@ static int br_dev_open(struct net_device *dev)
 	br_stp_enable_bridge(br);
 	br_multicast_open(br);
 
+	if (br_opt_get(br, BROPT_MULTICAST_ENABLED))
+		br_multicast_join_snoopers(br);
+
 	return 0;
 }
 
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index eae898c3cff7..6c8d6b2eed91 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -3286,7 +3286,7 @@ static inline void br_ip6_multicast_join_snoopers(struct net_bridge *br)
 }
 #endif
 
-static void br_multicast_join_snoopers(struct net_bridge *br)
+void br_multicast_join_snoopers(struct net_bridge *br)
 {
 	br_ip4_multicast_join_snoopers(br);
 	br_ip6_multicast_join_snoopers(br);
@@ -3336,9 +3336,6 @@ static void __br_multicast_open(struct net_bridge *br,
 
 void br_multicast_open(struct net_bridge *br)
 {
-	if (br_opt_get(br, BROPT_MULTICAST_ENABLED))
-		br_multicast_join_snoopers(br);
-
 	__br_multicast_open(br, &br->ip4_own_query);
 #if IS_ENABLED(CONFIG_IPV6)
 	__br_multicast_open(br, &br->ip6_own_query);
@@ -3509,6 +3506,9 @@ int br_multicast_toggle(struct net_bridge *br, unsigned long val)
 unlock:
 	spin_unlock_bh(&br->multicast_lock);
 
+	if (br_opt_get(br, BROPT_MULTICAST_ENABLED))
+		br_multicast_join_snoopers(br);
+
 	return 0;
 }
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 345118e35c42..7085dd747130 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -792,6 +792,7 @@ void br_multicast_del_port(struct net_bridge_port *port);
 void br_multicast_enable_port(struct net_bridge_port *port);
 void br_multicast_disable_port(struct net_bridge_port *port);
 void br_multicast_init(struct net_bridge *br);
+void br_multicast_join_snoopers(struct net_bridge *br);
 void br_multicast_open(struct net_bridge *br);
 void br_multicast_stop(struct net_bridge *br);
 void br_multicast_dev_del(struct net_bridge *br);
@@ -969,6 +970,10 @@ static inline void br_multicast_init(struct net_bridge *br)
 {
 }
 
+static inline void br_multicast_join_snoopers(struct net_bridge *br)
+{
+}
+
 static inline void br_multicast_open(struct net_bridge *br)
 {
 }
-- 
2.29.2

