Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB4B2EAB68
	for <bridge@lists.linux.dev>; Fri, 17 Oct 2025 03:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760672555; cv=none; b=Bm0uP0tulm5JZm56L7vu/ETp9QQqh2mHm2QBHz8OEMSmh5dMb6kYd8QB0GIz1sFwkiGqJ92qw+KFyxpItbfcr4Ea/2TSA758G/4LwVwO4BDukBddcJ4K/0Cs5EDhpIKOV9GH8wbAgx84gTIK2+p/KS7hehGPVKkPXpNgtWNBN30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760672555; c=relaxed/simple;
	bh=tV3M89Ff/zXcbHcKpMVblXkE273el8N9v5UlDIDcdes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhcGcWrBmrB7QkvqF6jKT2PVrkkuUrV9mSaXR1X+LG4a1wLm69qE9U4buMQ6Zji2tt4Wp17p6n23R9qGDhr0KSq1JIUHGa7eRQ/5VBC2hZo5F59PuRZVXlfMONq7wag9LbEn2PRFuYHjkdAAwAaoJ5sja1P+0APtdNZRCVI2ITo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4+pJtF1; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4+pJtF1"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27d3540a43fso15652535ad.3
        for <bridge@lists.linux.dev>; Thu, 16 Oct 2025 20:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760672554; x=1761277354; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQCGU65zJTP7rbQY7IxDIXC/3gKQXrOHz6Nfdc2qF2Y=;
        b=V4+pJtF1JsSfrhusjllrqsOJLwBeioId5s2aOva+IikOwJCbibf7bIRScDVUqdsu2B
         NCvWKDkuflYggodH3txY54XDCJCaf6VRT/iiB4LGplFpvqXQNFn4jKE2AEokBPs3XkWw
         RCTsbMDuywz5O4/m5Ch2Lu3NsP5UUGuc7ICcWzypOE2PJX6yX9jiwmoX61Z5mkVd9elw
         UunvPiGxw3X4JdLdvDJGQjkMXjlIJPSXu1XHJIBaDrJIWMctkl9TIJLZunkm43oJUn98
         z7okhBspGgUZLpShWyl3A4silOsx400bltE90e+5lOqreaU1Wt1hg1DcWoPYhE6q5Pu8
         L37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760672554; x=1761277354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQCGU65zJTP7rbQY7IxDIXC/3gKQXrOHz6Nfdc2qF2Y=;
        b=FMqn0uCBLw0tn7vdqAOl00asquNNrt9ZQ2Yw3Cz0Xku2MDHhjWI/4s1F7eT4OtQDSO
         j8/aiH4kQaVha9HLD2z/gBDXQBIl1HIicos3J0OCgIanKgvYP8VqzJ/ACMoo/Y2afTkT
         PqBGBIpfGbqqzij4MAS/2uRQehxjImLr53RkM8l9fL+pdxUxL7q3l009fFJZ/6Xa1sFj
         DvU0uoNMYbonLtEfEueO1H4umnCq/QtQypBZCJczm5PaTPv++SQKqCgb4zUZAcKd98Hc
         ArCwkFBru/UnOp1Rmd7A6x7vw3ESf2913X4Y0flKIszGXl/TDLc9YV/jIQ2cOEm8xhLL
         QXeg==
X-Forwarded-Encrypted: i=1; AJvYcCU8+sv7T+onQK9RTgBtL5emPuVI9O92D8426S+S4S9VYTzbDgSRh1tYqpDU74q1RUTJJXAJ8w8=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0CpQIujmlfSnjAooOMxtf+IMbSnR4X5nw8eyTtYOHp53UU7bZ
	q13o61Tzo++vUZ3+aDi+k11cLW2NzArd7m69zVWu/jXR44LfAmbMLsKHoDdrvnBZ7kU=
X-Gm-Gg: ASbGncu5hlRUhctIH3X/trV5yj6cyAVJ+ycMrCeQmwfVVs0u2InW07qReDIdplTBB2K
	XTfHT7qCKOL/XTb94Im1VMwXpJea31ZAguXrKWxEZJvAYNEnhrVid8iX//dilMJGK0yolzfL8F3
	YIEIfXkHw0U/QyMReKHgB73LzYqfvM+KdYlBY1436VhFxh5GqChkK8I/Lz5AKcJ9lU62wfGSgCS
	xu+ahIqHzJllBisELkBYtuipBWdx8tczozGA2lqqF5Se9I/74u6+dXV9+n98WODiJ8xNozQ7e26
	sw+hrKbZ0wi54uJR/dwAW4BfQVlx0q0bQ2pCk8tvcMJQYWgfs6Hc6ODLCiRKsvzlv7m7uqOmmQH
	g7wuBnACEL4c2BFV7RI/xS0CYo0y8Mru24PxO4lfd2cE1mtqNK7lhb94Q1xY+0xhZRkKnKNhnwB
	5POdvmzd3ZRoRu994=
X-Google-Smtp-Source: AGHT+IHhDudOgwPiLKIoaxZSVvQ0j+dKBJIIPws+2V0xXyqsjbJmCNxXruj71qD8aVFtDr66ZboV5A==
X-Received: by 2002:a17:903:98b:b0:263:3e96:8c1b with SMTP id d9443c01a7336-290caf83188mr25695835ad.33.1760672553736;
        Thu, 16 Oct 2025 20:42:33 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099ab4715sm46695165ad.93.2025.10.16.20.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 20:42:33 -0700 (PDT)
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
Subject: [PATCHv6 net-next 4/4] net: bridge: use common function to compute the features
Date: Fri, 17 Oct 2025 03:41:55 +0000
Message-ID: <20251017034155.61990-5-liuhangbin@gmail.com>
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

Previously, bridge ignored all features propagation and DST retention,
only handling explicitly the GSO limits.

By switching to the new helper netdev_compute_master_upper_features(), the bridge
now expose additional features, depending on the lowers capabilities.

Since br_set_gso_limits() is already covered by the helper, it can be
removed safely.

Bridge has it's own way to update needed_headroom. So we don't need to
update it in the helper.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 net/bridge/br_if.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 98c5b9c3145f..a6d4c44890fd 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -525,20 +525,6 @@ void br_mtu_auto_adjust(struct net_bridge *br)
 	br_opt_toggle(br, BROPT_MTU_SET_BY_USER, false);
 }
 
-static void br_set_gso_limits(struct net_bridge *br)
-{
-	unsigned int tso_max_size = TSO_MAX_SIZE;
-	const struct net_bridge_port *p;
-	u16 tso_max_segs = TSO_MAX_SEGS;
-
-	list_for_each_entry(p, &br->port_list, list) {
-		tso_max_size = min(tso_max_size, p->dev->tso_max_size);
-		tso_max_segs = min(tso_max_segs, p->dev->tso_max_segs);
-	}
-	netif_set_tso_max_size(br->dev, tso_max_size);
-	netif_set_tso_max_segs(br->dev, tso_max_segs);
-}
-
 /*
  * Recomputes features using slave's features
  */
@@ -652,8 +638,6 @@ int br_add_if(struct net_bridge *br, struct net_device *dev,
 			netdev_err(dev, "failed to sync bridge static fdb addresses to this port\n");
 	}
 
-	netdev_update_features(br->dev);
-
 	br_hr = br->dev->needed_headroom;
 	dev_hr = netdev_get_fwd_headroom(dev);
 	if (br_hr < dev_hr)
@@ -694,7 +678,8 @@ int br_add_if(struct net_bridge *br, struct net_device *dev,
 		call_netdevice_notifiers(NETDEV_CHANGEADDR, br->dev);
 
 	br_mtu_auto_adjust(br);
-	br_set_gso_limits(br);
+
+	netdev_compute_master_upper_features(br->dev, false);
 
 	kobject_uevent(&p->kobj, KOBJ_ADD);
 
@@ -740,7 +725,6 @@ int br_del_if(struct net_bridge *br, struct net_device *dev)
 	del_nbp(p);
 
 	br_mtu_auto_adjust(br);
-	br_set_gso_limits(br);
 
 	spin_lock_bh(&br->lock);
 	changed_addr = br_stp_recalculate_bridge_id(br);
@@ -749,7 +733,7 @@ int br_del_if(struct net_bridge *br, struct net_device *dev)
 	if (changed_addr)
 		call_netdevice_notifiers(NETDEV_CHANGEADDR, br->dev);
 
-	netdev_update_features(br->dev);
+	netdev_compute_master_upper_features(br->dev, false);
 
 	return 0;
 }
-- 
2.50.1

