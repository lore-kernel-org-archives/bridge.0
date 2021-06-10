Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OHs+5yapG1eHIgZGuzyj7K/JjrXGKBa3D/k+j6h/h8k=;
 b=bzshpus1Tg6X0zN0cY6Fa23oCQq8kf/CmBfNQgHl+CWbazGST9PmfBqX1tlV4zc6Xf
 1W3uO3bebMb9PqtCVMpo6KUtl0MDSJ8UGHZiEplDapH2JLGt3BbjS3FCqxyLKcA63ma0
 AN7/gxLXP+rTgWWmLEzsrIUXkmagqUc3g44KyzkVrZDQLXuAcaLZ/9otMUQnkZm7ZsfA
 84rgd6WZZA3s1jSXW7JBsHVnOHsejmd/oK+DV4liQIhuwJxreTmCL9/m75UeKPxeKPP5
 IjrfOKCiuhfxciBi/02Jn1thKuOu1nMQ8Vpysnuk9U76Ud1u2G/hutcqYpmgA4K8uCxV
 tgXw==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Thu, 10 Jun 2021 13:45:36 +0300
Message-Id: <20210610104537.119538-2-razor@blackwall.org>
In-Reply-To: <20210610104537.119538-1-razor@blackwall.org>
References: <20210610104537.119538-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net 1/2] net: bridge: fix vlan tunnel dst null
	pointer dereference
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@nvidia.com>, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

This patch fixes a tunnel_dst null pointer dereference due to lockless
access in the tunnel egress path. When deleting a vlan tunnel the
tunnel_dst pointer is set to NULL without waiting a grace period (i.e.
while it's still usable) and packets egressing are dereferencing it
without checking. Use READ/WRITE_ONCE to annotate the lockless use of
tunnel_id, use RCU for accessing tunnel_dst and make sure it is read
only once and checked in the egress path. The dst is already properly RCU
protected so we don't need to do anything fancy than to make sure
tunnel_id and tunnel_dst are read only once and checked in the egress path.

Fixes: 11538d039ac6 ("bridge: vlan dst_metadata hooks in ingress and egress paths")
Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
---
 net/bridge/br_private.h     |  4 ++--
 net/bridge/br_vlan_tunnel.c | 38 +++++++++++++++++++++++--------------
 2 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 7ce8a77cc6b6..e013d33f1c7c 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -90,8 +90,8 @@ struct bridge_mcast_stats {
 #endif
 
 struct br_tunnel_info {
-	__be64			tunnel_id;
-	struct metadata_dst	*tunnel_dst;
+	__be64				tunnel_id;
+	struct metadata_dst __rcu	*tunnel_dst;
 };
 
 /* private vlan flags */
diff --git a/net/bridge/br_vlan_tunnel.c b/net/bridge/br_vlan_tunnel.c
index 0d3a8c01552e..03de461a0d44 100644
--- a/net/bridge/br_vlan_tunnel.c
+++ b/net/bridge/br_vlan_tunnel.c
@@ -41,26 +41,33 @@ static struct net_bridge_vlan *br_vlan_tunnel_lookup(struct rhashtable *tbl,
 				      br_vlan_tunnel_rht_params);
 }
 
+static void vlan_tunnel_info_release(struct net_bridge_vlan *vlan)
+{
+	struct metadata_dst *tdst = rtnl_dereference(vlan->tinfo.tunnel_dst);
+
+	WRITE_ONCE(vlan->tinfo.tunnel_id, 0);
+	RCU_INIT_POINTER(vlan->tinfo.tunnel_dst, NULL);
+	dst_release(&tdst->dst);
+}
+
 void vlan_tunnel_info_del(struct net_bridge_vlan_group *vg,
 			  struct net_bridge_vlan *vlan)
 {
-	if (!vlan->tinfo.tunnel_dst)
+	if (!rcu_access_pointer(vlan->tinfo.tunnel_dst))
 		return;
 	rhashtable_remove_fast(&vg->tunnel_hash, &vlan->tnode,
 			       br_vlan_tunnel_rht_params);
-	vlan->tinfo.tunnel_id = 0;
-	dst_release(&vlan->tinfo.tunnel_dst->dst);
-	vlan->tinfo.tunnel_dst = NULL;
+	vlan_tunnel_info_release(vlan);
 }
 
 static int __vlan_tunnel_info_add(struct net_bridge_vlan_group *vg,
 				  struct net_bridge_vlan *vlan, u32 tun_id)
 {
-	struct metadata_dst *metadata = NULL;
+	struct metadata_dst *metadata = rtnl_dereference(vlan->tinfo.tunnel_dst);
 	__be64 key = key32_to_tunnel_id(cpu_to_be32(tun_id));
 	int err;
 
-	if (vlan->tinfo.tunnel_dst)
+	if (metadata)
 		return -EEXIST;
 
 	metadata = __ip_tun_set_dst(0, 0, 0, 0, 0, TUNNEL_KEY,
@@ -69,8 +76,8 @@ static int __vlan_tunnel_info_add(struct net_bridge_vlan_group *vg,
 		return -EINVAL;
 
 	metadata->u.tun_info.mode |= IP_TUNNEL_INFO_TX | IP_TUNNEL_INFO_BRIDGE;
-	vlan->tinfo.tunnel_dst = metadata;
-	vlan->tinfo.tunnel_id = key;
+	rcu_assign_pointer(vlan->tinfo.tunnel_dst, metadata);
+	WRITE_ONCE(vlan->tinfo.tunnel_id, key);
 
 	err = rhashtable_lookup_insert_fast(&vg->tunnel_hash, &vlan->tnode,
 					    br_vlan_tunnel_rht_params);
@@ -79,9 +86,7 @@ static int __vlan_tunnel_info_add(struct net_bridge_vlan_group *vg,
 
 	return 0;
 out:
-	dst_release(&vlan->tinfo.tunnel_dst->dst);
-	vlan->tinfo.tunnel_dst = NULL;
-	vlan->tinfo.tunnel_id = 0;
+	vlan_tunnel_info_release(vlan);
 
 	return err;
 }
@@ -182,12 +187,15 @@ int br_handle_ingress_vlan_tunnel(struct sk_buff *skb,
 int br_handle_egress_vlan_tunnel(struct sk_buff *skb,
 				 struct net_bridge_vlan *vlan)
 {
+	struct metadata_dst *tunnel_dst;
+	__be64 tunnel_id;
 	int err;
 
-	if (!vlan || !vlan->tinfo.tunnel_id)
+	if (!vlan)
 		return 0;
 
-	if (unlikely(!skb_vlan_tag_present(skb)))
+	tunnel_id = READ_ONCE(vlan->tinfo.tunnel_id);
+	if (!tunnel_id || unlikely(!skb_vlan_tag_present(skb)))
 		return 0;
 
 	skb_dst_drop(skb);
@@ -195,7 +203,9 @@ int br_handle_egress_vlan_tunnel(struct sk_buff *skb,
 	if (err)
 		return err;
 
-	skb_dst_set(skb, dst_clone(&vlan->tinfo.tunnel_dst->dst));
+	tunnel_dst = rcu_dereference(vlan->tinfo.tunnel_dst);
+	if (tunnel_dst)
+		skb_dst_set(skb, dst_clone(&tunnel_dst->dst));
 
 	return 0;
 }
-- 
2.31.1

