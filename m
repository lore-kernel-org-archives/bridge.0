Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079C71C07D5
	for <bridge@lists.linux.dev>; Tue, 15 Oct 2024 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729001322; cv=none; b=KOli/AOSwdfFOmfmZayj6KXKj2PrhXGvjzYMCChaHH9RGAMq4wF2cTIQeM0qKAZ0RUAu83DNuZiCjmdw5qpq8NUdE/ZRnNEHt2hovdlCRlu+4O2++d4sZsARUQliXwQ3R6paLfLtGdB+5z8/zYY/nHcx1CVZEVAmURWD/PCJzTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729001322; c=relaxed/simple;
	bh=hxuu0/nkjUZhdJBDoDA6hN+7VvuYgi9BaKCsHp4WTvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V+LPdTB8wxS7tYGwYQuxKSJH1C1aGjX+X8dlq6DPK5PMlO+yFwPbcAEOkBYjtJ/flgoQQJHMRBhtPWMKw/t9WbPztSgpuDNgset+qK/6i2s6bQ6P/Fh8vcY8VspQ7yaSqcmZgetfKA2v8M0l2tzLjZ5ssXDAJRF6tPU5ni1kEnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnALKwwe; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnALKwwe"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-20cb47387ceso29796175ad.1
        for <bridge@lists.linux.dev>; Tue, 15 Oct 2024 07:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729001320; x=1729606120; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6anbrvmLOQ4OBsRRG9oOEYV2Hqq5hOWvdDoNzx76NA=;
        b=gnALKwweBdza1cGKG0+FzVd7m5hB0MvABFRESBcwUajhem8MQOjKmMvp/4+MFQ5iaZ
         SjWgJnF/bSowoE/TKQhD+3r5oIiEne8YI9K/7JMrJDVuJvbZLM01y0ry/y7+fHT4aFNA
         f2Uq9ySVcfJ5ol/Ia/X0Yz2EGb19e4fNwjuKYYi3CFo62+y5OBe5uqRn2lA5b4l+evWE
         87SpmoI5P6bPrx3kdR1DZ680aTCf11CYz1X8Dgdcxpv5PkBjQxX7feauTzZI4b14EznZ
         qBXqJlMlHbSyfzZIj+p7C5nnzdyH1+tEpvokAG1BIlAGxrYsk3gVETX3zJXk+qhntFcg
         lqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729001320; x=1729606120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6anbrvmLOQ4OBsRRG9oOEYV2Hqq5hOWvdDoNzx76NA=;
        b=V5rwG5VjWtKTlBpki5x8jd4oQ5OEFUBdk+U44Z5jCPDH9K0s0/mJzzQ1wA8C12sqUt
         2Pyhr3U1+Ocg0+t2jJEpknpgwCYZmFOFrSb9/TLzoBFsuolMhRmyKiV0s2y9lg2z4Kf+
         cta4xwxwp9kojaVkCAToIsgoKUZoa7VZ40999Tgd24/eeliBDc39FIihrZqZJLNN8gj4
         GxdqE02zU7ocq/VVh2dybFtvF4SopBkQ4lmIeKFtPEC+YnnVbBxVkvE88/8VHIgekIEA
         BTKhjbrHKbuxkV5YKheC8e41LCyrqGp2tCP0MN3uiXKfseU2Zr3lbG5C/nKoLoqs8CFT
         /Dyg==
X-Forwarded-Encrypted: i=1; AJvYcCXEkMPTy9zQzzYnbBPGdP4XJPucmhSj9b9aQ2dL2THrSfsLCTKgi1OS8syhSMK6iIt6kFAz3Bs=@lists.linux.dev
X-Gm-Message-State: AOJu0YzrSU2OaMhY7cEdypqPGsSh2BftkgA7bkdTR9HIT2JLwn25W605
	YAHvSuQzTVf5l9KVhGD0FRf0iYp/CyacT1Fa/Bm7v27TRZBolTuR
X-Google-Smtp-Source: AGHT+IHy9wxqvfUD56h4WGgeKK4L4pmA46wTKG+SP1RfTiUWV4iaj1nLQ/39xSFLus0hu5kRNmPScA==
X-Received: by 2002:a17:902:ce0c:b0:203:a0ea:63c5 with SMTP id d9443c01a7336-20d2766b76fmr5604655ad.0.1729001320111;
        Tue, 15 Oct 2024 07:08:40 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f9d419sm12437625ad.93.2024.10.15.07.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 07:08:39 -0700 (PDT)
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
Subject: [PATCH net-next v3 04/10] net: ip: make ip_mc_validate_source() return drop reason
Date: Tue, 15 Oct 2024 22:07:54 +0800
Message-Id: <20241015140800.159466-5-dongml2@chinatelecom.cn>
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

Make ip_mc_validate_source() return drop reason, and adjust the call of
it in ip_route_input_mc().

Another caller of it is ip_rcv_finish_core->udp_v4_early_demux, and the
errno is not checked in detail, so we don't do more adjustment for it.

The drop reason "SKB_DROP_REASON_IP_LOCALNET" is added in this commit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/net/dropreason-core.h |  3 +++
 include/net/route.h           |  7 ++++---
 net/ipv4/route.c              | 35 +++++++++++++++++++----------------
 3 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 62a60be1db84..a2a1fb90e0e5 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -78,6 +78,7 @@
 	FN(IP_INNOROUTES)		\
 	FN(IP_LOCAL_SOURCE)		\
 	FN(IP_INVALID_SOURCE)		\
+	FN(IP_LOCALNET)			\
 	FN(PKT_TOO_BIG)			\
 	FN(DUP_FRAG)			\
 	FN(FRAG_REASM_TIMEOUT)		\
@@ -383,6 +384,8 @@ enum skb_drop_reason {
 	 * 2) source ip is zero and not IGMP
 	 */
 	SKB_DROP_REASON_IP_INVALID_SOURCE,
+	/** @SKB_DROP_REASON_IP_LOCALNET: source or dest ip is local net */
+	SKB_DROP_REASON_IP_LOCALNET,
 	/**
 	 * @SKB_DROP_REASON_PKT_TOO_BIG: packet size is too big (maybe exceed the
 	 * MTU)
diff --git a/include/net/route.h b/include/net/route.h
index 586e59f7ed8a..a828a17a6313 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -199,9 +199,10 @@ static inline struct rtable *ip_route_output_gre(struct net *net, struct flowi4
 	return ip_route_output_key(net, fl4);
 }
 
-int ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			  dscp_t dscp, struct net_device *dev,
-			  struct in_device *in_dev, u32 *itag);
+enum skb_drop_reason
+ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+		      dscp_t dscp, struct net_device *dev,
+		      struct in_device *in_dev, u32 *itag);
 int ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 			 dscp_t dscp, struct net_device *dev);
 int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 7f989e8eff30..917f05a0a5ce 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1665,34 +1665,37 @@ struct rtable *rt_dst_clone(struct net_device *dev, struct rtable *rt)
 EXPORT_SYMBOL(rt_dst_clone);
 
 /* called in rcu_read_lock() section */
-int ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			  dscp_t dscp, struct net_device *dev,
-			  struct in_device *in_dev, u32 *itag)
+enum skb_drop_reason
+ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+		      dscp_t dscp, struct net_device *dev,
+		      struct in_device *in_dev, u32 *itag)
 {
 	enum skb_drop_reason reason;
 
 	/* Primary sanity checks. */
 	if (!in_dev)
-		return -EINVAL;
+		return SKB_DROP_REASON_NOT_SPECIFIED;
 
-	if (ipv4_is_multicast(saddr) || ipv4_is_lbcast(saddr) ||
-	    skb->protocol != htons(ETH_P_IP))
-		return -EINVAL;
+	if (ipv4_is_multicast(saddr) || ipv4_is_lbcast(saddr))
+		return SKB_DROP_REASON_IP_INVALID_SOURCE;
+
+	if (skb->protocol != htons(ETH_P_IP))
+		return SKB_DROP_REASON_INVALID_PROTO;
 
 	if (ipv4_is_loopback(saddr) && !IN_DEV_ROUTE_LOCALNET(in_dev))
-		return -EINVAL;
+		return SKB_DROP_REASON_IP_LOCALNET;
 
 	if (ipv4_is_zeronet(saddr)) {
 		if (!ipv4_is_local_multicast(daddr) &&
 		    ip_hdr(skb)->protocol != IPPROTO_IGMP)
-			return -EINVAL;
+			return SKB_DROP_REASON_IP_INVALID_SOURCE;
 	} else {
 		reason = fib_validate_source(skb, saddr, 0, dscp, 0, dev,
 					     in_dev, itag);
 		if (reason)
-			return -EINVAL;
+			return reason;
 	}
-	return 0;
+	return SKB_NOT_DROPPED_YET;
 }
 
 /* called in rcu_read_lock() section */
@@ -1702,14 +1705,14 @@ ip_route_input_mc(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 {
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
 	unsigned int flags = RTCF_MULTICAST;
+	enum skb_drop_reason reason;
 	struct rtable *rth;
 	u32 itag = 0;
-	int err;
 
-	err = ip_mc_validate_source(skb, daddr, saddr, dscp, dev, in_dev,
-				    &itag);
-	if (err)
-		return SKB_DROP_REASON_NOT_SPECIFIED;
+	reason = ip_mc_validate_source(skb, daddr, saddr, dscp, dev, in_dev,
+				       &itag);
+	if (reason)
+		return reason;
 
 	if (our)
 		flags |= RTCF_LOCAL;
-- 
2.39.5

