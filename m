Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2BD3CF039
	for <bridge@lists.linux.dev>; Fri, 18 Sep 2026 15:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745405; cv=none; b=gBFuLKRcpenisi0t2vAFgWv8UmSWiNuWWAtviDp39IwrtvkvcHy8N7SLW6dydFrxbGeIJgnmMnM6PWFGibBrGIBqqWwbcu2HeBBL6QSct0wS2inTZpazbN70igqpki5TyPO7bHdBccuvtfa/VaVmkqc2/Ca+418Nu/8KdChdv9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745405; c=relaxed/simple;
	bh=wh/bHCNeZ8brFM9mHguqzK+B6LsJ1VdkUPeyNq6PVRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTH/ABnnbscD799tPb1FJhN6VKzv6c29R/TiQtyUC/PVFMz2nud2xR0+X/8aIoHhwRbVjbd4l5ftEkOzQViKxoL3v/1K6p/7XMFKuryylgBFOZkhaR2Jl2VCf0M+ldoghctqF41fwfovZll7AqTYzjiWAsIniPLOY2SCGI32XB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=e4oJBqxu; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="e4oJBqxu"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso8193705e9.0
        for <bridge@lists.linux.dev>; Fri, 18 Sep 2026 08:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1789745400; x=1790350200; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V/mESpr7P8gp/+NUtEjgIAXHo83bjFVemJXHNz8KJSA=;
        b=e4oJBqxuzfa4kot/mx7EVhFCjtgRQshvI/6Y3MdR0NYOZDiHYbsBcEcoRXU74VdPLp
         wa4aIQ367YK1sbEF35X+1BwFEtGr2VuUIv4+3kaB6/gfFBPZouv2lhy8s9rivf5Ey0J7
         w1t9KZaylorCZevMx8DYa3tvOvmFeydbuFz9yJTTwHNOC75ibpXslMVepnAQq28LD+mh
         yADZ4TDqe6N4CT2FwXd0vD3aPY4AveyJJbA8P6ytG0XZ7Fpq1/ykAjqKNcZQFAfMpZpj
         dQCrMh3/qqS+xnC3Eb+axWoOMzrf4oXaN93RdPD+FgZS7eplqzd13HmaEIsbfVnckboI
         4/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789745400; x=1790350200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V/mESpr7P8gp/+NUtEjgIAXHo83bjFVemJXHNz8KJSA=;
        b=j0Ts/ppjgNCRG9LP+Hof1MCOUaiwt7bHZIce6RqRvzmbPZx6sbKgWXXfkOb/on5JwO
         W8TvDMe2eU2NTXqQVnPYRWrEuiGi/IwlWdLkiEgS/a4T0v75a3NlkrFnsruYJFKpBlub
         BrddTZjruzhkjWTygggmI5h7ElfRmDZe82SYFpsCSxw+nVCKPv2sF5ykbMUtTGAoZlOJ
         /SbMQa3IEDbQpysEbA26fmWMcjom9O6kn6pcP4xQrl457wn3mfYuTt9aej265Nlbd0Lj
         q7KqtivplbalCBUvc7jXbU3FaAKWREcDswXdB6zX53OhZWROEVKtDU3gTnWyRu4Tfcee
         95sg==
X-Forwarded-Encrypted: i=1; AKwUvBxjXqv/2GXwiR0+m3F4wwIpB8aW5VRMmc3Vnja/7qhc6D1OQcwCs6mcu+DhQRh042mo8IDrIfk=@lists.linux.dev
X-Gm-Message-State: AFuF++mrqdDygQ06mrg21y7S9+0vwxdJH17vJFwToZyAremqR/U0XKYk
	AmWRXy+eHd8MQnhu/ZAZxAB7Fc/hHyyIX9H7NwkY59CgtUzDRrvcdw0IMTiqqx3BNgA=
X-Gm-Gg: AYBFou22xS5UkNai3inXEY3gKIbcEzuNosc8/8BNICi8g7eCxon41/5xkMiOi+9Oj8b
	QNcb69nD+D6kGOfD3RXrcqn5ToOtCdAu9bmdHmtPJ2hEKAF9yGWrEZo61aTBB8z//9OXEW2kzgD
	KpSe+FAmjjfznwNG/ItX3hThU1D6WtYGY8KHUjskR872vRPFdBtHcK2a7sU4SsTA6or4fh+JJpl
	/yVELKcpSOgbn40tk9BFQFg8OlnRlK4/iCxcSsxB8ntbchu5UtPNPYMUfP8NyfeD44QSeDPR5DZ
	RXFbDD3a4nJGg/+lcDP7oOYsZXLlXMGdLxEQdhq73Qbsp8cz4ZRcXHOqiaStWH64skk+l0GEvCD
	hBUSi0s9/W37IkmOIrOWjjKrnXLA6nf1yDcVUj9hqBUyQsCihXvWkC59pr5Ndv49D1EuhpO9d9j
	y7zexzVMShJKpQ+0ylGF1+OojU4mRkdjl1BvjVz1vR+KtiIgkyR2jOj0FzkNDOqAz3GN4m0dowg
	q+UkUMh/Sf1V6QjpwxtVQ==
X-Received: by 2002:a7b:cb46:0:b0:49e:7185:22ac with SMTP id 5b1f17b1804b1-49fbd148e69mr72188415e9.0.1789745400017;
        Fri, 18 Sep 2026 08:30:00 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4872008f34dsm5013491f8f.36.2026.09.18.08.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 08:29:59 -0700 (PDT)
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
Subject: [PATCH net-next 5/9] net: bridge: consider only port-VLAN members when flooding
Date: Fri, 18 Sep 2026 18:29:46 +0300
Message-ID: <20260918152950.1938259-6-razor@blackwall.org>
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

Use the port-VLAN list that is in every master VLAN and consider only
participating port-VLANs when flooding packets. This is the first
optimization that greatly improves performance for sparse port VLANs
e.g. 2 out of 32 ports participating in a single VLAN: before the
bridge would consider all 32 ports and forward the packet only through
the 2, now it will only consider the participating 2 ports.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 From local sashiko run:
 [Severity: Medium]
 Can this loop skip a newly added port VLAN while __vlan_add() is between
 its two RCU publication steps?

 In net/bridge/br_vlan.c:__vlan_add(), the port VLAN is first published in
 the ingress lookup hash:

    err = rhashtable_lookup_insert_fast(&vg->vlan_hash, &v->vnode,
                                        br_vlan_rht_params);
    if (err)
        goto out_fdb_insert;

    __vlan_add_list(v);

 Only the subsequent net/bridge/br_vlan.c:__vlan_add_list() call publishes
 it in the list now used by net/bridge/br_forward.c:br_flood():

    list_add_rcu(&v->port_vlist, &v->brvlan->port_vlist);

 A concurrent tagged frame can follow br_handle_frame_finish() through
 net/bridge/br_vlan.c:__allowed_ingress() and find the new VLAN here:

    v = br_vlan_find(vg, *vid);

 If the destination requires flooding, can it then reach br_flood() before
 the port VLAN appears in port_vlist?  With hairpin mode enabled, that would
 omit the required copy through the ingress port.  The same window can omit
 the newly enabled port for broadcast, multicast, or unknown-unicast traffic
 originated by net/bridge/br_device.c:br_dev_xmit().

 RTNL serializes configuration writers, but the RCU packet path does not take
 RTNL.  Is there another mechanism that makes the hash insertion and
 port_vlist insertion appear atomic to these readers?

 Before this change, br_flood() traversed every bridge port, and its egress
 VLAN lookup could find the already hash-published VLAN.  Could the flood
 membership publication be made consistent with the hash publication before
 the secondary membership set becomes authoritative?

 The later series state appears to select masterv->port_array when present
 and masterv->port_vlist otherwise, so it still floods exclusively through a
 secondary membership set.  Would the same hash-before-secondary-publication
 window remain in that state as well?

 Nik: Yes, both loops (list and array) can skip it, but that is ok.

 net/bridge/br_device.c  |  8 ++++----
 net/bridge/br_forward.c | 29 +++++++++++++++++++++--------
 net/bridge/br_input.c   |  2 +-
 net/bridge/br_private.h |  6 +++---
 4 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index e01c44a90d84..ce9ea9ac3d0a 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -89,10 +89,10 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	dest = eth_hdr(skb)->h_dest;
 	if (is_broadcast_ether_addr(dest)) {
-		br_flood(br, skb, BR_PKT_BROADCAST, false, true, vid);
+		br_flood(br, vlan, skb, BR_PKT_BROADCAST, false, true);
 	} else if (is_multicast_ether_addr(dest)) {
 		if (unlikely(netpoll_tx_running(dev))) {
-			br_flood(br, skb, BR_PKT_MULTICAST, false, true, vid);
+			br_flood(br, vlan, skb, BR_PKT_MULTICAST, false, true);
 			goto out;
 		}
 		if (br_multicast_rcv(&brmctx, &pmctx_null, vlan, skb, vid)) {
@@ -105,11 +105,11 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 		    br_multicast_querier_exists(brmctx, eth_hdr(skb), mdst))
 			br_multicast_flood(mdst, skb, brmctx, false, true);
 		else
-			br_flood(br, skb, BR_PKT_MULTICAST, false, true, vid);
+			br_flood(br, vlan, skb, BR_PKT_MULTICAST, false, true);
 	} else if ((dst = br_fdb_find_rcu(br, dest, vid)) != NULL) {
 		br_forward(READ_ONCE(dst->dst), skb, false, true);
 	} else {
-		br_flood(br, skb, BR_PKT_UNICAST, false, true, vid);
+		br_flood(br, vlan, skb, BR_PKT_UNICAST, false, true);
 	}
 out:
 	rcu_read_unlock();
diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index a696c6c128e3..251d61e7c312 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -262,19 +262,32 @@ static void br_flood_port(struct net_bridge_port **prev,
 }
 
 /* called under rcu_read_lock */
-void br_flood(struct net_bridge *br, struct sk_buff *skb,
-	      enum br_pkt_type pkt_type, bool local_rcv, bool local_orig,
-	      u16 vid)
+void br_flood(struct net_bridge *br, struct net_bridge_vlan *v,
+	      struct sk_buff *skb, enum br_pkt_type pkt_type,
+	      bool local_rcv, bool local_orig)
 {
 	struct net_bridge_port *prev = NULL;
-	struct net_bridge_port *p;
 
 	br_tc_skb_miss_set(skb, pkt_type != BR_PKT_BROADCAST);
 
-	list_for_each_entry_rcu(p, &br->port_list, list) {
-		br_flood_port(&prev, p, skb, pkt_type, local_orig, vid);
-		if (IS_ERR(prev))
-			break;
+	if (v) {
+		struct net_bridge_vlan *masterv, *pv;
+
+		masterv = br_vlan_is_master(v) ? v : v->brvlan;
+		list_for_each_entry_rcu(pv, &masterv->port_vlist, port_vlist) {
+			br_flood_port(&prev, pv->port, skb, pkt_type,
+				      local_orig, v->vid);
+			if (IS_ERR(prev))
+				break;
+		}
+	} else {
+		struct net_bridge_port *p;
+
+		list_for_each_entry_rcu(p, &br->port_list, list) {
+			br_flood_port(&prev, p, skb, pkt_type, local_orig, 0);
+			if (IS_ERR(prev))
+				break;
+		}
 	}
 
 	br_flood_finish(prev, skb, local_rcv, local_orig);
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 8bed72baf161..b20c7c182a80 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -226,7 +226,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 		br_forward(READ_ONCE(dst->dst), skb, local_rcv, false);
 	} else {
 		if (!mcast_hit)
-			br_flood(br, skb, pkt_type, local_rcv, false, vid);
+			br_flood(br, vlan, skb, pkt_type, local_rcv, false);
 		else
 			br_multicast_flood(mdst, skb, brmctx, local_rcv, false);
 	}
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index b2a12b6298cb..239cf58d2268 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -912,9 +912,9 @@ int br_dev_queue_push_xmit(struct net *net, struct sock *sk, struct sk_buff *skb
 void br_forward(const struct net_bridge_port *to, struct sk_buff *skb,
 		bool local_rcv, bool local_orig);
 int br_forward_finish(struct net *net, struct sock *sk, struct sk_buff *skb);
-void br_flood(struct net_bridge *br, struct sk_buff *skb,
-	      enum br_pkt_type pkt_type, bool local_rcv, bool local_orig,
-	      u16 vid);
+void br_flood(struct net_bridge *br, struct net_bridge_vlan *v,
+	      struct sk_buff *skb, enum br_pkt_type pkt_type,
+	      bool local_rcv, bool local_orig);
 
 /* return true if both source port and dest port are isolated */
 static inline bool br_skb_isolated(const struct net_bridge_port *to,
-- 
2.47.3

