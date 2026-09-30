Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959DA44AB60
	for <bridge@lists.linux.dev>; Wed, 30 Sep 2026 07:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752505; cv=none; b=st0xlmAP/oG1ThHrkkKjjIlUtX9HiBVuB9ARjikFWc0A/oPlmtFIv0HFx8B5qydujTKFCzScxm+PguQAU3HFaW90R9QizBnVRrhs0OUnshNAYA3R+kjjNYd2+qTas7IE7fZh37vMSsyXfaDWxfV4p/LLPLDz0gxZ9mwyiaqAyCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752505; c=relaxed/simple;
	bh=dTiBQSAqNUCPQimax9dfyHtRfcRzLTbvLmgS/pJ+6ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZyP0wHw/1tfOZksGiwNEfztQBLkELf55xLIRWM1J+UFsAQZuiS6NYzFxAsDyErZW8HxiJzqcKwQl/UL/Xvod4qfoLazX60uwuSy2v7b2GyAFKDRbtxs6nVoijvpg9SvD3TetWNQh8I3BzAqmq++6vJviLjJPP6SUlH+Y3TbfyJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=ReJ323Er; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="ReJ323Er"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ffe817151so20705915e9.0
        for <bridge@lists.linux.dev>; Wed, 30 Sep 2026 00:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1790752500; x=1791357300; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dppy2RMjxXff0xR3i643pFaUYeOnG0KjFvmGOp9cnso=;
        b=ReJ323ErlFvRo1zCrW1qbymvpPv0QNyn/HmiHMEexYhvtNgi8/fwj3HkRBeaqZzmXq
         fTc6Y4KJpHingfA22kExeVHIOdkUrGj1uiL38W6GxkNdLcY141QxA7QGbe76cN7mu3GI
         u/PI1/S7qiwT6rU+J+rci7YBFp++HpwPNvQdoazbtIZqaXhIOdf9MQT29tQZOUxugs2R
         w52rL2Fia5UXpYHbSdzRln0z5wEA92u5fgdSWv1fw6HDK8cVIA+4UuH6SMHwb7rssFzJ
         rBFF0iA6kc87tnM60cZmA3u7sGpfpvSmU1bLI1nm9BcnEN4WOyPXxHh/EQckqi8vzE1p
         pQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752500; x=1791357300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dppy2RMjxXff0xR3i643pFaUYeOnG0KjFvmGOp9cnso=;
        b=DE0V3xmcToAyNE8voR5MNwkdW1C88PmN+FvWrz3GTvJ3+gut4Z703t/hxZYfVKTtNu
         htyzKX0dO05ZOG2u/Fb8uLUfV+LvPuteqVlY/fVEXUwgtvLYiZsrgHkbPpYDpKCq3N3g
         Jr813aq7JduYQlYCiVvcGwoPvHO1suXFApU11eo8bkOzlvpJugnEF6z6hojr2BYHiu4+
         1RkWtgmuKb+lce/VL6p3JefmjHiopXVsUJnxSvOzpDL5+xGDmpcDmm6d0FGDLxIv0272
         iUktXfRnMdsXWSRCBFrIerROQp7rGwultqMAHy8X9S7F8D5Rg3NNdlM9pMg5EMs60Z/1
         o/0g==
X-Forwarded-Encrypted: i=1; AKwUvBwUIpc1QDdLaFjJ+qrCxnnNDL/DETpiHUNcHmnIGW92ooHMRR/F5puQB3jq07qRT212TLmlBqc=@lists.linux.dev
X-Gm-Message-State: AFuF++nPyTGexYRJlvWHQMnB2ei4fOlD12km6zgpnvYxW0t+1SPIioFf
	6Kx3fAjtf7CNev2GlkA5WIqQetMx0f8u/yYDMqrWl304WfioZJMY1l3t5WIzsAr0YfY=
X-Gm-Gg: AYBFou3seU5+lFEv7t81NEtZ2OXA2aWpA/v2Z3w3QmGm9BFzeMSj2xvuSbv7wvlm4lg
	qo0kGet2r/PdiSI/vkiF85SwjiZjzN6ZAe6RedgWX+BkFr5mmKmZgQVYQakbk64OgDyyiWRoILh
	yFgvqdP6j85vV/qoNlvYCkT65zE3tz3YLV27nPTyTSukLp/4Dc3Yw46JpeJY3VP3l2wD1o9GzPV
	3ViKi1kcCPa1Xc1xaj0IDhxrIpczmeDahYvro3MVVHmu2Plq3QZ3ZtsjAiN9d/fF7aNMi+2UE8k
	kIu55XJdm4lbrXFFvJz0fX/sAdy6KR6cYV7Eor4LGqz4CAwGKADRrTV7WE59Y4CC5UewKgX4zOi
	bXlG0a2ydVL+DVDee590ft/oGiBYqzvEA1C6jHTXOyJnN4rIFQBzsmr+PFG45mdQ1AJF/YEtfBX
	0hbFMA/UExauYwsskVwYvWZjQTFVfNnBNUAwZOfr2T/zJXD9D5oz+N3DuT9UujrDfzS998rcyFk
	R/VYNvwV5Iqywq2pC27
X-Received: by 2002:a05:600c:840d:b0:4a0:108:3b54 with SMTP id 5b1f17b1804b1-4a01b128472mr6649425e9.32.1790752500227;
        Wed, 30 Sep 2026 00:15:00 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a017b67813sm18243925e9.2.2026.09.30.00.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:14:59 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH net-next 02/12] net: bridge: use net_bridge_dst for fdb destinations
Date: Wed, 30 Sep 2026 10:14:01 +0300
Message-ID: <20260930071411.2786201-3-razor@blackwall.org>
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

Store fdb destinations in struct net_bridge_dst and access them through
the destination helpers. This doesn't change their representation or
behavior, fdb destinations still contain only bridge port pointers.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Masami Hiramatsu <mhiramat@kernel.org>
CC: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

 include/trace/events/bridge.h |  7 +++--
 net/bridge/br_arp_nd_proxy.c  |  4 +--
 net/bridge/br_device.c        |  4 +--
 net/bridge/br_fdb.c           | 53 ++++++++++++++++++-----------------
 net/bridge/br_input.c         |  4 +--
 net/bridge/br_private.h       | 20 ++++++++++++-
 net/bridge/br_switchdev.c     |  2 +-
 7 files changed, 58 insertions(+), 36 deletions(-)

diff --git a/include/trace/events/bridge.h b/include/trace/events/bridge.h
index 3fe4725c83ff..f676516b33fa 100644
--- a/include/trace/events/bridge.h
+++ b/include/trace/events/bridge.h
@@ -68,13 +68,14 @@ TRACE_EVENT(br_fdb_external_learn_add,
 
 TRACE_EVENT(fdb_delete,
 
-	TP_PROTO(struct net_bridge *br, struct net_bridge_fdb_entry *f),
+	TP_PROTO(struct net_bridge *br, struct net_bridge_fdb_entry *f,
+		 const struct net_bridge_port *dst),
 
-	TP_ARGS(br, f),
+	TP_ARGS(br, f, dst),
 
 	TP_STRUCT__entry(
 		__string(br_dev, br->dev->name)
-		__string(dev, f->dst ? f->dst->dev->name : "null")
+		__string(dev, dst ? dst->dev->name : "null")
 		__array(unsigned char, addr, ETH_ALEN)
 		__field(u16, vid)
 	),
diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index da15f4d7c1ae..ba4a63840b21 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -223,7 +223,7 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 		neigh_ha_snapshot(ha, n, n->dev);
 		f = br_fdb_find_rcu(br, ha, vid);
 		if (f) {
-			const struct net_bridge_port *dst = READ_ONCE(f->dst);
+			const struct net_bridge_port *dst = br_fdb_dst_port(f);
 			bool replied = false;
 
 			if ((p && test_bit(BR_PROXYARP_BIT, &p->flags)) ||
@@ -500,7 +500,7 @@ void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
 		neigh_ha_snapshot(ha, n, n->dev);
 		f = br_fdb_find_rcu(br, ha, vid);
 		if (f) {
-			const struct net_bridge_port *dst = READ_ONCE(f->dst);
+			const struct net_bridge_port *dst = br_fdb_dst_port(f);
 			bool replied = false;
 
 			if (br_is_neigh_suppress_enabled_vid(dst, vid)) {
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index ce9ea9ac3d0a..c6804409b60b 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -107,7 +107,7 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 		else
 			br_flood(br, vlan, skb, BR_PKT_MULTICAST, false, true);
 	} else if ((dst = br_fdb_find_rcu(br, dest, vid)) != NULL) {
-		br_forward(READ_ONCE(dst->dst), skb, false, true);
+		br_forward(br_fdb_dst_port(dst), skb, false, true);
 	} else {
 		br_flood(br, vlan, skb, BR_PKT_UNICAST, false, true);
 	}
@@ -400,7 +400,7 @@ static int br_fill_forward_path(struct net_device_path_ctx *ctx,
 	if (!f)
 		return -1;
 
-	dst = READ_ONCE(f->dst);
+	dst = br_fdb_dst_port(f);
 	if (!dst)
 		return -1;
 
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index e4570bbed854..0f5cf5615b56 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -90,7 +90,7 @@ static int fdb_fill_info(struct sk_buff *skb, const struct net_bridge *br,
 			 const struct net_bridge_fdb_entry *fdb,
 			 u32 portid, u32 seq, int type, unsigned int flags)
 {
-	const struct net_bridge_port *dst = READ_ONCE(fdb->dst);
+	const struct net_bridge_port *dst = br_fdb_dst_port(fdb);
 	unsigned long now = jiffies;
 	struct nda_cacheinfo ci;
 	struct nlmsghdr *nlh;
@@ -250,7 +250,7 @@ struct net_device *br_fdb_find_port(const struct net_device *br_dev,
 	rcu_read_lock();
 	f = br_fdb_find_rcu(br, addr, vid);
 	if (f) {
-		dst = READ_ONCE(f->dst);
+		dst = br_fdb_dst_port(f);
 		if (dst)
 			dev = dst->dev;
 	}
@@ -315,7 +315,7 @@ static void fdb_del_hw_addr(struct net_bridge *br, const unsigned char *addr)
 static void fdb_delete(struct net_bridge *br, struct net_bridge_fdb_entry *f,
 		       bool swdev_notify)
 {
-	trace_fdb_delete(br, f);
+	trace_fdb_delete(br, f, br_fdb_dst_port(f));
 
 	if (test_bit(BR_FDB_STATIC, &f->flags))
 		fdb_del_hw_addr(br, f->key.addr.addr);
@@ -350,7 +350,7 @@ static void fdb_delete_local(struct net_bridge *br,
 		vg = nbp_vlan_group(op);
 		if (op != p && ether_addr_equal(op->dev->dev_addr, addr) &&
 		    (!vid || br_vlan_find(vg, vid))) {
-			WRITE_ONCE(f->dst, op);
+			br_fdb_dst_write(f, br_port_to_dst(op));
 			clear_bit(BR_FDB_ADDED_BY_USER, &f->flags);
 			return;
 		}
@@ -361,7 +361,7 @@ static void fdb_delete_local(struct net_bridge *br,
 	/* Maybe bridge device has same hw addr? */
 	if (p && ether_addr_equal(br->dev->dev_addr, addr) &&
 	    (!vid || (v && br_vlan_should_use(v)))) {
-		WRITE_ONCE(f->dst, NULL);
+		br_fdb_dst_write(f, br_port_to_dst(NULL));
 		clear_bit(BR_FDB_ADDED_BY_USER, &f->flags);
 		return;
 	}
@@ -378,7 +378,8 @@ void br_fdb_find_delete_local(struct net_bridge *br,
 	spin_lock_bh(&br->hash_lock);
 	f = br_fdb_find(br, addr, vid);
 	if (f && test_bit(BR_FDB_LOCAL, &f->flags) &&
-	    !test_bit(BR_FDB_ADDED_BY_USER, &f->flags) && f->dst == p)
+	    !test_bit(BR_FDB_ADDED_BY_USER, &f->flags) &&
+	    br_fdb_dst_port(f) == p)
 		fdb_delete_local(br, p, f);
 	spin_unlock_bh(&br->hash_lock);
 }
@@ -408,7 +409,7 @@ static struct net_bridge_fdb_entry *fdb_create(struct net_bridge *br,
 		return NULL;
 
 	memcpy(fdb->key.addr.addr, addr, ETH_ALEN);
-	WRITE_ONCE(fdb->dst, source);
+	br_fdb_dst_write(fdb, br_port_to_dst(source));
 	fdb->key.vlan_id = vid;
 	fdb->flags = flags;
 	fdb->updated = fdb->used = jiffies;
@@ -470,7 +471,7 @@ void br_fdb_changeaddr(struct net_bridge_port *p, const unsigned char *newaddr)
 	spin_lock_bh(&br->hash_lock);
 	vg = nbp_vlan_group(p);
 	hlist_for_each_entry(f, &br->fdb_list, fdb_node) {
-		if (READ_ONCE(f->dst) == p &&
+		if (br_fdb_dst_port(f) == p &&
 		    test_bit(BR_FDB_LOCAL, &f->flags) &&
 		    !test_bit(BR_FDB_ADDED_BY_USER, &f->flags)) {
 			/* delete old one */
@@ -517,7 +518,8 @@ void br_fdb_change_mac_address(struct net_bridge *br, const u8 *newaddr)
 	/* If old entry was unassociated with any port, then delete it. */
 	f = br_fdb_find(br, br->dev->dev_addr, 0);
 	if (f && test_bit(BR_FDB_LOCAL, &f->flags) &&
-	    !f->dst && !test_bit(BR_FDB_ADDED_BY_USER, &f->flags))
+	    !br_fdb_dst_port(f) &&
+	    !test_bit(BR_FDB_ADDED_BY_USER, &f->flags))
 		fdb_delete_local(br, NULL, f);
 
 	fdb_add_local(br, NULL, newaddr, 0);
@@ -533,7 +535,8 @@ void br_fdb_change_mac_address(struct net_bridge *br, const u8 *newaddr)
 			continue;
 		f = br_fdb_find(br, br->dev->dev_addr, v->vid);
 		if (f && test_bit(BR_FDB_LOCAL, &f->flags) &&
-		    !f->dst && !test_bit(BR_FDB_ADDED_BY_USER, &f->flags))
+		    !br_fdb_dst_port(f) &&
+		    !test_bit(BR_FDB_ADDED_BY_USER, &f->flags))
 			fdb_delete_local(br, NULL, f);
 		fdb_add_local(br, NULL, newaddr, v->vid);
 	}
@@ -693,7 +696,7 @@ static bool __fdb_flush_matches(const struct net_bridge *br,
 				const struct net_bridge_fdb_entry *f,
 				const struct net_bridge_fdb_flush_desc *desc)
 {
-	const struct net_bridge_port *dst = READ_ONCE(f->dst);
+	const struct net_bridge_port *dst = br_fdb_dst_port(f);
 	int port_ifidx = dst ? dst->dev->ifindex : br->dev->ifindex;
 
 	if (desc->vlan_id && desc->vlan_id != f->key.vlan_id)
@@ -879,7 +882,7 @@ void br_fdb_delete_by_port(struct net_bridge *br,
 
 	spin_lock_bh(&br->hash_lock);
 	hlist_for_each_entry_safe(f, tmp, &br->fdb_list, fdb_node) {
-		if (READ_ONCE(f->dst) != p)
+		if (br_fdb_dst_port(f) != p)
 			continue;
 
 		if (!do_all)
@@ -921,7 +924,7 @@ int br_fdb_fillbuf(struct net_bridge *br, void *buf,
 			continue;
 
 		/* ignore pseudo entry for local MAC address */
-		dst = READ_ONCE(f->dst);
+		dst = br_fdb_dst_port(f);
 		if (!dst)
 			continue;
 
@@ -996,10 +999,10 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 			}
 
 			/* fastpath: update of existing entry */
-			if (unlikely(source != READ_ONCE(fdb->dst) &&
+			if (unlikely(source != br_fdb_dst_port(fdb) &&
 				     !test_bit(BR_FDB_STICKY, &fdb->flags))) {
 				br_switchdev_fdb_notify(br, fdb, RTM_DELNEIGH);
-				WRITE_ONCE(fdb->dst, source);
+				br_fdb_dst_write(fdb, br_port_to_dst(source));
 				fdb_modified = true;
 				/* Take over HW learned entry */
 				if (unlikely(test_bit(BR_FDB_ADDED_BY_EXT_LEARN,
@@ -1061,17 +1064,17 @@ int br_fdb_dump(struct sk_buff *skb,
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(f, &br->fdb_list, fdb_node) {
-		const struct net_bridge_port *dst = READ_ONCE(f->dst);
+		const struct net_bridge_port *dst = br_fdb_dst_port(f);
 
 		if (*idx < ctx->fdb_idx)
 			goto skip;
 		if (filter_dev && (!dst || dst->dev != filter_dev)) {
 			if (filter_dev != dev)
 				goto skip;
-			/* !f->dst is a special case for bridge
+			/* A NULL destination is a special case for bridge
 			 * It means the MAC belongs to the bridge
 			 * Therefore need a little more filtering
-			 * we only want to dump the !f->dst case
+			 * we only want to dump the NULL destination case
 			 */
 			if (dst)
 				goto skip;
@@ -1193,8 +1196,8 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
 		if (flags & NLM_F_EXCL)
 			return -EEXIST;
 
-		if (READ_ONCE(fdb->dst) != source) {
-			WRITE_ONCE(fdb->dst, source);
+		if (br_fdb_dst_port(fdb) != source) {
+			br_fdb_dst_write(fdb, br_port_to_dst(source));
 			modified = true;
 		}
 
@@ -1385,7 +1388,7 @@ static int fdb_delete_by_addr_and_port(struct net_bridge *br,
 	struct net_bridge_fdb_entry *fdb;
 
 	fdb = br_fdb_find(br, addr, vlan);
-	if (!fdb || READ_ONCE(fdb->dst) != p)
+	if (!fdb || br_fdb_dst_port(fdb) != p)
 		return -ENOENT;
 
 	fdb_delete(br, fdb, true);
@@ -1541,15 +1544,15 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 	} else {
 		if (locked &&
 		    (!test_bit(BR_FDB_LOCKED, &fdb->flags) ||
-		     READ_ONCE(fdb->dst) != p)) {
+		     br_fdb_dst_port(fdb) != p)) {
 			err = -EINVAL;
 			goto err_unlock;
 		}
 
 		WRITE_ONCE(fdb->updated, jiffies);
 
-		if (READ_ONCE(fdb->dst) != p) {
-			WRITE_ONCE(fdb->dst, p);
+		if (br_fdb_dst_port(fdb) != p) {
+			br_fdb_dst_write(fdb, br_port_to_dst(p));
 			modified = true;
 		}
 
@@ -1632,7 +1635,7 @@ void br_fdb_clear_offload(const struct net_device *dev, u16 vid)
 
 	spin_lock_bh(&p->br->hash_lock);
 	hlist_for_each_entry(f, &p->br->fdb_list, fdb_node) {
-		if (READ_ONCE(f->dst) == p && f->key.vlan_id == vid)
+		if (br_fdb_dst_port(f) == p && f->key.vlan_id == vid)
 			clear_bit(BR_FDB_OFFLOADED, &f->flags);
 	}
 	spin_unlock_bh(&p->br->hash_lock);
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 4357d78524a6..68aa8fa52eba 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -123,7 +123,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 				br_fdb_update(br, p, eth_hdr(skb)->h_source,
 					      vid, BIT(BR_FDB_LOCKED));
 			goto drop;
-		} else if (READ_ONCE(fdb_src->dst) != p ||
+		} else if (br_fdb_dst_port(fdb_src) != p ||
 			   test_bit(BR_FDB_LOCAL, &fdb_src->flags)) {
 			/* FDB mismatch. Drop the packet without roaming. */
 			goto drop;
@@ -223,7 +223,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 
 		if (now != READ_ONCE(dst->used))
 			WRITE_ONCE(dst->used, now);
-		br_forward(READ_ONCE(dst->dst), skb, local_rcv, false);
+		br_forward(br_fdb_dst_port(dst), skb, local_rcv, false);
 	} else {
 		if (!mcast_hit)
 			br_flood(br, vlan, skb, pkt_type, local_rcv, false);
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 1146187aa2ba..bbb59b53e745 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -312,7 +312,7 @@ struct net_bridge_dst {
 
 struct net_bridge_fdb_entry {
 	struct rhash_head		rhnode;
-	struct net_bridge_port		*dst;
+	struct net_bridge_dst		dst;
 
 	struct net_bridge_fdb_key	key;
 	struct hlist_node		fdb_node;
@@ -708,6 +708,24 @@ br_dst_port(struct net_bridge_dst dst)
 	return (struct net_bridge_port *)ACCESS_PRIVATE(&dst, value);
 }
 
+static inline struct net_bridge_dst
+br_fdb_dst_read(const struct net_bridge_fdb_entry *fdb)
+{
+	return br_dst_read(&fdb->dst);
+}
+
+static inline void br_fdb_dst_write(struct net_bridge_fdb_entry *fdb,
+				    struct net_bridge_dst dst)
+{
+	br_dst_write(&fdb->dst, dst);
+}
+
+static inline struct net_bridge_port *
+br_fdb_dst_port(const struct net_bridge_fdb_entry *fdb)
+{
+	return br_dst_port(br_fdb_dst_read(fdb));
+}
+
 /* called under bridge lock */
 static inline int br_is_root_bridge(const struct net_bridge *br)
 {
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 990c6b38fd39..10f3aea6a1f8 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -129,7 +129,7 @@ static void br_switchdev_fdb_populate(struct net_bridge *br,
 				      const struct net_bridge_fdb_entry *fdb,
 				      const void *ctx)
 {
-	const struct net_bridge_port *p = READ_ONCE(fdb->dst);
+	const struct net_bridge_port *p = br_fdb_dst_port(fdb);
 
 	item->addr = fdb->key.addr.addr;
 	item->vid = fdb->key.vlan_id;
-- 
2.47.3

