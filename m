Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5D10E61181
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1287860AC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddChwO0XV2RfxJFWAOa8FJ3HKcgwhT0IXU/U9IfVtqE=;
 b=krG6uIXjoEuAlMR1A4gI3ZSnl63Dd4gWJidxvsCER7HS8T/bBkQs8+7Lz1KTApoHd1rkcLOgiw6TYuyLeJUMjUnABjsejQHbqQTl7T9zXCxL5jIfSWQ1hSCqEWv8vJZ0RxK05EHakLV08bmRI8RSS8vJz65IyBnB/TyRVM2xRje7Fz7r6mD8k41RS4brKQTX4J2v3LOsB3br1ABp1EiJyoC3zjIdLnWaOFoXkp926dcbhSz7AHDv0diFN3tFVWS78IXx2MWOsN/5oHWpzRTOnPu44cnHvwOkBuy1mC9ZeAq0r9lns5UN7CuLftkuYDVk3MQb7M/7+vhgIXUdHDY1Vg==
From: Ido Schimmel <idosch@nvidia.com>
Date: Mon, 29 May 2023 14:48:28 +0300
Message-ID: <20230529114835.372140-2-idosch@nvidia.com>
In-Reply-To: <20230529114835.372140-1-idosch@nvidia.com>
References: <20230529114835.372140-1-idosch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Bridge] [PATCH net-next v2 1/8] skbuff: bridge: Add layer 2 miss
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
Cc: taras.chornyi@plvision.eu, petrm@nvidia.com, alexandre.belloni@bootlin.com, jiri@resnulli.us, leon@kernel.org, vladimir.oltean@nxp.com, razor@blackwall.org, roopa@nvidia.com, claudiu.manoil@nxp.com, Ido Schimmel <idosch@nvidia.com>, UNGLinuxDriver@microchip.com, edumazet@google.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com, simon.horman@corigine.com, kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com, davem@davemloft.net

For EVPN non-DF (Designated Forwarder) filtering we need to be able to
prevent decapsulated traffic from being flooded to a multi-homed host.
Filtering of multicast and broadcast traffic can be achieved using the
following flower filter:

 # tc filter add dev bond0 egress pref 1 proto all flower indev vxlan0 dst_mac 01:00:00:00:00:00/01:00:00:00:00:00 action drop

Unlike broadcast and multicast traffic, it is not currently possible to
filter unknown unicast traffic. The classification into unknown unicast
is performed by the bridge driver, but is not visible to other layers
such as tc.

Solve this by adding a new 'l2_miss' bit to the tc skb extension. Clear
the bit whenever a packet enters the bridge (received from a bridge port
or transmitted via the bridge) and set it if the packet did not match an
FDB or MDB entry. If there is no skb extension and the bit needs to be
cleared, then do not allocate one as no extension is equivalent to the
bit being cleared. The bit is not set for broadcast packets as they
never perform a lookup and therefore never incur a miss.

A bit that is set for every flooded packet would also work for the
current use case, but it does not allow us to differentiate between
registered and unregistered multicast traffic, which might be useful in
the future.

To keep the performance impact to a minimum, the marking of packets is
guarded by the 'tc_skb_ext_tc' static key. When 'false', the skb is not
touched and an skb extension is not allocated. Instead, only a
5 bytes nop is executed, as demonstrated below for the call site in
br_handle_frame().

Before the patch:

```
        memset(skb->cb, 0, sizeof(struct br_input_skb_cb));
  c37b09:       49 c7 44 24 28 00 00    movq   $0x0,0x28(%r12)
  c37b10:       00 00

        p = br_port_get_rcu(skb->dev);
  c37b12:       49 8b 44 24 10          mov    0x10(%r12),%rax
        memset(skb->cb, 0, sizeof(struct br_input_skb_cb));
  c37b17:       49 c7 44 24 30 00 00    movq   $0x0,0x30(%r12)
  c37b1e:       00 00
  c37b20:       49 c7 44 24 38 00 00    movq   $0x0,0x38(%r12)
  c37b27:       00 00
```

After the patch (when static key is disabled):

```
        memset(skb->cb, 0, sizeof(struct br_input_skb_cb));
  c37c29:       49 c7 44 24 28 00 00    movq   $0x0,0x28(%r12)
  c37c30:       00 00
  c37c32:       49 8d 44 24 28          lea    0x28(%r12),%rax
  c37c37:       48 c7 40 08 00 00 00    movq   $0x0,0x8(%rax)
  c37c3e:       00
  c37c3f:       48 c7 40 10 00 00 00    movq   $0x0,0x10(%rax)
  c37c46:       00

#ifdef CONFIG_HAVE_JUMP_LABEL_HACK

static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
{
        asm_volatile_goto("1:"
  c37c47:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
        br_tc_skb_miss_set(skb, false);

        p = br_port_get_rcu(skb->dev);
  c37c4c:       49 8b 44 24 10          mov    0x10(%r12),%rax
```

Subsequent patches will extend the flower classifier to be able to match
on the new 'l2_miss' bit and enable / disable the static key when
filters that match on it are added / deleted.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
    v2:
    * Use tc skb extension instead of adding a bit to the skb.
    * Do not mark broadcast packets as they never perform a lookup and
      therefore never incur a miss.

 include/linux/skbuff.h  |  1 +
 net/bridge/br_device.c  |  1 +
 net/bridge/br_forward.c |  3 +++
 net/bridge/br_input.c   |  1 +
 net/bridge/br_private.h | 27 +++++++++++++++++++++++++++
 5 files changed, 33 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 5951904413ab..e2f48ddb2f7c 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -330,6 +330,7 @@ struct tc_skb_ext {
 	u8 post_ct_snat:1;
 	u8 post_ct_dnat:1;
 	u8 act_miss:1; /* Set if act_miss_cookie is used */
+	u8 l2_miss:1; /* Set by bridge upon FDB or MDB miss */
 };
 #endif
 
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 8eca8a5c80c6..9a5ea06236bd 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -39,6 +39,7 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	u16 vid = 0;
 
 	memset(skb->cb, 0, sizeof(struct br_input_skb_cb));
+	br_tc_skb_miss_set(skb, false);
 
 	rcu_read_lock();
 	nf_ops = rcu_dereference(nf_br_ops);
diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 84d6dd5e5b1a..6116eba1bd89 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -203,6 +203,8 @@ void br_flood(struct net_bridge *br, struct sk_buff *skb,
 	struct net_bridge_port *prev = NULL;
 	struct net_bridge_port *p;
 
+	br_tc_skb_miss_set(skb, pkt_type != BR_PKT_BROADCAST);
+
 	list_for_each_entry_rcu(p, &br->port_list, list) {
 		/* Do not flood unicast traffic to ports that turn it off, nor
 		 * other traffic if flood off, except for traffic we originate
@@ -295,6 +297,7 @@ void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
 			allow_mode_include = false;
 	} else {
 		p = NULL;
+		br_tc_skb_miss_set(skb, true);
 	}
 
 	while (p || rp) {
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index fc17b9fd93e6..c34a0b0901b0 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -334,6 +334,7 @@ static rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
 		return RX_HANDLER_CONSUMED;
 
 	memset(skb->cb, 0, sizeof(struct br_input_skb_cb));
+	br_tc_skb_miss_set(skb, false);
 
 	p = br_port_get_rcu(skb->dev);
 	if (p->flags & BR_VLAN_TUNNEL)
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 2119729ded2b..a63b32c1638e 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -15,6 +15,7 @@
 #include <linux/u64_stats_sync.h>
 #include <net/route.h>
 #include <net/ip6_fib.h>
+#include <net/pkt_cls.h>
 #include <linux/if_vlan.h>
 #include <linux/rhashtable.h>
 #include <linux/refcount.h>
@@ -754,6 +755,32 @@ void br_boolopt_multi_get(const struct net_bridge *br,
 			  struct br_boolopt_multi *bm);
 void br_opt_toggle(struct net_bridge *br, enum net_bridge_opts opt, bool on);
 
+#if IS_ENABLED(CONFIG_NET_TC_SKB_EXT)
+static inline void br_tc_skb_miss_set(struct sk_buff *skb, bool miss)
+{
+	struct tc_skb_ext *ext;
+
+	if (!tc_skb_ext_tc_enabled())
+		return;
+
+	ext = skb_ext_find(skb, TC_SKB_EXT);
+	if (ext) {
+		ext->l2_miss = miss;
+		return;
+	}
+	if (!miss)
+		return;
+	ext = tc_skb_ext_alloc(skb);
+	if (!ext)
+		return;
+	ext->l2_miss = true;
+}
+#else
+static inline void br_tc_skb_miss_set(struct sk_buff *skb, bool miss)
+{
+}
+#endif
+
 /* br_device.c */
 void br_dev_setup(struct net_device *dev);
 void br_dev_delete(struct net_device *dev, struct list_head *list);
-- 
2.40.1

