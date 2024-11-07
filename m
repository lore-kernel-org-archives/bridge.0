Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA27216A0A
	for <bridge@lists.linux.dev>; Thu,  7 Nov 2024 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730984263; cv=none; b=SF9mipknslhBt6AIqjYjQyb1d2WwDW5R93UoW49jVInJGwGlxYWoZLWiVTlEu6kGtniG7HZI8ZLr4ETtycyFjbvdGwthSEmiWDiQY/DW5AQGd43bSICWwFpX0KT3ows1emHQYEPUaD3MShJHke/sUHh8KKj94fJ2GoM8ToAM+XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730984263; c=relaxed/simple;
	bh=XS2m++Sgf3ghY+FnwaWLEeDYZlpTGeMq5gxC//6ynBs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P0DZIU2xZNHp1LEBVCz8VyTZ8eIuHk1dJ1wMrYkLYcdVzEp+TtKHwZ3/Zb32bthS3ksvzKMfI3Lf96KDexbQc1P72jMAv6It22j1/aoYce4ZC4MUhhFEQsGji/jdFNB7WiiXoZnrriv+r5w/GcLFF8YIhuwaU1r3xpAWIlpiH8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/lc06Fr; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/lc06Fr"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-720be27db27so645308b3a.2
        for <bridge@lists.linux.dev>; Thu, 07 Nov 2024 04:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730984261; x=1731589061; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejigKO8ihJK0woNi79sU/LHHXIyrY4qa7/hgbBk06OE=;
        b=g/lc06FrHq51Hbp3GJ5oKtIAcWvHRRw6jVvbckVc72mDJ9yo5AY73IIcc/KbmkpbsU
         h+DVVxnpfAlAxVmUtTm/K0PLocRteP06E1co9/RFZLKaSt1qKCWIem2UjbWV44rM9Gvf
         DKmjK5MklqueZH+EHhtW9Dm29LfE38uoJYCmDPyzMFuSCP2mQhsttO63VMe0c5gkdJc7
         edCZYRTl/a96JMohkoCRa1mPcr0m4RjEisXaXfcPAQre4HBX0J3KLTveCeHHo+nCbXiW
         oU5BPPVWZZJ3js12J+QhSIDsIK8E0IHOhp36er+YUL0xPMzxanDvybDxFCy8QhI9AXvp
         sjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730984261; x=1731589061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ejigKO8ihJK0woNi79sU/LHHXIyrY4qa7/hgbBk06OE=;
        b=AImsjTgxmW0B9S8d0pXW6RFeKGq8W+DPwBDeWHQ3Vv8E1Bwjpi0l6nMxme8jfgyPgk
         48eZZ9X7Ixkg4MvmE6amlMqFx9wVWcmqygfyoQGTnALaU4arlIYrCAPyiUxOKAnIswp8
         lQ4/GhFzAhLjQE0TgrjzNCrITWpy/Gu2b28hNq/PkrGjM/ukdKVYcINuC2w2iKKas4CL
         4hFe3PAcm4f9yRk/R5hg7pRuMOXMpxSYhOolZHN6jnsSy7Q5wmLpyqnqYTsSOjSMJ5SF
         581DfE5SJqYRIeylj9BWVutX/ZGibU5zePYChIysruD47fsoarD2BGDfewx65CoqraG2
         x/lQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl3caMLpADL7CxNHlwGmEI0CFOmw1m+3eZFhcNTiYX0ccoj4CPdxz6B8LafXYV6J+GpZTy6h4=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+A5Vx/SMOASIEFx1NIFwzQiJEvH3627/FNVXkbAX7DcPQ2yL8
	DUywmoCzVjD4egnXdlAKCbUX0V5ibMUmz26/mWtASWoIv4KR8Fj2
X-Google-Smtp-Source: AGHT+IEU6zXbGJYonMbPl97a7r0f0+B1j6/MR40EUxdwoG8IsQ9GwfQX/JcxBrCjiLtl5vbF8FLzUQ==
X-Received: by 2002:a05:6a20:a104:b0:1d9:d04:586d with SMTP id adf61e73a8af0-1dc17b5fa12mr1126789637.38.1730984261012;
        Thu, 07 Nov 2024 04:57:41 -0800 (PST)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785ffeesm1441651b3a.3.2024.11.07.04.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 04:57:40 -0800 (PST)
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
Subject: [PATCH net-next v5 8/9] net: ip: make ip_mkroute_input/__mkroute_input return drop reasons
Date: Thu,  7 Nov 2024 20:56:00 +0800
Message-Id: <20241107125601.1076814-9-dongml2@chinatelecom.cn>
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

In this commit, we make ip_mkroute_input() and __mkroute_input() return
drop reasons.

The drop reason "SKB_DROP_REASON_ARP_PVLAN_DISABLE" is introduced for
the case: the packet which is not IP is forwarded to the in_dev, and
the proxy_arp_pvlan is not enabled.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
This name "SKB_DROP_REASON_ARP_PVLAN_DISABLE" is ugly, and I have not
figured out a suitable name for this case yet :/

v5:
- delete the unneeded comment in __mkroute_input()
---
 include/net/dropreason-core.h |  7 +++++++
 net/ipv4/route.c              | 34 ++++++++++++++++++----------------
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 74624d369d48..6c5a1ea209a2 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -104,6 +104,7 @@
 	FN(IP_TUNNEL_ECN)		\
 	FN(TUNNEL_TXINFO)		\
 	FN(LOCAL_MAC)			\
+	FN(ARP_PVLAN_DISABLE)		\
 	FNe(MAX)
 
 /**
@@ -477,6 +478,12 @@ enum skb_drop_reason {
 	 * the MAC address of the local netdev.
 	 */
 	SKB_DROP_REASON_LOCAL_MAC,
+	/**
+	 * @SKB_DROP_REASON_ARP_PVLAN_DISABLE: packet which is not IP is
+	 * forwarded to the in_dev, and the proxy_arp_pvlan is not
+	 * enabled.
+	 */
+	SKB_DROP_REASON_ARP_PVLAN_DISABLE,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index ce1201dbf464..5061a935ce62 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1769,10 +1769,12 @@ static void ip_handle_martian_source(struct net_device *dev,
 }
 
 /* called in rcu_read_lock() section */
-static int __mkroute_input(struct sk_buff *skb, const struct fib_result *res,
-			   struct in_device *in_dev, __be32 daddr,
-			   __be32 saddr, dscp_t dscp)
+static enum skb_drop_reason
+__mkroute_input(struct sk_buff *skb, const struct fib_result *res,
+		struct in_device *in_dev, __be32 daddr,
+		__be32 saddr, dscp_t dscp)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct fib_nh_common *nhc = FIB_RES_NHC(*res);
 	struct net_device *dev = nhc->nhc_dev;
 	struct fib_nh_exception *fnhe;
@@ -1786,13 +1788,13 @@ static int __mkroute_input(struct sk_buff *skb, const struct fib_result *res,
 	out_dev = __in_dev_get_rcu(dev);
 	if (!out_dev) {
 		net_crit_ratelimited("Bug in ip_route_input_slow(). Please report.\n");
-		return -EINVAL;
+		return reason;
 	}
 
 	err = fib_validate_source(skb, saddr, daddr, dscp, FIB_RES_OIF(*res),
 				  in_dev->dev, in_dev, &itag);
 	if (err < 0) {
-		err = -EINVAL;
+		reason = -err;
 		ip_handle_martian_source(in_dev->dev, in_dev, skb, daddr,
 					 saddr);
 
@@ -1820,7 +1822,7 @@ static int __mkroute_input(struct sk_buff *skb, const struct fib_result *res,
 		 */
 		if (out_dev == in_dev &&
 		    IN_DEV_PROXY_ARP_PVLAN(in_dev) == 0) {
-			err = -EINVAL;
+			reason = SKB_DROP_REASON_ARP_PVLAN_DISABLE;
 			goto cleanup;
 		}
 	}
@@ -1843,7 +1845,7 @@ static int __mkroute_input(struct sk_buff *skb, const struct fib_result *res,
 	rth = rt_dst_alloc(out_dev->dev, 0, res->type,
 			   IN_DEV_ORCONF(out_dev, NOXFRM));
 	if (!rth) {
-		err = -ENOBUFS;
+		reason = SKB_DROP_REASON_NOMEM;
 		goto cleanup;
 	}
 
@@ -1857,9 +1859,9 @@ static int __mkroute_input(struct sk_buff *skb, const struct fib_result *res,
 	lwtunnel_set_redirect(&rth->dst);
 	skb_dst_set(skb, &rth->dst);
 out:
-	err = 0;
- cleanup:
-	return err;
+	reason = SKB_NOT_DROPPED_YET;
+cleanup:
+	return reason;
 }
 
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
@@ -2117,9 +2119,10 @@ int fib_multipath_hash(const struct net *net, const struct flowi4 *fl4,
 }
 #endif /* CONFIG_IP_ROUTE_MULTIPATH */
 
-static int ip_mkroute_input(struct sk_buff *skb, struct fib_result *res,
-			    struct in_device *in_dev, __be32 daddr,
-			    __be32 saddr, dscp_t dscp, struct flow_keys *hkeys)
+static enum skb_drop_reason
+ip_mkroute_input(struct sk_buff *skb, struct fib_result *res,
+		 struct in_device *in_dev, __be32 daddr,
+		 __be32 saddr, dscp_t dscp, struct flow_keys *hkeys)
 {
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
 	if (res->fi && fib_info_num_path(res->fi) > 1) {
@@ -2333,9 +2336,8 @@ ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	}
 
 make_route:
-	err = ip_mkroute_input(skb, res, in_dev, daddr, saddr, dscp, flkeys);
-	if (!err)
-		reason = SKB_NOT_DROPPED_YET;
+	reason = ip_mkroute_input(skb, res, in_dev, daddr, saddr, dscp,
+				  flkeys);
 
 out:
 	return reason;
-- 
2.39.5

