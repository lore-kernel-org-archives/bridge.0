Received: from mail-io1-f67.google.com (mail-io1-f67.google.com [209.85.166.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FAA193418
	for <bridge@lists.linux.dev>; Wed, 30 Oct 2024 01:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730252584; cv=none; b=CXjwW2hOyPpidyGx54+Bua+2OSL/4GGIwEzNzAOOpkZhsFeBEgP4gRgZZTkwcMzYYPWFFK6ZFZpbCK2jlbsLG20XnY6swJCt2smEA/v05YtdtTa4Hfrg8V+2ERYcW1rAu6vnGFrD7eDIdhrs3o+qhbGgrUyB+fFqF8J9fcLkDtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730252584; c=relaxed/simple;
	bh=VRFZX0PxZ+x+OxZ+v3J66P8Bzgc+fTvBmulPtkU+gqY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B6JEzUn4dL+v2D5g8YO/2j4WKuXK6CRS28CwkiJbETNFf2dHUjjMygo+hqApjpg4YUs0ZujITn+/EuALEiJqcgDeuG/OSAtTo1VYIWZLyluRs2mKLdPH2nl8e7jquYDI6IBNS9h5DkdLfkohp5y2P3H6onHx2NDtg0zSxAZBaBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsJ+kw3J; arc=none smtp.client-ip=209.85.166.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsJ+kw3J"
Received: by mail-io1-f67.google.com with SMTP id ca18e2360f4ac-83ab5b4b048so244644539f.2
        for <bridge@lists.linux.dev>; Tue, 29 Oct 2024 18:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730252581; x=1730857381; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6G2CC+sHGPF4Txdej5kZadhy+Szsb6AhNP7Za8Jlvvk=;
        b=VsJ+kw3Jkvee22zO1wd6eIgffC5skmCPAmg3Q1C3jgLaHTkz6AKD6BDhTOwe0uwtAD
         T8ehevdibU/HxNkdm60yUkEEmQXk++Qg8aJlq63V2IrvRT0D23TRejgU10IsBXbwvPSl
         dtNs1MeM8+lWnIOGTUU4sglnO5akB14HpBBjvAZMbPlLA8ITcON9YosCq99mR+l+eccY
         6fhiYxTV0HwjqTKYt3XXCHoka38YtEOz68ffHDWcu1/ODEvLbrwsFKqsv4NIXEer9HQS
         9Y9vLwFIQOEdZuxcfPCXw2xiP55bY/nKq2KAQeXwTpLHHT+vtB/qBOOuAHTSXVVmtLXX
         DTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730252581; x=1730857381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6G2CC+sHGPF4Txdej5kZadhy+Szsb6AhNP7Za8Jlvvk=;
        b=EYaeB0lLEDClDOcwjvUwkV0E4U90hKWobHJkur+/gCUa/BWh3QKzzT1WmloiX0cqAe
         aUG0QypdtkfAy2wCfFMZvERdQYzgpQ5GXzPDEr/Kq+VLVOP9Gq5nHknKPRndXCzda6jk
         VMyh36M2LjxO8DU9dTPb44YpNrUOFA3PqdyqysK1VEUz7rHQoamZR5kRmZHe/gccTXQ3
         w3xJZJ7OrNfx0iUJ8m9gBks4VgJHNxp6npvTq+p4ii9MrO2LUW6re/INrc56KShf6F/n
         rsUaHhrxzltjK5HJMooCw3PLDRbJ+yqRhH31L7N2fKF578tnj2E7TL1+A0GcUhXEjKxX
         oSZg==
X-Forwarded-Encrypted: i=1; AJvYcCVzqKeJ9NH3QgbIZ2kvtpYw5lTQVLeUjwaiHVRBO+VhFDhkfAPmc5NcnK5EOTWxNjqPwLFaC4s=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2hgTsqU/m5hIW+xCtko3J+usjFU1p3sgbTNW3U/iS7bB3M0iI
	KatdEgQixjnhdvbWNIboQnrGhBqs3JpwdXiy8FDC/XjYJBLtRTfO
X-Google-Smtp-Source: AGHT+IGK/Bom/ziWuMrmOalMch1SIV5PLSJf5PfU79hyLLPx7QQeAwQNfud9F8HBJLvUQiUq63287A==
X-Received: by 2002:a05:6e02:19ca:b0:3a4:e38f:5ba5 with SMTP id e9e14a558f8ab-3a4ed2a9d8emr143755305ab.15.1730252580599;
        Tue, 29 Oct 2024 18:43:00 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc866906dsm8138407a12.10.2024.10.29.18.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 18:43:00 -0700 (PDT)
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
Subject: [PATCH RESEND net-next v4 1/9] net: ip: make fib_validate_source() support drop reasons
Date: Wed, 30 Oct 2024 09:41:37 +0800
Message-Id: <20241030014145.1409628-2-dongml2@chinatelecom.cn>
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

In this commit, we make fib_validate_source() and __fib_validate_source()
return -reason instead of errno on error.

The return value of fib_validate_source can be -errno, 0, and 1. It's hard
to make fib_validate_source() return drop reasons directly.

The fib_validate_source() will return 1 if the scope of the source(revert)
route is HOST. And the __mkroute_input() will mark the skb with
IPSKB_DOREDIRECT in this case (combine with some other conditions). And
then, a REDIRECT ICMP will be sent in ip_forward() if this flag exists. We
can't pass this information to __mkroute_input if we make
fib_validate_source() return drop reasons.

Therefore, we introduce the wrapper fib_validate_source_reason() for
fib_validate_source(), which will return the drop reasons on error.

In the origin logic, LINUX_MIB_IPRPFILTER will be counted if
fib_validate_source() return -EXDEV. And now, we need to adjust it by
checking "reason == SKB_DROP_REASON_IP_RPFILTER". However, this will take
effect only after the patch "net: ip: make ip_route_input_noref() return
drop reasons", as we can't pass the drop reasons from
fib_validate_source() to ip_rcv_finish_core() in this patch.

Following new drop reasons are added in this patch:

  SKB_DROP_REASON_IP_LOCAL_SOURCE
  SKB_DROP_REASON_IP_INVALID_SOURCE

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v4:
- don't refactor fib_validate_source/__fib_validate_source, and introduce
  a wrapper for fib_validate_source() instead.
v2:
- make fib_validate_source() return drop reasons, instead of -reason.
---
 include/net/dropreason-core.h | 10 ++++++++++
 include/net/ip_fib.h          | 12 ++++++++++++
 net/ipv4/fib_frontend.c       | 17 ++++++++++++-----
 net/ipv4/ip_input.c           |  4 +---
 net/ipv4/route.c              | 33 +++++++++++++++++++--------------
 5 files changed, 54 insertions(+), 22 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index d59bb96c5a02..62a60be1db84 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -76,6 +76,8 @@
 	FN(INVALID_PROTO)		\
 	FN(IP_INADDRERRORS)		\
 	FN(IP_INNOROUTES)		\
+	FN(IP_LOCAL_SOURCE)		\
+	FN(IP_INVALID_SOURCE)		\
 	FN(PKT_TOO_BIG)			\
 	FN(DUP_FRAG)			\
 	FN(FRAG_REASM_TIMEOUT)		\
@@ -373,6 +375,14 @@ enum skb_drop_reason {
 	 * IPSTATS_MIB_INADDRERRORS
 	 */
 	SKB_DROP_REASON_IP_INNOROUTES,
+	/** @SKB_DROP_REASON_IP_LOCAL_SOURCE: the source ip is local */
+	SKB_DROP_REASON_IP_LOCAL_SOURCE,
+	/**
+	 * @SKB_DROP_REASON_IP_INVALID_SOURCE: the source ip is invalid:
+	 * 1) source ip is multicast or limited broadcast
+	 * 2) source ip is zero and not IGMP
+	 */
+	SKB_DROP_REASON_IP_INVALID_SOURCE,
 	/**
 	 * @SKB_DROP_REASON_PKT_TOO_BIG: packet size is too big (maybe exceed the
 	 * MTU)
diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index b6e44f4eaa4c..a113c11ab56b 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -452,6 +452,18 @@ int fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
 			dscp_t dscp, int oif, struct net_device *dev,
 			struct in_device *idev, u32 *itag);
 
+static inline enum skb_drop_reason
+fib_validate_source_reason(struct sk_buff *skb, __be32 src, __be32 dst,
+			   dscp_t dscp, int oif, struct net_device *dev,
+			   struct in_device *idev, u32 *itag)
+{
+	int err = fib_validate_source(skb, src, dst, dscp, oif, dev, idev,
+				      itag);
+	if (err < 0)
+		return -err;
+	return SKB_NOT_DROPPED_YET;
+}
+
 #ifdef CONFIG_IP_ROUTE_CLASSID
 static inline int fib_num_tclassid_users(struct net *net)
 {
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 0c9ce934b490..87bb36a5bdec 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -346,6 +346,7 @@ static int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
 				 int rpf, struct in_device *idev, u32 *itag)
 {
 	struct net *net = dev_net(dev);
+	enum skb_drop_reason reason;
 	struct flow_keys flkeys;
 	int ret, no_addr;
 	struct fib_result res;
@@ -377,9 +378,15 @@ static int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
 
 	if (fib_lookup(net, &fl4, &res, 0))
 		goto last_resort;
-	if (res.type != RTN_UNICAST &&
-	    (res.type != RTN_LOCAL || !IN_DEV_ACCEPT_LOCAL(idev)))
-		goto e_inval;
+	if (res.type != RTN_UNICAST) {
+		if (res.type != RTN_LOCAL) {
+			reason = SKB_DROP_REASON_IP_INVALID_SOURCE;
+			goto e_inval;
+		} else if (!IN_DEV_ACCEPT_LOCAL(idev)) {
+			reason = SKB_DROP_REASON_IP_LOCAL_SOURCE;
+			goto e_inval;
+		}
+	}
 	fib_combine_itag(itag, &res);
 
 	dev_match = fib_info_nh_uses_dev(res.fi, dev);
@@ -412,9 +419,9 @@ static int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
 	return 0;
 
 e_inval:
-	return -EINVAL;
+	return -reason;
 e_rpf:
-	return -EXDEV;
+	return -SKB_DROP_REASON_IP_RPFILTER;
 }
 
 /* Ignore rp_filter for packets protected by IPsec. */
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index 89bb63da6852..c40a26972884 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -425,10 +425,8 @@ static int ip_rcv_finish_core(struct net *net, struct sock *sk,
 	return NET_RX_DROP;
 
 drop_error:
-	if (err == -EXDEV) {
-		drop_reason = SKB_DROP_REASON_IP_RPFILTER;
+	if (drop_reason == SKB_DROP_REASON_IP_RPFILTER)
 		__NET_INC_STATS(net, LINUX_MIB_IPRPFILTER);
-	}
 	goto drop;
 }
 
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 763398e08b7d..f64c0221c221 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1669,7 +1669,7 @@ int ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 			  dscp_t dscp, struct net_device *dev,
 			  struct in_device *in_dev, u32 *itag)
 {
-	int err;
+	enum skb_drop_reason reason;
 
 	/* Primary sanity checks. */
 	if (!in_dev)
@@ -1687,10 +1687,10 @@ int ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		    ip_hdr(skb)->protocol != IPPROTO_IGMP)
 			return -EINVAL;
 	} else {
-		err = fib_validate_source(skb, saddr, 0, dscp, 0, dev, in_dev,
-					  itag);
-		if (err < 0)
-			return err;
+		reason = fib_validate_source_reason(skb, saddr, 0, dscp, 0,
+						    dev, in_dev, itag);
+		if (reason)
+			return -EINVAL;
 	}
 	return 0;
 }
@@ -1788,6 +1788,7 @@ static int __mkroute_input(struct sk_buff *skb, const struct fib_result *res,
 	err = fib_validate_source(skb, saddr, daddr, dscp, FIB_RES_OIF(*res),
 				  in_dev->dev, in_dev, &itag);
 	if (err < 0) {
+		err = -EINVAL;
 		ip_handle_martian_source(in_dev->dev, in_dev, skb, daddr,
 					 saddr);
 
@@ -2140,6 +2141,7 @@ int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
 	struct rtable *rt = skb_rtable(hint);
 	struct net *net = dev_net(dev);
+	enum skb_drop_reason reason;
 	int err = -EINVAL;
 	u32 tag = 0;
 
@@ -2158,9 +2160,9 @@ int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	if (rt->rt_type != RTN_LOCAL)
 		goto skip_validate_source;
 
-	err = fib_validate_source(skb, saddr, daddr, dscp, 0, dev, in_dev,
-				  &tag);
-	if (err < 0)
+	reason = fib_validate_source_reason(skb, saddr, daddr, dscp, 0, dev,
+					    in_dev, &tag);
+	if (reason)
 		goto martian_source;
 
 skip_validate_source:
@@ -2202,6 +2204,7 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 			       dscp_t dscp, struct net_device *dev,
 			       struct fib_result *res)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
 	struct flow_keys *flkeys = NULL, _flkeys;
 	struct net    *net = dev_net(dev);
@@ -2296,10 +2299,11 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		goto brd_input;
 	}
 
+	err = -EINVAL;
 	if (res->type == RTN_LOCAL) {
-		err = fib_validate_source(skb, saddr, daddr, dscp, 0, dev,
-					  in_dev, &itag);
-		if (err < 0)
+		reason = fib_validate_source_reason(skb, saddr, daddr, dscp,
+						    0, dev, in_dev, &itag);
+		if (reason)
 			goto martian_source;
 		goto local_input;
 	}
@@ -2320,9 +2324,10 @@ out:	return err;
 		goto e_inval;
 
 	if (!ipv4_is_zeronet(saddr)) {
-		err = fib_validate_source(skb, saddr, 0, dscp, 0, dev, in_dev,
-					  &itag);
-		if (err < 0)
+		err = -EINVAL;
+		reason = fib_validate_source_reason(skb, saddr, 0, dscp, 0,
+						    dev, in_dev, &itag);
+		if (reason)
 			goto martian_source;
 	}
 	flags |= RTCF_BROADCAST;
-- 
2.39.5

