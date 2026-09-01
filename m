Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AEE38D401
	for <bridge@lists.linux.dev>; Tue,  1 Sep 2026 12:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788264467; cv=none; b=DJY6RIrATzHz8mdvSooFC7Xs0L2LdE/uw9PzzMJEZTcaMSODSSTfVrZ0M644wSX3ZOV0QG/kcPMFhuHo2tfnBpHbOijO1t6dxNnjcpJqmmiNZi8EX3BfZoNAn7tOU2nIkT7MkgbsPgaZj59UHcobUrQYUO7QJtFVvcfddPk4Rao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788264467; c=relaxed/simple;
	bh=wXTs7/mwUOm9B82JGE5NjvfCN2BrknQqFyvqV/ssMQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hA8Wjy/6VXkJ7ofVAsOL0gILcSqLb6vrOKKHMnakWHBYjdkvluArroaUik+iqozj6xleu1kU5Ww2GYQG8YsD/US+g8lS0THTm8/fVEtlhI5K01RP9GaNgWoFkd61bKu77VjYc58XK3pyVEdzmqJJ6SFWThqkfeoebK5HjjDVUTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=FgwGotHt; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="FgwGotHt"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4957eefd361so6425045e9.1
        for <bridge@lists.linux.dev>; Tue, 01 Sep 2026 05:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788264464; x=1788869264; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=17pAeXAPWqC20adwChneYdX1dfRnINnx5gBEzZVTcEg=;
        b=FgwGotHtRvrpn0z6zx93Anyf2tfcYs7UCz2+vW3s1oK00tjiWxcBr1Mp6OtSnQ2V5U
         IMvdh+Pa9LtzZsV/18t0GI6bKQvuaehsMLO/3KGTVT3lehS1qcUfpTQ8ttz6rtgj4sE/
         pxW/IzBaP3/xuuqAmkRo88WfbMLBtuwS1p8TJ/CNHdwkuWFeZQNzvFcOauDAox6sSofx
         5eJSVpwd64G8cHdiboLB1txaFaWEZMWRsSKAA7C//3n7G0wyDkRgdhdJgPCcX/d6YXCn
         EzA3voVKJ7Rm/Oijh5UpbiI8tD6i1I6y6QY0/0WEcNEKYP/jkL7touXqE/m0txLKxa2+
         HbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788264464; x=1788869264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=17pAeXAPWqC20adwChneYdX1dfRnINnx5gBEzZVTcEg=;
        b=gu854rc5ce0oQMz1ul+j5tyFWWijrSv+BLC3dTZAKzBR+5suQKLHzZwWmq1GMtx6m9
         C0NwwQ+BLIwC1ltKc/dGvLxRhJEw/wOuDyrLuGiV95fE/Ve+QPNBMgOh6wf/NZ12NQHb
         /UGGNS5BEa+laWfN3b6W3QK66QM6ja4Y0nfHsBByH2lGMnQ4vlsVHcfnruVjodQAUBqW
         brYFDj/eoG49ZjiX2gZl3lZ/C/4H52N1/S3ZPOtkxRMB46fmMsAzS+Tus2c9T7eNjQt2
         GoosurlyAHmKiIq1gUe0tdUmXdwsW2VkYwW4q/TwBAZGld7GvZJe4zvZctAfiBIsOYOm
         zXMQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp0W9AkHuV4YzLE2TQhiaMnmfmfwAxc/4uG0b7ZeeM5mZK/5UwTWz7/TAmyF9WQz1HqG9tb+Y4=@lists.linux.dev
X-Gm-Message-State: AFuF++kLdWRoDFVFEwGMWhREPzbiNkyo/JtB0bVXFepMMXjvlMoIkoSL
	N1iW+iR/AGVT+BVSQWnwXrGbsLAh4VIYsvkvboNcke3TJb9MIXIgDQcWAfa0huZi0p4=
X-Gm-Gg: AR+sD13YZ6wqtdArQod+x0FUgkYn2yHG092E6sDOoeAcW5q6EcXsuEKujFOqtUMeYaS
	DC4q61K50dz++8jxFG/TCOj4IqXHbTC8gQsNMfD3IPGrtTl0l6HGtx1M0EWxcwWQrkN4sgJuNyh
	g0uoOq6fvU8vx0rR50lm6t/JFuszqKsIluLmTyqxY3TMSfefAevvxkB6L+iD5xq8MUCzOR9K/cB
	HCHIKbDOR2jmEVqbnc8d5NUA+BafKV5BOee+rROZbxV/blgEWxBMaY+eInwur9O8cqNOY5d7dbm
	iybDatORZh+BvmdjrfKEABLzQ10GIPrO/F/97WnYfpqiZq/xVC5+sDfNKdGbPVi1TLis+yNYnKY
	2fTQ6OegQyoCKOxx1YwwFMPdLOCPc0TieqSQLvLjNYbn/GGNy35zDzYbegK1h5aMCF+z21dTHJt
	GLlY0OtEFNWQ932ECc2nyNByaqKGE36snj8SNuL45fo4OQPaEuti4Xb9Dq63xJUzqvlhmhY7/Ju
	n7NoZcZij3x
X-Received: by 2002:a05:600c:1549:b0:49c:d294:41e5 with SMTP id 5b1f17b1804b1-49cd294439fmr280766635e9.8.1788264463460;
        Tue, 01 Sep 2026 05:07:43 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49cdce10148sm61876185e9.5.2026.09.01.05.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 05:07:42 -0700 (PDT)
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
Subject: [PATCH net-next 5/9] net: bridge: vlan: annotate lockless use of private flags
Date: Tue,  1 Sep 2026 15:07:17 +0300
Message-ID: <20260901120721.747908-6-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901120721.747908-1-razor@blackwall.org>
References: <20260901120721.747908-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate vlan private flags data races, they can be read lockless.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_arp_nd_proxy.c |  6 ++++--
 net/bridge/br_multicast.c    | 16 ++++++++++------
 net/bridge/br_private.h      |  9 ++++++---
 net/bridge/br_vlan.c         |  2 +-
 net/bridge/br_vlan_options.c |  6 ++++--
 5 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index 87a40e2f1c50..b82fa6589ab9 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -521,7 +521,8 @@ bool br_is_neigh_suppress_enabled(const struct net_bridge_port *p, u16 vid)
 		v = br_vlan_find(vg, vid);
 		if (!v)
 			return false;
-		return !!(v->priv_flags & BR_VLFLAG_NEIGH_SUPPRESS_ENABLED);
+		return !!(READ_ONCE(v->priv_flags) &
+			  BR_VLFLAG_NEIGH_SUPPRESS_ENABLED);
 	}
 	return test_bit(BR_NEIGH_SUPPRESS_BIT, &p->flags);
 }
@@ -535,7 +536,8 @@ bool br_is_neigh_forward_grat_enabled(const struct net_bridge_port *p, u16 vid)
 		v = br_vlan_find(vg, vid);
 		if (!v)
 			return false;
-		return !!(v->priv_flags & BR_VLFLAG_NEIGH_FORWARD_GRAT_ENABLED);
+		return !!(READ_ONCE(v->priv_flags) &
+			  BR_VLFLAG_NEIGH_FORWARD_GRAT_ENABLED);
 	}
 	return test_bit(BR_NEIGH_FORWARD_GRAT_BIT, &p->flags);
 }
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index bbcaedf15ca1..cd984173320f 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2172,7 +2172,7 @@ static void br_multicast_enable_port_ctx(struct net_bridge_mcast_port *pmctx)
 
 	spin_lock_bh(&br->multicast_lock);
 	if (br_multicast_port_ctx_is_vlan(pmctx) &&
-	    !(pmctx->vlan->priv_flags & BR_VLFLAG_MCAST_ENABLED)) {
+	    !(READ_ONCE(pmctx->vlan->priv_flags) & BR_VLFLAG_MCAST_ENABLED)) {
 		spin_unlock_bh(&br->multicast_lock);
 		return;
 	}
@@ -2209,7 +2209,7 @@ static void br_multicast_disable_port_ctx(struct net_bridge_mcast_port *pmctx)
 
 	spin_lock_bh(&br->multicast_lock);
 	if (br_multicast_port_ctx_is_vlan(pmctx) &&
-	    !(pmctx->vlan->priv_flags & BR_VLFLAG_MCAST_ENABLED)) {
+	    !(READ_ONCE(pmctx->vlan->priv_flags) & BR_VLFLAG_MCAST_ENABLED)) {
 		spin_unlock_bh(&br->multicast_lock);
 		return;
 	}
@@ -4083,7 +4083,8 @@ int br_multicast_rcv(struct net_bridge_mcast **brmctx,
 			*pmctx = &vlan->port_mcast_ctx;
 		}
 
-		if (!(masterv->priv_flags & BR_VLFLAG_GLOBAL_MCAST_ENABLED))
+		if (!(READ_ONCE(masterv->priv_flags) &
+		      BR_VLFLAG_GLOBAL_MCAST_ENABLED))
 			return 0;
 	}
 
@@ -4383,7 +4384,8 @@ void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan, bool on)
 			return;
 
 		spin_lock_bh(&br->multicast_lock);
-		vlan->priv_flags ^= BR_VLFLAG_MCAST_ENABLED;
+		WRITE_ONCE(vlan->priv_flags, vlan->priv_flags ^
+					    BR_VLFLAG_MCAST_ENABLED);
 		spin_unlock_bh(&br->multicast_lock);
 
 		if (on)
@@ -4399,7 +4401,8 @@ void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan, bool on)
 
 		br = vlan->port->br;
 		spin_lock_bh(&br->multicast_lock);
-		vlan->priv_flags ^= BR_VLFLAG_MCAST_ENABLED;
+		WRITE_ONCE(vlan->priv_flags, vlan->priv_flags ^
+					    BR_VLFLAG_MCAST_ENABLED);
 		if (on)
 			__br_multicast_enable_port_ctx(&vlan->port_mcast_ctx);
 		else
@@ -4477,7 +4480,8 @@ bool br_multicast_toggle_global_vlan(struct net_bridge_vlan *vlan, bool on)
 	if (on == !!(vlan->priv_flags & BR_VLFLAG_GLOBAL_MCAST_ENABLED))
 		return false;
 
-	vlan->priv_flags ^= BR_VLFLAG_GLOBAL_MCAST_ENABLED;
+	WRITE_ONCE(vlan->priv_flags, vlan->priv_flags ^
+				    BR_VLFLAG_GLOBAL_MCAST_ENABLED);
 	br_multicast_toggle_vlan(vlan, on);
 
 	return true;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 96554d293d22..c7b64b5da012 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1273,21 +1273,24 @@ br_multicast_ctx_vlan_global_disabled(const struct net_bridge_mcast *brmctx)
 {
 	return br_multicast_ctx_is_vlan(brmctx) &&
 	       (!br_opt_get(brmctx->br, BROPT_MCAST_VLAN_SNOOPING_ENABLED) ||
-		!(brmctx->vlan->priv_flags & BR_VLFLAG_GLOBAL_MCAST_ENABLED));
+		!(READ_ONCE(brmctx->vlan->priv_flags) &
+		  BR_VLFLAG_GLOBAL_MCAST_ENABLED));
 }
 
 static inline bool
 br_multicast_ctx_vlan_disabled(const struct net_bridge_mcast *brmctx)
 {
 	return br_multicast_ctx_is_vlan(brmctx) &&
-	       !(brmctx->vlan->priv_flags & BR_VLFLAG_MCAST_ENABLED);
+	       !(READ_ONCE(brmctx->vlan->priv_flags) &
+		 BR_VLFLAG_MCAST_ENABLED);
 }
 
 static inline bool
 br_multicast_port_ctx_vlan_disabled(const struct net_bridge_mcast_port *pmctx)
 {
 	return br_multicast_port_ctx_is_vlan(pmctx) &&
-	       !(pmctx->vlan->priv_flags & BR_VLFLAG_MCAST_ENABLED);
+	       !(READ_ONCE(pmctx->vlan->priv_flags) &
+		 BR_VLFLAG_MCAST_ENABLED);
 }
 
 static inline bool
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index c8b2e3bfd42d..102792f20a5e 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1497,7 +1497,7 @@ int br_vlan_fill_forward_path_mode(struct net_bridge *br,
 
 	if (path->bridge.vlan_mode == DEV_PATH_BR_VLAN_TAG)
 		path->bridge.vlan_mode = DEV_PATH_BR_VLAN_KEEP;
-	else if (v->priv_flags & BR_VLFLAG_TAGGING_BY_SWITCHDEV)
+	else if (READ_ONCE(v->priv_flags) & BR_VLFLAG_TAGGING_BY_SWITCHDEV)
 		path->bridge.vlan_mode = DEV_PATH_BR_VLAN_UNTAG_HW;
 	else
 		path->bridge.vlan_mode = DEV_PATH_BR_VLAN_UNTAG;
diff --git a/net/bridge/br_vlan_options.c b/net/bridge/br_vlan_options.c
index cb0f556ff40d..bd049d268fe7 100644
--- a/net/bridge/br_vlan_options.c
+++ b/net/bridge/br_vlan_options.c
@@ -276,7 +276,8 @@ static int br_vlan_process_one_opts(const struct net_bridge *br,
 		}
 
 		if (val != enabled) {
-			v->priv_flags ^= BR_VLFLAG_NEIGH_SUPPRESS_ENABLED;
+			WRITE_ONCE(v->priv_flags, v->priv_flags ^
+				   BR_VLFLAG_NEIGH_SUPPRESS_ENABLED);
 			*changed = true;
 		}
 	}
@@ -292,7 +293,8 @@ static int br_vlan_process_one_opts(const struct net_bridge *br,
 		}
 
 		if (val != enabled) {
-			v->priv_flags ^= BR_VLFLAG_NEIGH_FORWARD_GRAT_ENABLED;
+			WRITE_ONCE(v->priv_flags, v->priv_flags ^
+				   BR_VLFLAG_NEIGH_FORWARD_GRAT_ENABLED);
 			*changed = true;
 		}
 	}
-- 
2.47.3

