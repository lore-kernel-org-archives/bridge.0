Return-Path: <vladimir.oltean@nxp.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DduN+q9h+tIBuMlP1SW0pq2bUKwwt+2igei15Vdqnek=;
 b=h1R8WAbjiWvWq25/oggMOeUnCjqHWODUSRzmUj2aS7Pwk0PDOiTwzdc4bL27Mcsy09WBLtnoRHLDf3uF5pYHtMr8GusObDT21jeh7Up21r1RMQxt2svnZxp7DHtKUuvmYXc1buS1IARGL53Sghl5VCxO2qIqXN6ZKIhRiZB7qL4=
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Sat,  3 Jul 2021 14:57:05 +0300
Message-Id: <20210703115705.1034112-11-vladimir.oltean@nxp.com>
In-Reply-To: <20210703115705.1034112-1-vladimir.oltean@nxp.com>
References: <20210703115705.1034112-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH v2 net-next 10/10] net: dsa: tag_dsa: offload
	the bridge forwarding process
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, bridge@lists.linux-foundation.org, Alexander Duyck <alexander.duyck@gmail.com>, Ido Schimmel <idosch@idosch.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>

From: Tobias Waldekranz <tobias@waldekranz.com>

Allow the DSA tagger to generate FORWARD frames for offloaded skbs
sent from a bridge that we offload, allowing the switch to handle any
frame replication that may be required. This also means that source
address learning takes place on packets sent from the CPU, meaning
that return traffic no longer needs to be flooded as unknown unicast.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/dsa_priv.h | 11 +++++++++
 net/dsa/tag_dsa.c  | 60 +++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 63 insertions(+), 8 deletions(-)

diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
index c577338b5bb7..c070157cd967 100644
--- a/net/dsa/dsa_priv.h
+++ b/net/dsa/dsa_priv.h
@@ -389,6 +389,17 @@ static inline struct sk_buff *dsa_untag_bridge_pvid(struct sk_buff *skb)
 	return skb;
 }
 
+static inline struct net_device *
+dsa_slave_get_sb_dev(const struct net_device *dev, struct sk_buff *skb)
+{
+	u16 queue_mapping = skb_get_queue_mapping(skb);
+	struct netdev_queue *txq;
+
+	txq = netdev_get_tx_queue(dev, queue_mapping);
+
+	return txq->sb_dev;
+}
+
 /* switch.c */
 int dsa_switch_register_notifier(struct dsa_switch *ds);
 void dsa_switch_unregister_notifier(struct dsa_switch *ds);
diff --git a/net/dsa/tag_dsa.c b/net/dsa/tag_dsa.c
index a822355afc90..9151ed141b3e 100644
--- a/net/dsa/tag_dsa.c
+++ b/net/dsa/tag_dsa.c
@@ -125,8 +125,49 @@ enum dsa_code {
 static struct sk_buff *dsa_xmit_ll(struct sk_buff *skb, struct net_device *dev,
 				   u8 extra)
 {
+	struct net_device *sb_dev = dsa_slave_get_sb_dev(dev, skb);
 	struct dsa_port *dp = dsa_slave_to_port(dev);
+	u8 tag_dev, tag_port;
+	enum dsa_cmd cmd;
 	u8 *dsa_header;
+	u16 pvid = 0;
+	int err;
+
+	if (sb_dev) {
+		/* Don't bother finding the accel_priv corresponding with this
+		 * subordinate device, we know it's the bridge becase we can't
+		 * offload anything else, so just search for it under the port,
+		 * we know it's the same.
+		 */
+		struct dsa_bridge_fwd_accel_priv *accel_priv = dp->accel_priv;
+		struct dsa_switch_tree *dst = dp->ds->dst;
+
+		cmd = DSA_CMD_FORWARD;
+
+		/* When offloading forwarding for a bridge, inject FORWARD
+		 * packets on behalf of a virtual switch device with an index
+		 * past the physical switches.
+		 */
+		tag_dev = dst->last_switch + 1 + accel_priv->bridge_num;
+		tag_port = 0;
+
+		/* If we are offloading forwarding for a VLAN-unaware bridge,
+		 * inject packets to hardware using the bridge's pvid, since
+		 * that's where the packets ingressed from.
+		 */
+		if (!br_vlan_enabled(sb_dev)) {
+			/* Safe because __dev_queue_xmit() runs under
+			 * rcu_read_lock_bh()
+			 */
+			err = br_vlan_get_pvid_rcu(sb_dev, &pvid);
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
@@ -134,10 +175,10 @@ static struct sk_buff *dsa_xmit_ll(struct sk_buff *skb, struct net_device *dev,
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
@@ -148,12 +189,13 @@ static struct sk_buff *dsa_xmit_ll(struct sk_buff *skb, struct net_device *dev,
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
@@ -304,6 +346,7 @@ static const struct dsa_device_ops dsa_netdev_ops = {
 	.xmit	  = dsa_xmit,
 	.rcv	  = dsa_rcv,
 	.needed_headroom = DSA_HLEN,
+	.bridge_fwd_offload = true,
 };
 
 DSA_TAG_DRIVER(dsa_netdev_ops);
@@ -347,6 +390,7 @@ static const struct dsa_device_ops edsa_netdev_ops = {
 	.xmit	  = edsa_xmit,
 	.rcv	  = edsa_rcv,
 	.needed_headroom = EDSA_HLEN,
+	.bridge_fwd_offload = true,
 };
 
 DSA_TAG_DRIVER(edsa_netdev_ops);
-- 
2.25.1

