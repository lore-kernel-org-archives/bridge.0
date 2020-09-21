Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=W1k28u9m4opk3xAHXu3X6yCLygcG5WtwBqkfTVt8j0k=;
 b=xyGBhkOGELPKn//wEelqXKR2capv+rcr01F4odCptjBa5YW1aMl9K9f6t/0AE/wp2F
 H8mU9/tvQ/ES2Gn5EstZdkbKciKhK/oKiGIWUjX3LtKCma9GaXbvw+gfcBg+t5W49o1A
 JHjfV7vzht0dYR7MYq/zmlq1IYz/NJMcNp441j3HZy23AMNTTznaX74gHX3SCSMwFNrx
 Vaey+fwS46Ycelax5JgnPTb3YsMBtq1X2N9kPwkPkyiSHD7sLTOx++j4LpbTQLHkUFkn
 DB/tET4zDJ1tQGLh3sW/wGCKCaipL+70mXN5PY4rRkJKirCxLDGDKUw4OOZ6ERVM6Z6T
 X7yA==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Mon, 21 Sep 2020 13:55:26 +0300
Message-Id: <20200921105526.1056983-17-razor@blackwall.org>
In-Reply-To: <20200921105526.1056983-1-razor@blackwall.org>
References: <20200921105526.1056983-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next 16/16] net: bridge: mcast: when forwarding
	handle filter mode and blocked flag
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@nvidia.com>, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

We need to avoid forwarding to ports in MCAST_INCLUDE filter mode when the
mdst entry is a *,G or when the port has the blocked flag.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_forward.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 4d12999e4576..e28ffadd1371 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -274,10 +274,19 @@ void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
 	struct net_bridge *br = netdev_priv(dev);
 	struct net_bridge_port *prev = NULL;
 	struct net_bridge_port_group *p;
+	bool allow_mode_include = true;
 	struct hlist_node *rp;
 
 	rp = rcu_dereference(hlist_first_rcu(&br->router_list));
-	p = mdst ? rcu_dereference(mdst->ports) : NULL;
+	if (mdst) {
+		p = rcu_dereference(mdst->ports);
+		if (br_multicast_should_handle_mode(br, mdst->addr.proto) &&
+		    br_multicast_is_star_g(&mdst->addr))
+			allow_mode_include = false;
+	} else {
+		p = NULL;
+	}
+
 	while (p || rp) {
 		struct net_bridge_port *port, *lport, *rport;
 
@@ -292,6 +301,10 @@ void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
 						   local_orig);
 				goto delivered;
 			}
+			if ((!allow_mode_include &&
+			     p->filter_mode == MCAST_INCLUDE) ||
+			    (p->flags & MDB_PG_FLAGS_BLOCKED))
+				goto delivered;
 		} else {
 			port = rport;
 		}
-- 
2.25.4

