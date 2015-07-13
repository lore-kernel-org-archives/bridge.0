Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=On5zBVFBdTqT9a9nRBdCNLY2/YJsusNqfYK2HXfI6ts=;
	b=fIp/oP+8o77I0ozR95XQKG2OdWZcoBOjGE3BIt4w6c7cpqnRBSOgRJ6hpzp07eCzag
	hPnLBBo75qTotINtDIa5+SY7tIaFy1g3S7vRShWXI7VBdHWiw/hOQDUasHw0MjJuxyOQ
	bHs8VActu2c/mqMoPGjy9ZWfmdHyzjelXVEJI=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Mon, 13 Jul 2015 05:28:37 -0700
Message-Id: <1436790517-30266-1-git-send-email-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net] bridge: multicast: treat igmpv3 report with
	INCLUDE and no sources as a leave
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: herbert@gondor.apana.org.au, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, bridge@lists.linux-foundation.org, davem@davemloft.net

From: Satish Ashok <sashok@cumulusnetworks.com>

A report with INCLUDE/Change_to_include and empty source list should be
treated as a leave, specified by RFC 3376, section 3.1:
"If the requested filter mode is INCLUDE *and* the requested source
 list is empty, then the entry corresponding to the requested
 interface and multicast address is deleted if present.  If no such
 entry is present, the request is ignored."

Signed-off-by: Satish Ashok <sashok@cumulusnetworks.com>
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_multicast.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 742a6c27d7a2..79db489cdade 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -39,6 +39,16 @@ static void br_multicast_start_querier(struct net_bridge *br,
 				       struct bridge_mcast_own_query *query);
 static void br_multicast_add_router(struct net_bridge *br,
 				    struct net_bridge_port *port);
+static void br_ip4_multicast_leave_group(struct net_bridge *br,
+					 struct net_bridge_port *port,
+					 __be32 group,
+					 __u16 vid);
+#if IS_ENABLED(CONFIG_IPV6)
+static void br_ip6_multicast_leave_group(struct net_bridge *br,
+					 struct net_bridge_port *port,
+					 const struct in6_addr *group,
+					 __u16 vid);
+#endif
 unsigned int br_mdb_rehash_seq;
 
 static inline int br_ip_equal(const struct br_ip *a, const struct br_ip *b)
@@ -1010,9 +1020,15 @@ static int br_ip4_multicast_igmp3_report(struct net_bridge *br,
 			continue;
 		}
 
-		err = br_ip4_multicast_add_group(br, port, group, vid);
-		if (err)
-			break;
+		if ((type == IGMPV3_CHANGE_TO_INCLUDE ||
+		     type == IGMPV3_MODE_IS_INCLUDE) &&
+		    ntohs(grec->grec_nsrcs) == 0) {
+			br_ip4_multicast_leave_group(br, port, group, vid);
+		} else {
+			err = br_ip4_multicast_add_group(br, port, group, vid);
+			if (err)
+				break;
+		}
 	}
 
 	return err;
@@ -1071,10 +1087,17 @@ static int br_ip6_multicast_mld2_report(struct net_bridge *br,
 			continue;
 		}
 
-		err = br_ip6_multicast_add_group(br, port, &grec->grec_mca,
-						 vid);
-		if (err)
-			break;
+		if ((grec->grec_type == MLD2_CHANGE_TO_INCLUDE ||
+		     grec->grec_type == MLD2_MODE_IS_INCLUDE) &&
+		    ntohs(*nsrcs) == 0) {
+			br_ip6_multicast_leave_group(br, port, &grec->grec_mca,
+						     vid);
+		} else {
+			err = br_ip6_multicast_add_group(br, port,
+							 &grec->grec_mca, vid);
+			if (!err)
+				break;
+		}
 	}
 
 	return err;
-- 
1.9.3

