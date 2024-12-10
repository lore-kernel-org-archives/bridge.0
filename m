Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FD2212D98
	for <bridge@lists.linux.dev>; Tue, 10 Dec 2024 09:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823981; cv=none; b=Yl1+N7BHB47HjGTDgg7axC6oWzlQWChdc9wYRlF4ofMyFb35JCVTKaFrdwcNocnsyNvdADCCTR55X45tdOwdJCScFY03f80zbyLtHt8u8ed4En+btOgkH35enl1h/Xi/N8cFeVW1JYJq+5jqgt4mlMgi7fgZ5Dk5rIBYcdeb8AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823981; c=relaxed/simple;
	bh=8FDg8XDgxLrQXtngh8SnXV87g84Jre2hDTtrxRNL4i8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xwf0txwKE/srst60oilS2zV+fxLgE4fy0FmG02k3fPM42NRKkpX43YOr7GaKUAOx9RI8KSz77YiPGyrjRMj6Eg9gaIXRFbx9k91LNBbVHNfj7mPedvdhPfcVPioQsNnKHS0Ma54otwsohw2SalK8XqyQU8uEbUJnKgBFyp3+kwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8ac7/Us; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8ac7/Us"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa5325af6a0so855694166b.2
        for <bridge@lists.linux.dev>; Tue, 10 Dec 2024 01:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733823978; x=1734428778; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFNROVzPiBTZyVVUJmIxiKujmgCuTGia69D/U8CcyUs=;
        b=I8ac7/Us/osoY9Z5ejxx0EjwEHemsAiVuZitjo9dCzKoV9yjhAY6SZ3A6CpssBXfVb
         yaQofDFlpov1fBVAGmArcgQRagKSnrYJ/qhsuKeUeFEGz8OxWTnHAF09Vy2aoFbppCrB
         sfRHSWMGYYH6ohOJt1VKuagWOQfXOq0cXXwKbicRIteZBhqrJkVN6T4BGT6Trh4Jz2mE
         Zo2k1vU9/13v40j4n8QKoDDyWx38YoypDWFb7DitXQ7GLw9VKFkDwCKZlkwlwow89g1I
         IJrX1XZ6Gnbkv9xaZT4ILHPANC7lEcK6qwHTtZR5MM4bIj9WposTnikHz/qQdpYYJElb
         8GqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733823978; x=1734428778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFNROVzPiBTZyVVUJmIxiKujmgCuTGia69D/U8CcyUs=;
        b=s+jzd9q/e5746Hhd7bqXDQVXrMvuI4dUXpLU4asy3XjDlBpgvCq/ZRxC1JrWWfcT1U
         c/jMxU7Sdpzwjk0/ECI5xtwUMMJs82YilA1pWXUQQzT5hjCFkTvLhi8Wn+Qm3RsLclxU
         rFqbZk1ymcS7P7CwG6WbHPnSuJwTqaWpOSmFohSiNh2kDKNUOvCD2WO3mSLNZqLEfkHv
         Re3aljgSUKnAgjrR74Oea5LiMb+21MMR5mmcL4Bea7IBicgot1D58N8OYo9frvNmC3De
         cLUa42ZXJjAnez33Ft4i5oC9SnUlxJoIO4cT9CpxVVBECMPNGc22WVc6ASVTZLW+0QB4
         8UKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDM4g1IcFx2fHoXBb9CjjB9Ri1ar0KMeUWTvL9yuAv+stoL0hEU7CWnOOtc0yxxnDb9NCKgvA=@lists.linux.dev
X-Gm-Message-State: AOJu0YxC9OuoAHTvrQJTl6dZtqUIzPAjrVSWz35Wt2BrDhrjIMfHg2ZX
	Xbo/09/05qSPEeXuE3wksL98PBgDoswOSdXuqzbKrxBmk7Cc8t6s
X-Gm-Gg: ASbGncvvoSfZA9beFpnzp9pBS4YFZS8CeUqdFXCiEkwTnXkTK7OSsiDrOapvgWjECtw
	6FfLObx2UcQzKFnyeqb9EuPP48xy6TYqQOVN5adsEI7D+ddT/9/ELQLW6meyE2falhzK1hv/brS
	sSCpEK/OCgnu1kTLkHFmyHdIUfuwoxM5mXQuqKFtKnyMOqXg3zFKqVu4kZYChtRMbISQAAjzVox
	QY3twHQLaFtBZ1/OWUv4BrBHUf3LoSGLWkfL9BSZr0Wmc1cWt1xlfhglsRrDRDjZ3A4Vv2z/5SG
	TJERJmNlOM0cYDZc7db8LTRsc3479TnTOPol1kHVbH9U5zJKruwdWta7oRDhDACsnqvuEhs=
X-Google-Smtp-Source: AGHT+IFck8FUe0I7ZA5vL7ViiiUaUyfpC35SDzrKqWUIlH6m1Fs13klQNmleCULSsIKK4sGjlxJe1g==
X-Received: by 2002:a17:906:3292:b0:aa6:967c:9aaf with SMTP id a640c23a62f3a-aa69ce44445mr361784266b.50.1733823977712;
        Tue, 10 Dec 2024 01:46:17 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14b609e56sm7313936a12.40.2024.12.10.01.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:46:17 -0800 (PST)
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
Subject: [PATCH RFC v3 net-next 04/13] bridge: Add filling forward path from port to port
Date: Tue, 10 Dec 2024 10:44:52 +0100
Message-ID: <20241210094501.3069-5-ericwouds@gmail.com>
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
index 9853cfbb9d14..046d7b04771f 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1581,6 +1581,7 @@ bool br_vlan_can_enter_range(const struct net_bridge_vlan *v_curr,
 			     const struct net_bridge_vlan *range_end);
 
 void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
+				    struct net_bridge_port *p,
 				    struct net_device_path_ctx *ctx,
 				    struct net_device_path *path);
 int br_vlan_fill_forward_path_mode(struct net_bridge *br,
@@ -1750,6 +1751,7 @@ static inline int nbp_get_num_vlan_infos(struct net_bridge_port *p,
 }
 
 static inline void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
+						  struct net_bridge_port *p,
 						  struct net_device_path_ctx *ctx,
 						  struct net_device_path *path)
 {
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 89f51ea4cabe..2ea1e2ff4676 100644
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

