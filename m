Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1539E3D3008
	for <bridge@lists.linux.dev>; Mon, 31 Aug 2026 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788175236; cv=none; b=YfN1+VrBxP8Cn/usfUUvgv2oEUEksreCkGeNgi9BRh7pX9awoksxn7CITBq7hb/Jgi0C4PpEo9q03Al1hufBZHjPjG8Edhp8PGsHlJy/TgNIpz+deTC6owXLVPYd8s3v4HbBQ+5CnBxw2frMfSisr73tTcWbEsEQx2jJ00tizes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788175236; c=relaxed/simple;
	bh=Kt3UFJiSXa7V9TWx2jNwlZKxIM7L5H0prj/bImayscI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cq7qBf98TLuiKkm6phYOQrxerRedxBTjafJEOTW/nF932bANe/XjsrUfCA3i7y+WcUewwBN/gau45vPdeZMMIl38+oWPxkyw1ssWbGUP3M6HAj3JS6qfGi0hPMLKn1mzILo0BsgIkmx7PFt3b+s6u8RzNdunNQrPtgVaU+2bmN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=dnsfh6mi; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="dnsfh6mi"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cf452def93so33730445ad.1
        for <bridge@lists.linux.dev>; Mon, 31 Aug 2026 04:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788175234; x=1788780034; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gC74SbUZQUk77bvawV+DO0MFVAbCqYwD4y40tBFx47E=;
        b=dnsfh6miKv5uEkmjL/KHFDCo+TR35zVv6fBEadT1T46m64blSviHhBDPb4eU09WUdg
         EpBJ37CgIlQ1wlxFElX5P0yks3Bc6bLlPTWQcoWh3snmhjeTh5i47S+aehKNYPmVvPZa
         OHAdawU/syqoFMkr/pwQ0gjpY8p81REA+88vEi6mPdiZf7xSH4MSB0d3qzlYnh1ScW3M
         iiGiB83bbDxtiXHUjMEh7kC+gWR7aQFVKHHDPtNi7K8hfUopjG4jxCyNZu1nxCKeMVCG
         WAZVV9uT5Vw2XVG1VFENhVXQt9q2mbT1zzA04l6wD5Wx/G/utmzs6e7pu+vYMUjvZC7n
         YlfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788175234; x=1788780034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gC74SbUZQUk77bvawV+DO0MFVAbCqYwD4y40tBFx47E=;
        b=Cka4Qguls0gskxn3fxB8/0LyHZs5xAagj9uyO8JIpB5fZHdKVB1+enkxDzIzqF21Jv
         ygcYbx27qEBoErHg0UvDDZweSYw0LpbQBfjnev5Vo1N4YQO3GizwJchlVGWsCeAgl15M
         p5SwYaiRqtSTw56BFnkT5dEoFFNNL7TSNgZXfW7AeSgT+N6AWeDqj9/6QsZkbH5oTR2A
         qEDBzZ635Umvo6xF1r4DXuF5hugUybh12D5YrrsjSOl8CMaGULMhTxqJ2L4gHJvoKb4W
         JWJqZ1yIzcVErxuLE29ti9k5PdozkbKxSt9wmIcersFTHA2bESlrXc9ZhJH3xPZ+JiKB
         /+Fg==
X-Forwarded-Encrypted: i=1; AKwUvBzthm1a0hwcsTkYRy+ro5aNC+pJZE3gaKE3ztprDHyosJQxJkYI9DbO1JdNjdVk57K6Ph0M5to=@lists.linux.dev
X-Gm-Message-State: AFuF++lEgqHmawPbme6LmqJQizKDXL9vZCW+W6ayxn627/0OOWEDDPMB
	W1Rs9Y8tXyZMVk62PzwWDFoos9d9YFwqz5o1dQnA3p6g4V6NWmvM8LyZ68bCvln4v1iM
X-Gm-Gg: AYBFou2+LUa/CR+DHYgNt/v5JyYbopYwMWsDfUWR2Wfo+R0ubHFD1xfsR9TF1g2JNbG
	ng8+DQOTHmynD7yOZoI3qUmWo8StehNYxzdEDaKI8FuCtp2STSd9QnLOdEO+xtK6folP/quuG02
	qnPT4EGlcVp7H9SR/redobdytj2vAKqCEb9LwAuyaPTHuMAwRBt4Ws6ozp304Hydc5GhpoGleCi
	l1RJG8j/raq49UBPojZxerSLaUhDDp+GrMDWJsBJdTab+DTH4mvS7scEefQH2SCAxSn24XbZvdc
	iFhaWGi4oidsSU6Vo8BAGRPRk4WRjubW58qKcZR3xgAEXpwsknsnNGJIP8yO8mVrEuchUyBTLyS
	1I9uGKt31M2ECHFe5SZiirKCT/XTilImJGro+ETud4T1UXve4sEyX5kUwGuv6gjTfNf209tFJ/A
	SO8KM38AuO8rsooNaIUyR/UB7/C82v98fLYKjrOAcMUdMsyoqCbnAUI7f4Ryz8/j+0DTZNgQ9sU
	7VP
X-Received: by 2002:a17:90b:4fc7:b0:395:8124:ac53 with SMTP id 98e67ed59e1d1-398da618732mr6189119a91.6.1788175234314;
        Mon, 31 Aug 2026 04:20:34 -0700 (PDT)
Received: from Roxy.localdomain ([203.175.14.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b1ab4e12sm21202886a91.16.2026.08.31.04.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 04:20:33 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: razor@blackwall.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	horatiu.vultur@microchip.com,
	henrik.bjoernlund@microchip.com,
	vega@nebusec.ai,
	zylzyl2333@gmail.com,
	zhilinz@nebusec.ai
Subject: [PATCH net v2 1/1] net: bridge: use option bits for CFM/MRP frame handlers
Date: Mon, 31 Aug 2026 19:20:12 +0800
Message-ID: <a43fdd12ad2fbb708c090dc4ead60f3e4aa8c0ac.1788159904.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788159904.git.zhilinz@nebusec.ai>
References: <cover.1788159904.git.zhilinz@nebusec.ai>
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
path. When neither protocol is compiled in, the new checks are compiled
out completely.

Fixes: 90c628dd47ff ("net: bridge: extend the process of special frames")
Fixes: dc32cbb3dbd7 ("bridge: cfm: Kernel space implementation of CFM. CCM frame RX added.")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Suggested-by: Nikolay Aleksandrov <razor@blackwall.org>
Co-developed-by: Yilin Zhu <zylzyl2333@gmail.com>
Signed-off-by: Yilin Zhu <zylzyl2333@gmail.com>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
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
 net/bridge/br_input.c   | 44 ++++++++++++++++++++---------------------
 net/bridge/br_mrp.c     | 13 +++---------
 net/bridge/br_private.h | 15 ++++----------
 5 files changed, 32 insertions(+), 52 deletions(-)

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
index d87a5f9fa92b7..72892e5b40439 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -317,20 +317,33 @@ static int nf_hook_bridge_pre(struct sk_buff *skb, struct sk_buff **pskb)
 	return RX_HANDLER_CONSUMED;
 }
 
+#if IS_ENABLED(CONFIG_BRIDGE_CFM) || IS_ENABLED(CONFIG_BRIDGE_MRP)
+/* CFM/MRP are uncommon; test both enable bits together first. */
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
-
-	hlist_for_each_entry_rcu(tmp, &p->br->frame_type_list, list)
-		if (unlikely(tmp->type == skb->protocol))
-			return tmp->frame_handler(p, skb);
+	struct net_bridge *br = p->br;
 
+#if IS_ENABLED(CONFIG_BRIDGE_CFM)
+	if (skb->protocol == htons(ETH_P_CFM) &&
+	    br_opt_get(br, BROPT_CFM_ENABLED))
+		return br_cfm_frame_rx(p, skb);
+#endif
+#if IS_ENABLED(CONFIG_BRIDGE_MRP)
+	if (skb->protocol == htons(ETH_P_MRP) &&
+	    br_opt_get(br, BROPT_MRP_ENABLED))
+		return br_mrp_process(p, skb);
+#endif
 	return 0;
 }
+#endif
 
 /*
  * Return NULL if skb is handled
@@ -425,8 +438,11 @@ static rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
 		}
 	}
 
-	if (unlikely(br_process_frame_type(p, skb)))
+#if IS_ENABLED(CONFIG_BRIDGE_CFM) || IS_ENABLED(CONFIG_BRIDGE_MRP)
+	if (unlikely((p->br->options & BR_CFM_MRP_OPTS) &&
+		     br_process_frame_type(p, skb)))
 		return RX_HANDLER_PASS;
+#endif
 
 forward:
 	if (br_mst_is_enabled(p))
@@ -467,19 +483,3 @@ rx_handler_func_t *br_get_rx_handler(const struct net_device *dev)
 
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
index d337b1cfb980d..afe7c0b4f8fa7 100644
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
@@ -2111,6 +2103,7 @@ int br_cfm_parse(struct net_bridge *br, struct net_bridge_port *p,
 		 struct nlattr *attr, int cmd, struct netlink_ext_ack *extack);
 bool br_cfm_created(struct net_bridge *br);
 void br_cfm_port_del(struct net_bridge *br, struct net_bridge_port *p);
+int br_cfm_frame_rx(struct net_bridge_port *port, struct sk_buff *skb);
 int br_cfm_config_fill_info(struct sk_buff *skb, struct net_bridge *br);
 int br_cfm_status_fill_info(struct sk_buff *skb,
 			    struct net_bridge *br,
-- 
2.43.0

