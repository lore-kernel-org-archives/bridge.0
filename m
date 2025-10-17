Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E823E2EAB68
	for <bridge@lists.linux.dev>; Fri, 17 Oct 2025 03:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760672543; cv=none; b=TYWtwD/jCKKSZneQDMypcvRlNAAg1p4084cAohLwhJhgAXtwev7gpB7a/6VBNlshXGCxYH2YGIzm8JuDD+6zBd4DMkeDFsTRyRcWsXK5VtqwZfavoglBX3PO8Ud5cytqXZAJ7VZBGzh2E0zhB4OVPcodxhzqslM990B07TdRs/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760672543; c=relaxed/simple;
	bh=GAj+Rj3U/iz2aCJlYeL1KvIfh4Se4wq/aFheRKL3Za0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKxg1Cnag9vWIjO1iLqM5YTFd4Asohes1nZsZXl0lVE2E+rT8a9dHHacUyXfzgbbMyN9kiZ6tKm2sx22/25sVhqSRsnS6i69h96Sy31GS/oX3AfC4X4xpdX0s1v4Q8xsdckrA6M5g03Gfxkh4J482RLC6v/yLGiizOH6ffMBjKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2zUTSjN; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2zUTSjN"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-290dc630a07so1474135ad.1
        for <bridge@lists.linux.dev>; Thu, 16 Oct 2025 20:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760672540; x=1761277340; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIu/AI3rt8eRH0zwke7Amlwg0XvJcRGg+AXdpABIBOw=;
        b=N2zUTSjNCjtDK7Q5qlxy5HO6wsmIYXGnwfY1R9fBIkl+NJf708GjJtTT1x38ml4sOn
         FTwWt+213Ujkvg+qRKX08fql4o5vhDo8o5d1HqJxdxWtwtwuFxd+EnNei+rRoZNRbLZZ
         mipdQl1sXqu1NdwGotnHij83WpC413sVdp/7ZUNZTrCLuuk0BaTSluQ+8KLsgi37me86
         6/rMKfxolR+3RbeD2KKIf81NNgUzUhFDDnYbY0GsaLWJJy71JtXRESbgI2T63SgV1xBX
         +NCYrJBzwaKLPnZOwWLkEeC+M/DvxwQERCM0eBibJTtY5QeYA9jfML3DsA6n5ALSCiVT
         YwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760672540; x=1761277340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIu/AI3rt8eRH0zwke7Amlwg0XvJcRGg+AXdpABIBOw=;
        b=mQt83ptm2C87WCtkzcpAyc9UC8GMA8N75WS5Fv5Jl9gLbIWbOZGEJEsLagonzbtrHc
         kg/rZ8p5ucZj9mNmR2wF4mcZucUjoJt1ONqBKhutbFx+4IZ2QOeaKjgFx7QICmWJz4f2
         hyS7MO0ydzOTa5p9HEKYKV1K7gPO12Rpgb7GM9jF0m/mNyR6DxvjZkiu/YvJOhAklgsC
         gVSyTffRFGP5NJ1p3fJ7M7xNT7xmJ7y6rZ9TYqetdzpBs2ia2QD/w3zXM4jMIJYRMFJp
         Uhlopfm8CCL0huv/5zDt3DLBZ+0ztAILJDNhJfMgYFvdETQ6azfhO3U3jYGk9ovPELuC
         GTgw==
X-Forwarded-Encrypted: i=1; AJvYcCWITjQ2oAq8NRjd38aADXIJHjzk/OyDEcyW+cRDv9fn4HAkQgUmMgjxWlee8AzWtgDsn3bG9kg=@lists.linux.dev
X-Gm-Message-State: AOJu0YzO97r42hJMc8YQVg0qF6jFhMQhk6yhkMtOiZOQaeswXErXF2DU
	Or4BA9JHDCHDfboyC0rkHoCQ6sc5CGeESWwUN+84nf3aXe7GX+b9G/gk
X-Gm-Gg: ASbGncs4uzcMKu17ksG3bzeZT3Y9XG89rnLAh65GBgvg9YMkWVGwxTEwYnEHmtoAGXS
	xtRU9fASzq03vPqSNsMOAWkz5+Xj9rrZonj8OvekcCHlXRda5ZVLMCmf7HKDmf1q5CRFhLmCAzn
	oF7NVHK9wITzgn8opTZ5Gn9QqdLMg0gxg2GS2vKhEWWirDVa/9ldG6JQ+SPe9y5MOFcLwB6w1JV
	9QbvmjeSVEyK5V38D4ze3Ctr3ulItNnS4Zy52noNC434uRbRQPmC1X8B6V+YV6k36/Yrws9ddwz
	MqjsTOPmtDOWz1gGxBJyjAL4OILZoRCJjHAkdmeGBz9VRXhqFDpsIt1OI+63Uf9YfFNOfwm8iIc
	+GcD7uY+kfYxKByQzt5WGO+OtApqC1A+I1XXUtcU4GVzE+KXTwVkb82B4/bD2+n9BuaJUgQbGKe
	Ku/MuG3+eZS70RFac=
X-Google-Smtp-Source: AGHT+IGpVn4CL9wEstHcEqk50p3Ed2u9SXoXAKeRWGfsyYTJjWnCjhRapkAwDqDLLKd5diZb2j0STg==
X-Received: by 2002:a17:902:e841:b0:290:c902:759 with SMTP id d9443c01a7336-290ccab6c0amr19097455ad.51.1760672540170;
        Thu, 16 Oct 2025 20:42:20 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099ab4715sm46695165ad.93.2025.10.16.20.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 20:42:19 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sdubroca@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv6 net-next 2/4] bonding: use common function to compute the features
Date: Fri, 17 Oct 2025 03:41:53 +0000
Message-ID: <20251017034155.61990-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251017034155.61990-1-liuhangbin@gmail.com>
References: <20251017034155.61990-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new functon netdev_compute_master_upper_features() to compute the bonding
features.

Note that bond_compute_features() currently uses bond_for_each_slave()
to traverse the lower devices list, and that is just a macro wrapper of
netdev_for_each_lower_private(). We use similar helper
netdev_for_each_lower_dev() in netdev_compute_master_upper_features() to
iterate the slave device, as there is not need to get the private data.

No functional change intended.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 99 ++-------------------------------
 1 file changed, 4 insertions(+), 95 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 4da619210c1f..cd7da6ed8c6b 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1468,97 +1468,6 @@ static netdev_features_t bond_fix_features(struct net_device *dev,
 	return features;
 }
 
-#define BOND_VLAN_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
-				 NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE | \
-				 NETIF_F_GSO_ENCAP_ALL | \
-				 NETIF_F_HIGHDMA | NETIF_F_LRO)
-
-#define BOND_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
-				 NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE | \
-				 NETIF_F_GSO_PARTIAL)
-
-#define BOND_MPLS_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
-				 NETIF_F_GSO_SOFTWARE)
-
-#define BOND_GSO_PARTIAL_FEATURES (NETIF_F_GSO_ESP)
-
-
-static void bond_compute_features(struct bonding *bond)
-{
-	netdev_features_t gso_partial_features = BOND_GSO_PARTIAL_FEATURES;
-	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE |
-					IFF_XMIT_DST_RELEASE_PERM;
-	netdev_features_t vlan_features = BOND_VLAN_FEATURES;
-	netdev_features_t enc_features  = BOND_ENC_FEATURES;
-#ifdef CONFIG_XFRM_OFFLOAD
-	netdev_features_t xfrm_features  = BOND_XFRM_FEATURES;
-#endif /* CONFIG_XFRM_OFFLOAD */
-	netdev_features_t mpls_features  = BOND_MPLS_FEATURES;
-	struct net_device *bond_dev = bond->dev;
-	struct list_head *iter;
-	struct slave *slave;
-	unsigned short max_hard_header_len = ETH_HLEN;
-	unsigned int tso_max_size = TSO_MAX_SIZE;
-	u16 tso_max_segs = TSO_MAX_SEGS;
-
-	if (!bond_has_slaves(bond))
-		goto done;
-
-	vlan_features = netdev_base_features(vlan_features);
-	mpls_features = netdev_base_features(mpls_features);
-
-	bond_for_each_slave(bond, slave, iter) {
-		vlan_features = netdev_increment_features(vlan_features,
-			slave->dev->vlan_features, BOND_VLAN_FEATURES);
-
-		enc_features = netdev_increment_features(enc_features,
-							 slave->dev->hw_enc_features,
-							 BOND_ENC_FEATURES);
-
-#ifdef CONFIG_XFRM_OFFLOAD
-		xfrm_features = netdev_increment_features(xfrm_features,
-							  slave->dev->hw_enc_features,
-							  BOND_XFRM_FEATURES);
-#endif /* CONFIG_XFRM_OFFLOAD */
-
-		gso_partial_features = netdev_increment_features(gso_partial_features,
-								 slave->dev->gso_partial_features,
-								 BOND_GSO_PARTIAL_FEATURES);
-
-		mpls_features = netdev_increment_features(mpls_features,
-							  slave->dev->mpls_features,
-							  BOND_MPLS_FEATURES);
-
-		dst_release_flag &= slave->dev->priv_flags;
-		if (slave->dev->hard_header_len > max_hard_header_len)
-			max_hard_header_len = slave->dev->hard_header_len;
-
-		tso_max_size = min(tso_max_size, slave->dev->tso_max_size);
-		tso_max_segs = min(tso_max_segs, slave->dev->tso_max_segs);
-	}
-	bond_dev->hard_header_len = max_hard_header_len;
-
-done:
-	bond_dev->gso_partial_features = gso_partial_features;
-	bond_dev->vlan_features = vlan_features;
-	bond_dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL |
-				    NETIF_F_HW_VLAN_CTAG_TX |
-				    NETIF_F_HW_VLAN_STAG_TX;
-#ifdef CONFIG_XFRM_OFFLOAD
-	bond_dev->hw_enc_features |= xfrm_features;
-#endif /* CONFIG_XFRM_OFFLOAD */
-	bond_dev->mpls_features = mpls_features;
-	netif_set_tso_max_segs(bond_dev, tso_max_segs);
-	netif_set_tso_max_size(bond_dev, tso_max_size);
-
-	bond_dev->priv_flags &= ~IFF_XMIT_DST_RELEASE;
-	if ((bond_dev->priv_flags & IFF_XMIT_DST_RELEASE_PERM) &&
-	    dst_release_flag == (IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM))
-		bond_dev->priv_flags |= IFF_XMIT_DST_RELEASE;
-
-	netdev_change_features(bond_dev);
-}
-
 static void bond_setup_by_slave(struct net_device *bond_dev,
 				struct net_device *slave_dev)
 {
@@ -2273,7 +2182,7 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	}
 
 	bond->slave_cnt++;
-	bond_compute_features(bond);
+	netdev_compute_master_upper_features(bond->dev, true);
 	bond_set_carrier(bond);
 
 	/* Needs to be called before bond_select_active_slave(), which will
@@ -2525,7 +2434,7 @@ static int __bond_release_one(struct net_device *bond_dev,
 		call_netdevice_notifiers(NETDEV_RELEASE, bond->dev);
 	}
 
-	bond_compute_features(bond);
+	netdev_compute_master_upper_features(bond->dev, true);
 	if (!(bond_dev->features & NETIF_F_VLAN_CHALLENGED) &&
 	    (old_features & NETIF_F_VLAN_CHALLENGED))
 		slave_info(bond_dev, slave_dev, "last VLAN challenged slave left bond - VLAN blocking is removed\n");
@@ -4028,7 +3937,7 @@ static int bond_slave_netdev_event(unsigned long event,
 	case NETDEV_FEAT_CHANGE:
 		if (!bond->notifier_ctx) {
 			bond->notifier_ctx = true;
-			bond_compute_features(bond);
+			netdev_compute_master_upper_features(bond->dev, true);
 			bond->notifier_ctx = false;
 		}
 		break;
@@ -6011,7 +5920,7 @@ void bond_setup(struct net_device *bond_dev)
 	 * capable
 	 */
 
-	bond_dev->hw_features = BOND_VLAN_FEATURES |
+	bond_dev->hw_features = MASTER_UPPER_DEV_VLAN_FEATURES |
 				NETIF_F_HW_VLAN_CTAG_RX |
 				NETIF_F_HW_VLAN_CTAG_FILTER |
 				NETIF_F_HW_VLAN_STAG_RX |
-- 
2.50.1

