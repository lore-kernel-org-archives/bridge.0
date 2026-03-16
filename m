Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15FB32A3E5
	for <bridge@lists.linux.dev>; Mon, 16 Mar 2026 04:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773635227; cv=none; b=Am8W2OAJyA2X9EbOpbGIyhkMZNaPNvedFjScBHIL/kGGxXx8vPaVuhNwGC40kOP+EYi8v0VbuV5yeMgbwW/ovVD9DmCY2oejn53h1x5j8uBqPRj51pGI/g7LVQwlPIB89L9jItu6WcjwiFDhGGVb80UERwhvvAhmOoILQOgawW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773635227; c=relaxed/simple;
	bh=qNPeHvHZTZR/YyNb7PrqwI9kz5RD4rqaFT50tFfTL2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jj5V0psaDFbarg/bUFavZy0sNEsQjBCjTAmMJTQk+ALzfQQf+IiW0xfK0fiwTL3jSl7eeJv6qzTg70y/P/hvz2PUxYaw0s277QRsAXMqOsv4UKxj7DwxdXIRIckrcmj11fu3TyJoH8efWNOg6yvMlNCX4axpFChTUTUJfBYHKrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKSKU+CX; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKSKU+CX"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c73e9e4cdf7so1030640a12.2
        for <bridge@lists.linux.dev>; Sun, 15 Mar 2026 21:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773635225; x=1774240025; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S4NrMDbk24kpM0xeU9hz073wyfuICysoD9kSVFILYB4=;
        b=MKSKU+CXzbyHfRbvdIhNnUIet0ZIMcrVhcYzkL9Wak3KS1lbTLAOnFAfu1nOnHsZ6/
         W2MHsJDDi/vqqPpuIiCIwXJjuTRbXbFnZTYyoWyukL7OXP/OAeVuqOzujmfjknOXnXLH
         thldt6n4e1V9CP5wh1ihaTPv3nWuq3POD626DvpaMWhfYqThPqXYGbJriKwPE5XydoY4
         7xJkowTNY6eAZsxzMs4hFuIy3oOSrVkj2oEopQDwpVT/p1Sn9gDmV1kcbbVCXyR4ebwK
         kD1ouRyNbeLesUl2udaAm+V+rVbBEVfd1gqPvASNpZC+L/ThibinJYRZEvrg7kbu9SsO
         lbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773635225; x=1774240025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S4NrMDbk24kpM0xeU9hz073wyfuICysoD9kSVFILYB4=;
        b=LLQPyzoswR9cVfS16yI5w+rfrEtRCimI4idoiIQPIbQpAVBeEFz29xwX4luDNguSQt
         7TyckaT6DvdBeY+y9Xmofh+5tq2hbkAUSknmoyVuGIY08JBgSAlIXmg4DnAffjmnvqqi
         Je/uvhSaiFSCZ8Hl2/XPP9wvR8SrHEEWLkGQd8LqIfV2iRqn9sdfDuFUdO//u5sGPziG
         0T/7G9rgNUVj3lV7rxKNH8uRl7Z0XAifLaVui8cyKqVZGeHBZf62II1gmNoRlw4SjGiS
         JLv7na3swPitFP7PbRl++OTfYRjKjJNLKBU886DcDYR1LPMrvytqNEk/f/41V7mkhMw+
         yEPA==
X-Forwarded-Encrypted: i=1; AJvYcCWKiNaOAPBXgcGttGW234USJNAcy5v6PSdtn0CBXcSnI35RmQd8fIglICa7QWrOp3jrmEe7siw=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxe7ruvGPsHP8cAN1URuhIv3WU+Het4XAZ0y5rkHA1rAOkniGv9
	Grj0qJcTeb5O8LuAj4ns9b3Kkji8oAqAZwiIc+ggvWftkA8tqCS+QmIG
X-Gm-Gg: ATEYQzya8QNzBFV2974dfSsamxmPNtHa8mrHds5YAa60y4L9KyG4PC29GOcyvgVbdex
	tVF4NdsP12kKB+BT6t5AW6KJDwVVwrHnPOs10t07J/yGQkCJArDd+gwXh6/rT84jQXclYd6CCdI
	tQnoXiVUupRSvfgv/OHTN6RprAfXf+yOi9Az06QWINkr6WTwFa2Jcj5367Z2k4fpn1Qt2gtuzQZ
	E7QzUp6tllJG84bmYSArUHWzQAPuiooQGhAS/pkXf94TN79y5OsD9hEur09ubjF1/lftEgHp5Oh
	s5yRuZGeY474fm6NinnvwNDXnsdeLy7+l+VDkbrxfN1zoM43YVmeLJqu+J7hxDud4rn5VVr+NFm
	4IXLYky4ZkDz+UERJrDkPlhVWFWBqtb2IKAvrBJe0sBvBZIjudy9tq2q9gXVlr0olb7jI93lDW7
	B9DroeWifbyKDzwFZp88nisAJbXCuOBtSh6BiXhNl1AjA4kHMl77F3WbYCDA==
X-Received: by 2002:a05:6a21:d83:b0:398:98ab:71a9 with SMTP id adf61e73a8af0-398eccd8644mr10815982637.44.1773635225270;
        Sun, 15 Mar 2026 21:27:05 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([240e:34c:5760:3860:bc29:deed:92d0:823c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0738422esm12180267b3a.55.2026.03.15.21.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 21:27:04 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Mon, 16 Mar 2026 12:26:09 +0800
Subject: [PATCH net-next v3 1/5] net: add ndo_update_offloads for offload
 computation
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-offload_compute-v3-1-a5d4a07d86d3@gmail.com>
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

Add a new ndo_update_offloads callback to net_device_ops that allows
devices to compute and update their offload features during feature
updates.

This callback enables master devices to recompute their features
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
index ae269a2e7f4d..acaec0340266 100644
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
index 200d44883fc1..bbd532aa6a1b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11011,6 +11011,9 @@ int __netdev_update_features(struct net_device *dev)
 	ASSERT_RTNL();
 	netdev_ops_assert_locked(dev);
 
+	if (dev->netdev_ops->ndo_update_offloads)
+		dev->netdev_ops->ndo_update_offloads(dev);
+
 	features = netdev_get_wanted_features(dev);
 
 	if (dev->netdev_ops->ndo_fix_features)

-- 
Git-155)

