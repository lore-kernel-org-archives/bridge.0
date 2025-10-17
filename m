Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8752EAB68
	for <bridge@lists.linux.dev>; Fri, 17 Oct 2025 03:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760672536; cv=none; b=YJrVrWzKz+7uWF0xN/xZomQMdtk2HRFEy8VFRm54sGv1lpxQAc8QmLUSDRYSXugDjJ6Lno4HLy4xnPMqxG3OJiZgL3NzUGhbgdu4boZ7XY2falqZkqNyCKYVgSWGBq4WFh/o5PI07Ys1OdZaJkcBWdpD3AWdICrkaoFemK9ygn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760672536; c=relaxed/simple;
	bh=Yu7Ry0nHYzkFpOviPQ73wvr+2M7lP6QTxPFeJoZcWGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jzcekiZOvBxDhZWeD7LOyTRIhOZekzJHPaGYf57q1RpjULszM00QBEawH5O6+WtQlobNxu4pfTwlZ1P14nqGsaAI3S+zgL0HMoeb117ArouGcyAz28pW7MO2nxoT6lJNvYKhxE7q9Z2JlQUiOjiRjhli/aSCxVGsUN5gJ9a6cVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lF4DpvXJ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lF4DpvXJ"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b62ed9c3e79so979777a12.0
        for <bridge@lists.linux.dev>; Thu, 16 Oct 2025 20:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760672534; x=1761277334; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YR2Qwuf4oEi0NJdlFXFCJhjQKRsh3wLw7gZtNuj+GkU=;
        b=lF4DpvXJbyGuR72zFoyfP2iVCroD291O9P0/danfeASTHRJ4Mof2g1IUPBTIhCKz1m
         MZzFv0XJhL1BzN+Pg6fEzevEPu0U18LfB7tvGwmIPfMma2M5KfdJzxopWJGmX898vpk3
         c5y7mkOyhuKstl473JcZU49wnSkYsaWI0zVSdgAHmBcDyChM1DUbtsKraLp8olb2ctJG
         O8Q5PLRhH2QdH3lIn1jqXZB6qKccrjKGiAd/gLgp8xAOlxQe3U9ZJLxn8Ys+lMi3hesR
         P4sO+2DsEQ46TwoFUDlcILypteGSjf8nIWY3Htlyts8ISP58Y4UfbGOkQzscTmMVIkUS
         bNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760672534; x=1761277334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YR2Qwuf4oEi0NJdlFXFCJhjQKRsh3wLw7gZtNuj+GkU=;
        b=XqMSkNWbHnesgqz8PQMfRcALElag2zjaOr/KJGn6itMZLD3bPiUTa3tV+LwKUcp2bM
         yibrrvVpfwlJgq8FsmdkasP8+FPyBqsBC855xenG37aFR2hst9c5dlHs6TnAps7MYho/
         E3NJBP7lAheNU05pGUgIUuppsREtfHVsE5IoVT8mWY7+OAl5wwhxji3mlzn1h6A+9bpn
         eXDrexvT7EAwz+FB9NuJZrYWGGQiq9WQr3aFb1ndI2rmwq8kyXvBDfjqVCmDGgs0mkri
         CkVUUftyfu/lEfXbAXzqWLLR1VpPqqUj1wnaJp4+o+fyvr5W3Cs80Awv7ojCDrn/XZWZ
         6faw==
X-Forwarded-Encrypted: i=1; AJvYcCVgRLWfi8D5a8gl7zQrgiC1CaFqDMLCKpDU4voMUeLmnXI4HJQqrGc3+hTGH88gBnIYx0DTqyI=@lists.linux.dev
X-Gm-Message-State: AOJu0YzFs9j4Rv4eKPX8qPuNJ3yTNnINGjI0nyuKc/0+mgM9SO561eFj
	vIEHavDz58HW7o7i72U3etDCRsOuk5voV+1s7pI7wLX7e/VJczn0zVMN
X-Gm-Gg: ASbGncuFBgea2AurRxOKtslvszH39IA7VjojV/hKrP6u5FTNUPJtWdvVeqslhe0BPO2
	Rs7Jogye6Qu51QMmtnqNY1cakmIgBAKPFmDJbUFQDsdGYsDKjJ3Upt//E35zOUYzH0uuzN9rEWx
	+2amYqOcw3LyOwjInKp4HaF/s42oulf64KiqVKY+agYTPZTH2JKyiAyEesdZF+gVE7tLqp+ccf6
	XZvAu7WUtfzAaq6H6pkWEpOG/nX14MPIH2KkvALdzDW6+Jt9nL7GCwg18IpGJn9t3qbXrTgGc2n
	efdRzA/P6eF2yge/KgaRU2rvlCfRyvLMKcxAHrT6H36yyFFR/ZgIYak4QSkXMDY2hShiQGeODxW
	Uo9Q8bO2Mpz1OpZlIWsRB7mrnMv9hmnibAr1TjVXeg5sIKkNbVdiDppyauUy08ERbYrvVkObetV
	5+RZFa
X-Google-Smtp-Source: AGHT+IFM96S/jI0CT9nb4RQ/t3eV705T8Y4/fxX+JPnp7pYo83b3A1owVVu0bMujEg+L2uhb6eirug==
X-Received: by 2002:a17:903:2411:b0:290:ad79:c616 with SMTP id d9443c01a7336-290ccaccc25mr25597505ad.57.1760672533651;
        Thu, 16 Oct 2025 20:42:13 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099ab4715sm46695165ad.93.2025.10.16.20.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 20:42:13 -0700 (PDT)
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
Subject: [PATCHv6 net-next 1/4] net: add a common function to compute features for upper devices
Date: Fri, 17 Oct 2025 03:41:52 +0000
Message-ID: <20251017034155.61990-2-liuhangbin@gmail.com>
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

Some high level software drivers need to compute features from lower
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
 net/core/dev.c                  | 88 +++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+)

diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index 7a01c518e573..93e4da7046a1 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -255,6 +255,24 @@ static inline int find_next_netdev_feature(u64 feature, unsigned long start)
 				 NETIF_F_GSO_UDP_TUNNEL |		\
 				 NETIF_F_GSO_UDP_TUNNEL_CSUM)
 
+/* virtual device features */
+#define MASTER_UPPER_DEV_VLAN_FEATURES	 (NETIF_F_HW_CSUM | NETIF_F_SG | \
+					  NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE | \
+					  NETIF_F_GSO_ENCAP_ALL | \
+					  NETIF_F_HIGHDMA | NETIF_F_LRO)
+
+#define MASTER_UPPER_DEV_ENC_FEATURES	 (NETIF_F_HW_CSUM | NETIF_F_SG | \
+					  NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE | \
+					  NETIF_F_GSO_PARTIAL)
+
+#define MASTER_UPPER_DEV_MPLS_FEATURES	 (NETIF_F_HW_CSUM | NETIF_F_SG | \
+					  NETIF_F_GSO_SOFTWARE)
+
+#define MASTER_UPPER_DEV_XFRM_FEATURES	 (NETIF_F_HW_ESP | NETIF_F_HW_ESP_TX_CSUM | \
+					  NETIF_F_GSO_ESP)
+
+#define MASTER_UPPER_DEV_GSO_PARTIAL_FEATURES (NETIF_F_GSO_ESP)
+
 static inline netdev_features_t netdev_base_features(netdev_features_t features)
 {
 	features &= ~NETIF_F_ONE_FOR_ALL;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d1a687444b27..7f5aad5cc9a1 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5304,6 +5304,7 @@ static inline netdev_features_t netdev_add_tso_features(netdev_features_t featur
 int __netdev_update_features(struct net_device *dev);
 void netdev_update_features(struct net_device *dev);
 void netdev_change_features(struct net_device *dev);
+void netdev_compute_master_upper_features(struct net_device *dev, bool update_header);
 
 void netif_stacked_transfer_operstate(const struct net_device *rootdev,
 					struct net_device *dev);
diff --git a/net/core/dev.c b/net/core/dev.c
index 33e6101dbc45..50d8ebd13a56 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12641,6 +12641,94 @@ netdev_features_t netdev_increment_features(netdev_features_t all,
 }
 EXPORT_SYMBOL(netdev_increment_features);
 
+/**
+ *	netdev_compute_master_upper_features - compute feature from lowers
+ *	@dev: the upper device
+ *	@update_header: whether to update upper device's header_len/headroom/tailroom
+ *
+ *	Recompute the upper device's feature based on all lower devices.
+ */
+void netdev_compute_master_upper_features(struct net_device *dev, bool update_header)
+{
+	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
+	netdev_features_t gso_partial_features = MASTER_UPPER_DEV_GSO_PARTIAL_FEATURES;
+	netdev_features_t xfrm_features = MASTER_UPPER_DEV_XFRM_FEATURES;
+	netdev_features_t mpls_features = MASTER_UPPER_DEV_MPLS_FEATURES;
+	netdev_features_t vlan_features = MASTER_UPPER_DEV_VLAN_FEATURES;
+	netdev_features_t enc_features = MASTER_UPPER_DEV_ENC_FEATURES;
+	unsigned short max_header_len = ETH_HLEN;
+	unsigned int tso_max_size = TSO_MAX_SIZE;
+	unsigned short max_headroom = 0;
+	unsigned short max_tailroom = 0;
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
+								 MASTER_UPPER_DEV_GSO_PARTIAL_FEATURES);
+
+		vlan_features = netdev_increment_features(vlan_features,
+							  lower_dev->vlan_features,
+							  MASTER_UPPER_DEV_VLAN_FEATURES);
+
+		enc_features = netdev_increment_features(enc_features,
+							 lower_dev->hw_enc_features,
+							 MASTER_UPPER_DEV_ENC_FEATURES);
+
+		if (IS_ENABLED(CONFIG_XFRM_OFFLOAD))
+			xfrm_features = netdev_increment_features(xfrm_features,
+								  lower_dev->hw_enc_features,
+								  MASTER_UPPER_DEV_XFRM_FEATURES);
+
+		mpls_features = netdev_increment_features(mpls_features,
+							  lower_dev->mpls_features,
+							  MASTER_UPPER_DEV_MPLS_FEATURES);
+
+		dst_release_flag &= lower_dev->priv_flags;
+
+		if (update_header) {
+			max_header_len = max(max_header_len, lower_dev->hard_header_len);
+			max_headroom = max(max_headroom, lower_dev->needed_headroom);
+			max_tailroom = max(max_tailroom, lower_dev->needed_tailroom);
+		}
+
+		tso_max_size = min(tso_max_size, lower_dev->tso_max_size);
+		tso_max_segs = min(tso_max_segs, lower_dev->tso_max_segs);
+	}
+
+	dev->gso_partial_features = gso_partial_features;
+	dev->vlan_features = vlan_features;
+	dev->hw_enc_features = enc_features | NETIF_F_GSO_ENCAP_ALL |
+			       NETIF_F_HW_VLAN_CTAG_TX |
+			       NETIF_F_HW_VLAN_STAG_TX;
+	if (IS_ENABLED(CONFIG_XFRM_OFFLOAD))
+		dev->hw_enc_features |= xfrm_features;
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
+EXPORT_SYMBOL(netdev_compute_master_upper_features);
+
 static struct hlist_head * __net_init netdev_create_hash(void)
 {
 	int i;
-- 
2.50.1

