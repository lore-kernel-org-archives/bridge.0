Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48301CBA11
	for <bridge@lists.linux.dev>; Thu, 24 Oct 2024 09:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762509; cv=none; b=jSbWgNBQ+u9drfJ+6ttUizC3o0gbiwbkKdar3CuXhl++HeWGsUl+QTFpchkqZOvb26sdRtWqURNjGY4JKwW1Y3FBD+3lUXpPNINETRYMiDvbz+du9reB/E3zhnzNXv0+9Xu8lKEiU4/ilPnPKDfjmPPt7xXES8GOsZ12IC0FOAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762509; c=relaxed/simple;
	bh=t2qbhSnr2J280GmqHB3cOqoaPQoBk9NuwAi6VMRWxwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sUqLLwSg2iE2nPJ5e2yspK3+K+RGJSxsrUA8zo8blON5VefKanax1rT9Lw4SWnwc4xaxHvLYQzoHDWdE3sQMnHd/0vqCeogwnmd2UTDmDV6Zk0wfbtQPZTtGZqn0zfyYYVloQgkfAM98VZWRyZ/LgWWtvP4amXyjJ1dg35qyNvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxbaFwXA; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxbaFwXA"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-20cf3e36a76so6545005ad.0
        for <bridge@lists.linux.dev>; Thu, 24 Oct 2024 02:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729762503; x=1730367303; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sYHu3jOQDhnsGiy2j7wnqe5lcTLCFT6TdpJY1JQ60c=;
        b=GxbaFwXAoxzhVw6IrP5tfO6Jz9msdf+Xygd1ZMAl/EejyjBNhAfTmyx2feeanUb1/X
         s+iMQNT2O5Y88/ZrfAO89vVyMjXnH0jyzjKpPhFRw5OAcTkqO3vU9ZC2B1VZSfffAcQL
         wpfDu/gMD199aRNWYU3fdTz+1yJL+1Zm9e5EKVApU3ir5SgowQF116WwqxSCm4BG9tbG
         nPBMHo5Ke8oo9K3z5l+NaUXx3vClEFeyzVvmclLjT8LA5uqJAn0DVMBLZvtyclLJTrQv
         b4uTIJ84F1r2rSW8UMw4QYbp7U+B5JNeMB1+wPiXDWWMXkvDGdKOguUgePaRGDhvhMDr
         5H8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729762503; x=1730367303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sYHu3jOQDhnsGiy2j7wnqe5lcTLCFT6TdpJY1JQ60c=;
        b=hI8quSBGyydhXoZ1vuhVOS9HkKZXnQKeMi8/iovYwXigMy+zaYW4eliJbUY+rGcGVW
         zP3hmBBxHazsJLgZaj/Oeek8ugypn57V06sps3jkaG1yWWo/7LDjHY0o1s01MVCoThWH
         esi9bWHlKhk6Hp34Z6zd9KGbxPeOV4AbcyXu4nxLYuLZ1PlyQvxZ39jKgO9DYYpeXxPe
         rX0fSXVzYHj7vER7cAt81T7ug4gkIAlnCTRQQ3ESHpz4jdnUcfhgfAsImjvEJ5Ji4JRu
         Ux5idjiMAmIeTA7lQN7uOdZ3OIcUVL+jf/nfowKXVBHhuGbZz4wOpeXQR0P+SZrvWoHT
         3IuA==
X-Forwarded-Encrypted: i=1; AJvYcCUSqeaxsPn/kJJen+D3n1MqBo8xjMG9THzV3fdzpuecsvX1iWTb3YDP9B6ZoiNFdXdweA0iang=@lists.linux.dev
X-Gm-Message-State: AOJu0YyCyRCJdUGuMmwELLuHXeFeI5RJqeFMNCFENbYVQzubnidhuHcf
	bZaFX+xfQda/xkr9ic9RDls75vA9c7HvyQpSkHlR9kXiADUeAzQI
X-Google-Smtp-Source: AGHT+IFA2/ZyjL+ClK4gyJ1frpG1cZXgBHF08kEZXuKcPerDgVOxZbqCB9MgVDu5Zl/rKCC8Aomcvw==
X-Received: by 2002:a05:6a21:2d88:b0:1d9:2453:4343 with SMTP id adf61e73a8af0-1d978bd2ff7mr6757395637.41.1729762502939;
        Thu, 24 Oct 2024 02:35:02 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1415071sm7600287b3a.217.2024.10.24.02.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:35:02 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: pabeni@redhat.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	dsahern@kernel.org,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	roopa@nvidia.com,
	razor@blackwall.org,
	gnault@redhat.com,
	bigeasy@linutronix.de,
	idosch@nvidia.com,
	ast@kernel.org,
	dongml2@chinatelecom.cn,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v4 4/9] net: ip: make ip_route_input_slow() return drop reasons
Date: Thu, 24 Oct 2024 17:33:43 +0800
Message-Id: <20241024093348.353245-5-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241024093348.353245-1-dongml2@chinatelecom.cn>
References: <20241024093348.353245-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this commit, we make ip_route_input_slow() return skb drop reasons,
and following new skb drop reasons are added:

  SKB_DROP_REASON_IP_INVALID_DEST

The only caller of ip_route_input_slow() is ip_route_input_rcu(), and we
adjust it by making it return -EINVAL on error.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v4:
- use indentation after the out label
---
 include/net/dropreason-core.h |  6 ++++
 net/ipv4/route.c              | 56 ++++++++++++++++++++++-------------
 2 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index a2a1fb90e0e5..74624d369d48 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -79,6 +79,7 @@
 	FN(IP_LOCAL_SOURCE)		\
 	FN(IP_INVALID_SOURCE)		\
 	FN(IP_LOCALNET)			\
+	FN(IP_INVALID_DEST)		\
 	FN(PKT_TOO_BIG)			\
 	FN(DUP_FRAG)			\
 	FN(FRAG_REASM_TIMEOUT)		\
@@ -386,6 +387,11 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_IP_INVALID_SOURCE,
 	/** @SKB_DROP_REASON_IP_LOCALNET: source or dest ip is local net */
 	SKB_DROP_REASON_IP_LOCALNET,
+	/**
+	 * @SKB_DROP_REASON_IP_INVALID_DEST: the dest ip is invalid:
+	 * 1) dest ip is 0
+	 */
+	SKB_DROP_REASON_IP_INVALID_DEST,
 	/**
 	 * @SKB_DROP_REASON_PKT_TOO_BIG: packet size is too big (maybe exceed the
 	 * MTU)
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 61e316f93291..7976f687d039 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2204,9 +2204,10 @@ static struct net_device *ip_rt_get_dev(struct net *net,
  *	called with rcu_read_lock()
  */
 
-static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			       dscp_t dscp, struct net_device *dev,
-			       struct fib_result *res)
+static enum skb_drop_reason
+ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+		    dscp_t dscp, struct net_device *dev,
+		    struct fib_result *res)
 {
 	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
@@ -2236,8 +2237,10 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		fl4.flowi4_tun_key.tun_id = 0;
 	skb_dst_drop(skb);
 
-	if (ipv4_is_multicast(saddr) || ipv4_is_lbcast(saddr))
+	if (ipv4_is_multicast(saddr) || ipv4_is_lbcast(saddr)) {
+		reason = SKB_DROP_REASON_IP_INVALID_SOURCE;
 		goto martian_source;
+	}
 
 	res->fi = NULL;
 	res->table = NULL;
@@ -2247,21 +2250,29 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	/* Accept zero addresses only to limited broadcast;
 	 * I even do not know to fix it or not. Waiting for complains :-)
 	 */
-	if (ipv4_is_zeronet(saddr))
+	if (ipv4_is_zeronet(saddr)) {
+		reason = SKB_DROP_REASON_IP_INVALID_SOURCE;
 		goto martian_source;
+	}
 
-	if (ipv4_is_zeronet(daddr))
+	if (ipv4_is_zeronet(daddr)) {
+		reason = SKB_DROP_REASON_IP_INVALID_DEST;
 		goto martian_destination;
+	}
 
 	/* Following code try to avoid calling IN_DEV_NET_ROUTE_LOCALNET(),
 	 * and call it once if daddr or/and saddr are loopback addresses
 	 */
 	if (ipv4_is_loopback(daddr)) {
-		if (!IN_DEV_NET_ROUTE_LOCALNET(in_dev, net))
+		if (!IN_DEV_NET_ROUTE_LOCALNET(in_dev, net)) {
+			reason = SKB_DROP_REASON_IP_LOCALNET;
 			goto martian_destination;
+		}
 	} else if (ipv4_is_loopback(saddr)) {
-		if (!IN_DEV_NET_ROUTE_LOCALNET(in_dev, net))
+		if (!IN_DEV_NET_ROUTE_LOCALNET(in_dev, net)) {
+			reason = SKB_DROP_REASON_IP_LOCALNET;
 			goto martian_source;
+		}
 	}
 
 	/*
@@ -2316,19 +2327,26 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		err = -EHOSTUNREACH;
 		goto no_route;
 	}
-	if (res->type != RTN_UNICAST)
+	if (res->type != RTN_UNICAST) {
+		reason = SKB_DROP_REASON_IP_INVALID_DEST;
 		goto martian_destination;
+	}
 
 make_route:
 	err = ip_mkroute_input(skb, res, in_dev, daddr, saddr, dscp, flkeys);
-out:	return err;
+	if (!err)
+		reason = SKB_NOT_DROPPED_YET;
+
+out:
+	return reason;
 
 brd_input:
-	if (skb->protocol != htons(ETH_P_IP))
-		goto e_inval;
+	if (skb->protocol != htons(ETH_P_IP)) {
+		reason = SKB_DROP_REASON_INVALID_PROTO;
+		goto out;
+	}
 
 	if (!ipv4_is_zeronet(saddr)) {
-		err = -EINVAL;
 		reason = fib_validate_source_reason(skb, saddr, 0, dscp, 0,
 						    dev, in_dev, &itag);
 		if (reason)
@@ -2349,7 +2367,7 @@ out:	return err;
 		rth = rcu_dereference(nhc->nhc_rth_input);
 		if (rt_cache_valid(rth)) {
 			skb_dst_set_noref(skb, &rth->dst);
-			err = 0;
+			reason = SKB_NOT_DROPPED_YET;
 			goto out;
 		}
 	}
@@ -2386,7 +2404,7 @@ out:	return err;
 			rt_add_uncached_list(rth);
 	}
 	skb_dst_set(skb, &rth->dst);
-	err = 0;
+	reason = SKB_NOT_DROPPED_YET;
 	goto out;
 
 no_route:
@@ -2407,12 +2425,8 @@ out:	return err;
 				     &daddr, &saddr, dev->name);
 #endif
 
-e_inval:
-	err = -EINVAL;
-	goto out;
-
 e_nobufs:
-	err = -ENOBUFS;
+	reason = SKB_DROP_REASON_NOMEM;
 	goto out;
 
 martian_source:
@@ -2469,7 +2483,7 @@ static int ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		return reason ? -EINVAL : 0;
 	}
 
-	return ip_route_input_slow(skb, daddr, saddr, dscp, dev, res);
+	return ip_route_input_slow(skb, daddr, saddr, dscp, dev, res) ? -EINVAL : 0;
 }
 
 int ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-- 
2.39.5

