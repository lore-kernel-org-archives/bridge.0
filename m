Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132C71DB148
	for <bridge@lists.linux.dev>; Tue,  8 Apr 2025 14:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744122502; cv=none; b=TDf0+/4hkbWiiWQX/YJOn2Spj9vwIlxdWL9kU9NPlIn+JJJdssmDp1VsYX2w09NV7zTkpvtkXxGzMqEqemI1xK5S2b4q/Oi5joY82rJDm/XmhbHTor3KxR7Kv85/MCthkh+rTqu/w6JMDxQYLRkBVTrCvItPkaYyB1dkPW3u400=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744122502; c=relaxed/simple;
	bh=fKU1hIH5wftor3HXv18Lb+SFJQaConszUIcYBY/OipQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YejoKXRZaLZWwbG3de0iKD4JYgBe43M3OIG4JASSNwWMYH2J1cNJhUZ0I+2svbxbyQqUJWHmombwc4ioPlu0nJsOsZPLZAIMbR+H7Ww7LiSCEwt/pu0uZ3F5i3UQzYGVdGj8dydUbSm1LH0YauywHyKOOZwO/fhf9ZBek2XXN0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdtmuRGl; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdtmuRGl"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e5e0caa151so10006110a12.0
        for <bridge@lists.linux.dev>; Tue, 08 Apr 2025 07:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744122499; x=1744727299; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UeDS1VbMS/qQi1KzpWyfGQyJc3UTd7ZY/9sMRmL0bYY=;
        b=cdtmuRGlvF96vbVcl2nvoIiSu0FqJu2IDWz8mB86nkNyDL9YKuK+/P4Yqv4wOAnnh5
         xpaz//c1HWerRDXNToJ61qozau3/zb953LMQGSR0JC104P7wstiBOwWfcB3tH9wUPfYA
         QpSttF4S9Zgst/gxKz0QUp/o+/VXFTFQeXPwt06JqJPeGre2tJa3mSshRnmmJrYaFYGn
         mRqzFiS/8S2E0XmP/RZvjRe5XLh0ogUG6jZDjBEhVozYwSQmt1c8bgSNqvD/5mZ0CD+g
         DhcPpwpN6rSwyvzx0zD7oj+jvbp+OdnYdmpzg/2Qe7VbedRtKCCN0xVJP7vRg1CPYk6t
         rs+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744122499; x=1744727299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UeDS1VbMS/qQi1KzpWyfGQyJc3UTd7ZY/9sMRmL0bYY=;
        b=xFoHZ8N810wqH+0SkLzY3uMzBdQyVLpp7WemXp/O5CixAvKPXcS04Wt8u59xkc3LPz
         qFU7MQJAxnDQcvrYabUXlV/acP2XIz8RbM7oJpkzCD6qbPdZN5eDnqY0i9AXAIzNU9I5
         ir9e58ayAxCZdH+BoTXt+q3k9+bLA9iA/lRkEEN6FUqSHqYViFZqc6cP25RG2tijHV8F
         WBwMbe2UrqGIA/6vbfJwbo5jLib5/XFt98vawz8Y0qdpL1yVnGaOluTwSJldckot1Gmk
         DzeZPUFz9NJv8QbkL9wcj3eIm/Nzl+SDwfhx9g3cEMsbhFqNKT10uuPvmaE/Bb6i/H94
         sPyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpfAWxkzeDgccAdgSrYCLLArXNYURogD+RXvEAYfN9MJbP6iNqqqMnJpKWO76BcsqnEey1AYk=@lists.linux.dev
X-Gm-Message-State: AOJu0YwT5PYvJBwdPajyoIab1/2pY8CRRUDgJxOj1siwCV/JrdSZFGfl
	GEg7cfxGxhWupv2uW5WmJ66rvofFWPqae8VrOc4Lr4hxNHbjaisi
X-Gm-Gg: ASbGnculi//0X/jg2ZUD5C+YZuKTqvBJNV8LYS2/6yCqkq3Gl7cQpMvL1aJMfhP2J3/
	SLJeUjZI+kqrfpQijSPXa5f3BBJS9QW7R0LzxXUELDD9Mu1CAeNBerlFMt7i/NZ5Z3o5RaEXCWe
	UQACHxfA+/hJZsBD9UX44J6dm7AYQwZtPw5Q9csZC0rq2j96uaqRllNYei1y4lbBUtCySNLeKsk
	8n6uBpZf1plGkVpvP7HZkPEMS4tAna5XTDpG+IKdEAqypAhaneDvFx9nreLf7FDL6YImaIuzKFS
	xz/cLDBS6u+uHS2nMrZtbE/uPqbxblSAtGf7SlQcFYUQUhPQBNfwy5iVpKowvVBkYRn3N6gunZ3
	cLiT8NGEAhI9Rya67mF8sSLAXy0C6qc4D0PdC7cm5GDt0z7yIWXuCjTIkyp/ohB0=
X-Google-Smtp-Source: AGHT+IEl+CsynwKhg/C8laNeWOqrJPLM0lP2g3t+A5AzCwJFmzaSaDDJ8quEoE1W8x7sYVBQ93t3YQ==
X-Received: by 2002:a05:6402:35d6:b0:5ed:3228:cfee with SMTP id 4fb4d7f45d1cf-5f0b5c3e38emr14099103a12.0.1744122499142;
        Tue, 08 Apr 2025 07:28:19 -0700 (PDT)
Received: from localhost.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f1549b3fd0sm2236164a12.35.2025.04.08.07.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 07:28:16 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v11 nf-next 1/6] bridge: Add filling forward path from port to port
Date: Tue,  8 Apr 2025 16:27:57 +0200
Message-ID: <20250408142802.96101-2-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250408142802.96101-1-ericwouds@gmail.com>
References: <20250408142802.96101-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a port is passed as argument instead of the master, then:

At br_fill_forward_path(): find the master and use it to fill the
forward path.

At br_vlan_fill_forward_path_pvid(): lookup vlan group from port
instead.

Changed call to br_vlan_group() into br_vlan_group_rcu() while at it.

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/bridge/br_device.c  | 19 ++++++++++++++-----
 net/bridge/br_private.h |  2 ++
 net/bridge/br_vlan.c    |  6 +++++-
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 80b75c2e229b..b4746a239b88 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -385,16 +385,25 @@ static int br_del_slave(struct net_device *dev, struct net_device *slave_dev)
 static int br_fill_forward_path(struct net_device_path_ctx *ctx,
 				struct net_device_path *path)
 {
+	struct net_bridge_port *src, *dst;
 	struct net_bridge_fdb_entry *f;
-	struct net_bridge_port *dst;
 	struct net_bridge *br;
 
-	if (netif_is_bridge_port(ctx->dev))
-		return -1;
+	if (netif_is_bridge_port(ctx->dev)) {
+		struct net_device *br_dev;
+
+		br_dev = netdev_master_upper_dev_get_rcu((struct net_device *)ctx->dev);
+		if (!br_dev)
+			return -1;
 
-	br = netdev_priv(ctx->dev);
+		src = br_port_get_rcu(ctx->dev);
+		br = netdev_priv(br_dev);
+	} else {
+		src = NULL;
+		br = netdev_priv(ctx->dev);
+	}
 
-	br_vlan_fill_forward_path_pvid(br, ctx, path);
+	br_vlan_fill_forward_path_pvid(br, src, ctx, path);
 
 	f = br_fdb_find_rcu(br, ctx->daddr, path->bridge.vlan_id);
 	if (!f)
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index c3395320a4f3..759e7685de9b 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1584,6 +1584,7 @@ bool br_vlan_can_enter_range(const struct net_bridge_vlan *v_curr,
 			     const struct net_bridge_vlan *range_end);
 
 void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
+				    struct net_bridge_port *p,
 				    struct net_device_path_ctx *ctx,
 				    struct net_device_path *path);
 int br_vlan_fill_forward_path_mode(struct net_bridge *br,
@@ -1753,6 +1754,7 @@ static inline int nbp_get_num_vlan_infos(struct net_bridge_port *p,
 }
 
 static inline void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
+						  struct net_bridge_port *p,
 						  struct net_device_path_ctx *ctx,
 						  struct net_device_path *path)
 {
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 0f714df92118..114d47d5f90f 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1446,6 +1446,7 @@ int br_vlan_get_pvid_rcu(const struct net_device *dev, u16 *p_pvid)
 EXPORT_SYMBOL_GPL(br_vlan_get_pvid_rcu);
 
 void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
+				    struct net_bridge_port *p,
 				    struct net_device_path_ctx *ctx,
 				    struct net_device_path *path)
 {
@@ -1458,7 +1459,10 @@ void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
 	if (!br_opt_get(br, BROPT_VLAN_ENABLED))
 		return;
 
-	vg = br_vlan_group(br);
+	if (p)
+		vg = nbp_vlan_group_rcu(p);
+	else
+		vg = br_vlan_group_rcu(br);
 
 	if (idx >= 0 &&
 	    ctx->vlan[idx].proto == br->vlan_proto) {
-- 
2.47.1

