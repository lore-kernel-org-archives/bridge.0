Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431201C07C6
	for <bridge@lists.linux.dev>; Thu, 24 Oct 2024 09:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762530; cv=none; b=t+2iFLq2kpjo6SAnNLDWX0cjlmhcZFJr2J8f03ZHM8M57Ku05YbJzldBz6keIe8q2iYuZvFbdbsfCn4WsRUhVLvuhBHdO/iRPFdOkOFU7Wbi20SRZsR6Xf1imMnMlDYD7I0in40gknXf1QFyItlgm9HYN5PoxkOzdFC0TRvej0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762530; c=relaxed/simple;
	bh=hEGV0orOzX8fGmrpn/mSJk8E7gQJlPcmRUdkkpTUsTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qm4KMm+/0a2ruV0bR8+zcqQs0vZK+oBXPhNxQKMZ0ocIgmUqY3rupQJ0uc1+g83E1hykwafzwsCvPTvSVIQdh/41hYN/iQrUXgS3kjoHPFuaQAHtSFGEKN9gzXkFYzZJ+nLUCo+FTih5fDrpEIeqgm71vKFOTGgOu8tKDOnZPfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iN26XftK; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iN26XftK"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-71ec1216156so529949b3a.2
        for <bridge@lists.linux.dev>; Thu, 24 Oct 2024 02:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729762525; x=1730367325; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjiOcvjWN3rfOnxH2qS/gj/uoa+l778sjVnoaX+Yeyw=;
        b=iN26XftKWi5FqbBtuCOE+eToXaVXZnhvAF1yVMrgMZuJBs7PtLh6pEDy6m527C4HyJ
         cpz0M7Cj3F7UvWPJPwphkc5o/ybxWInI9b2MUN1EE8nadi+7bN9mzPbwvU01xep0kJi7
         kMT1FSJ+zQnHbyfok2kwljAiE58bdILZpN8jJyvVNzIEg3P3crNBzDclYF6W/WB9pk2s
         1J//zwoWDOgr8Mt4JVa/TXygEwdCovExsejTd1LRHGftRuBgH7AyeyQW3bP5SqRXFf1F
         8DuaMFM0gbY/n+2soWPHaTPr4iItmDo+fCCf/TmiJ+YlZpZg0Stw1sTLbvmWfMetS3uW
         +eRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729762525; x=1730367325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjiOcvjWN3rfOnxH2qS/gj/uoa+l778sjVnoaX+Yeyw=;
        b=ox7M283XHWrZiZHUF0JHWf1jeAp+YjJB/NGzxnxl7eWUl/1ghXSaz6ElWd238PAI3e
         EepoM7ZS3+e5mPNyC+PkFwGB/GV7Y8pqE7EdCovQmPZ+0HVwPs/LRCgYFNcTIvZGnJOr
         A76h1LiQqPnA33GTtnmmiVDr1H8TCeA3nwmgPkLBnFEHJvW80dNQ2tYHzi+9U03OEsxW
         ZabDas9jjsTIRLWbWKt8K1W+KeBL18mtilIhTXoCb//DBJ50qGdduc6ET/EIocGvAOHt
         Lr83u0RMyeOV5I80GJRtNbzVuFwjd+OiFwtoMIJP6tYQ3gMg7z6XBGJ0ewlO7v083BHg
         s67w==
X-Forwarded-Encrypted: i=1; AJvYcCXiRJiXJbLFWeUPP97++vQb8rmBkeKK1IvEx908UlmacDszwR1VCT4yrGUVEoQrtA6iB9qsgf4=@lists.linux.dev
X-Gm-Message-State: AOJu0YxE+B+2HVpeT2OYn0RzrJSWh+caoJsklhMNBmLEIFPEzhrUpJ3N
	r+oNd9iU+rIUP3/HqHPSBUo/hnAktsGi+gSn1uBeYZUcPqMIe0RG
X-Google-Smtp-Source: AGHT+IFN5Ipw66nqfwr0BFzwrNhHZ1wx9abARssLV7ZYEHowb7n28tDKYtncRE2WZmFRVkX9pjzV7Q==
X-Received: by 2002:a05:6a00:b89:b0:71e:452:13dc with SMTP id d2e1a72fcca58-72030bcce48mr7521175b3a.13.1729762525269;
        Thu, 24 Oct 2024 02:35:25 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1415071sm7600287b3a.217.2024.10.24.02.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:35:24 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 8/9] net: ip: make ip_mkroute_input/__mkroute_input return drop reasons
Date: Thu, 24 Oct 2024 17:33:47 +0800
Message-Id: <20241024093348.353245-9-dongml2@chinatelecom.cn>
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
index 757526e450fd..d47d7ae9fc61 100644
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
 
 out:
 	return reason;
-- 
2.39.5

