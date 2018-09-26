Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=dkMOXatPISwkrRpBBaHhYyPMq8B4Rjr7dCfeL3XxzrY=;
	b=Vy3qQ7rGcqZgXUWpM4hazsx6vzHNno3WFfkrz8D2Ma+OxyJeatq3ptd3RZ9cx84mdo
	zJdj9LqXvtmv85RRtnSZFkujDs6hk0uoluuVIVLVB0xDtSKLo99k9ILFdXRhz/eFCI2W
	xqSD/b67+alIlQSgjyXvsdpGYH0JIsS17n5ic=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Wed, 26 Sep 2018 17:00:59 +0300
Message-Id: <20180926140107.10218-2-nikolay@cumulusnetworks.com>
In-Reply-To: <20180926140107.10218-1-nikolay@cumulusnetworks.com>
References: <20180926140107.10218-1-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next v2 1/9] net: bridge: make struct opening
	bracket consistent
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, idosch@idosch.org, davem@davemloft.net

Currently we have a mix of opening brackets on new lines and on the same
line, let's move them all on the same line.

Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/bridge/br_private.h | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index d21035a17f4c..522d707cc533 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -54,14 +54,12 @@ typedef struct bridge_id bridge_id;
 typedef struct mac_addr mac_addr;
 typedef __u16 port_id;
 
-struct bridge_id
-{
+struct bridge_id {
 	unsigned char	prio[2];
 	unsigned char	addr[ETH_ALEN];
 };
 
-struct mac_addr
-{
+struct mac_addr {
 	unsigned char	addr[ETH_ALEN];
 };
 
@@ -207,8 +205,7 @@ struct net_bridge_port_group {
 	unsigned char			eth_addr[ETH_ALEN];
 };
 
-struct net_bridge_mdb_entry
-{
+struct net_bridge_mdb_entry {
 	struct hlist_node		hlist[2];
 	struct net_bridge		*br;
 	struct net_bridge_port_group __rcu *ports;
@@ -218,8 +215,7 @@ struct net_bridge_mdb_entry
 	bool				host_joined;
 };
 
-struct net_bridge_mdb_htable
-{
+struct net_bridge_mdb_htable {
 	struct hlist_head		*mhash;
 	struct rcu_head			rcu;
 	struct net_bridge_mdb_htable	*old;
-- 
2.11.0

