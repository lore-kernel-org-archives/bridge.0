Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED89223E77
	for <bridge@lists.linux.dev>; Tue, 10 Dec 2024 09:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823983; cv=none; b=Fj8d7d8sAT0E/JPy1ewX/mUlt7BHVJD3hg8ncL91hpFEU1mkQXkKwNDmOiZ73aEcxIVVA0Q5WTNYCeQnXSG+K586StB4qQXq8f3Lqb7qNdepLkB+qd38Rf6ybpacm8KWnLgD1ZdYcUsMmEotgyKzKRCXvALTTAXmUgCwlVW01ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823983; c=relaxed/simple;
	bh=jNdmUtmmLWwn9rk4yVMKaaPoDxyz2/GusjoWrAJe5NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOMEWAFp53SWg8LGLGD1M34MhWWKbbB74FuPJ01oWqeCCB0irI2YbJGD8Kf1B0XTynYoPWNsLS+WfSIuH+XkIM0PS+EONv2zfSoWazRMKybSoo5Eabi7gG5Ty4L17MNreKsgSPXP8BAZUmbowiiIQ8+yYCLV2NNapG+4kJtIGZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSXjK5kk; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSXjK5kk"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d0f6fa6f8bso7650660a12.0
        for <bridge@lists.linux.dev>; Tue, 10 Dec 2024 01:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733823979; x=1734428779; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgr56AJOAsne10L7JfWzoylFaIhH9l45zqgX/3P/NmA=;
        b=WSXjK5kkGFuWmycanjqa1UU8Wbw5spEbQTB79bDAQYeRAEXURmJQwCSQUXg4hIM02d
         O/Y85hI0lfzT5OYXn0voKGDUdi7dDrFuEnDFd5xBLID6KkXTkvQXW7kB4M7GGD2L8ZJ5
         fz8H/AF8ponF6Qa7PNzuUAnCKAGUu7esWTsq8n9S8xkUebgePszCIx3vrASwfetJXfVZ
         ZTsNxG+oGumbWkulXhrQcRklBxXMn1+IVzpvYVkIJdJqdI6oR19gHkmk/3anQrJQdhSx
         uKbxB+Sl7XWKKgCvKbskoPy6bgb33mPeO7M8530LRKdm2xl75Jie8IdP5d010gdgM/u9
         PZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733823979; x=1734428779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgr56AJOAsne10L7JfWzoylFaIhH9l45zqgX/3P/NmA=;
        b=pDUS4LGScSnKMlxEiNIC38IZhkzwAkLD4NpPSV786ayHYR+piDnwgzGKAJJ3vs/FSJ
         EFel+0qcsHFH/dDcmCrM4QbvZtkigr+Om701i6q6pRoeP3rj/8haU2XHZ2pNIrffoxXp
         I+1XsDJO60630CxriKtgMvn3QKQ2wEZVa46Vif9/8bPIqwrata4i5r7XPV+GvrlNmDdL
         ltNeitsJmoMDRpthKmZo4Y+8mlcyf5IH8Oq/u8sJVIiYnNKNw6b9EisLiD1/lAK6TL+l
         KsW7oJMSqOzmcTg1ag/zao+ctRYOQLFVqYNPLbGlUadgeymgW5aQf7G3V8RlMK7KqAgM
         l2vA==
X-Forwarded-Encrypted: i=1; AJvYcCVH8mTnQ9TbOAT57Ngsg1Qf8JXhhZ3QsSWyKJGMKyUWZSCWPgwh054HXAsJj0y+1gB/EzNsY6k=@lists.linux.dev
X-Gm-Message-State: AOJu0YwukBKS+TeLg3b2zS1JmWuJ0kSEoxap02ZLF2jIhHRT/e4D7drA
	qbqVfQ33aZk9yLu2wp8W1UspkxRVtnqk5xkFxNDDodUF4x35fjaH
X-Gm-Gg: ASbGnctpxKa4xDMkHnB8kEr8MsC9e0zA9J74h/E3B9r52tRKRTo8yW9xskuvVxXDx8I
	qovMGvraIsSVy5H+CSPMEtCgt+ZpEbRzbFmmr1kwDb49uDFAodoOiEZLhl07c1U+aUza9816BY1
	/+S+/4j3bpVGSn1caJv2IB+BszKKfm6IK+K4phhBSdrBuBaj9hGuhyEPInqfuN6ujnJ5SdXJQR3
	stNQ/vOtFcBKclncLAkHLNpjkqSwbsfFcllR/0ASOZ3g9VjzlmIF7+qOP1wMz5hTLJKsTfRgJ+D
	oO9BtZCG4jOQ5zDq3Ofmmep0w2VqaE3BJLM5RpuyZB2kioCV8PFlc+FjQkJkXZyZxsDffEo=
X-Google-Smtp-Source: AGHT+IGZmVUxUDExEwI2I/Wt1QDwE1SDwE0IGYTeBPK1ELBKPlastjt+1dn458EDLOHgXMoYKOhzNA==
X-Received: by 2002:a05:6402:3484:b0:5d1:2440:9b05 with SMTP id 4fb4d7f45d1cf-5d41862e405mr4691296a12.28.1733823979183;
        Tue, 10 Dec 2024 01:46:19 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14b609e56sm7313936a12.40.2024.12.10.01.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:46:18 -0800 (PST)
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
Subject: [PATCH RFC v3 net-next 05/13] net: core: dev: Add dev_fill_bridge_path()
Date: Tue, 10 Dec 2024 10:44:53 +0100
Message-ID: <20241210094501.3069-6-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210094501.3069-1-ericwouds@gmail.com>
References: <20241210094501.3069-1-ericwouds@gmail.com>
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
index 135105441681..6dbc442f9706 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3183,6 +3183,8 @@ void dev_remove_offload(struct packet_offload *po);
 
 int dev_get_iflink(const struct net_device *dev);
 int dev_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb);
+int dev_fill_bridge_path(struct net_device_path_ctx *ctx,
+			 struct net_device_path_stack *stack);
 int dev_fill_forward_path(const struct net_device *dev, const u8 *daddr,
 			  struct net_device_path_stack *stack);
 struct net_device *__dev_get_by_flags(struct net *net, unsigned short flags,
diff --git a/net/core/dev.c b/net/core/dev.c
index c7f3dea3e0eb..01dc51abe7e8 100644
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
2.47.1

