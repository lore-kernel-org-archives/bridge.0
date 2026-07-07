Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD89039099C
	for <bridge@lists.linux.dev>; Tue,  7 Jul 2026 09:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415480; cv=none; b=S2Is0POCfkCQAV3F1DabfNLB3kOxjLuxO6Kly8WkCUiv7f5nvFWriboc8ejf0k7rPFHE3Ow8VUGypuKgym3QaSo8eepY62V8+kqVs0rmvLUUfZynvm8uH0JOiWXscXCvYSwfrl7IUqscyxY/70rAt+VvZQUqbQs69tcTU+GhlAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415480; c=relaxed/simple;
	bh=/L2CYa/L6Hv5Bh5hGEfPIOCpX6+gefXiQPwWix/MMqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PHFnfUb8k91zDwxoS5zGXApiCaZAU9kXamR5hDqQdlJtalpYiDOGr+HrbF5gEele7Md2bBtr7EFM/QJX36yXTBlkiTK/zasWAnhUPCykBN1+NfAaBHQ2J/j52eYS0YNUxdX9wTG+Xs1cxOUcCP7AXCl9nPpopbnVvdbqGyPyXJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2bheNeu; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2bheNeu"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6986287534eso6654586a12.3
        for <bridge@lists.linux.dev>; Tue, 07 Jul 2026 02:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783415476; x=1784020276; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sm5HNUD7n1DNF0D2zqXw/bbAWgUYwja5myfoUO3KdJU=;
        b=G2bheNeu9Hkmn5vKkCbr/c4K17Ug5ca7W5C6+FwEkwCU8qUNyHIyYh8JurJodPu9Hj
         qrK00e6uA25dLqOQD38JWSNq4KKbHbx0V0mGbnn/pyTSlT/iam4VbpFovb8ae60UAfug
         xUoehO9gj3sSZdrnCkgd0LDrjeoeI1+AlXyKA9usfqbmr4t84ahN01fNhdQIhvTm0vBI
         fVkXJJMOzvK5n3dJSyUL25ROHR6JyUxtjuHV2sou2VeWDCoqmr3z5sDYEEjF1VFmzzO6
         jdgGd8e3LdeDFbgwEBhEbyaJEVPeoR3E66/osVKid07p4P7RIK2H/uOn49zAi71oNDsk
         rT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783415476; x=1784020276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sm5HNUD7n1DNF0D2zqXw/bbAWgUYwja5myfoUO3KdJU=;
        b=FXL4xjuerZtSVLIU8UhIZnDCM2jiFA8NVxpIDZIQS/oeDgbjCIf0EECti0YiTiWbdj
         m3LDquxUI7XbQryKf/Lmr252BPeLppSN2SSucKqH2Fyeq9I02APOuRvO+PyDqriGfKOy
         YAoKoz/oPBGTXUGQz/x5yawZKW+CFeOnfRNfxRiVsRqWK40EcH13/iNQtXayuI1L3A+p
         vjAeBhacoRl5WbfVgNy1YfGMIdwbVTSVFzb/HCkiOUHGv6fFnd/yM/C84keegc+GoOz9
         RaJj6BGc8EI/BgsZ20r2Go2cmBm9dZf7J3zZhB/26o+Gas9zVVcKGDC0RR5JaQumpITe
         liGQ==
X-Forwarded-Encrypted: i=1; AHgh+RpN5c2kIYVRWwDJzapV9rV322z8xhHodHzgbNXdVcKg5S69/a72SrrNWKLKWPHiK5EAKXPaAeA=@lists.linux.dev
X-Gm-Message-State: AOJu0YzE8qLMA6sRjhFV3AQToTE+AQhclMLypsAQcHhleYMX2lDDVW4R
	g5P6Nb6eTHWxwapiLBXzadKkqWSfIlxbq70HoUDbCq3fCfi9qVN/Ebep
X-Gm-Gg: AfdE7ckyxaMGOOM92VHBMlDAL/wnJNKkuxX0TXNd68/iFlMy2j7HTTcuOQxbL09HLXu
	dT9ifj3hHBrcxd8L7Wk0GnhEv43OT2NkjjSlVDH3XHQGulnB2zxZiJw+mQZAddVCSvlxs0npiVF
	LOwaFTLtbQk8Eg82bsnInMalSNuH6wXfg5myVg+69z/z6Huwbab5gRPk/KKMrvp4DtfOBKIFvMY
	i8hF0h4VP2vyjmGCW5vs9tBr3c9uF8pUi+IH6q4SKwpizuq3n5rR7Njmy3nCKaSGje9A8QcTHlO
	7y0RHTwjKxpZJg/pKeN4Em61LwoFTDYvZVl3tAGZ0JYnaIIMqP9ZXjZit9s1tKySfieB90Zpa+t
	4gXVt/bw3f4/omrEREw+t93ux0mjZBGiiSCwhCckvupiVD4AmcASH9a+tNwCBxVbH3c7wundeVx
	G/hYvXHFCB1M4fDpIsB9p+teXGTpQzzztpMSbJzbkfYuXFnAZnPFbk0uR0PTr0fmEbzDqGnLsqI
	84n0zZ5Bumwy8Osmce94ggBrQdhU2GxAPdUqo9n8HGm
X-Received: by 2002:a05:6402:13d0:b0:69a:9fbe:5cbf with SMTP id 4fb4d7f45d1cf-69a9fbe5d6cmr180598a12.6.1783415475927;
        Tue, 07 Jul 2026 02:11:15 -0700 (PDT)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19cd87d6sm5297152a12.6.2026.07.07.02.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:11:15 -0700 (PDT)
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
Subject: [PATCH v12 nf-next 1/7] bridge: Add filling forward path from port to port
Date: Tue,  7 Jul 2026 11:10:39 +0200
Message-ID: <20260707091045.967678-2-ericwouds@gmail.com>
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

If a port is passed as argument instead of the master, then:

At br_fill_forward_path(): find the master and use it to fill the
forward path.

At br_vlan_fill_forward_path_pvid(): lookup vlan group from port
instead.

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/bridge/br_device.c  | 19 ++++++++++++++-----
 net/bridge/br_private.h |  2 ++
 net/bridge/br_vlan.c    |  6 +++++-
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 3b9fc86293fdb..56fc80d2f5215 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -385,16 +385,25 @@ static int br_del_slave(struct net_device *dev, struct net_device *slave_dev)
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
index d55ea9516e3e3..00f5b72ff42de 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1630,6 +1630,7 @@ bool br_vlan_can_enter_range(const struct net_bridge_vlan *v_curr,
 			     const struct net_bridge_vlan *range_end);
 
 void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
+				    struct net_bridge_port *p,
 				    struct net_device_path_ctx *ctx,
 				    struct net_device_path *path);
 int br_vlan_fill_forward_path_mode(struct net_bridge *br,
@@ -1799,6 +1800,7 @@ static inline int nbp_get_num_vlan_infos(struct net_bridge_port *p,
 }
 
 static inline void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
+						  struct net_bridge_port *p,
 						  struct net_device_path_ctx *ctx,
 						  struct net_device_path *path)
 {
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index a248ce70f919f..f4a82e107ec7d 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1450,6 +1450,7 @@ int br_vlan_get_pvid_rcu(const struct net_device *dev, u16 *p_pvid)
 EXPORT_SYMBOL_GPL(br_vlan_get_pvid_rcu);
 
 void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
+				    struct net_bridge_port *p,
 				    struct net_device_path_ctx *ctx,
 				    struct net_device_path *path)
 {
@@ -1462,7 +1463,10 @@ void br_vlan_fill_forward_path_pvid(struct net_bridge *br,
 	if (!br_opt_get(br, BROPT_VLAN_ENABLED))
 		return;
 
-	vg = br_vlan_group_rcu(br);
+	if (p)
+		vg = nbp_vlan_group_rcu(p);
+	else
+		vg = br_vlan_group_rcu(br);
 
 	if (idx >= 0 &&
 	    ctx->vlan[idx].proto == br->vlan_proto) {
-- 
2.53.0

