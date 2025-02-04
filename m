Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6588521B1BE
	for <bridge@lists.linux.dev>; Tue,  4 Feb 2025 19:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738698602; cv=none; b=DqdZ0CWSCa72aT806oLvwQ0DoxbPPDcnJRP4bXJaGFfEav8+mNFIcOC+F7Y4sxWZZ3OxTMKMD91Sn8L1gbWb3Mt3cl4+mXgPOQWDdOhp4IPSmEe1C1I5jVHsIjxquXAGCX5YIL3u+lYyPROSLe/RqdjscWL/shJ3jDBjPGrdkP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738698602; c=relaxed/simple;
	bh=jJ2Iimr6BJxlql197Mio9R5mbZtVtZjj3TNAmttbndo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=No39b7eYtj2VoxJo8MQQe3BPD4dTcFvwi3wJzWXLZqbV0gS/5q7q97fV3Xah/zqPV5ucf4msitsqLcL0ZAGM6TroFH/ITF1f0EnSr8O7FBxio8+aSj6z6ukSkAwtpnGSQcF39QD+SzQZvlizFIAQuBDSVqST1yQzHu9LwTDjmFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtBQsTwE; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtBQsTwE"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab7430e27b2so340558666b.3
        for <bridge@lists.linux.dev>; Tue, 04 Feb 2025 11:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738698599; x=1739303399; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CaTNlLcx8N/VOWeG8N/sMwOA19H7daJ4VH5LDcsIDAY=;
        b=HtBQsTwEU9W4mNSLygc9oUQ5aGxuXUGZJrOLyH0Lzi+WIBpp9VVW3uN35OQ1rGfDGF
         s0V7L8gl9ukxfYCSXUxzorfi9CI6D+Z4il75/8bS1a8q8tyL6zkaz0d/a81Y5wUC+TZh
         YbXN4OxX5boezy9NdE+uoHQ0FRv3oYU7RWa4oRPpL3TYZniZfOfIXiivoGIecGGRy3CR
         BZ3/brn3BhmQ43PrKDRCeSkAmZsTSZPDLjYzov2g3vgpEdtDWeBnk1POLHzHMY93tlY/
         IvgQkj0+Z7pY2Hl9KoeOBW3wgc2lAtP4qhAvnxi0pWQDkdEL+6aN8JQB37hVEfXhTWwb
         918g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738698599; x=1739303399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CaTNlLcx8N/VOWeG8N/sMwOA19H7daJ4VH5LDcsIDAY=;
        b=uGrl4+UL4TgAk+IvGlrUCwdcUibPlMnQltyTXDChcZqFLWLtC/Zy/1/ntb21TU+3mo
         vB0sBKrJDQ8PdxfpN28LXdZegLkXoUfs6SEnAzvcWsVhz08BYrxgI4fwnDCisAKxPrIr
         EfqtyYUH6SDXq7ULaiQqM4Jcj6r9bL0DBmsjnXGNpEic0gK4A9TKOz2RnqKxzOtnw0Ti
         pP4eRx0DSPDyujrizM9bZCRS5jG7VYqutoc4WZieZjnP+y3ycx0yMN6mdY38w6PpjjFV
         7V1iuw4x70rsDgTGpU8FDM036PfJIPUr5Vr/U9kXgARjLR+428ODTn7NsCU2jP1t1NsJ
         q94g==
X-Forwarded-Encrypted: i=1; AJvYcCXNRIcQmylQ8oNwwrDQUpAyStf5rRPqgHJz1N5AHGffgn2D//xXvhnIRUtY4svywxjSlDR0wlo=@lists.linux.dev
X-Gm-Message-State: AOJu0YwrnlpggAD9n9CZesW525tQqCi+Vn2ddbUd+c1vDw5RjJ+q5ref
	zpvyX+svlKjJyFJnTUqOCQW38xe3Uj6x5zRAJ1oJottOiD48Kx49
X-Gm-Gg: ASbGncuCvq0udjYTOaQeJnFg6w+onGRmcvIxbIqWGNlN9gTU/9L254x6jmId2Nd+C75
	qZYuLiFmBnJ8mDwxe1vqS5pqz1hV0N9bKC6QT3lmziuD57tSMUrl5R39q1dhAAbvRZZ/41iBwnn
	4ci1QcHZr/l+vOvI3A9GkzI9II9tfE1YhKYKPKJZWlfE29GSkLIpnuo/T7564K3E66qAZX8Y+BI
	/nh96lhubA3C+vM1iVrwYFeMEyuIYAYW5irXMriV9dzGBphj26ZJO5EzNvNcMpirrI3woLB8NFs
	P9p7sdwkXiruXHThShyAk7dwDHLfTzkqx3fy9CeEWy10p6TMNQbbw2feMhdNbj5JYP+MPOR9To3
	kqBiuIF8uBD/KWxoN8Woj9lqvC7Fi/lNk
X-Google-Smtp-Source: AGHT+IEn1JUbmSDDmV4FTAJZUTLPh7UPgcV8aDhV23EvUqrbyMWgBZiKGFEz4RZTiOX9pR12aKTGfQ==
X-Received: by 2002:a17:907:3f8f:b0:ab6:61cb:ced2 with SMTP id a640c23a62f3a-ab6cfcc6f27mr3006053266b.9.1738698598722;
        Tue, 04 Feb 2025 11:49:58 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e4a5635bsm964684466b.164.2025.02.04.11.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 11:49:58 -0800 (PST)
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
Subject: [PATCH v5 net-next 06/14] net: core: dev: Add dev_fill_bridge_path()
Date: Tue,  4 Feb 2025 20:49:13 +0100
Message-ID: <20250204194921.46692-7-ericwouds@gmail.com>
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

New function dev_fill_bridge_path(), similar to dev_fill_forward_path().
It handles starting from a bridge port instead of the bridge master.
The structures ctx and nft_forward_info need to be already filled in with
the (vlan) encaps.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 include/linux/netdevice.h |  2 ++
 net/core/dev.c            | 66 +++++++++++++++++++++++++++++++--------
 2 files changed, 55 insertions(+), 13 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 2a59034a5fa2..872235e30629 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3280,6 +3280,8 @@ void dev_remove_offload(struct packet_offload *po);
 
 int dev_get_iflink(const struct net_device *dev);
 int dev_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb);
+int dev_fill_bridge_path(struct net_device_path_ctx *ctx,
+			 struct net_device_path_stack *stack);
 int dev_fill_forward_path(const struct net_device *dev, const u8 *daddr,
 			  struct net_device_path_stack *stack);
 struct net_device *__dev_get_by_flags(struct net *net, unsigned short flags,
diff --git a/net/core/dev.c b/net/core/dev.c
index c0021cbd28fc..179f738f80d2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -713,44 +713,84 @@ static struct net_device_path *dev_fwd_path(struct net_device_path_stack *stack)
 	return &stack->path[k];
 }
 
-int dev_fill_forward_path(const struct net_device *dev, const u8 *daddr,
-			  struct net_device_path_stack *stack)
+static int dev_fill_forward_path_common(struct net_device_path_ctx *ctx,
+					struct net_device_path_stack *stack)
 {
 	const struct net_device *last_dev;
-	struct net_device_path_ctx ctx = {
-		.dev	= dev,
-	};
 	struct net_device_path *path;
 	int ret = 0;
 
-	memcpy(ctx.daddr, daddr, sizeof(ctx.daddr));
-	stack->num_paths = 0;
-	while (ctx.dev && ctx.dev->netdev_ops->ndo_fill_forward_path) {
-		last_dev = ctx.dev;
+	while (ctx->dev && ctx->dev->netdev_ops->ndo_fill_forward_path) {
+		last_dev = ctx->dev;
 		path = dev_fwd_path(stack);
 		if (!path)
 			return -1;
 
 		memset(path, 0, sizeof(struct net_device_path));
-		ret = ctx.dev->netdev_ops->ndo_fill_forward_path(&ctx, path);
+		ret = ctx->dev->netdev_ops->ndo_fill_forward_path(ctx, path);
 		if (ret < 0)
 			return -1;
 
-		if (WARN_ON_ONCE(last_dev == ctx.dev))
+		if (WARN_ON_ONCE(last_dev == ctx->dev))
 			return -1;
 	}
 
-	if (!ctx.dev)
+	if (!ctx->dev)
 		return ret;
 
 	path = dev_fwd_path(stack);
 	if (!path)
 		return -1;
 	path->type = DEV_PATH_ETHERNET;
-	path->dev = ctx.dev;
+	path->dev = ctx->dev;
 
 	return ret;
 }
+
+int dev_fill_bridge_path(struct net_device_path_ctx *ctx,
+			 struct net_device_path_stack *stack)
+{
+	const struct net_device *last_dev, *br_dev;
+	struct net_device_path *path;
+
+	stack->num_paths = 0;
+
+	if (!ctx->dev || !netif_is_bridge_port(ctx->dev))
+		return -1;
+
+	br_dev = netdev_master_upper_dev_get_rcu((struct net_device *)ctx->dev);
+	if (!br_dev || !br_dev->netdev_ops->ndo_fill_forward_path)
+		return -1;
+
+	last_dev = ctx->dev;
+	path = dev_fwd_path(stack);
+	if (!path)
+		return -1;
+
+	memset(path, 0, sizeof(struct net_device_path));
+	if (br_dev->netdev_ops->ndo_fill_forward_path(ctx, path) < 0)
+		return -1;
+
+	if (!ctx->dev || WARN_ON_ONCE(last_dev == ctx->dev))
+		return -1;
+
+	return dev_fill_forward_path_common(ctx, stack);
+}
+EXPORT_SYMBOL_GPL(dev_fill_bridge_path);
+
+int dev_fill_forward_path(const struct net_device *dev, const u8 *daddr,
+			  struct net_device_path_stack *stack)
+{
+	struct net_device_path_ctx ctx = {
+		.dev	= dev,
+	};
+
+	memcpy(ctx.daddr, daddr, sizeof(ctx.daddr));
+
+	stack->num_paths = 0;
+
+	return dev_fill_forward_path_common(&ctx, stack);
+}
 EXPORT_SYMBOL_GPL(dev_fill_forward_path);
 
 /* must be called under rcu_read_lock(), as we dont take a reference */
-- 
2.47.1

