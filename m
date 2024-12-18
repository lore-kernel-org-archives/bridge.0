Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1020A1B0406
	for <bridge@lists.linux.dev>; Wed, 18 Dec 2024 13:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734527424; cv=none; b=fKqmF7eqQKn3OqLEW5QdJzq2q0CYzmnKc9EJ5YhtKZuAApZhyWNgXIQkieDrXdznew9v7MMcqSIQgbdfO7X2nlwEaVRQC+lnWTX46AuQm0cgu/sS4RPc9/P6Gwx/qFQY788IgR5HTzK9n/PkK7c2Qbdm1+aw7HMcX8OxPVK6Ino=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734527424; c=relaxed/simple;
	bh=FrNFlIgaLGZInVfg7c+Ua7z0X9F1i2NtBJYO15VwRj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pw4b+iPIiz4WQNPImdj8XgSzz+gPmXxSe9gNJ5N4VRZC/swLz504pnIRfjtUY0gJm+eR1mICaBAgqw5f72sLcc0s2bVL7ron55L1Gkep41OiKv7qN+34Oe+QBuYcjzWcqvbrz80uD5pNWNRuli46V87AAbpLLZ4A58jFD3Zn+G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kb1Q4RQD; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kb1Q4RQD"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-725ce7b82cbso7449326b3a.0
        for <bridge@lists.linux.dev>; Wed, 18 Dec 2024 05:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734527422; x=1735132222; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXH8tUP/h7NPxTwhkU8DrmHX10k3nPXxIbmClQOEn5A=;
        b=kb1Q4RQDQ1KNDYwNARW4PbtzD63dnkJ6xeowaxAEEs9bgEzti4Klpj7TvuKSBNAl5J
         McvaOfwHVEiUlaofdwruuWsMyqjiqCgpoAFR2MS82BUnEnXVPaihBaglnIa0LFA0KNl3
         D3FwSGh0gc6zd2gOPxhuk0+46COUycGTrnzrxvDGNieody8MlEWEmBZ/xvDUqMo9VC6V
         2sX5sdLgXpvWjT2DAyJ1TITuJ12nUwYNwapdNEXx4erZ2a/Bdrk/wAcs8r2HaFx2HU5k
         vUbNoByxzAUaCFsLCrHfdZfnhO/l1O788dKhacgzZLnuXcxZynDkW5uZ2KS73Ltacl0l
         wrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734527422; x=1735132222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXH8tUP/h7NPxTwhkU8DrmHX10k3nPXxIbmClQOEn5A=;
        b=lni/TnnntV7SWcPGH3sZj1suEseV4lVRsVaQqBQM1IC5T7Cg1EbuxfU2ND9dmlT2cn
         LqoJxCAumdMlzPWdYLZEnL3QqgOpLFZ56dZmUnClguYSteFZ8QKPwZZFEs3v3br/iYzG
         soaGp2Ak9nQm3TnQ+Ns0Pgls/5Yy2nyRjnlv2AWbvmXWsYTAUOwF6/cB+4u7BHF+n3Iv
         nxDuPrhq+LzI91/JGmr4xWNYolJgxjqP35r4fXi0zYHiiRE2PEVnWcMX+KJRVoBP1Ik/
         jA8To/j/tPJQvTy/kDc6h88Hq86T/UPLjoyANk4eey+QsRfWb6vcJyyYw0mM9K/yvecX
         Z8uQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8GBQusd8+4OeVhRyv3B4F1OMyk70uwHGyJ2ixSdQGXQW3qW37B5yJmUL2jfrkPdzOeKWwNRM=@lists.linux.dev
X-Gm-Message-State: AOJu0YzfzkRXECls/XyyCAo1EILF7J9pm0reNMYlKK7CS0pjgxAS/uHn
	tg6YyjdNVUGcfGJ6GWML+Cxlzvh0Br8AlABcpigYGJiFhdnshn5J
X-Gm-Gg: ASbGncukCNZPiyRoG7hV/1LNlBZsP9jniZ+iwy/89dnbc93mkdFnheggqBF6ltErHpC
	3NaNJ12UVUnTzAASoICFdZrntlyT+o5zOohTeTXNEVeT8nn+zG1EeFAsUeB6R8napGiVFayERN9
	CtGX0s20XHlm9UMqSCaMNqnwWC9A8C+r81lF4Mdu4XTxXjUV/CApgJ4sBF6WIwAWK7u3m/We+Xd
	rhZsh6f7VzxUR7AiMaXkO4+huDpTIK4llIjYQ9VIZUM7Sg=
X-Google-Smtp-Source: AGHT+IGLrMJpewCg9a6Mvczs3iBMMwjIWUW57/cgClFku2ou3JPxqZ6yK8d+Q9sS8i4XncDR+dfRig==
X-Received: by 2002:a05:6a20:12c6:b0:1e1:bee3:50ea with SMTP id adf61e73a8af0-1e5b47f94bcmr5116348637.11.1734527422239;
        Wed, 18 Dec 2024 05:10:22 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5c0f59asm7434754a12.67.2024.12.18.05.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 05:10:21 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Hangbin Liu <liuhangbin@gmail.com>,
	linux-rdma@vger.kernel.org,
	linux-can@vger.kernel.org,
	osmocom-net-gprs@lists.osmocom.org,
	bpf@vger.kernel.org,
	linux-ppp@vger.kernel.org,
	wireguard@lists.zx2c4.com,
	linux-wireless@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	bridge@lists.linux.dev,
	linux-wpan@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 07/11] net: xfrm: Use link netns in newlink() of rtnl_link_ops
Date: Wed, 18 Dec 2024 21:09:05 +0800
Message-ID: <20241218130909.2173-8-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218130909.2173-1-shaw.leon@gmail.com>
References: <20241218130909.2173-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When link_net is set, use it as link netns instead of dev_net(). This
prepares for rtnetlink core to create device in target netns directly,
in which case the two namespaces may be different.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/xfrm/xfrm_interface_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 77d50d4af4a1..d1198c63dd23 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -242,10 +242,9 @@ static void xfrmi_dev_free(struct net_device *dev)
 	gro_cells_destroy(&xi->gro_cells);
 }
 
-static int xfrmi_create(struct net_device *dev)
+static int xfrmi_create(struct net *net, struct net_device *dev)
 {
 	struct xfrm_if *xi = netdev_priv(dev);
-	struct net *net = dev_net(dev);
 	struct xfrmi_net *xfrmn = net_generic(net, xfrmi_net_id);
 	int err;
 
@@ -819,11 +818,12 @@ static int xfrmi_newlink(struct rtnl_newlink_params *params)
 	struct netlink_ext_ack *extack = params->extack;
 	struct net_device *dev = params->dev;
 	struct nlattr **data = params->data;
-	struct net *net = dev_net(dev);
 	struct xfrm_if_parms p = {};
 	struct xfrm_if *xi;
+	struct net *net;
 	int err;
 
+	net = params->link_net ? : dev_net(dev);
 	xfrmi_netlink_parms(data, &p);
 	if (p.collect_md) {
 		struct xfrmi_net *xfrmn = net_generic(net, xfrmi_net_id);
@@ -852,7 +852,7 @@ static int xfrmi_newlink(struct rtnl_newlink_params *params)
 	xi->net = net;
 	xi->dev = dev;
 
-	err = xfrmi_create(dev);
+	err = xfrmi_create(net, dev);
 	return err;
 }
 
-- 
2.47.1

