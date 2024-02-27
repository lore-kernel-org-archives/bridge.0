Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016E13D541
	for <bridge@lists.linux.dev>; Tue, 27 Feb 2024 18:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709058444; cv=none; b=MbC3bcv1C4C0q4rlHSFHwPLOAsTVta7do0cP+G0vwAwdFvylNRbp66fAVo//pK+geJ1mL4QM8lGDDXV86iW2+3IItHvjNAA67H3GG9y4Aq389SAPNn76B+ers5GLwKrWGTIhYW9YbQOrhIZPZno2h8ZlwtXYl9ce6Ma0Pi8YNQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709058444; c=relaxed/simple;
	bh=uO+QAb9CNhOXbeAPWDtH2HJL7jsZQvvk4tKvYfP5lKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nZ7xqlX4BIc4QusGXBU4+x110W9PTwgnxYB+auGFADnl7KuUGLfB84+SApzwRmBuMu+1EP5n7MpO0L4QPBdNcRsaaxoONKUtfzRrcFkweEw1HGWDjstoY62PHNlgvVtHk74i3loagjl3/UvW+oEs5SR91WS8XIQhhTF0JIl9qHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5131316693cso1034644e87.0
        for <bridge@lists.linux.dev>; Tue, 27 Feb 2024 10:27:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709058440; x=1709663240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BYvzYko0Is+SAP/w3hqBwCLet2Nqsl8SFgKdmiGU1T4=;
        b=AftloKB5KE+vJGlbZVDAfJ+l3GjGQySnx9cRyjZTT11DZ9f2oOSkNUFceO7RBmhay8
         EYfBBZdDtBxy0UBqKULII0Elig4v+eQnnjC0MkqqafvZUuaw9OLLKvu97j9Q3+WrAi2z
         L75heHGcvjQbq9j3DwlfzsER8P2TS4rYdGOwKXHAzOo8joqXWBIGNNQSuSKUS8lSxqe6
         yWMy/C21s/cgnhu3vT8kMaE+R5pPSPiUjTGtFhUPl4O4U6v3GcY4CSC5eWKxZOqYCFkG
         1cN+HQIxUe8UcW7Dh65uyIMxUAH5j4zVm63HA83pRCHMzSMgICbZPx+UEtAq+We1/AP2
         osOg==
X-Forwarded-Encrypted: i=1; AJvYcCXcyiAB7VhYHAx8NyPm8w4jbL6L78xDVoUEEtu4aAjNjw5CVXS2QaugCW6wYiuKBPE+9ruSHv+KeyvtDx+hMBQ5oHclj53q
X-Gm-Message-State: AOJu0YyO9h4BVhpQ3pJXwOLgLzoGH1UxCx2oOmrxW6ihKW139YNnzHNH
	P/YRTQBzwcpQ4JhQGsipmmo2F9mz+9YyEnBQll5rf1qkSlHjyLEo
X-Google-Smtp-Source: AGHT+IEUwtTbXJECoVbN5asUL5J5WG/LHgYO68BFG1pCrUGnFaCZjVTJp4FqoJhJXBMYuqLO4LYYaA==
X-Received: by 2002:a05:6512:33d5:b0:512:fe39:5d0e with SMTP id d21-20020a05651233d500b00512fe395d0emr5433262lfg.9.1709058439803;
        Tue, 27 Feb 2024 10:27:19 -0800 (PST)
Received: from localhost (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id u11-20020aa7db8b000000b005653f390f77sm1001546edt.10.2024.02.27.10.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 10:27:19 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	bridge@lists.linux.dev (open list:ETHERNET BRIDGE)
Subject: [PATCH net-next 1/2] net: bridge: Do not allocate stats in the driver
Date: Tue, 27 Feb 2024 10:23:36 -0800
Message-ID: <20240227182338.2739884-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
convert veth & vrf"), stats allocation could be done on net core
instead of this driver.

With this new approach, the driver doesn't have to bother with error
handling (allocation failure checking, making sure free happens in the
right spot, etc). This is core responsibility now.

Remove the allocation in the bridge driver and leverage the network
core allocation.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/bridge/br_device.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 874cec75a818..4f636f7b0555 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -113,26 +113,18 @@ static int br_dev_init(struct net_device *dev)
 	struct net_bridge *br = netdev_priv(dev);
 	int err;
 
-	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
-	if (!dev->tstats)
-		return -ENOMEM;
-
 	err = br_fdb_hash_init(br);
-	if (err) {
-		free_percpu(dev->tstats);
+	if (err)
 		return err;
-	}
 
 	err = br_mdb_hash_init(br);
 	if (err) {
-		free_percpu(dev->tstats);
 		br_fdb_hash_fini(br);
 		return err;
 	}
 
 	err = br_vlan_init(br);
 	if (err) {
-		free_percpu(dev->tstats);
 		br_mdb_hash_fini(br);
 		br_fdb_hash_fini(br);
 		return err;
@@ -140,7 +132,6 @@ static int br_dev_init(struct net_device *dev)
 
 	err = br_multicast_init_stats(br);
 	if (err) {
-		free_percpu(dev->tstats);
 		br_vlan_flush(br);
 		br_mdb_hash_fini(br);
 		br_fdb_hash_fini(br);
@@ -159,7 +150,6 @@ static void br_dev_uninit(struct net_device *dev)
 	br_vlan_flush(br);
 	br_mdb_hash_fini(br);
 	br_fdb_hash_fini(br);
-	free_percpu(dev->tstats);
 }
 
 static int br_dev_open(struct net_device *dev)
@@ -496,6 +486,7 @@ void br_dev_setup(struct net_device *dev)
 	dev->hw_features = COMMON_FEATURES | NETIF_F_HW_VLAN_CTAG_TX |
 			   NETIF_F_HW_VLAN_STAG_TX;
 	dev->vlan_features = COMMON_FEATURES;
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 
 	br->dev = dev;
 	spin_lock_init(&br->lock);
-- 
2.43.0

