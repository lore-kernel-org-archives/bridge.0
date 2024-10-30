Received: from mail-oo1-f67.google.com (mail-oo1-f67.google.com [209.85.161.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56A11946CF
	for <bridge@lists.linux.dev>; Wed, 30 Oct 2024 01:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730252589; cv=none; b=TdfSW9AXGcx+sVOCvqyBCtlSRfX9bbpB/ItglmsTNxyaCs7PvDCFzr2uBapueI3/8FjGO7a1EIf4DdjRaek6i6irGZsyFb2NdTSRnI7PBq6nBmgYEd3ypV/ExvDCb9P2QE5wxePO5OQBwmMhqGM2hCCq3WwTbZxvvWKFRhnzeCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730252589; c=relaxed/simple;
	bh=jalKiGNYxieOdmuauWZ46l1HYvkQABXljddM93EYgn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=scffEXbfNdnF22npUwsRL9Q9clR2JzYEf03unOw/U2FZwMc+nEWy5ocLw8oUB8S8ecIo1ccU70xvF/5SBUazNzhb804MqlzMV1825jJvACLiNxOuXp9VXvdeojbf2wmhZTuzgjqqMs5SIfBsJFKoCJuj25zhXqTkZVrK3qqjY1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSm/lc4w; arc=none smtp.client-ip=209.85.161.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSm/lc4w"
Received: by mail-oo1-f67.google.com with SMTP id 006d021491bc7-5ebc349204cso3252465eaf.3
        for <bridge@lists.linux.dev>; Tue, 29 Oct 2024 18:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730252587; x=1730857387; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCNnhtybNfvt04iDpo5zyre6+yqd+pwPbIIAs/JSjPU=;
        b=fSm/lc4wXjlLXnmOm9Y5aubj0ut7cxBvgAJYiKlTjpBmIy3HCMI+HMns13pJtV8jdP
         f190qzh7xfG5jd8THlIDdGnoPdYfH0nXLjzJDIeDsklEDyq0rsq43HmXQ2FxjePBJM4B
         9x6cSLVVswkdTczRaCkftk7cS4nulemh7jCpArwwenwnRq4c8BChHAYqjqG2u8Ss1tSL
         m0oQ1MvnTgxZkCWsxfgXoWaCUP3/P5bG9zSjrlP8lB1b0rqEoKCfW7RxVj5n93pAYGSY
         F9sN/YovziKDNHg3kGOKMfpdT3pqGBbwfQpJiLQKqTUljoyT0T98nJuAStpXBMG04x4k
         GyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730252587; x=1730857387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YCNnhtybNfvt04iDpo5zyre6+yqd+pwPbIIAs/JSjPU=;
        b=ntaHbVNi3RZKiQCRQ4FeIoE+7zPDLBvi8VT1Ze48G3DuCZgUwvVuiUxSdTsLhY5v7p
         63Y7okPAYDKkGDOh1ML+hhRtcXZZMo8C52DVO3/BAKxNwjStzpLxnMZIL+1v7G92s8ND
         I30IM6HOZqyFgt5oAlZ1Cvn1iR4ALUEZ9E9vDyZ8CcSXEhR5bTRTxvAglBguJ9Z6/sNs
         nofDN2nfXeOTALj7/D5Yf5pyCYBYllyPM+lnAg/E703FL/D/CURE9X67RnLntev1Gi++
         oxAI0qRyM5fzoQ2hOxj8PIvEr+nR7B79SVBoW0Gf8Frpkm4fUkWhS6iLOCz+QpRWdeV/
         xPWg==
X-Forwarded-Encrypted: i=1; AJvYcCX9P+sT3N3AkvcqyfuH4Q2d/uG1zccS3RGyTYFGrmZYkng1UVlCsckOjwXRzRthbr9WcHp/syY=@lists.linux.dev
X-Gm-Message-State: AOJu0YzcnoyFPQi+T/fJAOm1YasaiA9y0U2uF07Akx5z5IjZnqJme3O3
	SJ4xwLtqCmz6Lf5rdfFt855KWj6Vn4wM6YB7jkbc3n3hJx3ga0kW
X-Google-Smtp-Source: AGHT+IH8gM6H0784jdmZBrZyrQbLM9r7PuEpBa67ybDtGWd3l7ClBj6fVFjmhgiCBl1je3xf2Fcysg==
X-Received: by 2002:a05:6870:4191:b0:277:fdce:6759 with SMTP id 586e51a60fabf-29051d49f6emr12807010fac.31.1730252586843;
        Tue, 29 Oct 2024 18:43:06 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc866906dsm8138407a12.10.2024.10.29.18.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 18:43:06 -0700 (PDT)
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
Subject: [PATCH RESEND net-next v4 2/9] net: ip: make ip_route_input_mc() return drop reason
Date: Wed, 30 Oct 2024 09:41:38 +0800
Message-Id: <20241030014145.1409628-3-dongml2@chinatelecom.cn>
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

Make ip_route_input_mc() return drop reason, and adjust the call of it
in ip_route_input_rcu().

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 net/ipv4/route.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index f64c0221c221..ccbaf6207299 100644
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

