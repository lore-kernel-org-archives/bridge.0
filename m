Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EDDB681454
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 18A378143C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3U0gVe0IZp8tb/PBmr/db2c4m/Qqc+y3KMkhyWl8Pb4=;
 b=dD30uOvtgcboI6ksNr7TUMMsbNCzlt5uIstkhUrO6oWaD+vOhFlWT8Bj+PTH+Lprjndn5rfRrzp4aEtmwUlHHTdAn/qDQEq+Ua4mfPqXD3GHBWkutjzj4P3x7OSvn3/Yb36HgfkPubaMuMJTI6dchKm452xdtGOpT3lAEZ33Vw5VhYV4guAryeADz437Rc9AttELQ5keu1ela6zCiCg8UouPaQc/cC5Qdx474/EwEvevfL66yS8R+Ju/YDTgacQv0KE/1wLSpQTeTH/JtzA4NRUo3F0r2XbAcv/AKFS7o5AFRsyJVRnuf4hmQ6TC9jp8SIDQxPRjYprhh0b51Smh6A==
From: Ido Schimmel <idosch@nvidia.com>
Date: Thu, 18 May 2023 14:33:24 +0300
Message-ID: <20230518113328.1952135-2-idosch@nvidia.com>
In-Reply-To: <20230518113328.1952135-1-idosch@nvidia.com>
References: <20230518113328.1952135-1-idosch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 1/5] skbuff: bridge: Add layer 2 miss
	indication
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: taras.chornyi@plvision.eu, petrm@nvidia.com, alexandre.belloni@bootlin.com, jiri@resnulli.us, taspelund@nvidia.com, leon@kernel.org, vladimir.oltean@nxp.com, razor@blackwall.org, claudiu.manoil@nxp.com, Ido Schimmel <idosch@nvidia.com>, UNGLinuxDriver@microchip.com, xiyou.wangcong@gmail.com, edumazet@google.com, jhs@mojatatu.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com, davem@davemloft.net

Allow the bridge driver to mark packets that did not match a layer 2
entry during forwarding by adding a 'l2_miss' bit to the skb.

Clear the bit whenever a packet enters the bridge (received from a
bridge port or transmitted via the bridge) and set it if the packet did
not match an FDB/MDB entry.

Subsequent patches will allow the flower classifier to match on this
bit. The motivating use case in non-DF (Designated Forwarder) filtering
where we would like to prevent decapsulated packets from being flooded
to a multi-homed host.

Do not allocate the bit if the kernel was not compiled with bridge
support and place it after the two bit fields in accordance with commit
4c60d04c2888 ("net: skbuff: push nf_trace down the bitfield"). The bit
does not increase the size of the structure as it is placed at an
existing hole. Layout with allmodconfig:

struct sk_buff {
[...]
			__u8       csum_not_inet:1;      /*   132: 3  1 */
			__u8       l2_miss:1;            /*   132: 4  1 */

			/* XXX 3 bits hole, try to pack */
			/* XXX 1 byte hole, try to pack */

			__u16      tc_index;             /*   134     2 */
			u16        alloc_cpu;            /*   136     2 */
[...]
} __attribute__((__aligned__(8)));

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/linux/skbuff.h  | 4 ++++
 net/bridge/br_device.c  | 1 +
 net/bridge/br_forward.c | 3 +++
 net/bridge/br_input.c   | 1 +
 4 files changed, 9 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 8cff3d817131..b64dc3f62c5c 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -801,6 +801,7 @@ typedef unsigned char *sk_buff_data_t;
  *	@encap_hdr_csum: software checksum is needed
  *	@csum_valid: checksum is already valid
  *	@csum_not_inet: use CRC32c to resolve CHECKSUM_PARTIAL
+ *	@l2_miss: Packet did not match an L2 entry during forwarding
  *	@csum_complete_sw: checksum was completed by software
  *	@csum_level: indicates the number of consecutive checksums found in
  *		the packet minus one that have been verified as
@@ -991,6 +992,9 @@ struct sk_buff {
 #if IS_ENABLED(CONFIG_IP_SCTP)
 	__u8			csum_not_inet:1;
 #endif
+#if IS_ENABLED(CONFIG_BRIDGE)
+	__u8			l2_miss:1;
+#endif
 
 #ifdef CONFIG_NET_SCHED
 	__u16			tc_index;	/* traffic control index */
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 8eca8a5c80c6..91dbdae4afd4 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -39,6 +39,7 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	u16 vid = 0;
 
 	memset(skb->cb, 0, sizeof(struct br_input_skb_cb));
+	skb->l2_miss = 0;
 
 	rcu_read_lock();
 	nf_ops = rcu_dereference(nf_br_ops);
diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 84d6dd5e5b1a..8cf5a51489ce 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -203,6 +203,8 @@ void br_flood(struct net_bridge *br, struct sk_buff *skb,
 	struct net_bridge_port *prev = NULL;
 	struct net_bridge_port *p;
 
+	skb->l2_miss = 1;
+
 	list_for_each_entry_rcu(p, &br->port_list, list) {
 		/* Do not flood unicast traffic to ports that turn it off, nor
 		 * other traffic if flood off, except for traffic we originate
@@ -295,6 +297,7 @@ void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
 			allow_mode_include = false;
 	} else {
 		p = NULL;
+		skb->l2_miss = 1;
 	}
 
 	while (p || rp) {
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index fc17b9fd93e6..d8ab5890cbe6 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -334,6 +334,7 @@ static rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
 		return RX_HANDLER_CONSUMED;
 
 	memset(skb->cb, 0, sizeof(struct br_input_skb_cb));
+	skb->l2_miss = 0;
 
 	p = br_port_get_rcu(skb->dev);
 	if (p->flags & BR_VLAN_TUNNEL)
-- 
2.40.1

