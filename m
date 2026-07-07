Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53C63911B6
	for <bridge@lists.linux.dev>; Tue,  7 Jul 2026 09:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415480; cv=none; b=ZcM6mHJdUXFwQvllcaUBFl7JSr6JNjz8obzpjosYtuFsC1CzNqQ6OPMcLmVyGUk45gXCvypOdK7lM0B8okWffdIrOLHzk8QEhllLuLsWfPkQ7vXmciTU+yopasDZmpOMhwgf5PZfI62MyV1/Bi+vTsUtMgYujyRaW3osna7s0JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415480; c=relaxed/simple;
	bh=cnD7jahdq7G1Q9SmXEmCD9A2fyUANXgV/XLl0q/cPCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IHa3yHTQB+IrjTJh4PDpvCkk1euMdv/pC7Kmw0nhCHdM4zbwgaGEZNqSJiCHthRQV6f+3c5rlXVR07aiFXdRHX/5d4fXm4GDuyIj2nSRCzZ3kRiVZyYOhW7p1oSv/pGMy4LFAW/vKEqCewk4i2WSuMANkUvv/7MVZ2+jG81Tqrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtw650Mb; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtw650Mb"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-698e5859a3cso911331a12.0
        for <bridge@lists.linux.dev>; Tue, 07 Jul 2026 02:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783415477; x=1784020277; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLtHBP+kPSWoPuhJNrOLFVJEuA0mq3S8UYf0yZ/z0ro=;
        b=jtw650MbIfIo+6rcDNpPLbbrtqnN+HaHroIyR2HtFkQmN6XupAAQ9nS2Xfnc129KkQ
         gppYWZlZFjWOfKeennxmbpJYU6rkKR19RRU50kqHJFSxoiy0e+CucZUk4e+arnCZwIIj
         eDF+syU2OZkae5SrmhK6bIb5fDTYZuZGxx11p7vpvGlYDYkZ2yhe54g4QxHuExbwguJ2
         KIORMlhhwRZJ99EmTcbi0jqY6sDxe4jp4QRTIMD7ymVAFNN1e5coqNndfVw68QFc6AfK
         Qu3hskjFSUhzUyUW+dr1t8Vl2selh2J8zpRVNQmzMjUwE8rgzLSAvDanze8B10GSzyQH
         mC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783415477; x=1784020277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VLtHBP+kPSWoPuhJNrOLFVJEuA0mq3S8UYf0yZ/z0ro=;
        b=gDXhSFW3YAe8noxgoaaU/WNO++3PqBZVT9I9uiKhpDz0Jz8ZD3YWDnYzgAHF9GGwlx
         BYeww9vm+2MjDpQPQx6lGgClPWvs5HSbFqUb5yHAcnqrZx8FTjZDnl5ke+uvhc5SzP3s
         XxbcR+Cy32lMBKnnLgOkkwq95ZO6Bct0cl70vU9f/p0OPBjTDNshKNzKY3+a+n3DerYi
         PNp/RA8JEZOwnbSHb7rQ0ZkxqyOCe8RRcF4Rw6pUlQgWOyRc8K3JqCsl3gzK837tAI6s
         Py1MHnwbVbvsichAb2yWLWeljRmCLAQGcNjndTJGuYGtEvIwr5NZbX7Ku2AQbCZquhU/
         E3YA==
X-Forwarded-Encrypted: i=1; AHgh+RqK3gOjx5sU3Z6p/Wn5Q3BAxdKZn6HhaAawt7+PP55opJI4IRaFQzIJLB3Vxu+/CM5n41OZc2M=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/FcVws4RaVRDAI0GzguX4Qortndi0pgYkI4/eclpHHXZ9QT5X
	zdI46aQPfkR16UXU8YuRjnNKTnrDW3FFZ1nRLuRkqkV+x+OhkDmBC+bc
X-Gm-Gg: AfdE7cmFmL5Qo15YunPfNFCHJ1oI7LbWBQiAgk2olYwaSFSMyzC89DX3rwWnnt3j/sO
	UVf792X1+Cu1epqomIUej3mebNzMs8B0OF3VKt4X4KXO2AAy7jNh7mRCPVjHrE8iIHk2HqsZ2P9
	pKyjaq9rlU9zXqd3wwGQEgGupgfgHZWO9cn4/aB2LQn5M/aBXnNuwbCH2dTw+d7/9EKsT1SNgMD
	VDMF+x58H6r1br6w/0UpRRw9vch3aEj6A0jp2FOgdo74cTiWSg2y+NdY/4MDa8AkDWGDoE8B+oc
	xDbrnuEbLiFLFzCzQAUo7q4wVmHg+hp8UXvCs6cMdaqnMRXojLeqDu+CYbTd1kEAWRPJzzbTuou
	D+q/58mT9mxxPMG44VNh+u1565PqEdXz17n6o93MIF7k+qSDvv/kIq8EWHmOv43nWVnJjeEAzAl
	W6ShIhEYS2JeDG2QoHEmK2j8vU1ZQ30j1PJGbc/R/wlNV5nOwF4ga3MjrgYnaEEc//uOOrP5TEL
	/p21C259D4w5k71mc4tJ6sg6hga8OKmadn6Dz2LASGT
X-Received: by 2002:a05:6402:180b:b0:69a:8e43:ec95 with SMTP id 4fb4d7f45d1cf-69a910bd402mr675661a12.7.1783415477014;
        Tue, 07 Jul 2026 02:11:17 -0700 (PDT)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19cd87d6sm5297152a12.6.2026.07.07.02.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:11:16 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>
Cc: netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v12 nf-next 2/7] net: core: dev: Add dev_fill_bridge_path()
Date: Tue,  7 Jul 2026 11:10:40 +0200
Message-ID: <20260707091045.967678-3-ericwouds@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707091045.967678-1-ericwouds@gmail.com>
References: <20260707091045.967678-1-ericwouds@gmail.com>
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
index 982b6e65a4be4..69b499ddefda0 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3421,6 +3421,8 @@ void dev_remove_offload(struct packet_offload *po);
 
 int dev_get_iflink(const struct net_device *dev);
 int dev_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb);
+int dev_fill_bridge_path(struct net_device_path_ctx *ctx,
+			 struct net_device_path_stack *stack);
 int dev_fill_forward_path(const struct net_device *dev, const u8 *daddr,
 			  struct net_device_path_stack *stack);
 struct net_device *dev_get_by_name(struct net *net, const char *name);
diff --git a/net/core/dev.c b/net/core/dev.c
index 4b3d5cfdf6e00..f6685c1e47860 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -750,44 +750,84 @@ static struct net_device_path *dev_fwd_path(struct net_device_path_stack *stack)
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
2.53.0

