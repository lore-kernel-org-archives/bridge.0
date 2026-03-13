Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D44E308F03
	for <bridge@lists.linux.dev>; Fri, 13 Mar 2026 03:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773371068; cv=none; b=ZCqPoE9HJjuJvNZu9CVCHmBvYNYyMqHTFp8dzTKTheFtFdnFBwdEsIQ1rPbTNEsCqPi8cgRhhZQtpIt8j2NvNg+qPDG+JInb3VLKnh6T0+uxmdbshuITzSHfDCBn1t97N7AvT0Be9qndjp0cdA65unCJOc9Jvxbjj5QLHCPC58U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773371068; c=relaxed/simple;
	bh=ckIN5ASkuNOY9pUfpsVNZbSyJ16scvuiSr26ig8bsBM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yo7++hTjHFkhqvgJmJcrxHxaCfH7KgFU1pDaEtTl5VEib6aPV2tCLadvPHTTo7dKfpTPM+5r37yZGhqpRtOGjJ1YuZyEF15vvmYq+GPW6kE0wyTxHMTg0cPgW1mnDu/WzQt46O/ce0N3CDomfq+1zgrM7Dhe7D5935ZbV/4IwII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbzFdlWg; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbzFdlWg"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-359fea895b5so993742a91.0
        for <bridge@lists.linux.dev>; Thu, 12 Mar 2026 20:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773371065; x=1773975865; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=djyy+9DJ7NGUH5/yQnciZZwbkw5XEWCb6BieiKG0OKc=;
        b=RbzFdlWgU/hvOF9bNOLuv2KO/7rkeNkuXH63GIZY3nBGQYHK7K8S+VoOZQ+mQbMoyf
         1+JcMM2XVJKmYVjSG4++lkmH/+RpCfDPDNK82jIbcAxNlQpq0pqLIHVfLQNgVJ0QHj/7
         brchV9IL1jx3W2If+kQ+RM2X4N7c3oEi1I5/+B4X+t515vGg7OvzEzMmJxYwCu2TgPZR
         ds8nKs2Y/MY+JSI2C30Zc1+JRVgoPAg4Nb5dht81AlPcCBwxegkEEpr0FPXkr0D4bzkj
         AM9X+4BzNWHSjneF6BoZ9nZFKSU5Xxai0xM1GkSUlXJE4wHXKB0xO7sVm+9NG9+7wkyQ
         v+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773371065; x=1773975865;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=djyy+9DJ7NGUH5/yQnciZZwbkw5XEWCb6BieiKG0OKc=;
        b=KECphqbx2ybg29HXnYS2+3sF7aivKFgP/UARjGYwlbRY5W3fOn8w3wno6SOXUDCIwz
         4vTA4Ew+7boqJP0V5+CUJG3nfeE+zXezpwzQxk51qzyj+0tcJWQREWQngmDi3Ber/Sdj
         zvIKEn3RQ9C+MjXYBIfPzagGcaF8YwgRrh+QTrlWWnsv4kBCQFJow2ad/Rzsxrbb3/Lv
         F2WuuUEXE0KPLldro/d5Ea5n1fWhcjt1NrTmgYGHm4w90vIYSbxhAx/IsLfaINWzTA8p
         wRr6o92Zr6hd4qSqRBqlCCDBwgoQdJPBXh/2L0BcykcuiHjbMamnYKjns5Nhi36TX1ez
         HymQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKbXFx2YlppsRVEDsTd9tMQ488X/uRLIn4LTQnjMDnQl8GNehKpMD5Jk6XHQSoHPVi9jj1tf8=@lists.linux.dev
X-Gm-Message-State: AOJu0YzNsyLBqt6oNC+S4AgcuwrZWEybpzF+n2UJC17r+wP7FNy2xlLo
	at+S7bgobceS6XH38h+7K88JFfXCym7Z8xkyWXCy9yhrB7R2kmbh5xLK
X-Gm-Gg: ATEYQzzEUjBBs56kZj5v7II1HLIa4sm+xX9E3If5K87FfPmBMjEhauDxc8XAQXa1t8Z
	C9wibWP7BPK7QadhaOa1nfmtAz9BVjZRm3YGTSzYQWnzZ8DpuVRDrEtItGXimRHq6N8OsmKhPMM
	u4JEvV/SK+wum5t+PJcNNnj2MqGIrVML3pR+sqFloDuvifeBvoW4aVGa1ISw0G+tGwpyM2Zx49W
	rPiUnxJN4CIfnWzSUrbx3yhzc+cxEjqVeAvrUeGOF28JlA9ZcZl5au97p/I5HkszZvJ6ppVYBhU
	uyzUb6178f7zVn4Tvxq6uHsug783iH0mlWN3b3xkLSBkwzPCZCOhifEah8qND37WyOPfjd3y0Qp
	GmSr51icvQp8XyCWlhn10x67cjBYI3jzVtQIeAxXgXpYZ6HbOB1Gg1kwinSt6a7hoheyPnE587N
	kwxAP1Vy0UtIwIIOe8LkDI1z8T99n71hvp3cZvQnh83Uh3nQH6hGOILhd+m/Mi14etyY+Ca/5tp
	hjzXUyIcMwrOV/viN8m24fKr9KeGvWc8y0qN83Sx9sjQ2pUgO4P
X-Received: by 2002:a17:90b:4cc4:b0:359:9885:3bb7 with SMTP id 98e67ed59e1d1-35a220aab7bmr1375535a91.32.1773371065498;
        Thu, 12 Mar 2026 20:04:25 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([240e:34c:5765:adb0:54b3:92b9:a11b:1cae])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a24a7dc1csm293967a91.1.2026.03.12.20.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 20:04:24 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Fri, 13 Mar 2026 11:03:11 +0800
Subject: [PATCH net-next v2 3/4] failover: use ndo_set_features for
 failover offload compute
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-offload_compute-v2-3-ffbc8ce5d50c@gmail.com>
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

Convert net_failover to use the ndo_set_features callback and calls
netdev_compute_master_upper_features() to compute new offload flags
during slave registration/unregistration.

This simplifies the failover code significantly by removing the custom
feature computation logic and relying on the centralized feature update
mechanism. The callback is automatically invoked during feature updates
when upper/lower device links change.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/net_failover.c | 67 ++++++----------------------------------------
 include/net/net_failover.h |  7 -----
 2 files changed, 8 insertions(+), 66 deletions(-)

diff --git a/drivers/net/net_failover.c b/drivers/net/net_failover.c
index d0361aaf25ef..10041a271bf5 100644
--- a/drivers/net/net_failover.c
+++ b/drivers/net/net_failover.c
@@ -300,6 +300,12 @@ static int net_failover_vlan_rx_kill_vid(struct net_device *dev, __be16 proto,
 	return 0;
 }
 
+static int net_failover_set_features(struct net_device *dev, netdev_features_t features)
+{
+	netdev_compute_master_upper_features(dev, true);
+	return 0;
+}
+
 static const struct net_device_ops failover_dev_ops = {
 	.ndo_open		= net_failover_open,
 	.ndo_stop		= net_failover_close,
@@ -312,6 +318,7 @@ static const struct net_device_ops failover_dev_ops = {
 	.ndo_vlan_rx_kill_vid	= net_failover_vlan_rx_kill_vid,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_features_check	= passthru_features_check,
+	.ndo_set_features	= net_failover_set_features,
 };
 
 #define FAILOVER_NAME "net_failover"
@@ -373,61 +380,6 @@ static rx_handler_result_t net_failover_handle_frame(struct sk_buff **pskb)
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
@@ -550,7 +502,6 @@ static int net_failover_slave_register(struct net_device *slave_dev,
 	}
 
 	net_failover_lower_state_changed(slave_dev, primary_dev, standby_dev);
-	net_failover_compute_features(failover_dev);
 
 	call_netdevice_notifiers(NETDEV_JOIN, slave_dev);
 
@@ -621,8 +572,6 @@ static int net_failover_slave_unregister(struct net_device *slave_dev,
 
 	dev_put(slave_dev);
 
-	net_failover_compute_features(failover_dev);
-
 	netdev_info(failover_dev, "failover %s slave:%s unregistered\n",
 		    slave_is_standby ? "standby" : "primary", slave_dev->name);
 
@@ -736,7 +685,7 @@ struct failover *net_failover_create(struct net_device *standby_dev)
 	/* Don't allow failover devices to change network namespaces. */
 	failover_dev->netns_immutable = true;
 
-	failover_dev->hw_features = FAILOVER_VLAN_FEATURES |
+	failover_dev->hw_features = MASTER_UPPER_DEV_VLAN_FEATURES |
 				    NETIF_F_HW_VLAN_CTAG_TX |
 				    NETIF_F_HW_VLAN_CTAG_RX |
 				    NETIF_F_HW_VLAN_CTAG_FILTER;
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
Git-155)

