Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC890376BFD
	for <bridge@lists.linux.dev>; Thu, 26 Feb 2026 11:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772106202; cv=none; b=biDEEkOuHxaeIjfRjQQ4L7UhXa2l/60CFtn63q3wC9OgjqqCbAtlwDeuek5OUaJGd5OgonOkOd919H8TZJffSqmycghUbFyiOta0HDdncdiRabspjpmLOuq3OY2AWgTe5hwsOq4NZ7YJ3yjwf9cOMWcRXuMah7QB7JI+cYBGnKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772106202; c=relaxed/simple;
	bh=GzjQ1QrmncB3M8ZZh2gze1EuHsDImbS4oU69hNkTzxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+Cn32LQ9zrALW1LJ94dPVvJePIwi8TFZFU3hZQQuN2iCqOKEr85BrIMgH2fURsqK7HxMKnL8yqsvCi9y8Fh6gIogvKkMXKfPblAnEufLlgFi3wnl4UDZi6uGVKWH5vF52Ldn2QGr6LYCbjyf1+s072ZIF8vlOge/qLVsZs0Xv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCx67jqN; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCx67jqN"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2adcede372cso2983135ad.0
        for <bridge@lists.linux.dev>; Thu, 26 Feb 2026 03:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772106199; x=1772710999; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ciG01gWGaVHVP/mcZG8G3rAKieiLmIPuwLg8daH8Bc=;
        b=iCx67jqNK2iCtFaRhgZ2Hx+6h/e93JPZ6CZCEfrkXD+0sCn2niKA1pBGLzLe9OPsd2
         3S78pYn2m3HeSyktpNqJrMK1T77PPzgEnFZML+vZ9mXljGTQxcmsv12MkspPciMvE87x
         EolKSG90rjJZEWjjYgrseBRrGIJExkTB10BHMZ9uWGvSpRZpuzxv5reohzG/ApDdZcGS
         WF1x9MOrwVRVoucq30ESKprmnrfaitlLRQS8Idqy8ihq8aNBXUyDxa1o3RQ5QffWMoHP
         FkDbAIkbU+jnQpNWjgps063CvzPWqQ0dknZDsS75ctV7ptzRst91zFRRgkrjZn59702G
         q8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772106199; x=1772710999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4ciG01gWGaVHVP/mcZG8G3rAKieiLmIPuwLg8daH8Bc=;
        b=Dv2lfqpqITYthD+Vrxj8WXbbIKXgxrAzlCqHDGWR4bcoEfa6p3fBifuSJyqttCl68H
         IRGW7qjwAqFng2wK3pSAfrZ8ODDqfQbXYuBbXaoao4Zyxj/7oWW5xEWpbqArdGhfP5Vv
         HKz16K9PYh3qNoPBO02Mi8tq7GR3bHgLJ1rB36jXTdAToeCDZsIzuCG+wVU4+kVcDbIl
         4vZAQ6Tul1QZFkGQk2+d7BvCjRlab3D+RxR8RXeq6l0bXCEXPJJq4usefSCKcf+b7jkc
         uHztmvR+ySlAwseMsqYBHirwWMZ0shKgxwTyEFk2I+GDDAXd+R6f4RTqmLhub20V21tE
         4kzA==
X-Forwarded-Encrypted: i=1; AJvYcCUYfrL+3Yz6Sf/WcLs3aWCK+uOGRgMjS0Z1pz4Bevb6xNSK23uJUz/ZC3ZiMsQCj6TvXNXJyxs=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywu/CLHeTlkFr60ir7abEE4b2rZM5m5UDB1gUXu8X6ieLN7EHx+
	rXT6l4QG3rE84vN6vOsmp4UR/mQ+ddT2t0SUTXkr0DWlI5D82X9x7QdZ
X-Gm-Gg: ATEYQzzK1etEl/mK59REt/s9Th+WjBGmRXUWBtznVI2iUZDBl0LH+0KtpfvZeFcxvcs
	El7C9GFCz4bR1TfU5jhwAqFolfXBle8ey1zZf/YvzKGKdo6Lnl+jXmjFNJFH8NMVQ7/mGDFzQei
	yk9hikReCHkIo77afFwGuIPh4UYGjpLJigE5ttgX7r6zO+Hfzsw/aEFOW4yeHWpxApg0ewFb5+c
	JhP6k0IHq9uOdRiX5xn5zEHWu0XC3AowKuCCF5ItqgC7SUfhQP69eX0Gwp2/3etkS4FztAWxZLK
	LkfneRXNygC1HkQKEDGDNsK31fUPyTCiMwbw8krXFotOTCx3+e2xOmbLXRJDLJdlN2qFf2SjdqV
	D/XFYT5/5xyKxFAZcNFtT0qD1V+WhfRVYuN2kIhIjsaVMd4PRuXOIqNbVrZX2qWrSSHov466fXi
	IC9928yLB5KniLkEbn2ksj/k5V7TU=
X-Received: by 2002:a17:903:32d2:b0:2aa:f2f3:bcb0 with SMTP id d9443c01a7336-2ae036e631amr24181285ad.47.1772106199007;
        Thu, 26 Feb 2026 03:43:19 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5dbac7sm34131545ad.37.2026.02.26.03.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 03:43:18 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [RFC PATCH net-next 1/3] net: add ndo_update_offloads
Date: Thu, 26 Feb 2026 11:42:06 +0000
Message-ID: <20260226114208.27774-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260226114208.27774-1-liuhangbin@gmail.com>
References: <20260226114208.27774-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new ndo_update_offloads callback to net_device_ops that allows
devices to compute and update their offload features during feature
updates.

This callback enabling master devices to recompute their features
based on current slave device configuration. This is particularly
useful for bonding, bridging, team, and failover devices that need
to aggregate features from their lower devices.

The callback is optional and only implemented by devices that need
dynamic offload feature computation.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 include/linux/netdevice.h | 7 +++++++
 net/core/dev.c            | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d4e6e00bb90a..1169091ccb9a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1281,6 +1281,12 @@ struct netdev_net_notifier {
  *	constraints, and returns the resulting flags. Must not modify
  *	the device state.
  *
+ * void (*ndo_update_offloads)(struct net_device *dev);
+ *	Called during feature update to allow device to compute and update
+ *	offload features (like vlan_features, hw_enc_features) based on
+ *	current lower device configuration. Typically used by master
+ *	devices to aggregate features from slave devices.
+ *
  * int (*ndo_set_features)(struct net_device *dev, netdev_features_t features);
  *	Called to update device configuration to new features. Passed
  *	feature set might be less than what was returned by ndo_fix_features()).
@@ -1558,6 +1564,7 @@ struct net_device_ops {
 							struct sock *sk);
 	netdev_features_t	(*ndo_fix_features)(struct net_device *dev,
 						    netdev_features_t features);
+	void			(*ndo_update_offloads)(struct net_device *dev);
 	int			(*ndo_set_features)(struct net_device *dev,
 						    netdev_features_t features);
 	int			(*ndo_neigh_construct)(struct net_device *dev,
diff --git a/net/core/dev.c b/net/core/dev.c
index 096b3ff13f6b..d05837c0713a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10982,6 +10982,9 @@ int __netdev_update_features(struct net_device *dev)
 	ASSERT_RTNL();
 	netdev_ops_assert_locked(dev);
 
+	if (dev->netdev_ops->ndo_update_offloads)
+		dev->netdev_ops->ndo_update_offloads(dev);
+
 	features = netdev_get_wanted_features(dev);
 
 	if (dev->netdev_ops->ndo_fix_features)
-- 
2.50.1

