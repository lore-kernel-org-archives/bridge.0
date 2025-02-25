Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7631620FA9B
	for <bridge@lists.linux.dev>; Tue, 25 Feb 2025 20:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740514596; cv=none; b=HttOkcqibL1AG9SyupsSpTFNkE4xjkAExLbexMnmKUrKz8YzhWPCIRxQLFVs3cLBhxotxKCYiZePJsUja/eF1+iAfrSskiNfXlcL3lx/kMxDZuijN40yRmw+2D69ceNTH0b502T8jgyJAyD1mrwHlvXLFmmAh4owXPzLPGi39ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740514596; c=relaxed/simple;
	bh=QIhn2y3kyisjmJYCyWM38qUrYkbqfd1KGtAA3NxVqc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PI2/8yKz5TYPHKMTAawmsnYA1c6Jc9vP4c61vkTBX13R4kYDDGjHqBF2YpCwNvAhUnFeVwVP/Et0/B117vE9Pc14u6Kr2ufUak6NcXddEZX6pNrMFQXyAIdVJmRLkpQD6LTc+WD016rM2W4B+7JH7mRT6a/0YiMF/IvrzTooQIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2BqkfRF; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2BqkfRF"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so365533666b.3
        for <bridge@lists.linux.dev>; Tue, 25 Feb 2025 12:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740514593; x=1741119393; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgvvO4mRAt67HclOcho5/or4Z9zLgPRzxsVdNZtTjYg=;
        b=e2BqkfRFBRYKTmvoDQwM92iqkWAJQyk4hemJzEdRAOTwpKWffV2BywS+rt4gm9vYWM
         Z2ZiZN3gHwV8MGvnW9804oMkCExendTAPmAtCcOCNCuSi+4lTskgMwN/ta14RpMJd1F6
         l5fwLJr0LbbBlPP4EbM/mcl2Bqm0dsnujIpq8s/kDADXQ8m6SksqZNmhND2yprq1qef4
         HhwQdeCk5x08D0B16k3RyhrLeq9Gl0ksewhQoMTMemD0o5qvSJv0aG68LO1ufcu+MkNh
         Imeylg2iWSZSDb/Ix3Ofr5bucz4OO6hN029plQQh+J4J4IHNtRIZrh8UVBZQ4U9VjTsk
         MCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740514593; x=1741119393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vgvvO4mRAt67HclOcho5/or4Z9zLgPRzxsVdNZtTjYg=;
        b=lJzSS3Rqg95BhKp0xM9rutjGXczujdLePGgpbLTp/ibZIZNHzz3WLys3t37eTLCP29
         7zcSwQ/T5XGDYNwBnA+YHfj1ywhrA8t4sppbVwcGvuURUdyf749jCmPeqyN9kEwkRUJa
         Sdi8SSkGNfvsOqed0zy1VN13RtJXk5aSXwOHcilA76kcv85epEAF0iQvcyG8jP2gSZAY
         lna2rkBFUWe9FXI2aljkTB5nK1UOnfjSDQ3/CAPRFO2noAq6SJaJhgc9N8dSBgr74k5V
         TzbMwyIO8iaw6z/W5dpSQe6r0rLxRk/y4p9kbqp22Sxc6oJlOyRumx8s8FNi5Gx89TAU
         JnPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwHQWeGJ8TezA9yiQ35DAoLW5OnlQAfioQXLWEaw2zylg4WUrbDuXEHXekjyVCBySazJbQ71s=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9KEYxP3u4yRHDpAOOixSLMIZ+TjWyoZTQs6jlHopz8MvI4W9o
	EQXvexe65PhvdejI+q1EVU3Rf8Xmk+xja1Q5lxAZFqe0sq08aDJD
X-Gm-Gg: ASbGncs+RLXmthKhpUfox6b0BcFrUa4OlHQUC+NX/ZlMgDdaNVUA5fEXgtlVHBWXwE6
	eZqCQVS3/KC8mjKg36uTU8bnyy+87aNfcQ/nL0pwk1mHr8NbueDU/1VSdBUPY+VN4s0aI52gIHj
	o+JJoWZqvXSFc7K3YdCCNBYIvylAukALMS7HrDHIK/JZ3IDmnRaajd5sMHU8tkhtPU7pOKYQKRg
	n6+Fu9ozZwyTLLj4tAz2vFEvTMpdWm1+NbU5QRm6roF5fCvMeC1iLKMbIfuIHbjiljiu5vyq0pQ
	8QszdrppMYV/NvSUni33mvlDYuMFzqawxSxfMCI0XCsVBdWbEaIgzMdM9fgToI7YfUTnEDaYv7P
	hFk8Z2iqoTVVCs04dygkYT+ilavSpTNUvEKZF6CwqNFs=
X-Google-Smtp-Source: AGHT+IHYa/rnJMcG6bw4DaLIqU4PpMQ2X1tUCpndBeXitg+IOobUcH2l24ISv9vbXMdXY/Di07mP4g==
X-Received: by 2002:a17:906:31d1:b0:abb:e95e:f2c3 with SMTP id a640c23a62f3a-abeeef4216amr55910166b.41.1740514592646;
        Tue, 25 Feb 2025 12:16:32 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed201218fsm194319666b.104.2025.02.25.12.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 12:16:32 -0800 (PST)
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
Subject: [PATCH v7 net-next 06/14] net: core: dev: Add dev_fill_bridge_path()
Date: Tue, 25 Feb 2025 21:16:08 +0100
Message-ID: <20250225201616.21114-7-ericwouds@gmail.com>
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

New function dev_fill_bridge_path(), similar to dev_fill_forward_path().
It handles starting from a bridge port instead of the bridge master.
The structures ctx and nft_forward_info need to be already filled in with
the (vlan) encaps.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 include/linux/netdevice.h |  2 ++
 net/core/dev.c            | 66 +++++++++++++++++++++++++++++++--------
 2 files changed, 55 insertions(+), 13 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9a387d456592..695445927598 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3289,6 +3289,8 @@ void dev_remove_offload(struct packet_offload *po);
 
 int dev_get_iflink(const struct net_device *dev);
 int dev_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb);
+int dev_fill_bridge_path(struct net_device_path_ctx *ctx,
+			 struct net_device_path_stack *stack);
 int dev_fill_forward_path(const struct net_device *dev, const u8 *daddr,
 			  struct net_device_path_stack *stack);
 struct net_device *__dev_get_by_flags(struct net *net, unsigned short flags,
diff --git a/net/core/dev.c b/net/core/dev.c
index 18064be6cf3e..d5f4fae840a2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -714,44 +714,84 @@ static struct net_device_path *dev_fwd_path(struct net_device_path_stack *stack)
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

