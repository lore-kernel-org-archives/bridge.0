Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47F32E62B3
	for <bridge@lists.linux.dev>; Fri, 13 Mar 2026 03:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773371079; cv=none; b=df466C53X+9s2u2TJf+j5mT/pzaXodpGht+nKuL4HRbwds+b9ZOcvha9GPfKebkCEbwNrW4dhAhY1TXnyZzPWwxkDw2hxB3skvfIxVt2vE1II650D6PZOyNlsgYq81EMi9JPmAZSuyK2tHrcvZvwkpyPqhFbyBdQENRBw82hv5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773371079; c=relaxed/simple;
	bh=I4tJr0wcN2egmg+HlHDIhE18HXzqUjm9zwXxnCfbyB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LbvPSkOB4NTxYepzj1RzEBvb95R3CTgXEp5woZKWIM2hY7nth0879Sj+87NY9pmovnmuK7MvUpBIhbhSQ56pyv+T53zHBRboF4ILtKIzOLiHYrVV9tpGGGSrJy//Ft0cZhxx6/XZKPAKy0p44lwnkKqbMAQDYiaZ4oAeqPQ6w34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHmKDJvR; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHmKDJvR"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35a1f3f07ebso445533a91.3
        for <bridge@lists.linux.dev>; Thu, 12 Mar 2026 20:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773371078; x=1773975878; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sjhGrfJof2HReSiAWd8q2bv7fT33KudQzX2odTz69Us=;
        b=gHmKDJvRiuFKoyrmlXd/ZUgrtjreiu+V3c0zGyDrm3mbd7c5ICWmqqqak77LVia9dT
         2hCpC636iAYtPVsjUrEHmjXs5NuWuKeCQrjbAWeJIZo7jzuiahKHMMDXv2RWpw7THDTM
         VSqAGIIsQRd32vuDyEaGlkaC4ej+AmjJG0M6DZHuVCXaGTj9wUSsBnXR+pfFQXCB0deJ
         J0890MHensVkCi0YAtkQT4MqSVD8TwfsNzpJFjA4iDrn0nHtZhTfvTsr7G4GLTRXHK1V
         hL6YWtKnRKmXbB0P6Ui+JJSUMKOXVNRBgkhHK93ittiSi59gpGECDLfuCORkFooGigXW
         xcqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773371078; x=1773975878;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sjhGrfJof2HReSiAWd8q2bv7fT33KudQzX2odTz69Us=;
        b=Qb4ZWN+Ednc16yVKx7J4M9ZfSY+s1pVnvsROyM3jWhdQwIru6ZyDDX6svtXFiuVKSF
         KcmW5zYpVu1tKgdbyk1pOFeXF6hFgdJO7EO3Z0520StTm6w26WWDhSYUM0RqxQmelDcC
         lNmbMoVHNfifOwRPqCF9JUItzuTtJbqjfAj9AITrSbW/9425NdjtFuWj/pS59DZGAe1L
         KEoSAyGkLPRZCr2qibpqc0wVELSoXIFIQVX/FBmi2Ia3Z2P30/3aAJX2QgoDNp8Af0kt
         GieYfECLdZ8auspyg3IRhbhmbVgjQL9ySWqLwih6a7rqhIjTNwIySYl3q4y6iC9DAIM/
         ZksA==
X-Forwarded-Encrypted: i=1; AJvYcCUg4z+PmRLg0BL9w0praA58p05pSIJE73whWb4Uk2VIKTpaRY+7g+QnvkiPpEbCWZfI8Poo2h0=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx42ctZRnQPa2ZYAcmbf2C48+VrDBjHtUXZKRUQoEuj2hUQRlAt
	7SbgptPLm6X8qxg/XeenIvB7DHi/Ek/1p+wRppdLwGZG/qFCxL0tmN4j
X-Gm-Gg: ATEYQzyTfsVpMU9Nuq7L9Lrgf1k0dHlQUEI7gSbASyPGQCJzEgvKLas/YDUZLJCmQgj
	XNTRQqITYu5jwRz0IxuPY9iCaDHStlZMB4a5D+VVNksierfyZNrddSu5JNwH2PDStncjrbbbJYM
	8y2lGX+mGNprjWsgJopxek64Z8bE0SUQq+eo+iR+JjbSLLbWmMvBugGwwmcIZnGTu2nXMzQiZrZ
	Z3gAlZdCcd5MRnnbd9PlsIAdFcMKynogUATUMz/ckelyAbaKpcq+ojluMY3GsaRjYvDY0LgBGN3
	8d/lWh3Ihux+GoLaxzwYNG2Qajg1sVhz70df291sivGJbd1F9TA1BB+fD2ApVTEx4oPYEb2KeTc
	3U06uDR1Hku/eF089l/SQvqIdDUL78VVrDvj+G7707rIW7Z+MQfEyzFf1el5tyJJ5HPS50yWFE1
	s6caL5Pt1VLXM+bcyWAhUdxOVo4cst0YXYVxxKKbM/ERXNiBOsstu1ODu047DaKaYZitPdu3Y1A
	fXayz5NypnPtvPXvw5GmX6/bEMedpi9UFrSy5wsESff/hbf6i2I
X-Received: by 2002:a17:90b:5291:b0:352:ccae:fe62 with SMTP id 98e67ed59e1d1-35a21ebac06mr1377246a91.10.1773371078075;
        Thu, 12 Mar 2026 20:04:38 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([240e:34c:5765:adb0:54b3:92b9:a11b:1cae])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a24a7dc1csm293967a91.1.2026.03.12.20.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 20:04:36 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Fri, 13 Mar 2026 11:03:12 +0800
Subject: [PATCH net-next v2 4/4] net: no need to disable LRO specifically
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-offload_compute-v2-4-ffbc8ce5d50c@gmail.com>
References: <20260313-offload_compute-v2-0-ffbc8ce5d50c@gmail.com>
In-Reply-To: <20260313-offload_compute-v2-0-ffbc8ce5d50c@gmail.com>
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
index 2c84d3ce3b04..57620e93cc37 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2222,9 +2222,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
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

