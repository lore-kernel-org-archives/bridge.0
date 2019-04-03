Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=10ORjpIz3nOZlxQn8U+PBvymmrFpvVsbmKnz9xcvDSU=;
	b=VIQ+erz6rBkxnwHGiA59xYtgi5rdeLE5b7QOJdz8xrWfm5guINKEQVzQcOCC2AgWHE
	d4nljZRyDy+uGuJWjkxuIWTjphv5jfzKHKkDAw6o+xpXPUnEDT6d8AeJYwrbmA1p+SAX
	n/8G9zs2HcLQWadlcq8qFwIpNag4x+WRO1D7U=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Wed,  3 Apr 2019 23:44:18 +0300
Message-Id: <20190403204418.3946-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next] net: bridge: mcast: remove unused
	br_ip_equal function
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org

Since the mcast conversion to rhashtable this function has been unused, so
remove it.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_multicast.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index f5343dfac282..afef6fc2c074 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -65,23 +65,6 @@ static void br_ip6_multicast_leave_group(struct net_bridge *br,
 					 __u16 vid, const unsigned char *src);
 #endif
 
-static inline int br_ip_equal(const struct br_ip *a, const struct br_ip *b)
-{
-	if (a->proto != b->proto)
-		return 0;
-	if (a->vid != b->vid)
-		return 0;
-	switch (a->proto) {
-	case htons(ETH_P_IP):
-		return a->u.ip4 == b->u.ip4;
-#if IS_ENABLED(CONFIG_IPV6)
-	case htons(ETH_P_IPV6):
-		return ipv6_addr_equal(&a->u.ip6, &b->u.ip6);
-#endif
-	}
-	return 0;
-}
-
 static struct net_bridge_mdb_entry *br_mdb_ip_get_rcu(struct net_bridge *br,
 						      struct br_ip *dst)
 {
-- 
2.20.1

