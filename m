Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD981C4A3B
	for <bridge@lists.linux.dev>; Tue, 15 Oct 2024 14:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729001357; cv=none; b=Uf1i2135H1aTxIA29EJdYdIPz4UAmNDazKNy9zghuCz5hqWy0syQmLk66pujKfNWC1qGEHEQpZtQsqTSTaPY46pTZrJvaJM0WEVQ6XvwTy5NQX0Qzigk2YwOJdOa7bnmiqNBhT54Dfj/szKD615Gon1zc3a1qB6KkHnytY709+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729001357; c=relaxed/simple;
	bh=deRFnQwRg+kHlAO3InS8HPWdrPzjO/lid9s4IAPn5Ho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mQld4WzDYVnl9wG8XifMwsg5vfgUUvY536vDkFQ98atEwj/gm9L7Ila6TQiSHGLLsl1K2lE6s8eYQO0otwOLLSuNWe6u9uAhx713NlHcQ/FyaiB1zHgOxDNGTJcKh1hc7vn6FGIOYvt/7sySWBnSbQXZrVTQIRgGRCxXQcNnw8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y59Oon3E; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y59Oon3E"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-20caea61132so34476855ad.2
        for <bridge@lists.linux.dev>; Tue, 15 Oct 2024 07:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729001356; x=1729606156; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xb6Keu+mjnQTG+TZRKzxO8S5SFad7ATh4n914sZaJ58=;
        b=Y59Oon3E+eNpaQ1xmpJ04PjyE/W9l9sDwLR0grHCJp/VBPvUjylh28RhXJs18ioyr5
         Yr8aiABBKtYlu2hxo+18Iiq9JPqk1wwd/6rKKPMO0A9nNeMcCLz4cZ157MiGGrZDf1sU
         8I9eU81oYug98RGfBrgqADvZLxWQDpxAQy8BQZrja5W9umt+Rtg++pQavhj3za/XOdWB
         +r8aBsairvHnqso+yrmXWXmDPRTwMLGaRuzZejKK7NMfmvqG0cBuC6GvHXIcwNIJyL94
         BLc48GonsZXN1QsPg2hazb5fMl7IZf9g5g/xf1bun0mQ9Q8CYj3Ht6K5nLqtHiphUEQA
         oZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729001356; x=1729606156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xb6Keu+mjnQTG+TZRKzxO8S5SFad7ATh4n914sZaJ58=;
        b=pKHXISzLFsrHcgB/U3XDreAWAIyAxcNr5wSUm3qk/qlk1LtG0yFS81sLFs+zPjviO1
         Cf8ij/6z67Zux5nFjkQS3OyTjIgkEMsM3EkLqOu+cMU47W7ibhnOuxzVCI6+9DlxKsHQ
         hydcsPb9G28oyAxkW2SIKHILGh2kS/ZWJjcren/eC0MK3AUh8LziIET7ZYlTgcHNY3ez
         jTMQu2hNRZPdeS2vQ6XYFcKQu2xZKEhvbV17znML0g4z7eWTL8QkBYkdSakhQvkpiedA
         hhlaTnonh6+4LBERbc0UQpIbeg/wmHYP9RSUMzjBGrnSB2BCldThIVEJX9WPvSpz/FoU
         TUNg==
X-Forwarded-Encrypted: i=1; AJvYcCUFQqSzmmGYIOcw0gmyrvTWkyofi0kPltSQaG2MXWzZYhvICmpzWUTxU5cAaESQzA8MLTccLqg=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3pJL8P+03z7ep4ee4Bf9O7crkuBMmYR5PF8GlsLQFY9rzUGjI
	u91t062fjMhBV+2TN8WqztycnQD67zdrklSq2Z2aGuq4P9TJQZwm
X-Google-Smtp-Source: AGHT+IGWOmfDSpyBXQ2KoMTkoFeGQU4J/bwskUqMV7x2PbaD9NjoBS5aXiZoLhs/g3mwmYmhUchSjw==
X-Received: by 2002:a17:903:22c7:b0:20c:9062:fb88 with SMTP id d9443c01a7336-20cbb1a983dmr170607795ad.1.1729001355567;
        Tue, 15 Oct 2024 07:09:15 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f9d419sm12437625ad.93.2024.10.15.07.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 07:09:15 -0700 (PDT)
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
Subject: [PATCH net-next v3 09/10] net: ip: make ip_mkroute_input/__mkroute_input return drop reasons
Date: Tue, 15 Oct 2024 22:07:59 +0800
Message-Id: <20241015140800.159466-10-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241015140800.159466-1-dongml2@chinatelecom.cn>
References: <20241015140800.159466-1-dongml2@chinatelecom.cn>
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
the proxy_arp_pvlan is not enabled. This name is ugly, and I have not
figure out a suitable name for this case yet :/

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/net/dropreason-core.h |  7 +++++++
 net/ipv4/route.c              | 35 +++++++++++++++++++----------------
 2 files changed, 26 insertions(+), 16 deletions(-)

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
index 86a964734b1d..cb6beb270265 100644
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
 
 	err = __fib_validate_source(skb, saddr, daddr, dscp, FIB_RES_OIF(*res),
 				    in_dev->dev, in_dev, &itag);
 	if (err < 0) {
-		err = -EINVAL;
+		reason = -err;
 		ip_handle_martian_source(in_dev->dev, in_dev, skb, daddr,
 					 saddr);
 
@@ -1820,7 +1822,8 @@ static int __mkroute_input(struct sk_buff *skb, const struct fib_result *res,
 		 */
 		if (out_dev == in_dev &&
 		    IN_DEV_PROXY_ARP_PVLAN(in_dev) == 0) {
-			err = -EINVAL;
+			/* what do we name this situation? */
+			reason = SKB_DROP_REASON_ARP_PVLAN_DISABLE;
 			goto cleanup;
 		}
 	}
@@ -1843,7 +1846,7 @@ static int __mkroute_input(struct sk_buff *skb, const struct fib_result *res,
 	rth = rt_dst_alloc(out_dev->dev, 0, res->type,
 			   IN_DEV_ORCONF(out_dev, NOXFRM));
 	if (!rth) {
-		err = -ENOBUFS;
+		reason = SKB_DROP_REASON_NOMEM;
 		goto cleanup;
 	}
 
@@ -1857,9 +1860,9 @@ static int __mkroute_input(struct sk_buff *skb, const struct fib_result *res,
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
@@ -2117,9 +2120,10 @@ int fib_multipath_hash(const struct net *net, const struct flowi4 *fl4,
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
@@ -2333,9 +2337,8 @@ ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	}
 
 make_route:
-	err = ip_mkroute_input(skb, res, in_dev, daddr, saddr, dscp, flkeys);
-	if (!err)
-		reason = SKB_NOT_DROPPED_YET;
+	reason = ip_mkroute_input(skb, res, in_dev, daddr, saddr, dscp,
+				  flkeys);
 
 out:	return reason;
 
-- 
2.39.5

