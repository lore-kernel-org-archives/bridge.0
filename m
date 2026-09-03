Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468174BB80A
	for <bridge@lists.linux.dev>; Thu,  3 Sep 2026 14:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445952; cv=none; b=FXnhi0h+dlicA/6iUns+Udv5TyOlGVQgLlp8V9iHSRZf+MFdMq5xCLrF1SWSMi1oq+Uj2TsP+M4ZZ4ABtcjEv5c5/Nyr776chMx0/k6ZsGtQUs5ZURp8+whpol7dBnwW85b6eo9QcJPFkfMxMpqy/OPikWuhwAo0IZ8es+zScTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445952; c=relaxed/simple;
	bh=InjVNAvLxGWDYxEK1AeR3eh5gYArP4jBsLz0CYulbSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RpSG4UlLeAyezjyJUGvc4NAQTbmq6Kx4kRPCoD/NcPGg6a3y2XJZmsaWM1xIfGXIpuW923Bn9UlSWiBgZZUMyV5Kbfn/Z1AlWeOOVRIktb75cmS/HhEEnEEe2fLx+YT6W4THfFtBeNoj9HRYjUblaIyYEo4a5MlbfR/5735F9ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=g5pZrYuL; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="g5pZrYuL"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49b9320423cso24868915e9.0
        for <bridge@lists.linux.dev>; Thu, 03 Sep 2026 07:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788445937; x=1789050737; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N/K6O5S2pm84VRJixVdZrdWBEd51ncYWpRSnUeYge4o=;
        b=g5pZrYuLTP61dzN5VyZsfHf9Xj9FAqO40e31mhnm841uRdCZkAROyF4POgQkrXzexM
         xqmxi5EFbLv7LK1SzfiLW9ESeZiVLmqbsrZyAx3E5AtCQrJHaXaq4J+0wte6KWfTzYgz
         aLaJXm22lc4p/uW/5oKXpA3gSRxAc2f9/nR5F8B6NLr7cRb2NGTPSdsj8MUgHqUUokcN
         /f6IGBTL3/UwqBbbrjCvN9GsDeDgJUEpXEEohRprgywiE59w+tGVotniJiggmvZmJWcN
         P5fw2KqyB6r30/zRlTTtyq48H2YLTyw23vViFV9wRzaVpMTbBzrtKX3IGMZFYsYy+Yc4
         BGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788445937; x=1789050737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N/K6O5S2pm84VRJixVdZrdWBEd51ncYWpRSnUeYge4o=;
        b=lZxhWcw4CoFc/7tl7NU30wt2VA/knFOgj8tW2VBdZnXineSJM8CXKlPJf4VKq7HIpS
         wyvzx9+s/IRkbDqZHtfqDmwRvePX39mTM5e/3HJ+3jhGDSMJe0beTuEYRXt4oovpHSv0
         oOYkPtD/PMo/bf5pTjjpnqzJwCtODTIxzZwh7BGBxhyhO49x33Yw1/oxtil0W24bil7i
         fvGpxrStqjfUQCbrObXTf9Al21hFC4fKwP1nkWFqYol/yYx4r7itORHTpcLQCh3CAlqO
         4IzodF94SpD0jtvSB14OfV9Wipbi18HdXF+nWmp2NDSNTosLXSbLjXCBFK0A8Wid3AKL
         arlQ==
X-Forwarded-Encrypted: i=1; AKwUvBzdstGBUmUwL3/sVon/hvsE7zgtgXMLvCsd/AlJZjoEVuSZLZLbIJ8cocBifdJlgn0PrINxip8=@lists.linux.dev
X-Gm-Message-State: AFuF++me/FR7/0w8oTVIZr/8/766heSJNy/tL81u1396OihjmmLES3iv
	HRqkx3n0NXlXwQ3ZWoUwy64Gjej/rlcbcsFOFHBMtpNxzZsOauAXUT31tDdlPKKNJa1hP04Ofci
	4gYVfmLY=
X-Gm-Gg: AYBFou2rB3U6tGQJVZ0BB/7yLtHYk8ab7shfRLQPL0f/RAeLcne9eRSX9TC/hyHs0vo
	LuOcqNPbyvQZXWElzaQS9SM3PoIiozOp3DyYK9ukyl4LR5v7A48LAxCPLP5nAVFSdhiS9uta6Ve
	vJeiPIJZPjVWwRnrYqDK06yckphJuOjOemAr/NkUgl7cpAgHnvlmND9awdo/hXG9Ev+UpumnaTG
	KNznhten+6+cJeRjI6q770bn9ucIXF0qKHJ6vzlaH0BbAosZln395l3R5RxeBUekAnI4EmocdJ6
	Mo3ooT9BPu1vyflXmxeOkx5aCt15nxXFE8UmIs83WgiWvi716oUhmAgTzh0EIRKx68gBi7WQOkb
	XCU8lIkXtaeibMPb45kChD1yJzk8G0WBX8M8t6Z+73VMv0bWQTMfXwH7cu3U6UMpjW5CLe7rYSC
	nt6ESQPxjdTG9DHlkLQbk9tNDcwjdAgUi7Te1jDUi55EbQA073jlwaB+4xiBP7GLZiY5ElJaofX
	iBJEL1mDk8=
X-Received: by 2002:a05:600c:3e0a:b0:499:a277:e8b5 with SMTP id 5b1f17b1804b1-49ce5810b5dmr289604115e9.3.1788445937075;
        Thu, 03 Sep 2026 07:32:17 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49cee5d5d12sm74337245e9.5.2026.09.03.07.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:32:16 -0700 (PDT)
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
Subject: [PATCH net-next v2 9/9] net: bridge: use br_vlan_get_state to get vlan state
Date: Thu,  3 Sep 2026 17:31:38 +0300
Message-ID: <20260903143138.1574598-10-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260903143138.1574598-1-razor@blackwall.org>
References: <20260903143138.1574598-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vlan state can change under RTNL or RCU (mst), so use the helper
to get the state properly throughout the bridge driver.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
v2: use br_vlan_get_state consistently where needed (Ido)

 net/bridge/br_mst.c          |  7 ++++---
 net/bridge/br_private.h      | 21 +++++++++++----------
 net/bridge/br_vlan.c         |  2 +-
 net/bridge/br_vlan_options.c |  2 +-
 4 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index 76a5bf287578..ecd8bba7430e 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -70,7 +70,7 @@ int br_mst_get_state(const struct net_device *dev, u16 msti, u8 *state)
 
 	list_for_each_entry(v, &vg->vlan_list, vlist) {
 		if (v->brvlan->msti == msti) {
-			*state = v->state;
+			*state = br_vlan_get_state(v);
 			return 0;
 		}
 	}
@@ -145,7 +145,7 @@ static void br_mst_vlan_sync_state(struct net_bridge_vlan *pv, u16 msti)
 		 * it.
 		 */
 		if (v != pv && v->brvlan->msti == msti) {
-			br_mst_vlan_set_state(vg, pv, v->state);
+			br_mst_vlan_set_state(vg, pv, br_vlan_get_state(v));
 			return;
 		}
 	}
@@ -282,7 +282,8 @@ int br_mst_fill_info(struct sk_buff *skb,
 		nest = nla_nest_start_noflag(skb, IFLA_BRIDGE_MST_ENTRY);
 		if (!nest ||
 		    nla_put_u16(skb, IFLA_BRIDGE_MST_ENTRY_MSTI, v->brvlan->msti) ||
-		    nla_put_u8(skb, IFLA_BRIDGE_MST_ENTRY_STATE, v->state)) {
+		    nla_put_u8(skb, IFLA_BRIDGE_MST_ENTRY_STATE,
+			       br_vlan_get_state(v))) {
 			err = -EMSGSIZE;
 			break;
 		}
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index c7b64b5da012..df1500391f1d 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -687,6 +687,15 @@ static inline bool br_vlan_should_use(const struct net_bridge_vlan *v)
 	return true;
 }
 
+/* The vlan state can be changed with only rcu held by the mst code so
+ * annotate the lock-free read. br_vlan_set_state() is kept further down
+ * because it needs br_multicast_update_vlan_mcast_ctx().
+ */
+static inline u8 br_vlan_get_state(const struct net_bridge_vlan *v)
+{
+	return READ_ONCE(v->state);
+}
+
 static inline bool nbp_state_should_learn(const struct net_bridge_port *p)
 {
 	return p->state == BR_STATE_LEARNING || p->state == BR_STATE_FORWARDING;
@@ -1299,7 +1308,7 @@ br_multicast_port_ctx_state_disabled(const struct net_bridge_mcast_port *pmctx)
 	return pmctx->port->state == BR_STATE_DISABLED ||
 	       (br_multicast_port_ctx_is_vlan(pmctx) &&
 		(br_multicast_port_ctx_vlan_disabled(pmctx) ||
-		 pmctx->vlan->state == BR_STATE_DISABLED));
+		 br_vlan_get_state(pmctx->vlan) == BR_STATE_DISABLED));
 }
 
 static inline bool
@@ -1308,7 +1317,7 @@ br_multicast_port_ctx_state_stopped(const struct net_bridge_mcast_port *pmctx)
 	return br_multicast_port_ctx_state_disabled(pmctx) ||
 	       pmctx->port->state == BR_STATE_BLOCKING ||
 	       (br_multicast_port_ctx_is_vlan(pmctx) &&
-		pmctx->vlan->state == BR_STATE_BLOCKING);
+		br_vlan_get_state(pmctx->vlan) == BR_STATE_BLOCKING);
 }
 
 static inline bool
@@ -1916,14 +1925,6 @@ bool br_vlan_global_opts_can_enter_range(const struct net_bridge_vlan *v_curr,
 bool br_vlan_global_opts_fill(struct sk_buff *skb, u16 vid, u16 vid_range,
 			      const struct net_bridge_vlan *v_opts);
 
-/* vlan state manipulation helpers using *_ONCE to annotate lock-free access,
- * while br_vlan_set_state() may access data protected by multicast_lock.
- */
-static inline u8 br_vlan_get_state(const struct net_bridge_vlan *v)
-{
-	return READ_ONCE(v->state);
-}
-
 static inline void br_vlan_set_state(struct net_bridge_vlan *v, u8 state)
 {
 	WRITE_ONCE(v->state, state);
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 95187a607ec2..72b75757ac85 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -40,7 +40,7 @@ static void __vlan_add_pvid(struct net_bridge_vlan_group *vg,
 	if (vg->pvid == v->vid)
 		return;
 
-	br_vlan_set_pvid_state(vg, v->state);
+	br_vlan_set_pvid_state(vg, br_vlan_get_state(v));
 	WRITE_ONCE(vg->pvid, v->vid);
 }
 
diff --git a/net/bridge/br_vlan_options.c b/net/bridge/br_vlan_options.c
index bd049d268fe7..506668fc31d9 100644
--- a/net/bridge/br_vlan_options.c
+++ b/net/bridge/br_vlan_options.c
@@ -43,7 +43,7 @@ bool br_vlan_opts_eq_range(const struct net_bridge_vlan *v_curr,
 	u8 range_mc_rtr = br_vlan_multicast_router(range_end);
 	u8 curr_mc_rtr = br_vlan_multicast_router(v_curr);
 
-	if (v_curr->state != range_end->state)
+	if (br_vlan_get_state(v_curr) != br_vlan_get_state(range_end))
 		return false;
 
 	if (!__vlan_tun_can_enter_range(v_curr, range_end))
-- 
2.47.3

