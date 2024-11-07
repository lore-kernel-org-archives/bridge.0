Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0459C216A18
	for <bridge@lists.linux.dev>; Thu,  7 Nov 2024 12:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730984255; cv=none; b=B5vEaUkej0bR7lU2MflaNzfJv8pxyfrivDlZgGY4/CR6HapJcsF27CjOoeLou18qyS3OzXrhr0nPdMLtldJ8ZR2f+a80NT6CG3btG0bbuuAZmrvMucBFHAmkt6gq0AQYNEiA21szrUY7tKlTo8N0Il+IEYfxVQggMs82j8Dtwus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730984255; c=relaxed/simple;
	bh=Dxf+YjSfF9s66wnRYYKzNGRdTBF+f3o1p3CcPZ9IKMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gW9uAGkZeSfpCfjMZQkcXbOyvmd0ry2NroH07oMKDdYQbAW1L24cksdINvj51oeN2g2DY7cNEIWvb6T3k/v87y0EubRxvkDGzvhSyPIlUQNAEpG6iKRQDxl+TrLxGAZvbOWWhTRgvoXDa5rIzBG94qZzdJ+lPG4hOV3mz2wsgnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLugXOuS; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLugXOuS"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-71e592d7f6eso625710b3a.3
        for <bridge@lists.linux.dev>; Thu, 07 Nov 2024 04:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730984253; x=1731589053; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHha3jxrqpGXunHNpntG6RFQwcyCzV6dVXG5YPCOYY8=;
        b=SLugXOuSBnlPsa5BUSyzAJ2i/zOXO8zyN8WCCd4nw29x+nGrO0rWiNcZn4y6+oxMWB
         sLICGtypMaj6PxlnPzBLWzhoPSPioWpJ3CUBwEZglH28/eEgXDjwiggHXWsv1xTmjWvD
         aOCS8D42sT2Lnezw7yFVIG93w27GOkRJPdeUG+O5xYZMl3tU65IjKFo47hD3zM10RklI
         djOw3DJPnzjgBOBiZIpemR0Llzo+ZD44chA3pdlXrCYnNrPq8zS8HR4OQrQJaATCfXFO
         hBlyMFbN1KLgV2dOY5rfceEmpwwWAQzt6q/noY73rBZt7j30tEzLEFZdW0qwVcZpO9Nt
         ZrJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730984253; x=1731589053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHha3jxrqpGXunHNpntG6RFQwcyCzV6dVXG5YPCOYY8=;
        b=SMvd5FGd2/O0UwTnWtsN+Verj0G6TnnQq5pNPXGByiyHaAEBk913CAgsROOdydzINC
         eUMvuE78Za+jbxZOEEj0im6o/6W3ZjtLHPHePjdM1iW96rLn8fnXE+AIJyKOx/MyY9w8
         OPU4IawCP0Ke240QWJcnu7fohpkN7zj8eEmbI9YJX9NwY/ZgPFrtFV9zNWdPO28a0mL5
         xFpWl0Zp0Q99Vi3Ys7J7s/QEaCp0FmRZoz2faKZdaki2MtJMyPJ7ra5q9IYLXw5F5KZN
         qmXMd0gpaMkBTYvJvHVud8wrSRHIV3zxLI/sEoxnUJl9EcoDLYPHg4LLNRM1mhTuGVaj
         /Lew==
X-Forwarded-Encrypted: i=1; AJvYcCUCSEjU4Fl9D3ry/0sXdOCfSmlALr1AMR2lJ1zeXllQrQhkwtFIM/kkF0Nzs8pnOkti2Uy4Yww=@lists.linux.dev
X-Gm-Message-State: AOJu0YxB3j9cRIKKJtqFMcWqpeicEGN64ZtxtVjfnsilOlMtGNFdIIo5
	1iUdjtCtl6XEIVYBJvk+Y7g6m/HpuKnrls4WtDBa6DBnPvA30ZUO
X-Google-Smtp-Source: AGHT+IE3eEOgJ1qWU18w+8ZWk4W8v2UIMOmASaaI5mv+vDl7yedq5Q1v/jaYiqKiIcGj1dcxqIst6Q==
X-Received: by 2002:aa7:88c6:0:b0:71e:104d:62fe with SMTP id d2e1a72fcca58-720c99b80b2mr33334379b3a.20.1730984253181;
        Thu, 07 Nov 2024 04:57:33 -0800 (PST)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785ffeesm1441651b3a.3.2024.11.07.04.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 04:57:32 -0800 (PST)
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
Subject: [PATCH net-next v5 7/9] net: ip: make ip_route_input() return drop reasons
Date: Thu,  7 Nov 2024 20:55:59 +0800
Message-Id: <20241107125601.1076814-8-dongml2@chinatelecom.cn>
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

