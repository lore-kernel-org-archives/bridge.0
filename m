Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ED91E3DC8
	for <bridge@lists.linux.dev>; Tue,  7 Jan 2025 09:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736240770; cv=none; b=dsufLOD/3smXZ/w1dwhK9lr6EM//7olul3eI47sNRPcgdNAY0B4vLMMpjTWoFYR/IjjGmeobrWp2cXgx31aUXeDypMeRXbiMfyG4tbpB4tfu+lCbDml4XtSd2VMoDdmLTBQTJ3AKvdwsVL+wEFuWeYkEbw/uJSR9ZRsXUO9BS4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736240770; c=relaxed/simple;
	bh=mCdJorupZbFaQ3ucEHtHHKn4v/RNMnVY9IhyUnZPOss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IR9FeRwH70Z6elSBTVwRJ3EOjIhysKXU4JNCk7/hGMPM+0GbuMl6t8eUTgl0WhoRBlXORNewGAMs031MX2tyhKalzWtwA14JHLlSKpdXfP9CWl2jtyx3KfvivU6AKNZvzWRbyxx6L1IktNANl/KLaipbvz5A3UW4AFSkLZmkH20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYcnl7+J; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYcnl7+J"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9e44654ae3so2550081266b.1
        for <bridge@lists.linux.dev>; Tue, 07 Jan 2025 01:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736240767; x=1736845567; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inK7YfAKbOx/gvsqH8JrlXFRxeSCmPFOnUoO4T3PkD0=;
        b=YYcnl7+Jq7Ti+A2A3Hroz1h0ZpwIdH/2c2oTN3ARSEhF6mlftVntEZiACvQ5PqWEwM
         h0qA/OazoHGZ6tBDo+UxB4E4FqwyruzjqgYGonW4PuCuecQYztxa0zkJnt6lRtwgtKzH
         ffS9Iv2q7Tiutrm+S8KMADgMVX5Rg8tVnbyTk6Vp92aRF61wh+cOjgGFH+ahlnqlS3x5
         vEFwO21LnIYljz5eTFF2SvyPnr8DUwIs228HzQ0kq/HQy6GS0vH/ndZd0aopkrlvobHm
         Fulpnd1k6RY6vLcQSB/AiEGlJTx5L4xOyQBVQNM8Bwy4OOFo5hIHCtdCi0s8obLq6IhW
         Wkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736240767; x=1736845567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=inK7YfAKbOx/gvsqH8JrlXFRxeSCmPFOnUoO4T3PkD0=;
        b=p0SAxD7M1uM89kNCAzIsNAsaqV6GYledQwn2hPLrz7eVwDK5KuI5eDxhVibkctPv/4
         CChHJsnI0Itx4+ow2l2VwdkhB7ou2nv+kDisfQppEOhLalRolf1pES/1t4Z35+QwuRTY
         CBIiBsyPiiU3jN9Ncns1SubaHIjl2Xy6y4UQNKxR+km9Fo8M9FyhB9xeBDPcMBdv9lYH
         IBZ28bmM/LKWvdaPCsdhz3FvBDlMnVuV7TcI32y8ceFkP6BrsMbvTdG1T57tcXmk5nCK
         tWHzI1T3bWRjVf38ZjN0za2qv9iw4BE1vnuUSDoij/CzVzuTNNCP7hUcKBlMpFRMsURs
         4dAg==
X-Forwarded-Encrypted: i=1; AJvYcCVw+FztdnND891ioO3gI9CdmueqFaaXbDmsSEGc1KVekE1Z3H6YgcLTDX+pIKZ0DBckDJw/daI=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx9Q0CrdQPxkv5BPGSyiISrChyhuJQ2D2EOKro+Tx0ICsCGG8aN
	30lKScQTgjjXGODi7/7FwtqmK6RZr/HIk9FIta/rviuexO7gCVw5
X-Gm-Gg: ASbGncsIoe/xWuxMwie7dDwZLV5zzPDsziD3OOip8ewldUjqjIxojfXk9lkOSJFQok7
	SqQPN4Lnr7H49+540ubnQDmM95UHhioET7uRVM5eYQ7G8ZKHY5JHCIF22p7N4grPIPEiB3s1Jk0
	Dj9TEHTUN37diIAQ/txKaDJqzrOn8kDXXNmY9zmWcMbyAY3ADCuU6oXLxCXuco2otoRgIpVVAIl
	D6pmWBTgdAeKaaBK3Y9avOToET++KGPcyinSrM3BzzuNa47D8aJnnPd94x+3k6rWcfJ3QMRq07y
	BjX12hWGEqfw/uLxYnvy3+GvhM+4H3qsHm3Ki1MEas2lpDIZL3LYgbJg9wEGkNAqr6FaJ78BXA=
	=
X-Google-Smtp-Source: AGHT+IHrdDy9A9gTXFzVem5TTKGvqrwcwaAGIG1kmAOtqGfBDbimoZPMTBSrG7qD5IXkUnDJ5cWKBA==
X-Received: by 2002:a17:907:1c1e:b0:aab:9268:2626 with SMTP id a640c23a62f3a-aac2cf5063fmr6251574966b.25.1736240766425;
        Tue, 07 Jan 2025 01:06:06 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80676f3f9sm24005333a12.23.2025.01.07.01.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 01:06:05 -0800 (PST)
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
Subject: [PATCH v4 net-next 04/13] bridge: Add filling forward path from port to port
Date: Tue,  7 Jan 2025 10:05:21 +0100
Message-ID: <20250107090530.5035-5-ericwouds@gmail.com>
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

If a port is passed as argument instead of the master, then:

At br_fill_forward_path(): find the master and use it to fill the
forward path.

At br_vlan_fill_forward_path_pvid(): lookup vlan group from port
instead.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/bridge/br_device.c  | 19 ++++++++++++++-----
 net/bridge/br_private.h |  2 ++
 net/bridge/br_vlan.c    |  6 +++++-
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 0ab4613aa07a..c7646afc8b96 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -383,16 +383,25 @@ static int br_del_slave(struct net_device *dev, struct net_device *slave_dev)
 static int br_fill_forward_path(struct net_device_path_ctx *ctx,
 				struct net_device_path *path)
 {
+	struct net_bridge_port *src, *dst;
 	struct net_bridge_fdb_entry *f;
-	struct net_bridge_port *dst;
 	struct net_bridge *br;
 
-	if (netif_is_bridge_port(ctx->dev))
-		return -1;
+	if (netif_is_bridge_port(ctx->dev)) {
+		struct net_device *br_dev;
+
+		br_dev = netdev_master_upper_dev_get_rcu((struct net_device *)ctx->dev);
+		if (!br_dev)
+			return -1;
 
-	br = netdev_priv(ctx->dev);
+		src = br_port_get_rcu(ctx->dev);
+		br = netdev_priv(br_dev);
+	} else {
+		src = NULL;
+		br = netdev_priv(ctx->dev);
+	}
 
-	br_vlan_fill_forward_path_pvid(br, ctx, path);
+	br_vlan_fill_forward_path_pvid(br, src, ctx, path);
 
 	f = br_fdb_find_rcu(br, ctx->daddr, path->bridge.vlan_id);
 	if (!f)
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 29d6ec45cf41..94603c64fb63 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1584,6 +1584,7 @@ bool br_vlan_can_enter_range(const struct net_bridge_vlan *v_curr,
 			     const struct net_bridge_vlan *range_end);
 
 void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
+				    struct net_bridge_port *p,
 				    struct net_device_path_ctx *ctx,
 				    struct net_device_path *path);
 int br_vlan_fill_forward_path_mode(struct net_bridge *br,
@@ -1753,6 +1754,7 @@ static inline int nbp_get_num_vlan_infos(struct net_bridge_port *p,
 }
 
 static inline void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
+						  struct net_bridge_port *p,
 						  struct net_device_path_ctx *ctx,
 						  struct net_device_path *path)
 {
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index d9a69ec9affe..07dae3655c26 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1441,6 +1441,7 @@ int br_vlan_get_pvid_rcu(const struct net_device *dev, u16 *p_pvid)
 EXPORT_SYMBOL_GPL(br_vlan_get_pvid_rcu);
 
 void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
+				    struct net_bridge_port *p,
 				    struct net_device_path_ctx *ctx,
 				    struct net_device_path *path)
 {
@@ -1453,7 +1454,10 @@ void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
 	if (!br_opt_get(br, BROPT_VLAN_ENABLED))
 		return;
 
-	vg = br_vlan_group(br);
+	if (p)
+		vg = nbp_vlan_group(p);
+	else
+		vg = br_vlan_group(br);
 
 	if (idx >= 0 &&
 	    ctx->vlan[idx].proto == br->vlan_proto) {
-- 
2.47.1

