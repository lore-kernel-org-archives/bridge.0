Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Mon, 10 Mar 2014 22:25:25 +0100
Message-Id: <1394486725-4992-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1394486725-4992-1-git-send-email-linus.luessing@web.de>
References: <1394486725-4992-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCHv2 2/2] bridge: multicast: enable snooping on
	general queries only
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Florian Westphal <fwestpha@redhat.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Stephen Hemminger <stephen@networkplumber.org>, =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>, Jan Stancek <jstancek@redhat.com>

Without this check someone could easily create a denial of service
by injecting multicast-specific queries to enable the bridge
snooping part if no real querier issuing periodic general queries
is present on the link which would result in the bridge wrongly
shutting down ports for multicast traffic as the bridge did not learn
about these listeners.

With this patch the snooping code is enabled upon receiving valid,
general queries only.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
v2: unchanged

 net/bridge/br_multicast.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index e56bae4..93067ec 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1127,9 +1127,10 @@ static void br_multicast_query_received(struct net_bridge *br,
 					struct net_bridge_port *port,
 					struct bridge_mcast_querier *querier,
 					int saddr,
+					bool is_general_query,
 					unsigned long max_delay)
 {
-	if (saddr)
+	if (saddr && is_general_query)
 		br_multicast_update_querier_timer(br, querier, max_delay);
 	else if (timer_pending(&querier->timer))
 		return;
@@ -1190,7 +1191,7 @@ static int br_ip4_multicast_query(struct net_bridge *br,
 	}
 
 	br_multicast_query_received(br, port, &br->ip4_querier, !!iph->saddr,
-				    max_delay);
+				    !group, max_delay);
 
 	if (!group)
 		goto out;
@@ -1282,7 +1283,8 @@ static int br_ip6_multicast_query(struct net_bridge *br,
 	}
 
 	br_multicast_query_received(br, port, &br->ip6_querier,
-				    !ipv6_addr_any(&ip6h->saddr), max_delay);
+				    !ipv6_addr_any(&ip6h->saddr),
+				    is_general_query, max_delay);
 
 	if (!group)
 		goto out;
-- 
1.7.10.4

