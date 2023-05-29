Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6D1B640BB7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7407940B74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vc5/tMt9sFwrCWq6+YtiD/d1QZ16Bt400idyZhPc9A=;
 b=i2MFec745JGKMBK8ultW23XMD0DZo4Av+wpan+mRmvqnje8U4DnmJIH+HFfBgGuZsTRAtTfH9eMtiqTVxPW3BB0EWKqVkTgQuI+/322XmwvP5ZIyBLLlQnWvm2iy8uY1g1gFG5WRYnYq5ruQwgn5ufoJ3jkX4OASsE9TDzJ8UFOseSqttz7gyWUD1UWFjzeQj9FQeWPMZY+x65FU83L7mFoh+rNRuGpi6PRzHB1X089kEb/q7lWTUHYh+HmHaluD4aDGa3jeD2KQerHmqv7nx4IdNIhDhLztSNHoVdVWgD6ZZ+jZ7UiGILz3dGjp4gDm4AzN1PkWGqql0AfWJslAHA==
From: Ido Schimmel <idosch@nvidia.com>
Date: Mon, 29 May 2023 14:48:30 +0300
Message-ID: <20230529114835.372140-4-idosch@nvidia.com>
In-Reply-To: <20230529114835.372140-1-idosch@nvidia.com>
References: <20230529114835.372140-1-idosch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v2 3/8] net/sched: flower: Allow matching
	on layer 2 miss
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: taras.chornyi@plvision.eu, petrm@nvidia.com, alexandre.belloni@bootlin.com, jiri@resnulli.us, leon@kernel.org, vladimir.oltean@nxp.com, razor@blackwall.org, roopa@nvidia.com, claudiu.manoil@nxp.com, Ido Schimmel <idosch@nvidia.com>, UNGLinuxDriver@microchip.com, edumazet@google.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com, simon.horman@corigine.com, kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com, davem@davemloft.net

Add the 'TCA_FLOWER_L2_MISS' netlink attribute that allows user space to
match on packets that encountered a layer 2 miss. The miss indication is
set as metadata in the tc skb extension by the bridge driver upon FDB or
MDB lookup miss and dissected by the flow dissector to the
'FLOW_DISSECTOR_KEY_META' key.

The use of this skb extension is guarded by the 'tc_skb_ext_tc' static
key. As such, enable / disable this key when filters that match on layer
2 miss are added / deleted.

Tested:

 # cat tc_skb_ext_tc.py
 #!/usr/bin/env -S drgn -s vmlinux

 refcount = prog["tc_skb_ext_tc"].key.enabled.counter.value_()
 print(f"tc_skb_ext_tc reference count is {refcount}")

 # ./tc_skb_ext_tc.py
 tc_skb_ext_tc reference count is 0

 # tc filter add dev swp1 egress proto all handle 101 pref 1 flower src_mac 00:11:22:33:44:55 action drop
 # tc filter add dev swp1 egress proto all handle 102 pref 2 flower src_mac 00:11:22:33:44:55 l2_miss true action drop
 # tc filter add dev swp1 egress proto all handle 103 pref 3 flower src_mac 00:11:22:33:44:55 l2_miss false action drop

 # ./tc_skb_ext_tc.py
 tc_skb_ext_tc reference count is 2

 # tc filter replace dev swp1 egress proto all handle 102 pref 2 flower src_mac 00:01:02:03:04:05 l2_miss false action drop

 # ./tc_skb_ext_tc.py
 tc_skb_ext_tc reference count is 2

 # tc filter del dev swp1 egress proto all handle 103 pref 3 flower
 # tc filter del dev swp1 egress proto all handle 102 pref 2 flower
 # tc filter del dev swp1 egress proto all handle 101 pref 1 flower

 # ./tc_skb_ext_tc.py
 tc_skb_ext_tc reference count is 0

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
    v2:
    * Split flow_dissector changes to a previous patch.
    * Use tc skb extension instead of 'skb->l2_miss'.

 include/uapi/linux/pkt_cls.h |  2 ++
 net/sched/cls_flower.c       | 30 ++++++++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

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
 
diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 9dbc43388e57..04adcde9eb81 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -120,6 +120,7 @@ struct cls_fl_filter {
 	u32 handle;
 	u32 flags;
 	u32 in_hw_count;
+	u8 needs_tc_skb_ext:1;
 	struct rcu_work rwork;
 	struct net_device *hw_dev;
 	/* Flower classifier is unlocked, which means that its reference counter
@@ -415,6 +416,8 @@ static struct cls_fl_head *fl_head_dereference(struct tcf_proto *tp)
 
 static void __fl_destroy_filter(struct cls_fl_filter *f)
 {
+	if (f->needs_tc_skb_ext)
+		tc_skb_ext_tc_disable();
 	tcf_exts_destroy(&f->exts);
 	tcf_exts_put_net(&f->exts);
 	kfree(f);
@@ -615,7 +618,8 @@ static void *fl_get(struct tcf_proto *tp, u32 handle)
 }
 
 static const struct nla_policy fl_policy[TCA_FLOWER_MAX + 1] = {
-	[TCA_FLOWER_UNSPEC]		= { .type = NLA_UNSPEC },
+	[TCA_FLOWER_UNSPEC]		= { .strict_start_type =
+						TCA_FLOWER_L2_MISS },
 	[TCA_FLOWER_CLASSID]		= { .type = NLA_U32 },
 	[TCA_FLOWER_INDEV]		= { .type = NLA_STRING,
 					    .len = IFNAMSIZ },
@@ -720,7 +724,7 @@ static const struct nla_policy fl_policy[TCA_FLOWER_MAX + 1] = {
 	[TCA_FLOWER_KEY_PPPOE_SID]	= { .type = NLA_U16 },
 	[TCA_FLOWER_KEY_PPP_PROTO]	= { .type = NLA_U16 },
 	[TCA_FLOWER_KEY_L2TPV3_SID]	= { .type = NLA_U32 },
-
+	[TCA_FLOWER_L2_MISS]		= NLA_POLICY_MAX(NLA_U8, 1),
 };
 
 static const struct nla_policy
@@ -1668,6 +1672,10 @@ static int fl_set_key(struct net *net, struct nlattr **tb,
 		mask->meta.ingress_ifindex = 0xffffffff;
 	}
 
+	fl_set_key_val(tb, &key->meta.l2_miss, TCA_FLOWER_L2_MISS,
+		       &mask->meta.l2_miss, TCA_FLOWER_UNSPEC,
+		       sizeof(key->meta.l2_miss));
+
 	fl_set_key_val(tb, key->eth.dst, TCA_FLOWER_KEY_ETH_DST,
 		       mask->eth.dst, TCA_FLOWER_KEY_ETH_DST_MASK,
 		       sizeof(key->eth.dst));
@@ -2085,6 +2093,11 @@ static int fl_check_assign_mask(struct cls_fl_head *head,
 	return ret;
 }
 
+static bool fl_needs_tc_skb_ext(const struct fl_flow_key *mask)
+{
+	return mask->meta.l2_miss;
+}
+
 static int fl_set_parms(struct net *net, struct tcf_proto *tp,
 			struct cls_fl_filter *f, struct fl_flow_mask *mask,
 			unsigned long base, struct nlattr **tb,
@@ -2121,6 +2134,14 @@ static int fl_set_parms(struct net *net, struct tcf_proto *tp,
 		return -EINVAL;
 	}
 
+	/* Enable tc skb extension if filter matches on data extracted from
+	 * this extension.
+	 */
+	if (fl_needs_tc_skb_ext(&mask->key)) {
+		f->needs_tc_skb_ext = 1;
+		tc_skb_ext_tc_enable();
+	}
+
 	return 0;
 }
 
@@ -3074,6 +3095,11 @@ static int fl_dump_key(struct sk_buff *skb, struct net *net,
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

