Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53481B6CE5
	for <bridge@lists.linux.dev>; Sun,  9 Feb 2025 11:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739099456; cv=none; b=PCnhqGnTpBM7p1oSnVSYPGp+QlzftZMzrfCNBwyIm9Bc1KRcDM7Z9a0+j6lAUJy3G6QyABeOmuanBbi4AVShvCPu8cVRcfPKQcwksZjtiwCxL547x9luogJQY3E9DxbktCsD6lBtHPpaagN7LfDmxQ+4CLwQYHB+87t15iwfrYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739099456; c=relaxed/simple;
	bh=jL4m9THywe+Y+ySsb+WjfJWIbmxM5647af+Ndr34Ui4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSl3N0LfSwF7llqHGnu/FhH7lexkX4PAW3bvPPXVZN5gX+4vRT1Lukds7xKaRCYPxdwv6WLAfwKVOD3B/dYQQ34AS+Gjx9CX4CKKxR9Zjb495VYqwYoIfHmsrOj27phfjytHCgjUc9CiAO5xUsGxzfq5RZK3ue24HZFXZANBqkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQmBlJx3; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQmBlJx3"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso611842366b.1
        for <bridge@lists.linux.dev>; Sun, 09 Feb 2025 03:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739099453; x=1739704253; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiV2XWtkfGXlde1QnvjR6tvTdGG2fr19IqREO8Jjig4=;
        b=iQmBlJx3dVvC2Lgyv9S87Gfm28+pECMkgKVp7kUZo/ZpLjluC1aJUx8Z44Cgufw7m6
         us2HR8GTaCbN5FNbLpZ8tNipEoRjBSTcbkY58QJPU0QHE9LFgrB0NsMTgg6EbvtIlRkW
         5FQxBxX/6qJ8r18t+j3KfbGMmUVWrSa1P6kENhDpltEev/g15wmHUwy0nJH32YcpKFZ3
         6YCP3dSzI1aG8imks7TyWCq90y6zMM5wVcIy0U7WLVokJcWTJEAm9gEa6DHtV/jQ+nnu
         zQFVX0VtSOY/UQy9nCtYcj/K4bXDbKhs132RyliN/D6G4YIOCa1Em6U311r2eYNdfSqN
         pvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739099453; x=1739704253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fiV2XWtkfGXlde1QnvjR6tvTdGG2fr19IqREO8Jjig4=;
        b=iACnuCVWlhyE/17xizKgve1feIh7iMhgNf37HIDVqEd++nVcF+60H17mlMcznaBePy
         o0mSt7thOxTOtlH8biZVk/jqJv1fZE7GRXnXnfsyArKfRl+42Fe/pg5y+n9Y6J+Vk5IW
         MwH+nyq6UC+jbJHrxXRJqUpSRpJr0huk+vGLmALYp78MsjYEv5xGc5HO1DZcBDcYbo6x
         FpwnWpyhdGXB0Np8NiuRQXKZz9b6q2GRDu5tL4TdjqftAq7o4FIH5DBGSe0V+WNrHbml
         Y+uSIUyResxpoAlvm88D7VzzDGzRMRWb4R+VTm4N6Y45z7bDxYLYnK0v8WGjbvIgwnGu
         ztvw==
X-Forwarded-Encrypted: i=1; AJvYcCU3xevBrhffcsXDnNC+7czJOGDZVzARzYTlwSYwLJijgVK+bAl04VJDTT6ynSN2Jj8RvgKsswo=@lists.linux.dev
X-Gm-Message-State: AOJu0YxN1rlMY+xPx7UEEjEt0dITKM2PkYeYBhpWrqVUP7LmlglJwPZM
	hKHYLlq2cJ6a2k8Ro7ROqCFPfeSKmiLmW8YCs2QP0PcYXnS8hDKa
X-Gm-Gg: ASbGncv8jucOFVRIC3IX6I4R4u6wJZMznWyDsDM/qvWzyEAZyqZKD4O5bXdux+fMv0j
	J991IJd9Q3/OT8ZfRQr5a8ODjFGn63wxLinuSxjufdBkW7Qh2LqHHsopSY5X1UbLLZtyITDyVaz
	XJ7dY1wMYSVC+JwxtTLkvLLA7sKhK9Ygeuzps+wYGXftKwBVMJU+Hn7nrQWJ/QXR4DIAkShMgXA
	zfrZvHv2OTMSy5OTVKjQRJru0rzBGH+i0jZw/8uW17UKcrVv1jvw3n3GEHRswOyPGKNrUH3410o
	jwVyY2iGkKhTf0HW6VuIMhWp3oZ+0uuHsLVeipekRmX0dEIAEi83Cvnu3xllTTd+DTM/7vxHu+S
	pS7U7x0YP51KLzmKVgwK54Jb8RnXM0f/M
X-Google-Smtp-Source: AGHT+IEmLnqa0nGSLzn3hjiFdgZfX9hAmJ8z1fc9klOPfXuoZo6FdGrvL+huNkWGACzBiYRhNwKTyw==
X-Received: by 2002:a17:907:6d16:b0:ab7:3e27:ff04 with SMTP id a640c23a62f3a-ab789a9f58bmr979157866b.3.1739099452941;
        Sun, 09 Feb 2025 03:10:52 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab79afc7452sm357516366b.163.2025.02.09.03.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 03:10:52 -0800 (PST)
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
Subject: [PATCH v6 net-next 06/14] net: core: dev: Add dev_fill_bridge_path()
Date: Sun,  9 Feb 2025 12:10:26 +0100
Message-ID: <20250209111034.241571-7-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250209111034.241571-1-ericwouds@gmail.com>
References: <20250209111034.241571-1-ericwouds@gmail.com>
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
index 5429581f2299..9f925dc3d1d1 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3281,6 +3281,8 @@ void dev_remove_offload(struct packet_offload *po);
 
 int dev_get_iflink(const struct net_device *dev);
 int dev_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb);
+int dev_fill_bridge_path(struct net_device_path_ctx *ctx,
+			 struct net_device_path_stack *stack);
 int dev_fill_forward_path(const struct net_device *dev, const u8 *daddr,
 			  struct net_device_path_stack *stack);
 struct net_device *__dev_get_by_flags(struct net *net, unsigned short flags,
diff --git a/net/core/dev.c b/net/core/dev.c
index d5ab9a4b318e..70d767cb8bc9 100644
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

