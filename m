Return-Path: <wenxu@ucloud.cn>
From: wenxu@ucloud.cn
Date: Sat,  6 Jul 2019 22:15:49 +0800
Message-Id: <1562422552-26065-2-git-send-email-wenxu@ucloud.cn>
In-Reply-To: <1562422552-26065-1-git-send-email-wenxu@ucloud.cn>
References: <1562422552-26065-1-git-send-email-wenxu@ucloud.cn>
Subject: [Bridge] [PATCH 2/5 nf-next v4] netfilter:nf_flow_table: Separate
	inet operation to single function
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: pablo@netfilter.org, nikolay@cumulusnetworks.com, fw@strlen.de
Cc: bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

This patch separate the inet family operation to single function.
Prepare for supporting  the bridge family.

Signed-off-by: wenxu <wenxu@ucloud.cn>
---
 net/netfilter/nf_flow_table_core.c | 52 ++++++++++++++++++++++++++++----------
 net/netfilter/nf_flow_table_ip.c   | 34 +++++++++++++++----------
 2 files changed, 59 insertions(+), 27 deletions(-)

diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index 7e0b5bd..2bec409 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -22,6 +22,20 @@ struct flow_offload_entry {
 static DEFINE_MUTEX(flowtable_lock);
 static LIST_HEAD(flowtables);
 
+static struct dst_entry *
+flow_offload_fill_inet_dst(struct flow_offload_tuple *ft,
+			   struct nf_flow_route *route,
+			   enum flow_offload_tuple_dir dir)
+{
+	struct dst_entry *other_dst = route->tuple[!dir].dst;
+	struct dst_entry *dst = route->tuple[dir].dst;
+
+	ft->iifidx = other_dst->dev->ifindex;
+	ft->dst.dst_cache = dst;
+
+	return dst;
+}
+
 static void
 flow_offload_fill_dir(struct flow_offload *flow, struct nf_conn *ct,
 		      struct nf_flow_dst *flow_dst,
@@ -29,9 +43,9 @@ struct flow_offload_entry {
 {
 	struct flow_offload_tuple *ft = &flow->tuplehash[dir].tuple;
 	struct nf_conntrack_tuple *ctt = &ct->tuplehash[dir].tuple;
-	struct dst_entry *other_dst = flow_dst->route.tuple[!dir].dst;
-	struct dst_entry *dst = flow_dst->route.tuple[dir].dst;
+	struct dst_entry *dst;
 
+	dst = flow_offload_fill_inet_dst(ft, &flow_dst->route, dir);
 	ft->dir = dir;
 
 	switch (ctt->src.l3num) {
@@ -51,9 +65,19 @@ struct flow_offload_entry {
 	ft->l4proto = ctt->dst.protonum;
 	ft->src_port = ctt->src.u.tcp.port;
 	ft->dst_port = ctt->dst.u.tcp.port;
+}
 
-	ft->iifidx = other_dst->dev->ifindex;
-	ft->dst_cache = dst;
+static int flow_offload_dst_hold(struct nf_flow_dst *flow_dst)
+{
+	if (!dst_hold_safe(flow_dst->route.tuple[FLOW_OFFLOAD_DIR_ORIGINAL].dst))
+		return -1;
+
+	if (!dst_hold_safe(flow_dst->route.tuple[FLOW_OFFLOAD_DIR_REPLY].dst)) {
+		dst_release(flow_dst->route.tuple[FLOW_OFFLOAD_DIR_ORIGINAL].dst);
+		return -1;
+	}
+
+	return 0;
 }
 
 struct flow_offload *
@@ -72,11 +96,8 @@ struct flow_offload *
 
 	flow = &entry->flow;
 
-	if (!dst_hold_safe(flow_dst->route.tuple[FLOW_OFFLOAD_DIR_ORIGINAL].dst))
-		goto err_dst_cache_original;
-
-	if (!dst_hold_safe(flow_dst->route.tuple[FLOW_OFFLOAD_DIR_REPLY].dst))
-		goto err_dst_cache_reply;
+	if (flow_offload_dst_hold(flow_dst))
+		goto err_dst_cache;
 
 	entry->ct = ct;
 
@@ -90,9 +111,7 @@ struct flow_offload *
 
 	return flow;
 
-err_dst_cache_reply:
-	dst_release(flow_dst->route.tuple[FLOW_OFFLOAD_DIR_ORIGINAL].dst);
-err_dst_cache_original:
+err_dst_cache:
 	kfree(entry);
 err_ct_refcnt:
 	nf_ct_put(ct);
@@ -135,12 +154,17 @@ static void flow_offload_fixup_ct_state(struct nf_conn *ct)
 	ct->timeout = nfct_time_stamp + timeout;
 }
 
+static void flow_offload_dst_release(struct flow_offload *flow)
+{
+	dst_release(flow->tuplehash[FLOW_OFFLOAD_DIR_ORIGINAL].tuple.dst.dst_cache);
+	dst_release(flow->tuplehash[FLOW_OFFLOAD_DIR_REPLY].tuple.dst.dst_cache);
+}
+
 void flow_offload_free(struct flow_offload *flow)
 {
 	struct flow_offload_entry *e;
 
-	dst_release(flow->tuplehash[FLOW_OFFLOAD_DIR_ORIGINAL].tuple.dst.dst_cache);
-	dst_release(flow->tuplehash[FLOW_OFFLOAD_DIR_REPLY].tuple.dst.dst_cache);
+	flow_offload_dst_release(flow);
 	e = container_of(flow, struct flow_offload_entry, flow);
 	if (flow->flags & FLOW_OFFLOAD_DYING)
 		nf_ct_delete(e->ct, 0, 0);
diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index 0016bb8..24263e2 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -214,6 +214,25 @@ static bool nf_flow_exceeds_mtu(const struct sk_buff *skb, unsigned int mtu)
 	return true;
 }
 
+static void nf_flow_inet_xmit(struct flow_offload *flow, struct sk_buff *skb,
+			      enum flow_offload_tuple_dir dir)
+{
+	struct net_device *outdev;
+	struct rtable *rt;
+	struct iphdr *iph;
+	__be32 nexthop;
+
+	rt = (struct rtable *)flow->tuplehash[dir].tuple.dst.dst_cache;
+	outdev = rt->dst.dev;
+	iph = ip_hdr(skb);
+	ip_decrease_ttl(iph);
+
+	skb->dev = outdev;
+	nexthop = rt_nexthop(rt, flow->tuplehash[!dir].tuple.src_v4.s_addr);
+	skb_dst_set_noref(skb, &rt->dst);
+	neigh_xmit(NEIGH_ARP_TABLE, outdev, &nexthop, skb);
+}
+
 unsigned int
 nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 			const struct nf_hook_state *state)
@@ -223,11 +242,7 @@ static bool nf_flow_exceeds_mtu(const struct sk_buff *skb, unsigned int mtu)
 	struct flow_offload_tuple tuple = {};
 	enum flow_offload_tuple_dir dir;
 	struct flow_offload *flow;
-	struct net_device *outdev;
-	struct rtable *rt;
 	unsigned int thoff;
-	struct iphdr *iph;
-	__be32 nexthop;
 
 	if (skb->protocol != htons(ETH_P_IP))
 		return NF_ACCEPT;
@@ -241,13 +256,11 @@ static bool nf_flow_exceeds_mtu(const struct sk_buff *skb, unsigned int mtu)
 
 	dir = tuplehash->tuple.dir;
 	flow = container_of(tuplehash, struct flow_offload, tuplehash[dir]);
-	rt = (struct rtable *)flow->tuplehash[dir].tuple.dst.dst_cache;
-	outdev = rt->dst.dev;
 
 	if (unlikely(nf_flow_exceeds_mtu(skb, flow->tuplehash[dir].tuple.mtu)))
 		return NF_ACCEPT;
 
-	if (skb_try_make_writable(skb, sizeof(*iph)))
+	if (skb_try_make_writable(skb, sizeof(struct iphdr)))
 		return NF_DROP;
 
 	thoff = ip_hdr(skb)->ihl * 4;
@@ -258,13 +271,8 @@ static bool nf_flow_exceeds_mtu(const struct sk_buff *skb, unsigned int mtu)
 		return NF_DROP;
 
 	flow->timeout = (u32)jiffies + NF_FLOW_TIMEOUT;
-	iph = ip_hdr(skb);
-	ip_decrease_ttl(iph);
 
-	skb->dev = outdev;
-	nexthop = rt_nexthop(rt, flow->tuplehash[!dir].tuple.src_v4.s_addr);
-	skb_dst_set_noref(skb, &rt->dst);
-	neigh_xmit(NEIGH_ARP_TABLE, outdev, &nexthop, skb);
+	nf_flow_inet_xmit(flow, skb, dir);
 
 	return NF_STOLEN;
 }
-- 
1.8.3.1

