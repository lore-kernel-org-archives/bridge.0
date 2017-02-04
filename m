Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=TGz9GY8jnm6NDrnJ7geFVXNA8FfXUHrf0B/2pDKSLgA=;
	b=O0ZmO5HH2QZKciQ5sQ0T65AgHIs8bFF2QQiR537CQ+/b31RjIStLaQNoI7UgN44tLh
	eXocF59PHrNSt08XYe4CjN3aAm6r3+AMLuloACKm63gUBv8aOMWVsvakcSf4j5vKPTnS
	+us2ZEPHZb4F7FVv9/N/xmwhZSXY/8vOOni70=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Sat,  4 Feb 2017 18:05:08 +0100
Message-Id: <1486227909-18319-4-git-send-email-nikolay@cumulusnetworks.com>
In-Reply-To: <1486227909-18319-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1486227909-18319-1-git-send-email-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next 3/4] bridge: move write-heavy fdb members
	in their own cache line
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

Fdb's used and updated fields are written to on every packet forward and
packet receive respectively. Thus if we are receiving packets from a
particular fdb, they'll cause false-sharing with everyone who has looked
it up (even if it didn't match, since mac/vid share cache line!). The
"used" field is even worse since it is updated on every packet forward
to that fdb, thus the standard config where X ports use a single gateway
results in 100% fdb false-sharing. Note that this patch does not prevent
the last scenario, but it makes it better for other bridge participants
which are not using that fdb (and are only doing lookups over it).
The point is with this move we make sure that only communicating parties
get the false-sharing, in a later patch we'll show how to avoid that too.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_private.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 47fd64bf5022..1cbbf63a5ef7 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -160,19 +160,21 @@ struct net_bridge_vlan_group {
 	u16				pvid;
 };
 
-struct net_bridge_fdb_entry
-{
+struct net_bridge_fdb_entry {
 	struct hlist_node		hlist;
 	struct net_bridge_port		*dst;
 
-	unsigned long			updated;
-	unsigned long			used;
 	mac_addr			addr;
 	__u16				vlan_id;
 	unsigned char			is_local:1,
 					is_static:1,
 					added_by_user:1,
 					added_by_external_learn:1;
+
+	/* write-heavy members should not affect lookups */
+	unsigned long			updated ____cacheline_aligned_in_smp;
+	unsigned long			used;
+
 	struct rcu_head			rcu;
 };
 
-- 
2.1.4

