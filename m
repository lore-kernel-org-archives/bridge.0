Return-Path: <Joseph.Huang@garmin.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pps1;
 bh=Fj46d+TFO6oS9m9H9NaMKRavcBycZmgywtCruQcLscg=;
 b=OJhdxKx6hEgp7j7TT6nzISmkxKLf7sQ/jhSNPZG1ZfoOMIhhw4bBUxVZLzF/ZrBnuRMQ
 /rSUiFaQ4nW5lrQXQ+6lXK0FYi88qGl9Gr4eUWkz16giinH+zu8ElL+aSgtI1BTpqI9c
 aoCZdN1UdT85iRxvDgtqZ1jx+QltAQoYbiBn90mfVLcLT8QITlijNAphZI1FeWHZXYcc
 +T/MBkqD3thxpq6ZA/7w/65QXt4I+rNZS60eS8iUVZnslw/Om8dy1LZH33Kp+tlJJ+4X
 WraZXZPdETnMaWj7bkXI/ueXR043GjMvSBWNr2NCfTIKBHd08dKHbQQCX9TNsGxC+zcQ TA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=garmin.onmicrosoft.com; s=selector1-garmin-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fj46d+TFO6oS9m9H9NaMKRavcBycZmgywtCruQcLscg=;
 b=GLYwZ3cgydMX0maQcdUxqt0CBhxPUSmMqOTP7mTOYDnoERjmHYFJ8GLmnVv3UHYR3oRiA5wu/aVG1uc78caRgNXm51Af3PSgpas7dVaT7lCjcThfxecR7xQfGWMXoO2IttmvukKISyZFYZGtnNCBmZ5s4jKW2nudHSFQW298utp9BfhfF2qeECeiAamItpewN3x1upfyjCwge3GfYvET/GrRgwSx63fUbrZJdM92aR3gaudb5PxXvgAL80yZxKAC+oKubly+0Knuqz4sJBBYSxD6Uq3EZtar32vHTedM0cN4uRrQRjzAy3XWiut3z5A2x/MGjCHm4zz7wEXd3ucs0A==
From: Joseph Huang <Joseph.Huang@garmin.com>
Date: Tue, 4 May 2021 14:22:58 -0400
Message-ID: <20210504182259.5042-6-Joseph.Huang@garmin.com>
In-Reply-To: <20210504182259.5042-1-Joseph.Huang@garmin.com>
References: <20210504182259.5042-1-Joseph.Huang@garmin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH 5/6] bridge: Flood Queries even when mcast_flood is
	disabled
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

Modify the forwarding path so that received Queries are always flooded
even when mcast_flood is disabled on a bridge port.

In current implementation, when mcast_flood is disabled on a bridge
port, Queries received from other Querier will not be forwarded out of
that bridge port. This unfortunately broke multicast snooping.

Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
---
 net/bridge/br_forward.c   | 3 ++-
 net/bridge/br_multicast.c | 3 +++
 net/bridge/br_private.h   | 3 +++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 6e9b049ae521..2fb9b4a78881 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -203,7 +203,8 @@ void br_flood(struct net_bridge *br, struct sk_buff *skb,
 				continue;
 			break;
 		case BR_PKT_MULTICAST:
-			if (!(p->flags & BR_MCAST_FLOOD) && skb->dev != br->dev)
+			if (!(p->flags & BR_MCAST_FLOOD) && skb->dev != br->dev &&
+			    !BR_INPUT_SKB_CB_FORCE_FLOOD(skb))
 				continue;
 			break;
 		case BR_PKT_BROADCAST:
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 719ded3204a0..b7d9c491abe0 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -3238,6 +3238,7 @@ static int br_multicast_ipv4_rcv(struct net_bridge *br,
 		err = br_ip4_multicast_igmp3_report(br, port, skb, vid);
 		break;
 	case IGMP_HOST_MEMBERSHIP_QUERY:
+		BR_INPUT_SKB_CB(skb)->force_flood = 1;
 		br_ip4_multicast_query(br, port, skb, vid);
 		break;
 	case IGMP_HOST_LEAVE_MESSAGE:
@@ -3300,6 +3301,7 @@ static int br_multicast_ipv6_rcv(struct net_bridge *br,
 		err = br_ip6_multicast_mld2_report(br, port, skb, vid);
 		break;
 	case ICMPV6_MGM_QUERY:
+		BR_INPUT_SKB_CB(skb)->force_flood = 1;
 		err = br_ip6_multicast_query(br, port, skb, vid);
 		break;
 	case ICMPV6_MGM_REDUCTION:
@@ -3322,6 +3324,7 @@ int br_multicast_rcv(struct net_bridge *br, struct net_bridge_port *port,
 
 	BR_INPUT_SKB_CB(skb)->igmp = 0;
 	BR_INPUT_SKB_CB(skb)->mrouters_only = 0;
+	BR_INPUT_SKB_CB(skb)->force_flood = 0;
 
 	if (!br_opt_get(br, BROPT_MULTICAST_ENABLED))
 		return 0;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 9aa51508ba83..59af599d48eb 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -491,6 +491,7 @@ struct br_input_skb_cb {
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
 	u8 igmp;
 	u8 mrouters_only:1;
+	u8 force_flood:1;
 #endif
 	u8 proxyarp_replied:1;
 	u8 src_port_isolated:1;
@@ -510,8 +511,10 @@ struct br_input_skb_cb {
 
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
 # define BR_INPUT_SKB_CB_MROUTERS_ONLY(__skb)	(BR_INPUT_SKB_CB(__skb)->mrouters_only)
+# define BR_INPUT_SKB_CB_FORCE_FLOOD(__skb)		(BR_INPUT_SKB_CB(__skb)->force_flood)
 #else
 # define BR_INPUT_SKB_CB_MROUTERS_ONLY(__skb)	(0)
+# define BR_INPUT_SKB_CB_FORCE_FLOOD(__skb)		(0)
 #endif
 
 #define br_printk(level, br, format, args...)	\
-- 
2.17.1

