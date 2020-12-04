Return-Path: <Joseph.Huang@garmin.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pps1;
 bh=zqXsF6l9tXT+qxlWWgAJIfKFp4LyuDX1RGy/o/fvOMg=;
 b=ktaH0k1UEQ6j14uKw25s21izTnlUoVrSTbcO/DmsDxDgCb+4ZI9RZz2cVNwdy9jpTnMA
 qAhor/CzGFTW8XAlbvDqo1SxcDl3lW6yYewZNBo3edx5Co/UhxM8gelCj3if2uqaqIGm
 hpyFhTg3j8of5SYvOMgq7uE+x5pnaHCXEA5RoGHQRpXC0p4jB6N1IF/mL4iPpgf5dX4S
 qYVKDySU7EMAssnsIUA2BDhmFhuu61RD50rKpQlRulUtwOXutmOv2+MXp6OmFeYIB0uA
 ZDZjBSpcCrAV0yLcSy1Tyw1zMxjH9DF/ps7c+HtgqWumi0Nmrzrrm9axPyMVL8wFBtt1 lg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=garmin.onmicrosoft.com; s=selector1-garmin-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqXsF6l9tXT+qxlWWgAJIfKFp4LyuDX1RGy/o/fvOMg=;
 b=b1S6kqiWPvQ9WtP6YgJsuwnEcmr1A0r7vPZ07k6B8dD051n39bjf+Osh8UOarJw9rahaD+nrN9xWcCUGyl9y33oEb6eW6y3FyB09coYlh/+kPXjF3ilUFLty5dRPm9wl4LWCjozmfAqUMR7pFsPF0Fed81K48sUPTh0eC24jgcDK6cJSlOejn1ZjiiYDW/522FH9eRW7cFrLpW+Xcyy2ZZVQbVSxPDP06AulOuv4Xk5W5M+ckSNE1kvoMtjas4CQyj159BQAFRByjJdqJFp4RVNjDd3VAbpXYrvbjOpy9EMxHsVd7xW3ltN9I0XaS6hgRCqDHqaQcpT5iaxVFZckvw==
From: Joseph Huang <Joseph.Huang@garmin.com>
Date: Fri, 4 Dec 2020 18:56:28 -0500
Message-ID: <20201204235628.50653-1-Joseph.Huang@garmin.com>
In-Reply-To: <20201201214047.128948-1-Joseph.Huang@garmin.com>
References: <20201201214047.128948-1-Joseph.Huang@garmin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH v3] bridge: Fix a deadlock when enabling multicast
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

Steps to reproduce:
1. sysctl net.ipv6.conf.all.force_mld_version=1
2. have another querier
3. ip link set dev bridge type bridge mcast_snooping 0 && \
   ip link set dev bridge type bridge mcast_snooping 1 < deadlock >

A typical call trace looks like the following:

[  936.251495]  _raw_spin_lock+0x5c/0x68
[  936.255221]  br_multicast_add_group+0x40/0x170 [bridge]
[  936.260491]  br_multicast_rcv+0x7ac/0xe30 [bridge]
[  936.265322]  br_dev_xmit+0x140/0x368 [bridge]
[  936.269689]  dev_hard_start_xmit+0x94/0x158
[  936.273876]  __dev_queue_xmit+0x5ac/0x7f8
[  936.277890]  dev_queue_xmit+0x10/0x18
[  936.281563]  neigh_resolve_output+0xec/0x198
[  936.285845]  ip6_finish_output2+0x240/0x710
[  936.290039]  __ip6_finish_output+0x130/0x170
[  936.294318]  ip6_output+0x6c/0x1c8
[  936.297731]  NF_HOOK.constprop.0+0xd8/0xe8
[  936.301834]  igmp6_send+0x358/0x558
[  936.305326]  igmp6_join_group.part.0+0x30/0xf0
[  936.309774]  igmp6_group_added+0xfc/0x110
[  936.313787]  __ipv6_dev_mc_inc+0x1a4/0x290
[  936.317885]  ipv6_dev_mc_inc+0x10/0x18
[  936.321677]  br_multicast_open+0xbc/0x110 [bridge]
[  936.326506]  br_multicast_toggle+0xec/0x140 [bridge]

Fixes: 4effd28c1245 ("bridge: join all-snoopers multicast address")
Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
---
 net/bridge/br_device.c    |  6 ++++++
 net/bridge/br_multicast.c | 34 +++++++++++++++++++++++++---------
 net/bridge/br_private.h   | 10 ++++++++++
 3 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 7730c8f3cb53..d3ea9d0779fb 100644
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
 
@@ -197,6 +200,9 @@ static int br_dev_stop(struct net_device *dev)
 	br_stp_disable_bridge(br);
 	br_multicast_stop(br);
 
+	if (br_opt_get(br, BROPT_MULTICAST_ENABLED))
+		br_multicast_leave_snoopers(br);
+
 	netif_stop_queue(dev);
 
 	return 0;
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index eae898c3cff7..54cb82a69056 100644
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
@@ -3317,7 +3317,7 @@ static inline void br_ip6_multicast_leave_snoopers(struct net_bridge *br)
 }
 #endif
 
-static void br_multicast_leave_snoopers(struct net_bridge *br)
+void br_multicast_leave_snoopers(struct net_bridge *br)
 {
 	br_ip4_multicast_leave_snoopers(br);
 	br_ip6_multicast_leave_snoopers(br);
@@ -3336,9 +3336,6 @@ static void __br_multicast_open(struct net_bridge *br,
 
 void br_multicast_open(struct net_bridge *br)
 {
-	if (br_opt_get(br, BROPT_MULTICAST_ENABLED))
-		br_multicast_join_snoopers(br);
-
 	__br_multicast_open(br, &br->ip4_own_query);
 #if IS_ENABLED(CONFIG_IPV6)
 	__br_multicast_open(br, &br->ip6_own_query);
@@ -3354,9 +3351,6 @@ void br_multicast_stop(struct net_bridge *br)
 	del_timer_sync(&br->ip6_other_query.timer);
 	del_timer_sync(&br->ip6_own_query.timer);
 #endif
-
-	if (br_opt_get(br, BROPT_MULTICAST_ENABLED))
-		br_multicast_leave_snoopers(br);
 }
 
 void br_multicast_dev_del(struct net_bridge *br)
@@ -3487,6 +3481,7 @@ static void br_multicast_start_querier(struct net_bridge *br,
 int br_multicast_toggle(struct net_bridge *br, unsigned long val)
 {
 	struct net_bridge_port *port;
+	bool change_snoopers = false;
 
 	spin_lock_bh(&br->multicast_lock);
 	if (!!br_opt_get(br, BROPT_MULTICAST_ENABLED) == !!val)
@@ -3495,7 +3490,7 @@ int br_multicast_toggle(struct net_bridge *br, unsigned long val)
 	br_mc_disabled_update(br->dev, val);
 	br_opt_toggle(br, BROPT_MULTICAST_ENABLED, !!val);
 	if (!br_opt_get(br, BROPT_MULTICAST_ENABLED)) {
-		br_multicast_leave_snoopers(br);
+		change_snoopers = true;
 		goto unlock;
 	}
 
@@ -3506,9 +3501,30 @@ int br_multicast_toggle(struct net_bridge *br, unsigned long val)
 	list_for_each_entry(port, &br->port_list, list)
 		__br_multicast_enable_port(port);
 
+	change_snoopers = true;
+
 unlock:
 	spin_unlock_bh(&br->multicast_lock);
 
+	/* br_multicast_join_snoopers has the potential to cause
+	 * an MLD Report/Leave to be delivered to br_multicast_rcv,
+	 * which would in turn call br_multicast_add_group, which would
+	 * attempt to acquire multicast_lock. This function should be
+	 * called after the lock has been released to avoid deadlocks on
+	 * multicast_lock.
+	 *
+	 * br_multicast_leave_snoopers does not have the problem since
+	 * br_multicast_rcv first checks BROPT_MULTICAST_ENABLED, and
+	 * returns without calling br_multicast_ipv4/6_rcv if it's not
+	 * enabled. Moved both functions out just for symmetry.
+	 */
+	if (change_snoopers) {
+		if (br_opt_get(br, BROPT_MULTICAST_ENABLED))
+			br_multicast_join_snoopers(br);
+		else
+			br_multicast_leave_snoopers(br);
+	}
+
 	return 0;
 }
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 345118e35c42..8424464186a6 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -792,6 +792,8 @@ void br_multicast_del_port(struct net_bridge_port *port);
 void br_multicast_enable_port(struct net_bridge_port *port);
 void br_multicast_disable_port(struct net_bridge_port *port);
 void br_multicast_init(struct net_bridge *br);
+void br_multicast_join_snoopers(struct net_bridge *br);
+void br_multicast_leave_snoopers(struct net_bridge *br);
 void br_multicast_open(struct net_bridge *br);
 void br_multicast_stop(struct net_bridge *br);
 void br_multicast_dev_del(struct net_bridge *br);
@@ -969,6 +971,14 @@ static inline void br_multicast_init(struct net_bridge *br)
 {
 }
 
+static inline void br_multicast_join_snoopers(struct net_bridge *br)
+{
+}
+
+static inline void br_multicast_leave_snoopers(struct net_bridge *br)
+{
+}
+
 static inline void br_multicast_open(struct net_bridge *br)
 {
 }
-- 
2.29.2

