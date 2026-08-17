Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B00142D747
	for <bridge@lists.linux.dev>; Mon, 17 Aug 2026 14:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786977398; cv=none; b=D3vlF8u7MuqXEYyF1X0Ia3TMiqz/Um3mSgKlWBB/kf/6syoPytUPCEjIW5onMS1ougJvoVDNLrlyBbd7hV6fWnr5gFLWY8Gm+hIGTTvVr8puzB/NQCNtPDO7HdeF5F3eprtj/zCZFF0NoNXyo1Z6BskLv7HXzl1KwxCu/jY+LzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786977398; c=relaxed/simple;
	bh=5HBoqnGtnzRNqan8IWTOyFmdRKtOx6N/Ms/8+AHi84w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LaSdV49uPzzRgn5+bJAWoVh/S8Y2XAxoBSLVtrWj+5XFT19U2ACwf2RZBxosTNPbx1WRDEq7O4zxfoA3hgMQ9m2b+zFyDNg0EMVY00AZaepsPhdCjFxFQldUlNqvNWjse6sSsVYTuxUxgljeRw0zKve65lgXk0u8iZUiRGYSK4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=LwaCE9gA; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="LwaCE9gA"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-495590dde14so43821805e9.0
        for <bridge@lists.linux.dev>; Mon, 17 Aug 2026 07:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1786977395; x=1787582195; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=evyEuxoOZz3lNtLTNY5/6S0gQr/PcairTmXOnH8x5Rk=;
        b=LwaCE9gAjofGTiHxGvy2sODLgiWEbxzSY5YTpI6Ng/3AXdRdD48ZxcBamkx8rS+t91
         NvGDmvp5jjwyMyy/v7mScl8eeRqQjGKbr+FlzKapdeWR7z6mtFqV6MdhV+WiVv/pHUkb
         3J4mFPFAOmnRjX5xrshPOaGg/Z1RRF3pK1WUrcC0aTQ4+ED6XjLHzVYBd30c31bydYNv
         Omkcdl1y9g05/dwRsvcwB1jvz/QZhtyn42VwzfkdUeLkQHbh7q1lbNDcEza/ltFAcCFc
         QKZIHcskwke9tFX4FTgsF1X/S7lu4jVL5zR7x1wpR/F9YtQuB0PcSglBYzyM3SRLmiH6
         noQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786977395; x=1787582195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=evyEuxoOZz3lNtLTNY5/6S0gQr/PcairTmXOnH8x5Rk=;
        b=SpcvyRt2rcBxWfmLjcpp89NtYjy3bALAPsVeS4jokRs1IyvvaiquPVzErwY2BERoU4
         P+hJ08BLLuoKthHzKBBBzD3bF+asQm0y/Ww9uZc4rw/nm7MMZLtNtWY7oWuQ31DoAKib
         JBejtbPrJZJoB2MGWD6Uf7skZ3oIiLiFzqw4Dk5AJinqIa63dPNGHlVxBxfUs5udBho6
         c6heYpWtOupToxupVHvpouuoPgcIVgWPMoxfwW4LA7gflvoFZQii8LnHict44WeqocHI
         TWScYBIOI6NCsU0edqaV+F4XVhmhi55pJ+zQmPVrTa+GzwCq+GCttZJ9DktDYCuWcICo
         kU7Q==
X-Forwarded-Encrypted: i=1; AHgh+RqfxCeY5opoeBGbbrUEYTT8pXUEdhB1+uqsntp+67dZ575BafH85azmg/uGT0xgWZvXoMvkPCI=@lists.linux.dev
X-Gm-Message-State: AOJu0YxEDkBY1Yr0VlRqPTCmlMIOsuKN+cQyfg7xULKCFq09y14VyQKt
	7aq9Xx6MUniRZgWJWIbiob3BTFcbdzihbEAbloFe1hQUzK2Gt20Xc1ODrf/T2NJjjmA=
X-Gm-Gg: AR+sD11Qq5palKLIE/CiynIBURhzXNxaCMBrHpfXM24zPAFSo3GvCyvjdOy6Deg34k3
	hmmoVOcsIqVMXhRMFkJa8ywBCaqlt4BIR1vDZovxIK9IJjNdymCxBjUixasikfnhSyKF2smTl5X
	zmZk9BM1RlgqZO7Z5kcFNbCNHDJ2T7j2suoZ9p9Vi6Ru3ynBeJPFdYrKhYA6gAbCEYreO5xVOpe
	bWs1BYtqrPq8luv3tH0pVXBqcDoNx1camxqDwihCJgpOyxzpdwxMQ6BpAKtdrdplfWtcGCa6y/h
	//0DfZiSu8DBimoc5cKb0kqclJ0MHyP48rBIwlmZ9Jw7UCoxc6B1l/DFed9eHyNeuALbDC2OUpG
	Xa3eV10ac8rl1g097Rti2s9GFxJHNM4s8zWicKNKDIcgpLFyPeyAOevZ546Gna/vI4ncH8qxNGf
	phEjCwqqw7risOVMNA5mtLQfr3ekz3Y3nv+JkOA0dt3jv/rQSl3+lqTVjMQRe5hujdgSsl8AQgw
	XBzRAyZEPg=
X-Received: by 2002:a05:600c:5246:b0:495:4d5c:903e with SMTP id 5b1f17b1804b1-4999fb2e492mr7123935e9.7.1786977394789;
        Mon, 17 Aug 2026 07:36:34 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-482a5b783basm4514691f8f.30.2026.08.17.07.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 07:36:34 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	roopa@nvidia.com,
	bridge@lists.linux.dev,
	andrew+netdev@lunn.ch,
	dlstevens@us.ibm.com,
	amwang@redhat.com,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net 1/2] net: bridge: arp/nd proxy: fix reading neigh ha
Date: Mon, 17 Aug 2026 17:36:12 +0300
Message-ID: <20260817143613.685769-2-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260817143613.685769-1-razor@blackwall.org>
References: <20260817143613.685769-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently neigh ha address is read directly, but that can result in
torn/partial reads if the neigh is being updated. Use neigh_ha_snapshot
to take a stable snapshot of the address.

Fixes: 057658cb33fb ("bridge: suppress arp pkts on BR_NEIGH_SUPPRESS ports")
Fixes: ed842faeb2bd ("bridge: suppress nd pkts on BR_NEIGH_SUPPRESS ports")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_arp_nd_proxy.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index 23eb6931a2b4..e994f01ed04e 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -195,13 +195,15 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 	n = neigh_lookup(&arp_tbl, &tip, vlandev);
 	if (n) {
 		struct net_bridge_fdb_entry *f;
+		u8 ha[MAX_ADDR_LEN];
 
 		if (!(READ_ONCE(n->nud_state) & NUD_VALID)) {
 			neigh_release(n);
 			return;
 		}
 
-		f = br_fdb_find_rcu(br, n->ha, vid);
+		neigh_ha_snapshot(ha, n, n->dev);
+		f = br_fdb_find_rcu(br, ha, vid);
 		if (f) {
 			const struct net_bridge_port *dst = READ_ONCE(f->dst);
 			bool replied = false;
@@ -211,10 +213,10 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 			    br_is_neigh_suppress_enabled(dst, vid)) {
 				if (!vid)
 					br_arp_send(br, p, skb->dev, sip, tip,
-						    sha, n->ha, sha, 0, 0);
+						    sha, ha, sha, 0, 0);
 				else
 					br_arp_send(br, p, skb->dev, sip, tip,
-						    sha, n->ha, sha,
+						    sha, ha, sha,
 						    skb->vlan_proto,
 						    skb_vlan_tag_get(skb));
 				replied = true;
@@ -252,7 +254,7 @@ struct nd_msg *br_is_nd_neigh_msg(const struct sk_buff *skb, struct nd_msg *msg)
 }
 
 static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
-		       struct sk_buff *request, struct neighbour *n,
+		       struct sk_buff *request, struct neighbour *n, u8 *ha,
 		       __be16 vlan_proto, u16 vlan_tci)
 {
 	struct net_device *dev = request->dev;
@@ -310,7 +312,7 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
 		ipv6_eth_mc_map(&in6addr_linklocal_allnodes, eth_hdr(reply)->h_dest);
 	else
 		ether_addr_copy(eth_hdr(reply)->h_dest, daddr);
-	ether_addr_copy(eth_hdr(reply)->h_source, n->ha);
+	ether_addr_copy(eth_hdr(reply)->h_source, ha);
 	eth_hdr(reply)->h_proto = htons(ETH_P_IPV6);
 	reply->protocol = htons(ETH_P_IPV6);
 
@@ -340,7 +342,7 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
 	na->icmph.icmp6_override = 1;
 	na->icmph.icmp6_solicited = dad ? 0 : 1;
 	na->target = ns->target;
-	ether_addr_copy(&na->opt[2], n->ha);
+	ether_addr_copy(&na->opt[2], ha);
 	na->opt[0] = ND_OPT_TARGET_LL_ADDR;
 	na->opt[1] = na_olen >> 3;
 
@@ -369,7 +371,7 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
 		__vlan_hwaccel_put_tag(reply, vlan_proto, vlan_tci);
 
 	netdev_dbg(dev, "nd send dev %s dst %pI6 dst_hw %pM src %pI6 src_hw %pM\n",
-		   dev->name, &pip6->daddr, daddr, &pip6->saddr, n->ha);
+		   dev->name, &pip6->daddr, daddr, &pip6->saddr, ha);
 
 	if (p) {
 		dev_queue_xmit(reply);
@@ -472,24 +474,26 @@ void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
 	n = neigh_lookup(&nd_tbl, &msg->target, vlandev);
 	if (n) {
 		struct net_bridge_fdb_entry *f;
+		u8 ha[MAX_ADDR_LEN];
 
 		if (!(READ_ONCE(n->nud_state) & NUD_VALID)) {
 			neigh_release(n);
 			return;
 		}
 
-		f = br_fdb_find_rcu(br, n->ha, vid);
+		neigh_ha_snapshot(ha, n, n->dev);
+		f = br_fdb_find_rcu(br, ha, vid);
 		if (f) {
 			const struct net_bridge_port *dst = READ_ONCE(f->dst);
 			bool replied = false;
 
 			if (br_is_neigh_suppress_enabled(dst, vid)) {
 				if (vid != 0)
-					br_nd_send(br, p, skb, n,
+					br_nd_send(br, p, skb, n, ha,
 						   skb->vlan_proto,
 						   skb_vlan_tag_get(skb));
 				else
-					br_nd_send(br, p, skb, n, 0, 0);
+					br_nd_send(br, p, skb, n, ha, 0, 0);
 				replied = true;
 			}
 
-- 
2.47.3

