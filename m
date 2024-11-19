Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810661C7603
	for <bridge@lists.linux.dev>; Tue, 19 Nov 2024 10:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732011570; cv=none; b=CgF5J5vgYP09DjFdlz8yKGsou6yCcQXYKtXQnf9m8COhK04mEVKQWyqdqhjBgV9pIRU2jJt4kNTrFeZa3lqhl5ckOa/8/C4vVCE5Nt/a8RrE23RDU/pSLT0+vf87e0Zi4zDvSK4cNmTpjwLuYFiLWX8IW8uUnEKy1sqoERQk0LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732011570; c=relaxed/simple;
	bh=DLGTszneUOBEBDZLWCnm870CxbqkcNe11Y1L1eWSarQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IsPRFeZIa5EbdK0yIop9nZQzCPT5LOgf+kKH/TYKAy4FHOft7nDHF+rRpnOVVqIsoQAhXw7oSsgaQioXTQxyuERLlMn8agcZQRYbIx7kqFOHgu5K3vHg+df0/FPRClbQfDyvl2rRMvFAbU6DVTciuPFmMxhBdjezjnSk2rdZUuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFsxnxw0; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFsxnxw0"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5cfd2978f95so2085268a12.0
        for <bridge@lists.linux.dev>; Tue, 19 Nov 2024 02:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732011567; x=1732616367; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UhjXvlF/z+0rM6u5ozJqSa6SbSygSBJ+zrfQOupSHO8=;
        b=TFsxnxw09RaVHLyDLyzie+9xBjSM4FHk1Pn5tCwSNNvoca44xKnLVOz5zn+jWPwW2Z
         c2aha0CI4KgjKGgd7jEGLNvRZi1PwKXu5+ihCpOUi/z02zcnJJTO6u3gdjOY7nFHmbWn
         mNz46lngl8IgocewO171GeBA4A9yNe1GEROZEhFHIusP9O3hWE+NowZsZt4EMvfxg7oW
         wUTxS5Q++1yqpWPMvUkPSEaYnNYPW1uogc02ubncO3BPSZXU/HDrTDyQLgn+5jKuifGw
         6j6BwtwmOeMh6OZ4cmFiLH7MK+3HlzFBoZ7peAp1S7XStjKN+UFpJo3Vi9NQ3jxKnB2k
         g5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732011567; x=1732616367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UhjXvlF/z+0rM6u5ozJqSa6SbSygSBJ+zrfQOupSHO8=;
        b=JbHjTFnELX31dqttayU9j3DY/MswdGiqdM5v1fa8vzwzB4rmXj6aou5hYEx8Fo5VJA
         +E5+brd8nuj8iotoMspa7+hUKJUFk2DgfhSA22TbTy+Jvr/jowE18TliGBvni7Bs/ngK
         gOftkQDaDPGbb7WcCHksQZ6hoVRbMdGuwEYID5KTIVZtlxFXTmHsJr/S8MH7wytgNIv/
         C0zuPry24Y6QTaWeBhpF5xdYbYqbU1XNXbZsCncm/SzV9oh2u2Jo/VtkXZzKturpm5re
         FFaJb7hKHrYMJEqZ19iwqvWlSDE9v545C55Msr1AspI5f/MxRmGwe2qK39XWiNMNwkol
         KuAA==
X-Forwarded-Encrypted: i=1; AJvYcCVn0nOraBnUoyfnMCHYjZpbl6jYapiFUKYLAUSbidvVRjhIEhyCzMFEtgsukBakGGfnscuMi6o=@lists.linux.dev
X-Gm-Message-State: AOJu0YyS2vSIqGGwcyroZP4kXYqyfkDmfF764ACuhf8PO5KwPhz8LXi5
	9S02mktUbtvlqUOUrbY4lR8l1FU+appILGmUc19X/BEDoLDOmarK
X-Google-Smtp-Source: AGHT+IGzB93ZeO7pNN+fEomEYrj7b7jdCBNk8D+nmWW0jpw6ZssNgDprYV1yl7YzBLGgZvsa4c/n+g==
X-Received: by 2002:a17:907:9303:b0:a9e:d417:c725 with SMTP id a640c23a62f3a-aa4833e8fe9mr1613209266b.3.1732011566595;
        Tue, 19 Nov 2024 02:19:26 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e081574sm634875566b.179.2024.11.19.02.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 02:19:26 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Ivan Vecera <ivecera@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	David Ahern <dsahern@kernel.org>,
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
Subject: [PATCH RFC v2 net-next 06/14] net: core: dev: Add dev_fill_bridge_path()
Date: Tue, 19 Nov 2024 11:18:58 +0100
Message-ID: <20241119101906.862680-7-ericwouds@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241119101906.862680-1-ericwouds@gmail.com>
References: <20241119101906.862680-1-ericwouds@gmail.com>
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
index ecc686409161..15923d177f9e 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3143,6 +3143,8 @@ void dev_remove_offload(struct packet_offload *po);
 
 int dev_get_iflink(const struct net_device *dev);
 int dev_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb);
+int dev_fill_bridge_path(struct net_device_path_ctx *ctx,
+			 struct net_device_path_stack *stack);
 int dev_fill_forward_path(const struct net_device *dev, const u8 *daddr,
 			  struct net_device_path_stack *stack);
 struct net_device *__dev_get_by_flags(struct net *net, unsigned short flags,
diff --git a/net/core/dev.c b/net/core/dev.c
index 13d00fc10f55..f44752e916b0 100644
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
 
 /**
-- 
2.45.2

