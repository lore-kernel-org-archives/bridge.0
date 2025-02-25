Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A65D212B32
	for <bridge@lists.linux.dev>; Tue, 25 Feb 2025 20:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740514595; cv=none; b=K1hZ2mxP8oTJ1qarnVYQmo4DgqxzJ1wG91acCGcIOPs+7Awj1+GilOenad6T7sWTX4RRGFEJM49djcJE+cXmr6C3ad1aUpgAA0xYnpk+ILvH28BAh6hu9DTjP6d1sVCoOYz+wZwwLzRXsuMNopSo4faG8om7fSX+z+NxACU+Nq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740514595; c=relaxed/simple;
	bh=sq5lC5Lgg2lgUcbphMYliAhopUKVFEXA0PcFARtTXys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g26fXtiYXlaWsmluKxNHd8vNk30CbcMKTl16z2eAdeBlaTi8JP4EZ/Xjp9q0W474k3EbKivMTicplZK/0qXkDMbIIrddGWV36CqtU1Z5NR6ulfyBAzTLw22xlB/e9Lkc8d1+R1LBRrqI9DRMgrkMFyMMuGZSU0KrkRMUjdliDDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2Om2erE; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2Om2erE"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abb75200275so962796466b.3
        for <bridge@lists.linux.dev>; Tue, 25 Feb 2025 12:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740514592; x=1741119392; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glD7coNk2GO9/l1adKLN+uo1Xfh2D3YWudU7CjoMsSA=;
        b=W2Om2erEmnjULzxav3bTKwimEQXVKJbuYFTuB4xMIY1xHaY1NyyBQi60dUTlou0YxT
         dc9Lm19G3Hm3TEkgfdp24UH2IccmTQUHXAKcEQSDsSlhY+heFdVCjnl2x619sreQUNqU
         rafB0ptpUZSRz0gX4ukcDGGuy4dbDab00XKv6pjoixeH9mTjt/JWD4ngbUfXpjNl2xO2
         FVlr+lM8qPjAOwxcSRgCOjmXSjr/Kv7cc21UKT2l5TgDLMf5tbgS7zLH5To8/9WJCdi0
         aoCvlH9pCe3g3GC4xVfiS7sOFsiUBR12S9jxWmAvgU5BWhnKlSBvOXr13rE5iWUo+xRU
         U4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740514592; x=1741119392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=glD7coNk2GO9/l1adKLN+uo1Xfh2D3YWudU7CjoMsSA=;
        b=HodLk1j0GM/+Wfu2mbOf9yqcAzSMmm3q/HqGZRNIclKwB48f+IjP9KH5XlxNg85aE5
         x/XMOBenrvD9U+RZaxmTdYiEBPvVQodpXgrJd/A/4oxB6f5TryxXnsejj1jgFr7tJR50
         oCoGv+aUK6QLHluVXv++CJm/Lb+ZsK8jE1qki4FqHs+eHuarP84NqdY7UajGTJ6fHRpE
         ZrwVGjoxATUa+zmd1Tre5tpCTG04Uj60Y/gH8tORe/vE8eoZkyY+W0UalLRZEhgSthjk
         QqhknfgKM9CNBjWBF7KL7N4SaDC70Kf32ZYpxV9bkUTWUCfFwdTIqg2tg1frF5hJky03
         bGig==
X-Forwarded-Encrypted: i=1; AJvYcCVJmJjq+IpBNGc8wB8gtOxjxWZ9AJTspI/OO/K7ESCJt28M4juQlYCqAyf2anFcxf6bh+PF250=@lists.linux.dev
X-Gm-Message-State: AOJu0YzelPMC2iKC68rXSBrQi7xd11xd6iRQoYG2cgm0hnR7MUA4oR+V
	ZA329un9TwpfczixfbHpOufxbzfddPDmJ5uZzLcneZCa4+PG3M1J
X-Gm-Gg: ASbGncuP7cQvsSomQjsh4UPlvY9WwrQ7+auf85BGCkXNeWXd1XSxlKwXz0H0dx1YABM
	xuyw6l3Ie+kWl5QwxHpEOZsroGHt3VhnkTAZUZNIPnA574Axcr7emN9H3L8rkzJ+cT6lSVACqMV
	JMffGUUQ2SwJDxssPpH8GE3ksEwHU6deCYi6WOwllr60lkrm+XW3cao6dxKB9MtsI2v6XNGVtBK
	CNwPbYuX0oLHT5GBuJIq2TMpragsujPYI/ldohw+0ghRqbKTgDsydXNRWB1AXpYLxnsP03GJWRy
	lIxHBGOoYUjURbVwWqgDphOfp0N+7PL5/nsAFNcwy5RmgcHB+1Q//fjOMfOPR6826WH+Kr1evh7
	FX3EtMNv9mS45m+CAEcT1A9wF001TGe1VJxrQjuK7Kro=
X-Google-Smtp-Source: AGHT+IEjvw2ycbh6O1a2xVehSVYNCqn405b5ejvhuSsYBKJJvxe4gk715VpktRuefN5csP8lyNYY2Q==
X-Received: by 2002:a17:907:3da7:b0:ab7:98e8:dcd4 with SMTP id a640c23a62f3a-abc09a097c7mr1694058566b.20.1740514591509;
        Tue, 25 Feb 2025 12:16:31 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed201218fsm194319666b.104.2025.02.25.12.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 12:16:31 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Ivan Vecera <ivecera@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Joe Damato <jdamato@fastly.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Frank Wunderlich" <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v7 net-next 05/14] bridge: Add filling forward path from port to port
Date: Tue, 25 Feb 2025 21:16:07 +0100
Message-ID: <20250225201616.21114-6-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250225201616.21114-1-ericwouds@gmail.com>
References: <20250225201616.21114-1-ericwouds@gmail.com>
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
index 0ab4613aa07a..c7646afc8b96 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -383,16 +383,25 @@ static int br_del_slave(struct net_device *dev, struct net_device *slave_dev)
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
index 1054b8a88edc..a0b950390a16 100644
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
index d9a69ec9affe..a18c7da12ebd 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1441,6 +1441,7 @@ int br_vlan_get_pvid_rcu(const struct net_device *dev, u16 *p_pvid)
 EXPORT_SYMBOL_GPL(br_vlan_get_pvid_rcu);
 
 void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
+				    struct net_bridge_port *p,
 				    struct net_device_path_ctx *ctx,
 				    struct net_device_path *path)
 {
@@ -1453,7 +1454,10 @@ void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
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

