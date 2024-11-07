Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941B4212F14
	for <bridge@lists.linux.dev>; Thu,  7 Nov 2024 12:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730984225; cv=none; b=h692ZSPQG6xjfTuPQ1lqKxyK3BgF46tpWx2JB59auxpaGlhDi7ZaLvGYj8xwFojRH+1f+Kbn3DCyrj8bxo4e+cdoMK5yrQN6W/NGTTO2hJ/sulSBkoIOPOFL7hsA+b0TeymsZblMpU98DX84qoXm1YttfNZNoqw01EPKVxLK8Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730984225; c=relaxed/simple;
	bh=Hwlyk1RkZ8H0cJe0cYToxVJgBU3qh+yZ7+dZVE9YlwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h9+Slqak4J8AeLrWed25s4eA7818C/oDLKFWu36HqJWbRT+Frd5VmeHnr1Xd5tra22JtdEhvBtxIR57bBuFhkyvDjiiAGRoJVkMbYD2ZgR+gWaz5PLneYFJd7AubUHVdTEH4v/pZ8GI5itVkRjHzBU1Djlui3K/VthJ/ZfCbCz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnOYAUz1; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnOYAUz1"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-71e5130832aso645233b3a.0
        for <bridge@lists.linux.dev>; Thu, 07 Nov 2024 04:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730984223; x=1731589023; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTqkz36ekB+JArtkSWdZup78l4dvG65c4a97rkbFY2g=;
        b=fnOYAUz1H6+4UxccDHQFPGwOThpOWDS98lhxYDGQaaCK4DWPoLi2RXoK6yglzC96oN
         LMwLsqMnMpEh6hqBbOLeLar3S694SSM5v8/YoPISCv3+7ubzbQg2yIWHlw0ZoRZEtHaq
         gQJH+XZVSMIifzwnNiZdMc+Mu9ODvLmhhCJQTclgJlv0S45ysTNg6xfxfn98bx48xweh
         DiwC4LpxWaab65XTchKr5qVt9jlLDTWMdeItpUY9vbBplOkADO/p23FVgEveTCXgsPUH
         uvUjGmUnT3adhhPsreTccuBdWIhe9a7Pkfgso8MGTNcQ696ZabguPijMYA00WR2+hh4j
         z+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730984223; x=1731589023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTqkz36ekB+JArtkSWdZup78l4dvG65c4a97rkbFY2g=;
        b=FlYJBbc9zz/rozDJm7pXi9J7qaifk5o2mDf4fvaH0vw9WewJlIMtvgNP3CTqIotKJ1
         lJ2DkvntYS9BM8J1klplI5fdfJhbfCdEeQAPDWA1IJJZipv4GbBX+e9W3qIVYRHAJ+DO
         4U28nsqejVx/5qBrPSmOMO8mwBSgvhyL5e+Y9mxPt07TdVIVksh6E0F2gKpYrtGwWpM7
         WFYp/XinkkNYPyrxPwflXsFnota11wLEsnpwlPjC23ga/A21km5PmAQPXUZSf46g1EWN
         7gHLV4cSu9wRDqpEkQzeoW18RpFIXeX86dCnGn2Kk2ZQCwWHMvLpxU3nJJSkIrvcf/+h
         Ie3w==
X-Forwarded-Encrypted: i=1; AJvYcCUBngpIDI68OudHjug5pSHRAmJcJ238BcKLuaLiJ2y2lv5QgEEb2JYjjUB+hRYWVLdxTkRzHWo=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3TuCG/hmTmm8SXOeNEIU+SCsSIXqr/Fk88ttpRR92sZ0a3Cpp
	1CEQxTfACHcXo7MpJ7Mu/jYAOp9TKdLQKtro38rctgPpZ1GAWu5P
X-Google-Smtp-Source: AGHT+IF2zGAUBIBaXz3X1zvbLv2DoqVWAuK2tyX4mIgaYAkA4p1rjVUF8Y9Cn80G6QcS+PeexU17lw==
X-Received: by 2002:a05:6a00:3d0b:b0:71e:e4f:3e58 with SMTP id d2e1a72fcca58-720c998d909mr31610613b3a.17.1730984222858;
        Thu, 07 Nov 2024 04:57:02 -0800 (PST)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785ffeesm1441651b3a.3.2024.11.07.04.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 04:57:02 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: pabeni@redhat.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	dsahern@kernel.org,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	roopa@nvidia.com,
	razor@blackwall.org,
	gnault@redhat.com,
	bigeasy@linutronix.de,
	hawk@kernel.org,
	idosch@nvidia.com,
	dongml2@chinatelecom.cn,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next v5 3/9] net: ip: make ip_mc_validate_source() return drop reason
Date: Thu,  7 Nov 2024 20:55:55 +0800
Message-Id: <20241107125601.1076814-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241107125601.1076814-1-dongml2@chinatelecom.cn>
References: <20241107125601.1076814-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make ip_mc_validate_source() return drop reason, and adjust the call of
it in ip_route_input_mc().

Another caller of it is ip_rcv_finish_core->udp_v4_early_demux, and the
errno is not checked in detail, so we don't do more adjustment for it.

The drop reason "SKB_DROP_REASON_IP_LOCALNET" is added in this commit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/net/dropreason-core.h |  3 +++
 include/net/route.h           |  7 ++++---
 net/ipv4/route.c              | 35 +++++++++++++++++++----------------
 3 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 62a60be1db84..a2a1fb90e0e5 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -78,6 +78,7 @@
 	FN(IP_INNOROUTES)		\
 	FN(IP_LOCAL_SOURCE)		\
 	FN(IP_INVALID_SOURCE)		\
+	FN(IP_LOCALNET)			\
 	FN(PKT_TOO_BIG)			\
 	FN(DUP_FRAG)			\
 	FN(FRAG_REASM_TIMEOUT)		\
@@ -383,6 +384,8 @@ enum skb_drop_reason {
 	 * 2) source ip is zero and not IGMP
 	 */
 	SKB_DROP_REASON_IP_INVALID_SOURCE,
+	/** @SKB_DROP_REASON_IP_LOCALNET: source or dest ip is local net */
+	SKB_DROP_REASON_IP_LOCALNET,
 	/**
 	 * @SKB_DROP_REASON_PKT_TOO_BIG: packet size is too big (maybe exceed the
 	 * MTU)
diff --git a/include/net/route.h b/include/net/route.h
index 586e59f7ed8a..a828a17a6313 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -199,9 +199,10 @@ static inline struct rtable *ip_route_output_gre(struct net *net, struct flowi4
 	return ip_route_output_key(net, fl4);
 }
 
-int ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			  dscp_t dscp, struct net_device *dev,
-			  struct in_device *in_dev, u32 *itag);
+enum skb_drop_reason
+ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+		      dscp_t dscp, struct net_device *dev,
+		      struct in_device *in_dev, u32 *itag);
 int ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 			 dscp_t dscp, struct net_device *dev);
 int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index ccbaf6207299..566acd08aedf 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1665,34 +1665,37 @@ struct rtable *rt_dst_clone(struct net_device *dev, struct rtable *rt)
 EXPORT_SYMBOL(rt_dst_clone);
 
 /* called in rcu_read_lock() section */
-int ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			  dscp_t dscp, struct net_device *dev,
-			  struct in_device *in_dev, u32 *itag)
+enum skb_drop_reason
+ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+		      dscp_t dscp, struct net_device *dev,
+		      struct in_device *in_dev, u32 *itag)
 {
 	enum skb_drop_reason reason;
 
 	/* Primary sanity checks. */
 	if (!in_dev)
-		return -EINVAL;
+		return SKB_DROP_REASON_NOT_SPECIFIED;
 
-	if (ipv4_is_multicast(saddr) || ipv4_is_lbcast(saddr) ||
-	    skb->protocol != htons(ETH_P_IP))
-		return -EINVAL;
+	if (ipv4_is_multicast(saddr) || ipv4_is_lbcast(saddr))
+		return SKB_DROP_REASON_IP_INVALID_SOURCE;
+
+	if (skb->protocol != htons(ETH_P_IP))
+		return SKB_DROP_REASON_INVALID_PROTO;
 
 	if (ipv4_is_loopback(saddr) && !IN_DEV_ROUTE_LOCALNET(in_dev))
-		return -EINVAL;
+		return SKB_DROP_REASON_IP_LOCALNET;
 
 	if (ipv4_is_zeronet(saddr)) {
 		if (!ipv4_is_local_multicast(daddr) &&
 		    ip_hdr(skb)->protocol != IPPROTO_IGMP)
-			return -EINVAL;
+			return SKB_DROP_REASON_IP_INVALID_SOURCE;
 	} else {
 		reason = fib_validate_source_reason(skb, saddr, 0, dscp, 0,
 						    dev, in_dev, itag);
 		if (reason)
-			return -EINVAL;
+			return reason;
 	}
-	return 0;
+	return SKB_NOT_DROPPED_YET;
 }
 
 /* called in rcu_read_lock() section */
@@ -1702,14 +1705,14 @@ ip_route_input_mc(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 {
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
 	unsigned int flags = RTCF_MULTICAST;
+	enum skb_drop_reason reason;
 	struct rtable *rth;
 	u32 itag = 0;
-	int err;
 
-	err = ip_mc_validate_source(skb, daddr, saddr, dscp, dev, in_dev,
-				    &itag);
-	if (err)
-		return SKB_DROP_REASON_NOT_SPECIFIED;
+	reason = ip_mc_validate_source(skb, daddr, saddr, dscp, dev, in_dev,
+				       &itag);
+	if (reason)
+		return reason;
 
 	if (our)
 		flags |= RTCF_LOCAL;
-- 
2.39.5

