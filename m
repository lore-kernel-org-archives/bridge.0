Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=B13CGLA0lo8+efLqVrkSJzHsVtmDQcNi0q9+2P4Ffy4=;
	b=JVoRRH7Ks0QOKZBQzgGlYqA/tCcskbKbhXlkjoV7OArY2B3Hruk6xJbjLerGXpJs0l
	xwaOkD3rO7winAQea8gA7QXx0atbVTMRMAxUXq+VgGcBO/4kDHp2RGkpaaK5AiPuBmXl
	aQT1+SzJ0m3Qu4pbN2oIS1+mcQdahDozbP5z4=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Wed,  5 Dec 2018 15:14:27 +0200
Message-Id: <20181205131427.4989-5-nikolay@cumulusnetworks.com>
In-Reply-To: <20181205131427.4989-1-nikolay@cumulusnetworks.com>
References: <20181205131427.4989-1-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next v3 4/4] net: bridge: increase multicast's
	default maximum number of entries
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

bridge's default hash_max was 512 which is rather conservative, now that
we're using the generic rhashtable API which autoshrinks let's increase
it to 4096 and move it to a define in br_private.h.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
v2, v3: no change

 net/bridge/br_multicast.c | 2 +-
 net/bridge/br_private.h   | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 804ee15c45c1..879cd2315769 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1741,7 +1741,7 @@ static void br_ip6_multicast_query_expired(struct timer_list *t)
 
 void br_multicast_init(struct net_bridge *br)
 {
-	br->hash_max = 512;
+	br->hash_max = BR_MULTICAST_DEFAULT_HASH_MAX;
 
 	br->multicast_router = MDB_RTR_TYPE_TEMP_QUERY;
 	br->multicast_last_member_count = 2;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index ba50fa437a94..5719b4d3e466 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -31,6 +31,8 @@
 #define BR_PORT_BITS	10
 #define BR_MAX_PORTS	(1<<BR_PORT_BITS)
 
+#define BR_MULTICAST_DEFAULT_HASH_MAX 4096
+
 #define BR_VERSION	"2.3"
 
 /* Control of forwarding link local multicast */
-- 
2.17.2

