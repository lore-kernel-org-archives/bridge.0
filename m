Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A8E209F35
	for <bridge@lists.linux.dev>; Tue,  8 Apr 2025 14:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744122504; cv=none; b=HWpggUZjZ0strDIhkyjGR5esboaRdOuq00DeBfVmO5TnT1fEvF9As/IhigQVa89T4xn8ZfKxyi0NN9r1NbZNPG8jLCBx5yft3ArpyxTJIPMYwkvGBfiZ4+sXxOzfXNmcfXZpSKHHYQqXN3mYbwt3134q/cmuCKF019qIhiCeV/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744122504; c=relaxed/simple;
	bh=WSZKz/K7UVWoWk6FUYdxDqC2g3rdJrKCTr4jqbfvyY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b6NCFR3tzAakK8ncff4ASErnKIiG9wZI5qGBEiVKsv/CqR15Bj2nLh/ktkNqBzDkXl2pwFR5w7qbwyalu22md6wIQtgnM3LOxbrRF4hbY/Nt8G7F0Fd9atghalF+kJE1XSgpq8ThxHQqCh5dokHjcm2zRzXOkjnFv2R4Jro9Tss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhPhOYQ/; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhPhOYQ/"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5edc07c777eso7307045a12.3
        for <bridge@lists.linux.dev>; Tue, 08 Apr 2025 07:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744122501; x=1744727301; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wiK3xf56Z+UJiP7fuMR0BqouNVJG3LzaRWNpv+Rl2O0=;
        b=IhPhOYQ/mr4CMKElxXiqvEz3NbfWp8OFOMqaEJj2AFZydDar/1+eB2JI916ZrMxUGS
         BI5VvIJ8BFrxI80Ys2mu55BKBUahUkc+biI714qjen1QjFu8ZCKr6pMnNDzCTqLURTSt
         Zd+MImMyxXEXxCWeBVdG4qwNNupjiQgwLBdAqqjwG6o9MrLS3/vgCX+d5srF/Z7txlVr
         K5NWgSZzFluzebojT99YgtMNO3a6csjX4q6oJNAbQf8AQ8vdEOIzcLR4ZTKaMxwICVmh
         IAtbf+7cvqPR4HG/g9EpqKf/XZdPGQ5S07U8HFdmuaPpzFhyu8JLhX2FXSozvxRT96Uv
         WWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744122501; x=1744727301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wiK3xf56Z+UJiP7fuMR0BqouNVJG3LzaRWNpv+Rl2O0=;
        b=HW37h6QIFtyVSZxtmLGqpNLkezeRzU4DvLYF3MoowpB2pYI4dKVG1jBJkqYlJ5aAGT
         Pls8n3wT97BYbDjUOyWdg3BDZ7rcmdHiAbVoC9edSw0jrOe5HhnF57y5dXyM19YRhBbc
         W+T5OrSObAQCiZbWF6WsIPqnc0qP9SFkThi0qzIFwP/b/9vPCcOzoluR49gtpll81+ik
         2ZW0pwGpKxXBdJK/RsIBZZKQ/cWSdA5CBfZu0a76INJz7xqp25tn7O581i+RJ8YONWN6
         dWeyw9TqCrldFyzg7P/KilRKG4DoR1SmyER4dyXHD216LbIMTDoqpGnpRUQ8l/BZqBLx
         yCtg==
X-Forwarded-Encrypted: i=1; AJvYcCU15UcJJDHvJxCCPrXeexn4xXkKVwJgBYJDcSlY/wiFsKp7SfI4oq+im+biqEcXr1WV+SR8Odc=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7rk2xZu1AZmBLm4/Uoy8agFkVebG10FPY9EUthbtXamguTEG4
	Nb+kglqfI+G6YvCicow6MTI2YPR8MCx1Cs41iFZAZwqXA6XzlKDG
X-Gm-Gg: ASbGncv6qRd8rjmJYZO7zFO1S+4vCmQcutFVfvJKxCIDfpTL2cjBk4GRZoTQvrpPxvi
	4I83Ou35+MYciFbKycb5Vib07M6Y4DuIRTP4RzXOzY6JoX3QymoA2l3HeqJapWnd5GrfGTTjcDm
	eCOA5atNU+zigs8F5Rrb4UuUPg3i5pd10VKPcRcFs/HPxjSnSwyMH9yD3U8Wvs6rFxjDkaDQqz6
	8MZQXlf+gXpHXV+fXOTlOVGSXytwD2d6W+a/+599avaaKrqOzAIVCMyWp+L9C0aqNptFQl8dtGF
	Fx8v3CVR4xNcq+PPM+529Gl1gwznqedwJZzNx4C58+mnQNdlmI4f8uwgTcq+529w4W5xxdDw4Fs
	BY8JUTZhZxPAwh1gyjt6KyPt7C6UMeEfEd554j9S6Oddt4m0dBnYA1g+qFqLqFUs=
X-Google-Smtp-Source: AGHT+IEh1oD6QhBQpwHASU08pMMzkJ2QyGD37Ub4ebSI+AqhO2VlkmxqtJBlgYtboV/1HH1EjIWc4g==
X-Received: by 2002:a05:6402:1d4e:b0:5eb:9673:feb with SMTP id 4fb4d7f45d1cf-5f0db88a448mr9660131a12.25.1744122500632;
        Tue, 08 Apr 2025 07:28:20 -0700 (PDT)
Received: from localhost.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f1549b3fd0sm2236164a12.35.2025.04.08.07.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 07:28:19 -0700 (PDT)
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
Subject: [PATCH v11 nf-next 2/6] net: core: dev: Add dev_fill_bridge_path()
Date: Tue,  8 Apr 2025 16:27:58 +0200
Message-ID: <20250408142802.96101-3-ericwouds@gmail.com>
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
index 4e8eaae8c441..cab2482a6967 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3323,6 +3323,8 @@ void dev_remove_offload(struct packet_offload *po);
 
 int dev_get_iflink(const struct net_device *dev);
 int dev_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb);
+int dev_fill_bridge_path(struct net_device_path_ctx *ctx,
+			 struct net_device_path_stack *stack);
 int dev_fill_forward_path(const struct net_device *dev, const u8 *daddr,
 			  struct net_device_path_stack *stack);
 struct net_device *__dev_get_by_flags(struct net *net, unsigned short flags,
diff --git a/net/core/dev.c b/net/core/dev.c
index 0608605cfc24..3c365e816107 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -729,44 +729,84 @@ static struct net_device_path *dev_fwd_path(struct net_device_path_stack *stack)
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

