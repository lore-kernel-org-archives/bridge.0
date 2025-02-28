Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F934277029
	for <bridge@lists.linux.dev>; Fri, 28 Feb 2025 20:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773789; cv=none; b=Ui20Nugkn7QuT0R1j65pN2Ip2jvA6kR1mhRILjQhIrOS1HaIE77nDMQdn4XR94ifIzFcSuiSGQV/7zQGLr5pveQ+S14bt7p7z+aHjhb67F6vAflOrEGD9kU2lfrFUK0XKwSUkHVu5cHg8gUyH1kQudU9Rjloa1OS8J/yyO3YT9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773789; c=relaxed/simple;
	bh=sq5lC5Lgg2lgUcbphMYliAhopUKVFEXA0PcFARtTXys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRhTIS96kgOOaz3nOGkWj7DHkfX6fDNYtvrhRg6ghXX0fCoCzsSFIRXtVndAQWcfi/76zAK1gWM0IWTFBgqEXKVcoLa17JMHJhLa4yjABg75n+uN+KdPbJgOiGcF7kY4AKXrDH1ciVSHyokpv1XvEVsar2MQOWIk68EhVHr+fIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xd+eNxfg; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xd+eNxfg"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abec8b750ebso410927266b.0
        for <bridge@lists.linux.dev>; Fri, 28 Feb 2025 12:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740773784; x=1741378584; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glD7coNk2GO9/l1adKLN+uo1Xfh2D3YWudU7CjoMsSA=;
        b=Xd+eNxfgKyl8CN0l4bScP2cZiGYUdWgxiuRX9t2JnwtwoczCTEGU4YqvgL384I4VNG
         wCc08SXIUQsd3XDZJhZtcB1rnwJYhPZuRrj3D2Yd8qh6dTGtU8dpOlVDfbWcJj8pg1g2
         gMrF0YED6lb6wIcCb8pJfeQM8KCgk/sMyzPM+02N9IC18NVCAObtNWj2sc0XgC/sNFWB
         ENjUEmwaKyDos/Rhj9pmcmhb0pzJi49R3/3zy/LX+oupWO9mh80N+U1G/N5hQcqxQ5Cv
         Km71H53D/XJBc9XLdob8DJk8psIKgM8oOoT8jH8d8gz+BxmJMplomC5N04IJhI69leEO
         4r1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740773784; x=1741378584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=glD7coNk2GO9/l1adKLN+uo1Xfh2D3YWudU7CjoMsSA=;
        b=jzXwSDONOlN43w95PjSnWTJlNaUiBC2mXnmWjgfRkcrpC/397OH6F9Yh/VFhUmnSz1
         70y1pgBOMJQamSGb7vefX5zJuJDuICA1T75NQACtduC1O6Me/uvzxD+3GUztvXoaeVO+
         C7UB0JYWr00ZxKCJEEQY4ypUNb0Dl7/zzCTT+8DTDpc0+Jwvgwa9mxHtuXhBv58PRIgZ
         Qbl21aZGdprJBaTRDe/rbSmVcYjihZYvcgtUZcmmxyN1gULz2TP291ioCBBQ3KVknwAe
         FERUPLHbpFkDNroohIXzEyIb55Ot8wNGmXxsit1NTyQuaRE/yO3k7fgl/gc5vl8jgAsa
         yXaA==
X-Forwarded-Encrypted: i=1; AJvYcCUo47N67El1SjLx8cWXOV8S7rdrMPpv3y5fISwin9ENRdyOUEy43nHz3fiQdN402OqJo/XsxAQ=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxa9jjr9cnC1trEPbAIXHBzTman+dX19MtTDNkDzj5Cf1N8+QH0
	1EXq5viIuXsgQbPPqwvaEOZ+Mx71d8zvZz9ElFZ8p2R193LTuFD5
X-Gm-Gg: ASbGncuTwkrGQZt4YHvtpaG3pPqISBbyhckB9OpWE+CozudEQ1mT/dSVZNjfjjTyTLm
	4jdhOtoJhcVv2h/evabBqI+DedSsZnJBk8WORq3ouEBZsPqnjf+B8pFvBzSJ3YLi73nxa3Qv2vu
	10ziCaT4jju4F3Kng9A68fcVwSaBDIv7Q8iXz/WXNzy6ouqu/DT/GNfHwut4KwJb+CcP75qpSxt
	OmTrvFF6z23vczbNFfE+Id/OLsD1zxAYBd+WzR+CpFC5ixuXnJdgaml14S2Pd/fVVc2hPphLK6z
	MPYza7MD64J0So3KeDUF8/6TXvhO1pp/NB1vrGWeCpNvXFZmOlk3zPYgWPu92gUAoeD5m6gMF8p
	aQ2eG6+IA/xTmLJqLnQjx585/bhgNZZQxavTZ3pbhNN4=
X-Google-Smtp-Source: AGHT+IEkD4+S63CdkvFhMcDqcuwDe3gQEzkaBi0DoNz6EL4MylQGJKFnzY2Wc6+ZXTl1u9JBQtGaYA==
X-Received: by 2002:a17:907:7f27:b0:abe:fa17:12e0 with SMTP id a640c23a62f3a-abf25f8dd1dmr472704766b.11.1740773784160;
        Fri, 28 Feb 2025 12:16:24 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c755c66sm340812666b.136.2025.02.28.12.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 12:16:23 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Michal Ostrowski <mostrows@earthlink.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
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
Subject: [PATCH v8 net-next 06/15] bridge: Add filling forward path from port to port
Date: Fri, 28 Feb 2025 21:15:24 +0100
Message-ID: <20250228201533.23836-7-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250228201533.23836-1-ericwouds@gmail.com>
References: <20250228201533.23836-1-ericwouds@gmail.com>
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

