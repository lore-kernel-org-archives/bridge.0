Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2FC1F6662
	for <bridge@lists.linux.dev>; Wed, 18 Dec 2024 13:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734527408; cv=none; b=gGO9MjJvvc1y9CguogIsRU3WwZI+B1u8FJXtgqb3O/zj7eJlhEVnl3SISZONzxTx0hhIFwdjmHigUScvBF0QDdqahSdgrT3dngE8JgnrjlxgfpaLF6fEp5kN20z5jL31/Cl7f06NMKtvGWi2ZuK0xcwwkZruKAO8k5PUER1eHh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734527408; c=relaxed/simple;
	bh=Q/SDsLYvLvxL7f1ap2ESVK2p4seJuOkLNCClDpbcn1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XbZZJahVi6Mr2uiCjFbFJ2556sSZge74TjuoEMxz5yYWCJpfwJPxM62ooUrZYJpszsHWizgjTGIEtsRtY1TgQEgg4aUaMovtsN9UWmqbSLabCBnonrc38cvsB6F6JLKP0dogapRdKA1ik92Vf9PRU3Fe41UkDZzbI26pGK6M0xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwws70px; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwws70px"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-728ec840a8aso6878519b3a.0
        for <bridge@lists.linux.dev>; Wed, 18 Dec 2024 05:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734527406; x=1735132206; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=duDRQNaydM9MnygAgym8Q8/9ko+la+IiXsEzlSyfpMg=;
        b=kwws70pxJWt8l1ae6fzISBg1Lxj+qeKP5C8lw0+mBUXoX61zpQE5yco2hKhKGMGcnI
         CDZPtl8TplbiTiHuCiNHP6A3fXKItlJBazEWI4ayGVqj3qZPWnFMRY2utBRzpHCOXL01
         CQjEgff9EDEcOqJGBSprJpkD5FiJoIJbG+fb25PlB00CZ7cyPZtmgXgAOqgW9el0ioEC
         Y/4Q334Ny1bMY8COb5bkpCb/POw+Ih7FjR7BDr/f/GMfwa36SbCzS43xa2pVdwi8FeJm
         nZHzMVPlg3G0QtDgOpbh169tphD68TtF77RXoAlU1pgC12b+zV+OIvav+p4uoRBOvSld
         zAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734527406; x=1735132206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=duDRQNaydM9MnygAgym8Q8/9ko+la+IiXsEzlSyfpMg=;
        b=uz+VcdmlwyHug0pQ9hssJiYWsjaft+w1GCYMClXVQgd8CY5AgzpNuOxYiMjnSVY/In
         MDbI7gIsUsYo05zdHHYsMsOhqIKiblYf+2G3IFMg3KCXfTdUXe4HBkk830P3yYFP6wrI
         YYuEs6CQ0mT72b6dopdptMyFyibhdLkQy73hjIB9yKnB522JWI6FCu+aB6s/QdEgsuZ0
         RrvO+h2RqOiWvte+EeC907aFYZwhtRJlCKWdIUVIQW/+HYsf0VD2bmyk6PyrhVwx9bML
         LWp2M29HIoMUYwiHHajbAlcPv2G1KeA6dW+XybEInEzw2vwIJKz4FIrU+8z50yJHAb4M
         WgWA==
X-Forwarded-Encrypted: i=1; AJvYcCWrVSyrXYVOTF5/WLYws7HAlk4W48Dwfu+mVL/g+15hvzlwGLfLcTbWPcV1mswjh5iL8kqQxj0=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4y074dxYuckWrM8n345ZLEkJIrKDRtbXZfbR3LarFpKQ8AivP
	wnTTZRcTQaIsi9a40zMW8VsDK1qu0qVQ3zGkMVNGKjrZEGynE8Ui
X-Gm-Gg: ASbGncuQYTxGJxG9Vx4affxOi1zoH98f0k7XUHdYX4+21uYEKVluk6JfEm4qFuoLrKT
	aeIxMYrOt/PmLePIyXH2VpsYLkIZrkTUzUcDaSJVfrIlDirK9gBA4hIpLdtrxUfJAo/yMlCjr2M
	SOed63fLdwhGVJQjqWmgAzGn3WBXT0bpelsIBWciotUteeJ3/tiw7A/7Q+IZpFVJoG63RB7L5AO
	9lgPxKHnxCEBJBSZBwxO23tUfhRMdFU+yovZLurX7eFrXw=
X-Google-Smtp-Source: AGHT+IHjAWByhkuRCvJpT02c4DgXI4s1gEBDobTpc14t8liBEMaFpl/IXfL3hYD82aWPv+sYgjfNgQ==
X-Received: by 2002:a05:6a21:c94:b0:1e1:a647:8a3f with SMTP id adf61e73a8af0-1e5b4824307mr5763308637.22.1734527405806;
        Wed, 18 Dec 2024 05:10:05 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5c0f59asm7434754a12.67.2024.12.18.05.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 05:10:05 -0800 (PST)
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
Subject: [PATCH net-next v6 05/11] net: ip_tunnel: Use link netns in newlink() of rtnl_link_ops
Date: Wed, 18 Dec 2024 21:09:03 +0800
Message-ID: <20241218130909.2173-6-shaw.leon@gmail.com>
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
index ecad1d88dd26..bae80bb7839a 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1405,7 +1405,8 @@ static int ipgre_newlink(struct rtnl_newlink_params *params)
 	err = ipgre_netlink_parms(dev, data, tb, &p, &fwmark);
 	if (err < 0)
 		return err;
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb, &p,
+				 fwmark);
 }
 
 static int erspan_newlink(struct rtnl_newlink_params *params)
@@ -1424,7 +1425,8 @@ static int erspan_newlink(struct rtnl_newlink_params *params)
 	err = erspan_netlink_parms(dev, data, tb, &p, &fwmark);
 	if (err)
 		return err;
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb, &p,
+				 fwmark);
 }
 
 static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
@@ -1698,7 +1700,7 @@ struct net_device *gretap_fb_dev_create(struct net *net, const char *name,
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

