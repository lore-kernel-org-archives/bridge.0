Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB282638AF
	for <bridge@lists.linux.dev>; Fri, 29 Aug 2025 09:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756461299; cv=none; b=pNicPYiQmEcv9FwkDLGHFWtIWVS7i021itDdPeKiClGux8lwI9Wqi1Sjfb4Gbp4iNDDWZ64+K12rA89DhYcEF8PCWlNCnxfXINVOhZTB1SrfK4O83/PqK1caEi8dDdIfVEakgjXVgcibGTMgA/aeeZasEtYHql7xWfuJiMEXyk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756461299; c=relaxed/simple;
	bh=LvKMJecvv6fCl08ak6wcz+usML93SEKeGztEfvaXXos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XTJkY/YgixxBizgPP5ubxTl0ntURQJVTnlc61w454A/KKXf19Vfjgxd/D+YwsaTh7T7dfjSzfb0pk+REbXB4gQ57bjeM6JslF/eE7UWbLRabm8rcBhIyGT6dbY5lgv/WCdkte0Y1VjYj4kROIzJ8LRkTX5+uxNz9oZCeqYN6Y4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbFivGxg; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbFivGxg"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-771e987b4e6so1511742b3a.2
        for <bridge@lists.linux.dev>; Fri, 29 Aug 2025 02:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756461297; x=1757066097; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ROTQkSqqAop+hXmMAfGEDF4zfkGUQT7wlA8Dp+fSV8=;
        b=XbFivGxgnDPWjWLkOI8QbWzVYUZSpWNJlM0NzOI7QbwNPdIp8o18u3/9Khcdiboir2
         ueY0si5bGH9AfGJeec5zdGjwNMppeVO2FgRUpJ22/WEAkw7ApDGL/pgEqrCU2+CS2fFY
         H/CM1j4oH/IRbD9uLE3XlZ9m3h5SCGWZkd0++ZSCRcb9nZ1AMhvU9X1boFPZERcXAdgW
         ym2ntysv4slbnZbkRtNRI/W88qKON7CxSYJHMwFizzpH4D11+NlYuDNikeBRAREPCFsX
         GwmCkTucM8w1AOF8+gGIRB9RQ9a+4z6DhKsg63XWrgITBcPKR7I3wghB+GW/K0Jx8wyJ
         A6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756461297; x=1757066097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ROTQkSqqAop+hXmMAfGEDF4zfkGUQT7wlA8Dp+fSV8=;
        b=hb5wTr4jv/JhN8dnT4YkJD0dCkCOud/+DtPxNM6pKPUPJxTCVN8/kBku1CliH+c5Tu
         lenaFuWcLzxlMqhojBdWFx3i66yvZMJ473LTPFk1KB8EJq2nzcPUydSme5cf0bg6QMEm
         9SYd2VyZDtQABAvrIEz4mc56WcGjsE9eyfUyFpT4RNizWebTkrl25uHpITemUjS0al6U
         ixRm5x9rbIaFjS7H2LmZe8LCrUVvv3C3g2Og0HSeY+f8mI8NsB0h9caAjqxVkThu851E
         tyGD/5wTtsxr2bLNnAZRBRjkrmOE2bkvoqmhwqym5el6RAAu4Ur6cVP5EH2P2AC8viR4
         Ul+A==
X-Forwarded-Encrypted: i=1; AJvYcCVrjMk+HgBduf7nBl9i2PhN4H2UgO1bpN1EVFmYeI2lBsP1vJvbNvrbz3eiS/Ft+fVbpa/suTU=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzii7MT3FWHhJADmrlU8nDfS0Qiwspuu/s6GvTipLOiqZ3SMFZQ
	JgTFWRLwe8GQK6LFXG4XUUL3Vo9hSKuuEaZZvBK4q/Rc5HrGnXTEoGIk
X-Gm-Gg: ASbGnctOYVnMd3FsNYQaZWDygvzPfprGEJ76Ga3js3JkFyVWxvbsmPVSroS+kidSZ1L
	oZtz+q9Rhk8Emb9VGezK9RcYjxOWEUlSsCLaa+qVyHejoOQO2neZVFjZEG9Q+/l+ugUktFPogk5
	shF2Zgz6kWmcbBC4bn2hN+u4wYMzHSziMbQdTW6ZDpL8kGpJTKSiAfodZmOjlUCei+LCs0V9XVX
	Nt7Lm50XolyyiCtKWHCFe4BdBrTbuX1LR9rT1Nvd5rWGylu0RR77SNNQiWHvEDFZoqVmwlUrzLR
	ki1g2DhZWayx7LrmaRvnjw4RM6vyWdUDUkP9+NshR1jZAyKpLKkvClaKgmCT+Tu7eQQQwhQyzrX
	4x84iwddDy8it48v/Z6w8Gxl4RKR4121oe8GRaMMotA==
X-Google-Smtp-Source: AGHT+IHPK9Bc23mRLIWDN8ntFsoHqmmVHrlhufQQPo1gBiSEBJ0d2KH8HKBIuohVwn//FgkmThDgxw==
X-Received: by 2002:a05:6a20:3d1a:b0:240:167f:eb88 with SMTP id adf61e73a8af0-24340dc847dmr38266596637.41.1756461296924;
        Fri, 29 Aug 2025 02:54:56 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd347db1fsm1751528a12.47.2025.08.29.02.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 02:54:56 -0700 (PDT)
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
Subject: [PATCH net-next 2/5] bonding: use common function to compute the features
Date: Fri, 29 Aug 2025 09:54:27 +0000
Message-ID: <20250829095430.443891-3-liuhangbin@gmail.com>
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

