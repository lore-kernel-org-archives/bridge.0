Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC72A3254B8
	for <bridge@lists.linux.dev>; Thu, 16 Oct 2025 03:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760585950; cv=none; b=T4kOWXkM2KmwP7I51xtPF9yisu5gXfTdN5PcmLLy+hOe+PEBvvILjJxvg8eYr3JN4J30h7MhlveUCBUx9Y3bQF1fVNihovWBb5bisfoTC8BWQ+fL7oykKmzuwEpLXjV4jtLU/lrKuYEpIOQYeHXZCYwmvsuOEBbCFABCuYasazw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760585950; c=relaxed/simple;
	bh=wo1CsYkCWbyeO4hgQ/K47IoOTbuwdmMdH8TM1+uW2KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYdTDFZj4AjbDheMhFS09evQR5XHYR7ZHMKL62zxrc3nNq8bB9D9t139eKyAt40uAxU2+v6pMWsH6wTxC9jIlNpx1XkWi3ki2QoEYJqHQDeof5F46HteMRmj+U24dIg3u6v+aKVxTebWBJYGADfeX0gRqGH6E8kHv7MJBnKRZMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alJ37QZu; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alJ37QZu"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b5507d3ccd8so190527a12.0
        for <bridge@lists.linux.dev>; Wed, 15 Oct 2025 20:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760585948; x=1761190748; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5qn0NKgdBQyC0oF4Dkj2L47WgHW7PlWvIyIP1l643A=;
        b=alJ37QZupgER/eSQQWLotgeO2an3oIeugxHh9tjaZXtAcd8txkTY0Accu2gjMbTYWT
         8nxl4L8hCP9/ZuYHOvS3ADZI0565UXNCNIrxqt5kxHriPFADxr8D2GE4XBuxJDvmR4m/
         fRiTemP9BkiRWFN0NruXLt4K4+YdtXdAwNCvghxyKSgQSlvD96OEMIqZS+37rMl22RI3
         eXI3GRCv3WbrORV/oqrEKg1H5Jy94hXHUSGvPcJi+Ri9fpl66Gehbe9V8niesTqhDjaO
         KVV76ljN6yvxzRsY+sup4h48+P93kCuuewYa+jDScIUFt2HMOggQ+lqvyYb0jVsoCN3m
         0zCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760585948; x=1761190748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5qn0NKgdBQyC0oF4Dkj2L47WgHW7PlWvIyIP1l643A=;
        b=lm23eaz6I5Rsuv1OsTEjbTuIAfmPElZnvxMMl2FvGrYyEVgsClKjeZ4BVtoeAQmfWp
         PF2OMGHoBCUqIwp3R2Z9GhOgoAqxevVSs+xQ3kIZ0mmdiTrcr8m9GvXh4iVIU/1COGFp
         GVU4gLh+GDU/pqPIpg8WvKJ3GCTqyIORQ/nFIoVoiAHSw3PWjwc5IA1bONu7gzjmjQWp
         TPMG8daMBMiBYNkOPtA9zk+/e07oDJgbm0bAczHWTdHtcAGSNabFd6GjAG8NUMQsogR1
         dXfhcJ65815r+XRWOew3dfTYlFRX+yx5diTEi25FbgfOGuZSU2L+RlAtjMv5sGEKxJgP
         Pa3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgNx9oaOjO82f2SvR/TGKtZUzWZNWVaxM7JZgu9wk7y2IwCz04F7QyasmggLoog22zyZxcqWA=@lists.linux.dev
X-Gm-Message-State: AOJu0YxkDE13S8kFisz4PtzVWJvC6AUbP5RG+lSDpPMnjKH3pf4VH/Xo
	67hfFUd4PCa8w2Xe+R8SXpnaDFffVoVgZZ7yZqg55dpnd+Rw6ylI4sOO
X-Gm-Gg: ASbGncuDQkdByVrOdTReprC6T/Iq6Ailb4UD05nzFCRiJ0qDAuv6ta2Jruu9zM47eiR
	/oJNsevYgGBtCl+cw3fKcEXZRw7w+PdILUOk8MteSS+Neu7z+4Cl9aYSGXgmLt/EsaZUJzN4eUe
	lff3HDiCaCQGK6fURDvmJM11GiFzXTgesr3h0T1IZ6KirP4w2yj5ZB9S+p//C3RMeYumgRMueQ8
	737OVmH1eS5NmWRNRCB5PMOitmTBxOU6FJFV3yfOqWc6WC3IFCNeDBMmXC/pF7FPzpGbdP5SNk+
	w6yVvMfmuMMHOYGGZeSm0I159hrjAkMNPiHMP9HKd3IHWqx+LatWLeMlyooL1PIrmwZRQKQAWHe
	wRv6fF0/2PhK3uXOqIoVtl3vMbhFhmo537PM7rwfZpuimu6twM4VdCRydeLa3aisrvcHifaAYCu
	JPaRmBGgKocVBGbts=
X-Google-Smtp-Source: AGHT+IFKwnVYCQ5pyoFx/pbr/4gDxtu2w11uLKogeVEWfYNG0tYvyVVkDAvxXSpbzkW7Ox2gRIOwlw==
X-Received: by 2002:a17:903:2345:b0:24c:da3b:7376 with SMTP id d9443c01a7336-2902726438amr437036485ad.26.1760585948104;
        Wed, 15 Oct 2025 20:39:08 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099343065sm12507925ad.26.2025.10.15.20.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 20:39:07 -0700 (PDT)
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
Subject: [PATCHv5 net-next 4/4] net: bridge: use common function to compute the features
Date: Thu, 16 Oct 2025 03:38:28 +0000
Message-ID: <20251016033828.59324-5-liuhangbin@gmail.com>
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

Previously, bridge ignored all features propagation and DST retention,
only handling explicitly the GSO limits.

By switching to the new helper netdev_compute_upper_features(), the bridge
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
index 98c5b9c3145f..0742bd0eaf53 100644
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
+	netdev_compute_upper_features(br->dev, false);
 
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
+	netdev_compute_upper_features(br->dev, false);
 
 	return 0;
 }
-- 
2.50.1

