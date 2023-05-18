Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8BB8560F65
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2230F607D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JC35ro7zE3aai5AM0voSy7JdBNhtLPukhKGob/b1U8=;
 b=PD5KM6M5a19NG6lbjWIAEmCx78V/0EddY/sUNx8BhAklWblxipqdfPhEK/f4/bj/N6gQh1lVra1d40PaP7ud4IzIJR5azEy6GTI6GOC3+lcZ13lAahuObMnTs3ymu7xsABto5t/j2gNd8XMdEWymi/VzKTIHhjC3ChPFyxBg5gOVT4bUVEU3LmnQxxJ/U3s+DXHa5eA5ucU4A+LpylSBXVeNlLXF9TS9ye6iyq9vezIxQJFdNBI1iYHn5T8X+heGYp7Xj5bsa+Oqyx0BRhHBajjRikU4gj7LLyMDRSsmj5fQ7sGX7MYU205yA0QUccf90+zq7hqH0HaLQs91vZ3pWA==
From: Ido Schimmel <idosch@nvidia.com>
Date: Thu, 18 May 2023 14:33:25 +0300
Message-ID: <20230518113328.1952135-3-idosch@nvidia.com>
In-Reply-To: <20230518113328.1952135-1-idosch@nvidia.com>
References: <20230518113328.1952135-1-idosch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next 2/5] net/sched: flower: Allow matching on
	layer 2 miss
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

Add the 'TCA_FLOWER_L2_MISS' netlink attribute that allows user space to
match on packets that encountered a layer 2 miss. The miss indication is
set as metadata in the skb by the bridge driver upon FDB/MDB lookup
miss.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/net/flow_dissector.h |  2 ++
 include/uapi/linux/pkt_cls.h |  2 ++
 net/core/flow_dissector.c    |  3 +++
 net/sched/cls_flower.c       | 14 ++++++++++++--
 4 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
index 85b2281576ed..8b41668c77fc 100644
--- a/include/net/flow_dissector.h
+++ b/include/net/flow_dissector.h
@@ -243,10 +243,12 @@ struct flow_dissector_key_ip {
  * struct flow_dissector_key_meta:
  * @ingress_ifindex: ingress ifindex
  * @ingress_iftype: ingress interface type
+ * @l2_miss: packet did not match an L2 entry during forwarding
  */
 struct flow_dissector_key_meta {
 	int ingress_ifindex;
 	u16 ingress_iftype;
+	u8 l2_miss;
 };
 
 /**
diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index 648a82f32666..00933dda7b10 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -594,6 +594,8 @@ enum {
 
 	TCA_FLOWER_KEY_L2TPV3_SID,	/* be32 */
 
+	TCA_FLOWER_L2_MISS,		/* u8 */
+
 	__TCA_FLOWER_MAX,
 };
 
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 25fb0bbc310f..3776c7bdd228 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -241,6 +241,9 @@ void skb_flow_dissect_meta(const struct sk_buff *skb,
 					 FLOW_DISSECTOR_KEY_META,
 					 target_container);
 	meta->ingress_ifindex = skb->skb_iif;
+#if IS_ENABLED(CONFIG_BRIDGE)
+	meta->l2_miss = skb->l2_miss;
+#endif
 }
 EXPORT_SYMBOL(skb_flow_dissect_meta);
 
diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 9dbc43388e57..4eb06c6367fc 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -615,7 +615,8 @@ static void *fl_get(struct tcf_proto *tp, u32 handle)
 }
 
 static const struct nla_policy fl_policy[TCA_FLOWER_MAX + 1] = {
-	[TCA_FLOWER_UNSPEC]		= { .type = NLA_UNSPEC },
+	[TCA_FLOWER_UNSPEC]		= { .strict_start_type =
+						TCA_FLOWER_L2_MISS },
 	[TCA_FLOWER_CLASSID]		= { .type = NLA_U32 },
 	[TCA_FLOWER_INDEV]		= { .type = NLA_STRING,
 					    .len = IFNAMSIZ },
@@ -720,7 +721,7 @@ static const struct nla_policy fl_policy[TCA_FLOWER_MAX + 1] = {
 	[TCA_FLOWER_KEY_PPPOE_SID]	= { .type = NLA_U16 },
 	[TCA_FLOWER_KEY_PPP_PROTO]	= { .type = NLA_U16 },
 	[TCA_FLOWER_KEY_L2TPV3_SID]	= { .type = NLA_U32 },
-
+	[TCA_FLOWER_L2_MISS]		= NLA_POLICY_MAX(NLA_U8, 1),
 };
 
 static const struct nla_policy
@@ -1668,6 +1669,10 @@ static int fl_set_key(struct net *net, struct nlattr **tb,
 		mask->meta.ingress_ifindex = 0xffffffff;
 	}
 
+	fl_set_key_val(tb, &key->meta.l2_miss, TCA_FLOWER_L2_MISS,
+		       &mask->meta.l2_miss, TCA_FLOWER_UNSPEC,
+		       sizeof(key->meta.l2_miss));
+
 	fl_set_key_val(tb, key->eth.dst, TCA_FLOWER_KEY_ETH_DST,
 		       mask->eth.dst, TCA_FLOWER_KEY_ETH_DST_MASK,
 		       sizeof(key->eth.dst));
@@ -3074,6 +3079,11 @@ static int fl_dump_key(struct sk_buff *skb, struct net *net,
 			goto nla_put_failure;
 	}
 
+	if (fl_dump_key_val(skb, &key->meta.l2_miss,
+			    TCA_FLOWER_L2_MISS, &mask->meta.l2_miss,
+			    TCA_FLOWER_UNSPEC, sizeof(key->meta.l2_miss)))
+		goto nla_put_failure;
+
 	if (fl_dump_key_val(skb, key->eth.dst, TCA_FLOWER_KEY_ETH_DST,
 			    mask->eth.dst, TCA_FLOWER_KEY_ETH_DST_MASK,
 			    sizeof(key->eth.dst)) ||
-- 
2.40.1

