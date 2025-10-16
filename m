Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98C444C63
	for <bridge@lists.linux.dev>; Thu, 16 Oct 2025 03:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760585936; cv=none; b=T8bh1L8G2TIwMWk3z7IrdC6Z7XoZ+lBR7ofgyZvgtIzZ6Nct5L72sSIhXGpW9GbFQyk4c4jq469liLi49e2gCYZx+Kxt0er59vWZPNETmLGcHhdPRXjPBj1ebSFnAIS3QlJaQDf1I5rpB9U+Uc7Isjek0ACih6f+5w4SfMv2W3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760585936; c=relaxed/simple;
	bh=1uT9H9PRviPd7d49sO9P1Wa7Db4Tffph07bVM93pm9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q/lBx18DTjxxpALlKC2DJ6i2iDxpZ0lDLbV8W4V07722RiqU89YB/+pdcSs9ZH+qlxF3ZXN/AK1xbikN2HURlewdJJtBbdfWA4W5r4x1d7DagIWtve5ZS+9zLlVW8zIz+GVDVBSf5Z4bQPS1d7m2JIfp8t3oMhHYWRPrm8dUb1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1NHVd+B; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1NHVd+B"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-27eed7bdfeeso3110825ad.0
        for <bridge@lists.linux.dev>; Wed, 15 Oct 2025 20:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760585934; x=1761190734; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=viMZc2742kNQ9bglDQAz5YS/WuHEZi44CGoB+QOOfCo=;
        b=D1NHVd+BEMvOljEshL3YgdtuRitp9Wb14UQUt8PNe+mybeCra8Gr3u2SiFdl/PlMy3
         pcq0WWuspBsyiSnp+suEsMWPR36imHVN6nf4UJUuBD0JFReLIi/svodeKUYw1GXWqydZ
         gSdPlV+u4/CijKmXmDf9onAAalCiDCMI0I2n8SgV4IiLmUvhMZ4Uqvph8lMOLFibcYkF
         f2NfBXHNlNmFlDM4cgr/ti75QsJ0rR+fH8D0geyJW+5OZ2IJBR2OLnROFxBhmbcOLWn1
         Q6lrWyJAcCoz8SH2YuEBeEVZZifmrVvqokcR8NGtTcVFC1KJ7lTlhTzY0t7//N7jlQG9
         /LnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760585934; x=1761190734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=viMZc2742kNQ9bglDQAz5YS/WuHEZi44CGoB+QOOfCo=;
        b=riSaEF1k1+gYVT0W8ycXYAUad77pmC6uyNW1EkVc1qtiJm5urL/fKG2GjmJyz4L35J
         IVX1LI7+kmPWb4ZlbuQVam5VgAYwkRSjQRPLyccPbp2reOmGgkgUhZPTJ9bW80/WHXRH
         3gxoc97R9WDnBI4vkhH7zWg7dW5jHgm8159xJ4UkAaWLKjIpANJH9mSyqxMigVg97mMk
         aXYCosvVvg6In9vTk2VeR8uSF0lvoCwsqUXVH7+nXbTbFfw1gVCL1x4zSfunREhG9xKh
         IzfTnl2j47ZA5yyHafVjGeDcpRKQrcaZ5hlBQtXfBi2q35yEwoTlKeV/CHspgXu8NKvU
         CAKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjosHwjWN2M1n4dqfGewMxBrnBG8j4LboSxHvyUbCBa781vbB2ZmDofo4N5BRLJ8yuI7B89/A=@lists.linux.dev
X-Gm-Message-State: AOJu0YyaZSfFzckWhEKskT+7vMRuEU6S/Eq/dHsxQy7mk49hw4eitFhj
	paAuDajqNuxkDjhJ7SGygCP993NtxwwCCJsYChFWvemycnyCV6jbh1eW
X-Gm-Gg: ASbGnctMahZUYxs4/4eLZej0e3eLAa28bozP8oiWsN23lJbzuYMeYCEVJ55pBsb0htP
	6ZduM1hL8b+WdaZA9OYYgE3F+AYHIn0CbOe2/4C3amVkRWP3rbtq3/i6lxD2CBUxdV1giFmHjxN
	uD2n4OC3IhG2oqky+ggENLB1BIszPUelazz2hfExxpL7q20+sqKkE+l/VX9pjO/QwYXNUsQKCvF
	8Kbd5KmmHkpTaHo2QZ5ilk0sEzw9M1rVh2kn2mj7qSjHuwmSqJazaz0pK2xpeshDkblENNpo6AK
	57/e3K7QmbumUeKWPqpgNJZVUnreH+tX40Zam8JFxXusREhWLei9boK3XnFve1wZV04XIHU/+Lf
	x/jzCecjkh1jsuwbN9pNTZIuByZQWsDsgVV4xbQONO1/QXvqVyl9WZlnw/3EFG4em8ElE79yqbq
	5ZgGYC
X-Google-Smtp-Source: AGHT+IFfdemxesjaSTcJ/pshhhk5XUdr+CVk+BaZw99JeFEIy8oI8x122ugf9usgCdxO9sN5G89krA==
X-Received: by 2002:a17:903:8cd:b0:269:7840:de24 with SMTP id d9443c01a7336-29091b8e212mr22653755ad.21.1760585933968;
        Wed, 15 Oct 2025 20:38:53 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099343065sm12507925ad.26.2025.10.15.20.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 20:38:53 -0700 (PDT)
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
Subject: [PATCHv5 net-next 2/4] bonding: use common function to compute the features
Date: Thu, 16 Oct 2025 03:38:26 +0000
Message-ID: <20251016033828.59324-3-liuhangbin@gmail.com>
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

Use the new functon netdev_compute_upper_features() to compute the bonding
features.

Note that bond_compute_features() currently uses bond_for_each_slave()
to traverse the lower devices list, and that is just a macro wrapper of
netdev_for_each_lower_private(). We use similar helper
netdev_for_each_lower_dev() in netdev_compute_upper_features() to
iterate the slave device, as there is not need to get the private data.

No functional change intended.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 99 ++-------------------------------
 1 file changed, 4 insertions(+), 95 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 4da619210c1f..9bf36dec44d1 100644
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
+	netdev_compute_upper_features(bond->dev, true);
 	bond_set_carrier(bond);
 
 	/* Needs to be called before bond_select_active_slave(), which will
@@ -2525,7 +2434,7 @@ static int __bond_release_one(struct net_device *bond_dev,
 		call_netdevice_notifiers(NETDEV_RELEASE, bond->dev);
 	}
 
-	bond_compute_features(bond);
+	netdev_compute_upper_features(bond->dev, true);
 	if (!(bond_dev->features & NETIF_F_VLAN_CHALLENGED) &&
 	    (old_features & NETIF_F_VLAN_CHALLENGED))
 		slave_info(bond_dev, slave_dev, "last VLAN challenged slave left bond - VLAN blocking is removed\n");
@@ -4028,7 +3937,7 @@ static int bond_slave_netdev_event(unsigned long event,
 	case NETDEV_FEAT_CHANGE:
 		if (!bond->notifier_ctx) {
 			bond->notifier_ctx = true;
-			bond_compute_features(bond);
+			netdev_compute_upper_features(bond->dev, true);
 			bond->notifier_ctx = false;
 		}
 		break;
@@ -6011,7 +5920,7 @@ void bond_setup(struct net_device *bond_dev)
 	 * capable
 	 */
 
-	bond_dev->hw_features = BOND_VLAN_FEATURES |
+	bond_dev->hw_features = UPPER_DEV_VLAN_FEATURES |
 				NETIF_F_HW_VLAN_CTAG_RX |
 				NETIF_F_HW_VLAN_CTAG_FILTER |
 				NETIF_F_HW_VLAN_STAG_RX |
-- 
2.50.1

