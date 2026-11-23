Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429724;
	b=EPzpXXo9Q1VCH6NuvYhQQx2OdY58MS2MO8fGY6uXwvw40eU/kkCaLtsyMj9s8eBSqAlr
	 wZ3yh40E1paq1Mzqi1dX37t4S1KF8SzzfKNvkbfZOZ6uM7MoqDTSZjf+HFI4Be16YQY2t
	 M57vjaWJ70x6/0PK5rAG8kKckf5h/c+csgQnwLVv+ka+NjphOIiSsD2AzDeBeItHV8LAL
	 lbcZOOIi3A6z7KDpz3TPruAA8Dfo1dGw88hZwweKD7jgcnhoTA/kSTVsMugi7U7rWLYGO
	 iUTpVK0tVsUEvv2NMA4pWxMZWfB7OtMCLShiwdaxpjKRkUaFDLkO4imdqjC2vlAGBxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429724;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0A1TT+t5OqeLZ073EDE6jPbaRu8g2jN0d8R7gHtkTVQ=;
	b=b2g3L2waPPvMGmSoHHrOAqSAKuv7aPthFfch1RLRc1zU+ejLEbX0rQwfaUsKV+9DO5Ft
	 Jq249jF8GjNGdFd4X1sCI0KuIP7W0ErxJ6XY74p3Z5Uea5qST5o8GZ7PfFdGec49e0SlJ
	 U6eEU2+mTvNcTqb7c6qbU7pxZ+1llBk3w1233+Ur4mm0AIsG6jYGSKniGYQzssQEq9c3y
	 WuBPpXsnpW4EuSTrkwek8ultEtJKQENhFOQyCitJ3yR+VAPgXuqvSL2Mmoz0lsaGia43X
	 3VpAF1y8EJ0SbQO3e9ijcx0UjrjRUI2M/3eiFQmE2SY+LBjJveE4EG60PyM6nwVp+uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=isgnYnJX;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DDD606A321
	for <bridge@lists.linux.dev>; Mon, 23 Nov 2026 10:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5DDD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=isgnYnJX
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48dee593f18so2973672f8f.3
        for <bridge@lists.linux.dev>; Mon, 23 Nov 2026 02:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1795429722; x=1796034522; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0A1TT+t5OqeLZ073EDE6jPbaRu8g2jN0d8R7gHtkTVQ=;
        b=isgnYnJXQSgd4PpUqTG2PrrwuDNLPrnrhLew9YwquEsc7Hh0G1hPxO0vezu2KWnzNm
         Dc/cYQjAFOHGHRirDNgB3oW7+M+B8E3YkN+7pAOdFI+eBzIHkvcRUG/gXqKdvlNA4LZC
         SMd6i/AmGdDZXB+x58q38kufVKsLt8bHLb99x5H7DhMNGbB/6xIppGs+6iU5hoL23wx5
         ksZuP09NqZPo+FLHlkFkbic8tGxp25fN+i0fgM52xtaG1ZNhRP2CgSP1B2Op7MNQGqKK
         uOlimtEbt9/Ut11a3mYxJZrBgxtNEMyUUGkT63cuKbMXqE0nnvw2eYV+LPdiRUmmOlrq
         aXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795429722; x=1796034522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0A1TT+t5OqeLZ073EDE6jPbaRu8g2jN0d8R7gHtkTVQ=;
        b=Be2qhN1ifVjIssPJXm7aVhhzOfRFSUp24Hy/WdVw4JWYCq6TxswhHq6lS8iJyzly3r
         Wjcx5FiD247/oxMxxYuPRJT4FOsOOaL+UfxW+MCndFDqqnd87ng3ockw40TkYowKypxd
         t6iMKkxojwYN7pdQGxYFXUpI0okBhNx+muPgn1sZeuPpbncG578PyTRxb3TqgcPWDR4p
         0HgdgyApUxFxbrkSzg/2bWxJn4iZF9LXv2Z9EoEHUYNw2QUY2B2F8CxaS+GInkdOkhiS
         jQXnJ5HZyVEAoAUAr2LQoCLcQbQbKaLo/O1lv373nbUK3bzug/rpNdfP9yX7eEFctxst
         mPvw==
X-Forwarded-Encrypted: i=1; AL+hErGe/gQx6DsJi/Ge+0pLaIw9acMWX0wRuELi6TEhGVm043WVmRG/9p1vsRIPFYx2H3W78VxGQ4E=@lists.linux.dev
X-Gm-Message-State: APuU4Z8wf6aIGwSlHz4aaOXoi4R8jcMs/QmyRnDwtTtt3UVGglLoLJnG
	BS7+3RgWwWGTXAhr6zEo+k7hQBCEjOY7rva6BcnUhHpBqo5gdNWm+abSJ/98QDWL1eI=
X-Gm-Gg: AZFdTZeAN5QkJ2Ak+mWor1X6QrStA3TFwsr3JyLulz0cY6am5TjxPbChFN/8IaZcvLp
	kkYU7phHoKPfM/Ot48Gym0dOzPdiydmv0rugcjzvS7sdig/LRKHrN5tVuJC+JeOEz5lC9+7Wz5n
	ZRsU/t/NsBOR2prYzZTBx77SOprPwe+YIj05XO5wPi2fyIW5LsNEYm01k0SwShjzQ9hGWQ+Ei+E
	FedsyBZgt2+wseF5QkQuU6b8MOsvV7ce6XOvPDgStJA2lEm3xqOUcUTQoww7ezBRGZt78NKvcPG
	kleJyGPkQndA/Rn5Fo3LnSJk9vL5EsvdtGYWJQMYYWk5dW2t6p90niq45SoPwaezZT5z/lPeXWm
	Is7wHAwY3ZpQsEmaKNOIYQrz/snBzXArBG4Wpe2iD70C4S/nym38UpYVtCqHeg8i4vjmhjQ+D7w
	96sbkfKX2WCF+oBMo5sPk4fjxNHKq3f91iQhe/IAGD9yP3HWBxEH/TYaCAzH4VgbLdHy1JOvIzA
	UL4rlCSIZZnXo1mmnGw/12Ebf9rrzT8GLM86P6E8dD6kBsf0O1UI2eHLYpu3UGN3cG3hA0GqQyU
	Ql1Uef0p7yRaQE2WeVrxHiGycGj6OsYoeT5ENFF07rs9Xjn8etk=
X-Received: by 2002:a05:600c:8210:b0:4bb:6a2d:b438 with SMTP id 5b1f17b1804b1-4bb88786c81mr225278965e9.0.1795429722129;
        Mon, 23 Nov 2026 02:28:42 -0800 (PST)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb8526cbd0sm447180395e9.0.2026.11.23.02.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 02:28:41 -0800 (PST)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bridge@lists.linux.dev
Subject: [PATCH net-next 1/3] net: bridge: avoid VLAN lookups for multicast router forwarding
Date: Mon, 23 Nov 2026 12:28:31 +0200
Message-ID: <20261123102833.924427-2-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123102833.924427-1-razor@blackwall.org>
References: <20261123102833.924427-1-razor@blackwall.org>
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Return the multicast port context when decoding a router-list node and
pass its VLAN entry to the forwarding destination. With per-VLAN snooping,
the context already identifies the egress port VLAN, so validation and
tagging can use it directly.

A per-VLAN router context is selected through the resolved ingress VLAN.
Global router contexts have no VLAN pointer and resolve their VLAN during
egress validation.

During port VLAN deletion, a per-VLAN router context can remain on the
router list after the VLAN has been unpublished. Forwarding can therefore
still use its cached VLAN until router-list removal, whereas a fresh VLAN
lookup would reject it. This is transient forwarding during teardown,
consistent with the existing cached FDB destination behavior. RCU protects
the VLAN's lifetime, and context cleanup removes it from the router lists.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
local Sashiko review says:
 [Severity: Medium]
 Can this forward multicast through a port VLAN after it is unpublished?

 CPU0                              CPU1
 nbp_vlan_delete()
   __vlan_unpublish(vg, v)
                                   br_multicast_flood()
                                     fwd.vlan = rpmctx->vlan
                                     should_deliver_vlan()
                                     br_handle_vlan()
                                       <-- forwards on removed VLAN
   br_multicast_port_ctx_deinit(...)

 Nik: this is already documented, it can forward for a short-while until
      ctx_deinit is called which is fine

CC: Ido Schimmel <idosch@nvidia.com>
CC: David S. Miller <davem@davemloft.net>
CC: Eric Dumazet <edumazet@kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>
CC: bridge@lists.linux.dev

 net/bridge/br_forward.c |  5 ++++-
 net/bridge/br_private.h | 19 +++++--------------
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 54365c6104b5..b725e8f1b29a 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -412,10 +412,12 @@ void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
 
 	while (p || rp) {
 		struct net_bridge_port *port, *lport, *rport;
+		struct net_bridge_mcast_port *rpmctx;
 		struct br_fwd_dst fwd = {};
 
 		lport = p ? p->key.port : NULL;
-		rport = br_multicast_rport_from_node_skb(rp, skb);
+		rpmctx = br_multicast_rport_ctx_from_node_skb(rp, skb);
+		rport = rpmctx ? rpmctx->port : NULL;
 
 		if ((unsigned long)lport > (unsigned long)rport) {
 			port = lport;
@@ -432,6 +434,7 @@ void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
 				goto delivered;
 		} else {
 			port = rport;
+			fwd.vlan = rpmctx->vlan;
 		}
 
 		fwd.port = port;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 014d0b8db8c7..20e423e22132 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1244,24 +1244,15 @@ br_multicast_get_first_rport_node(struct net_bridge_mcast *brmctx,
 	return rcu_dereference(hlist_first_rcu(&brmctx->ip4_mc_router_list));
 }
 
-static inline struct net_bridge_port *
-br_multicast_rport_from_node_skb(struct hlist_node *rp, struct sk_buff *skb)
+static inline struct net_bridge_mcast_port *
+br_multicast_rport_ctx_from_node_skb(struct hlist_node *rp, struct sk_buff *skb)
 {
-	struct net_bridge_mcast_port *mctx;
-
 #if IS_ENABLED(CONFIG_IPV6)
 	if (skb->protocol == htons(ETH_P_IPV6))
-		mctx = hlist_entry_safe(rp, struct net_bridge_mcast_port,
-					ip6_rlist);
-	else
+		return hlist_entry_safe(rp, struct net_bridge_mcast_port,
+				       ip6_rlist);
 #endif
-		mctx = hlist_entry_safe(rp, struct net_bridge_mcast_port,
-					ip4_rlist);
-
-	if (mctx)
-		return mctx->port;
-	else
-		return NULL;
+	return hlist_entry_safe(rp, struct net_bridge_mcast_port, ip4_rlist);
 }
 
 static inline bool br_ip4_multicast_is_router(struct net_bridge_mcast *brmctx)
-- 
2.47.3

