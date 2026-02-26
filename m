Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E4931961B
	for <bridge@lists.linux.dev>; Thu, 26 Feb 2026 11:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772106215; cv=none; b=fubttVZrzh1IumLdR2NGJYY3jn15ZtVRGW07suoDHdf2o0paL+eh+5yIirpa28LgySD+htqXd9t68jgGeCGHygqGXW6qjYHJOnVU8tLmq4+iVbGoONCi6RDe1opJioa6i5IP2AySAC7BJzuZb0/eWfNspxxEhGz/cfDBz4RT2kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772106215; c=relaxed/simple;
	bh=W8/P9pOZ2TaGtqC+2IqlgV4WZxsB2rdjDd83Ft34dw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9/OCWC5qUuFMr3F/Ff9YP9BU2mDXUgGo2ax5yNOm+qW7GaYU4CUTMtvh01HtOvg9adqgKl4w5LKpYfPnjUvVhY87egNDZrGde/JQeG/yZ9/wutZnHrOHbxVucj91b/RIeYBXAsoa/USdrn8Pq9O2ktnfSk7RI4E6Tm73FlEHeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbclwybN; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbclwybN"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c70bc5b4e86so314956a12.0
        for <bridge@lists.linux.dev>; Thu, 26 Feb 2026 03:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772106213; x=1772711013; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PbhS0NvKYgSA4IUttJNgnpP91LFlge369iIxmO7B660=;
        b=QbclwybNnxnx6XsxFmhX3pUzVQqxr4yqQMCf8DNY0onD9Xcu+JMog3dteHQgQYjYQV
         bNPcXgIlUFOLiIxgtIhqpL2VWfZiD9AtMkWhxKWAikCI/Z4Bm3Z12kwGEDJkqaxeZkCS
         Klwf4guJdRpyH1nPFdDl++ieNASzBoWnOqRl/I+QJGbSVlC3MmZvaBhUasuPxcyW0UNT
         U0jSrfwm202U/7HMo2f6+7Ovjqtl2ZXu70kL59scpsEx9zEkdE5IyR88k5Lw0CiJu5wB
         +g/sXngTCc9RLmPH6fBceLQc6e9sOlLCYPxTf8R05RxCozye5im4o5yUVAsll/Sv2g4b
         uJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772106213; x=1772711013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PbhS0NvKYgSA4IUttJNgnpP91LFlge369iIxmO7B660=;
        b=aPMTxx3tOzVmRexQPajEDRJ4UfrdhPzXd+QoACmtiOuDaSLy2wh9iFQAxGw7OP+/2k
         sBPxhC66cjLl/FgcktMlK1aMKW0fvQi52iDD9FfewNapUyEyrP8/aomVvHUIf/KPqgFU
         /bEopex4M9tQdpDnjnZdb652FceThZpZdlmj2ktOIDh7Df28/UBUQmGtqbEUjLw65XIS
         rddPLFgVmD3IGWkSXth8Bnn459ByLYZmGsBJZQg7nDsN/7xp3LA0VaKDhqAw4f5e0vue
         E9WCrDDOhtEF2FdGPLVY0dcAqP27+xykPHgV5Oi5okdhJdLTcvBkPX6uI2epqvj+/mbl
         O9Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVZEYgNqdkN28f/8CVffk8X9FzE05wgqp0/muq/0bRNI1XTveGbFO/UPoR/44Sg0ZmChrzmdM8=@lists.linux.dev
X-Gm-Message-State: AOJu0YzyNdsrvgm2liB85PlJ+eC8i64fhU5EAQw/xGFnVw+7tHz4ohbz
	iM/XwCuoYbY5Loi72cFHjBsFDIElQo3LwSLJrOEs2LkDqiXDZ2h5MILy
X-Gm-Gg: ATEYQzwpJSdU4Ex0TCFNHM+6OpuQ3lpL0w0IPFOR1IWlVL71KR8gd+Xddp+Z2J0pIkQ
	tBvaXDgfQ79vusKnoy2A7JAoLa8LvWf+EZsrB6FyKwyP91XpqYT9BC/3RN80BFE5Ept5MTMTW9v
	ZzUcSKBFmrzvgVQCHubBC5cvNuixSsVFKitFMcW2mLKtl/LpWhSkUpDgbttYoitLVwJ9hubcNHc
	2jdEthCLiAMhnUMlUu0KHm3LoU97+FbNWLdmTRTmgU+OteWWILieXuxgWcmAm2xKu0rNt2D23Ks
	eUUR/mWVOjPvMKruTlIjIz0nFITbJ7QOFt0ReKBiFAY4XOAPuML1KIpPbpwWDtyZAbUNAjcXfBY
	tuKIZk+Pc5332t1fayIQE0kBJxjDYYBXRzr9cQAuo89YI+W0JW6untBsH+AMT0T+FR1CcvYDQi+
	Wq2Gy7dhG0IIqyeTLmw0kyLtzfcBk=
X-Received: by 2002:a17:902:f68c:b0:2ad:ae4f:3468 with SMTP id d9443c01a7336-2ade9a4fd5cmr39424435ad.38.1772106213588;
        Thu, 26 Feb 2026 03:43:33 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5dbac7sm34131545ad.37.2026.02.26.03.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 03:43:33 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [RFC PATCH net-next 3/3] failover: use .ndo_update_offloads for failover
Date: Thu, 26 Feb 2026 11:42:08 +0000
Message-ID: <20260226114208.27774-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260226114208.27774-1-liuhangbin@gmail.com>
References: <20260226114208.27774-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert net_failover to use the new ndo_update_offloads callback
instead of manually calling netdev_compute_master_upper_features()
during slave registration/unregistration.

This simplifies the failover code significantly by removing the custom
feature computation logic and relying on the centralized feature update
mechanism. The callback is automatically invoked during feature updates
when upper/lower device links change.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/net_failover.c | 64 ++++----------------------------------
 include/net/net_failover.h |  7 -----
 2 files changed, 6 insertions(+), 65 deletions(-)

diff --git a/drivers/net/net_failover.c b/drivers/net/net_failover.c
index d0361aaf25ef..527175f554a6 100644
--- a/drivers/net/net_failover.c
+++ b/drivers/net/net_failover.c
@@ -300,6 +300,11 @@ static int net_failover_vlan_rx_kill_vid(struct net_device *dev, __be16 proto,
 	return 0;
 }
 
+static void failover_update_offloads(struct net_device *dev)
+{
+	netdev_compute_master_upper_features(dev, true);
+}
+
 static const struct net_device_ops failover_dev_ops = {
 	.ndo_open		= net_failover_open,
 	.ndo_stop		= net_failover_close,
@@ -312,6 +317,7 @@ static const struct net_device_ops failover_dev_ops = {
 	.ndo_vlan_rx_kill_vid	= net_failover_vlan_rx_kill_vid,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_features_check	= passthru_features_check,
+	.ndo_update_offloads    = failover_update_offloads,
 };
 
 #define FAILOVER_NAME "net_failover"
@@ -373,61 +379,6 @@ static rx_handler_result_t net_failover_handle_frame(struct sk_buff **pskb)
 	return RX_HANDLER_ANOTHER;
 }
 
-static void net_failover_compute_features(struct net_device *dev)
-{
-	netdev_features_t vlan_features = FAILOVER_VLAN_FEATURES &
-					  NETIF_F_ALL_FOR_ALL;
-	netdev_features_t enc_features  = FAILOVER_ENC_FEATURES;
-	unsigned short max_hard_header_len = ETH_HLEN;
-	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE |
-					IFF_XMIT_DST_RELEASE_PERM;
-	struct net_failover_info *nfo_info = netdev_priv(dev);
-	struct net_device *primary_dev, *standby_dev;
-
-	primary_dev = rcu_dereference(nfo_info->primary_dev);
-	if (primary_dev) {
-		vlan_features =
-			netdev_increment_features(vlan_features,
-						  primary_dev->vlan_features,
-						  FAILOVER_VLAN_FEATURES);
-		enc_features =
-			netdev_increment_features(enc_features,
-						  primary_dev->hw_enc_features,
-						  FAILOVER_ENC_FEATURES);
-
-		dst_release_flag &= primary_dev->priv_flags;
-		if (primary_dev->hard_header_len > max_hard_header_len)
-			max_hard_header_len = primary_dev->hard_header_len;
-	}
-
-	standby_dev = rcu_dereference(nfo_info->standby_dev);
-	if (standby_dev) {
-		vlan_features =
-			netdev_increment_features(vlan_features,
-						  standby_dev->vlan_features,
-						  FAILOVER_VLAN_FEATURES);
-		enc_features =
-			netdev_increment_features(enc_features,
-						  standby_dev->hw_enc_features,
-						  FAILOVER_ENC_FEATURES);
-
-		dst_release_flag &= standby_dev->priv_flags;
-		if (standby_dev->hard_header_len > max_hard_header_len)
-			max_hard_header_len = standby_dev->hard_header_len;
-	}
-
-	dev->vlan_features = vlan_features;
-	dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL;
-	dev->hard_header_len = max_hard_header_len;
-
-	dev->priv_flags &= ~IFF_XMIT_DST_RELEASE;
-	if (dst_release_flag == (IFF_XMIT_DST_RELEASE |
-				 IFF_XMIT_DST_RELEASE_PERM))
-		dev->priv_flags |= IFF_XMIT_DST_RELEASE;
-
-	netdev_change_features(dev);
-}
-
 static void net_failover_lower_state_changed(struct net_device *slave_dev,
 					     struct net_device *primary_dev,
 					     struct net_device *standby_dev)
@@ -550,7 +501,6 @@ static int net_failover_slave_register(struct net_device *slave_dev,
 	}
 
 	net_failover_lower_state_changed(slave_dev, primary_dev, standby_dev);
-	net_failover_compute_features(failover_dev);
 
 	call_netdevice_notifiers(NETDEV_JOIN, slave_dev);
 
@@ -621,8 +571,6 @@ static int net_failover_slave_unregister(struct net_device *slave_dev,
 
 	dev_put(slave_dev);
 
-	net_failover_compute_features(failover_dev);
-
 	netdev_info(failover_dev, "failover %s slave:%s unregistered\n",
 		    slave_is_standby ? "standby" : "primary", slave_dev->name);
 
diff --git a/include/net/net_failover.h b/include/net/net_failover.h
index b12a1c469d1c..f0f038d113a0 100644
--- a/include/net/net_failover.h
+++ b/include/net/net_failover.h
@@ -30,11 +30,4 @@ struct net_failover_info {
 struct failover *net_failover_create(struct net_device *standby_dev);
 void net_failover_destroy(struct failover *failover);
 
-#define FAILOVER_VLAN_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
-				 NETIF_F_FRAGLIST | NETIF_F_ALL_TSO | \
-				 NETIF_F_HIGHDMA | NETIF_F_LRO)
-
-#define FAILOVER_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
-				 NETIF_F_RXCSUM | NETIF_F_ALL_TSO)
-
 #endif /* _NET_FAILOVER_H */
-- 
2.50.1

