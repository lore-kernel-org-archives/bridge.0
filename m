Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773241B6D18
	for <bridge@lists.linux.dev>; Thu, 24 Oct 2024 09:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762521; cv=none; b=EKlYeV/eSTdskSujxmEQLVvfYdSlkGideXznTmk3wwZ10O5YQSjJaUesbCv/KjAw9jvKGMRp6EPGHespkA83T9dDhCKC6eN54OSrx3Wdblx1z0zBDoWYQp1iauILU4q3UyyX+tpWAP4Xzwu32gwjTGmIJSJlaCRr6h0rQe7LJqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762521; c=relaxed/simple;
	bh=cJ0OGLfON7rfzJI4gOqeXOhVCn6upuw2yPV7fi7n4MQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ERg+hXIPEISks2+N0kMb76dKcuO81x5n8OpCeDv3qHoLhuYr/tOQPSPf5D9/1XGfNK0tV5+6N6bJoLPnUtOwihehoZ2Ob6aiXC+nIWBVgTgNnbj8hWj9gF9omJ5tFqyySY5lFqnl/jzLzZi/P/f9r2AWJDL/4OC/hvW1CrFnciw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U18isITY; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U18isITY"
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-7ed9f1bcb6bso411416a12.1
        for <bridge@lists.linux.dev>; Thu, 24 Oct 2024 02:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729762515; x=1730367315; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4GMKPzguG4mlKFwZhzBDmmWl0vg75LYwmRRCcfaNtRw=;
        b=U18isITYNZkLgmYLaKHcJuj2l8aZykSQPNk71NIbVj2MBw2Sa3dpllfMC4AL6GJpdr
         vZeR1wCc00t/4zNyqDDlFvWjnkmnY7FMs+bDhWs4TaXDblfTynxTHV9V8extfrz4YKeI
         HBr9P9iPQm8UM2LT3PsST1pxXWED5hKDVh5kK5m/RKrnPvN9IFgPe2ac8yFRXx2AcDrJ
         cGMKsydipZMACdWPTxK82Zj2g9/3ciLv8J/Xhzrb2LvZ7HYrBmCvoOo0mEnlPUIIkOlS
         SevnoFmD9Y6Y804KFE4uDIrDR9g7aBXFdhgyEMmru/frwUdV2JNyLtxybo9qa/ii3tFz
         r+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729762515; x=1730367315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4GMKPzguG4mlKFwZhzBDmmWl0vg75LYwmRRCcfaNtRw=;
        b=rlhdu0LPemjMY1AxNECyl160BljhgxWDiy7fSC3XjOgoBQ9LAJVMJSCQggGtwmn5KW
         t9AKg3KnpixORHuBj9fnyNxj8zrob1rKquoq/uJqf3rqfenFj1hGD7gtWPSNSnvs/ABu
         OmtCmEVpBPVIJjpOHS+j1b7CwweKgM6keMcEZoviDaDACadTi29G5+hHTbkIEgUc6aqr
         w0I7O54MlhkhtnQk2AFAjmbvQxThshY7ILLKUq2rttQBS/tpSlJQmwdoUD1FNk57FbjJ
         Tj1lx+40ZlrJug+i+2eRAWcNSE/yZADFiUbgrKU9S9DrNR1HowMR59qr9QKT1pqcMJG7
         IAGQ==
X-Forwarded-Encrypted: i=1; AJvYcCURyaxdoYuU7mPJTNRqFHaByN7cHKouKYZjV93YtGOcidkIiodsEo7eNnmwBrYHiCI/bNc2sQM=@lists.linux.dev
X-Gm-Message-State: AOJu0YwHL5XGCX7gcvTcBtpZ5Obe5X88Nw+xutsdCZwWE3YBTlEqNUng
	0+cBNvhdvjjDESmbsBB/z8RpzvWTZNPjgRkD6BuULo1sHhWUbE3n
X-Google-Smtp-Source: AGHT+IH9dDA5gU7g4QgEHskFkl8XfuOQh79z1eQgclz1Dh1YoNkH/2OIUkhoMgBdVlcei/4GI6Xn+w==
X-Received: by 2002:a05:6300:4043:b0:1d9:29c8:2d32 with SMTP id adf61e73a8af0-1d9898ff732mr1534360637.5.1729762514698;
        Thu, 24 Oct 2024 02:35:14 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1415071sm7600287b3a.217.2024.10.24.02.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:35:14 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 6/9] net: ip: make ip_route_input_noref() return drop reasons
Date: Thu, 24 Oct 2024 17:33:45 +0800
Message-Id: <20241024093348.353245-7-dongml2@chinatelecom.cn>
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

In this commit, we make ip_route_input_noref() return drop reasons, which
come from ip_route_input_rcu().

We need adjust the callers of ip_route_input_noref() to make sure the
return value of ip_route_input_noref() is used properly.

The errno that ip_route_input_noref() returns comes from ip_route_input
and bpf_lwt_input_reroute in the origin logic, and we make them return
-EINVAL on error instead. In the following patch, we will make
ip_route_input() returns drop reasons too.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v4:
- introduce the variable "reason" in bpf_lwt_input_reroute() to make
  things clear
---
 include/net/route.h    | 15 ++++++++-------
 net/core/lwt_bpf.c     |  6 ++++--
 net/ipv4/ip_fragment.c | 12 +++++++-----
 net/ipv4/ip_input.c    |  7 ++++---
 net/ipv4/route.c       |  7 ++++---
 5 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index a828a17a6313..11674f7c6be6 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -203,8 +203,9 @@ enum skb_drop_reason
 ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		      dscp_t dscp, struct net_device *dev,
 		      struct in_device *in_dev, u32 *itag);
-int ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			 dscp_t dscp, struct net_device *dev);
+enum skb_drop_reason
+ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+		     dscp_t dscp, struct net_device *dev);
 int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		      dscp_t dscp, struct net_device *dev,
 		      const struct sk_buff *hint);
@@ -212,18 +213,18 @@ int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 static inline int ip_route_input(struct sk_buff *skb, __be32 dst, __be32 src,
 				 dscp_t dscp, struct net_device *devin)
 {
-	int err;
+	enum skb_drop_reason reason;
 
 	rcu_read_lock();
-	err = ip_route_input_noref(skb, dst, src, dscp, devin);
-	if (!err) {
+	reason = ip_route_input_noref(skb, dst, src, dscp, devin);
+	if (!reason) {
 		skb_dst_force(skb);
 		if (!skb_dst(skb))
-			err = -EINVAL;
+			reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	}
 	rcu_read_unlock();
 
-	return err;
+	return reason ? -EINVAL : 0;
 }
 
 void ipv4_update_pmtu(struct sk_buff *skb, struct net *net, u32 mtu, int oif,
diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index e0ca24a58810..8a78bff53b2c 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -88,6 +88,7 @@ static int run_lwt_bpf(struct sk_buff *skb, struct bpf_lwt_prog *lwt,
 
 static int bpf_lwt_input_reroute(struct sk_buff *skb)
 {
+	enum skb_drop_reason reason;
 	int err = -EINVAL;
 
 	if (skb->protocol == htons(ETH_P_IP)) {
@@ -96,8 +97,9 @@ static int bpf_lwt_input_reroute(struct sk_buff *skb)
 
 		dev_hold(dev);
 		skb_dst_drop(skb);
-		err = ip_route_input_noref(skb, iph->daddr, iph->saddr,
-					   ip4h_dscp(iph), dev);
+		reason = ip_route_input_noref(skb, iph->daddr, iph->saddr,
+					      ip4h_dscp(iph), dev);
+		err = reason ? -EINVAL : 0;
 		dev_put(dev);
 	} else if (skb->protocol == htons(ETH_P_IPV6)) {
 		skb_dst_drop(skb);
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index 48e2810f1f27..52b991e976ba 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -132,12 +132,12 @@ static bool frag_expire_skip_icmp(u32 user)
  */
 static void ip_expire(struct timer_list *t)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_FRAG_REASM_TIMEOUT;
 	struct inet_frag_queue *frag = from_timer(frag, t, timer);
 	const struct iphdr *iph;
 	struct sk_buff *head = NULL;
 	struct net *net;
 	struct ipq *qp;
-	int err;
 
 	qp = container_of(frag, struct ipq, q);
 	net = qp->q.fqdir->net;
@@ -175,10 +175,12 @@ static void ip_expire(struct timer_list *t)
 
 	/* skb has no dst, perform route lookup again */
 	iph = ip_hdr(head);
-	err = ip_route_input_noref(head, iph->daddr, iph->saddr, ip4h_dscp(iph),
-				   head->dev);
-	if (err)
+	reason = ip_route_input_noref(head, iph->daddr, iph->saddr,
+				      ip4h_dscp(iph), head->dev);
+	if (reason)
 		goto out;
+	else
+		reason = SKB_DROP_REASON_FRAG_REASM_TIMEOUT;
 
 	/* Only an end host needs to send an ICMP
 	 * "Fragment Reassembly Timeout" message, per RFC792.
@@ -195,7 +197,7 @@ static void ip_expire(struct timer_list *t)
 	spin_unlock(&qp->q.lock);
 out_rcu_unlock:
 	rcu_read_unlock();
-	kfree_skb_reason(head, SKB_DROP_REASON_FRAG_REASM_TIMEOUT);
+	kfree_skb_reason(head, reason);
 	ipq_put(qp);
 }
 
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index c40a26972884..513eb0c6435a 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -362,10 +362,11 @@ static int ip_rcv_finish_core(struct net *net, struct sock *sk,
 	 *	how the packet travels inside Linux networking.
 	 */
 	if (!skb_valid_dst(skb)) {
-		err = ip_route_input_noref(skb, iph->daddr, iph->saddr,
-					   ip4h_dscp(iph), dev);
-		if (unlikely(err))
+		drop_reason = ip_route_input_noref(skb, iph->daddr, iph->saddr,
+						   ip4h_dscp(iph), dev);
+		if (unlikely(drop_reason))
 			goto drop_error;
+		drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	} else {
 		struct in_device *in_dev = __in_dev_get_rcu(dev);
 
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 4b0daf3510d7..757526e450fd 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2487,8 +2487,9 @@ ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	return ip_route_input_slow(skb, daddr, saddr, dscp, dev, res);
 }
 
-int ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			 dscp_t dscp, struct net_device *dev)
+enum skb_drop_reason ip_route_input_noref(struct sk_buff *skb, __be32 daddr,
+					  __be32 saddr, dscp_t dscp,
+					  struct net_device *dev)
 {
 	enum skb_drop_reason reason;
 	struct fib_result res;
@@ -2497,7 +2498,7 @@ int ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	reason = ip_route_input_rcu(skb, daddr, saddr, dscp, dev, &res);
 	rcu_read_unlock();
 
-	return reason ? -EINVAL : 0;
+	return reason;
 }
 EXPORT_SYMBOL(ip_route_input_noref);
 
-- 
2.39.5

