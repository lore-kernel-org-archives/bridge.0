Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C28A21ADC2
	for <bridge@lists.linux.dev>; Tue,  4 Feb 2025 19:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738698601; cv=none; b=je5WlO18Rtni/yEj5S6sNVDnYFKzsklvT1zMbDct0LEuNyIgWo+LD1iSYT+KcYtMpDf5FyFG8JmPdB8bVPci4j8fgPSkcINSMh41gvAMGvVeupH68R8sXboTyrOoVbQAFFghZfS9sWfgfKEDa/nRTT4QoaCZXPs2ffGXXJd+4Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738698601; c=relaxed/simple;
	bh=7hjVfCkns+vqQFnGF8Q7jWozdhbMtX7RB8eHdAqvruU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOb+wA1o51lEOi8ATRUEV1yJ8Epned6qad/IPD6apeF2f6dKpHPvHsK3RSEjJtwRI3B5AqQ6FYLlouEM3lphnUD+wT10F0MGIQgLEUsRKmc1dHSn55DTfuWNVLI4+i62K4f+9sckn3Q3qWDPjhRQzArtGDzFiydXb/biGrM2c9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZ8dmjq/; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZ8dmjq/"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab69bba49e2so886876166b.2
        for <bridge@lists.linux.dev>; Tue, 04 Feb 2025 11:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738698598; x=1739303398; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsPCevqpueBx6GSFI4rD1h7XgDDvXf62bnEByGQFocw=;
        b=PZ8dmjq/zDveZw2Q7bndc1Yuk037GYQB16ADyDcEKh3s9W5mmvx7H7bWBOJmbMpswY
         GTIo4YnWoPfu7grBGQ5cp4ZmBwQD7SbKDGhLRJmt93m3wWcCrSqqlGLl5zhBznVDFhw0
         fCyLzr4Pk28a4GPbF4OyP4HL9MHTyOc3RF6tE3RkZXC6KG771UNhmux2lhxGtwmJTaAy
         OWNdF9RZHZQiJnOotXQnze2qedgwOJuQZ4EPrDAOEXzZmjDtSS04mhkXrGo321bxv+3h
         uDrw7KKDvutpsNBtpp8R2YQrXKyvy1dN+HhnetjR5cfLVPuxxigl3xSDXuyR+Di5KFlm
         ZbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738698598; x=1739303398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsPCevqpueBx6GSFI4rD1h7XgDDvXf62bnEByGQFocw=;
        b=SQwByEdPHv+iox4BT25MqZ4n1uCJQSJfOw+0+hCS7yyzoZSp/D7/FNUhehCwPweolK
         keFLb0bQGnjZ2yxy6CIH4GbBbUfk63JET3aYb1sQEbTlq0oycwCR5cA0G5y1ocRoW8u0
         gwNiuj3jV5aVMPll4DG6FroOx5q+VmnfflL09z4x8iYcpDItVexmmGbxXLR54cDsqbUy
         QvzmqjKAgPMty2/uX7g5Qdx7G/JCT8YM2Kv8NH538U9p2pUGyAcvl/OXQRKTeYvAntcS
         umoKQe7fHEN51w3zS/rI+qWIIEhEJo8l1wlcVM0DMJu+HY3EBdwvZQYZFH1euYFo2GyE
         wfWg==
X-Forwarded-Encrypted: i=1; AJvYcCU8knQJau8zCa59gItWoS/X0x6MuR/K9qD5j5NqcmqN+XazzUK10iAseNdtZx7bxuYxvWmxMgY=@lists.linux.dev
X-Gm-Message-State: AOJu0YxsPK/wOP7pyKz0Q3xyYRmL9yxfTP3/AAeOjjybKp8r83UVPUpj
	is+tOdOPjI+GlqUbQHW1LONcAAfV6fQffZFFX3EV1mrxsvoqn6gm
X-Gm-Gg: ASbGnct9UWiEM2FVIB+4++lugyoQU0FQeXd0zIc8MN9x/kXQICasnb2SU4dIRCwomoV
	1tkMXx0Fk93qan3biG+6s4Nm1YmQfNO0gPbOs1WZ++c70bYTZ0IEQN+0F2+UGxn00rLhKDk+Mnu
	0/1NV/P3C02dBaQBv4DBC88kpqwu+1wEndatsYwFQg0TDF2c3ePUTr9WIdTRPfxGJEgpQ9E54wB
	70LOaK1m6whru+lBD4xLPK+Giy+MmC7z3lbgvZLuo99dCzozR5gFFbNcUzMr8jhBieUbXyEAomC
	4KG11Xurvj2Wpwpfn4pyLQ8ChoLOvkagBPY8q8lHNWcotyGn6/LXUVXGvUFJLqe8/vnIj8TaYNZ
	1Mg4lkKj+W/0XTFsJBgzb4K38BUM7QAca
X-Google-Smtp-Source: AGHT+IGsvAO6yB125nXkOzzJQ5/yZRvVQfJ0zTUKb3SHTgAx94hlT9r32V6YfG08Gq0AwS0+7SB3aw==
X-Received: by 2002:a05:6402:42ca:b0:5dc:caab:9447 with SMTP id 4fb4d7f45d1cf-5dcdb7297ffmr798822a12.18.1738698597522;
        Tue, 04 Feb 2025 11:49:57 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e4a5635bsm964684466b.164.2025.02.04.11.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 11:49:57 -0800 (PST)
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
	Lorenzo Bianconi <lorenzo@kernel.org>,
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
Subject: [PATCH v5 net-next 05/14] bridge: Add filling forward path from port to port
Date: Tue,  4 Feb 2025 20:49:12 +0100
Message-ID: <20250204194921.46692-6-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250204194921.46692-1-ericwouds@gmail.com>
References: <20250204194921.46692-1-ericwouds@gmail.com>
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
index d9a69ec9affe..07dae3655c26 100644
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
+		vg = nbp_vlan_group(p);
+	else
+		vg = br_vlan_group(br);
 
 	if (idx >= 0 &&
 	    ctx->vlan[idx].proto == br->vlan_proto) {
-- 
2.47.1

