Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=VnTm7R4ZUVv4Wt/iiDM8P+5EBEl0YQ1xUvUz7/JVOwk=;
	b=BpeesUvNK0H7NmeuIDQ4uA/kyGAYhfnpVKCpzVx4yJBQ9YYxJlmJ7k8pxMkEidWZ7A
	bbip6uBQJNtdFg3/NlSw1I3T/9eVotN3pmmyiZkqVlDE+NVGpA8Yk+o/HxU92rnTBFgR
	krCL5RjsyvS31rwKdnJLtdA8zj9JX4aCqE8LE=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Wed, 22 Jul 2015 03:28:49 -0700
Message-Id: <1437560929-25827-1-git-send-email-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next] bridge: mcast: when multicast is disabled
	flush the groups
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, davem@davemloft.net

From: Satish Ashok <sashok@cumulusnetworks.com>

Once multicast gets disabled we should flush the groups.
Example:
# bridge mdb add dev br0 port eth3 grp 239.0.0.1
# bridge mdb
dev br0 port eth3 grp 239.0.0.1 temp
# echo 0 > multicast_snooping
# bridge mdb

Signed-off-by: Satish Ashok <sashok@cumulusnetworks.com>
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_multicast.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 0dd3cd90962c..cf79bfc16e30 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -39,6 +39,7 @@ static void br_multicast_start_querier(struct net_bridge *br,
 				       struct bridge_mcast_own_query *query);
 static void br_multicast_add_router(struct net_bridge *br,
 				    struct net_bridge_port *port);
+static void br_multicast_del_grps(struct net_bridge *br);
 unsigned int br_mdb_rehash_seq;
 
 static inline int br_ip_equal(const struct br_ip *a, const struct br_ip *b)
@@ -553,6 +554,7 @@ static struct net_bridge_mdb_entry *br_multicast_get_group(
 			err = -E2BIG;
 disable:
 			br->multicast_disabled = 1;
+			br_multicast_del_grps(br);
 			goto err;
 		}
 	}
@@ -1866,6 +1868,17 @@ static void br_multicast_start_querier(struct net_bridge *br,
 	}
 }
 
+static void br_multicast_del_grps(struct net_bridge *br)
+{
+	struct net_bridge_port *port, *bn;
+	struct net_bridge_port_group *pg;
+	struct hlist_node *n;
+
+	list_for_each_entry_safe(port, bn, &br->port_list, list)
+		hlist_for_each_entry_safe(pg, n, &port->mglist, mglist)
+			br_multicast_del_pg(br, pg);
+}
+
 int br_multicast_toggle(struct net_bridge *br, unsigned long val)
 {
 	int err = 0;
@@ -1876,8 +1889,10 @@ int br_multicast_toggle(struct net_bridge *br, unsigned long val)
 		goto unlock;
 
 	br->multicast_disabled = !val;
-	if (br->multicast_disabled)
+	if (br->multicast_disabled) {
+		br_multicast_del_grps(br);
 		goto unlock;
+	}
 
 	if (!netif_running(br->dev))
 		goto unlock;
-- 
2.4.3

