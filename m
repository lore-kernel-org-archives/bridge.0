Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93B2145346
	for <bridge@lists.linux.dev>; Sat,  4 Jan 2025 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735995511; cv=none; b=Deye5AZZ5XMKw4AmknRjll6aTTUX5WsL8yGWD1F9QejCD2TLdcsu7GApl5TGcEnWI0ej9qqkYfn3HhuJ/3COHULdotoxqXx5EkeUGL+3frZm1rWRv/DYK5PvyVg527yQ6U2pH5j+NrKXgswRnmiNnpvPYc0x+OvGlKJd2Vvp308=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735995511; c=relaxed/simple;
	bh=od0hp3ObXVcrAjwD63XqEg9Dqr5Go4qWpS5DUQq9mKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4YsnhpyMXAGgmk8EfWnwlgJNN1iRdank/aSDfO8f+AvB8bGjgzBPTHgieJILQZh4bRKwYu542JpeA6MvuIa9IPwXhRQoXcp4rPE+gkvLLAngNbm97s4Rtf++4iLpvVyQpZC8YchtddITxZXFZlWb3eEgAu13RLoSKMQeL2nAdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeK86Y4y; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeK86Y4y"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21649a7bcdcso178341895ad.1
        for <bridge@lists.linux.dev>; Sat, 04 Jan 2025 04:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735995507; x=1736600307; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCmZExhyz7cb3bxHLdfAhcPoFeVCTtasFkXOWH4Z1YU=;
        b=jeK86Y4yy3uNKNvAGXpVSG5PBqp4/OD5gNXi3PeE51kVsP7HMHLuuX7Ko2jMS792+5
         Tb8cI6AzlyBLUbwZqA0BkmQPc1j7U4BKMTPF0KN0ex5mYAgHLLSFQ9SEOw9nd5qylJTb
         idc3YLcPTfCcgUZsX4Ni1mskgA2kPhvpXPiL5fX9BmXLrQKTE5PJ+cfwnjDwgieQaiqZ
         UnL12AV6ES8cO88Mqu13sJPiwhxVeN57JKmuF85CbwihhOx/dVUzierQyuwKHauBMdsL
         a5lXn3nxEIXQtAoNsijw7NKpqxF8Sbg7lyTI4TH0/n3P/znWu47Al1RdrJoy3Hu46Jtr
         dDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735995507; x=1736600307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCmZExhyz7cb3bxHLdfAhcPoFeVCTtasFkXOWH4Z1YU=;
        b=snlUNvjJQlr7Z1++v8/rYqvM/wSo7x1uZFY79cdtUi4gE266rCihKENemKkWGDw3Oc
         wx7t6D8+ZapV31gfhaA6ZZpXh9QU6Rg7Sj9ZnS01CLCTqrYmFPKR/+svWLzBPYSblvNt
         uja8MugE2vk7Jvy+2F+P++SFD8VUwfaKG6//p/KHOtyAVZChJQ+L1wTViMhnL48txnDm
         mFluswLCV009iHoU+qstv7srAWJbJ6MgQeYrHvhMfPbvUEhI3zkm0dIzuBylOQS+DEpu
         22ZDTH5w8E2rmw9beelKGkXaTq0ZeY8E08PUu29hzKeBeEIvXhOHjLMeT0om1WF5ky+3
         zBDw==
X-Forwarded-Encrypted: i=1; AJvYcCWsCG7C9xQkW2Za95bvKSGNdc/hDEgeqL1eBOfNbNU2Wkpe8jyvUezqI0vC3nD0l2EbZUW8L3g=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxn9VgKmCxzS+OF5hXfdTYasDyhC84ZkGLdSJwvhuOKHz3nW6aA
	6aTH3oAm7qtdpfkho2RGdq46jGe+PWgJoy6E0+xEw169oxfaEmFh
X-Gm-Gg: ASbGncsWKbzdTqifcSUUg5TOqEUue4faBPDhi4lmdiTgC4T64HR1eoCtmeL+ZOVOTMy
	AoV0wfJppDP2nIuCzP0QkNrM9gsFG0uq9juW6bP5H1QCb4Xu8fzJw+gBJ9pW68YdmK5eDrNtkLG
	pfFAv7F+g1J3WOtAeEdTRK9XEul/VYLjQbScEow2IftgLrH/0gILgxzKC6dYiijEaWeoHRv6vvN
	l4Qxa7YsNIkcirOdvVIqIVGokevcv3hiKX6F+i2A/TFbyU=
X-Google-Smtp-Source: AGHT+IHhlUZ4hpFQ3a9b6BPvAGinyOtYhhp3nBXZboTqrJ2Is+5BNZ37AA3tsOk4lmwOGToWJ2idfA==
X-Received: by 2002:a05:6a21:3189:b0:1e0:d632:b9e0 with SMTP id adf61e73a8af0-1e5e046fab8mr87168448637.13.1735995506986;
        Sat, 04 Jan 2025 04:58:26 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad830349sm27761344b3a.47.2025.01.04.04.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 04:58:26 -0800 (PST)
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
Subject: [PATCH net-next v7 05/11] net: ip_tunnel: Use link netns in newlink() of rtnl_link_ops
Date: Sat,  4 Jan 2025 20:57:26 +0800
Message-ID: <20250104125732.17335-6-shaw.leon@gmail.com>
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

Convert common ip_tunnel_newlink() to accept an extra link netns
argument. Don't overwrite ip_tunnel.net in ip_tunnel_init().

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 include/net/ip_tunnels.h |  5 +++--
 net/ipv4/ip_gre.c        |  8 +++++---
 net/ipv4/ip_tunnel.c     | 10 ++++++----
 net/ipv4/ip_vti.c        |  3 ++-
 net/ipv4/ipip.c          |  3 ++-
 5 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 1aa31bdb2b31..ae1f2dda4533 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -406,8 +406,9 @@ int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_buff *skb,
 		  bool log_ecn_error);
 int ip_tunnel_changelink(struct net_device *dev, struct nlattr *tb[],
 			 struct ip_tunnel_parm_kern *p, __u32 fwmark);
-int ip_tunnel_newlink(struct net_device *dev, struct nlattr *tb[],
-		      struct ip_tunnel_parm_kern *p, __u32 fwmark);
+int ip_tunnel_newlink(struct net *net, struct net_device *dev,
+		      struct nlattr *tb[], struct ip_tunnel_parm_kern *p,
+		      __u32 fwmark);
 void ip_tunnel_setup(struct net_device *dev, unsigned int net_id);
 
 bool ip_tunnel_netlink_encap_parms(struct nlattr *data[],
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 71eb651e2b44..d1b712b775b6 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1408,7 +1408,8 @@ static int ipgre_newlink(struct rtnl_newlink_params *params)
 	err = ipgre_netlink_parms(dev, data, tb, &p, &fwmark);
 	if (err < 0)
 		return err;
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb, &p,
+				 fwmark);
 }
 
 static int erspan_newlink(struct rtnl_newlink_params *params)
@@ -1427,7 +1428,8 @@ static int erspan_newlink(struct rtnl_newlink_params *params)
 	err = erspan_netlink_parms(dev, data, tb, &p, &fwmark);
 	if (err)
 		return err;
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb, &p,
+				 fwmark);
 }
 
 static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
@@ -1701,7 +1703,7 @@ struct net_device *gretap_fb_dev_create(struct net *net, const char *name,
 	struct ip_tunnel *t;
 	int err;
 	struct rtnl_newlink_params params = {
-		.net = net,
+		.src_net = net,
 		.tb = tb,
 	};
 
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 25505f9b724c..952d2241c9b1 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1213,11 +1213,11 @@ void ip_tunnel_delete_nets(struct list_head *net_list, unsigned int id,
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_delete_nets);
 
-int ip_tunnel_newlink(struct net_device *dev, struct nlattr *tb[],
-		      struct ip_tunnel_parm_kern *p, __u32 fwmark)
+int ip_tunnel_newlink(struct net *net, struct net_device *dev,
+		      struct nlattr *tb[], struct ip_tunnel_parm_kern *p,
+		      __u32 fwmark)
 {
 	struct ip_tunnel *nt;
-	struct net *net = dev_net(dev);
 	struct ip_tunnel_net *itn;
 	int mtu;
 	int err;
@@ -1326,7 +1326,9 @@ int ip_tunnel_init(struct net_device *dev)
 	}
 
 	tunnel->dev = dev;
-	tunnel->net = dev_net(dev);
+	if (!tunnel->net)
+		tunnel->net = dev_net(dev);
+
 	strscpy(tunnel->parms.name, dev->name);
 	iph->version		= 4;
 	iph->ihl		= 5;
diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index 12ccbf34fb6c..98752b4d28ad 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -584,7 +584,8 @@ static int vti_newlink(struct rtnl_newlink_params *params)
 	__u32 fwmark = 0;
 
 	vti_netlink_parms(data, &parms, &fwmark);
-	return ip_tunnel_newlink(dev, tb, &parms, fwmark);
+	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb,
+				 &parms, fwmark);
 }
 
 static int vti_changelink(struct net_device *dev, struct nlattr *tb[],
diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index 3a737ea3c2e5..c65c8b0e838f 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -456,7 +456,8 @@ static int ipip_newlink(struct rtnl_newlink_params *params)
 	}
 
 	ipip_netlink_parms(data, &p, &t->collect_md, &fwmark);
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb, &p,
+				 fwmark);
 }
 
 static int ipip_changelink(struct net_device *dev, struct nlattr *tb[],
-- 
2.47.1

