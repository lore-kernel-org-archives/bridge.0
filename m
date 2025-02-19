Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BCE1E5B89
	for <bridge@lists.linux.dev>; Wed, 19 Feb 2025 12:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969510; cv=none; b=LCs6eNX2upn/d6duvZLf1D8WWXOcyGAdFKAB1s43kokxIZ90eJfavGbIaE3uVQ2YsH3MX3NUKPvq6RWGpN/HOzVq5eWXJ32QrprqxrOfhZQy/Brpb95SPCUMvaYqDOik/GcmPO1mGpmTcK7+iF6tfjdBrE9HXIDOwyeZTf+cNTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969510; c=relaxed/simple;
	bh=TB+PZXAS/vx8BG7x1KeG79/o2AKkUgqXidM5xP69mA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2Kz+c3rOCSCoyFzeMLDMzAYgK2KRu138joyzk3KEqQ6GCOPMH7+VdvjtQ1voQ8sEGYrFcFDKTES6pFmD21m8mgcjYsBZaFJkHKAcZsvhk/glmCad1R3+0vWWyf+taH4vX6dD9hmtARAFeculZKgK9WEi3eYqSYxpQP76lmPwXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8CTkAAo; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8CTkAAo"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220d39a5627so97979995ad.1
        for <bridge@lists.linux.dev>; Wed, 19 Feb 2025 04:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969508; x=1740574308; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8g2ZzjSkLAnV2rJAeqcq6uVgaF3+M6uyZFMb8BU5Wo=;
        b=A8CTkAAoTTHuNRd3N17deA1tB6FiMBLBgonqqe1PomVGYjaTtG8vMsvHuTOnhoPAoY
         YA3QcogvbVziwHAPMuyDRKKS8a0fWvJM9P6jS0y02UU7RQDMtqDrEfGu3Ql2CslwE6JE
         c967SafiJTcG9Rrt+s6jWawKjR0sTlR1hEMtrzxeCInm81OWeIpEjKjQmH0y+R2PV1pj
         xjtXhoRA8VQsepX61mlB2O+hHSnNitkcQhEb9LNziiFKYs31DB6rfAFjvKozxM66/CO4
         jZHzIQTeaQpPeCjf/PNnXFa066+8mSGh0xKRSmAf+ipQdrdFacIew0eZTTKxyUHwj/G4
         jw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969508; x=1740574308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8g2ZzjSkLAnV2rJAeqcq6uVgaF3+M6uyZFMb8BU5Wo=;
        b=ONF6nFDoFU7+M45juGK63LvFBplBnVmsg6adR/6ALvd5Te+sZ4wLT7M459pfrzrnfA
         hASabT2bCXPKSleh0jFl12/ayIR3g2mnihf/zw3xRYGZraEHTfpxpoSAZEvc+XgbgBvf
         8gvq6rFm8Il2ymojii1r4KRQeU2rnyEWiv7/FAbr+ndIHClIC+K1ISR69b16pNYwn2sI
         Z3PPjtXVJF2Y4Fp7Q7J07vJy+Rlm4dRyPeiM9CHc/aRbCYZ7b8XNZoAy6xVAnctCyuNB
         l9JDgzw7ff7eIqU6l72wN8ifPim+vBz79iJ3S40HC6AvX79je/Oe0GhCRTY81alEkdHI
         On5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFhFRAs5rPU6pVkZl2rvlCsaLpGVq9hIU/0jqI8DhX4lGDBm56zzz61XRkRMAHUjFayOX/hZw=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywv/MOlDWrvg0aiOkjHsTfOhk/7/nyON9NCN/OnMtTUzqCqXtQn
	sC8Ta0KNItdXkwGf0gfOXYVIMs0ti4jqRvYdW2UlW168w+puKv/T
X-Gm-Gg: ASbGncsOH/Enx5KOx0vbUGy7CPUF2i7hTQAyHBDlH7UvF11U6F71zMqNrWFrgNaRe5K
	3wJwurk4+MMC3QjSfrNH0qxDHoSgpMYlcITxkd7kauGIza/sYrgPqj8P4EjKvG/v3TsWKZ2Qk0+
	fieEQM+Pt5LOyhfo8lSu8C/CvRPKgGuGmvjai//hXTfMKaChml0dVB+Uiz75HKRm60NiHTeHUwT
	i8MG25wnFAOTdkN4kKawydXZKBBGoOU7lIi3EoOqZfT0zKpWQFWpF/W+hH+g+SdjM31bzrO51IK
	liCONw==
X-Google-Smtp-Source: AGHT+IFYP0H8aiDg7L5uhsGsJLhgqrRsnWJTkGp9h+ijz9vj+qGa0NYcij3UcKBMYCMaV2Zll9Ie8g==
X-Received: by 2002:a17:902:ec84:b0:220:d532:834e with SMTP id d9443c01a7336-221040255d9mr276303305ad.19.1739969508267;
        Wed, 19 Feb 2025 04:51:48 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536436fsm103427175ad.64.2025.02.19.04.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:51:47 -0800 (PST)
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
Subject: [PATCH net-next v10 06/13] net: ip_tunnel: Use link netns in newlink() of rtnl_link_ops
Date: Wed, 19 Feb 2025 20:50:32 +0800
Message-ID: <20250219125039.18024-7-shaw.leon@gmail.com>
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

When link_net is set, use it as link netns instead of dev_net(). This
prepares for rtnetlink core to create device in target netns directly,
in which case the two namespaces may be different.

Convert common ip_tunnel_newlink() to accept an extra link netns
argument.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 include/net/ip_tunnels.h | 5 +++--
 net/ipv4/ip_gre.c        | 8 +++++---
 net/ipv4/ip_tunnel.c     | 6 +++---
 net/ipv4/ip_vti.c        | 3 ++-
 net/ipv4/ipip.c          | 3 ++-
 5 files changed, 15 insertions(+), 10 deletions(-)

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
index 1fe9b13d351c..26d15f907551 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1413,7 +1413,8 @@ static int ipgre_newlink(struct net_device *dev,
 	err = ipgre_netlink_parms(dev, data, tb, &p, &fwmark);
 	if (err < 0)
 		return err;
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb, &p,
+				 fwmark);
 }
 
 static int erspan_newlink(struct net_device *dev,
@@ -1433,7 +1434,8 @@ static int erspan_newlink(struct net_device *dev,
 	err = erspan_netlink_parms(dev, data, tb, &p, &fwmark);
 	if (err)
 		return err;
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb, &p,
+				 fwmark);
 }
 
 static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
@@ -1701,7 +1703,7 @@ static struct rtnl_link_ops erspan_link_ops __read_mostly = {
 struct net_device *gretap_fb_dev_create(struct net *net, const char *name,
 					u8 name_assign_type)
 {
-	struct rtnl_newlink_params params = { .net = net };
+	struct rtnl_newlink_params params = { .src_net = net };
 	struct nlattr *tb[IFLA_MAX + 1];
 	struct net_device *dev;
 	LIST_HEAD(list_kill);
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index dd4b4e5be998..011f2a5aab3b 100644
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
2.48.1

