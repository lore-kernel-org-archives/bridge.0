Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D4D3624CB
	for <bridge@lists.linux.dev>; Tue, 10 Mar 2026 07:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773128828; cv=none; b=PQ05qnBFv3WLivyohC57l0AeS4aWpbsdqdtSHP2H7M0YWk7MdRA3AqOoP1+K6CQRAFvrGWXtlkmqtOJ93vMC2+PPU2TygWXP7ImEsGyogYGjD+cW+olmkybGhLBabpLBfm4lkopXHk1xYWnqVFce9JSiWpragLyTTUGkijbASgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773128828; c=relaxed/simple;
	bh=bXnDNSFidNz36SeGMTKr9aEsO9Td+iPTz2QUPB6xp3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ed3OHTWTrrFWnuX1luCunFXup8WF/P/XkdiATzGMy9p1EpyYnjgM/RZH7nApxjv0IVec2Hrwg0JYtQ2lIGg/v7IJEyHaOi1f3qTJc2fY4rz3MqmeZgEVRJQLUVp0+Jki8h1XczWE20N8UV04LicqZUAeT0yjABjT7415S8bSVss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAKb0nkJ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAKb0nkJ"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-359f8502ea8so65538a91.2
        for <bridge@lists.linux.dev>; Tue, 10 Mar 2026 00:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773128826; x=1773733626; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3MrEEXv7Xy2jJrXRIKwxLssaRaTIm50HmDgCOhNMffI=;
        b=CAKb0nkJo5HN/7htRFxTg9Yp5p3LptnoD9+uNe0PzEqreJGuClOFgkcgCDtfS7i4xO
         lWetOmOOb5fUFtyYf70Za9PBZl5TZOZT1PbC8ogUD2CDRfCBjrdbNvpruC5RYyijRwXe
         TAjgYgiq+wZX+ErAKbYlXZE/5K02sITU7AEwifc0nIHKpy6hM2zuaBd62vPV1++Lhuag
         aa0xgoQf1tiFrrQNvbxZVx1Mr59F3TWfcWl9zcfIaZVt6J3u3NdXRbOAdnggBgOwWoJZ
         3uLJUb/4FtlBZdwnIkGBAacn7qtfbvUVqu7DaYiMkSr7r2ptYasvsSD4elnrBiTjE5Z5
         7vPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773128826; x=1773733626;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3MrEEXv7Xy2jJrXRIKwxLssaRaTIm50HmDgCOhNMffI=;
        b=DO/6bl7IZeWV6mMAKNNOXSJx+n9zp0xFMaiemCsRLF5KVinDxR5HTn/ITXq8xsvMKy
         tAqr8GOf/FW5Ki9zSmbSGuoGfU3PVbMmIak8Lb5m7hqL9XWvx44B3TfFYV3BfbwCJeBt
         KFPcAX2j6mLdBppJxcFKwGGxfr/MIweAoplNy5zIqJvAvUH8VLxf2k/t07JawCnaz6YE
         YyZMIM3ujcLBaeUIo4b471ZPi7BdHuEt8e0DXMREM1em0hNJn6haR8EyuUOX8OTPaSAU
         XWvIA1PH8ZKh59E1pdrdC2y1IXhvIG1l/emqmMTMygwaELrs+cK4qswKCY9rGUv9Ku/A
         mI6w==
X-Forwarded-Encrypted: i=1; AJvYcCVUrtmIAso5AYPIXuVnQctu0l2JCoBFrDF01mpZ+GhtLC6SSZXyQiago7IG3NHllEVTtaF3kwY=@lists.linux.dev
X-Gm-Message-State: AOJu0YxiSzRM4CTpmMh1PexahO9PJ7YpC6FjSQ3n1pCRsyBVA8m0003h
	nLgiHwpvIC9ZnYP0wORetliBL2EZV2Yc/Q5swnIRW+m7A6bfcxNhASQo
X-Gm-Gg: ATEYQzzmyxG09eG1Aap9Wif28eWxQ29BZHT+gYURGa1dbgcRbAQih+NMRkXw0Ex/l3E
	YkwQXGMKiyTbn7z7Pv9B/dKdj5qzMDNKmeP8V5c4gVm/bKUwicBFlA+ev5SOE379do0RRx84owy
	ItBFTqyBCJM6qtcz1AuB9/hKfPribE+JaQZYy+pkwq0ThZOk/8lHHEVGo11UDflJyY2rCqEVHqr
	hgoA+SAjpgoQvifRkgqdA8GUXkbV7pBCPhJprxBEqpYjDux0hZGZuWXsngP6pUQB34I5KWfUedY
	7KXccvRj1DS6Pl3ksXMbUWtuco3S5Lz6EmLLdO+3WECa/WdDWa1SMbGAlrG5zQktu/O4TYcCifI
	FyTvHvyOrDCwHsaVc6Fb4DGP6kMkwpaF9FwlfUGCFwd9V8VDrB9JRYpWuGAytK0CH6Zg4dUkAgV
	rKTFSGRje6BuwbELh0ApqMWQF6ZaXNy8C9GOsueTbP5UoStANhm4gLERRwauxdiu6+uzwZOM6Nq
	j5ZHKWnO0PnzeMiNFNr5rZAsrk7rAtGJOrmH8ruw0s=
X-Received: by 2002:a17:90b:5252:b0:359:9bad:13d9 with SMTP id 98e67ed59e1d1-359be29eea6mr12832642a91.15.1773128826073;
        Tue, 10 Mar 2026 00:47:06 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359bc7ef38csm7260607a91.2.2026.03.10.00.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 00:47:05 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Tue, 10 Mar 2026 15:45:07 +0800
Subject: [PATCH net-next 3/3] net: no need to disable LRO specifically
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-offload_compute-v1-3-3df79c09ea65@gmail.com>
References: <20260310-offload_compute-v1-0-3df79c09ea65@gmail.com>
In-Reply-To: <20260310-offload_compute-v1-0-3df79c09ea65@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jiri Pirko <jiri@resnulli.us>, Nikolay Aleksandrov <razor@blackwall.org>, 
 Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bridge@lists.linux.dev, Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: b4 0.14.3

In commit "net: use ndo_set_features to set offload features for
bonding/bridge/team" we called netdev_change_features() in
__netdev_upper_dev_link(), which will disable LRO automatically on lower
device if upper device doesn't have LRO enabled. So we don't need to
dev_disable_lro() again after netdev_upper_dev_link().

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 3 ---
 drivers/net/team/team_core.c    | 3 ---
 net/8021q/vlan.c                | 2 --
 net/bridge/br_if.c              | 2 --
 net/hsr/hsr_slave.c             | 1 -
 5 files changed, 11 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 4d32b06079ee..5b117acb1138 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2177,9 +2177,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	}
 #endif
 
-	if (!(bond_dev->features & NETIF_F_LRO))
-		dev_disable_lro(slave_dev);
-
 	res = netdev_rx_handler_register(slave_dev, bond_handle_frame,
 					 new_slave);
 	if (res) {
diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 4906ea3717b1..73d4f68a7ccd 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1191,9 +1191,6 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 		goto err_enable_netpoll;
 	}
 
-	if (!(dev->features & NETIF_F_LRO))
-		dev_disable_lro(port_dev);
-
 	err = netdev_rx_handler_register(port_dev, team_handle_frame,
 					 port);
 	if (err) {
diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index 2b74ed56eb16..fda3a80e9340 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -193,8 +193,6 @@ int register_vlan_dev(struct net_device *dev, struct netlink_ext_ack *extack)
 	vlan_group_set_device(grp, vlan->vlan_proto, vlan_id, dev);
 	grp->nr_vlan_devs++;
 
-	netdev_update_features(dev);
-
 	return 0;
 
 out_unregister_netdev:
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 030248bc94c5..0aa653a1e651 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -620,8 +620,6 @@ int br_add_if(struct net_bridge *br, struct net_device *dev,
 	if (err)
 		goto err5;
 
-	dev_disable_lro(dev);
-
 	list_add_rcu(&p->list, &br->port_list);
 
 	nbp_update_port_count(br);
diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index 44f83c8c56a7..4b6ab185392b 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -169,7 +169,6 @@ static int hsr_portdev_setup(struct hsr_priv *hsr, struct net_device *dev,
 	res = netdev_rx_handler_register(dev, hsr_handle_frame, port);
 	if (res)
 		goto fail_rx_handler;
-	dev_disable_lro(dev);
 
 	return 0;
 

-- 
Git-155)

