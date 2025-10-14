Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E73B30F551
	for <bridge@lists.linux.dev>; Tue, 14 Oct 2025 08:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760428960; cv=none; b=eOTvvOHRBYNMZabYheRDawvCU3pMx/xZ5iWKtHyCQXTv5zyJdPElWu8NyBkhNJmhCpg3wJFuJPMoBC+u4L3Z46vay51+p870QkbTzsupVomtR+Wyc6I3sRs0hJsS/8ksnis7hP45sV6HcBzd4eEDHupB5bDbj74v9r124+6+m20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760428960; c=relaxed/simple;
	bh=8dTxGOgQN7TatfYGs89HXqTVV1dfXFxVLm/rqIOGmqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4JKI3cT4joKN4V1ypl1+swEPelyONCuQ4W5Cxrn5EeLk38V+kGgxoQ2QVAlcpr5r4+5vUTXIOPccJma8XPITlbliKY9vHpqOqv2Nh2q9CvVUakVChb75+fo9jFRzHsWD5YtITZzi3bu0Vpyq2wXgfG9IyFeFZ8tnt+63hfFTME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Go4SvAWl; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Go4SvAWl"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-782e93932ffso4527216b3a.3
        for <bridge@lists.linux.dev>; Tue, 14 Oct 2025 01:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760428958; x=1761033758; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWnH+cC42+c5SizK69CiWCx74af0EbDcIh1zp6haGLQ=;
        b=Go4SvAWl/2SOhAgF06Q2IoRW/QXHVvNr+nJiGckvx5m5FNmLCZcLMbyzjONO+UbtLl
         M1B9ZYcks6ZlsajoAP/8lzEEpnmlSUPqlfwWqHRgVzgOAbhXmdNiEZ19jc5PDelQirfz
         wmp0f5fcivkIYlxODi+OdwO7NfQlrYLmRajDeWcTVKmRI6o18QYy63oBpP0iql79hczj
         9pi8GoTYNaEgkCCgJLb0/DKl2PPrEbYQmt8kG/PVWLy4B7ve4PXOyeRoJCrIvk9nYO40
         E+8x3d8LTwTUizahVOQv2/L5z/veCtdKRCu7IR8uYL5obm4sWCLggG0Y0/lvGW7pAiIA
         bz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760428958; x=1761033758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWnH+cC42+c5SizK69CiWCx74af0EbDcIh1zp6haGLQ=;
        b=J87VaN2KjcWVl0jnPVMTpDN3sVYF568LJXq8LAj1v9IW4+oop0ykuYGOr0gDqf+oPO
         wR2J5bpFXqzq9P25STD7VDgmmbJUpZ4IAWGhw/2IXxwc245cEyLV8F8i+CcmW2k78N9P
         lEC+mRSR5mYXwwX7Cl9PAUhgMEsSsBMDq3qPT9MQpmJmttWipSoF374B3pibVOZ9AmwG
         gQdLyEBGmifUqdFwbiaQAajmGqJ/G10iTm8pGgJO17NZYydQAmRAkELmHl5Wv8ag2vfK
         tDhuLihV6UEmQ7F13OuPuS63wfI+Ny+oysUo+bBSAHczkKOFs0+2Vvu3q5aFxJCsez1r
         EIug==
X-Forwarded-Encrypted: i=1; AJvYcCXpoQqBZFiYhXGx+44brK44SD7aGR21S+Iq2UfstjnUpClXHXsMrNIpKEFmDloB6onWBqMcGx4=@lists.linux.dev
X-Gm-Message-State: AOJu0YxEYTmRDWxis1Ror5KRM8b6Kxc7FpuiYKJqcwT2uBQ/UAgJXOvU
	pSwhiBKYGP/yDWpb5xjy1cEkKPS23okCqb8CDg1oO6yFbPDFw50xgFSn
X-Gm-Gg: ASbGncs9esfLhHUvDDhaLeggoEGj4XaLvBpi2TZPl9Wdzy7+GwHNQsHeNwX6/wFiyeT
	tVuMXwWMtzMk/HHuAGh5EP1UsostdP4QvevAzPP2QiN5D6ollWzZbEseLjUmCCyHMBmHX1DOFoS
	T64odk8SAPAKTxRV9x1XZsmZ0u6G2imv4ufVfpXc8qvKhk9Io1XbUnX5fcDGA6koy15kGvUgSL9
	JpEQhTkDHfjTIujD9QSvzW5Npw1TSUDfhxaPMptQ27m5r+NOJq3K45hUG+GMsXc4xRAsB6vBji8
	AJZA/0Z9ZKEWMsbyq9mF132LSYdVc+VSJWzawADmHwv508qLpvI3VP8A9P34F0DxvXbbmlBX9AZ
	G3P1PFsLfGkoMp+mYzHhmLCzr/3HbE4+AJpayvQ1aYfllHA==
X-Google-Smtp-Source: AGHT+IHtgBHpjqHOfJPQMdE11TvFAmCGMEgpTH8sJ4AtgUwzT3dUkv9OUYCk/OS7ICE9VnkZDoBWig==
X-Received: by 2002:a17:90b:1c0e:b0:335:2823:3686 with SMTP id 98e67ed59e1d1-33b510ff59bmr29055412a91.2.1760428957619;
        Tue, 14 Oct 2025 01:02:37 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626407c4sm14648210a91.6.2025.10.14.01.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 01:02:37 -0700 (PDT)
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
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv4 net-next 1/4] net: add a common function to compute features from lowers devices
Date: Tue, 14 Oct 2025 08:02:14 +0000
Message-ID: <20251014080217.47988-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251014080217.47988-1-liuhangbin@gmail.com>
References: <20251014080217.47988-1-liuhangbin@gmail.com>
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
 include/linux/netdev_features.h | 18 +++++++
 include/linux/netdevice.h       |  1 +
 net/core/dev.c                  | 95 +++++++++++++++++++++++++++++++++
 3 files changed, 114 insertions(+)

diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index 7a01c518e573..f3fe2d59ea96 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -255,6 +255,24 @@ static inline int find_next_netdev_feature(u64 feature, unsigned long start)
 				 NETIF_F_GSO_UDP_TUNNEL |		\
 				 NETIF_F_GSO_UDP_TUNNEL_CSUM)
 
+/* virtual device features */
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
+
 static inline netdev_features_t netdev_base_features(netdev_features_t features)
 {
 	features &= ~NETIF_F_ONE_FOR_ALL;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d1a687444b27..8e28fee247f5 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5304,6 +5304,7 @@ static inline netdev_features_t netdev_add_tso_features(netdev_features_t featur
 int __netdev_update_features(struct net_device *dev);
 void netdev_update_features(struct net_device *dev);
 void netdev_change_features(struct net_device *dev);
+void netdev_compute_features_from_lowers(struct net_device *dev, bool update_header);
 
 void netif_stacked_transfer_operstate(const struct net_device *rootdev,
 					struct net_device *dev);
diff --git a/net/core/dev.c b/net/core/dev.c
index a64cef2c537e..54f0e792fbd2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12616,6 +12616,101 @@ netdev_features_t netdev_increment_features(netdev_features_t all,
 }
 EXPORT_SYMBOL(netdev_increment_features);
 
+/**
+ *	netdev_compute_features_from_lowers - compute feature from lowers
+ *	@dev: the upper device
+ *	@update_header: whether to update upper device's header_len/headroom/tailroom
+ *
+ *	Recompute the upper device's feature based on all lower devices.
+ */
+void netdev_compute_features_from_lowers(struct net_device *dev, bool update_header)
+{
+	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
+	netdev_features_t gso_partial_features = VIRTUAL_DEV_GSO_PARTIAL_FEATURES;
+#ifdef CONFIG_XFRM_OFFLOAD
+	netdev_features_t xfrm_features = VIRTUAL_DEV_XFRM_FEATURES;
+#endif
+	netdev_features_t mpls_features = VIRTUAL_DEV_MPLS_FEATURES;
+	netdev_features_t vlan_features = VIRTUAL_DEV_VLAN_FEATURES;
+	netdev_features_t enc_features = VIRTUAL_DEV_ENC_FEATURES;
+	unsigned short max_header_len = ETH_HLEN;
+	unsigned int tso_max_size = TSO_MAX_SIZE;
+	u16 tso_max_segs = TSO_MAX_SEGS;
+	struct net_device *lower_dev;
+	unsigned short max_headroom;
+	unsigned short max_tailroom;
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
+		enc_features = netdev_increment_features(enc_features,
+							 lower_dev->hw_enc_features,
+							 VIRTUAL_DEV_ENC_FEATURES);
+
+#ifdef CONFIG_XFRM_OFFLOAD
+		xfrm_features = netdev_increment_features(xfrm_features,
+							  lower_dev->hw_enc_features,
+							  VIRTUAL_DEV_XFRM_FEATURES);
+#endif
+
+		mpls_features = netdev_increment_features(mpls_features,
+							  lower_dev->mpls_features,
+							  VIRTUAL_DEV_MPLS_FEATURES);
+
+		dst_release_flag &= lower_dev->priv_flags;
+
+		if (update_header) {
+			max_header_len = max_t(unsigned short, max_header_len,
+					lower_dev->hard_header_len);
+			max_headroom = max_t(unsigned short, max_headroom,
+					lower_dev->needed_headroom);
+			max_tailroom = max_t(unsigned short, max_tailroom,
+					lower_dev->needed_tailroom);
+		}
+
+		tso_max_size = min(tso_max_size, lower_dev->tso_max_size);
+		tso_max_segs = min(tso_max_segs, lower_dev->tso_max_segs);
+	}
+
+	dev->gso_partial_features = gso_partial_features;
+	dev->vlan_features = vlan_features;
+	dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL |
+				    NETIF_F_HW_VLAN_CTAG_TX |
+				    NETIF_F_HW_VLAN_STAG_TX;
+#ifdef CONFIG_XFRM_OFFLOAD
+	dev->hw_enc_features |= xfrm_features;
+#endif
+	dev->mpls_features = mpls_features;
+
+	dev->priv_flags &= ~IFF_XMIT_DST_RELEASE;
+	if ((dev->priv_flags & IFF_XMIT_DST_RELEASE_PERM) &&
+	    dst_release_flag == (IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM))
+		dev->priv_flags |= IFF_XMIT_DST_RELEASE;
+
+	if (update_header) {
+		dev->hard_header_len = max_header_len;
+		dev->needed_headroom = max_headroom;
+		dev->needed_tailroom = max_tailroom;
+	}
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

