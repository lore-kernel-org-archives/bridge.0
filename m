Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544931D5142
	for <bridge@lists.linux.dev>; Tue, 15 Oct 2024 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729001367; cv=none; b=rb3PlMLkkPFkQC3WsmMjlhtkT3scepyGXvSxy0cR3pLBDXxYMIUd2vyjHJiTtR3Zb8EYlKlHNgwS/m2pmJvRXcMQb8vWpFyVQGaAS7rOGcQHxO2pXInmcTvpAn6bc6h+KUrnrTNumXzpEjuG6j00IqPtuDZQr3DpU1Vqdq3QOjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729001367; c=relaxed/simple;
	bh=J47DiM7it9UqLoIOTYLS3JMdWYRznJt9vbjuYFkxJkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kPmkXvCr2Gtk4UMm6fOgiDkqMpsJe/F9toK5Q+9FmIRpHfuxj3urg7fmk+CHtCxgoJypBFJBA8L4Lm7+XJAB/+e3AwWAQke8qOcpZtLYh2ZAnkunuZIulFEKM2QaLNZrmxZ+s9r5kSdf6f/+rohprLBLuN/99uaNUqYP7kzQslc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9qDfzEG; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9qDfzEG"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-20c7ee8fe6bso39337175ad.2
        for <bridge@lists.linux.dev>; Tue, 15 Oct 2024 07:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729001366; x=1729606166; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xu2WL8L9YsDBkU34XcEw9nzL+sIi7gQQkUV02cDwen8=;
        b=A9qDfzEGEsmqZxl1cAKkBPwBwMzpup0Jr54JywpurTkxm4tC5hbC343H87McJ5SKni
         r9A1cXSJVNP5iHLvgsAxXEMo/6sKeSvJQ8M2JuoqJ9Qm8L16DdYpVBWlCJMMuEgrtNuk
         e2wGJwdFzkVzmpkE8zQC2yR1GYRhOyKGizBoxU/u9/LB1RGb0Eu+ug5mmagTnjw+GLKr
         7IgMiYAL/gxXJVLY8qfngR4k8zyxWUt2NYtyJrEWi3S8gkqMorsDP+oMFs2iUcLdz6ea
         3ELhGuckRRSeZxMIqra4l8GsW8+YfGL1lNdc3zKwOY9dfNBBvA/zWeOREdIbWhHNxH28
         Q05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729001366; x=1729606166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xu2WL8L9YsDBkU34XcEw9nzL+sIi7gQQkUV02cDwen8=;
        b=DKzjBu6RrrYV95AmZeiMdisBgsk5SYyo1OTbiDGmRXLli34Bnr32dW0+ZuEidMj/k8
         rhwMe2CcWTS63DThf/mJVLAZOC45A9y+AJJ3RQqKyzVjLQGoYEZVoE5TeGcnfG5Xzesk
         1kWOhcM+XMj7j43THqYxYDWL/+MJ/W4rvznBjdqHekEDAvcOM9aaXAhOrQNJhxzvcuOk
         5crroN8L3evudGssyRoVBvpk01Rjkih7gf+a0PPN43/wnQpfiTvSsRxX/B0zROHQFFCr
         01e5CP5sAoNwr098oSdx4f8NdALkn05OWdgNHp7rmUVSBkgXBixPQVEB8M3sHn5KdGYn
         Ge2A==
X-Forwarded-Encrypted: i=1; AJvYcCX6Y1SWd6Dp+9f4QI19TL/p78lMgdTpvHoOtFCbGZXN8RpMEN3ixpO5e1AodhQ8jSeJ5SLzrQE=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyq74whDQkM0AGUiGdnveSmn7eA/pmL8bzRh16v0CRVLpcQUHDO
	Mun/ZPgIpLkS1YC0xfd//+7DnyBqSYMWS3PWeC+Z+wURsVxZEbk3
X-Google-Smtp-Source: AGHT+IEEdhkY93DkVnsHYKcg3Nn1LJ22CyQpWTu6lhDCBND8N0iZZ4Hbvrszipi9s+zu9OsPn3PgDw==
X-Received: by 2002:a17:903:230b:b0:20c:e262:2580 with SMTP id d9443c01a7336-20d27f0d040mr5161505ad.44.1729001365587;
        Tue, 15 Oct 2024 07:09:25 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f9d419sm12437625ad.93.2024.10.15.07.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 07:09:25 -0700 (PDT)
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
Subject: [PATCH net-next v3 10/10] net: ip: make ip_route_use_hint() return drop reasons
Date: Tue, 15 Oct 2024 22:08:00 +0800
Message-Id: <20241015140800.159466-11-dongml2@chinatelecom.cn>
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

In this commit, we make ip_route_use_hint() return drop reasons. The
drop reasons that we return are similar to what we do in
ip_route_input_slow(), and no drop reasons are added in this commit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/net/route.h |  7 ++++---
 net/ipv4/ip_input.c |  9 ++++-----
 net/ipv4/route.c    | 26 ++++++++++++++++----------
 3 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index f4ab5412c9c9..4debc335d276 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -206,9 +206,10 @@ ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 enum skb_drop_reason
 ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		     dscp_t dscp, struct net_device *dev);
-int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-		      dscp_t dscp, struct net_device *dev,
-		      const struct sk_buff *hint);
+enum skb_drop_reason
+ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+		  dscp_t dscp, struct net_device *dev,
+		  const struct sk_buff *hint);
 
 static inline enum skb_drop_reason
 ip_route_input(struct sk_buff *skb, __be32 dst, __be32 src, dscp_t dscp,
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index 513eb0c6435a..f0a4dda246ab 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -322,15 +322,14 @@ static int ip_rcv_finish_core(struct net *net, struct sock *sk,
 	int err, drop_reason;
 	struct rtable *rt;
 
-	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
-
 	if (ip_can_use_hint(skb, iph, hint)) {
-		err = ip_route_use_hint(skb, iph->daddr, iph->saddr,
-					ip4h_dscp(iph), dev, hint);
-		if (unlikely(err))
+		drop_reason = ip_route_use_hint(skb, iph->daddr, iph->saddr,
+						ip4h_dscp(iph), dev, hint);
+		if (unlikely(drop_reason))
 			goto drop_error;
 	}
 
+	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	if (READ_ONCE(net->ipv4.sysctl_ip_early_demux) &&
 	    !skb_dst(skb) &&
 	    !skb->sk &&
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index cb6beb270265..fe57f6abf53e 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2142,28 +2142,34 @@ ip_mkroute_input(struct sk_buff *skb, struct fib_result *res,
  * assuming daddr is valid and the destination is not a local broadcast one.
  * Uses the provided hint instead of performing a route lookup.
  */
-int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-		      dscp_t dscp, struct net_device *dev,
-		      const struct sk_buff *hint)
+enum skb_drop_reason
+ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+		  dscp_t dscp, struct net_device *dev,
+		  const struct sk_buff *hint)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
 	struct rtable *rt = skb_rtable(hint);
 	struct net *net = dev_net(dev);
-	enum skb_drop_reason reason;
-	int err = -EINVAL;
 	u32 tag = 0;
 
 	if (!in_dev)
-		return -EINVAL;
+		return reason;
 
-	if (ipv4_is_multicast(saddr) || ipv4_is_lbcast(saddr))
+	if (ipv4_is_multicast(saddr) || ipv4_is_lbcast(saddr)) {
+		reason = SKB_DROP_REASON_IP_INVALID_SOURCE;
 		goto martian_source;
+	}
 
-	if (ipv4_is_zeronet(saddr))
+	if (ipv4_is_zeronet(saddr)) {
+		reason = SKB_DROP_REASON_IP_INVALID_SOURCE;
 		goto martian_source;
+	}
 
-	if (ipv4_is_loopback(saddr) && !IN_DEV_NET_ROUTE_LOCALNET(in_dev, net))
+	if (ipv4_is_loopback(saddr) && !IN_DEV_NET_ROUTE_LOCALNET(in_dev, net)) {
+		reason = SKB_DROP_REASON_IP_LOCALNET;
 		goto martian_source;
+	}
 
 	if (rt->rt_type != RTN_LOCAL)
 		goto skip_validate_source;
@@ -2179,7 +2185,7 @@ int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 
 martian_source:
 	ip_handle_martian_source(dev, in_dev, skb, daddr, saddr);
-	return err;
+	return reason;
 }
 
 /* get device for dst_alloc with local routes */
-- 
2.39.5

