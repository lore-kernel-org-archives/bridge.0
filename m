Return-Path: <menglong8.dong@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=X5IUJFfkhyOjUeQe/gYauu/2sKrd/DEbUds1gC+B5RU=;
 b=DpDvfQf3vyJbpzghRJ8Cew7bzqpKpLzkvro4EJtc49amvTSAelFioDvmVj1BFNrFcN
 vpotcO2IAcg8vzQ1dZqwVLHvDHERBOGOjZ/1eQLboSDqY+YHQ7ZLtNnkM0kXqHEU8sdy
 t+rgEfzXJ900nUH2ET41LCxgZ00KFeW33M0etBMG/M8ssVzO9BgybOlF8uobyQ4SnU3E
 189WhrVboNLOjebfz/Qf+s+xUQqcuCof5n7aGc8bnsNWK/HsU8LgYKnqyVV7YrHg5wnE
 LMcth4tbTxbGxECyb6GG/fA6LBkSeWHaiU6ssOfmQWLa7vu+ldc8M3rFpTOkZB03o4Nu
 YlCw==
From: menglong8.dong@gmail.com
Date: Thu, 14 Jan 2021 20:41:31 -0800
Message-Id: <20210115044131.6039-1-dong.menglong@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH v3 net-next] net: bridge: check vlan with
	eth_type_vlan() method
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: kuba@kernel.org
Cc: Menglong Dong <dong.menglong@zte.com.cn>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, nikolay@nvidia.com, roopa@nvidia.com, davem@davemloft.net

From: Menglong Dong <dong.menglong@zte.com.cn>

Replace some checks for ETH_P_8021Q and ETH_P_8021AD with
eth_type_vlan().

Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
---
v3:
- fix compile warning in br_vlan_set_proto() by casting 'val' to
  be16.

v2:
- use eth_type_vlan() in br_validate() and __br_vlan_set_proto()
  too.
---
 net/bridge/br_forward.c |  3 +--
 net/bridge/br_netlink.c | 11 +++--------
 net/bridge/br_vlan.c    |  2 +-
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index e28ffadd1371..6e9b049ae521 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -39,8 +39,7 @@ int br_dev_queue_push_xmit(struct net *net, struct sock *sk, struct sk_buff *skb
 	br_drop_fake_rtable(skb);
 
 	if (skb->ip_summed == CHECKSUM_PARTIAL &&
-	    (skb->protocol == htons(ETH_P_8021Q) ||
-	     skb->protocol == htons(ETH_P_8021AD))) {
+	    eth_type_vlan(skb->protocol)) {
 		int depth;
 
 		if (!__vlan_get_protocol(skb, skb->protocol, &depth))
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 49700ce0e919..15cfcad846c5 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1096,14 +1096,9 @@ static int br_validate(struct nlattr *tb[], struct nlattr *data[],
 		return 0;
 
 #ifdef CONFIG_BRIDGE_VLAN_FILTERING
-	if (data[IFLA_BR_VLAN_PROTOCOL]) {
-		switch (nla_get_be16(data[IFLA_BR_VLAN_PROTOCOL])) {
-		case htons(ETH_P_8021Q):
-		case htons(ETH_P_8021AD):
-			break;
-		default:
-			return -EPROTONOSUPPORT;
-		}
+	if (data[IFLA_BR_VLAN_PROTOCOL] &&
+	    !eth_type_vlan(nla_get_be16(data[IFLA_BR_VLAN_PROTOCOL]))) {
+		return -EPROTONOSUPPORT;
 	}
 
 	if (data[IFLA_BR_VLAN_DEFAULT_PVID]) {
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 701cad646b20..bb2909738518 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -917,7 +917,7 @@ int __br_vlan_set_proto(struct net_bridge *br, __be16 proto)
 
 int br_vlan_set_proto(struct net_bridge *br, unsigned long val)
 {
-	if (val != ETH_P_8021Q && val != ETH_P_8021AD)
+	if (!eth_type_vlan(htons(val)))
 		return -EPROTONOSUPPORT;
 
 	return __br_vlan_set_proto(br, htons(val));
-- 
2.25.1

