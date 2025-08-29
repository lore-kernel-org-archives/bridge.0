Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CEB304BB5
	for <bridge@lists.linux.dev>; Fri, 29 Aug 2025 09:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756461292; cv=none; b=rEj0H8v1zYfZ3iyf8dAByc08p8c/lIgzs8DiFIjNCUIIhfSo7X9E5enklJzDnF16wGc0sUIiD2pn9HhQmrqFF1yWVSGrnGTLfR8milt00n7soAZxdJfvbe8V+aPFuL25U+yER8E+nwdJYdXBP8QYr1quBd3x8APMdoskEPjd+NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756461292; c=relaxed/simple;
	bh=ZhlPFja7SlYAPblQqVOmGRc6MDhCNGVIIY7jHIji+MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qc2EI/Txk7meyZDbHO4rWcNHn/gjQNgSZCNHTIqSirqGBWgGRWSSM2jbUQYrOfQ96/X4mojDbHfeVuI1GADMHeljVKlaIAMwwUf1DK2L13+JBxdDYfXz285wnVG95G4ubZ6B/+2fBAdR8TgVoTOrCB8W5gVB6UKypvY6+KKKMGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlmdFde/; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlmdFde/"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-771ed4a8124so1996330b3a.2
        for <bridge@lists.linux.dev>; Fri, 29 Aug 2025 02:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756461290; x=1757066090; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHcc1/G3/bt6bkHV6jdHu2UO9CVcNgvv4eN1WO9eHCI=;
        b=MlmdFde/mGlS5LivuHu7Zh3jsxRt3TgQDX8yiJjMtjhH3rYgAKW5LT44mR0mw1bZdY
         TL4JPKS46K1mQPARhXOtBf64bXRE+ynz3oxSBBC/yMVB0AIxX4WLuV05QmsqJgNKBJKu
         7nH3tcRRROFeno5JekzuMmJ6UoSCDFEDORkQScPfTVKnkhM05QL0I1iGG7Hunpb5kKSa
         nFR2VX/zCBIpJM6hDzRLlL9JgPqb8c3jpK0W221TmXHPQ1EbaURnZBssDyv1ZTKFEy38
         pPPDfMusyRX3z5Tn58DGY1ixuvjwOWiK5udyH2b0wmngGluCdpcdu4Vm662avMdSTNr6
         vJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756461290; x=1757066090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHcc1/G3/bt6bkHV6jdHu2UO9CVcNgvv4eN1WO9eHCI=;
        b=YqRKQZn80DqveY4uL+n9Wa3MqbAJSDJ7bAOsIgA5ELUo0Op8mDbU18NnSWWRg0D3u4
         kOO/3xvcbbM6w8WWxo49P7UGsiOOgR8EzioSutYlKmado7WjE24q6ngsjdHsFl+JDuk3
         iCTbBIu1AMJNJGUoc2CeRBq07VvOcJuy+oWVxTN1DgRr5PNZ6dZSilH6a+NjeQIyZ0wK
         OUw7HXCezhc0I4k3xnNHE2e1viDAD4/hHH4sPaoY3cqslEU8mNiuKVCGgUfZld42yOd3
         vdUAO7qCHBrQoyd2OcuFepnf0jLZSEa0+FdHiCOK8nWd8x1Rmp/sw3Rxg072L7r0s0kd
         NwoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoKAal2yu+DknICSCwlychJnFqFHzQehN6pPseIHLerd25xN796h5AUR2+ZjujDner6n40hcI=@lists.linux.dev
X-Gm-Message-State: AOJu0YymGXsaZkNKVHuCq6tuvFMeoBaCwebhCW3V8rLDKuV3smNXouyk
	f8aVOQk4KJbl6mDpAvLm+oaAgbBju7fPNDXQU2BzE4Q+qpZmjPLBKv6l
X-Gm-Gg: ASbGnctck94sd3I49aZfn9ytXsL+M5x1WagYS9hNhVlCqu0H1D7HMDT4fNlJV4DG83w
	XpboGhqEiu6sSj/HDjhJ4yvrvkOsMT5WyyAswj2CFmmLSCf1e9wKDNp2FCKeGI3uaotjxH/b99W
	FKRoToY/c7qHM+hfqxTwee3WHHH15Rx422B9iM+bPxVCgtzaKn0Ln3cEnHlx4DL/mLlJKo9/+9k
	PbYtNc6s6U7NMbsJZ1SSM6Ieruv6i7fyyUYZPkqB95y5ubPxXK1mQBJQumm8637pW0tRuxAEyjN
	zTaQtFU0hGo1E4qqokmm/Ex7am0/LqrK6cGNGcExcbN/j5Ptfv8uhQKJ1XtCkNJfR4q3+QNqCmY
	tiqK0xiPvL38fh3sVE5zsIs1/YfqEl4JZUqOMpl05Z5WkARXSYnla
X-Google-Smtp-Source: AGHT+IGb5b20g+ds5+t2jSRo3PBkjPZ0xiu5XnsklcgUgS2IcIeT7FoBwfI/+jjDNvRt4GiKPyM/UA==
X-Received: by 2002:a05:6a20:4c20:b0:243:a20a:3ca5 with SMTP id adf61e73a8af0-243a20a3f30mr10342005637.13.1756461289820;
        Fri, 29 Aug 2025 02:54:49 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd347db1fsm1751528a12.47.2025.08.29.02.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 02:54:49 -0700 (PDT)
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
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 1/5] net: add a common function to compute features from lowers devices
Date: Fri, 29 Aug 2025 09:54:26 +0000
Message-ID: <20250829095430.443891-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250829095430.443891-1-liuhangbin@gmail.com>
References: <20250829095430.443891-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some high level virtual drivers need to compute features from lower
devices. But each has their own implementations and may lost some
feature compute. Let's use one common function to compute features
for kinds of these devices.

The new helper uses the current bond implementation as the reference
one, as the latter already handles all the relevant aspects: netdev
features, TSO limits and dst retention.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 include/linux/netdevice.h | 19 ++++++++++
 net/core/dev.c            | 79 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index f3a3b761abfb..42742a47f2c6 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5279,6 +5279,25 @@ int __netdev_update_features(struct net_device *dev);
 void netdev_update_features(struct net_device *dev);
 void netdev_change_features(struct net_device *dev);
 
+/* netdevice features */
+#define VIRTUAL_DEV_VLAN_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
+					 NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE | \
+					 NETIF_F_GSO_ENCAP_ALL | \
+					 NETIF_F_HIGHDMA | NETIF_F_LRO)
+
+#define VIRTUAL_DEV_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
+					 NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE | \
+					 NETIF_F_GSO_PARTIAL)
+
+#define VIRTUAL_DEV_MPLS_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
+					 NETIF_F_GSO_SOFTWARE)
+
+#define VIRTUAL_DEV_XFRM_FEATURES	(NETIF_F_HW_ESP | NETIF_F_HW_ESP_TX_CSUM | \
+					 NETIF_F_GSO_ESP)
+
+#define VIRTUAL_DEV_GSO_PARTIAL_FEATURES (NETIF_F_GSO_ESP)
+void netdev_compute_features_from_lowers(struct net_device *dev);
+
 void netif_stacked_transfer_operstate(const struct net_device *rootdev,
 					struct net_device *dev);
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 1d1650d9ecff..fcad2a9f6b65 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12577,6 +12577,85 @@ netdev_features_t netdev_increment_features(netdev_features_t all,
 }
 EXPORT_SYMBOL(netdev_increment_features);
 
+/**
+ *	netdev_compute_features_from_lowers - compute feature from lowers
+ *	@dev: the upper device
+ *
+ *	Recompute the upper device's feature based on all lower devices.
+ */
+void netdev_compute_features_from_lowers(struct net_device *dev)
+{
+	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
+	netdev_features_t gso_partial_features = VIRTUAL_DEV_GSO_PARTIAL_FEATURES;
+#ifdef CONFIG_XFRM_OFFLOAD
+	netdev_features_t xfrm_features  = VIRTUAL_DEV_XFRM_FEATURES;
+#endif
+	netdev_features_t mpls_features  = VIRTUAL_DEV_MPLS_FEATURES;
+	netdev_features_t vlan_features = VIRTUAL_DEV_VLAN_FEATURES;
+	netdev_features_t enc_features  = VIRTUAL_DEV_ENC_FEATURES;
+	unsigned short max_hard_header_len = ETH_HLEN;
+	unsigned int tso_max_size = TSO_MAX_SIZE;
+	u16 tso_max_segs = TSO_MAX_SEGS;
+	struct net_device *lower_dev;
+	struct list_head *iter;
+
+	mpls_features = netdev_base_features(mpls_features);
+	vlan_features = netdev_base_features(vlan_features);
+	enc_features = netdev_base_features(enc_features);
+
+	netdev_for_each_lower_dev(dev, lower_dev, iter) {
+		gso_partial_features = netdev_increment_features(gso_partial_features,
+								 lower_dev->gso_partial_features,
+								 VIRTUAL_DEV_GSO_PARTIAL_FEATURES);
+
+		vlan_features = netdev_increment_features(vlan_features,
+							  lower_dev->vlan_features,
+							  VIRTUAL_DEV_VLAN_FEATURES);
+
+#ifdef CONFIG_XFRM_OFFLOAD
+		xfrm_features = netdev_increment_features(xfrm_features,
+							  lower_dev->hw_enc_features,
+							  VIRTUAL_DEV_XFRM_FEATURES);
+#endif
+
+		enc_features = netdev_increment_features(enc_features,
+							 lower_dev->hw_enc_features,
+							 VIRTUAL_DEV_ENC_FEATURES);
+
+		mpls_features = netdev_increment_features(mpls_features,
+							  lower_dev->mpls_features,
+							  VIRTUAL_DEV_MPLS_FEATURES);
+
+		dst_release_flag &= lower_dev->priv_flags;
+		if (lower_dev->hard_header_len > max_hard_header_len)
+			max_hard_header_len = lower_dev->hard_header_len;
+
+		tso_max_size = min(tso_max_size, lower_dev->tso_max_size);
+		tso_max_segs = min(tso_max_segs, lower_dev->tso_max_segs);
+	}
+
+	dev->gso_partial_features = gso_partial_features;
+	dev->hard_header_len = max_hard_header_len;
+	dev->vlan_features = vlan_features;
+	dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL |
+				    NETIF_F_HW_VLAN_CTAG_TX |
+				    NETIF_F_HW_VLAN_STAG_TX;
+#ifdef CONFIG_XFRM_OFFLOAD
+	dev->hw_enc_features |= xfrm_features;
+#endif
+	dev->mpls_features = mpls_features;
+	netif_set_tso_max_segs(dev, tso_max_segs);
+	netif_set_tso_max_size(dev, tso_max_size);
+
+	dev->priv_flags &= ~IFF_XMIT_DST_RELEASE;
+	if ((dev->priv_flags & IFF_XMIT_DST_RELEASE_PERM) &&
+	    dst_release_flag == (IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM))
+		dev->priv_flags |= IFF_XMIT_DST_RELEASE;
+
+	netdev_change_features(dev);
+}
+EXPORT_SYMBOL(netdev_compute_features_from_lowers);
+
 static struct hlist_head * __net_init netdev_create_hash(void)
 {
 	int i;
-- 
2.50.1

