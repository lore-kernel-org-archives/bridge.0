Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1F624A066
	for <bridge@lists.linux.dev>; Tue,  9 Sep 2025 08:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405976; cv=none; b=LM/UM1J6IFvO91EQLIjwCesxDwgRf4Aj1cr0BX3K9VIIH/J62R9HFVmlLGIKgWX7AMQujLCM9FcozmDFHKlzB++cBFwI1DuZhv9zVXqXERwcRZsLPlPK1d/ecaVHBHw3zO07bNfadvRHsjzAywnNemAsBjsNOwtnS6dhl8B0K7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405976; c=relaxed/simple;
	bh=UIhlWxuqN69pLYi6tPZrXWF9cGhQLaJDRjRgty4I3Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TArvWxsy81ldkn2YsxPmFw6CoGayEEJq9QU78X8WlWP5khwA0Dw8dsfGLILlC4juK0WJggo0gvWXOYwwRdjZ3tDYhABEzDmLD9md9+DUvpYZDiXx/CQE6Vpu208x6NQwIA/hqbqLSMJmWCBlIns0YXJ7r46G0usZisHitL+LTVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGxVIN+D; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGxVIN+D"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24458272c00so60436535ad.3
        for <bridge@lists.linux.dev>; Tue, 09 Sep 2025 01:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757405974; x=1758010774; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9kBZ8wSNbgVPLWYpqquJEoE5nIKe8yQyYCFGYvwsAQ=;
        b=WGxVIN+DbDggfN/2G9baWvy/92P0GNkccT5qhKC9yPV9kpvjzkCh0zCA53FcfXW31l
         XcIvbW0uZHlx4gSQEewmtmDI954BhlhCjLaowtZYNxWRPg4E5fR/XaqQOJz5t+j7NQ3Y
         1NFrKuiJW+yetZRjH9yDXSewUX+swfN++vIwjZutk8ni63FCCBwsJljg7qc766VUVHmC
         4d+zafEDbvycH9qW6kQ9Yct5Vgwu68odUyfsynbqQPqlbHgWblDD3fQ1mScNGzOcvpxr
         IliFkkilgKTNHnWoevSBcq+A9AELOzekE6GnMJiHZ1iQVEwBQRYSPljMHZ7wyRHCWijQ
         4hMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757405974; x=1758010774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9kBZ8wSNbgVPLWYpqquJEoE5nIKe8yQyYCFGYvwsAQ=;
        b=i/JJaMdEt1FUwVzGh9QKsDkWXBksEZb2EuHsoSD3SZrlHC/O9U83bWoHTHHx3VUEJJ
         JrkZoLgeS4Yw1Wmi8mX2a21rhvsBdcXWEyzUH0V6YORhpkYdJDJExv5+hfM+U/xMfgc9
         t1EVju2Jhi7bk4iLKIX/UbtQm0NFR6bkuhVJiPNt7qsbXemQvU9cfLUkRP9R0hn8Lucj
         ssj8zS9Xgv8098XWySfyB3J/73QMyOA/+9yrHoCRbyB5+/sL9qkxGB7xNkBZX5/TdUJP
         2ZnW1Not7o+6YszOLTEs6PiNYMhurCAUqzAbHdaOVl0o0bJR32HZAIhLmZEAhG8uvvNF
         4p4g==
X-Forwarded-Encrypted: i=1; AJvYcCWmJGaEDQA92TBadQN/jxKepX9FbuaulXV+3WBlPCGMdqljtXKVGUnYCSmipUHhJTwD5KL4klo=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2Z+joRCazZgbHgWanZCHjxPMLHBmSecCkOHwMfjKfxvSVo4cZ
	hVfzf9dUO4rH2k0fTuKAB3nNJdST7Uq+tSCo2EIff/IzFaYSzUzdVuAr
X-Gm-Gg: ASbGncvGUKWXDFF0VR3RBv7XnnpcF9VyPEOmKns1UdD0z5bh5qfPUS7Gv406vx9oG/4
	35aiWceDHgnImtNya4xk+BmiCSrdifjfQ+/Q/Vl8Gm2Tbhy6qzl/4sdG7ZePMWOwv5FkzkJKlqo
	Ac7GPoA1vT24DVlUbhAuV4KU8lJ0NPz+n4rroECg5WCRkW7A/pMJoSKylRiXklNhehnqv8PmWpM
	JGIyo3bd4j/ViLuUmwoXSl1V0v5SP/RojcSP4KKgL7pppWr3CpWH/ONhgZrrJ7ZFyJi8DPG/gsc
	70BSHrOIw7lQCHdzAcaFU0kh72hKFw4Le5/3NJHB9BDgvNetV44j3cffHmeps3ZsXL/UzbcNiY0
	7Lfs9Laa8ubEgXR6pnv2JUPjr1h8H8IKI2xf2042WeccXvAbgE62Z
X-Google-Smtp-Source: AGHT+IFkevz+07KZP1RBJh2ujaoDNj45NZZpaRqI+pqsnwseopNaWUHlbdVezTUcHfaceDpVDyDddA==
X-Received: by 2002:a17:902:fc44:b0:24b:62ef:9d38 with SMTP id d9443c01a7336-2516e887fd5mr144769785ad.19.1757405974451;
        Tue, 09 Sep 2025 01:19:34 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c7ecd9cafsm174370575ad.83.2025.09.09.01.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 01:19:33 -0700 (PDT)
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
Subject: [PATCHv3 net-next 4/5] net: bridge: use common function to compute the features
Date: Tue,  9 Sep 2025 08:18:51 +0000
Message-ID: <20250909081853.398190-5-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250909081853.398190-1-liuhangbin@gmail.com>
References: <20250909081853.398190-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, bridge ignored all features propagation and DST retention,
only handling explicitly the GSO limits.

By switching to the new helper netdev_compute_features_from_lowers(),
the bridge now expose additional features, depending on the lowers
capabilities.

Since br_set_gso_limits() is already covered by the helper, it can be
removed safely.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 net/bridge/br_if.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 98c5b9c3145f..8fe44e8c008c 100644
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
+	netdev_compute_features_from_lowers(br->dev);
 
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
+	netdev_compute_features_from_lowers(br->dev);
 
 	return 0;
 }
-- 
2.50.1

