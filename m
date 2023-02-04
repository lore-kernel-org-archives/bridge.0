Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E8CAF41D21
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5575841CBE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9vIZfjeNZjPD//rZ4qABhtrQ7NtCZ56VecAMZrz9uA=;
 b=As65JTzj0hOGgQ/wNH+kEpiKtLB8bX9DYKqV/aVUrVsPwEkadiFmf/mmRZqEz1nb9a4C0oSLsMhq+yTjFT0izlIKKZcneWewzSnMQoFnP8x8wwVL3nHXgEqBc34h8L5VOjLNvk5cgtap3zMq1oFY9otb2EyjuYZncd9znDa2kpgT4IpsR7gOnRAZsEyD0dKCsMzuML2rocAp3wZ83itYbVOqrj/dRpiwpJYUgU8bd99U1d9xTyGXf8fPFb8Si1JDO6PmCbjWaQjoqMh+UlhTOaZlWZdm2+gMBFVPDRv2pUf/K7na4m9vZDB8cGaXpz6YemLDvrm/CaOO0ZGeQz6Ljw==
From: Ido Schimmel <idosch@nvidia.com>
Date: Sat,  4 Feb 2023 19:08:00 +0200
Message-Id: <20230204170801.3897900-13-idosch@nvidia.com>
In-Reply-To: <20230204170801.3897900-1-idosch@nvidia.com>
References: <20230204170801.3897900-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Bridge] [RFC PATCH net-next 12/13] vxlan: Add MDB data path support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, mlxsw@nvidia.com, razor@blackwall.org, Ido Schimmel <idosch@nvidia.com>, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

Integrate MDB support into the Tx path of the VXLAN driver, allowing it
to selectively forward IP multicast traffic according to the matched MDB
entry.

If MDB entries are configured (i.e., 'VXLAN_F_MDB' is set) and the
packet is an IP multicast packet, perform up to three different lookups
according to the following priority:

1. For an (S, G) entry, using {Source VNI, Source IP, Destination IP}.
2. For a (*, G) entry, using {Source VNI, Destination IP}.
3. For the catchall MDB entry (0.0.0.0 or ::), using the source VNI.

The catchall MDB entry is similar to the catchall FDB entry
(00:00:00:00:00:00) that is currently used to transmit BUM (broadcast,
unknown unicast and multicast) traffic. However, unlike the catchall FDB
entry, this entry is only used to transmit unregistered IP multicast
traffic that is not link-local. Therefore, when configured, the catchall
FDB entry will only transmit BULL (broadcast, unknown unicast,
link-local multicast) traffic.

The catchall MDB entry is useful in deployments where inter-subnet
multicast forwarding is used and not all the VTEPs in a tenant domain
are members in all the broadcast domains. In such deployments it is
advantageous to transmit BULL (broadcast, unknown unicast and link-local
multicast) and unregistered IP multicast traffic on different tunnels.
If the same tunnel was used, a VTEP only interested in IP multicast
traffic would also pull all the BULL traffic and drop it as it is not a
member in the originating broadcast domain [1].

If the packet did not match an MDB entry (or if the packet is not an IP
multicast packet), return it to the Tx path, allowing it to be forwarded
according to the FDB.

If the packet did match an MDB entry, forward it to the associated
remote VTEPs. However, if the entry is a (*, G) entry and the associated
remote is in INCLUDE mode, then skip over it as the source IP is not in
its source list (otherwise the packet would have matched on an (S, G)
entry). Similarly, if the associated remote is marked as BLOCKED (can
only be set on (S, G) entries), then skip over it as well as the remote
is in EXCLUDE mode and the source IP is in its source list.

[1] https://datatracker.ietf.org/doc/html/draft-ietf-bess-evpn-irb-mcast#section-2.6

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c    |  15 ++++
 drivers/net/vxlan/vxlan_mdb.c     | 114 ++++++++++++++++++++++++++++++
 drivers/net/vxlan/vxlan_private.h |   6 ++
 3 files changed, 135 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 1c98ddd38bc4..1e55c5582e67 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2743,6 +2743,21 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 #endif
 	}
 
+	if (vxlan->cfg.flags & VXLAN_F_MDB) {
+		struct vxlan_mdb_entry *mdb_entry;
+
+		rcu_read_lock();
+		mdb_entry = vxlan_mdb_entry_skb_get(vxlan, skb, vni);
+		if (mdb_entry) {
+			netdev_tx_t ret;
+
+			ret = vxlan_mdb_xmit(vxlan, mdb_entry, skb);
+			rcu_read_unlock();
+			return ret;
+		}
+		rcu_read_unlock();
+	}
+
 	eth = eth_hdr(skb);
 	f = vxlan_find_mac(vxlan, eth->h_dest, vni);
 	did_rsc = false;
diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
index 72c922064c02..34ffd77cd466 100644
--- a/drivers/net/vxlan/vxlan_mdb.c
+++ b/drivers/net/vxlan/vxlan_mdb.c
@@ -1320,6 +1320,120 @@ int vxlan_mdb_del(struct net_device *dev, struct nlattr *tb[],
 	return err;
 }
 
+struct vxlan_mdb_entry *vxlan_mdb_entry_skb_get(struct vxlan_dev *vxlan,
+						struct sk_buff *skb,
+						__be32 src_vni)
+{
+	struct vxlan_mdb_entry *mdb_entry;
+	struct vxlan_mdb_entry_key group;
+
+	if (!is_multicast_ether_addr(eth_hdr(skb)->h_dest) ||
+	    is_broadcast_ether_addr(eth_hdr(skb)->h_dest))
+		return NULL;
+
+	/* When not in collect metadata mode, 'src_vni' is zero, but MDB
+	 * entries are stored with the VNI of the VXLAN device.
+	 */
+	if (!(vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA))
+		src_vni = vxlan->default_dst.remote_vni;
+
+	memset(&group, 0, sizeof(group));
+	group.vni = src_vni;
+
+	switch (ntohs(skb->protocol)) {
+	case ETH_P_IP:
+		if (!pskb_may_pull(skb, sizeof(struct iphdr)))
+			return NULL;
+		group.dst.sa.sa_family = AF_INET;
+		group.dst.sin.sin_addr.s_addr = ip_hdr(skb)->daddr;
+		group.src.sa.sa_family = AF_INET;
+		group.src.sin.sin_addr.s_addr = ip_hdr(skb)->saddr;
+		break;
+#if IS_ENABLED(CONFIG_IPV6)
+	case ETH_P_IPV6:
+		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
+			return NULL;
+		group.dst.sa.sa_family = AF_INET6;
+		group.dst.sin6.sin6_addr = ipv6_hdr(skb)->daddr;
+		group.src.sa.sa_family = AF_INET6;
+		group.src.sin6.sin6_addr = ipv6_hdr(skb)->saddr;
+		break;
+#endif
+	default:
+		return NULL;
+	}
+
+	mdb_entry = vxlan_mdb_entry_lookup(vxlan, &group);
+	if (mdb_entry)
+		return mdb_entry;
+
+	memset(&group.src, 0, sizeof(group.src));
+	mdb_entry = vxlan_mdb_entry_lookup(vxlan, &group);
+	if (mdb_entry)
+		return mdb_entry;
+
+	/* No (S, G) or (*, G) found. Look up the all-zeros entry, but only if
+	 * the destination IP address is not link-local multicast since we want
+	 * to transmit such traffic together with broadcast and unknown unicast
+	 * traffic.
+	 */
+	switch (ntohs(skb->protocol)) {
+	case ETH_P_IP:
+		if (ipv4_is_local_multicast(group.dst.sin.sin_addr.s_addr))
+			return NULL;
+		group.dst.sin.sin_addr.s_addr = 0;
+		break;
+#if IS_ENABLED(CONFIG_IPV6)
+	case ETH_P_IPV6:
+		if (ipv6_addr_type(&group.dst.sin6.sin6_addr) &
+		    IPV6_ADDR_LINKLOCAL)
+			return NULL;
+		memset(&group.dst.sin6.sin6_addr, 0,
+		       sizeof(group.dst.sin6.sin6_addr));
+		break;
+#endif
+	default:
+		return NULL;
+	}
+
+	return vxlan_mdb_entry_lookup(vxlan, &group);
+}
+
+netdev_tx_t vxlan_mdb_xmit(struct vxlan_dev *vxlan,
+			   const struct vxlan_mdb_entry *mdb_entry,
+			   struct sk_buff *skb)
+{
+	struct vxlan_mdb_remote *remote, *fremote = NULL;
+	__be32 src_vni = mdb_entry->key.vni;
+
+	list_for_each_entry_rcu(remote, &mdb_entry->remotes, list) {
+		struct sk_buff *skb1;
+
+		if ((vxlan_mdb_is_star_g(&mdb_entry->key) &&
+		     READ_ONCE(remote->filter_mode) == MCAST_INCLUDE) ||
+		    (READ_ONCE(remote->flags) & VXLAN_MDB_REMOTE_F_BLOCKED))
+			continue;
+
+		if (!fremote) {
+			fremote = remote;
+			continue;
+		}
+
+		skb1 = skb_clone(skb, GFP_ATOMIC);
+		if (skb1)
+			vxlan_xmit_one(skb1, vxlan->dev, src_vni,
+				       rcu_dereference(remote->rd), false);
+	}
+
+	if (fremote)
+		vxlan_xmit_one(skb, vxlan->dev, src_vni,
+			       rcu_dereference(fremote->rd), false);
+	else
+		kfree_skb(skb);
+
+	return NETDEV_TX_OK;
+}
+
 static void vxlan_mdb_check_empty(void *ptr, void *arg)
 {
 	WARN_ON_ONCE(1);
diff --git a/drivers/net/vxlan/vxlan_private.h b/drivers/net/vxlan/vxlan_private.h
index 7bcc38faae27..817fa3075842 100644
--- a/drivers/net/vxlan/vxlan_private.h
+++ b/drivers/net/vxlan/vxlan_private.h
@@ -235,6 +235,12 @@ int vxlan_mdb_add(struct net_device *dev, struct nlattr *tb[], u16 nlmsg_flags,
 		  struct netlink_ext_ack *extack);
 int vxlan_mdb_del(struct net_device *dev, struct nlattr *tb[],
 		  struct netlink_ext_ack *extack);
+struct vxlan_mdb_entry *vxlan_mdb_entry_skb_get(struct vxlan_dev *vxlan,
+						struct sk_buff *skb,
+						__be32 src_vni);
+netdev_tx_t vxlan_mdb_xmit(struct vxlan_dev *vxlan,
+			   const struct vxlan_mdb_entry *mdb_entry,
+			   struct sk_buff *skb);
 int vxlan_mdb_init(struct vxlan_dev *vxlan);
 void vxlan_mdb_fini(struct vxlan_dev *vxlan);
 #endif
-- 
2.37.3

