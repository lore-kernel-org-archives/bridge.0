Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnNsmqSGXme7gRFsGv5yZ5vZbFhW8Cd6oNNqhjaTRH8=;
 b=IfXGzRY6NUEuy60RqzwyKJSVDYQIel+21sC+5d7q/FdYR1O6EW+MF4Uz1dItBtZaXH67yzco1fi+offgq8wfWeHrQDWO8Aga95SuhXQkn0veRPxP2Rsnc4bIfb9zeNB/toOIv+qc754hm6I5ZH6IjN9Eie+8EcGn83RvD/X61/Q=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Thu, 22 Jul 2021 18:55:42 +0300
Message-Id: <20210722155542.2897921-6-vladimir.oltean@nxp.com>
In-Reply-To: <20210722155542.2897921-1-vladimir.oltean@nxp.com>
References: <20210722155542.2897921-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [PATCH v5 net-next 5/5] net: dsa: tag_dsa: offload the
	bridge forwarding process
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, DENG Qingfang <dqfext@gmail.com>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@idosch.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Marek Behun <kabel@blackhole.sk>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>

From: Tobias Waldekranz <tobias@waldekranz.com>

Allow the DSA tagger to generate FORWARD frames for offloaded skbs
sent from a bridge that we offload, allowing the switch to handle any
frame replication that may be required. This also means that source
address learning takes place on packets sent from the CPU, meaning
that return traffic no longer needs to be flooded as unknown unicast.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2:
- use the VLAN from the packet when the bridge is VLAN-aware, and the
  PVID of the bridge when VLAN-unaware, instead of the PVID of the
  egress port as the code was originally written
- retrieve the sb_dev based on the TX queue mapping of the skb instead
  of based on the DSA_SKB_CB() populated in the ndo_select_queue()
  method, because DSA does not have ownership of the skb there yet
v2->v3:
- use skb->offload_fwd_mark instead of dsa_slave_get_sb_dev() and TX
  queue mappings
- drop the "bool bridge_fwd_offload"
v3->v5:
- none

 net/dsa/tag_dsa.c | 52 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 44 insertions(+), 8 deletions(-)

diff --git a/net/dsa/tag_dsa.c b/net/dsa/tag_dsa.c
index a822355afc90..0f258218c8cf 100644
--- a/net/dsa/tag_dsa.c
+++ b/net/dsa/tag_dsa.c
@@ -126,7 +126,42 @@ static struct sk_buff *dsa_xmit_ll(struct sk_buff *skb, struct net_device *dev,
 				   u8 extra)
 {
 	struct dsa_port *dp = dsa_slave_to_port(dev);
+	u8 tag_dev, tag_port;
+	enum dsa_cmd cmd;
 	u8 *dsa_header;
+	u16 pvid = 0;
+	int err;
+
+	if (skb->offload_fwd_mark) {
+		struct dsa_switch_tree *dst = dp->ds->dst;
+		struct net_device *br = dp->bridge_dev;
+
+		cmd = DSA_CMD_FORWARD;
+
+		/* When offloading forwarding for a bridge, inject FORWARD
+		 * packets on behalf of a virtual switch device with an index
+		 * past the physical switches.
+		 */
+		tag_dev = dst->last_switch + 1 + dp->bridge_num;
+		tag_port = 0;
+
+		/* If we are offloading forwarding for a VLAN-unaware bridge,
+		 * inject packets to hardware using the bridge's pvid, since
+		 * that's where the packets ingressed from.
+		 */
+		if (!br_vlan_enabled(br)) {
+			/* Safe because __dev_queue_xmit() runs under
+			 * rcu_read_lock_bh()
+			 */
+			err = br_vlan_get_pvid_rcu(br, &pvid);
+			if (err)
+				return NULL;
+		}
+	} else {
+		cmd = DSA_CMD_FROM_CPU;
+		tag_dev = dp->ds->index;
+		tag_port = dp->index;
+	}
 
 	if (skb->protocol == htons(ETH_P_8021Q)) {
 		if (extra) {
@@ -134,10 +169,10 @@ static struct sk_buff *dsa_xmit_ll(struct sk_buff *skb, struct net_device *dev,
 			memmove(skb->data, skb->data + extra, 2 * ETH_ALEN);
 		}
 
-		/* Construct tagged FROM_CPU DSA tag from 802.1Q tag. */
+		/* Construct tagged DSA tag from 802.1Q tag. */
 		dsa_header = skb->data + 2 * ETH_ALEN + extra;
-		dsa_header[0] = (DSA_CMD_FROM_CPU << 6) | 0x20 | dp->ds->index;
-		dsa_header[1] = dp->index << 3;
+		dsa_header[0] = (cmd << 6) | 0x20 | tag_dev;
+		dsa_header[1] = tag_port << 3;
 
 		/* Move CFI field from byte 2 to byte 1. */
 		if (dsa_header[2] & 0x10) {
@@ -148,12 +183,13 @@ static struct sk_buff *dsa_xmit_ll(struct sk_buff *skb, struct net_device *dev,
 		skb_push(skb, DSA_HLEN + extra);
 		memmove(skb->data, skb->data + DSA_HLEN + extra, 2 * ETH_ALEN);
 
-		/* Construct untagged FROM_CPU DSA tag. */
+		/* Construct untagged DSA tag. */
 		dsa_header = skb->data + 2 * ETH_ALEN + extra;
-		dsa_header[0] = (DSA_CMD_FROM_CPU << 6) | dp->ds->index;
-		dsa_header[1] = dp->index << 3;
-		dsa_header[2] = 0x00;
-		dsa_header[3] = 0x00;
+
+		dsa_header[0] = (cmd << 6) | tag_dev;
+		dsa_header[1] = tag_port << 3;
+		dsa_header[2] = pvid >> 8;
+		dsa_header[3] = pvid & 0xff;
 	}
 
 	return skb;
-- 
2.25.1

