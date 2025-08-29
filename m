Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1863074A0
	for <bridge@lists.linux.dev>; Fri, 29 Aug 2025 09:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756461313; cv=none; b=ITDJ7D/e1qQucJDoRE83eg8RozsNZMyhRb74HDlB075rmB5fXTU4JsD1AZFaZe/a/ch+1ILom6vcZ4ri/IXWgJjGtB4LBhdxvVu9U/tqV2+l5uPuctnR7vg4WZSmzp4WWmGpwKLcuaWSw4wLSu/YYkDXU8VWoS8MQR/RqXHuDBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756461313; c=relaxed/simple;
	bh=UIhlWxuqN69pLYi6tPZrXWF9cGhQLaJDRjRgty4I3Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZkdhtShShHfQCL5BQxHeAwlVJi8RLnm6w4UyAWyViEDIj81tl+86Eup7CtOwR6uKEWzCbPGRhJLiA6m/MVbs/9bKioUVljNDnJYKPV8a+jzIniDNMjRZpWxVZTBOFHWAKsPrN5iMMBmNiNqlkjxC/yJ0Uh1D17rO6+fCo3RTMec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaHdHl48; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaHdHl48"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-32753ef4e33so1457509a91.0
        for <bridge@lists.linux.dev>; Fri, 29 Aug 2025 02:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756461311; x=1757066111; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9kBZ8wSNbgVPLWYpqquJEoE5nIKe8yQyYCFGYvwsAQ=;
        b=WaHdHl48g75JwGmzn4kdlRL+nTG6+o8/LW5H0TxpoEff/E4NCLLXPJc8wAgPJHNIt2
         25COoWBbaSxf5DB84BeBodQMYhlB/BO9JJW/A/H7fYxT9l6I/P03oXk+vLn9VcAmQSGj
         o8r/heinVsDErau1xZxcX7RxyuIqmwvcOCt/G1/MPxk1WJuDm9HqN6FS49IJPzfyHzwM
         Em96jajIiUyUtP6P17SrKhOBFVu9NPl5R4VP8HrqoeouB8Yd+/2SFzsqgJjrlVOCXcfk
         EFugxcUvnmpi5EX7+ODXlhnibiMTWX3YYrGOxKAlM/0LL/QEtChFmPhaSFefsX/CGcM2
         rU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756461311; x=1757066111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9kBZ8wSNbgVPLWYpqquJEoE5nIKe8yQyYCFGYvwsAQ=;
        b=u5/QqgoB54as6iiSmzCrajIaWqUx4DoytSknSx8SmbGIly3SUt6HA+JMiGmy47DpCo
         Xp6OTZc+trj9w8CYwrUN5tcOXtCftVNAqWzv/So5yJWZlI9Tt2GG1Iyr1CGZXqTwZBix
         zbpvKyQJ3Ce8WyaErocf8nOuraw3KyieiR3+ljg8OCZSIoZSsGAmHU50GDkHgZXkhqRA
         XMWeMihxEblSNiBL2RkCrBAIH3okluRP3IGDEsnObUWmo6BiaWEZdmgZWLkVD9YwuiHR
         YkYc0Ff5ZFm3YqFA2zFKxWeUKk1TaA5/YGXDW3xcVLvGbqQT7WnXLnCiTj6wGqi11MIm
         8IFw==
X-Forwarded-Encrypted: i=1; AJvYcCXgNQ6ep3C6qEUjln6LnunD1WMmgadsM+cRCt8DILr1etP3eiKkE8yqBRAfH3jK+rH90XELQxY=@lists.linux.dev
X-Gm-Message-State: AOJu0YwK4wOswZgq5raXudXzLPHChvjWBZV+6VR0yH2wWBKfvtwZr97t
	l38Q4pnMhBjVQs7wB7Yz0+HtAtbuqjHWE2V80BcxTzTTgKJe3JVBYh5o
X-Gm-Gg: ASbGncsYAQ/oIOHaIoOyqLT5vQW5rySuDFmRJCnpyRVEtLUEcnBD/+5RaNEknkXWeI9
	rZi+a5uDN0DOgzOQ2dfss8udysODn0S6AT9f+ko20wp5YXgYtP+qdjS7r0wlFB5vs2JUQOIifuu
	HwWI2DDtZp3OgF1R1kjE6C8yY6k9QMHvHaOOXuRmtZY6gJBEmDhzzrWfwus6Q/QoWCU0ZeiqmNM
	rVPNVUHP3CqMhuUebJwugMd+Rmo0qZk8niaVPsQPDRxKm5ilOVYhPxrb3KGmdAHW7GaUQ3o89Jz
	9V4FJarPqIagBCKDX4fOiskG8pBoP5lhmpa+IkKC+m06xjMME0MFeOf0x8gQ8lYsd+9QdQZr4Q+
	nsFZcPddBSaTqEoyj1w1/EcwexfAqHBrkqfudw8hRgQ==
X-Google-Smtp-Source: AGHT+IHsK4m1pnnbSsQ0TC8ivkR557BH2bcTyUBjY0FSec8e/powKl/lqDZiDqj3ASoVraxYAGyFIQ==
X-Received: by 2002:a17:90b:2ccd:b0:324:eac4:2968 with SMTP id 98e67ed59e1d1-32515ee13cdmr36122443a91.33.1756461310881;
        Fri, 29 Aug 2025 02:55:10 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd347db1fsm1751528a12.47.2025.08.29.02.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 02:55:10 -0700 (PDT)
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
Subject: [PATCH net-next 4/5] net: bridge: use common function to compute the features
Date: Fri, 29 Aug 2025 09:54:29 +0000
Message-ID: <20250829095430.443891-5-liuhangbin@gmail.com>
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

