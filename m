Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C1E339875
	for <bridge@lists.linux.dev>; Mon, 16 Mar 2026 04:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773635276; cv=none; b=n3l/OLUaN+p3f9+jE3vRVK1YCrBgCUaCBThJYhTAn00XQq1gFfqnyDo+MMAb9LoigoCJPxjaPHtxBiBVNWUebycToA1eTtmsyHwAGZZ1tI+UhPEJFvXV4eqmIGhqAW7AxzVlXBsnNJsCju7hq43QzVlNBDV7u5iPv27UiDCgrts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773635276; c=relaxed/simple;
	bh=Pwe+hISXxf7UnQW3PsrYTHnib7m2N5HUUsdGQZrsYtM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uda2VT+TvVolkNM2IlYPagOJ6r4Dd2fQ41NHeWVYcW7u0GPqEX3M99Cv5woa3/hgHPyV/PHReMmrWAojMYdac9Vk+3B0htnbJxNIFSLBY+6zEGHek/imr2Ykj5QEHrgu86wzbwdLEG9q8ax8RQupXRpGLwt9bIc6PoewM2hMAKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VlxTqQOk; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlxTqQOk"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-829b8b6c4d0so3349507b3a.0
        for <bridge@lists.linux.dev>; Sun, 15 Mar 2026 21:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773635275; x=1774240075; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AJCl7LHn28MJC1H9+y+noJgdFBK7VWHZCxMkHXcBrlc=;
        b=VlxTqQOkTNs+hdUXAU7wAbSGJPXmHwDCvSAnT0RwiQOy5uF4N0ZkvIC+rlecEV+iET
         0ttH5EgDJqFexyOc8SKMgrYS9ESB4yFFut8MU0wdtnxIMX2eceuSqbdCHkaQh3gC5XXp
         cOFQ1GDxjsspzPp3LJ1UqCCG+AHZuVAqj1+urJxp7St5nM6V+K+EvGgfcoAWjRo9REQ1
         UgHyzk3y+pIQ2j1jpfY10tDdQz99/5NVMqirnYSHZ4JWJ6xFhPOeGfFZUPNdukzTmeYq
         AqGOL7E3KPat/jZk1c8CO6f1u2Cp8YRSLG7iqHZWzD+hvmEwBLmC5KoIyUvWfpIWmr97
         13Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773635275; x=1774240075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AJCl7LHn28MJC1H9+y+noJgdFBK7VWHZCxMkHXcBrlc=;
        b=BMZ1/3r087pY3YRX6A5zh2TFu/Z26WB4E9/VNUQ3aPt7IBsUREn6kgIUc3zAzKrdkF
         /MGPbKzoF8Oq/IGJZflCTbh3KVAwsfGh9HUz2Fr2Y/mfWqE1mX+IXoLbwOVDkJuUgtdM
         4WxuZGEJPLLy14oeiX2eS5OBjN1YCRBMfWnHEQHwSdGEKRaUoOMVnxawNRMUoLQuRw2Z
         sb48/rqbcvFN6tVOdBsXae1c63ql7vEPuLFZOED9sED/qeO0/5rzkwObemsm+BnVVY71
         sZk+ggpPBDepX37SiGV6eWNz8P4erlLLb8BFGdaOxH2pwOPy3wv+RHHYzTV5m5QlH5vI
         ADHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI3wgdF3hPnVzzrqQHeY0MvIAxKhvKQ1aRbHJT6RpjNs0L0WHxx9v6Bj0+bXk4qnrpNqtn3ao=@lists.linux.dev
X-Gm-Message-State: AOJu0YzuSTXoZJZ9BC+gHjmovD7qpQW2ttWFZ/7Af7KAb+aURnBBVRFa
	domsupNiMSo6SbtKfKdFx/Flx7dAMPzyltkwgE3ZYfp59nDCVEVmM2Qr
X-Gm-Gg: ATEYQzwSDyR7BnYHgzgWAMuV0dQ/6UQKO2b7elrryMxrXlnkzhdVSIGfMFNrFRsn93U
	rLpvtkRiAajuvdQmDV4E45ohS5umT0nvMUonoST4yyCYpsfIuU7Bbqlq7fH+Np3kHffKpD8VoQ0
	zD8EIl7imoQpRF0iAlIBtiUHuJ9JlhxfZGKFyV9uyI4ApDvmNjvz5fpmN8+9tL9KLdEWaKoxzu8
	ppZKUok+qh7hIhzqE8kWzIZ0pUklNmV5dUzF2G371U9e9acqsIs64DnGszMHlssf6gdFIAc0OLY
	ToevGAjBxnDTvqNfFA3wZP2B/TCfIODWKTxei1l0LUoZR8GehGoyhC/hwkIlP0BEvyQKpuOE0bN
	b0kK5yL3wIFqbGmps2uQ6v68W6HTK1tsd2tgRHE1waPaLSoLvrxEynjpTucQO5djSvKk5AoQlAn
	DC2euDLFbYVcKCBghrGMuz/bGwI29/hlu0BLeZ4iSxIE2AklmyXo+VbnRsNA==
X-Received: by 2002:a05:6a00:929f:b0:829:822e:cdc9 with SMTP id d2e1a72fcca58-82a1970498amr10804962b3a.2.1773635275161;
        Sun, 15 Mar 2026 21:27:55 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([240e:34c:5760:3860:bc29:deed:92d0:823c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0738422esm12180267b3a.55.2026.03.15.21.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 21:27:54 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Mon, 16 Mar 2026 12:26:13 +0800
Subject: [PATCH net-next v3 5/5] net: no need to disable LRO specifically
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-offload_compute-v3-5-a5d4a07d86d3@gmail.com>
References: <20260316-offload_compute-v3-0-a5d4a07d86d3@gmail.com>
In-Reply-To: <20260316-offload_compute-v3-0-a5d4a07d86d3@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jiri Pirko <jiri@resnulli.us>, Nikolay Aleksandrov <razor@blackwall.org>, 
 Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
 Sabrina Dubroca <sd@queasysnail.net>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bridge@lists.linux.dev, Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: b4 0.14.3

In commit "net: use ndo_update_offloads to set offload features for
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
index ea6bb20f9348..f4f6ae02f7ca 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2221,9 +2221,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	}
 #endif
 
-	if (!(bond_dev->features & NETIF_F_LRO))
-		dev_disable_lro(slave_dev);
-
 	res = netdev_rx_handler_register(slave_dev, bond_handle_frame,
 					 new_slave);
 	if (res) {
diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index affbcc6fc130..4f18205dd30d 100644
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

