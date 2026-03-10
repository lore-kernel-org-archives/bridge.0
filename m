Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EB53630AE
	for <bridge@lists.linux.dev>; Tue, 10 Mar 2026 07:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773128822; cv=none; b=kNp+OhqH75X/ixkBds5LNAiOGzol2yE+Yw8DOvdH2R5yeqL/bhYKcZJqGTDf1ta3Urf1XZEQNCFkll8fwKXQc1tJUN1yQOa36GUyQWUSzzZXKlC4AKlZYrOV7/10PBRsyhFALeXM977xhV57QWkRsCmuOEsjoYF3Y4/a8ZbIwMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773128822; c=relaxed/simple;
	bh=ckIN5ASkuNOY9pUfpsVNZbSyJ16scvuiSr26ig8bsBM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lLiAmcaIXZmV/d31y/7FstpLwgt21WwV5V32u1OaSJjIp5UdaIaHyHcSEJb/89EhJ9noU8XIVGLHVqn9lvrhw6nlrfgnhT/LITct6g2Vhca8epLO+0p6OgUI8yDjV7QgxuY337YDzogl9c43sBv7ZhcJgTXIokPhDjJFBNaMM8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGbEklDN; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGbEklDN"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35983877dc5so4109011a91.2
        for <bridge@lists.linux.dev>; Tue, 10 Mar 2026 00:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773128820; x=1773733620; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=djyy+9DJ7NGUH5/yQnciZZwbkw5XEWCb6BieiKG0OKc=;
        b=VGbEklDN0CfWDhNozpTb1bmPXnWxNtAebEsh25CISy+t70hRDogr9BipsOd8xKCJUq
         aP0zNMMbf5kWnMezLZs1LDG1kjyptNYXuzxVpO7Cr3iZfZc5pJ+beHrnZaCkCB9G1xKS
         94edobtzbJ8Zqyk/q82wTccZFGAPw20eN9GR2cCqcCViWK9AyyOEZ3Q9RATWx+bliQI+
         BJc9oAMLpfG3wkt38+t9uB5yxgMA8Hn1ipvqJkZUdXwS9IoBzYaUXUPgm1M9q6zc2DJJ
         ulEujoxvKdlJvG87FkheQv8FshwgV9633UIq3gvR3HzCxSLMoGYGwlYHJd0z1elMrBAg
         Wr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773128820; x=1773733620;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=djyy+9DJ7NGUH5/yQnciZZwbkw5XEWCb6BieiKG0OKc=;
        b=HxmR9+LcUNmjVkmd7DVpt7USw7KpP8VdiJa7W6BQtD5KiMywjwB7kLylO0idUmEPcv
         nDTo7TMBgK/MfghXutJhcUzwqGEPj34IoweQvj91MVx7q6KOhm26AHgbe4VZo5Mffzrl
         hFopf/nnQhKbjuea2v8Q9UnA2557MVBE0XrxdyGQ2DUb+ueqIP6KFWflEMA/naC/eMhb
         DG+dOpin1xsS1QlE83953VDxPhnczxSV2mRPoIebt9CXark2Q2QHcP2egrX0So2g5O4i
         exmGT7hdWn0NvIKOzgV3Y6FBw01ZFpwaay3tHtI/01Ibf5sZ5C1yjikM+uvF188hmvkE
         6n4A==
X-Forwarded-Encrypted: i=1; AJvYcCVxvUZ/qGC/YClTN0GMTVFgZL4pb/vd7gD4pZgF8mLhXwI4b+W7+Km9mPddnZeNjEcTuQaBwmg=@lists.linux.dev
X-Gm-Message-State: AOJu0YxO/UmABI7kbNt0O9cL2/LVfyCwK7bsxmURooqphg4W7xrF5Zu1
	mHoJDFc3VRsBYMkMUNyWZsA0SLxXCbuaOKpEiRlR7sZcCil0UtiKKjPz1bax6kp/
X-Gm-Gg: ATEYQzySCNxCZpr/BQYT1Eww+O2iDBmRXYDX1AFOG0ZksLObxwAve9xLP/obWUaUU8a
	uf9u7ee9h/MAACJe0rPAMfct2rZINCPpBLMYxRWB77qLvYGn6B+zkH1kPcOtFA0wRLcAjVRfEPO
	KZi9AAqm4+fLYytFYuChbst8DtWrQ34Z1Gm/+j9yk7YsSM6BKW/x1qgJCsgP3lrPh+TfcIUwxaH
	ObIX/wbBbUUq69NuK2GaCO6TPED60oTsj3KICUj9zWqJh2zsR53qpX2+AFpbfvkHxCYoFN9BM9u
	27g7Pu+cpBQfJdBnn/Qw5keuwZvE6DFdrptcp7lzKXCGvPxzNDrbOvT1LzaBlmPMo6aZAyRUNWm
	8oZMYiiIi4O0zGcZm0wAWjBR95VxOEJINlNXPUK2r6W2zYKA3h47tMq+B2D13/k/up5jVxzEGfC
	bG7wSeDrmVemBsmVYSM/BpDqlr8HxRkfqwgop1J7WluZKJAMnkxl37lkVEWcvxTHKDXDNF4Yjfo
	e9wVAS9Ymr0aQW/ovBoXi77a/AoM6o4K9fas3wUWLo=
X-Received: by 2002:a17:90b:3a4b:b0:359:7fe6:7e5 with SMTP id 98e67ed59e1d1-359be30aee2mr10825721a91.24.1773128819911;
        Tue, 10 Mar 2026 00:46:59 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359bc7ef38csm7260607a91.2.2026.03.10.00.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 00:46:59 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Tue, 10 Mar 2026 15:45:06 +0800
Subject: [PATCH net-next 2/3] failover: use ndo_set_features for failover
 offload compute
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-offload_compute-v1-2-3df79c09ea65@gmail.com>
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

