Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CBD20AF7E
	for <bridge@lists.linux.dev>; Wed,  5 Mar 2025 10:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170616; cv=none; b=VkWFzi/3kiPlQvIGlJ8xGgIGQ5q/bIBriQQAt8PyhsU0rA8egt5yLvWCAXBVO7+7q9YSpfizdepUEoMG+OCG108RdpUeua6XyL435TLnZbb6Ut036Wdc9rZSX6xl5rrFAiKnqYE3YGbD0ovLwDVt2BVEzRmHLKxAdWmr5IJUNZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170616; c=relaxed/simple;
	bh=PBHyuPBG/ButhJ6qRcnSF9I0EBwamgj3VpeiHQaqfac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rk3K1aXGgShwNNbm+4JE2J50FDghVYhLMy55mN+jg5ZzazrYkh88EJC1Mfih768YmBpJDstjLYMdRLag5fqCkP0a+Nosgk89JbHauAH4RiGhdG8LRkRSpvXd0Ce/PnlHmK8sAfBuU5QjGnYjh4+0GzRFs7uP9odjEh2Y8oalOj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWzg8PL9; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWzg8PL9"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e4d3f92250so9128245a12.1
        for <bridge@lists.linux.dev>; Wed, 05 Mar 2025 02:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741170612; x=1741775412; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XruRHgHNa4U+aD5EhN/5bdzeM8wMLCsm+ZTeJKtfedw=;
        b=eWzg8PL9cvfwuI1CdwEcMjE1SyKm5+DTMB8y2waudqs1NrsfawldlOmjQfm4GLBUIL
         dbgv93HAfJNG2qbs/AQsQAN+e6FhK21FX0x4GKTXzJKSn5TgDxnad8ITbmH5LSyVhMNJ
         AcBNsPiAfK1VKh4gtxLy7tIuJS/HnDMIdV5nxkbn2sI/N2/zC9rremkY+5wQx1sKZ6rU
         uQybWsoqFT8+jzaYy2DMsKGm46m204kt98dL3D7cY3JB2W9DEYz+cQPWneHykm/V53KB
         wvTmXXVtkdhF38SVd/VhuMXJ0TV/1dYCCsXPhuVCK3kmQee1sfmfcrcbkdzMA0SzKA7M
         yGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741170612; x=1741775412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XruRHgHNa4U+aD5EhN/5bdzeM8wMLCsm+ZTeJKtfedw=;
        b=FWjSCloE1MVIxGF2XCHqOHGEGPvdGkzD/Ab4VzcCgBFPWA5Ej5VPkqbKF3LXXy2pVw
         q0sEfNH7vvFWTK4wo/Z+aIzLj9Xq9Co/4W/pTBBH6yC4Tefx6P8ySS8FB7PGNDPxZYwO
         K3aBD/3arx2JQR20W4bmIHbWZpWzpR9a+dYTvxe5BcOtygyWFxXAsLIpq7/Pizr5/xcO
         7ZzHIatBxg4vWdx384nzQTgPOBQEPjhSSe28WT01xvZMGmBO05g79WCeukY71L9jyuE7
         sgO9h3uGwJR8cB9A2PVYfF9Bc66aTuIEQIC/Y5QfCFS8UXFVzIHjBjTvTVARf4PMa6yH
         J0Fw==
X-Forwarded-Encrypted: i=1; AJvYcCWCF6AjrSO/yF8DLwCcGRiX7b2Ydphn9REtkCI35syEutWWtZ1FewUXnOJke0Bv6eyyKQQaIsg=@lists.linux.dev
X-Gm-Message-State: AOJu0YxvWuEA9c1hvwDfO/T3fPimdZe9fFaL870GgwzLUY1az/AW5yEo
	pQq7QuVo2MZ34XDKJ1jkFjjpR1Da9RJ8timQsppEmK1RWppFBMi3
X-Gm-Gg: ASbGncuotyDXDDJPTL902JdhJUhmOsxnw01gVokxHMNh1iDFxGTlQJrr3lUK5Ss2Jpb
	m7bhwT6GWAv35zc0GuggKgvXbJmPrwZrH/XSsXQEJgO8d8Qo1k1eOL9h8qXMY0VdqE7XkDRy4GF
	vhvIZwo9vY6KUomIro8aoSK4dmK1dD7Uwy0+HjDGyEIwwu/+agw+SdMYEy0mIebjSUK7B8RBK/R
	277gWvO+uwr31dVcB06FcYr1rlb9lpzxXYMxkahfXp9Vquk3axVfS+fpwQUl/Mt5aa3/k7rbeFF
	f5prKTjMvMjJPBXUfNWb8RterQ6Q1EQ7mL+s/AOm1lpDv8slqbcAv/ZuIKBAfpE6L0QauVS6PaN
	o1Ayw2P9fWSSp/6lalpnJPYijIjl5CT9upbySMsI3ClJEczIIts6QHtWnOE22lg==
X-Google-Smtp-Source: AGHT+IGWn08A2DSO8MVNqGyk+bS/v/k3a0mXwDhZkKNPGgmv7Ei/GzcOqONoOScVVDEII0Mp72AZ4Q==
X-Received: by 2002:a17:907:1c84:b0:ac2:473:7f35 with SMTP id a640c23a62f3a-ac20e03dcc8mr267370466b.55.1741170612157;
        Wed, 05 Mar 2025 02:30:12 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1f7161a4esm247154266b.161.2025.03.05.02.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:30:11 -0800 (PST)
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
	Ahmed Zaki <ahmed.zaki@intel.com>,
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
	linux-hardening@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v9 nf 07/15] net: core: dev: Add dev_fill_bridge_path()
Date: Wed,  5 Mar 2025 11:29:41 +0100
Message-ID: <20250305102949.16370-8-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305102949.16370-1-ericwouds@gmail.com>
References: <20250305102949.16370-1-ericwouds@gmail.com>
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
index 7ab86ec228b7..81cdad85d9f1 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3318,6 +3318,8 @@ void dev_remove_offload(struct packet_offload *po);
 
 int dev_get_iflink(const struct net_device *dev);
 int dev_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb);
+int dev_fill_bridge_path(struct net_device_path_ctx *ctx,
+			 struct net_device_path_stack *stack);
 int dev_fill_forward_path(const struct net_device *dev, const u8 *daddr,
 			  struct net_device_path_stack *stack);
 struct net_device *__dev_get_by_flags(struct net *net, unsigned short flags,
diff --git a/net/core/dev.c b/net/core/dev.c
index 2dc705604509..d0810f052d3a 100644
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

