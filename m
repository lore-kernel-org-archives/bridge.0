Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Tue,  3 May 2016 22:18:54 +0200
Message-Id: <1462306734-4183-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net] bridge: fix igmp / mld query parsing
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Simon Wunderlich <sw@simonwunderlich.de>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>

With the newly introduced helper functions the skb pulling is hidden
in the checksumming function - and undone before returning to the
caller.

The IGMP and MLD query parsing functions in the bridge still
assumed that the skb is pointing to the beginning of the IGMP/MLD
message while it is now kept at the beginning of the IPv4/6 header.

If there is a querier somewhere else, then this either causes
the multicast snooping to stay disabled even though it could be
enabled. Or, if we have the querier enabled too, then this can
create unnecessary IGMP / MLD query messages on the link.

Fixing this by taking the offset between IP and IGMP/MLD header into
account, too.

Fixes: 9afd85c9e455 ("net: Export IGMP/MLD message validation code")
Reported-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/bridge/br_multicast.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 03661d9..7105cdf 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1271,6 +1271,7 @@ static int br_ip4_multicast_query(struct net_bridge *br,
 	unsigned long max_delay;
 	unsigned long now = jiffies;
 	__be32 group;
+	int offset = skb_transport_offset(skb);
 	int err = 0;
 
 	spin_lock(&br->multicast_lock);
@@ -1280,14 +1281,14 @@ static int br_ip4_multicast_query(struct net_bridge *br,
 
 	group = ih->group;
 
-	if (skb->len == sizeof(*ih)) {
+	if (skb->len == offset + sizeof(*ih)) {
 		max_delay = ih->code * (HZ / IGMP_TIMER_SCALE);
 
 		if (!max_delay) {
 			max_delay = 10 * HZ;
 			group = 0;
 		}
-	} else if (skb->len >= sizeof(*ih3)) {
+	} else if (skb->len >= offset + sizeof(*ih3)) {
 		ih3 = igmpv3_query_hdr(skb);
 		if (ih3->nsrcs)
 			goto out;
@@ -1350,6 +1351,7 @@ static int br_ip6_multicast_query(struct net_bridge *br,
 	unsigned long now = jiffies;
 	const struct in6_addr *group = NULL;
 	bool is_general_query;
+	int offset = skb_transport_offset(skb);
 	int err = 0;
 
 	spin_lock(&br->multicast_lock);
@@ -1357,8 +1359,8 @@ static int br_ip6_multicast_query(struct net_bridge *br,
 	    (port && port->state == BR_STATE_DISABLED))
 		goto out;
 
-	if (skb->len == sizeof(*mld)) {
-		if (!pskb_may_pull(skb, sizeof(*mld))) {
+	if (skb->len == offset + sizeof(*mld)) {
+		if (!pskb_may_pull(skb, offset + sizeof(*mld))) {
 			err = -EINVAL;
 			goto out;
 		}
@@ -1367,7 +1369,7 @@ static int br_ip6_multicast_query(struct net_bridge *br,
 		if (max_delay)
 			group = &mld->mld_mca;
 	} else {
-		if (!pskb_may_pull(skb, sizeof(*mld2q))) {
+		if (!pskb_may_pull(skb, offset + sizeof(*mld2q))) {
 			err = -EINVAL;
 			goto out;
 		}
-- 
1.7.10.4

