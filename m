Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DC91C3F0C
	for <bridge@lists.linux.dev>; Tue,  2 Sep 2025 07:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756798001; cv=none; b=fEHIzd3jwYepj9yG5D1WqElXvjFxf8TDwqi0e8DJZis4kCgYz441qZP7O9fgorjtIrA9mYppvaTG4MjjJzWApjB9+jONlcgAlkMHVfTBdYz9fr8aenHMbFCNcjcb08UHmzR2cXF6daWnc4FwIK5K5IGlDVTLwQ77TrFHId9OzLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756798001; c=relaxed/simple;
	bh=LvKMJecvv6fCl08ak6wcz+usML93SEKeGztEfvaXXos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P2ozm+GaUEXw3GlQrEY4YzZE0oH8rX2S3CUEq1BK1ueWKpjLHTs6/gFvIBaxgHJvY00NjTBLa155mHMNfA0H0+aA0FJnf0JwL41amOhVHLxaulrRX3mjG+0/aoiy/S4uDUPgY20uD/l0+m72d2lj19tdeCs6yk6LZ7s7LqkV7js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNn5jfXe; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNn5jfXe"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77250e45d36so1509464b3a.0
        for <bridge@lists.linux.dev>; Tue, 02 Sep 2025 00:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756797999; x=1757402799; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ROTQkSqqAop+hXmMAfGEDF4zfkGUQT7wlA8Dp+fSV8=;
        b=PNn5jfXeHnew3cttF++wMYfx3795cOw6tdAthv6itwHWb/jZnK2nLFfy1l0qNZyj3+
         BH956w6avt0cnrAGcP5DqYuLSTLQu+OkzWFqp110u8tOX+GoGsa/07uDX7pAUK26AbF7
         qjKyKfPjmLay6BjwZELKZycQ2/vmF9Bh0B/b4xePF3JhPXVI1s32P5WoPBkffTyGQlxp
         2RDFJAME+hSiwtcXcmeA3psrYk+cRpaHgOP3D/DU/K7Tll0ZDzti2jInY0lesfQY7bs5
         pa8ibsPdsuMUDQL9kO+M/j7rFDH+I4Je124uZz0sNAkOvjlUZpf8lxeaLX1BzY+EBuGU
         I41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756797999; x=1757402799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ROTQkSqqAop+hXmMAfGEDF4zfkGUQT7wlA8Dp+fSV8=;
        b=NYYkYGsJ3i/NjIyO2AaOaMK4mu2vWfXWfcdXOPyKsbIj2spIGuDAtMXYItxQCXfrq2
         I4y2a6Ojk/dvAMBJC9qLfsQ+OqILR2iNJwxN5QGG66YBOdrrkrhWcwP2aMASmJTM7uid
         gPJkg+ZvEng9iWPEjCZsdK3QO+TRtsj+0Ky4tBfpnGHBTLSeN3x0CbvWDshiI3NLn/1I
         cHNjP9Gnp4oq9y9NS91eXPWbEXvZFdGhKqQ6srqiyLQpxTfu/rQxDhwwIyb8mgDmMfkY
         DJZ+luxyftEuLMH98Wlvi1pptHWhkZ5XgC/AC1/z0uEZ8GHh+pwAdFJLQL3SWpsPQq2H
         35Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUzJIg6hO0M7Y7kBp6VpjPVMTxfloIPNP4Jrpz5kuKqFYgFjgaV21O6y6LgRiH8R7uRG+Y742o=@lists.linux.dev
X-Gm-Message-State: AOJu0YwTEAW3ASr1QTioPiI6in7g3HSj1cXGqKrBMpD0eZQzUcpJRzoN
	XAmrn1dPwj0n4viL/O7LOAqD1PfTazQ39f3LHvmug2w2KUTpnLYXPMEc
X-Gm-Gg: ASbGncvFfshtctVC5Wmeb35TTWVARqM1b3HcDx7EIHXuk+03c+7rq26VunmNvIM3U1A
	36iRIGpeJC6PDV4o+dq9wQGPpGYKKcXzgkXBi4FUBtNjqvJpB/mFIa65oE+hlBMkOULpIt81Io0
	qwv/6uDnnMGB3/luau0eWORD5jPiDRF07IPSdxfyow9f577Xmfa9bweeWgUBP8pWnh+eN1yv1zz
	8t2bbFsVL1rVrQJz+f/bowSzQCYQv1HrAIzZAK5RBYoDh8+Jb2wMlEuU51y1J0fkMtETD1I6lCk
	Lz3wLEQrFpYU29rRm/K1ViN0o3wRhU5/pHzaojinzeDxjQbXYKMRB5FqyHVnKsOcrJb6KBP1IEN
	EK8eVGOKWOQ+Sz2qClPUeCsxTlRjWlmoK5gwpoMI9cQ==
X-Google-Smtp-Source: AGHT+IFbsRKItnVYXBA/kLP0Fy939d8jTQ8sFMbOgaWYFiuxk/U/RaOtpPVINCeC5Eu/6XF0KKG1Bg==
X-Received: by 2002:a05:6a20:12c5:b0:233:7c59:5bdd with SMTP id adf61e73a8af0-243d6e06de9mr14130688637.13.1756797998605;
        Tue, 02 Sep 2025 00:26:38 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327d9347189sm13416648a91.9.2025.09.02.00.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 00:26:38 -0700 (PDT)
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
Subject: [PATCHv2 net-next 2/5] bonding: use common function to compute the features
Date: Tue,  2 Sep 2025 07:25:59 +0000
Message-ID: <20250902072602.361122-3-liuhangbin@gmail.com>
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

Use the new functon netdev_compute_features_from_lowers() to compute the
bonding features.

Note that bond_compute_features() currently uses bond_for_each_slave()
to traverse the lower devices list, and that is just a macro wrapper of
netdev_for_each_lower_private(). We use similar helper
netdev_for_each_lower_dev() in netdev_compute_features_from_lowers() to
iterate the slave device, as there is not need to get the private data.

No functional change intended.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 99 ++-------------------------------
 1 file changed, 4 insertions(+), 95 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 257333c88710..ec098a52ef75 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1540,97 +1540,6 @@ static netdev_features_t bond_fix_features(struct net_device *dev,
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
@@ -2370,7 +2279,7 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	}
 
 	bond->slave_cnt++;
-	bond_compute_features(bond);
+	netdev_compute_features_from_lowers(bond->dev);
 	bond_set_carrier(bond);
 
 	/* Needs to be called before bond_select_active_slave(), which will
@@ -2622,7 +2531,7 @@ static int __bond_release_one(struct net_device *bond_dev,
 		call_netdevice_notifiers(NETDEV_RELEASE, bond->dev);
 	}
 
-	bond_compute_features(bond);
+	netdev_compute_features_from_lowers(bond->dev);
 	if (!(bond_dev->features & NETIF_F_VLAN_CHALLENGED) &&
 	    (old_features & NETIF_F_VLAN_CHALLENGED))
 		slave_info(bond_dev, slave_dev, "last VLAN challenged slave left bond - VLAN blocking is removed\n");
@@ -4126,7 +4035,7 @@ static int bond_slave_netdev_event(unsigned long event,
 	case NETDEV_FEAT_CHANGE:
 		if (!bond->notifier_ctx) {
 			bond->notifier_ctx = true;
-			bond_compute_features(bond);
+			netdev_compute_features_from_lowers(bond->dev);
 			bond->notifier_ctx = false;
 		}
 		break;
@@ -6109,7 +6018,7 @@ void bond_setup(struct net_device *bond_dev)
 	 * capable
 	 */
 
-	bond_dev->hw_features = BOND_VLAN_FEATURES |
+	bond_dev->hw_features = VIRTUAL_DEV_VLAN_FEATURES |
 				NETIF_F_HW_VLAN_CTAG_RX |
 				NETIF_F_HW_VLAN_CTAG_FILTER |
 				NETIF_F_HW_VLAN_STAG_RX |
-- 
2.50.1

