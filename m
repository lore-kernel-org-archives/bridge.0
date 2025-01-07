Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8341A1E3DD0
	for <bridge@lists.linux.dev>; Tue,  7 Jan 2025 09:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736240774; cv=none; b=ctYVL0ag1jg+7fvaFwq4TBYqVvAGFoRxzAgvht4/fckaBoZWDkKB+veOEOqBDIhOrCFSxeLO1USBgjBoXY/6iv+Q4r7g9SlIEtNmJdXAeqKhs6N4gz6tuCAV5/aFe25SDcgX9M4W/JV8pIwlvD/GTZvSwVCy8vbu1as9xw5Eca0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736240774; c=relaxed/simple;
	bh=7XmbWDndSEvs88PZzlZNFxYNYD1e9bNkx2NqAzllkzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNY/4sKOQiVcvm9RtXY1Y1OTYp/35nuoEOq20jWDd0RshkLDiAzwynecG8kN77qFKxQiigvDhEfQGjItYkXsy1L/Doq9mhR3h2hJixwYsJwgRdzYinO44ZCGHjWMjmYAoEMCvE6UupnQ9IORbV1VcfD9xSIWeYOTIPp5/VZJVvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ew1L3mlG; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ew1L3mlG"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaedd529ba1so1706308266b.1
        for <bridge@lists.linux.dev>; Tue, 07 Jan 2025 01:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736240769; x=1736845569; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nrwgi24+JwpSHmI0m5MVBAM3u5qvCwn+TDjEgeV2UcI=;
        b=Ew1L3mlG7hN7804mVE0dZnDlBxq/YDrGUQQudDL7KuUChDQEBqBI148RizZFL7mL3d
         /Rgqu6lmnsdfJHuKcq6sVyUD/eKkyReJLLoxs6pn1wjDrtgESguYA11P0ZZeCWoazEna
         0Ul9kW9ZZcPivmlTR89GXESXoDafXn19pJ/cRPpYyhxXTidb43u65+h8eA6i2k1sRA/s
         zto+MQqFXERyWIuu9scBWM1nxw9YXx5YYuBgE6dH4EfmmV+QOftBOgKNCaW0CtGQzFEc
         vV3QpTRjMhQ3zmVXZ5MyB1fQEK8IEvsXYilhj5gIDw9Kp2d+8TBxJF13zElzVouI2Hcm
         FhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736240769; x=1736845569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nrwgi24+JwpSHmI0m5MVBAM3u5qvCwn+TDjEgeV2UcI=;
        b=Z8W+VWUBm3RDb9zHTY+ni8zTDikhvoxidhRt81+8ietWyf92rELE82WgE6rtU4vfWO
         RgpXwIe5G9rBXefXHKf9CuD49apPjrXobHbcU4A8MsVsaIlVQlcaCARMlWBH4o7lr6wQ
         cStUewd5W6daAMZUZBUh+Fq726PqgoZtk1/Mqe36pmrUULMxDHj4x5GA2kZrrzRyL54n
         B3yCSq0HRuXV6/67j8e7DR1DzHYoe8Et4XIsuPH2SIWA531H1vS9hFtuU5cLA7iTziMM
         vogH6ejlibcdxfDhykFndrTNF91Xd073F+/yBHgOJbmZ1CHJjNovV14HO05j0KGNWAZQ
         iWvA==
X-Forwarded-Encrypted: i=1; AJvYcCUhjJ6i/uUICF8DO07igEVGAPtri35j0266rK2EVw8TYQrkNaKCqiwcxQ40KRbhc++pGxB+j6o=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz706FxTlr89OCYSzA1LUErQc/GEdVHTfo2ZDp2oC+dLDyAWDLU
	5erMhhg6li8Is947bml56mgdN+J8ovsI0WEcHiSDZSFewE1hs5vQ
X-Gm-Gg: ASbGncuHtWI9A/wbNzocJ0ASzHdsOhh5FWqzb87Q6tYOcYAjHcltYyQdZvT47CfoQjr
	sb6r2OLX8mECJBxi4t5m9SiW/+0CCAf/xS7UlBlhLrhJsI4lrMCqJq9SPhK296oNNVAZ8jM0N4L
	MbIR15nnlTA32sbfCKyzTInC9OZ9005uIdbppbMT4urd9DGHTZkDS11vCyRcp+A5cnlVPQFtGre
	4L3h9XpEzfEqHRRJMvZglWPBB4jOOy09npP7SjqF4wTJmYaZxRVNvIrU7hcVjorUjDkWS37s1uB
	k6xdMBWVviB+kdvEiz4Es4v0PrrGEPyOgfPB35koa+6cK3o+/iigU8S01YYEkeScLWCNx9KDbA=
	=
X-Google-Smtp-Source: AGHT+IGuixhYjL4SuyghMfzPKIs9WMN7N2be7FgjYC3LBKQ+ZlOzUPBDz9qqDNyF0KSv3KcGoiKbCA==
X-Received: by 2002:a05:6402:40c9:b0:5d1:1064:326a with SMTP id 4fb4d7f45d1cf-5d81ddbf672mr139428959a12.15.1736240768590;
        Tue, 07 Jan 2025 01:06:08 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80676f3f9sm24005333a12.23.2025.01.07.01.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 01:06:07 -0800 (PST)
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
Subject: [PATCH v4 net-next 05/13] net: core: dev: Add dev_fill_bridge_path()
Date: Tue,  7 Jan 2025 10:05:22 +0100
Message-ID: <20250107090530.5035-6-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107090530.5035-1-ericwouds@gmail.com>
References: <20250107090530.5035-1-ericwouds@gmail.com>
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
index 2593019ad5b1..7d66a73b880c 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3187,6 +3187,8 @@ void dev_remove_offload(struct packet_offload *po);
 
 int dev_get_iflink(const struct net_device *dev);
 int dev_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb);
+int dev_fill_bridge_path(struct net_device_path_ctx *ctx,
+			 struct net_device_path_stack *stack);
 int dev_fill_forward_path(const struct net_device *dev, const u8 *daddr,
 			  struct net_device_path_stack *stack);
 struct net_device *__dev_get_by_flags(struct net *net, unsigned short flags,
diff --git a/net/core/dev.c b/net/core/dev.c
index e7223972b9aa..f41b159ee9c5 100644
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

