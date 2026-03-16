Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5EC1F461D
	for <bridge@lists.linux.dev>; Mon, 16 Mar 2026 04:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773635264; cv=none; b=dWuoIZb595UHpsjsg++/96zCniAnNaBNOy1LhEMm+X07WuDc0xUQZYdz01HrnbIgcxvarEe23/tyCGIhJHXjWNSfNafnYC/cex0ricSIaQa6OmSRZBRhs9F6Nab/R2u91fXZZcZzClTq726g6YkPJADmweB1PxQsRuc/qWhVqmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773635264; c=relaxed/simple;
	bh=9i2xWCN02/6dWupq0qfGRAfhr3jgqrdA1Q8ElDVHmj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KMHBzwU7uMx7NRATNoxTsU/fFak5QqvNpdLD4O9+c+0O0UWZkWdqObajbDmby9H7ioPgftcG1RwHH18BdqzLOt9x9QRP38PY5fiE/GDXWU5HPDv5rnRvrifZsk6AvEmwaoDDpfaDmPzmBbt6KlfBsVWttGuwh8Q15dLWmMcM7BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+qreElO; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+qreElO"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8296d553142so1746225b3a.3
        for <bridge@lists.linux.dev>; Sun, 15 Mar 2026 21:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773635263; x=1774240063; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C7xj5ZZxKagQhRbiCtY39hgG05M7BNgG4UcL1mqFDwQ=;
        b=m+qreElOsVDjQstY6b2TXnJTUL1rEp/BBjA4G+dF4WEzwxfp1DSlalna92qamcn9aj
         fpTdgoLmmW01tZtQ/Ls2wH7MUo77TOEdDji1g//U0a1OtzuyTxHQYMwB+dcFqChWZrZ3
         6Nnvzg06BQKjjH4TlPSbcr6mGCmM1Dm6H7EBWdwdsxTMHd7dGdKWt7AWwDL9mO3tqJG1
         b1tW0QaKbtNs7kwMPiG1TDNRlus7QZspNDTdHacz06gQQYKS2VwUCfhEdZuH8SLYum8j
         eAIvzuaYKxwGNFUmj78Wdh1oKcUv+ohjoBRWNzC85riDKPsmFnea63QjNB0jGHdKQMW0
         skrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773635263; x=1774240063;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C7xj5ZZxKagQhRbiCtY39hgG05M7BNgG4UcL1mqFDwQ=;
        b=bHJgHaJ9qOwOmCuRN8yqKOwsyx68qwxLBBF3uoE3/jmEU7SruLnbiWB78BK51vWzy7
         gwB5pLWHoujdMJ/qv2/0+fCPdNfZ6FL/vwp5NKQh5/qi5j1ruSW6cMz+tyX25Ktg8Q00
         f1w9Hw43Csg7fxblHNaMIK88SjmhyOFW9AxbrnQz8vx+Hhp2CvemTOuAYfFXL8ipiB2t
         FUS9YnJ5yHjwyJSv2TAi5WObF7F9WNlmboBUa2PR6iRxGjBZnRerJnlKNhMfSQMk5Wts
         3Lj89q92LeqkHFl8rylWTl1SoScdB55yi1r1JxKEVGDhlBGKNxK22JMo7JO6XYEI3wl/
         P0gA==
X-Forwarded-Encrypted: i=1; AJvYcCXFHkXWRflov7TyaPtAbZwniRFqU2XrZv60DjGhU4+vd+87ScIfxn4Ny8KKGHj129kc6NAD5mY=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyf46iyeF8mE5XAmDT9ooIY8qCmuvkfkw+0uTRKvtaJm4HgJBH1
	K6bXN0DlDX9YuNM9YnGRuug2nvLtBrzKSmw3R6POWq2keAuBXPPCW0ta
X-Gm-Gg: ATEYQzxuPXihTZsY3SUl8XbyBH5GBCLmPf+lHwDnaUrqMR6sQhJMrYOZBBzwxJgIOSL
	aGqwhxEtWxQxSGG65JstxW+krjIhg75Fxt05/V6/od/Ok2Hi8boeRJOOVOTj1zZtrhFiOX+cRN9
	U4qDmFbBdm6s4sjVnSOELMZZ+BLPmLjPT6gwNAqqAjJN3g3AqiDbc373WqPrhRa5XE3c0xCc5+m
	QcCjSkTA5vDU+dXVfK3OtS1DMXEiCeHEzGFxTYp6jlhpVqHoWIzosbXP+m/yEx1u3UBjTbOJ0wD
	YOzXloUvBM8quU79j8xI00qV9UyHij0K87rdsCcu8/8Qi0vRjM4cFrdWoU9BgQPQIIYwx0q6hf4
	th8x0N0JH6W4kjaOQm+sMUREnQF6X6+BGU5cR+/CJwGew1GkDDp7QrC3IwaTaH7Xzw+Jk/ipx66
	sPCmo+8t3yy4bDRTqMCtKpqchWE3KlurP7ceIzI33fKMvgfN4aIj1VTHnqjg==
X-Received: by 2002:a05:6a00:4605:b0:829:8990:3f86 with SMTP id d2e1a72fcca58-82a198cf37fmr9979104b3a.35.1773635262976;
        Sun, 15 Mar 2026 21:27:42 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([240e:34c:5760:3860:bc29:deed:92d0:823c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0738422esm12180267b3a.55.2026.03.15.21.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 21:27:42 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Mon, 16 Mar 2026 12:26:12 +0800
Subject: [PATCH net-next v3 4/5] failover: use ndo_update_offloads for
 failover offload compute
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-offload_compute-v3-4-a5d4a07d86d3@gmail.com>
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

Convert net_failover to use the ndo_update_offloads callback and calls
netdev_compute_master_upper_features() to compute new offload flags
during slave registration/unregistration.

This simplifies the failover code significantly by removing the custom
feature computation logic and relying on the centralized feature update
mechanism. The callback is automatically invoked during feature updates
when upper/lower device links change.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/net_failover.c | 66 +++++-----------------------------------------
 include/net/net_failover.h |  7 -----
 2 files changed, 7 insertions(+), 66 deletions(-)

diff --git a/drivers/net/net_failover.c b/drivers/net/net_failover.c
index d0361aaf25ef..85c238b88b85 100644
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
+	.ndo_update_offloads	= failover_update_offloads,
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
 
@@ -736,7 +684,7 @@ struct failover *net_failover_create(struct net_device *standby_dev)
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

