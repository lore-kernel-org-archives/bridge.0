Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63320205ACB
	for <bridge@lists.linux.dev>; Wed,  5 Mar 2025 10:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170615; cv=none; b=pz1hmrNLNf3oacBBKwDxPnFk4svYG5yd/6uMiHdTPd4jhbaxTkthXqHqZwPrzshQD8wf4eYQdUr1sjSeG/cq2emi+cyKKVdAuU+kC+LCdajcw9a+y8hHXqz6x3nL4uSp3ANOc1xVd97A74kBwYaqR8l6CNAgwGe4nhTPRpkI4l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170615; c=relaxed/simple;
	bh=xttbzI/pcl6SYlB7PpU+GQoyrB/QS5WPo8yeg4iagTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qh5i6sOxLX/iaohZF83yju0UVpc50JmJ4c9y6O2pt/skuNF54bSRe1Egae7ePEQe/RlEukTltkl7GEP1FbjY4UHhtSKDQVnoONrURkLl2NRMZ9lqdnoIqlECmGteae1pP2QAQ5PG97v/UxHAPeNwmLP5q2e/24CyfKKj8WI024c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQITl/Ph; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQITl/Ph"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab771575040so121925966b.1
        for <bridge@lists.linux.dev>; Wed, 05 Mar 2025 02:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741170611; x=1741775411; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IM1kXQjhThZXDzCIWTKLQoY0aGhS2pSnBiHrFmA8ll0=;
        b=IQITl/PhITcbKLOQAerPEQEz4AaHauCu+GqgyGAQJtrEwFV8ssAcoo02L3w8p2QlDu
         bDKLKn4dJP5qbrjsRQQjHZuuxjj79TQpj0n+o1KX5JxQUmeF1qKi/1Qc7lCjkghYf1dZ
         /lSkQswg/4ZnC77+vM2I/rrmQicNwTW6YpbLGVgLKcXeRAOEF/5ZL8BOdHZPPVmPlF9E
         dI8EA87rjJILgcWwEoys80roFBjyULMwmqWNLrJ6iBvzxRirE3KF+jexFXDMcYekDu7k
         39Dv7FBQCA6BrIApg/Hwt3ScnpMsQlJiwg7Wm1BZB1ytyRihBKepUaSgszmhEfw010A8
         Q8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741170611; x=1741775411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IM1kXQjhThZXDzCIWTKLQoY0aGhS2pSnBiHrFmA8ll0=;
        b=s0tOmHjBHnh2PV5TuQhkMElbccph/rZiHl9qO6tFTf1+61sk86W4Vj4Ubr+DqWe5x1
         fuqHTjF1WttjvfQaxmaZo1z0DQMES86mE1ZIJnjaLRLjhBbXFMdRTn8hPKvrpvKSWGdW
         Ok3Kdzb+Si2WcqCTzgjjXVbxfY9hitDXRfN3GP/rvBjPVDmQOjzTMRE4SRN/Ne3MVmsg
         os34w8lJO/C4aCwWkqXWhp18FH7vqH6y0aSLVT9ChcOpWA546UQcAPGHJnAzYqRE/upw
         wGT3tDXOLdiTnwQB8POQ6wCyiDV1Ack6urkO7bwR9j4CRJNFTBFf81ws/vEvlVbV/NTj
         jbhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOSlsIi4W5SAOryvkstDNZN/xSeADWlzbSFpTGFSdMH9xvCqPjr5inAn89RGj+S4lQdHOSBf8=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx59RaX2UX1+ImCvwSw6TNCJs21YCCVv+sbO3ivvC3tOU5Wc3jF
	QBl/Kfo8RJunZDlJVWED5qkM1P5ac1Ve4osWJYaay87TiPTx9I1C
X-Gm-Gg: ASbGncuxCou0G53FccnSKFI/KMw6ig3eK2hoTpbwXa8XQjRXSkmtWDS3Cdl+HcEodhP
	4sFTSO9zuOMWKqIiv6EITH8OvXpCzLuljWP+mgBi4fAOEoz7Ni4cotdVp/kipwes4WxTW0aBqJE
	DcuUyPzxW4TxqtSsqUARj5JDuBSx5HOv59Pd+0Qw84pRFz0vYe6/chO7v+xkJWtpjWggNsYxET9
	WqxMcWaN4muuq/o560scYT+Ep6IXmavVlSzEYf/FMdYpPUvLkZGLUiaEO715iWJpZCKJUphV4g7
	zJMXiPq6K9gamaCv651zvzWQOeAQnpJfFzzmuTmJ9SPJ1+qDIcalEeFsFBzuetOAu8oXVBCvl2t
	+ASnQupMPpBSe9Ay6uKlSgSsXHlW6PWR8zbr/bkOVMPsdQ5B+ooPMO75HpQqoDA==
X-Google-Smtp-Source: AGHT+IGUiR/Ewb64RsvjGNeJXBn0Ed+9S8empXfVW8h4ZmJBkjiI9NUn/Px8AChfgHjCFcCWMHNHpA==
X-Received: by 2002:a17:907:3f9c:b0:ac1:e08c:6ac8 with SMTP id a640c23a62f3a-ac20ecf947emr220727966b.2.1741170610822;
        Wed, 05 Mar 2025 02:30:10 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1f7161a4esm247154266b.161.2025.03.05.02.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:30:10 -0800 (PST)
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
Subject: [PATCH v9 nf 06/15] bridge: Add filling forward path from port to port
Date: Wed,  5 Mar 2025 11:29:40 +0100
Message-ID: <20250305102949.16370-7-ericwouds@gmail.com>
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

If a port is passed as argument instead of the master, then:

At br_fill_forward_path(): find the master and use it to fill the
forward path.

At br_vlan_fill_forward_path_pvid(): lookup vlan group from port
instead.

Changed call to br_vlan_group() into br_vlan_group_rcu() while at it.

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/bridge/br_device.c  | 19 ++++++++++++++-----
 net/bridge/br_private.h |  2 ++
 net/bridge/br_vlan.c    |  6 +++++-
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 9d8c72ed01ab..02eb23e8aab8 100644
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
index 1054b8a88edc..a0b950390a16 100644
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
index d9a69ec9affe..a18c7da12ebd 100644
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
+		vg = nbp_vlan_group_rcu(p);
+	else
+		vg = br_vlan_group_rcu(br);
 
 	if (idx >= 0 &&
 	    ctx->vlan[idx].proto == br->vlan_proto) {
-- 
2.47.1

