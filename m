Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95811E8328
	for <bridge@lists.linux.dev>; Wed, 19 Feb 2025 12:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969519; cv=none; b=WefsOrYDyUpRSfB/pgnuGXnschrfs5dl7MUCxCb73OJ852NdkJnjgxDCBR18O6us9an+YjjEOxLOwJbAAJA740bsTg05zrurAzrJXb/y1yo0dxX2Pa1A+4t7HAWxKfCDPTz+U3Q7KPV6+GRin0G9F2vgHf0WNnlGdE+wkPjTzYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969519; c=relaxed/simple;
	bh=VA66gTa0Qj/pMCkEuKNn0qYWFCRGp3U7y68sKrY8e1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FHdin1WUg6O/6b7gSmsbkX7J+CuFHfghnn0VzAShbko7ZckKQZkMwUV9ud1ffJ89UIktfRMhdQVZoP2OKEg3GX1wsBr9iQY3qTfTdkJAcOcMvtu0uZldSCGZGu42VkKyPjYZdmd78EnwmRZllWhvwyrQ54eNjNZkvRgCk+Sp2DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EL7kutpm; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EL7kutpm"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2211acda7f6so77947185ad.3
        for <bridge@lists.linux.dev>; Wed, 19 Feb 2025 04:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969517; x=1740574317; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6bozwwxLUJNxVW5ZYXuCA298+o6a+m5Om77EOnyIyg=;
        b=EL7kutpmmvxOTl4UbQaGagSDL/wQYCNW49RI7mPNJNPzHDkZuKPXXPmAYNKsO3GLvQ
         I6zMzbnyoqGm5cccAq4hBkCWpalw9WFXOQtJyFiE4MyxpDeBE9FPO3RWBcnksJn/8tOR
         TlPrs9oOGcxLRIbUZ6viUG465nzRZQ6ssKXdmDntcJ2UW0TfOT+NetUlEt/ohoiRMC9r
         EA8y1HQaxHrMvqQWP9TaLBRqi8PK8s2FLpYC5r15Gi6IRvnNRJHKvx23TEW1sgucUTzV
         WiAuWEhi0NNr7zzwAIOP8sK7rOJeg8n2PqrSnqSSICvF+/kaYXWpeLTu8LG9DtaeXj5Y
         uOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969517; x=1740574317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B6bozwwxLUJNxVW5ZYXuCA298+o6a+m5Om77EOnyIyg=;
        b=wEc/w8e7kiICg2nzxjsPcPqDGtDHTUe2UkujJKC4Ma3rtaB0uNEX3FV18ORoHcjdTQ
         qwFc2XsP7SvMqUwSBQpw0Dw+o1PI2ngM4BPz14sOOFaZfN5cK/Giyg1eAb5NDFECUUwc
         /1Qgsn3n8sPyaDaaR1UHPIwZTJwIy2J9dL7XULyggMQcLxmfIP5Grm1XYq5Pjamtxwpj
         8BiVRUQWRH8KrXaFZeEzvl1fjvTdAky2JIHjMnAo12WD4mKOnT22b0ZoU/wX5DWNIzjZ
         2Dr09sWwdC5B4nyyDf1idYrhit+D8Oz/vshvUagCBIuJNjbYRcz/6f3dtuLEZ68FD0fw
         XQfw==
X-Forwarded-Encrypted: i=1; AJvYcCVRa58wbjcLwvJD7fd6W2DSti8ZjZcN/IchPNVB9M9IunNswZNebBqxx92Kcfo6DSxPgZuuYLQ=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx9lPUeUphwgdlGRCzF31Czmt5sOT2TJd/bNmbPao0oc7Emr2QJ
	C8Ys1p292FYkHnDcbIb8a1ebsCXSMBSJGxikm+gKaZhay9Vo4j0+
X-Gm-Gg: ASbGnctaLURQDm/iz2VctvEL/hEWoGbQkPTkneX1AUUMaX67ilLgggWaCcn03lr98GK
	DnUMuNceFIFyhZW//hQObRssfZECesn590qNL3RdyCHclBFlaQSi1QYvpYjLXqrQ7sZ06u9Lg/J
	J/USWv6NacHesWpdLuA/XPrXGprhuzagEO1zwtLJpNTEKoH+O0sLqpoCnE63ZHFVSLgoHsa2B1L
	ktp8XlZ9ky0DFf2MzlfupH2dwZSam8gx5tfdbXvkaCXqwIqnQVR0Hr5c49VkLDXBhfH2ebpa6FD
	DErbrg==
X-Google-Smtp-Source: AGHT+IGKxW3/SlkXIFQ/R+7OZM2jJGBrIehyvby3inig7425vAO11UDlInuUnZBsT6heGdokKuXecQ==
X-Received: by 2002:a17:903:2305:b0:220:fce7:d3b8 with SMTP id d9443c01a7336-221709654admr66486875ad.12.1739969517203;
        Wed, 19 Feb 2025 04:51:57 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536436fsm103427175ad.64.2025.02.19.04.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:51:56 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
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
Subject: [PATCH net-next v10 07/13] net: ipv6: Init tunnel link-netns before registering dev
Date: Wed, 19 Feb 2025 20:50:33 +0800
Message-ID: <20250219125039.18024-8-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219125039.18024-1-shaw.leon@gmail.com>
References: <20250219125039.18024-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently some IPv6 tunnel drivers set tnl->net to dev_net(dev) in
ndo_init(), which is called in register_netdevice(). However, it lacks
the context of link-netns when we enable cross-net tunnels at device
registration time.

Let's move the init of tunnel link-netns before register_netdevice().

ip6_gre has already initialized netns, so just remove the redundant
assignment.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/ipv6/ip6_gre.c    | 2 --
 net/ipv6/ip6_tunnel.c | 3 ++-
 net/ipv6/ip6_vti.c    | 3 ++-
 net/ipv6/sit.c        | 8 +++++---
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 863852abe8ea..d9e6b1fd9917 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1498,7 +1498,6 @@ static int ip6gre_tunnel_init_common(struct net_device *dev)
 	tunnel = netdev_priv(dev);
 
 	tunnel->dev = dev;
-	tunnel->net = dev_net(dev);
 	strcpy(tunnel->parms.name, dev->name);
 
 	ret = dst_cache_init(&tunnel->dst_cache, GFP_KERNEL);
@@ -1882,7 +1881,6 @@ static int ip6erspan_tap_init(struct net_device *dev)
 	tunnel = netdev_priv(dev);
 
 	tunnel->dev = dev;
-	tunnel->net = dev_net(dev);
 	strcpy(tunnel->parms.name, dev->name);
 
 	ret = dst_cache_init(&tunnel->dst_cache, GFP_KERNEL);
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 54b843d20870..111a8777c2f7 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1878,7 +1878,6 @@ ip6_tnl_dev_init_gen(struct net_device *dev)
 	int t_hlen;
 
 	t->dev = dev;
-	t->net = dev_net(dev);
 
 	ret = dst_cache_init(&t->dst_cache, GFP_KERNEL);
 	if (ret)
@@ -1940,6 +1939,7 @@ static int __net_init ip6_fb_tnl_dev_init(struct net_device *dev)
 	struct net *net = dev_net(dev);
 	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
 
+	t->net = net;
 	t->parms.proto = IPPROTO_IPV6;
 
 	rcu_assign_pointer(ip6n->tnls_wc[0], t);
@@ -2015,6 +2015,7 @@ static int ip6_tnl_newlink(struct net_device *dev,
 	int err;
 
 	nt = netdev_priv(dev);
+	nt->net = net;
 
 	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		err = ip6_tnl_encap_setup(nt, &ipencap);
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 993f85aeb882..16e0d74f99dd 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -925,7 +925,6 @@ static inline int vti6_dev_init_gen(struct net_device *dev)
 	struct ip6_tnl *t = netdev_priv(dev);
 
 	t->dev = dev;
-	t->net = dev_net(dev);
 	netdev_hold(dev, &t->dev_tracker, GFP_KERNEL);
 	netdev_lockdep_set_classes(dev);
 	return 0;
@@ -958,6 +957,7 @@ static int __net_init vti6_fb_tnl_dev_init(struct net_device *dev)
 	struct net *net = dev_net(dev);
 	struct vti6_net *ip6n = net_generic(net, vti6_net_id);
 
+	t->net = net;
 	t->parms.proto = IPPROTO_IPV6;
 
 	rcu_assign_pointer(ip6n->tnls_wc[0], t);
@@ -1009,6 +1009,7 @@ static int vti6_newlink(struct net_device *dev,
 	vti6_netlink_parms(data, &nt->parms);
 
 	nt->parms.proto = IPPROTO_IPV6;
+	nt->net = net;
 
 	if (vti6_locate(net, &nt->parms, 0))
 		return -EEXIST;
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index e2bd52cabdee..20453671ac50 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -269,6 +269,7 @@ static struct ip_tunnel *ipip6_tunnel_locate(struct net *net,
 
 	nt = netdev_priv(dev);
 
+	nt->net = net;
 	nt->parms = *parms;
 	if (ipip6_tunnel_create(dev) < 0)
 		goto failed_free;
@@ -1449,7 +1450,6 @@ static int ipip6_tunnel_init(struct net_device *dev)
 	int err;
 
 	tunnel->dev = dev;
-	tunnel->net = dev_net(dev);
 	strcpy(tunnel->parms.name, dev->name);
 
 	ipip6_tunnel_bind_dev(dev);
@@ -1565,6 +1565,7 @@ static int ipip6_newlink(struct net_device *dev,
 	int err;
 
 	nt = netdev_priv(dev);
+	nt->net = net;
 
 	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		err = ip_tunnel_encap_setup(nt, &ipencap);
@@ -1860,6 +1861,9 @@ static int __net_init sit_init_net(struct net *net)
 	 */
 	sitn->fb_tunnel_dev->netns_local = true;
 
+	t = netdev_priv(sitn->fb_tunnel_dev);
+	t->net = net;
+
 	err = register_netdev(sitn->fb_tunnel_dev);
 	if (err)
 		goto err_reg_dev;
@@ -1867,8 +1871,6 @@ static int __net_init sit_init_net(struct net *net)
 	ipip6_tunnel_clone_6rd(sitn->fb_tunnel_dev, sitn);
 	ipip6_fb_tunnel_init(sitn->fb_tunnel_dev);
 
-	t = netdev_priv(sitn->fb_tunnel_dev);
-
 	strcpy(t->parms.name, sitn->fb_tunnel_dev->name);
 	return 0;
 
-- 
2.48.1

