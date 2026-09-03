Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13983FBEA5
	for <bridge@lists.linux.dev>; Thu,  3 Sep 2026 06:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788418599; cv=none; b=B1nIQcso5WskkLgSZ5HA7gMs+JVbmdzqkyenoxy+pj6uDeBK8pSHNqPzuQH3Gu0Od3CDC3x5MX+s/jmcD2PTspDGGKzPX8QywZyXb0oa31lVXiYnvLuSbT5VoOh3/Usl15wogTBFhct1yNKVdWA3xdYsbzU8tH+83wKRghcJlUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788418599; c=relaxed/simple;
	bh=aPAu8O+Z31pFJBRkDjt55qEqr+1soQ8sBGwF4hc8Ef4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=spfk+SdFH0LO1yur27vQwRS1lfHmIAiNetu6qP5egnnih3TV15osupKKalZ0wBc2T/W6AKXsEtBCyk8m2W/B16a7jkIEn8xe1gpntYGpePFlHin0ghf1h9Wl9erzLG8R5CmsJEao8B9iqKciBIwTtwWwp9Bx4k9+ZrZHJMFCOXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=KdEOEVeV; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="KdEOEVeV"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d6f9e2f681so21422755ad.3
        for <bridge@lists.linux.dev>; Wed, 02 Sep 2026 23:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788418594; x=1789023394; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2OEX0/sB0aUCvFZnFb+ZNiZz37uHRQ0yoP90qXgnBBI=;
        b=KdEOEVeVhNSEIOa+IU9/2uQDc5DRT9Xq4JU+/5aQd+q+FE3b3+Sc9sSaTQDBspVplN
         UCip7aWdgS5DYiFDrhCFlRu41qH/DclFv8m0dJ8bYUuhG5deI0hoP4Yu4a03fF+wiwtY
         hEMnvsyXECTDzcFc5QMhlRSqDLZgdsuXSjjlwx4S7U3kt92sHExL5TXxFJQ9kI5a20ml
         So9c2Kfqp/MnVgEmSnT4HymYQSjAKrW6SG02A+YmgVbHsajPsnVpDO4TnthzFAi1HUp4
         l7UUu+BIgunBTxL5CVQmNgjGAZ3a76aIqxZG9WQV45c6zOAeyIlF74lARHyWPA2Ceq2l
         s0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788418594; x=1789023394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2OEX0/sB0aUCvFZnFb+ZNiZz37uHRQ0yoP90qXgnBBI=;
        b=DqEXwm2J8Q0WwuPNqxb7Lm28CbH4N77l8UHwdoiMIbh1mUXKCREeuDFJVS56pzHHAM
         kWDwBiUxfPrfPbE3h7JWMdPvKGrMCU7iMWe3O4NQBctuedCf812QvouuUDZKURen6sym
         kia/EMTD8A+YlraAh9lyijLJ9Dlvr1dNXExPk3+yBgUOb+eOy+cd6UC7nmkX4gT7XI0K
         EfOdbtaWwoWPi68fpsbcVgGg6Dds0ryPqa0TEyeaZpDo8SXHe3LFpM0BoSGk4BHgh5Ug
         IUAoj/V48RADC9dP856Jv0qYmTy+l15ty4bqThL0cZQuy9KKHudgeqweEEazvphaGNJH
         AwIQ==
X-Forwarded-Encrypted: i=1; AKwUvBz4KT+yXefIwhxX49hypMvR6l8TNTIOdI8FvynO/+UT3aGHrCfJ/JShRdQRlHL/RSBaumaqH8U=@lists.linux.dev
X-Gm-Message-State: AFuF++mMgA3MrZoa7dpAh4wEGFS76GJ2v2trgc5lE8yaBOqUk6uNLQ5f
	Yxh2+A/2MpjE6WUO8JF9wfEe2sDfTehEBRnKw1F6ePB0uUjo2jQfPewckQJnliwwSTVf
X-Gm-Gg: AYBFou2l4dS7h4FTMFiLQ9ZS2F3qhVoM87dkAq0zUuAUr0NdFfvpmZ+/nhXtqfHPRfi
	hD/vPXHGZ/i2GQsYi4tRxBSbQZqntkoWZLlfy/1dUmc1+YIHfECi3BMjuPeu9G9uuHo0jjlF+7a
	4N3o4ZfvDRdQ9zt1MkeGD8mUiYQ7WoKdLbtzv+NYevGEeZZb8NIYs369VYXnJDxvL5mT1L+2uiZ
	d2cHujL6HHaiaU3yAzCoKfGD4zpLMiZLRJ8Mb4iZmKXiYzrBmhLuistRLSa1OkYuxgLI2nMypav
	C6Oo1H+oAgxy4R71ede9H5PBdUzDrYgluxSR2ren8Eig3uaQLm6Ehh6TnvxJ53zGkFYI7Ub5F6H
	6jkwmV0TBZ5WHNfX3u0eEkbYjI4GoHnaoV4j7AGtCVeSo2CRLrbiBdQJ2SQuvdlEEheHCdGCocj
	F/DeCxCv3tH3uLaFadLoGd+jGZaGW77V2cAIKwID6Q4UtKTuhLXv0du0PjybvxLfiDtLF9v7PzK
	ejD
X-Received: by 2002:a17:902:f54b:b0:2da:f75f:adbc with SMTP id d9443c01a7336-2daf75faf3bmr82815665ad.15.1788418593509;
        Wed, 02 Sep 2026 23:56:33 -0700 (PDT)
Received: from Roxy.localdomain ([203.175.14.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dafe62dbc7sm5443565ad.28.2026.09.02.23.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 23:56:32 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: razor@blackwall.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	henrik.bjoernlund@microchip.com,
	horatiu.vultur@microchip.com,
	vega@nebusec.ai,
	zylzyl2333@gmail.com,
	zhilinz@nebusec.ai
Subject: [PATCH net v3 1/1] net: bridge: use option bits for CFM/MRP frame handlers
Date: Thu,  3 Sep 2026 14:56:14 +0800
Message-ID: <0345b9d5aa60ba416f6738ff1b87140f0a749cb8.1788417901.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788417901.git.zhilinz@nebusec.ai>
References: <cover.1788417901.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CFM and MRP register a global br_frame_type whose hlist_node is linked
into the per-bridge frame_type_list when the first MEP/MRP instance is
created. Enabling the protocol on multiple bridges therefore inserts the
same node into multiple lists. Unregistering it on one bridge then
corrupts list state belonging to another.

These handlers can only be installed once per bridge, and they are
uncommon. Track their per-bridge enable state with net_bridge option
bits, which already live on the Rx hot cache line, and dispatch the
matching handler directly from the receive path. Check both bits
together first as an unlikely case.

Remove the generic frame_type_list and br_frame_type helpers, which
have had no other users since CFM and MRP were added. That shrinks
struct net_bridge by 8 bytes and drops the list walk from the fast
path. When neither protocol is compiled in, BR_CFM_MRP_OPTS is 0 and
the compiler prunes the branch.

Fixes: 90c628dd47ff ("net: bridge: extend the process of special frames")
Fixes: dc32cbb3dbd7 ("bridge: cfm: Kernel space implementation of CFM. CCM frame RX added.")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Suggested-by: Nikolay Aleksandrov <razor@blackwall.org>
Co-developed-by: Yilin Zhu <zylzyl2333@gmail.com>
Signed-off-by: Yilin Zhu <zylzyl2333@gmail.com>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
changes in v3:
- Always define BR_CFM_MRP_OPTS and keep the fast-path check
  unconditional. Read br->options with READ_ONCE().
- Drop CONFIG ifdefs around CFM/MRP dispatch. Provide header no-ops when
  the protocols are not compiled in so the compiler can prune them.
- v2 Link: https://lore.kernel.org/all/a43fdd12ad2fbb708c090dc4ead60f3e4aa8c0ac.1788159904.git.zhilinz@nebusec.ai/

changes in v2:
  - Replace the per-bridge br_frame_type object with net_bridge option
    bits.
  - Dispatch CFM/MRP handlers from the receive path. Check both option
    bits together first as an unlikely case.
  - Cover MRP, which has the same shared hlist_node bug.
  - Remove frame_type_list so CFM/MRP do not affect the fast path when
    they are disabled in .config.
  - v1 Link: https://lore.kernel.org/all/7198fe2845c30c60c6b3833dd78cead8c5966931.1778378864.git.zylzyl2333@gmail.com/

 net/bridge/br_cfm.c     | 11 +++--------
 net/bridge/br_device.c  |  1 -
 net/bridge/br_input.c   | 35 ++++++++++++++---------------------
 net/bridge/br_mrp.c     | 13 +++----------
 net/bridge/br_private.h | 26 +++++++++++++++-----------
 5 files changed, 35 insertions(+), 51 deletions(-)

diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
index dea56fffa1c19..9dcc97d63a6fc 100644
--- a/net/bridge/br_cfm.c
+++ b/net/bridge/br_cfm.c
@@ -367,7 +367,7 @@ static u32 ccm_tlv_extract(struct sk_buff *skb, u32 index,
 }
 
 /* note: already called with rcu_read_lock */
-static int br_cfm_frame_rx(struct net_bridge_port *port, struct sk_buff *skb)
+int br_cfm_frame_rx(struct net_bridge_port *port, struct sk_buff *skb)
 {
 	u32 mdlevel, interval, size, index, max;
 	const struct br_cfm_common_hdr *hdr;
@@ -489,11 +489,6 @@ static int br_cfm_frame_rx(struct net_bridge_port *port, struct sk_buff *skb)
 	return 1;
 }
 
-static struct br_frame_type cfm_frame_type __read_mostly = {
-	.type = cpu_to_be16(ETH_P_CFM),
-	.frame_handler = br_cfm_frame_rx,
-};
-
 int br_cfm_mep_create(struct net_bridge *br,
 		      const u32 instance,
 		      struct br_cfm_mep_create *const create,
@@ -559,7 +554,7 @@ int br_cfm_mep_create(struct net_bridge *br,
 	INIT_DELAYED_WORK(&mep->ccm_tx_dwork, ccm_tx_work_expired);
 
 	if (hlist_empty(&br->mep_list))
-		br_add_frame(br, &cfm_frame_type);
+		br_opt_toggle(br, BROPT_CFM_ENABLED, true);
 
 	hlist_add_tail_rcu(&mep->head, &br->mep_list);
 
@@ -588,7 +583,7 @@ static void mep_delete_implementation(struct net_bridge *br,
 	kfree_rcu(mep, rcu);
 
 	if (hlist_empty(&br->mep_list))
-		br_del_frame(br, &cfm_frame_type);
+		br_opt_toggle(br, BROPT_CFM_ENABLED, false);
 }
 
 int br_cfm_mep_delete(struct net_bridge *br,
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index ff55dab736326..e01c44a90d84b 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -503,7 +503,6 @@ void br_dev_setup(struct net_device *dev)
 	spin_lock_init(&br->lock);
 	INIT_LIST_HEAD(&br->port_list);
 	INIT_HLIST_HEAD(&br->fdb_list);
-	INIT_HLIST_HEAD(&br->frame_type_list);
 #if IS_ENABLED(CONFIG_BRIDGE_MRP)
 	INIT_HLIST_HEAD(&br->mrp_list);
 #endif
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index d87a5f9fa92b7..8bed72baf1615 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -317,17 +317,25 @@ static int nf_hook_bridge_pre(struct sk_buff *skb, struct sk_buff **pskb)
 	return RX_HANDLER_CONSUMED;
 }
 
+#define BR_CFM_MRP_OPTS \
+	((IS_ENABLED(CONFIG_BRIDGE_CFM) ? BIT(BROPT_CFM_ENABLED) : 0UL) | \
+	 (IS_ENABLED(CONFIG_BRIDGE_MRP) ? BIT(BROPT_MRP_ENABLED) : 0UL))
+
 /* Return 0 if the frame was not processed otherwise 1
  * note: already called with rcu_read_lock
  */
 static int br_process_frame_type(struct net_bridge_port *p,
 				 struct sk_buff *skb)
 {
-	struct br_frame_type *tmp;
+	struct net_bridge *br = p->br;
+
+	if (skb->protocol == htons(ETH_P_CFM) &&
+	    br_opt_get(br, BROPT_CFM_ENABLED))
+		return br_cfm_frame_rx(p, skb);
 
-	hlist_for_each_entry_rcu(tmp, &p->br->frame_type_list, list)
-		if (unlikely(tmp->type == skb->protocol))
-			return tmp->frame_handler(p, skb);
+	if (skb->protocol == htons(ETH_P_MRP) &&
+	    br_opt_get(br, BROPT_MRP_ENABLED))
+		return br_mrp_process(p, skb);
 
 	return 0;
 }
@@ -425,7 +433,8 @@ static rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
 		}
 	}
 
-	if (unlikely(br_process_frame_type(p, skb)))
+	if (unlikely((READ_ONCE(p->br->options) & BR_CFM_MRP_OPTS) &&
+		     br_process_frame_type(p, skb)))
 		return RX_HANDLER_PASS;
 
 forward:
@@ -467,19 +476,3 @@ rx_handler_func_t *br_get_rx_handler(const struct net_device *dev)
 
 	return br_handle_frame;
 }
-
-void br_add_frame(struct net_bridge *br, struct br_frame_type *ft)
-{
-	hlist_add_head_rcu(&ft->list, &br->frame_type_list);
-}
-
-void br_del_frame(struct net_bridge *br, struct br_frame_type *ft)
-{
-	struct br_frame_type *tmp;
-
-	hlist_for_each_entry(tmp, &br->frame_type_list, list)
-		if (ft == tmp) {
-			hlist_del_rcu(&ft->list);
-			return;
-		}
-}
diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
index ef16d07039241..dce6efa96c4c6 100644
--- a/net/bridge/br_mrp.c
+++ b/net/bridge/br_mrp.c
@@ -6,13 +6,6 @@
 static const u8 mrp_test_dmac[ETH_ALEN] = { 0x1, 0x15, 0x4e, 0x0, 0x0, 0x1 };
 static const u8 mrp_in_test_dmac[ETH_ALEN] = { 0x1, 0x15, 0x4e, 0x0, 0x0, 0x3 };
 
-static int br_mrp_process(struct net_bridge_port *p, struct sk_buff *skb);
-
-static struct br_frame_type mrp_frame_type __read_mostly = {
-	.type = cpu_to_be16(ETH_P_MRP),
-	.frame_handler = br_mrp_process,
-};
-
 static bool br_mrp_is_ring_port(struct net_bridge_port *p_port,
 				struct net_bridge_port *s_port,
 				struct net_bridge_port *port)
@@ -486,7 +479,7 @@ static void br_mrp_del_impl(struct net_bridge *br, struct br_mrp *mrp)
 	kfree_rcu(mrp, rcu);
 
 	if (hlist_empty(&br->mrp_list))
-		br_del_frame(br, &mrp_frame_type);
+		br_opt_toggle(br, BROPT_MRP_ENABLED, false);
 }
 
 /* Adds a new MRP instance.
@@ -536,7 +529,7 @@ int br_mrp_add(struct net_bridge *br, struct br_mrp_instance *instance)
 	rcu_assign_pointer(mrp->s_port, p);
 
 	if (hlist_empty(&br->mrp_list))
-		br_add_frame(br, &mrp_frame_type);
+		br_opt_toggle(br, BROPT_MRP_ENABLED, true);
 
 	INIT_DELAYED_WORK(&mrp->test_work, br_mrp_test_work_expired);
 	INIT_DELAYED_WORK(&mrp->in_test_work, br_mrp_in_test_work_expired);
@@ -1241,7 +1234,7 @@ static int br_mrp_rcv(struct net_bridge_port *p,
  * normal forwarding.
  * note: already called with rcu_read_lock
  */
-static int br_mrp_process(struct net_bridge_port *p, struct sk_buff *skb)
+int br_mrp_process(struct net_bridge_port *p, struct sk_buff *skb)
 {
 	/* If there is no MRP instance do normal forwarding */
 	if (likely(!test_bit(BR_MRP_AWARE_BIT, &p->flags)))
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index d337b1cfb980d..b01997ea95089 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -495,12 +495,13 @@ enum net_bridge_opts {
 	BROPT_MST_ENABLED,
 	BROPT_MDB_OFFLOAD_FAIL_NOTIFICATION,
 	BROPT_FDB_LOCAL_VLAN_0,
+	BROPT_CFM_ENABLED,
+	BROPT_MRP_ENABLED,
 };
 
 struct net_bridge {
 	spinlock_t			lock;
 	spinlock_t			hash_lock;
-	struct hlist_head		frame_type_list;
 	struct net_device		*dev;
 	unsigned long			options;
 	/* These fields are accessed on each packet */
@@ -932,16 +933,6 @@ int nbp_backup_change(struct net_bridge_port *p, struct net_device *backup_dev);
 int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb);
 rx_handler_func_t *br_get_rx_handler(const struct net_device *dev);
 
-struct br_frame_type {
-	__be16			type;
-	int			(*frame_handler)(struct net_bridge_port *port,
-						 struct sk_buff *skb);
-	struct hlist_node	list;
-};
-
-void br_add_frame(struct net_bridge *br, struct br_frame_type *ft);
-void br_del_frame(struct net_bridge *br, struct br_frame_type *ft);
-
 static inline bool br_rx_handler_check_rcu(const struct net_device *dev)
 {
 	return rcu_dereference(dev->rx_handler) == br_get_rx_handler(dev);
@@ -2080,6 +2071,7 @@ int br_mrp_parse(struct net_bridge *br, struct net_bridge_port *p,
 bool br_mrp_enabled(struct net_bridge *br);
 void br_mrp_port_del(struct net_bridge *br, struct net_bridge_port *p);
 int br_mrp_fill_info(struct sk_buff *skb, struct net_bridge *br);
+int br_mrp_process(struct net_bridge_port *p, struct sk_buff *skb);
 #else
 static inline int br_mrp_parse(struct net_bridge *br, struct net_bridge_port *p,
 			       struct nlattr *attr, int cmd,
@@ -2103,6 +2095,11 @@ static inline int br_mrp_fill_info(struct sk_buff *skb, struct net_bridge *br)
 	return 0;
 }
 
+static inline int br_mrp_process(struct net_bridge_port *p, struct sk_buff *skb)
+{
+	return 0;
+}
+
 #endif
 
 /* br_cfm.c */
@@ -2111,6 +2108,7 @@ int br_cfm_parse(struct net_bridge *br, struct net_bridge_port *p,
 		 struct nlattr *attr, int cmd, struct netlink_ext_ack *extack);
 bool br_cfm_created(struct net_bridge *br);
 void br_cfm_port_del(struct net_bridge *br, struct net_bridge_port *p);
+int br_cfm_frame_rx(struct net_bridge_port *port, struct sk_buff *skb);
 int br_cfm_config_fill_info(struct sk_buff *skb, struct net_bridge *br);
 int br_cfm_status_fill_info(struct sk_buff *skb,
 			    struct net_bridge *br,
@@ -2135,6 +2133,12 @@ static inline void br_cfm_port_del(struct net_bridge *br,
 {
 }
 
+static inline int br_cfm_frame_rx(struct net_bridge_port *port,
+				  struct sk_buff *skb)
+{
+	return 0;
+}
+
 static inline int br_cfm_config_fill_info(struct sk_buff *skb, struct net_bridge *br)
 {
 	return -EOPNOTSUPP;
-- 
2.43.0

