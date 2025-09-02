Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50BA2DF144
	for <bridge@lists.linux.dev>; Tue,  2 Sep 2025 07:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756798014; cv=none; b=YmIw1YkFedfOGs1IB//wx8ufQ0qSGhVsdDwvYQYMltb/48fjgi2NY53ZUQlf5QqK2IVFfWbs6GQyxj8EoB9NHYjc+ZCDPYuusvseIHp8Uf77x4z6fNjWsFcuwCWPSHsKZ6nR1FIploIKfT7PVJOzXDHFC38//hGN7Q/UwUABdGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756798014; c=relaxed/simple;
	bh=UIhlWxuqN69pLYi6tPZrXWF9cGhQLaJDRjRgty4I3Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E6ofZFVnoxSO57216NSR8o7zOZUU16Aok2ahdE/DSpB9l+9suDlPhqq7PPpkFPuWuqM181ASR+W7jaPid1Atoq/1lbrqUxhT6PBXq2aCwce4ccGg70idiQcDpYNS90OrHD3s4RVzpWAivzK36decw+sfbgqw3bkfjXiMCgY15yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/N6t4rd; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/N6t4rd"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77251d7cca6so1587349b3a.3
        for <bridge@lists.linux.dev>; Tue, 02 Sep 2025 00:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756798012; x=1757402812; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9kBZ8wSNbgVPLWYpqquJEoE5nIKe8yQyYCFGYvwsAQ=;
        b=i/N6t4rdZe3I/mTJjSnPFzXYVoygyLxXIemxQouSbyn8yO7nmJ+G//9e7CP4Kgw1qa
         VZ9hMgf0gEtTMO4+eQAQCOgZGkw/MsKho9gnfSyLX9bXHvV2UCVq7xB0NNwgc1KfTLoI
         +J80Gt3W3QC6H+gyxT9Q7pZJTYpMP8sJTMYuhkPTQdDV9zz7jxhVB6BGMi1y2ZxKNc81
         al7VrW1QXaDyDo7DYSTmeCCPRAgjOS/nRiVnNvzTLbTC1Kx6V8ledyvV0gb02zOBstSy
         fIKvj7/DqBh/LY3KNy2870jYxiHsInGV7yGiHeoFB51sr5OS0Dsu/qt6LF90cT23Eh31
         q5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756798012; x=1757402812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9kBZ8wSNbgVPLWYpqquJEoE5nIKe8yQyYCFGYvwsAQ=;
        b=wYKzjxs1necnIW+nfDqfmrWRMD1h8qw2DBm75Op0do8x2BAb7R1pbEWMrHsafIuCvF
         NLDsDYdKJbuxpRLMFdoT1o9xSmDH0vxd3w8I/wMCNPfLOOycrD5YYqCqRln+F3l8lBil
         9okAT4TjqTRnRWXXN1jPGPnqGAQ7qSwDAWcKhEeBG2AnkDXcBnxq7BJ1azeWd2b2hbi7
         FxOOBU9t3iII9e/Y8JEqNf3MN8hP07QRK4Q2xFdC82agdhzelSa28CdQLODgQywauiad
         5Ef1MYMwsEFRrt98a+LkKXvYGa+gjz07Fl1WfpH9Graedy6VduADF8xewQ1PU2oOGet9
         r2Qw==
X-Forwarded-Encrypted: i=1; AJvYcCV0yDr8weEVVlPoNFRHvl/MFeN+S8SiGoGkELe1JlrzRyqHEa45Yw/FHENvxbDWod7rWzeIAmY=@lists.linux.dev
X-Gm-Message-State: AOJu0YzT3pmJyKAn2fohwUH8teCELj8xwAyhwlNXewvQZUk5EokOlajA
	3UP2YdZqlY5eMl3h1MFGtD49YBHuLk6qPS0V49+bxetAMsaN6eXGKMD6
X-Gm-Gg: ASbGncvcUlG6C1l7au/fc0OfOwOdwPi/7iXMkuCwzbje5PVOn0sVi5KXXL3NXtHhtIv
	q+t0LXHrbitGfWHnVOkmSioZ5mjiicG0VdvjW0qW48If0EcIucrEF86fvSs9RS+j2rEZ9Ms/TLq
	TUFXTi5l4W45dVjzIemp47aUZ9fheymNSwVForkHgPjHMG90Qcb5M+nAo84U1E2/5XWo24MRIuE
	azGFMk5bPTr3P8WVHPv4iz+Y4OCSMAmvHegz3Ct4X+sW3DDhaVUN0GEDUoxQDIzZICwzcHbX1Gf
	5E6UFHNV+cDSrMGg2gGao/qTAD0fRayz4BK8H4V8QoVTmoeETNGHNzpe2OggjXFnMlp0zmneRon
	UysuqPQ79SLCpvyQqIqmTZNJe7nybffLjCFlu9G6iyQ==
X-Google-Smtp-Source: AGHT+IFE5feWtU2KgQp1RM18qUQKlzI09j/4JTDWTFuzVs2U8m5ajSDdOry2e6kxrkWUVrtwE2/S+w==
X-Received: by 2002:a05:6a20:4c8f:b0:244:58:c147 with SMTP id adf61e73a8af0-2440058c3f7mr2245485637.21.1756798012292;
        Tue, 02 Sep 2025 00:26:52 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327d9347189sm13416648a91.9.2025.09.02.00.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 00:26:51 -0700 (PDT)
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
Subject: [PATCHv2 net-next 4/5] net: bridge: use common function to compute the features
Date: Tue,  2 Sep 2025 07:26:01 +0000
Message-ID: <20250902072602.361122-5-liuhangbin@gmail.com>
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

