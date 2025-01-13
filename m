Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2CB246351
	for <bridge@lists.linux.dev>; Mon, 13 Jan 2025 14:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779103; cv=none; b=DGXpWVT3lXvufGlHyFEnWPGFzr06boJkwU2OLgXBpZpNXECP6pyFPgRBfAw5GpSZQkV64t2TZpve6R/gaa3a2IZbv9pGvD+OVmVmu07FqQSjaT8JhRtzMuz8r2qEoNoXLSgXi9umRKP1YKb0R7q8OlpeXvV7r9elLOrWALlHXF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779103; c=relaxed/simple;
	bh=4+uj3n3qzLmPEBfggnLAVLnO/V0f9mUleOD9sy+kwQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZDhMev5DyUhJJZ8jqqdCKyIvwMqk4DDuJgTDGpaf2LJekEeoZafi/KfpsVPqKTSGcdkYTtXmHAF1xnqhYEWoHRsPbaZcpLCaqmq1IvUlTNyndbXatV7Na2o3hSAg4i7r1uj+vg0r4cV6WjlCOfAtn/g4+iWJ25J2ALHuFuz3N1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3+uRaXU; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3+uRaXU"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21619108a6bso75041655ad.3
        for <bridge@lists.linux.dev>; Mon, 13 Jan 2025 06:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736779102; x=1737383902; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2hr3iCsVwpwP1Nzlez7XTECQN7gMZZquvojvDybmoY=;
        b=C3+uRaXUilcG4sjH9Bdfcoeh/+5edCP+NIr9OVCKnPEBxkjRkxFB9D7/IBjmggqco/
         H3V5Si6ao0z7ELSRVLtHC59SJZmL7tHbwznoWe5G6rArXgRLbG3TR8gVsCbwdF09jGvJ
         ukYkC1Vd7kwANH+XA191KrG9MCWBl3RXQwEe3GItDG6NgsToJvLfBV+I6zfCcCPpAeL9
         M9P4iee0BH3JbGxC+cymljiDpM+ScwLxHaW28fW0BA3DXRPEnJAqpsPa2XVp/4tGEt4G
         Phi5FXdFtdEeSaQC5Bm/VgXmU6sNJUXk5FoazNBCwEzkr26AFkbHXeC/p/9TY5s83+fs
         LGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736779102; x=1737383902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2hr3iCsVwpwP1Nzlez7XTECQN7gMZZquvojvDybmoY=;
        b=U5RXlReeQYQLxmOhgv0PleST5B3uPHQfxuHpjkxzi53P8IBJXSnZGk4ksOgMrE049y
         huK8Zn4JDXD9bDbNJbb1pTU+dQgcwEkK2rzqFx1vUqXk55/4yhrsp9uHnuJ+wUKEpXWj
         xL3U0emsJsOgtmI8NMz1q/ldhA8xzTwHm37oW08AyAX0WgFJEJXDRcQGlOqB9SV2gcL1
         sIJj+o2jQYQ8M4zDLZoY9fZayeKgNoolyUPbidJsbjhMkfjlOL1LnrUp/Vn0t6hptIUx
         205MUNzV/+daA0QiuA0GBUJW+hmnDjTpuCPMn1Qi63RZI+UGGdu/HManL5jmLXingsvo
         5zUw==
X-Forwarded-Encrypted: i=1; AJvYcCVvy+PkX754WPruRJdFRYd14CQwz3z4OgkWjhV4RoslTwK3qIXINupGQFQI+k6s3RtloTYj8OE=@lists.linux.dev
X-Gm-Message-State: AOJu0YzdYYrNCfs2ztfhbbnXE8c+qMIfT8gZmKN2bRlKY+jqzBx2rRbA
	Ks24YuBBofInOq8DTDSq47FwBMAkW7NlhYVx5s7hscUiHMSqDj0T
X-Gm-Gg: ASbGnctyS/hVvqzQxRs99qBnrhiCnJSzfh6BdZo9DzQlwK9PL1ElNYrD/tO9nrjHqlQ
	0Q0yIIGmJO/MAND+qqWhg2osAfadb5MriO0hSCd5NFcbEr63rQScclHHAvo60RUXA6BjgyM0MLM
	1+Vrwf4XM72m6hrU9UZoDH94fyRakKL/ACjh2Vb1m5GJvD4XfZ/Nuc8+Sr/JsA39gyYPASjTnQJ
	QSrwMBToyOl5CYnYo6A3qfJY+KOxceo/2tJCAwOdsDXMKw=
X-Google-Smtp-Source: AGHT+IGv14RrhPbpKFC9/J2BufZTu7MOaWM0c1rsX2Y4WR5iS1cGRY2j7eRCHAjKSVADaNJCQQybTw==
X-Received: by 2002:a17:902:f685:b0:215:b473:1dc9 with SMTP id d9443c01a7336-21a83fdf10fmr312977815ad.46.1736779101666;
        Mon, 13 Jan 2025 06:38:21 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f155e00sm54328715ad.103.2025.01.13.06.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:38:21 -0800 (PST)
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
Subject: [PATCH net-next v8 05/11] net: ip_tunnel: Use link netns in newlink() of rtnl_link_ops
Date: Mon, 13 Jan 2025 22:37:13 +0800
Message-ID: <20250113143719.7948-6-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113143719.7948-1-shaw.leon@gmail.com>
References: <20250113143719.7948-1-shaw.leon@gmail.com>
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
index 4e8c310769ad..51113e981229 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1409,7 +1409,8 @@ static int ipgre_newlink(struct net_device *dev,
 	err = ipgre_netlink_parms(dev, data, tb, &p, &fwmark);
 	if (err < 0)
 		return err;
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb, &p,
+				 fwmark);
 }
 
 static int erspan_newlink(struct net_device *dev,
@@ -1429,7 +1430,8 @@ static int erspan_newlink(struct net_device *dev,
 	err = erspan_netlink_parms(dev, data, tb, &p, &fwmark);
 	if (err)
 		return err;
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb, &p,
+				 fwmark);
 }
 
 static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
@@ -1703,7 +1705,7 @@ struct net_device *gretap_fb_dev_create(struct net *net, const char *name,
 	struct ip_tunnel *t;
 	int err;
 	struct rtnl_newlink_params params = {
-		.net = net,
+		.src_net = net,
 		.tb = tb,
 	};
 
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 09b73acf037a..618a50d5c0c2 100644
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
index b901bee03e6d..159b4473290e 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -585,7 +585,8 @@ static int vti_newlink(struct net_device *dev,
 	__u32 fwmark = 0;
 
 	vti_netlink_parms(data, &parms, &fwmark);
-	return ip_tunnel_newlink(dev, tb, &parms, fwmark);
+	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb,
+				 &parms, fwmark);
 }
 
 static int vti_changelink(struct net_device *dev, struct nlattr *tb[],
diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index a8b844bcfc64..bab0bf90c908 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -455,7 +455,8 @@ static int ipip_newlink(struct net_device *dev,
 	}
 
 	ipip_netlink_parms(data, &p, &t->collect_md, &fwmark);
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb, &p,
+				 fwmark);
 }
 
 static int ipip_changelink(struct net_device *dev, struct nlattr *tb[],
-- 
2.47.1

