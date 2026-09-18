Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1013B50277A
	for <bridge@lists.linux.dev>; Fri, 18 Sep 2026 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745401; cv=none; b=dc9iOH/eTK4xybFopLtBOrOUlnXuct6fsTdEYcce5cV1EEMYA7NGjWVAZKp72Xl03V2mPyT5pblGo/5Zq/2RhfTernfYFGKlTlFX1FYxViyn42z6Fx6F8Tblc2Bsa7WEEnCnVOyQcpISkTWVmZ7IWuyvqCW6k/4etX9J/pRUU7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745401; c=relaxed/simple;
	bh=17NOFVoHTFRZtmBU8VcbvFQORg1E7zTFJ8D9MkrCkGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LofjHETnJKoqSOrZcBnTFJ535wt3RTpdcCodegbXXEiGPT3hi+Ebs2okV1LWZxMYNEOaDW7/82N8LAVO8ayBJy/3b72jhoNmYFZmNZOG7aqAbmFGTCDLyEZgTuwPRDQC9TqFxz206/8Qn9p1OEAPz+sLI+x9dtoQN0hcPvsNZeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=V/dbBy7E; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="V/dbBy7E"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912e4b11so5287605e9.3
        for <bridge@lists.linux.dev>; Fri, 18 Sep 2026 08:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1789745397; x=1790350197; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e6togQ4gMpUP7rpLltEx0vdjyZqCFDV6vC/es0QEpLc=;
        b=V/dbBy7EmK/dB/e3K0pU9Vq45Du+HhhbruaXMEQokiGGwF6Knzrc2QyC1lyjmJxdXV
         pJvdSDO4V9zmUqd/Fmnbi8yRlW6OlAT8PwPbn/FyCOUqY9I18YCApPBxsbj/izO7Itz3
         N9rdqoUzio29gbjJp7XZrC7a1vvlnpWytbuyogQVn+AH7jr2FEOjLIVX4bbkGW5PDV/B
         rxMUy+RKuh+sp03tdn4tgFYhCCMLBqBiaEIjXMw8VUxcM0vpoELchufgAb4SI0zppxHL
         GO8QOF8D66zVVhFc/0P+GWj/u6zIgesKSq2KVOehO7ap7RxEdJH9JnAGKrCmcjKBk60a
         Ih9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789745397; x=1790350197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e6togQ4gMpUP7rpLltEx0vdjyZqCFDV6vC/es0QEpLc=;
        b=fb0ZaqZpT30aNgo8MNzNcmkFdElM4DgIGSEgfcMllj0PNab6E9+ckIiaY0okt52EtX
         PoyKqFRWM2BfyH7KKTdTiw8vynbirlxqYo20B7qX/5nFtlCB8gkymEeMUSCom5U8f1rV
         NrQs3AB34KRgsjArmEo3L3pKpC27nRyHOyfyoLU4Coj6LROuouA5R7duoaX7aN1E/ksx
         nvATVgQD1SF8146RA3RWryDlBRj2sI7wQ9r1EudfkE/RJawcRa2hR79AbnPNKErxpMkT
         UdiLGuUMnvpAuCK+XnUSGW/vkCTF5hVkbcTb53LQ2eA7XdeTEC3JsoKxLXa8m2gKTtEN
         U4Dg==
X-Forwarded-Encrypted: i=1; AKwUvByh3CnhN8VZLRZ9TQ+/Rpy6+8ZTd4hJczk3kbhIvi0gKIFXNmQYoxE1ntkv6FhZn2Z8AtMUFSQ=@lists.linux.dev
X-Gm-Message-State: AFuF++lpY7QFSt2s3jTXzvXyA6WnLwLwnf/b7y04DQvs+bxxSaA4Yta+
	hqgIfIoLC2qrDlONWVm5UW3bKwWqv52FGYReoP/HuIebDrC9WbVQA3aeRUG4UhtUyd8=
X-Gm-Gg: AYBFou3iTrtdQdoAB1yYtlvFTRtWxHeX2jeTghzUExbg/2OQKAle7t15SdBlaq+Cquf
	ng42uwWQkrwfn49Hr6mG/AIde7tMCs8mdiOkWyX5KRFKUI71AiO70No352mUH+swBFjWCtiW9k8
	lc6jbU12I1wS5+jtmoRjtPm1/hwVtvyBeSFqcYORlmUzVVFD4TY4zq3IyMsX/GhTMMr5HK58DyI
	Daa3Ih1RN5re8LaRIc9SLQwg06Q6w33XSLMkHib3lg+upsaqeUZXc79Bo3ZPHeYFTFEW1VW7QJD
	MPwnY99cn3Y51z3TaCPN3Cf4HB6beS/Jz1uevu8m/ZjxhXSlG5GctQDyNDlxlFo11uOyKBJxqLu
	9p28/oxNK+Fol9I6M9sXToC+Qi5K2l/JcSZfKmBCb8hGhuZEyIKhlUG8t0kzi6m9gyPCqUT4KgS
	TjvbbUdZ8pEUIKe7zb+lvvMy1AGwZ8QWgsMua+roP0GIve26KoPQSZd2g3OHHxlXTZ2IdzJ5228
	8hyCeH6zeZFS9Lu3KlrYyTJCRXG/WN3ZA==
X-Received: by 2002:a05:600c:19cd:b0:49c:fc6e:a3da with SMTP id 5b1f17b1804b1-49fc584fc7bmr39814655e9.25.1789745397104;
        Fri, 18 Sep 2026 08:29:57 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49fcd07411fsm563905e9.7.2026.09.18.08.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 08:29:56 -0700 (PDT)
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
Subject: [PATCH net-next 3/9] net: bridge: vlan: cache the pvid vlan entry directly
Date: Fri, 18 Sep 2026 18:29:44 +0300
Message-ID: <20260918152950.1938259-4-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918152950.1938259-1-razor@blackwall.org>
References: <20260918152950.1938259-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VLAN groups cache the pvid and its state separately requiring state
updates to keep both copies synchronized. Lockless readers can also
observe the pvid and state from different updates. Cache an rcu protected
pointer to the pvid vlan entry instead. This makes the vlan entry the
single source of truth and lets the ingress path reuse it without another
lookup. It also makes the vlan entry always available at the ingress path
for subsequent forwarding-path optimizations.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_mst.c          | 13 ++----
 net/bridge/br_private.h      | 25 +++++-------
 net/bridge/br_vlan.c         | 76 ++++++++++++++----------------------
 net/bridge/br_vlan_options.c | 12 ++----
 4 files changed, 46 insertions(+), 80 deletions(-)

diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index 63fc1dd0e9bc..252d5c927f71 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -79,16 +79,11 @@ int br_mst_get_state(const struct net_device *dev, u16 msti, u8 *state)
 }
 EXPORT_SYMBOL_GPL(br_mst_get_state);
 
-static void br_mst_vlan_set_state(struct net_bridge_vlan_group *vg,
-				  struct net_bridge_vlan *v,
-				  u8 state)
+static void br_mst_vlan_set_state(struct net_bridge_vlan *v, u8 state)
 {
 	if (br_vlan_get_state(v) == state)
 		return;
 
-	if (v->vid == br_get_pvid(vg))
-		br_vlan_set_pvid_state(vg, state);
-
 	br_vlan_set_state(v, state);
 }
 
@@ -129,7 +124,7 @@ int br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state,
 		if (READ_ONCE(v->brvlan->msti) != msti)
 			continue;
 
-		br_mst_vlan_set_state(vg, v, state);
+		br_mst_vlan_set_state(v, state);
 	}
 
 out_rcu_unlock:
@@ -149,13 +144,13 @@ static void br_mst_vlan_sync_state(struct net_bridge_vlan *pv, u16 msti)
 		 * it.
 		 */
 		if (v != pv && v->brvlan->msti == msti) {
-			br_mst_vlan_set_state(vg, pv, br_vlan_get_state(v));
+			br_mst_vlan_set_state(pv, br_vlan_get_state(v));
 			return;
 		}
 	}
 
 	/* Otherwise, start out in a new MSTI with all ports disabled. */
-	return br_mst_vlan_set_state(vg, pv, BR_STATE_DISABLED);
+	return br_mst_vlan_set_state(pv, BR_STATE_DISABLED);
 }
 
 int br_mst_vlan_set_msti(struct net_bridge_vlan *mv, u16 msti)
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 09c397e30330..bda25f851342 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -256,8 +256,7 @@ struct net_bridge_vlan {
  * @tunnel_hash: Hash table to map from tunnel key ID (e.g. VXLAN VNI) to VLAN
  * @vlan_list: sorted VLAN entry list
  * @num_vlans: number of total VLAN entries
- * @pvid: PVID VLAN id
- * @pvid_state: PVID's STP state (e.g. forwarding, learning, blocking)
+ * @pvid: RCU-protected PVID VLAN entry
  *
  * IMPORTANT: Be careful when checking if there're VLAN entries using list
  *            primitives because the bridge can have entries in its list which
@@ -269,9 +268,8 @@ struct net_bridge_vlan_group {
 	struct rhashtable		vlan_hash;
 	struct rhashtable		tunnel_hash;
 	struct list_head		vlan_list;
+	struct net_bridge_vlan		__rcu *pvid;
 	u16				num_vlans;
-	u16				pvid;
-	u8				pvid_state;
 };
 
 /* bridge fdb flags */
@@ -1687,10 +1685,16 @@ static inline int br_vlan_get_tag(const struct sk_buff *skb, u16 *vid)
 
 static inline u16 br_get_pvid(const struct net_bridge_vlan_group *vg)
 {
+	struct net_bridge_vlan *pvid;
+
 	if (!vg)
 		return 0;
 
-	return READ_ONCE(vg->pvid);
+	pvid = rcu_dereference_rtnl(vg->pvid);
+	if (!pvid)
+		return 0;
+
+	return pvid->vid;
 }
 
 static inline u16 br_vlan_flags(const struct net_bridge_vlan *v, u16 pvid)
@@ -1922,17 +1926,6 @@ static inline void br_vlan_set_state(struct net_bridge_vlan *v, u8 state)
 	br_multicast_update_vlan_mcast_ctx(v, state);
 }
 
-static inline u8 br_vlan_get_pvid_state(const struct net_bridge_vlan_group *vg)
-{
-	return READ_ONCE(vg->pvid_state);
-}
-
-static inline void br_vlan_set_pvid_state(struct net_bridge_vlan_group *vg,
-					  u8 state)
-{
-	WRITE_ONCE(vg->pvid_state, state);
-}
-
 /* learn_allow is true at ingress and false at egress */
 static inline bool br_vlan_state_allowed(u8 state, bool learn_allow)
 {
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 34ede0f3e452..bfedd13e3fd4 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -35,21 +35,21 @@ static struct net_bridge_vlan *br_vlan_lookup(struct rhashtable *tbl, u16 vid)
 }
 
 static void __vlan_add_pvid(struct net_bridge_vlan_group *vg,
-			    const struct net_bridge_vlan *v)
+			    struct net_bridge_vlan *v)
 {
-	if (vg->pvid == v->vid)
+	if (rcu_access_pointer(vg->pvid) == v)
 		return;
 
-	br_vlan_set_pvid_state(vg, br_vlan_get_state(v));
-	WRITE_ONCE(vg->pvid, v->vid);
+	RCU_INIT_POINTER(vg->pvid, v);
 }
 
-static void __vlan_delete_pvid(struct net_bridge_vlan_group *vg, u16 vid)
+static void __vlan_delete_pvid(struct net_bridge_vlan_group *vg,
+			       struct net_bridge_vlan *v)
 {
-	if (vg->pvid != vid)
+	if (rcu_access_pointer(vg->pvid) != v)
 		return;
 
-	WRITE_ONCE(vg->pvid, 0);
+	RCU_INIT_POINTER(vg->pvid, NULL);
 }
 
 /* Update the BRIDGE_VLAN_INFO_PVID and BRIDGE_VLAN_INFO_UNTAGGED flags of @v.
@@ -60,6 +60,7 @@ static bool __vlan_flags_update(struct net_bridge_vlan *v, u16 flags,
 				bool commit)
 {
 	struct net_bridge_vlan_group *vg;
+	struct net_bridge_vlan *pvid;
 	u16 vlan_flags;
 	bool change;
 
@@ -70,7 +71,8 @@ static bool __vlan_flags_update(struct net_bridge_vlan *v, u16 flags,
 
 	/* check if anything would be changed on commit */
 	vlan_flags = v->flags;
-	change = !!(flags & BRIDGE_VLAN_INFO_PVID) == !!(vg->pvid != v->vid) ||
+	pvid = rtnl_dereference(vg->pvid);
+	change = !!(flags & BRIDGE_VLAN_INFO_PVID) == !!(pvid != v) ||
 		 ((flags ^ vlan_flags) & BRIDGE_VLAN_INFO_UNTAGGED);
 
 	if (!commit)
@@ -79,7 +81,7 @@ static bool __vlan_flags_update(struct net_bridge_vlan *v, u16 flags,
 	if (flags & BRIDGE_VLAN_INFO_PVID)
 		__vlan_add_pvid(vg, v);
 	else
-		__vlan_delete_pvid(vg, v->vid);
+		__vlan_delete_pvid(vg, v);
 
 	if (flags & BRIDGE_VLAN_INFO_UNTAGGED)
 		vlan_flags |= BRIDGE_VLAN_INFO_UNTAGGED;
@@ -403,7 +405,7 @@ static void __vlan_del(struct net_bridge_vlan *v)
 		masterv = v->brvlan;
 	}
 
-	__vlan_delete_pvid(vg, v->vid);
+	__vlan_delete_pvid(vg, v);
 	if (p) {
 		err = __vlan_vid_del(p->dev, p->br, v);
 		if (err)
@@ -453,7 +455,7 @@ static void __vlan_flush(const struct net_bridge *br,
 	struct net_bridge_vlan *vlan, *tmp;
 	u16 v_start = 0, v_end = 0;
 
-	__vlan_delete_pvid(vg, vg->pvid);
+	__vlan_delete_pvid(vg, rtnl_dereference(vg->pvid));
 	list_for_each_entry_safe(vlan, tmp, &vg->vlan_list, vlist) {
 		/* take care of disjoint ranges */
 		if (!v_start) {
@@ -579,42 +581,32 @@ static bool __allowed_ingress(const struct net_bridge *br,
 	}
 
 	if (!*vid) {
-		u16 pvid = br_get_pvid(vg);
-
+		v = vg ? rcu_dereference(vg->pvid) : NULL;
 		/* Frame had a tag with VID 0 or did not have a tag.
 		 * See if pvid is set on this port.  That tells us which
 		 * vlan untagged or priority-tagged traffic belongs to.
 		 */
-		if (!pvid)
+		if (!v)
 			goto drop;
 
 		/* PVID is set on this port.  Any untagged or priority-tagged
 		 * ingress frame is considered to belong to this vlan.
 		 */
-		*vid = pvid;
+		*vid = v->vid;
 		if (likely(!tagged))
 			/* Untagged Frame. */
-			__vlan_hwaccel_put_tag(skb, br->vlan_proto, pvid);
+			__vlan_hwaccel_put_tag(skb, br->vlan_proto, v->vid);
 		else
 			/* Priority-tagged Frame.
 			 * At this point, we know that skb->vlan_tci VID
 			 * field was 0.
 			 * We update only VID field and preserve PCP field.
 			 */
-			skb->vlan_tci |= pvid;
-
-		/* if snooping and stats are disabled we can avoid the lookup */
-		if (!br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED) &&
-		    !br_opt_get(br, BROPT_VLAN_STATS_ENABLED)) {
-			if (*state == BR_STATE_FORWARDING) {
-				*state = br_vlan_get_pvid_state(vg);
-				if (!br_vlan_state_allowed(*state, true))
-					goto drop;
-			}
-			return true;
-		}
+			skb->vlan_tci |= v->vid;
+	} else {
+		v = br_vlan_find(vg, *vid);
 	}
-	v = br_vlan_find(vg, *vid);
+
 	if (!v || !br_vlan_should_use(v))
 		goto drop;
 
@@ -697,11 +689,10 @@ bool br_should_learn(struct net_bridge_port *p, struct sk_buff *skb, u16 *vid)
 		*vid = 0;
 
 	if (!*vid) {
-		*vid = br_get_pvid(vg);
-		if (!*vid ||
-		    !br_vlan_state_allowed(br_vlan_get_pvid_state(vg), true))
+		v = rcu_dereference(vg->pvid);
+		if (!v || !br_vlan_state_allowed(br_vlan_get_state(v), true))
 			return false;
-
+		*vid = v->vid;
 		return true;
 	}
 
@@ -1061,17 +1052,10 @@ int br_vlan_set_stats_per_port(struct net_bridge *br, unsigned long val)
 
 static bool vlan_default_pvid(struct net_bridge_vlan_group *vg, u16 vid)
 {
-	struct net_bridge_vlan *v;
-
-	if (vid != vg->pvid)
-		return false;
+	struct net_bridge_vlan *pvid = rtnl_dereference(vg->pvid);
 
-	v = br_vlan_lookup(&vg->vlan_hash, vid);
-	if (v && br_vlan_should_use(v) &&
-	    (v->flags & BRIDGE_VLAN_INFO_UNTAGGED))
-		return true;
-
-	return false;
+	return pvid && pvid->vid == vid && br_vlan_should_use(pvid) &&
+	       (pvid->flags & BRIDGE_VLAN_INFO_UNTAGGED);
 }
 
 static void br_vlan_disable_default_pvid(struct net_bridge *br)
@@ -1524,7 +1508,7 @@ int br_vlan_get_info(const struct net_device *dev, u16 vid,
 
 	p_vinfo->vid = vid;
 	p_vinfo->flags = v->flags;
-	if (vid == br_get_pvid(vg))
+	if (v == rcu_access_pointer(vg->pvid))
 		p_vinfo->flags |= BRIDGE_VLAN_INFO_PVID;
 	return 0;
 }
@@ -1551,7 +1535,7 @@ int br_vlan_get_info_rcu(const struct net_device *dev, u16 vid,
 
 	p_vinfo->vid = vid;
 	p_vinfo->flags = READ_ONCE(v->flags);
-	if (vid == br_get_pvid(vg))
+	if (v == rcu_access_pointer(vg->pvid))
 		p_vinfo->flags |= BRIDGE_VLAN_INFO_PVID;
 	return 0;
 }
@@ -1956,7 +1940,7 @@ void br_vlan_notify(const struct net_bridge *br,
 			goto out_kfree;
 
 		flags = v->flags;
-		if (br_get_pvid(vg) == v->vid)
+		if (v == rcu_access_pointer(vg->pvid))
 			flags |= BRIDGE_VLAN_INFO_PVID;
 		break;
 	case RTM_DELVLAN:
diff --git a/net/bridge/br_vlan_options.c b/net/bridge/br_vlan_options.c
index 506668fc31d9..e4b7a147e42b 100644
--- a/net/bridge/br_vlan_options.c
+++ b/net/bridge/br_vlan_options.c
@@ -110,8 +110,7 @@ size_t br_vlan_opts_nl_size(void)
 	       + 0;
 }
 
-static int br_vlan_modify_state(struct net_bridge_vlan_group *vg,
-				struct net_bridge_vlan *v,
+static int br_vlan_modify_state(struct net_bridge_vlan *v,
 				u8 state,
 				bool *changed,
 				struct netlink_ext_ack *extack)
@@ -143,9 +142,6 @@ static int br_vlan_modify_state(struct net_bridge_vlan_group *vg,
 	if (v->state == state)
 		return 0;
 
-	if (v->vid == br_get_pvid(vg))
-		br_vlan_set_pvid_state(vg, state);
-
 	br_vlan_set_state(v, state);
 	*changed = true;
 
@@ -216,7 +212,6 @@ static int br_vlan_modify_tunnel(const struct net_bridge_port *p,
 
 static int br_vlan_process_one_opts(const struct net_bridge *br,
 				    const struct net_bridge_port *p,
-				    struct net_bridge_vlan_group *vg,
 				    struct net_bridge_vlan *v,
 				    struct nlattr **tb,
 				    bool *changed,
@@ -228,7 +223,7 @@ static int br_vlan_process_one_opts(const struct net_bridge *br,
 	if (tb[BRIDGE_VLANDB_ENTRY_STATE]) {
 		u8 state = nla_get_u8(tb[BRIDGE_VLANDB_ENTRY_STATE]);
 
-		err = br_vlan_modify_state(vg, v, state, changed, extack);
+		err = br_vlan_modify_state(v, state, changed, extack);
 		if (err)
 			return err;
 	}
@@ -339,8 +334,7 @@ int br_vlan_process_options(const struct net_bridge *br,
 			break;
 		}
 
-		err = br_vlan_process_one_opts(br, p, vg, v, tb, &changed,
-					       extack);
+		err = br_vlan_process_one_opts(br, p, v, tb, &changed, extack);
 		if (err)
 			break;
 
-- 
2.47.3

