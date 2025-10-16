Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A7B1DA55
	for <bridge@lists.linux.dev>; Thu, 16 Oct 2025 03:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760585930; cv=none; b=QQGSDLMUwikPloYMf3igMG0Sq7PFxZSpDEaWZyWo/Ehujpfm9uQAygUClosZa9T4QV9MBB8gLf/LzEgzdD9wtOW8kVkIsKOcvviBPEXGVBE8WV99PZAVFNPfIbwRVfLX9NuOA27sTXW0ipRnNxvRubqmepT2iIbihCsJhGaYaD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760585930; c=relaxed/simple;
	bh=jtxM883aMPKlN/KGb2ljhQBXsIkM0dA3IyBTXpxd4Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+TKMx0QY9f7PczUYesf63c9dIVPcOXryhy/VU5qD9gFVoU6PTr0SVRqJXLC68Ueicw2GnSffjFI58XCEipyTKbulOTJ5w9wN7XV+B9353NBjmtEua3sJ7ksAauhmiQAK1SPV6XNJEwXi/MYS19GUfIe0bufC5TZWw6zwavmsbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQZOqPqM; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQZOqPqM"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b6329b6e3b0so1150728a12.1
        for <bridge@lists.linux.dev>; Wed, 15 Oct 2025 20:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760585927; x=1761190727; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1U3shMQWdIXc1mtcSMjgFuKSzDMPyNXZfAEh5poLBz4=;
        b=VQZOqPqMxTeeZ7wvG8+60+GIcNaliqeswfBxq4r+rR+nMpH+Ob9/LSC8oLmikaZD0f
         IrefKbSNxp5gwD+4pjvcQFvF1nSNvkKa0q5dkCYwQPPs0c+ruvN3EqN/CsQZ2TtVsAbW
         ZqCxX0cksfIjcENUlH1WOWYs1EWKW8r4aCxipHEs8JvaU8B3tXdBP7KGL+NsCt3VObzs
         gylOUcYEJfXcO2n+OChUDEqhPzBTxj6MDoLvOEC6DSz8SUiC0YXY+VNkHarluU0xUzjO
         2WUD1V8m+1F2VvfjBEeXAPICCDk9MhPFHC9hM0oQEmt9xIdeiCHx0U3wEeT/AYwOpoZf
         oPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760585927; x=1761190727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1U3shMQWdIXc1mtcSMjgFuKSzDMPyNXZfAEh5poLBz4=;
        b=XvgwL7a263biPB+uvJT1XthI3ZmmabscY3nc1VEa25ouzwc9DflFLAyd1lC43WX4Oi
         wSEzK9iaJ0nlSOmCi+semi9cIhXMGplO7QE+PNvOfP1G8/gFgJONXfrtfH1KVghMi7Ms
         cSQ+EuW6pxyA11PCdDjZIu4fTFuCIzEpcLtChRA5HZpVZmP0Mqqqw7HwjLnTE/dSdOof
         zePDwdmaVs7ZtMGlxydhkH/HSzAz6xBjSJSdj+PBelHEsb5F8kwscwSVKGva0Xj9eqRO
         A/wwhNygUS5zKaDkTtaEhSoGr8P3Nv17+xpsU+sZ1dT0gLrObmyMApDizkVgA+MjxNuk
         9V3w==
X-Forwarded-Encrypted: i=1; AJvYcCUTh3L1V9gU2wplNIloUzzERUyjr6Z+SfvksNKLOY96sMNPDGUeh0Hvj+8BdseJS1INmmMbwhI=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/6ohSWcabittYVbadAgoeQVraA8v/mEEcTpiWLrA47z0JomTD
	JRIlcWkO28KGEV0nF+2e7cbV+j1parcbpSWxpHmNWUirRXKDdyNVEHHc
X-Gm-Gg: ASbGncuAKoKgisDL0+P2VvapPrfhmxh/DlFAuSHLAiqhEw0w0JWv0/uxK7COD32fTlr
	O6BXht86+QAKMr2ek1EdQq3xNJNFQmH7KtS610jZ/Wx6iAJztCsbh3tVQ79bkPexDKfsmjO9QiG
	imMb+oY81MfM2kpEk+qLjA6kflqH/xPqbKd6eOE+NaQahiLFlxrmmrQ7/AwtsK+O+42K1hL2Dg2
	3t3ymgmaqBL52W8H7iDfA4LzhxcyWNuZRKBKybbN1b5MocuKbfzFknzeAH+Ju40vpo+gKAlT9Sa
	N/x35LrnLy2JGkJHXXLSgkWhVRWCsi0Tp/vMcX8SLbBX8VuQuxYE1fBFUWyGbH8Pw/MWN3iCdjG
	OidspyUqaznUk9UB3nWkm0Gh+nPGbAWlY5ktDfyPJGI+SOx1X3J2fu/8fqN9Ft0MpHDy/mXlRlD
	x/yhDH9Hsvq01tULI=
X-Google-Smtp-Source: AGHT+IEQnSNMmFHmCUEdL+aRIKm9fNrjLAzbqx2Ldo6MIRmL9eucbRosmVQisM3sE1KVA/Y8CVNmdA==
X-Received: by 2002:a17:903:2c0f:b0:278:f46b:d49c with SMTP id d9443c01a7336-290919db9c6mr28052985ad.9.1760585927423;
        Wed, 15 Oct 2025 20:38:47 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099343065sm12507925ad.26.2025.10.15.20.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 20:38:46 -0700 (PDT)
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
Subject: [PATCHv5 net-next 1/4] net: add a common function to compute features for upper devices
Date: Thu, 16 Oct 2025 03:38:25 +0000
Message-ID: <20251016033828.59324-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016033828.59324-1-liuhangbin@gmail.com>
References: <20251016033828.59324-1-liuhangbin@gmail.com>
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
index 7a01c518e573..ffb5f2ccfea2 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -255,6 +255,24 @@ static inline int find_next_netdev_feature(u64 feature, unsigned long start)
 				 NETIF_F_GSO_UDP_TUNNEL |		\
 				 NETIF_F_GSO_UDP_TUNNEL_CSUM)
 
+/* virtual device features */
+#define UPPER_DEV_VLAN_FEATURES (NETIF_F_HW_CSUM | NETIF_F_SG | \
+				 NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE | \
+				 NETIF_F_GSO_ENCAP_ALL | \
+				 NETIF_F_HIGHDMA | NETIF_F_LRO)
+
+#define UPPER_DEV_ENC_FEATURES  (NETIF_F_HW_CSUM | NETIF_F_SG | \
+				 NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE | \
+				 NETIF_F_GSO_PARTIAL)
+
+#define UPPER_DEV_MPLS_FEATURES (NETIF_F_HW_CSUM | NETIF_F_SG | \
+				 NETIF_F_GSO_SOFTWARE)
+
+#define UPPER_DEV_XFRM_FEATURES (NETIF_F_HW_ESP | NETIF_F_HW_ESP_TX_CSUM | \
+				 NETIF_F_GSO_ESP)
+
+#define UPPER_DEV_GSO_PARTIAL_FEATURES (NETIF_F_GSO_ESP)
+
 static inline netdev_features_t netdev_base_features(netdev_features_t features)
 {
 	features &= ~NETIF_F_ONE_FOR_ALL;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d1a687444b27..e25c02eb537d 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5304,6 +5304,7 @@ static inline netdev_features_t netdev_add_tso_features(netdev_features_t featur
 int __netdev_update_features(struct net_device *dev);
 void netdev_update_features(struct net_device *dev);
 void netdev_change_features(struct net_device *dev);
+void netdev_compute_upper_features(struct net_device *dev, bool update_header);
 
 void netif_stacked_transfer_operstate(const struct net_device *rootdev,
 					struct net_device *dev);
diff --git a/net/core/dev.c b/net/core/dev.c
index 33e6101dbc45..fab7ccedc5a3 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12641,6 +12641,94 @@ netdev_features_t netdev_increment_features(netdev_features_t all,
 }
 EXPORT_SYMBOL(netdev_increment_features);
 
+/**
+ *	netdev_compute_upper_features - compute feature from lowers
+ *	@dev: the upper device
+ *	@update_header: whether to update upper device's header_len/headroom/tailroom
+ *
+ *	Recompute the upper device's feature based on all lower devices.
+ */
+void netdev_compute_upper_features(struct net_device *dev, bool update_header)
+{
+	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
+	netdev_features_t gso_partial_features = UPPER_DEV_GSO_PARTIAL_FEATURES;
+	netdev_features_t xfrm_features = UPPER_DEV_XFRM_FEATURES;
+	netdev_features_t mpls_features = UPPER_DEV_MPLS_FEATURES;
+	netdev_features_t vlan_features = UPPER_DEV_VLAN_FEATURES;
+	netdev_features_t enc_features = UPPER_DEV_ENC_FEATURES;
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
+								 UPPER_DEV_GSO_PARTIAL_FEATURES);
+
+		vlan_features = netdev_increment_features(vlan_features,
+							  lower_dev->vlan_features,
+							  UPPER_DEV_VLAN_FEATURES);
+
+		enc_features = netdev_increment_features(enc_features,
+							 lower_dev->hw_enc_features,
+							 UPPER_DEV_ENC_FEATURES);
+
+		if (IS_ENABLED(CONFIG_XFRM_OFFLOAD))
+			xfrm_features = netdev_increment_features(xfrm_features,
+								  lower_dev->hw_enc_features,
+								  UPPER_DEV_XFRM_FEATURES);
+
+		mpls_features = netdev_increment_features(mpls_features,
+							  lower_dev->mpls_features,
+							  UPPER_DEV_MPLS_FEATURES);
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
+EXPORT_SYMBOL(netdev_compute_upper_features);
+
 static struct hlist_head * __net_init netdev_create_hash(void)
 {
 	int i;
-- 
2.50.1

