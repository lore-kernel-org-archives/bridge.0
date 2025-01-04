Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15E81C5F00
	for <bridge@lists.linux.dev>; Sat,  4 Jan 2025 12:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735995519; cv=none; b=Dz4r6LFlHpVqYISAJTKZa74+aeQHna6YlQGl/r83VnpB+tyD35ECCc0qm9TYppPVpmjM0B8WXW4uQAwGTeONOEt8xL899kRvDYFzKcMAJHSfpnqjcPk4lY8FoCNtQmseDHzRGL5KbXPFtFN83gFJAXBxkRpyu70c3a44hGVsnJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735995519; c=relaxed/simple;
	bh=ExcFFASRL0JOBX+JRaYP5UZ03RNRSWOI8Fw5iiUDoBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=riC6MwUrFXTqnRZF8aEZcqnFVfVrdLxsR1pUvz4a0BLb/7E3a2rZ4Y693RjHrisO6jxiOrX1wrpztiKlRtyGndtFpiKgj5re9AMmnhYaAK2VZh6t8RTYsm3M8/h07HR+Du0eGuElnrmURAUjFAPO2WbT3Vn5TLTuMOiP5k22opE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqSY3Er1; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqSY3Er1"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2162c0f6a39so191017095ad.0
        for <bridge@lists.linux.dev>; Sat, 04 Jan 2025 04:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735995515; x=1736600315; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGKuR9iwJLKB00bK/9yuK8uQjR1STrnypDr+9jM2ZjQ=;
        b=KqSY3Er1BVJ7aO3/eSDlBFB5Y0f01CWpQRnFC9TROw7ygbYG34PvHWoUJu/g6kA2u2
         bSsjyupCe10yvymT/2y1iphjJaHptcxPcI209rSpl4mAqhk65jzvW6gnn8IOIkl7Pusc
         cjjOHfWzswCkwVoVwxolpdCx1U3YdLr/hD5eddTz7yzPkTBP7ZemA5fXx7pIf3eV40zv
         FTGOuWIfWzueE/UP4iY3cgEu8YG0xkCiI5ROwldOoK7kRWTqGY1fZ9Mo67YkDUzADu1h
         sD4PObAS31prPx0EVl1lJySQLnNW+lXyhcjI1i1H/bLLc5RBH2b5toxl/I5ssh94mM/Q
         V0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735995515; x=1736600315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGKuR9iwJLKB00bK/9yuK8uQjR1STrnypDr+9jM2ZjQ=;
        b=NHE/XXxCCB0y6f/kKPnX1JGs6U1ZBmAvOPY/sMZ8uuSXLENSgfI9OQ6xF/EoD2twpV
         JoxLNiKpaWAHWzToM4RzJ7xHn8Kdd7S6u6uGthE4sS49kuhe0QsEAQWhOMjL04amESmr
         LgDZBcMyviflIphy4QNQa2HCg+dkzO9hpyWrzo9kOL1EYgH88Dez+d4wXn+W488XMBhA
         qmkti0wdfvcAcBc0tPZsBZNYcSX1l6mh01tTFebUqeFsJuLQl73NbGmpGYuMNZ4x+KNn
         yJE4JJ72UlJCcf7s4BPEUG7QYx6rDyGrym3wMsCy3axlqJtlv50Bf1x+HR2gQ11u/CFs
         UebA==
X-Forwarded-Encrypted: i=1; AJvYcCWdZGGECakM+ZNFbEZbz26kA/ClYs3NcotojUAjm2W3YP1/jQspVI2KtPHTAZhtXxmWdbJ96AQ=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2v9b6HdVRv/jDTLdY0HZFCNhwb7pNplHiTXj0JRcXhYkYhORL
	JzrOEMrBk9/+Pin7lhKp95POBGuuDBMBFRykinATGeas+8ncJYx3
X-Gm-Gg: ASbGncus6MHS8McAV3pq870Zg6olhIx8uAVJ1AihEuyjsHW1ggHgMABPiYZtwCJLTJe
	7sZtM02o9MTpXqgObwHmGxXkz0MqkqMiNPorjyTy9Jdv2Q3z7DhF8/23rxFkU3VL1kwOg7vIqph
	Vyihjq19Vo1MxnG7dqb1QwSY+ovdGP/kbML9wGX+alcbutupZ1aDXQwj6fVV6AtjhJvwZtDJoGV
	dfpPCEvP1PNUAo9oCOCP/BYS6QQzSSfvpBbWwjWZtQhJhE=
X-Google-Smtp-Source: AGHT+IGjBqn10MmdRu4jxYpKUCQXpYCqN1FLgpb8zvJWMn+lBROruosGrc2xG5POheEXQ3wHAgMJ2g==
X-Received: by 2002:a05:6a21:648c:b0:1e2:2e4:6893 with SMTP id adf61e73a8af0-1e5e1e2979bmr85664871637.9.1735995515041;
        Sat, 04 Jan 2025 04:58:35 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad830349sm27761344b3a.47.2025.01.04.04.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 04:58:34 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
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
Subject: [PATCH net-next v7 06/11] net: ipv6: Use link netns in newlink() of rtnl_link_ops
Date: Sat,  4 Jan 2025 20:57:27 +0800
Message-ID: <20250104125732.17335-7-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250104125732.17335-1-shaw.leon@gmail.com>
References: <20250104125732.17335-1-shaw.leon@gmail.com>
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

Set correct netns in priv before registering device, and avoid
overwriting it in ndo_init() path.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/ipv6/ip6_gre.c    | 22 ++++++++++++----------
 net/ipv6/ip6_tunnel.c | 13 ++++++++-----
 net/ipv6/ip6_vti.c    | 10 ++++++----
 net/ipv6/sit.c        | 11 +++++++----
 4 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 3efd51f0d7d2..1d47c229068d 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1498,7 +1498,8 @@ static int ip6gre_tunnel_init_common(struct net_device *dev)
 	tunnel = netdev_priv(dev);
 
 	tunnel->dev = dev;
-	tunnel->net = dev_net(dev);
+	if (!tunnel->net)
+		tunnel->net = dev_net(dev);
 	strcpy(tunnel->parms.name, dev->name);
 
 	ret = dst_cache_init(&tunnel->dst_cache, GFP_KERNEL);
@@ -1882,7 +1883,8 @@ static int ip6erspan_tap_init(struct net_device *dev)
 	tunnel = netdev_priv(dev);
 
 	tunnel->dev = dev;
-	tunnel->net = dev_net(dev);
+	if (!tunnel->net)
+		tunnel->net = dev_net(dev);
 	strcpy(tunnel->parms.name, dev->name);
 
 	ret = dst_cache_init(&tunnel->dst_cache, GFP_KERNEL);
@@ -1971,7 +1973,7 @@ static bool ip6gre_netlink_encap_parms(struct nlattr *data[],
 	return ret;
 }
 
-static int ip6gre_newlink_common(struct net *src_net, struct net_device *dev,
+static int ip6gre_newlink_common(struct net *link_net, struct net_device *dev,
 				 struct nlattr *tb[], struct nlattr *data[],
 				 struct netlink_ext_ack *extack)
 {
@@ -1992,7 +1994,7 @@ static int ip6gre_newlink_common(struct net *src_net, struct net_device *dev,
 		eth_hw_addr_random(dev);
 
 	nt->dev = dev;
-	nt->net = dev_net(dev);
+	nt->net = link_net;
 
 	err = register_netdevice(dev);
 	if (err)
@@ -2010,13 +2012,13 @@ static int ip6gre_newlink(struct rtnl_newlink_params *params)
 	struct netlink_ext_ack *extack = params->extack;
 	struct net_device *dev = params->dev;
 	struct nlattr **data = params->data;
-	struct net *src_net = params->net;
 	struct nlattr **tb = params->tb;
-	struct net *net = dev_net(dev);
 	struct ip6gre_net *ign;
 	struct ip6_tnl *nt;
+	struct net *net;
 	int err;
 
+	net = params->link_net ? : dev_net(dev);
 	nt = netdev_priv(dev);
 	ip6gre_netlink_parms(data, &nt->parms);
 	ign = net_generic(net, ip6gre_net_id);
@@ -2029,7 +2031,7 @@ static int ip6gre_newlink(struct rtnl_newlink_params *params)
 			return -EEXIST;
 	}
 
-	err = ip6gre_newlink_common(src_net, dev, tb, data, extack);
+	err = ip6gre_newlink_common(net, dev, tb, data, extack);
 	if (!err) {
 		ip6gre_tnl_link_config(nt, !tb[IFLA_MTU]);
 		ip6gre_tunnel_link_md(ign, nt);
@@ -2250,13 +2252,13 @@ static int ip6erspan_newlink(struct rtnl_newlink_params *params)
 	struct netlink_ext_ack *extack = params->extack;
 	struct net_device *dev = params->dev;
 	struct nlattr **data = params->data;
-	struct net *src_net = params->net;
 	struct nlattr **tb = params->tb;
-	struct net *net = dev_net(dev);
 	struct ip6gre_net *ign;
 	struct ip6_tnl *nt;
+	struct net *net;
 	int err;
 
+	net = params->link_net ? : dev_net(dev);
 	nt = netdev_priv(dev);
 	ip6gre_netlink_parms(data, &nt->parms);
 	ip6erspan_set_version(data, &nt->parms);
@@ -2270,7 +2272,7 @@ static int ip6erspan_newlink(struct rtnl_newlink_params *params)
 			return -EEXIST;
 	}
 
-	err = ip6gre_newlink_common(src_net, dev, tb, data, extack);
+	err = ip6gre_newlink_common(net, dev, tb, data, extack);
 	if (!err) {
 		ip6erspan_tnl_link_config(nt, !tb[IFLA_MTU]);
 		ip6erspan_tunnel_link_md(ign, nt);
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index f4bdbabc3246..cb09cc878dee 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -253,8 +253,7 @@ static void ip6_dev_free(struct net_device *dev)
 static int ip6_tnl_create2(struct net_device *dev)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
-	struct net *net = dev_net(dev);
-	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
+	struct ip6_tnl_net *ip6n = net_generic(t->net, ip6_tnl_net_id);
 	int err;
 
 	dev->rtnl_link_ops = &ip6_link_ops;
@@ -1878,7 +1877,8 @@ ip6_tnl_dev_init_gen(struct net_device *dev)
 	int t_hlen;
 
 	t->dev = dev;
-	t->net = dev_net(dev);
+	if (!t->net)
+		t->net = dev_net(dev);
 
 	ret = dst_cache_init(&t->dst_cache, GFP_KERNEL);
 	if (ret)
@@ -2007,13 +2007,16 @@ static int ip6_tnl_newlink(struct rtnl_newlink_params *params)
 	struct net_device *dev = params->dev;
 	struct nlattr **data = params->data;
 	struct nlattr **tb = params->tb;
-	struct net *net = dev_net(dev);
-	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
 	struct ip_tunnel_encap ipencap;
+	struct ip6_tnl_net *ip6n;
 	struct ip6_tnl *nt, *t;
+	struct net *net;
 	int err;
 
+	net = params->link_net ? : dev_net(dev);
+	ip6n = net_generic(net, ip6_tnl_net_id);
 	nt = netdev_priv(dev);
+	nt->net = net;
 
 	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		err = ip6_tnl_encap_setup(nt, &ipencap);
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 79e601e629d2..a3108a7464c7 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -177,8 +177,7 @@ vti6_tnl_unlink(struct vti6_net *ip6n, struct ip6_tnl *t)
 static int vti6_tnl_create2(struct net_device *dev)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
-	struct net *net = dev_net(dev);
-	struct vti6_net *ip6n = net_generic(net, vti6_net_id);
+	struct vti6_net *ip6n = net_generic(t->net, vti6_net_id);
 	int err;
 
 	dev->rtnl_link_ops = &vti6_link_ops;
@@ -925,7 +924,8 @@ static inline int vti6_dev_init_gen(struct net_device *dev)
 	struct ip6_tnl *t = netdev_priv(dev);
 
 	t->dev = dev;
-	t->net = dev_net(dev);
+	if (!t->net)
+		t->net = dev_net(dev);
 	netdev_hold(dev, &t->dev_tracker, GFP_KERNEL);
 	netdev_lockdep_set_classes(dev);
 	return 0;
@@ -1001,13 +1001,15 @@ static int vti6_newlink(struct rtnl_newlink_params *params)
 {
 	struct net_device *dev = params->dev;
 	struct nlattr **data = params->data;
-	struct net *net = dev_net(dev);
 	struct ip6_tnl *nt;
+	struct net *net;
 
+	net = params->link_net ? : dev_net(dev);
 	nt = netdev_priv(dev);
 	vti6_netlink_parms(data, &nt->parms);
 
 	nt->parms.proto = IPPROTO_IPV6;
+	nt->net = net;
 
 	if (vti6_locate(net, &nt->parms, 0))
 		return -EEXIST;
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 4dd1309d1eb3..8888fc51fa0b 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -201,8 +201,7 @@ static void ipip6_tunnel_clone_6rd(struct net_device *dev, struct sit_net *sitn)
 static int ipip6_tunnel_create(struct net_device *dev)
 {
 	struct ip_tunnel *t = netdev_priv(dev);
-	struct net *net = dev_net(dev);
-	struct sit_net *sitn = net_generic(net, sit_net_id);
+	struct sit_net *sitn = net_generic(t->net, sit_net_id);
 	int err;
 
 	__dev_addr_set(dev, &t->parms.iph.saddr, 4);
@@ -270,6 +269,7 @@ static struct ip_tunnel *ipip6_tunnel_locate(struct net *net,
 	nt = netdev_priv(dev);
 
 	nt->parms = *parms;
+	nt->net = net;
 	if (ipip6_tunnel_create(dev) < 0)
 		goto failed_free;
 
@@ -1449,7 +1449,8 @@ static int ipip6_tunnel_init(struct net_device *dev)
 	int err;
 
 	tunnel->dev = dev;
-	tunnel->net = dev_net(dev);
+	if (!tunnel->net)
+		tunnel->net = dev_net(dev);
 	strcpy(tunnel->parms.name, dev->name);
 
 	ipip6_tunnel_bind_dev(dev);
@@ -1555,15 +1556,17 @@ static int ipip6_newlink(struct rtnl_newlink_params *params)
 	struct net_device *dev = params->dev;
 	struct nlattr **data = params->data;
 	struct nlattr **tb = params->tb;
-	struct net *net = dev_net(dev);
 	struct ip_tunnel *nt;
 	struct ip_tunnel_encap ipencap;
 #ifdef CONFIG_IPV6_SIT_6RD
 	struct ip_tunnel_6rd ip6rd;
 #endif
+	struct net *net;
 	int err;
 
+	net = params->link_net ? : dev_net(dev);
 	nt = netdev_priv(dev);
+	nt->net = net;
 
 	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		err = ip_tunnel_encap_setup(nt, &ipencap);
-- 
2.47.1

