Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E129503BC3
	for <bridge@lists.linux.dev>; Fri, 18 Sep 2026 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745409; cv=none; b=hWJnh7+WmKZCPgVLPRYHyplgFz53lVI7+kTgMpxMIiB377Z/7u8izz2W6jT8sdUmIGUhuuq7bDKEX4s1UibO6X7O7Q/Mwo5jibJcz6E16P0WC4cuHYU5JTulOdCYN7hdSJ1qZZ3sT2yF0xgr0cyOGrifJAor9pmmSyzZK4eebvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745409; c=relaxed/simple;
	bh=2EPOkJReona5TRx2q4HJ29Rjz2csI9JBpQqH0yD1h0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQDKl3vCSYUeuA8q4IBGOlOXSI30mgaDt4QSwDuXtIbIL2hMVrQL83wnSnrGP7eYqB77bOqN2kwa/dPs/o2ZXtisz1Ume1I4HZwqJm3M9Ry3dwhz4pDYsmCavGzzTrtPyYl0rplDzbXNrQkCb4mkQOW7zhmRWzgxUs9W7UHUdxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=iEiqqEn3; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="iEiqqEn3"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49d097b4939so4666525e9.0
        for <bridge@lists.linux.dev>; Fri, 18 Sep 2026 08:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1789745406; x=1790350206; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qt8/dPuDVCuLlG8nkmLCpJqVQajFZPFEOjgY24MqgXY=;
        b=iEiqqEn3sLZOY3/WP1Vua9y2IIF5HtlnPzVvnKUN7aEXC60yV3lzbUuk9QJb2xAlnm
         sCsedNtP/LJFPwVLILkIcvbTQU6ruwmYdPbEJPiNHR9u4EtC/CtnlerKD1zKO2xBYEWu
         HfNEaq+z9py3DxaPrRwVjF57tRWSwVO4IgThFUlTdTiJ/l14zswepW49fpwOTsjWXxXV
         j4CNJ/dGmXvWw+Y0raUEYo0PkxhS6A6lmmvYR19JmsicmdfNCdZpEmSfoQwD0p4X39oo
         yZdOpjPQ6h9qwi3aTbP1Cv9Db/3Au7U5pf3hQkFdu5+rpV+aZlRHw0yT+Ou+zrsoGMDv
         PmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789745406; x=1790350206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qt8/dPuDVCuLlG8nkmLCpJqVQajFZPFEOjgY24MqgXY=;
        b=Mp02L4jldRajCXgvb+YqULUaA7YarboxLJy/1ID1GyK7nNClr0z2/OBNUzq4gXsA3N
         WTKslvCYB5cYCp9uaVgCmERWi9TdnyKQJ2QSaABXi8syDr+o5WPPKwhI17++jbKFLTUM
         gyAZBqgqZdfQZXyfy5KB6WNVXVDkupeuNLwbM6t38IMv/1ZqBhG+WqjstN7QHctwOVlC
         TEJT5jjcU6NNoGh4uD48nStP/rGB9A06tN48tLDj8oNI/KrYdsE+EHeYSiC6kqjpeYzP
         duxtUggFbSQu1z9H8p39nVhjD6sEQlp4fBqUi0dZDIpgIN6mxThOCAArya10vky+ZGIP
         lN6A==
X-Forwarded-Encrypted: i=1; AKwUvBzqm6hN6pRF5iT71Tqn+mGU8gcD8NSVJDevFGnnDh325hPpYMeBdrslsRacmi9bvR4PfgnWIv4=@lists.linux.dev
X-Gm-Message-State: AFuF++knBcsxWYiPGX3xj7fGJCO4rDua8UxaRHDb9aW5S7d8unZ/tiQV
	GV/2SG3pc6QpyvmryyNWn9msp7qtCmqNV+vrbnzhvwtlkkyTaybtJpijx8Je8sfxHOb02WNseeX
	ayO5i
X-Gm-Gg: AYBFou0WxtUEPxPcR4ZghNfIgqxa90GKKUSoXa6weGCObSDqqIO+4EJH5EypRFn8KwI
	Tg/Wq/eXwpffc61CzLamRYd1AXylfwnFmgcCqsni8ZsMYS3vf9YfRe2X73AwzYSl44NJKTA4Jk9
	zFv+Plnbkt4Rtm9lx0M0R7PfoaP2iRzPn5poaalWBVT45weUcP8xOEpH0cyDHbv9pye9anGR2s6
	QZKFo0x4pAkzt66fOwd9MhYfl5kf7X9j9x9C/muhJtaAD6V7t0g5jpjQEZi4PJ9Y0vG8HziII00
	eC7DNMZrJOyulo6EUpGe2E6RpUmg0zYFSb1Dpx0Ia9nRqQ9Iz92MGTzTqgPA332UXabkmE4geXu
	qL0Ys8aOjgOfJLXxGQKzKA6iZ+uwZGiqux3SZTVsRdgGo9WxgJ+yc+YwFi8KvH1WicpTmSTWAOt
	r9EkZ3O+yAd0qz2lcZGAX/cnDA9q0oNJHdgcC1OIvRdrfyERUukEbO47x5mc4aWPeISbXixMby3
	9H1dinXBQSzDqoodWdqUQ==
X-Received: by 2002:a05:600c:34c3:b0:49c:fa21:e74a with SMTP id 5b1f17b1804b1-49fc5757f73mr40080095e9.32.1789745405745;
        Fri, 18 Sep 2026 08:30:05 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49fcd0a8274sm103725e9.15.2026.09.18.08.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 08:30:05 -0700 (PDT)
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
Subject: [PATCH net-next 9/9] net: bridge: avoid VLAN lookups for flood neighbour suppression
Date: Fri, 18 Sep 2026 18:29:50 +0300
Message-ID: <20260918152950.1938259-10-razor@blackwall.org>
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

We can remove more unnecessary VLAN lookups if we pass the port-VLAN
entry to the neighbour suppression helpers so they can use it directly
instead of resolving it again. Use a vid wrapper for callers which don't
have the port-VLAN entry. This removes up to two additional VLAN hash
lookups per flooded egress port for packets marked as proxy replied.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_arp_nd_proxy.c | 51 ++++++++++++++++++++----------------
 net/bridge/br_forward.c      |  5 ++--
 net/bridge/br_private.h      |  6 +++--
 3 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index 9ce8f440e38f..da15f4d7c1ae 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -40,6 +40,23 @@ void br_recalculate_neigh_suppress_enabled(struct net_bridge *br)
 }
 
 #if IS_ENABLED(CONFIG_INET)
+static bool
+br_is_neigh_suppress_enabled_vid(const struct net_bridge_port *p, u16 vid)
+{
+	const struct net_bridge_vlan *v = NULL;
+
+	if (p && vid && test_bit(BR_NEIGH_VLAN_SUPPRESS_BIT, &p->flags)) {
+		struct net_bridge_vlan_group *vg;
+
+		vg = nbp_vlan_group_rcu(p);
+		v = br_vlan_find(vg, vid);
+		if (!v)
+			return false;
+	}
+
+	return br_is_neigh_suppress_enabled(p, v);
+}
+
 static void br_arp_send(struct net_bridge *br, struct net_bridge_port *p,
 			struct net_device *dev, __be32 dest_ip, __be32 src_ip,
 			const unsigned char *dest_hw,
@@ -159,7 +176,7 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 		return;
 
 	if (br_opt_get(br, BROPT_NEIGH_SUPPRESS_ENABLED)) {
-		if (br_is_neigh_suppress_enabled(p, vid))
+		if (br_is_neigh_suppress_enabled_vid(p, vid))
 			return;
 		if (is_unicast_ether_addr(eth_hdr(skb)->h_dest) &&
 		    parp->ar_op == htons(ARPOP_REQUEST))
@@ -211,7 +228,7 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 
 			if ((p && test_bit(BR_PROXYARP_BIT, &p->flags)) ||
 			    (dst && test_bit(BR_PROXYARP_WIFI_BIT, &dst->flags)) ||
-			    br_is_neigh_suppress_enabled(dst, vid)) {
+			    br_is_neigh_suppress_enabled_vid(dst, vid)) {
 				if (!vid)
 					br_arp_send(br, p, skb->dev, sip, tip,
 						    sha, ha, sha, 0, 0);
@@ -424,7 +441,7 @@ void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
 	BR_INPUT_SKB_CB(skb)->proxyarp_replied = 0;
 	BR_INPUT_SKB_CB(skb)->grat_arp = 0;
 
-	if (br_is_neigh_suppress_enabled(p, vid))
+	if (br_is_neigh_suppress_enabled_vid(p, vid))
 		return;
 
 	if (is_unicast_ether_addr(eth_hdr(skb)->h_dest) &&
@@ -486,7 +503,7 @@ void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
 			const struct net_bridge_port *dst = READ_ONCE(f->dst);
 			bool replied = false;
 
-			if (br_is_neigh_suppress_enabled(dst, vid)) {
+			if (br_is_neigh_suppress_enabled_vid(dst, vid)) {
 				if (vid != 0)
 					br_nd_send(br, p, skb, n, ha,
 						   skb->vlan_proto,
@@ -509,35 +526,25 @@ void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
 }
 #endif
 
-bool br_is_neigh_suppress_enabled(const struct net_bridge_port *p, u16 vid)
+bool br_is_neigh_suppress_enabled(const struct net_bridge_port *p,
+				  const struct net_bridge_vlan *v)
 {
 	if (!p)
 		return false;
 
-	if (vid && test_bit(BR_NEIGH_VLAN_SUPPRESS_BIT, &p->flags)) {
-		struct net_bridge_vlan_group *vg = nbp_vlan_group_rcu(p);
-		struct net_bridge_vlan *v;
-
-		v = br_vlan_find(vg, vid);
-		if (!v)
-			return false;
+	if (v && test_bit(BR_NEIGH_VLAN_SUPPRESS_BIT, &p->flags))
 		return !!(READ_ONCE(v->priv_flags) &
 			  BR_VLFLAG_NEIGH_SUPPRESS_ENABLED);
-	}
+
 	return test_bit(BR_NEIGH_SUPPRESS_BIT, &p->flags);
 }
 
-bool br_is_neigh_forward_grat_enabled(const struct net_bridge_port *p, u16 vid)
+bool br_is_neigh_forward_grat_enabled(const struct net_bridge_port *p,
+				      const struct net_bridge_vlan *v)
 {
-	if (vid && test_bit(BR_NEIGH_VLAN_SUPPRESS_BIT, &p->flags)) {
-		struct net_bridge_vlan_group *vg = nbp_vlan_group_rcu(p);
-		struct net_bridge_vlan *v;
-
-		v = br_vlan_find(vg, vid);
-		if (!v)
-			return false;
+	if (v && test_bit(BR_NEIGH_VLAN_SUPPRESS_BIT, &p->flags))
 		return !!(READ_ONCE(v->priv_flags) &
 			  BR_VLFLAG_NEIGH_FORWARD_GRAT_ENABLED);
-	}
+
 	return test_bit(BR_NEIGH_FORWARD_GRAT_BIT, &p->flags);
 }
diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index d89f1b7d6def..b5eece1ff9e8 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -244,7 +244,6 @@ static int br_flood_port(struct br_fwd_dst *prev,
 			 enum br_pkt_type pkt_type, bool local_orig)
 {
 	const struct net_bridge_port *p = fwd->port;
-	u16 vid = fwd->vlan ? fwd->vlan->vid : 0;
 
 	/* Do not flood unicast traffic to ports that turn it off, nor
 	 * other traffic if flood off, except for traffic we originate
@@ -275,9 +274,9 @@ static int br_flood_port(struct br_fwd_dst *prev,
 		/* For gratuitous ARPs/NAs, check neigh_forward_grat.
 		 * For regular ARPs/NDs, check only neigh_suppress.
 		 */
-		if (br_is_neigh_suppress_enabled(p, vid) &&
+		if (br_is_neigh_suppress_enabled(p, fwd->vlan) &&
 		    (!BR_INPUT_SKB_CB(skb)->grat_arp ||
-		     !br_is_neigh_forward_grat_enabled(p, vid)))
+		     !br_is_neigh_forward_grat_enabled(p, fwd->vlan)))
 			return 0;
 	}
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 7c0b1d3e7931..67117fb3dc88 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -2390,6 +2390,8 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
 		       u16 vid, struct net_bridge_port *p, struct nd_msg *msg);
 struct nd_msg *br_is_nd_neigh_msg(struct sk_buff *skb);
-bool br_is_neigh_suppress_enabled(const struct net_bridge_port *p, u16 vid);
-bool br_is_neigh_forward_grat_enabled(const struct net_bridge_port *p, u16 vid);
+bool br_is_neigh_suppress_enabled(const struct net_bridge_port *p,
+				  const struct net_bridge_vlan *v);
+bool br_is_neigh_forward_grat_enabled(const struct net_bridge_port *p,
+				      const struct net_bridge_vlan *v);
 #endif
-- 
2.47.3

