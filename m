Received: from mail-oa1-f67.google.com (mail-oa1-f67.google.com [209.85.160.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE551B3943
	for <bridge@lists.linux.dev>; Thu, 24 Oct 2024 09:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762495; cv=none; b=a9QkecGG68FWJjdlddc8+FuviajHkMOZY9CGqus7YxEUK376EUmjPs6r7hLUBVglsPpMTMCSvQzUoWKmaXtZsGsJQ6uX7K2FthXt+ESw93LIu1J1mMZixPTYjIhpuAVUBEdYGCGcUvJhz4hFwl+dznotV1snf1cykjImCkdY30c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762495; c=relaxed/simple;
	bh=cCy/lda6L2Cz0Ny93zsNxAuokNc2e7IJ437qVAXid0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=csGTOXZKNxTncclATnqNWT1knFjP3F5xZuzkEtu5hiEaHP5fHC5/B1YMybCpr8e6MbDo2wADQYVmVw/a5Ye6vtqwZDkyjw3w7nvFxrkJsdUrxsKx5mMJI1viZWZwA0T09crP2qzCnKiBTwoHLRENYrJqY+Nxr03+xdZDmiDfq4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPfF1WVM; arc=none smtp.client-ip=209.85.160.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPfF1WVM"
Received: by mail-oa1-f67.google.com with SMTP id 586e51a60fabf-2884e7fad77so389568fac.2
        for <bridge@lists.linux.dev>; Thu, 24 Oct 2024 02:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729762492; x=1730367292; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znmG4LU+dkvIoogMrj5tdOh7xv17KQWidIX+N22GnQg=;
        b=OPfF1WVMQlTgsjsiSeTxo0zgH5lX1XRsHX1TNJqWA2YjgD/eo7L2PK2aP+bsug7Jk+
         6JO1lNHEI3B5q6X5RsPyyQFs9JMxP8bmJMRbjaSYwpdr493FAHYxUhTgaGqOEij3FdCS
         oIDwxaiM7nfC+3nJOTHGLeuijtFsi+bii86QPyQCdJXHHpvBbH1elFf54g6H43MADA68
         OK4af3PtxL1hjwCbyDCgt4x8ocJtx3IwbZ0/T3U3/QjzeEivuvDpCs1wJgPyylNaFdzh
         mVj2j5zEnp4oV5kZeYX5AC/6mqAqwaBv49NppdCpQmPE3hpg9BX/j/ckqdtwk0XEN8uX
         iI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729762492; x=1730367292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=znmG4LU+dkvIoogMrj5tdOh7xv17KQWidIX+N22GnQg=;
        b=P9W+lTh4nHJHBep+kwxNIlBx9bcuyAa2MCu2lbHm9RO7U3le6WiV7nOAM83Whur0y7
         MkHkBlLLVbr5U3JCMubSy7XYbq28EvQcheXhC4QF3X4kDaiC0oXUfvwAKZLVOuQ+wG0h
         z5OJd0KLZdSOCFV76YS/aBeomH81UWgu+ySGNbwB++l+WwTyoXFnB56CpaC8MPM+bS6w
         dP38sqDx4she8m1y+GgoMuLZMAlAO1SpdMqt4hOwewb0iEun5zh6nEhG7qsUTxjJk2Rp
         1az/Wbs4G08WyBtS1LWPmCgBPg0DRkbYt4B5mvNGPjt6YVQ842XwvLaTzPYcHdDUq8ff
         p17g==
X-Forwarded-Encrypted: i=1; AJvYcCV44C4nhR1vtNhoBOJMqetK8+wv1PI46L0HGrhxWzqvr0FR7YSFXTbbZmEmJ0kHkTxawF1zWNc=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzfa949ZyMax2E/pPxp14X+FLbggl0ngWTyBcgH5rUEnXu2xHKn
	qqVxP8FU1NoGmxvonRzRbtd82snscZAWs41xnnPt/vKHz/h4Zs5E
X-Google-Smtp-Source: AGHT+IHlP78/7AG+7AUKWTVBYlw/SMFQGR68T7fk+J3NIh7b170uLsi52Y+9MJB2QEu/FZGvx+zaeA==
X-Received: by 2002:a05:6870:1f0a:b0:287:886:2e62 with SMTP id 586e51a60fabf-28ced26f849mr1367558fac.12.1729762491885;
        Thu, 24 Oct 2024 02:34:51 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1415071sm7600287b3a.217.2024.10.24.02.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:34:51 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 2/9] net: ip: make ip_route_input_mc() return drop reason
Date: Thu, 24 Oct 2024 17:33:41 +0800
Message-Id: <20241024093348.353245-3-dongml2@chinatelecom.cn>
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

Make ip_route_input_mc() return drop reason, and adjust the call of it
in ip_route_input_rcu().

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 net/ipv4/route.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 3e7a3e947b7d..e579fe5bd3d3 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1696,8 +1696,9 @@ int ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 }
 
 /* called in rcu_read_lock() section */
-static int ip_route_input_mc(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			     dscp_t dscp, struct net_device *dev, int our)
+static enum skb_drop_reason
+ip_route_input_mc(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+		  dscp_t dscp, struct net_device *dev, int our)
 {
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
 	unsigned int flags = RTCF_MULTICAST;
@@ -1708,7 +1709,7 @@ static int ip_route_input_mc(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	err = ip_mc_validate_source(skb, daddr, saddr, dscp, dev, in_dev,
 				    &itag);
 	if (err)
-		return err;
+		return SKB_DROP_REASON_NOT_SPECIFIED;
 
 	if (our)
 		flags |= RTCF_LOCAL;
@@ -1719,7 +1720,7 @@ static int ip_route_input_mc(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	rth = rt_dst_alloc(dev_net(dev)->loopback_dev, flags, RTN_MULTICAST,
 			   false);
 	if (!rth)
-		return -ENOBUFS;
+		return SKB_DROP_REASON_NOMEM;
 
 #ifdef CONFIG_IP_ROUTE_CLASSID
 	rth->dst.tclassid = itag;
@@ -1735,7 +1736,7 @@ static int ip_route_input_mc(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 
 	skb_dst_drop(skb);
 	skb_dst_set(skb, &rth->dst);
-	return 0;
+	return SKB_NOT_DROPPED_YET;
 }
 
 
@@ -2433,12 +2434,12 @@ static int ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	 * route cache entry is created eventually.
 	 */
 	if (ipv4_is_multicast(daddr)) {
+		enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 		struct in_device *in_dev = __in_dev_get_rcu(dev);
 		int our = 0;
-		int err = -EINVAL;
 
 		if (!in_dev)
-			return err;
+			return -EINVAL;
 		our = ip_check_mc_rcu(in_dev, daddr, saddr,
 				      ip_hdr(skb)->protocol);
 
@@ -2459,10 +2460,10 @@ static int ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		     IN_DEV_MFORWARD(in_dev))
 #endif
 		   ) {
-			err = ip_route_input_mc(skb, daddr, saddr, dscp, dev,
-						our);
+			reason = ip_route_input_mc(skb, daddr, saddr, dscp,
+						   dev, our);
 		}
-		return err;
+		return reason ? -EINVAL : 0;
 	}
 
 	return ip_route_input_slow(skb, daddr, saddr, dscp, dev, res);
-- 
2.39.5

