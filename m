Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D476155345
	for <bridge@lists.linux.dev>; Sun, 13 Oct 2024 18:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728845744; cv=none; b=k7Zk9+JcYRo8Bwri+XB9vxiBhDSL+puihNnB7xCc9XH1uSvUwV8T9GACsLmsHULiPQriqztIExqMaORGnxKOMJoP9zqBbB0RAOpjEOqbhXcTAYlwnuTPQrZo1hlU75/OernWP+TgAsCQ0JBT9nL9hG1lscDkVLm/jeAkad6Nu9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728845744; c=relaxed/simple;
	bh=jvjjfXzmQDVAH55jYPPc3+4Cp/SDJi0V57uD2qNQC8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XOssIF4lIrOzIPxJ/YGx8IkmiaP7ExcQH4qN6aRIqW92/geybSRHObnLvwMSgAI0JugAmDPO3GQbXvB2CTuHhDphDWRhDewTJAgIgB3lkCsUspF3YSvvTlUzxV9VNGIfi9lQQhO+vScBS9a3y1KcziofuaI4s2hgpxWKhR/c/qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzPdZpld; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzPdZpld"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a993a6348e0so289229266b.1
        for <bridge@lists.linux.dev>; Sun, 13 Oct 2024 11:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728845739; x=1729450539; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLdtf9AkfZZtftPmO+QTmZhKFxRRSQewBGWvAuWXxX0=;
        b=EzPdZpldAwx6HuDyU9drFdfVaSPlig7m4KxStzvRqYLBP0sLDDNdqzd09zRBKHHhMA
         I4JwgUnTwJPSKuhu4LUvzKHOP6cENBvWmtSgTyNV/b7Yh2nLeoDxWoXHK8cZBWffPabI
         B22i6zRhWx0pi4k0zGlCGamqXCU70vH+NkdzANeEG9AgvpZMq9lKNvBDTov+wvLe45xu
         r6LDdS6CYb7wtNJ9KHIgInZisZcqQ8f2aEIdaFTENJPKY+rKVrTtzVoo42FJ3hRM/CAV
         g3pL8oe5wpH0mViWlMsDrT5zScFU5+3JEkyCZ/LMrQq+jc8yfJlkEDxkYQu4SKKooel7
         s6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728845739; x=1729450539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OLdtf9AkfZZtftPmO+QTmZhKFxRRSQewBGWvAuWXxX0=;
        b=cZJ+fq4ufgQTb0h0JX4SSPKp3ROgromH1mkUezlxDvV9sPqrrqLWebrYrSxKt4jffv
         PhUlW4XcKPvHQDg3oozOS0aUOxmkdeck9U11R1/ztfuNsbCW6kncCKNE/qY6tMFEVdpG
         Q7VEcu2Ro78pNjCkCOMQ+kbYikBVOGEjZUNF8YDTQ6NETfxeFnghWA9NJVLPiY93/m1p
         LiHROyeJGtS2R29YpvOgDZ73BywfeMkH9Q6KnBbSlq/+ItzsQucE+ci96j9eSnvou5DU
         AK/9rctraHFcB4SKYQV9oYYzBP6JHmE76KWxgmSBgvRfV25S3CN86Mfy33wHw1FwmkDX
         r44g==
X-Forwarded-Encrypted: i=1; AJvYcCVD/gGXhzzF64qEiBAsRoGgzeZ10pdzcJD5zXRozyS5vog3MpiwRxwzuv11o1RrwOJQZHAnYI0=@lists.linux.dev
X-Gm-Message-State: AOJu0YymYb+ujezd51YupUMZAsv7wVUoALEvtr2NArN+hxReiaBR8tS9
	8NxmwgH3SvPZ1BS7DGwK6v8YNF3T1zQppSH3x5XZGR8Kgvxmjlx1
X-Google-Smtp-Source: AGHT+IFGmTnwONoCtYAAkw85QCQZ49i2r3KEyVZKqIg/rOT96DkANV9Cgr1YZGISZ8fGwYKHbFWZBA==
X-Received: by 2002:a05:6402:51cd:b0:5c9:492c:f7fa with SMTP id 4fb4d7f45d1cf-5c95ac09939mr9913132a12.1.1728845739130;
        Sun, 13 Oct 2024 11:55:39 -0700 (PDT)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a12d384b9sm13500866b.172.2024.10.13.11.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 11:55:37 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"Frank Wunderlich" <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Eric Woudstra <ericwouds@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH RFC v1 net-next 05/12] bridge: br_fill_forward_path add port to port
Date: Sun, 13 Oct 2024 20:55:01 +0200
Message-ID: <20241013185509.4430-6-ericwouds@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241013185509.4430-1-ericwouds@gmail.com>
References: <20241013185509.4430-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If handed a bridge port, use the bridge master to fill the forward path.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/bridge/br_device.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 26b79feb385d..e242e091b4a6 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -384,15 +384,25 @@ static int br_fill_forward_path(struct net_device_path_ctx *ctx,
 				struct net_device_path *path)
 {
 	struct net_bridge_fdb_entry *f;
-	struct net_bridge_port *dst;
+	struct net_bridge_port *src, *dst;
+	struct net_device *br_dev;
 	struct net_bridge *br;
 
-	if (netif_is_bridge_port(ctx->dev))
-		return -1;
+	if (netif_is_bridge_port(ctx->dev)) {
+		br_dev = netdev_master_upper_dev_get_rcu((struct net_device *)ctx->dev);
+		if (!br_dev)
+			return -1;
+
+		br = netdev_priv(br_dev);
 
-	br = netdev_priv(ctx->dev);
+		src = br_port_get_rcu(ctx->dev);
 
-	br_vlan_fill_forward_path_pvid(br, ctx, path);
+		br_vlan_fill_forward_path_pvid(br, src, ctx, path);
+	} else {
+		br = netdev_priv(ctx->dev);
+
+		br_vlan_fill_forward_path_pvid(br, NULL, ctx, path);
+	}
 
 	f = br_fdb_find_rcu(br, ctx->daddr, path->bridge.vlan_id);
 	if (!f)
-- 
2.45.2

