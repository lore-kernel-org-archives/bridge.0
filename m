Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CBF1CCB29
	for <bridge@lists.linux.dev>; Wed, 30 Oct 2024 01:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730252618; cv=none; b=dhvt4Ulfg4HKDnWzRMDIK0G9eH+a6F6xLhhoQAiI5/2/0T6RYQADm+az/zgkH+9sTzv9nzspXOHVaKZpUUpf6IEnpMdVyt70Mm5Qrik+WKmKbHbG6UMdo+yLHalV9jSpFf4JnTOGEXUWWcE3pO+WBzJuysi3EIqkEpxg44wj/Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730252618; c=relaxed/simple;
	bh=Dxf+YjSfF9s66wnRYYKzNGRdTBF+f3o1p3CcPZ9IKMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ifiV+r7DWf05/zL6gzQFZZTfHDXbeHpdpyknGl3xnVXOSNbIRDcZn+l0doweyDSqUp8Q7Xb2OXUYQZ87MDbx+l00ipTKK25+SlAQyMAzDtAFOts6/o3n4Ty+zdxY9ww2rJJSbeSE/Yb65ER9rckl10HLvbm4m8lEZZNOW2WbEX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYPfZ6Me; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYPfZ6Me"
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso315646a12.1
        for <bridge@lists.linux.dev>; Tue, 29 Oct 2024 18:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730252615; x=1730857415; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHha3jxrqpGXunHNpntG6RFQwcyCzV6dVXG5YPCOYY8=;
        b=RYPfZ6MeQ/MhjUSopHt2aGmBxldjfjsuQdvQQbDg7S+xP34/kejZoSPKYCJCzz0xKj
         CbS3FEB/uIgk6Q9mxgsCYqtVigB3jsP5xIkP7CfbeJIKa7jDtm1fosbsuZ26CZh7dR5a
         BrQfyyNq6JH7fkNs7D9b61x+2jukIohM1ekuX6ygbuAWKa6mYy2XsF6FcJToM1ZK4evo
         K1y6TtIbFoX5Esr0s/f3iMSAZ2t1P7g1rCIXPccQoN0rQvyVsTIdYkZX87dLXcx18bg6
         DfcEcYVywPRbJq0bAsqFF9YX0OW4noG9m8iwe6gkYhhRvojgqvNpMxPnV52YOL2RWC2z
         HGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730252615; x=1730857415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHha3jxrqpGXunHNpntG6RFQwcyCzV6dVXG5YPCOYY8=;
        b=RXqTy6BlnZfPY5w/GOIQQ/cYvzfZPUJWOjDPkS+BGg+p1fLWk0+m9UdAQ1kkh5h4UF
         oT1I70azZDSQ5dgoGZTTy+Dv+9BfafXAjoZ9P7AvxyRSl0Xmjm2iMxo/HE+CRHi/DS5K
         QkGzqYd5KFUVqz4OzjhNBqFjWFrWU5WDcXmvr04yJDzsWbovr+ZxVGhVhKDpxJ9/66JX
         T7Ck2bfZCJCy60fYJ8cBeJ46cHEqCeUlrbsRGRyM/ayPZePJLxchW8T1hAbAsYer6tHz
         F/Gjf3rQXqv4Oo+UujqRCowte240ta5hVA+H5wtZIL207Os+sdjjJm/g59mJIzNEIeoQ
         eQ6g==
X-Forwarded-Encrypted: i=1; AJvYcCWuMvVmJwV+vfHnCSA5R+bhzIey/gBYkSfqiPT9ehllm/T2hmzYOS1yFb35eGPUr7YLu/nDTh4=@lists.linux.dev
X-Gm-Message-State: AOJu0YyBdl/lJWa+p0wFkrOpC1INOmsQP4X3Wzm5vT78+MEngGlAgy1n
	BwF3rVoi12ELJdpkI/s536hujj+tw/lP0ZTEDGFKsTjiXsK6po4R
X-Google-Smtp-Source: AGHT+IFJJUSCB//39VAXd17haAZ2/OpwKzfzvKZ8vtIdhSrK7HsIGTHuQWmpfO3gxw0dkEqo9pfwwg==
X-Received: by 2002:a05:6a21:33a4:b0:1d9:e5af:a600 with SMTP id adf61e73a8af0-1db7fe09c92mr1060617637.10.1730252615119;
        Tue, 29 Oct 2024 18:43:35 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc866906dsm8138407a12.10.2024.10.29.18.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 18:43:34 -0700 (PDT)
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
Subject: [PATCH RESEND net-next v4 7/9] net: ip: make ip_route_input() return drop reasons
Date: Wed, 30 Oct 2024 09:41:43 +0800
Message-Id: <20241030014145.1409628-8-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241030014145.1409628-1-dongml2@chinatelecom.cn>
References: <20241030014145.1409628-1-dongml2@chinatelecom.cn>
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
index 33eec844a5a0..4f088fa1c2f2 100644
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

