Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03F230FC03
	for <bridge@lists.linux.dev>; Tue, 14 Oct 2025 08:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760428982; cv=none; b=csNLpQVRACsFGrayhgAM/a1OYIwqj8HStKFYuffW8sHvFAxTcc8RI2TtqtK8kIqe5kR+GyXfI3ET8U3xCuzO/GHhWQBtqQ/xxezmPuR5bI2HVF0w5gokYGtKv2ZXtzymLn34uwccGOQXJz/LGUKHvP9xC1jIfNROrXGdBGL+sKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760428982; c=relaxed/simple;
	bh=lH3Fg0xYXRRKlOcO2hIA1PKojnFE7636KmAX1iarqLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kd/cdTjMtoQZgbRb/CChbUjT02jF59wxJvFQZi+tbIYaZz0I5MNvC92kM2OeAz3oDldv3kcOZ4WI1zfNy5y/IQZggykb2pd5hZlJ1gvB1AJH2yr1ZxfU74FTA3VnKAULX16ji3YzIMeGOmVaNC1ro7GCu4i5ss1aG3sqoekU644=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bm1ipgjI; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bm1ipgjI"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-78af9ebe337so3992967b3a.1
        for <bridge@lists.linux.dev>; Tue, 14 Oct 2025 01:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760428980; x=1761033780; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6CIivt01bOqUoEaRvA5upBzPrQco5NjM7gJAaWtH0s=;
        b=bm1ipgjIZh9caClG6kw1RtTPZJEu1v7BADJ3TXzpivyRO8jpRvqC8qL9NGDwmrN+iy
         hOX0CmOnBM81JPp6WPDY64EdCvmu9+wjSrInpnSLr2BJUOTzc/wvH91BEIMb9cbLkjTF
         zZzstE4WFA1Ore2kTE82scLNxb7WqFZFkJjHtCyfuu6MfppX2YDRB/ky9vp0OU5hiPtr
         BmUJu6jp/8X6H31qRUpMZVw7rKOpZ8wT+eYcxEL5XLVUJ6L5uS0EnJh6qJqqOHPiC6LU
         A4zHhPob9XAs/pmveUQIWeJM99USCQ1q51Xp3f6n1K5Kf0WSFa+d3oJs3UmeH/K1p9sI
         kLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760428980; x=1761033780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6CIivt01bOqUoEaRvA5upBzPrQco5NjM7gJAaWtH0s=;
        b=F970aTEkjww6Vql3MKt7AjnJu1gArj+iFgZAkWvAVTfYi51zkP5D4vxFtxqj6RyWPj
         JKJQT+z6blbTnnIE+fc6rJulaDvd+2ami5+ywkM+NTLzUVLZpUm9ZmBxfPf8Im3ORXey
         WiUr6ycOhmZMNr0OO/s1BMlBOzGpJUopoFUULCv3CzZzIgKT0LoHsLF7QjX/M105jK08
         0N3a+hRTIpuLWa0HkPprgpN/VcGKII3U2alFo3K0MfVxNV4cOMt3YJQgY03zjF758LFE
         4VA7ujq7ETjet/cf0smA09R5+crCVQ02XV82WcTtUsNa5/jWIRFe3toQUjbcHm+P8Vcl
         IGlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi6WBdN6V0sNRa0hGwysMq5kc9cSyEzYQWAqdOBKG3tWT+O9Y/TmNKON3w9Dk7lGuG71oCetA=@lists.linux.dev
X-Gm-Message-State: AOJu0YyGemq15INgOCHqxI0PrxS+MwNyWwcB2Zmb+8dKOJ/1q0VGurou
	l7iCnEkkAvn8BYL9GYJ0OSzArMgVbwS+/qN9+9bQe6VuB//wK2iQsWpV
X-Gm-Gg: ASbGncvcTpNkXfSrlOrdpjbH4Ux7oGHzusIVedg67I1b6FPYQQo9idMaXqzdXQRn3rB
	flYxRgReboyiG+ZxxkE5PXfjYmXgBsSoonJsO9DDLcbVv22Bfb2fSaMIjILyZKDcAcJ18PGFs6p
	MAURTC7VpuQ+qPEz22W6jFvpyg5yKz+7oHcdFjPo/h9yDje9Z+G0cl84qU2ZI2A3LdHuK7mXHLZ
	lbekL++YTePenPmHef8XyiFRgVBhiM4grEcMS3uN0fCyfmFqvTN1psoBGFVymwY4CdzLPhm73zt
	VoOgJr25waezKHGa5FrEPuzXARW2q2tSwMgvK8JT3zCROVX7nSnllUyQItyKmeyc63MtJCNib1A
	b/OMJUOov1++1gHbzsX37EfwUQikg6IdMdm0CIppPhML74w==
X-Google-Smtp-Source: AGHT+IGSzBQQGsbNRR3SZqd7vh9nZGoC7PUS1lh3+/p13pc6t1WziAuBTsyvJqOXqUW55QcL91DiiQ==
X-Received: by 2002:a05:6a20:3d96:b0:2df:37cb:6b73 with SMTP id adf61e73a8af0-32da80bb9c4mr30115116637.11.1760428980002;
        Tue, 14 Oct 2025 01:03:00 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626407c4sm14648210a91.6.2025.10.14.01.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 01:02:59 -0700 (PDT)
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
Subject: [PATCHv4 net-next 4/4] net: bridge: use common function to compute the features
Date: Tue, 14 Oct 2025 08:02:17 +0000
Message-ID: <20251014080217.47988-5-liuhangbin@gmail.com>
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

Previously, bridge ignored all features propagation and DST retention,
only handling explicitly the GSO limits.

By switching to the new helper netdev_compute_features_from_lowers(),
the bridge now expose additional features, depending on the lowers
capabilities.

Since br_set_gso_limits() is already covered by the helper, it can be
removed safely.

Bridge has it's own way to update needed_headroom. So we don't need to
update it in the helper.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 net/bridge/br_if.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 98c5b9c3145f..d614378245f8 100644
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
+	netdev_compute_features_from_lowers(br->dev, false);
 
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
+	netdev_compute_features_from_lowers(br->dev, false);
 
 	return 0;
 }
-- 
2.50.1

