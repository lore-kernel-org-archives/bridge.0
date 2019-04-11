Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=cIm1WM2orO7m8M+IcrzbXB+WItZKq8vBKCt7TrMB9d4=;
	b=bKJMsXIuQpTSfhbFM7mDndOyuZIJT4cD8uu6jZZe8u3W/PSyX6M+nk4ZItYGsKlKgv
	+menMhmO4x0ap8rTmwKJY0Db1kGx/EeET/UgRRpI/lVHGCL2UpFNKomv9P2+ZXTo3v9E
	bXS1BorkgN35OOpurIHtheWrsPtFdGSOTha0o=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Thu, 11 Apr 2019 15:08:25 +0300
Message-Id: <20190411120825.31221-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net] net: bridge: multicast: use rcu to access port
	list from br_multicast_start_querier
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, herbert@gondor.apana.org.au

br_multicast_start_querier() walks over the port list but it can be
called from a timer with only multicast_lock held which doesn't protect
the port list, so use RCU to walk over it.

Fixes: c83b8fab06fc ("bridge: Restart queries when last querier expires")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
---
 net/bridge/br_multicast.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 02da21d771c9..45e7f4173bba 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2031,7 +2031,8 @@ static void br_multicast_start_querier(struct net_bridge *br,
 
 	__br_multicast_open(br, query);
 
-	list_for_each_entry(port, &br->port_list, list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(port, &br->port_list, list) {
 		if (port->state == BR_STATE_DISABLED ||
 		    port->state == BR_STATE_BLOCKING)
 			continue;
@@ -2043,6 +2044,7 @@ static void br_multicast_start_querier(struct net_bridge *br,
 			br_multicast_enable(&port->ip6_own_query);
 #endif
 	}
+	rcu_read_unlock();
 }
 
 int br_multicast_toggle(struct net_bridge *br, unsigned long val)
-- 
2.20.1

