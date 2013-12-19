Return-Path: <tanxiaojun@huawei.com>
From: Tan Xiaojun <tanxiaojun@huawei.com>
Date: Thu, 19 Dec 2013 13:28:11 +0800
Message-ID: <1387430894-11220-3-git-send-email-tanxiaojun@huawei.com>
In-Reply-To: <1387430894-11220-1-git-send-email-tanxiaojun@huawei.com>
References: <1387430894-11220-1-git-send-email-tanxiaojun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Bridge] [PATCH 2/5] bridge: remove unnecessary parentheses
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: stephen@networkplumber.org, davem@davemloft.net, bart.de.schuymer@pandora.be
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

Return is not a function, parentheses are not required.

Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
---
 net/bridge/br_forward.c         | 4 ++--
 net/bridge/netfilter/ebtables.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 96866aa..d3409e6 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -30,9 +30,9 @@ static int deliver_clone(const struct net_bridge_port *prev,
 static inline int should_deliver(const struct net_bridge_port *p,
 				 const struct sk_buff *skb)
 {
-	return (((p->flags & BR_HAIRPIN_MODE) || skb->dev != p->dev) &&
+	return ((p->flags & BR_HAIRPIN_MODE) || skb->dev != p->dev) &&
 		br_allowed_egress(p->br, nbp_get_vlan_info(p), skb) &&
-		p->state == BR_STATE_FORWARDING);
+		p->state == BR_STATE_FORWARDING;
 }
 
 static inline unsigned int packet_length(const struct sk_buff *skb)
diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index ac78024..09d16d7 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -118,7 +118,7 @@ ebt_dev_check(const char *entry, const struct net_device *device)
 	/* 1 is the wildcard token */
 	while (entry[i] != '\0' && entry[i] != 1 && entry[i] == devname[i])
 		i++;
-	return (devname[i] != entry[i] && entry[i] != 1);
+	return devname[i] != entry[i] && entry[i] != 1;
 }
 
 #define FWINV2(bool,invflg) ((bool) ^ !!(e->invflags & invflg))
-- 
1.8.0


