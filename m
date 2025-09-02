Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EF7278154
	for <bridge@lists.linux.dev>; Tue,  2 Sep 2025 07:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756797994; cv=none; b=k+mLbXBgghFXqohYfbzcrx1vNnkK8+aGw9kC0Zh/UKJg7P7Eh+ZukLzQoNBhHrKYa/iNoNDFV9iXbZ3CCdkS0o1QjLT58jvUtfwbOM8En0QcbR5nSyNqyq3d1ZflR97BahUL6/pyo6SSPvxScRONupY8q1y1ujkfHe/VzhfaOfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756797994; c=relaxed/simple;
	bh=f3PQMblOMBCI/1kmTA/vjXSxqmbwI+7PArh10fBY6Is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQnTk3UxI2XoqZqpSHLQwDBoW8C2Uc96jinuyVxmI++zxP5R1t+z+wi93DhmrM5IUzR+9qiYfoZoeP76fiZ1xQXVf4OC7aFBm5/bz8werEa1a40Ui5CJ0E1KoGIpgra8VLwEMbDeB8ZzdjWR9sTC5Yd8IsKvpuSVblWLsVNQpsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8PT3YeO; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8PT3YeO"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-327f8726b95so3251161a91.0
        for <bridge@lists.linux.dev>; Tue, 02 Sep 2025 00:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756797992; x=1757402792; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CroiyAwqZlGYn3SnRc22yfKpEhM9ceyols54ibX4Vh0=;
        b=Y8PT3YeOAQCpwjgLQLvFxIAqTcGDWGIAQ70576QlZuvJSKbVcQLGoaJoc13ztT3Z/3
         WuHUbKn3wLy/ubl5NevL4kroOM8pFqYXqQZ7gYpz6MitBBHK9ZsTBq0O6QYUzXW5IULP
         xrA6yVsGEycWloy2mNHcAndFj6jiB5iRAVPWmoS368mK1YCXOPrLHfgcYNUNFq7c31C+
         g3GNVboCEEPdwiOuMuoU42arS4eJVcqjflwRQRoYCHaW0NKpa9QldY6i/u5OZN59fe9a
         oPHYHmMT9cT4TMZEa7taZPurK59OaZnuZadd5QcC27GCtNhdb3ynI/Nj+2OyT1n+KWJ7
         CS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756797992; x=1757402792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CroiyAwqZlGYn3SnRc22yfKpEhM9ceyols54ibX4Vh0=;
        b=QOEpoauysZY6uYIchdUu52ZsT5OZP07VjkM0Y3rdWy/kMEzCS33HFy7yMywcXGO0uU
         TEEVOIW40n7zK5r5nwNBRfXwnnlXvvMCTJd3drA5kExKkKDC1LTNVbr+bA2I47cTAqmf
         muInsbj0mvybNysdjHVe9opSInouGnyzcVscBHqsgvTJfFCoRlWytxOEzhjFG0Kc3A92
         DTZqMsYr2oWQBfrnOz+vpjBDq+wCPEwlkDZXa6kJc3BxhoulETaFimLSYSGK/IWw8HuX
         NIakbYaAg/cXYikGktIB4hj4mYHZK9kobBm9tT23E71mih2JGmDoA7PPqAS89j1J3552
         eKCA==
X-Forwarded-Encrypted: i=1; AJvYcCUrH3/Z7DQt5JB+6cCil53f/IyzxbSenRgM7z06kCgPzqAQtdAZ1EQWf8usK79T+NMg1+Ejd80=@lists.linux.dev
X-Gm-Message-State: AOJu0YzYv6+n8t3sYkkkP+FlO45IY1FTUfp6XY0pSP+cPO9A5L1M1tez
	Rb6ADl+U45zltI1dr2wJ4lWuD2wPN1PeMDqWQONSJDi8VmYaXSrDsmr9
X-Gm-Gg: ASbGncupe+qGBgz6mJDIKCmexuQLuMnAVwuMzRy4L5m+arcFQTP7OonWWwTFxEz/QrO
	6GwsbOnGzWYDD7DochQnvwev0FLSGHnDStsW2U4mbsWBph4vskgESS/kjv+wmHQHgNVOWK4Fq/I
	Vxj5JQef67tbOwMsdHpCSgztM9ljLSgEMn3kwkqxp9mbDfK2r6mp8lQkmceQsxoJcMomNHfhysE
	tF/7aZT5lVl8SnJZs7He9OMY6FNwQw+LOMYtcK5RxepTebJwG7I1ZLbgSuCXk7toQT+wXaCOvoG
	M+ZjdgfAEqlxJBvDhNCHO1E/d0HhY7mdfP36CltsYSB+2RlEsmt1UaOblajBcKZbhCIeqfUamzn
	ul0nIIQrqV3ltIr2nRftkfWaQ6CV706Iau2q22kX4OQ==
X-Google-Smtp-Source: AGHT+IFrLsup/zlKl9VPJLG+MwLiZxV8wgI92Vfbd7yMnlWhB00wvnSNTUodtgetR+EuOfYKqbwlrA==
X-Received: by 2002:a17:90b:3d4d:b0:327:be20:cd8a with SMTP id 98e67ed59e1d1-3280d381b25mr15013382a91.17.1756797991765;
        Tue, 02 Sep 2025 00:26:31 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327d9347189sm13416648a91.9.2025.09.02.00.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 00:26:31 -0700 (PDT)
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
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 1/5] net: add a common function to compute features from lowers devices
Date: Tue,  2 Sep 2025 07:25:58 +0000
Message-ID: <20250902072602.361122-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250902072602.361122-1-liuhangbin@gmail.com>
References: <20250902072602.361122-1-liuhangbin@gmail.com>
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
 net/core/dev.c            | 76 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)

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
index 1d1650d9ecff..5c1c8b016c8e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12577,6 +12577,82 @@ netdev_features_t netdev_increment_features(netdev_features_t all,
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
+
+		tso_max_size = min(tso_max_size, lower_dev->tso_max_size);
+		tso_max_segs = min(tso_max_segs, lower_dev->tso_max_segs);
+	}
+
+	dev->gso_partial_features = gso_partial_features;
+	dev->vlan_features = vlan_features;
+#ifdef CONFIG_XFRM_OFFLOAD
+	dev->hw_enc_features |= xfrm_features;
+#endif
+	dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL |
+				    NETIF_F_HW_VLAN_CTAG_TX |
+				    NETIF_F_HW_VLAN_STAG_TX;
+	dev->mpls_features = mpls_features;
+
+	dev->priv_flags &= ~IFF_XMIT_DST_RELEASE;
+	if ((dev->priv_flags & IFF_XMIT_DST_RELEASE_PERM) &&
+	    dst_release_flag == (IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM))
+		dev->priv_flags |= IFF_XMIT_DST_RELEASE;
+
+	netif_set_tso_max_segs(dev, tso_max_segs);
+	netif_set_tso_max_size(dev, tso_max_size);
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

