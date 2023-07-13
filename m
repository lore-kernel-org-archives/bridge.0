Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6755781EEA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A370883BA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atm9CGpPjeRFLS/syFuSAHEqrZlKZkYjuFPtkoz3LPo=;
 b=MqHn1VqPIZ8oDwFZfM4H36gxVEHGtNiWzTN05W2c+PIC3WW03MAZoWdj4eKHvfLDemC9HZNf09vcT6tLAsjnxrOXlrJG4mGGJQ0DDvrZ4cKKP1BPqb8TtKoEp6O0/pfOPDXZ5cHHKi8hZuPXF3EN2zQQA4PObG8KNTSf+f03g5NQvUfA8k6mB0wfYr7esUEBye57Rs8wbWbElAP1XhoKJpLtaQziXu5sSVA0O39k69GEG/jke821e/l6a76ry1KbxdjCdZd3dOHHmxmclW3nWSjOL3CyrpsMcKBb4VtgUo4UguUTVBgZrQrdAsMNvYHE3w8TIsFtSFhP2TITCoT5yQ==
From: Ido Schimmel <idosch@nvidia.com>
Date: Thu, 13 Jul 2023 10:09:23 +0300
Message-ID: <20230713070925.3955850-3-idosch@nvidia.com>
In-Reply-To: <20230713070925.3955850-1-idosch@nvidia.com>
References: <20230713070925.3955850-1-idosch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [RFC PATCH net-next 2/4] vxlan: Add support for nexthop ID
	metadata
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, taspelund@nvidia.com, Ido Schimmel <idosch@nvidia.com>, razor@blackwall.org, dsahern@gmail.com, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

VXLAN FDB entries can point to FDB nexthop objects. Each such object
includes the IP address(es) of remote VTEP(s) via which the target host
is accessible. Example:

 # ip nexthop add id 1 via 192.0.2.1 fdb
 # ip nexthop add id 2 via 192.0.2.17 fdb
 # ip nexthop add id 1000 group 1/2 fdb
 # bridge fdb add 00:11:22:33:44:55 dev vx0 self static nhid 1000 src_vni 10020

This is useful for EVPN multihoming where a single host can be connected
to multiple VTEPs. The source VTEP will calculate the flow hash of the
skb and forward it towards the IP address of one of the VTEPs member in
the nexthop group.

There are cases where an external entity (e.g., the bridge driver) can
provide not only the tunnel ID (i.e., VNI) of the skb, but also the ID
of the nexthop object via which the skb should be forwarded.

Therefore, in order to support such cases, when the VXLAN device is in
external / collect metadata mode and the tunnel info attached to the skb
is of bridge type, extract the nexthop ID from the tunnel info. If the
ID is valid (i.e., non-zero), forward the skb via the nexthop object
associated with the ID, as if the skb hit an FDB entry associated with
this ID.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c | 44 ++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 78744549c1b3..10a4dbd50710 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2672,6 +2672,45 @@ static void vxlan_xmit_nh(struct sk_buff *skb, struct net_device *dev,
 	dev_kfree_skb(skb);
 }
 
+static netdev_tx_t vxlan_xmit_nhid(struct sk_buff *skb, struct net_device *dev,
+				   u32 nhid, __be32 vni)
+{
+	struct vxlan_dev *vxlan = netdev_priv(dev);
+	struct vxlan_rdst nh_rdst;
+	struct nexthop *nh;
+	bool do_xmit;
+	u32 hash;
+
+	memset(&nh_rdst, 0, sizeof(struct vxlan_rdst));
+	hash = skb_get_hash(skb);
+
+	rcu_read_lock();
+	nh = nexthop_find_by_id(dev_net(dev), nhid);
+	if (unlikely(!nh || !nexthop_is_fdb(nh) || !nexthop_is_multipath(nh))) {
+		rcu_read_unlock();
+		goto drop;
+	}
+	do_xmit = vxlan_fdb_nh_path_select(nh, hash, &nh_rdst);
+	rcu_read_unlock();
+
+	if (vxlan->cfg.saddr.sa.sa_family != nh_rdst.remote_ip.sa.sa_family)
+		goto drop;
+
+	if (likely(do_xmit))
+		vxlan_xmit_one(skb, dev, vni, &nh_rdst, false);
+	else
+		goto drop;
+
+	return NETDEV_TX_OK;
+
+drop:
+	dev->stats.tx_dropped++;
+	vxlan_vnifilter_count(netdev_priv(dev), vni, NULL,
+			      VXLAN_VNI_STATS_TX_DROPS, 0);
+	dev_kfree_skb(skb);
+	return NETDEV_TX_OK;
+}
+
 /* Transmit local packets over Vxlan
  *
  * Outer IP header inherits ECN and DF from inner header.
@@ -2687,6 +2726,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct vxlan_fdb *f;
 	struct ethhdr *eth;
 	__be32 vni = 0;
+	u32 nhid = 0;
 
 	info = skb_tunnel_info(skb);
 
@@ -2696,6 +2736,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 		if (info && info->mode & IP_TUNNEL_INFO_BRIDGE &&
 		    info->mode & IP_TUNNEL_INFO_TX) {
 			vni = tunnel_id_to_key32(info->key.tun_id);
+			nhid = info->key.nhid;
 		} else {
 			if (info && info->mode & IP_TUNNEL_INFO_TX)
 				vxlan_xmit_one(skb, dev, vni, NULL, false);
@@ -2723,6 +2764,9 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 #endif
 	}
 
+	if (nhid)
+		return vxlan_xmit_nhid(skb, dev, nhid, vni);
+
 	if (vxlan->cfg.flags & VXLAN_F_MDB) {
 		struct vxlan_mdb_entry *mdb_entry;
 
-- 
2.40.1

