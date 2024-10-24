Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2271D5157
	for <bridge@lists.linux.dev>; Thu, 24 Oct 2024 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762523; cv=none; b=FzAsPFRw8UN5Q+wHMwYW5v6JpjbTX3qnmta6BJcNJOuqwRsrk9e5kQ+5FI2pit+BawPxNcifIPbEO5HJh5cPLmq8tG3f43wLzKwOXlHrcoxd/zsBszIYTy5p0ScC4210ypiibJsWbLP33gVXrw3E92TAwC6/KmkXqCmQ9+YgVSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762523; c=relaxed/simple;
	bh=ZBCJSiNa4CsjTZLKPAoPbJkdOPZmUXoqjlRHJMtpBEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E/tpLliwWhtRcLcqh9HJVbg1DQt83hjWpvCnNaELV7u2WF3KJ7FH36x5RTeqWold9tEu8BZuS2rrHNSRg/ONWfWFr2V75CX2HDXjtMiInjqaXRID4a0krd15xNlImrChFpCC2c9Uzm7rWv+pO1tS31jz0JNRxaYQ2Upcx+FAN9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrDP3Y81; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrDP3Y81"
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-7ea8ecacf16so427919a12.1
        for <bridge@lists.linux.dev>; Thu, 24 Oct 2024 02:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729762520; x=1730367320; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6zwyUv2KGSH8PlgsFrB+o93Y53y7wbnB82m1YBj/UE=;
        b=VrDP3Y81CJPDHReILoiRJWkZDoSaEvRM6kAAJAtpndoQwyoFVmfdGpIqdXaMcJW8yn
         iPf2CHf3ChSytefLiZtX3MlXhTO6VDDX0Ujl8ZntOePCiTYtPEk/NOofWRb32UMi5B5X
         S0CFJOUxFLpe2oSBj4sHFAz+KA9vY7b1LRwnRDhn6UQGM6wrHyvuWVPbwjE0JhvJQi9f
         UArWD5P2eQpS+Tjk3jyYag10mnBBPF2zEHatr/Dd9cojgFr99uWw6F+83CWClMCTyhvx
         kI2RdvXUVTXZM3hZXHD+5OLMYDH7nZzJVf7BQHq6c/qqstC1hTdAzDjdpEv/yz7XKjbv
         NQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729762520; x=1730367320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6zwyUv2KGSH8PlgsFrB+o93Y53y7wbnB82m1YBj/UE=;
        b=XHEQKIij2TLFQ+a0bxJmYQsQyCc/988KCbSZ0HyOru+eElXNnUWzkgtkQ/5a9cVgqk
         aQI70TqA68cVuavrpA8HPPq0ePW1N11LaoEV6zTlIJsXdi6pA2M1ba0xgSqburj7K2Nq
         /bInJkwi/TqB/FsvywOBgsfA98J+/f1/FghbmU4zIvdednGwCQcIm1StDrZn+eErk7XH
         pew16fwXbIRpeXnzrzLAp9eemJ2AuWv4hbFoO4Rn/Uu2g1rRLe+18M034GtneS+0b3jX
         EQXBdMRz1RtrMo8PXN0yzErVxO5EBzL/NiVc+GpXEaHADMfKAPNbQIPFQ+1dyPGbXwYE
         /jgw==
X-Forwarded-Encrypted: i=1; AJvYcCUrX0LJgq1YA4Aiiowyy5tmVF+LVvBsySQJDvTycXaurBgpwljAXqtPN/+zoBZ9w3z8GamK0jc=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4A5wPDYCoASDx6B2fw39ftUcDJezsaZYl1YHBxzcUt8AIxiKq
	0M1KQgZC/O6UA/7wk6jLzg7rDUHf8B9NAJv9dlU7DDvbaJbmwYg3
X-Google-Smtp-Source: AGHT+IEhH9mv4sRJVGrpIlkJrNHBz3f9CnsIgWLrxbEHkg0baOEdR6HmBCN2l2m6Svm3SbVXLsLMzA==
X-Received: by 2002:a05:6a21:1709:b0:1d9:782f:8c9a with SMTP id adf61e73a8af0-1d978b2d8b7mr6909181637.21.1729762520057;
        Thu, 24 Oct 2024 02:35:20 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1415071sm7600287b3a.217.2024.10.24.02.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:35:19 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 7/9] net: ip: make ip_route_input() return drop reasons
Date: Thu, 24 Oct 2024 17:33:46 +0800
Message-Id: <20241024093348.353245-8-dongml2@chinatelecom.cn>
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

In this commit, we make ip_route_input() return skb drop reasons that come
from ip_route_input_noref().

Meanwhile, adjust all the call to it.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v4:
- replace the variable "err" with "reason" for the return value of
  ip_route_input()
---
 include/net/route.h             |  7 ++++---
 net/bridge/br_netfilter_hooks.c | 11 ++++++-----
 net/ipv4/icmp.c                 |  2 +-
 net/ipv4/ip_options.c           |  2 +-
 net/ipv6/seg6_local.c           | 14 +++++++-------
 5 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index 11674f7c6be6..f4ab5412c9c9 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -210,8 +210,9 @@ int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		      dscp_t dscp, struct net_device *dev,
 		      const struct sk_buff *hint);
 
-static inline int ip_route_input(struct sk_buff *skb, __be32 dst, __be32 src,
-				 dscp_t dscp, struct net_device *devin)
+static inline enum skb_drop_reason
+ip_route_input(struct sk_buff *skb, __be32 dst, __be32 src, dscp_t dscp,
+	       struct net_device *devin)
 {
 	enum skb_drop_reason reason;
 
@@ -224,7 +225,7 @@ static inline int ip_route_input(struct sk_buff *skb, __be32 dst, __be32 src,
 	}
 	rcu_read_unlock();
 
-	return reason ? -EINVAL : 0;
+	return reason;
 }
 
 void ipv4_update_pmtu(struct sk_buff *skb, struct net *net, u32 mtu, int oif,
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 17a5f5923d61..110cffc24a1d 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -373,8 +373,8 @@ static int br_nf_pre_routing_finish(struct net *net, struct sock *sk, struct sk_
 	struct nf_bridge_info *nf_bridge = nf_bridge_info_get(skb);
 	struct net_device *dev = skb->dev, *br_indev;
 	const struct iphdr *iph = ip_hdr(skb);
+	enum skb_drop_reason reason;
 	struct rtable *rt;
-	int err;
 
 	br_indev = nf_bridge_get_physindev(skb, net);
 	if (!br_indev) {
@@ -390,9 +390,9 @@ static int br_nf_pre_routing_finish(struct net *net, struct sock *sk, struct sk_
 	}
 	nf_bridge->in_prerouting = 0;
 	if (br_nf_ipv4_daddr_was_changed(skb, nf_bridge)) {
-		err = ip_route_input(skb, iph->daddr, iph->saddr,
-				     ip4h_dscp(iph), dev);
-		if (err) {
+		reason = ip_route_input(skb, iph->daddr, iph->saddr,
+					ip4h_dscp(iph), dev);
+		if (reason) {
 			struct in_device *in_dev = __in_dev_get_rcu(dev);
 
 			/* If err equals -EHOSTUNREACH the error is due to a
@@ -402,7 +402,8 @@ static int br_nf_pre_routing_finish(struct net *net, struct sock *sk, struct sk_
 			 * martian destinations: loopback destinations and destination
 			 * 0.0.0.0. In both cases the packet will be dropped because the
 			 * destination is the loopback device and not the bridge. */
-			if (err != -EHOSTUNREACH || !in_dev || IN_DEV_FORWARD(in_dev))
+			if (reason != SKB_DROP_REASON_IP_INADDRERRORS || !in_dev ||
+			    IN_DEV_FORWARD(in_dev))
 				goto free_skb;
 
 			rt = ip_route_output(net, iph->daddr, 0,
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 23664434922e..69ea33f64a54 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -545,7 +545,7 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
 		orefdst = skb_in->_skb_refdst; /* save old refdst */
 		skb_dst_set(skb_in, NULL);
 		err = ip_route_input(skb_in, fl4_dec.daddr, fl4_dec.saddr,
-				     dscp, rt2->dst.dev);
+				     dscp, rt2->dst.dev) ? -EINVAL : 0;
 
 		dst_release(&rt2->dst);
 		rt2 = skb_rtable(skb_in);
diff --git a/net/ipv4/ip_options.c b/net/ipv4/ip_options.c
index 81e86e5defee..e3321932bec0 100644
--- a/net/ipv4/ip_options.c
+++ b/net/ipv4/ip_options.c
@@ -618,7 +618,7 @@ int ip_options_rcv_srr(struct sk_buff *skb, struct net_device *dev)
 		orefdst = skb->_skb_refdst;
 		skb_dst_set(skb, NULL);
 		err = ip_route_input(skb, nexthop, iph->saddr, ip4h_dscp(iph),
-				     dev);
+				     dev) ? -EINVAL : 0;
 		rt2 = skb_rtable(skb);
 		if (err || (rt2->rt_type != RTN_UNICAST && rt2->rt_type != RTN_LOCAL)) {
 			skb_dst_drop(skb);
diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index c74705ead984..ac1dbd492c22 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -954,10 +954,10 @@ static int input_action_end_dx4_finish(struct net *net, struct sock *sk,
 				       struct sk_buff *skb)
 {
 	struct dst_entry *orig_dst = skb_dst(skb);
+	enum skb_drop_reason reason;
 	struct seg6_local_lwt *slwt;
 	struct iphdr *iph;
 	__be32 nhaddr;
-	int err;
 
 	slwt = seg6_local_lwtunnel(orig_dst->lwtstate);
 
@@ -967,9 +967,9 @@ static int input_action_end_dx4_finish(struct net *net, struct sock *sk,
 
 	skb_dst_drop(skb);
 
-	err = ip_route_input(skb, nhaddr, iph->saddr, 0, skb->dev);
-	if (err) {
-		kfree_skb(skb);
+	reason = ip_route_input(skb, nhaddr, iph->saddr, 0, skb->dev);
+	if (reason) {
+		kfree_skb_reason(skb, reason);
 		return -EINVAL;
 	}
 
@@ -1174,8 +1174,8 @@ static struct sk_buff *end_dt_vrf_core(struct sk_buff *skb,
 static int input_action_end_dt4(struct sk_buff *skb,
 				struct seg6_local_lwt *slwt)
 {
+	enum skb_drop_reason reason;
 	struct iphdr *iph;
-	int err;
 
 	if (!decap_and_validate(skb, IPPROTO_IPIP))
 		goto drop;
@@ -1193,8 +1193,8 @@ static int input_action_end_dt4(struct sk_buff *skb,
 
 	iph = ip_hdr(skb);
 
-	err = ip_route_input(skb, iph->daddr, iph->saddr, 0, skb->dev);
-	if (unlikely(err))
+	reason = ip_route_input(skb, iph->daddr, iph->saddr, 0, skb->dev);
+	if (unlikely(reason))
 		goto drop;
 
 	return dst_input(skb);
-- 
2.39.5

