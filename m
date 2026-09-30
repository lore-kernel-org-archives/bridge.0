Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620F4411F80
	for <bridge@lists.linux.dev>; Wed, 30 Sep 2026 07:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752514; cv=none; b=IPUYpfekeiqBwe3KdvnTsbURaNazs3i8UGPL8N3Vjb2pcupOuI13dK1mBbLxnWNlbLf7b4rB3FSoa9STCk6Tl1fJ6E1yoPC44KhtoQkFpaTABL6UqbfkQhnwKORBFrf2xZSvRs41tlQ3zX87f4MLCmeUIdqcQms8aDXHW0dwGUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752514; c=relaxed/simple;
	bh=WY+ZCDHQJBEKPea/uiuEGbtTtwRxCsc9kJgv9B3OgNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0AZNWKiNnNcCGu1CuSDS5p3L4UYAr0Ffc12Q5RjX6ktG+eDzNCGwLzzYPWAIG9NHCdWCE+LtWdUbJuTLAE2iGyEeR6jZcHKarOH4WVQuATFA2JU00/L+8NZstS5J12Y4ngqCiMBi2sVsdprHudHBGNHmjLbF2lI8c8KKK5opG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=a8BmaiuH; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="a8BmaiuH"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4834977ae75so3002324f8f.3
        for <bridge@lists.linux.dev>; Wed, 30 Sep 2026 00:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1790752504; x=1791357304; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CiQIP7dLQtmAzKllQ/Ze/JeI5fWO1kb1ce2CTMfNNWQ=;
        b=a8BmaiuH8l60inV4ZikYHHn1udzdbDPV6TQjqOcUerfXpcWoOlXcR9cyMQ5HJNUgtx
         PbTX5rZ6VmoQ2DCwNUd/ZfrfwatgxqttJYGxe5X+RAGaLRAo64ujxBL+u4a0yk7EZXog
         iYa+vdfzeLgZZ06CVTSE4Ubh7M4Qk9RQLPPJ0TV5SWdb+qCoVAlOTcheAO3CCWRoMhgE
         nJ5f9/Jh949x4zZG8xGQeJFzlYhoUSxhgsXGsv2F1t/k5ciJQ5QjiNqWzBmDoeD1A9e2
         bvTFAX/oA8DwxTqd8rcIu45AheEqVdZs+9R7U7FLyIDxcJz9tk6xZ905uA8H88CXdXGk
         JwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752504; x=1791357304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CiQIP7dLQtmAzKllQ/Ze/JeI5fWO1kb1ce2CTMfNNWQ=;
        b=dBLQd+3cjMy8H0EnjHUYx//3PnV2OJxXjsA52rh+bX8rkeTUpTB5SsNBmlucSWOvPG
         A0pcc108V0sQQLWGq6NHvC982s+TLqY/G8dkmDnmPcI0QQG4rYIZ4uLvIf/c53MkuvgK
         vaTq2bdbaKye08xAaw1hG300C0ODJyJVsurxa1QUnntcGd3/AL1sCC64evYEcbdmTznN
         ScH48IR/xH6Trq56uVPiB+aXZUheO1FjZQhNh3cV947v91JGVIHDsPiiZOV7odZzkFg+
         /WJpD6YBwvvSBSLsfTpTLRWsqL7wGS3Imwz0VgXZqG4n3ybozGY9q4hXuqRR3J0PP/L0
         hlzA==
X-Forwarded-Encrypted: i=1; AKwUvBwljZ0HbWLq3UUoWfNk14nLj34D2TeJ+1l2tPA4flkuO8WnIxrbp9y4WNZZZTF7ascSSPDaSRY=@lists.linux.dev
X-Gm-Message-State: AFq9FYLkg8KonRfEOBGQPV44bWh/PRUF9373zJI7ffi1XPUa+gh2kkxZ
	TRWybe4xQJ0449N9PsBLM1hir3zEgbLIxxwqPJbwWo6qBqSIW3oZX8uB1f1ZJ9w7hSw=
X-Gm-Gg: AYBFou0e058PM5U1e4qxScP6dtXEIdaGqJVhaz9AGGd/aQ/WIV91K0G9eH194fNR4Lr
	PqGH0XZSriRLIvuG7uto9S43qIpsfjVlgB5lF/W4rN2Xrv9duNvImJs8YAiUUwQUuWxkTY5ZEDH
	uMLU4/OKwJMya0F5R5mYUcakbclpeoMSq7WXKi52uVqlh29LtDcS78QLiGJXeRi6jgAw89IRVlz
	XHLIYY2Y5IsPQG8SInqhHK1gfQBSyryVZaSYGmmbsSEKPg4dJzSXPIqC8Qnwar7dgk3+ppK89sx
	8qKA+9oe9rlSDJmv1X8cykM7+bYXJEVAZUttB9MXJjtYtlRfCBF/4oVIf7oiKMGr1qnIJfmTJ9W
	Pq2tjYV93rxLR7RKHePl2GinBR8/TL7RVpptX/QsKk/M2jkI8sCIWspZ16wPDs8xUXyQ3Qj1c7H
	iGV2VXzj/wGXgXncYJAMV3nglJ9gHpfzk0gVD4hv4Ssn0U7wbMh5vOBGVXIzcvh/iFkT5ZKsJ/v
	0RUu9SoCdKQ7FbUMfWp
X-Received: by 2002:a5d:5849:0:b0:487:27f6:a4e3 with SMTP id ffacd0b85a97d-48b0253d698mr949095f8f.51.1790752503779;
        Wed, 30 Sep 2026 00:15:03 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48b02a0185asm1271050f8f.32.2026.09.30.00.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:15:03 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 04/12] net: bridge: vlan: return VLAN entries from ingress helpers
Date: Wed, 30 Sep 2026 10:14:03 +0300
Message-ID: <20260930071411.2786201-5-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930071411.2786201-1-razor@blackwall.org>
References: <20260930071411.2786201-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Have the ingress helpers return the resolved vlan entry directly and let
callers derive the vid from it. This keeps the vlan available for later fdb
operations without carrying parallel vlan pointer and vid.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_device.c  |  5 +++--
 net/bridge/br_input.c   | 14 ++++++++------
 net/bridge/br_private.h | 12 +++++++-----
 net/bridge/br_vlan.c    | 38 +++++++++++++++++++++-----------------
 4 files changed, 39 insertions(+), 30 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index c6804409b60b..2423d69f2498 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -65,9 +65,10 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	skb_reset_mac_header(skb);
 	skb_pull(skb, ETH_HLEN);
 
-	if (!br_allowed_ingress(br, br_vlan_group_rcu(br), skb, &vid,
-				&state, &vlan))
+	if (!br_allowed_ingress(br, br_vlan_group_rcu(br), skb, &state,
+				&vlan))
 		goto out;
+	vid = vlan ? vlan->vid : 0;
 
 	if (IS_ENABLED(CONFIG_INET) &&
 	    (eth_hdr(skb)->h_proto == htons(ETH_P_ARP) ||
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 68aa8fa52eba..d9a0e1f65ec9 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -86,8 +86,8 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 	struct net_bridge_vlan *vlan;
 	struct net_bridge *br;
 	bool promisc;
-	u16 vid = 0;
 	u8 state;
+	u16 vid;
 
 	if (!p)
 		goto drop;
@@ -107,9 +107,10 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 
 	brmctx = &p->br->multicast_ctx;
 	pmctx = &p->multicast_ctx;
-	if (!br_allowed_ingress(p->br, nbp_vlan_group_rcu(p), skb, &vid,
-				&state, &vlan))
+	if (!br_allowed_ingress(p->br, nbp_vlan_group_rcu(p), skb, &state,
+				&vlan))
 		goto out;
+	vid = vlan ? vlan->vid : 0;
 
 	if (test_bit(BR_PORT_LOCKED_BIT, &p->flags)) {
 		struct net_bridge_fdb_entry *fdb_src =
@@ -245,14 +246,15 @@ EXPORT_SYMBOL_GPL(br_handle_frame_finish);
 static void __br_handle_local_finish(struct sk_buff *skb)
 {
 	struct net_bridge_port *p = br_port_get_rcu(skb->dev);
-	u16 vid = 0;
+	struct net_bridge_vlan *vlan;
 
 	/* check if vlan is allowed, to avoid spoofing */
 	if (test_bit(BR_LEARNING_BIT, &p->flags) &&
 	    nbp_state_should_learn(p) &&
 	    !br_opt_get(p->br, BROPT_NO_LL_LEARN) &&
-	    br_should_learn(p, skb, &vid))
-		br_fdb_update(p->br, p, eth_hdr(skb)->h_source, vid, 0);
+	    br_should_learn(p, skb, &vlan))
+		br_fdb_update(p->br, p, eth_hdr(skb)->h_source,
+			      vlan ? vlan->vid : 0, 0);
 }
 
 /* note: already called with rcu_read_lock */
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 2bf7f4429a3b..34e95741b940 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1702,11 +1702,11 @@ br_multicast_ctx_options_equal(const struct net_bridge_mcast *brmctx1,
 #ifdef CONFIG_BRIDGE_VLAN_FILTERING
 bool br_allowed_ingress(const struct net_bridge *br,
 			struct net_bridge_vlan_group *vg, struct sk_buff *skb,
-			u16 *vid, u8 *state,
-			struct net_bridge_vlan **vlan);
+			u8 *state, struct net_bridge_vlan **vlan);
 bool br_allowed_egress(struct net_bridge_vlan_group *vg,
 		       const struct sk_buff *skb);
-bool br_should_learn(struct net_bridge_port *p, struct sk_buff *skb, u16 *vid);
+bool br_should_learn(struct net_bridge_port *p, struct sk_buff *skb,
+		     struct net_bridge_vlan **vlan);
 struct sk_buff *br_handle_vlan(struct net_bridge *br,
 			       const struct net_bridge_port *port,
 			       struct net_bridge_vlan_group *vg,
@@ -1825,7 +1825,7 @@ static inline u16 br_vlan_flags(const struct net_bridge_vlan *v, u16 pvid)
 static inline bool br_allowed_ingress(const struct net_bridge *br,
 				      struct net_bridge_vlan_group *vg,
 				      struct sk_buff *skb,
-				      u16 *vid, u8 *state,
+				      u8 *state,
 				      struct net_bridge_vlan **vlan)
 
 {
@@ -1840,8 +1840,10 @@ static inline bool br_allowed_egress(struct net_bridge_vlan_group *vg,
 }
 
 static inline bool br_should_learn(struct net_bridge_port *p,
-				   struct sk_buff *skb, u16 *vid)
+				   struct sk_buff *skb,
+				   struct net_bridge_vlan **vlan)
 {
+	*vlan = NULL;
 	return true;
 }
 
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index ce5aa15c4540..471b4e7f0571 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -583,13 +583,13 @@ struct sk_buff *br_handle_vlan(struct net_bridge *br,
 /* Called under RCU */
 static bool __allowed_ingress(const struct net_bridge *br,
 			      struct net_bridge_vlan_group *vg,
-			      struct sk_buff *skb, u16 *vid,
-			      u8 *state,
+			      struct sk_buff *skb, u8 *state,
 			      struct net_bridge_vlan **vlan)
 {
 	struct pcpu_sw_netstats *stats;
 	struct net_bridge_vlan *v;
 	bool tagged;
+	u16 vid;
 
 	BR_INPUT_SKB_CB(skb)->vlan_filtered = true;
 	/* If vlan tx offload is disabled on bridge device and frame was
@@ -603,7 +603,7 @@ static bool __allowed_ingress(const struct net_bridge *br,
 			return false;
 	}
 
-	if (!br_vlan_get_tag(skb, vid)) {
+	if (!br_vlan_get_tag(skb, &vid)) {
 		/* Tagged frame */
 		if (skb->vlan_proto != br->vlan_proto) {
 			/* Protocol-mismatch, empty out vlan_tci for new tag */
@@ -615,7 +615,7 @@ static bool __allowed_ingress(const struct net_bridge *br,
 
 			skb_pull(skb, ETH_HLEN);
 			skb_reset_mac_len(skb);
-			*vid = 0;
+			vid = 0;
 			tagged = false;
 		} else {
 			tagged = true;
@@ -625,7 +625,7 @@ static bool __allowed_ingress(const struct net_bridge *br,
 		tagged = false;
 	}
 
-	if (!*vid) {
+	if (!vid) {
 		v = vg ? rcu_dereference(vg->pvid) : NULL;
 		/* Frame had a tag with VID 0 or did not have a tag.
 		 * See if pvid is set on this port.  That tells us which
@@ -637,7 +637,6 @@ static bool __allowed_ingress(const struct net_bridge *br,
 		/* PVID is set on this port.  Any untagged or priority-tagged
 		 * ingress frame is considered to belong to this vlan.
 		 */
-		*vid = v->vid;
 		if (likely(!tagged))
 			/* Untagged Frame. */
 			__vlan_hwaccel_put_tag(skb, br->vlan_proto, v->vid);
@@ -649,7 +648,7 @@ static bool __allowed_ingress(const struct net_bridge *br,
 			 */
 			skb->vlan_tci |= v->vid;
 	} else {
-		v = br_vlan_find(vg, *vid);
+		v = br_vlan_find(vg, vid);
 	}
 
 	if (!v || !br_vlan_should_use(v))
@@ -680,8 +679,7 @@ static bool __allowed_ingress(const struct net_bridge *br,
 
 bool br_allowed_ingress(const struct net_bridge *br,
 			struct net_bridge_vlan_group *vg, struct sk_buff *skb,
-			u16 *vid, u8 *state,
-			struct net_bridge_vlan **vlan)
+			u8 *state, struct net_bridge_vlan **vlan)
 {
 	/* If VLAN filtering is disabled on the bridge, all packets are
 	 * permitted.
@@ -692,7 +690,7 @@ bool br_allowed_ingress(const struct net_bridge *br,
 		return true;
 	}
 
-	return __allowed_ingress(br, vg, skb, vid, state, vlan);
+	return __allowed_ingress(br, vg, skb, state, vlan);
 }
 
 /* Called under RCU. */
@@ -716,11 +714,15 @@ bool br_allowed_egress(struct net_bridge_vlan_group *vg,
 }
 
 /* Called under RCU */
-bool br_should_learn(struct net_bridge_port *p, struct sk_buff *skb, u16 *vid)
+bool br_should_learn(struct net_bridge_port *p, struct sk_buff *skb,
+		     struct net_bridge_vlan **vlan)
 {
 	struct net_bridge_vlan_group *vg;
 	struct net_bridge *br = p->br;
 	struct net_bridge_vlan *v;
+	u16 vid;
+
+	*vlan = NULL;
 
 	/* If filtering was disabled at input, let it pass. */
 	if (!br_opt_get(br, BROPT_VLAN_ENABLED))
@@ -730,20 +732,22 @@ bool br_should_learn(struct net_bridge_port *p, struct sk_buff *skb, u16 *vid)
 	if (!vg || !READ_ONCE(vg->num_vlans))
 		return false;
 
-	if (!br_vlan_get_tag(skb, vid) && skb->vlan_proto != br->vlan_proto)
-		*vid = 0;
+	if (!br_vlan_get_tag(skb, &vid) && skb->vlan_proto != br->vlan_proto)
+		vid = 0;
 
-	if (!*vid) {
+	if (!vid) {
 		v = rcu_dereference(vg->pvid);
 		if (!v || !br_vlan_state_allowed(br_vlan_get_state(v), true))
 			return false;
-		*vid = v->vid;
+		*vlan = v;
 		return true;
 	}
 
-	v = br_vlan_find(vg, *vid);
-	if (v && br_vlan_state_allowed(br_vlan_get_state(v), true))
+	v = br_vlan_find(vg, vid);
+	if (v && br_vlan_state_allowed(br_vlan_get_state(v), true)) {
+		*vlan = v;
 		return true;
+	}
 
 	return false;
 }
-- 
2.47.3

