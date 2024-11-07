Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F682144A9
	for <bridge@lists.linux.dev>; Thu,  7 Nov 2024 12:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730984233; cv=none; b=IoevtiOQDdUgN8dwheSPFahnhMavPGWdTlkG2sRZIc5T63LC4DjKdMlxFeVuwRpkaP33VDxPQZCjJhRcOMusn2TM8yqFYHjqOuWL2pekZ/kqjv0NzO2Jva73lJj8TDvDuuD/LXgySzwwFub0A/Wnf1FgIl3c3L1eb6yiEFiaqqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730984233; c=relaxed/simple;
	bh=LAqzk3ZeLSZRqj1ByixV8/2cQzVAafDYcEAPajrW45Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d7aVV2lJDgPiBQYNpNy9YC4xNwGheBystNqWjIV9vNWnwg2n49x8N+w8ZYbPoV3JZLqQOhX1nc9VQ30sWv3d8QaRPYm2PqIRu2FT+/M7IAN6x3dGYo7B+yu/clmu37CgcpoZCnbcD1D6Mp0Hn4+zv54gtS3EeYRz5G71qT6jaBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQVTcU8C; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQVTcU8C"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-720aa3dbda5so606059b3a.1
        for <bridge@lists.linux.dev>; Thu, 07 Nov 2024 04:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730984231; x=1731589031; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9fMwGGcbp4z4vwxeeXuhogVmcPVJ1v4SFojuZQbris=;
        b=EQVTcU8ClvFISvgqSlTzUnZMWUdtGlVSjr6zfsSpaajw0hIkecRM6+2FxxYvo+ZeTe
         OHatFHY2O7lwHYrz4AU/RuCun/UUGJPzasC6zSaok5au9z9bdAbD/v0fNy3+FPl/JLI7
         U5Rz7jKeH3tDe/Ev39D6NwzW9OjBSpButh/tRFBNTYkMWzxc8i+XuvJ8Es7A+tDeCDn7
         Euof1kQfvI4bdV9gllPWWgyS5pIp+K9grzFKevc9StOvosGNB13yqf5CqE5zn/QUbSUR
         Lx5vFunZvooYPh8uIHeizuT6sM2f+Wh8l6UE6OdcbMJMUTqju9kradW2+Ha9mTuDy4YK
         1pAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730984231; x=1731589031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O9fMwGGcbp4z4vwxeeXuhogVmcPVJ1v4SFojuZQbris=;
        b=Qfn26ydl1RFd1ii2tIOPs/Kwqpys44QwOMckshFkJ6Z9hSsuwp48CM3dWri6Y4pVjj
         fLdvxxrf0Or1REdDYqwmrDnd7FjrQnfdwa4C5r7uodlg9ZCcU3VTgBTHZfFSLQpxZ4d1
         fK6MQOpu2HRbtrNEa+1Y2pUS+hI/dEZHDlernE0LX0jvPZfmyXHI4YkJhNkCZ4aoY0fY
         whQcX3Y6/GR811l15AgKiS5fH/x7wSgNMteUkWd+1hsfUqnZzWQAleQwJzU6VLw6n+PB
         gP6AtuOuDFlPWioErRnJCCu3mK+YVwE7k8KqDSdxU/j1P4c+ajWDeSnOew00+WiWtqpT
         BEBg==
X-Forwarded-Encrypted: i=1; AJvYcCXe738pg0axZxLZYzppqy0IX4C9911T2sU4KgWqMcXrOccI/MmBhpjxC0MjKYfhGh7yZJ2TYws=@lists.linux.dev
X-Gm-Message-State: AOJu0YzZ93LHR6lgJKIctm+ioW2+Kljm0mzNb3nascozFkezK+sqw0O4
	yQpwOwUVVruQjL0AnDxS6BY8fTgaDSzSnOqFaZW6KiaLC3f4jAJf
X-Google-Smtp-Source: AGHT+IG+QOHt0ycOAwDcbC8TJ8OplkTJg1hkCdA4fgS8r4ZISfqNi0rcD93EkYDnOCy7nljxHuRf4Q==
X-Received: by 2002:a05:6a21:3384:b0:1db:dcc6:dd39 with SMTP id adf61e73a8af0-1dc17a82fb1mr1314337637.26.1730984230627;
        Thu, 07 Nov 2024 04:57:10 -0800 (PST)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785ffeesm1441651b3a.3.2024.11.07.04.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 04:57:10 -0800 (PST)
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
Subject: [PATCH net-next v5 4/9] net: ip: make ip_route_input_slow() return drop reasons
Date: Thu,  7 Nov 2024 20:55:56 +0800
Message-Id: <20241107125601.1076814-5-dongml2@chinatelecom.cn>
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

In this commit, we make ip_route_input_slow() return skb drop reasons,
and following new skb drop reasons are added:

  SKB_DROP_REASON_IP_INVALID_DEST

The only caller of ip_route_input_slow() is ip_route_input_rcu(), and we
adjust it by making it return -EINVAL on error.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v4:
- use indentation after the out label
---
 include/net/dropreason-core.h |  6 ++++
 net/ipv4/route.c              | 56 ++++++++++++++++++++++-------------
 2 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index a2a1fb90e0e5..74624d369d48 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -79,6 +79,7 @@
 	FN(IP_LOCAL_SOURCE)		\
 	FN(IP_INVALID_SOURCE)		\
 	FN(IP_LOCALNET)			\
+	FN(IP_INVALID_DEST)		\
 	FN(PKT_TOO_BIG)			\
 	FN(DUP_FRAG)			\
 	FN(FRAG_REASM_TIMEOUT)		\
@@ -386,6 +387,11 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_IP_INVALID_SOURCE,
 	/** @SKB_DROP_REASON_IP_LOCALNET: source or dest ip is local net */
 	SKB_DROP_REASON_IP_LOCALNET,
+	/**
+	 * @SKB_DROP_REASON_IP_INVALID_DEST: the dest ip is invalid:
+	 * 1) dest ip is 0
+	 */
+	SKB_DROP_REASON_IP_INVALID_DEST,
 	/**
 	 * @SKB_DROP_REASON_PKT_TOO_BIG: packet size is too big (maybe exceed the
 	 * MTU)
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 566acd08aedf..1c4727504909 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2204,9 +2204,10 @@ static struct net_device *ip_rt_get_dev(struct net *net,
  *	called with rcu_read_lock()
  */
 
-static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			       dscp_t dscp, struct net_device *dev,
-			       struct fib_result *res)
+static enum skb_drop_reason
+ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+		    dscp_t dscp, struct net_device *dev,
+		    struct fib_result *res)
 {
 	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
@@ -2236,8 +2237,10 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		fl4.flowi4_tun_key.tun_id = 0;
 	skb_dst_drop(skb);
 
-	if (ipv4_is_multicast(saddr) || ipv4_is_lbcast(saddr))
+	if (ipv4_is_multicast(saddr) || ipv4_is_lbcast(saddr)) {
+		reason = SKB_DROP_REASON_IP_INVALID_SOURCE;
 		goto martian_source;
+	}
 
 	res->fi = NULL;
 	res->table = NULL;
@@ -2247,21 +2250,29 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	/* Accept zero addresses only to limited broadcast;
 	 * I even do not know to fix it or not. Waiting for complains :-)
 	 */
-	if (ipv4_is_zeronet(saddr))
+	if (ipv4_is_zeronet(saddr)) {
+		reason = SKB_DROP_REASON_IP_INVALID_SOURCE;
 		goto martian_source;
+	}
 
-	if (ipv4_is_zeronet(daddr))
+	if (ipv4_is_zeronet(daddr)) {
+		reason = SKB_DROP_REASON_IP_INVALID_DEST;
 		goto martian_destination;
+	}
 
 	/* Following code try to avoid calling IN_DEV_NET_ROUTE_LOCALNET(),
 	 * and call it once if daddr or/and saddr are loopback addresses
 	 */
 	if (ipv4_is_loopback(daddr)) {
-		if (!IN_DEV_NET_ROUTE_LOCALNET(in_dev, net))
+		if (!IN_DEV_NET_ROUTE_LOCALNET(in_dev, net)) {
+			reason = SKB_DROP_REASON_IP_LOCALNET;
 			goto martian_destination;
+		}
 	} else if (ipv4_is_loopback(saddr)) {
-		if (!IN_DEV_NET_ROUTE_LOCALNET(in_dev, net))
+		if (!IN_DEV_NET_ROUTE_LOCALNET(in_dev, net)) {
+			reason = SKB_DROP_REASON_IP_LOCALNET;
 			goto martian_source;
+		}
 	}
 
 	/*
@@ -2316,19 +2327,26 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		err = -EHOSTUNREACH;
 		goto no_route;
 	}
-	if (res->type != RTN_UNICAST)
+	if (res->type != RTN_UNICAST) {
+		reason = SKB_DROP_REASON_IP_INVALID_DEST;
 		goto martian_destination;
+	}
 
 make_route:
 	err = ip_mkroute_input(skb, res, in_dev, daddr, saddr, dscp, flkeys);
-out:	return err;
+	if (!err)
+		reason = SKB_NOT_DROPPED_YET;
+
+out:
+	return reason;
 
 brd_input:
-	if (skb->protocol != htons(ETH_P_IP))
-		goto e_inval;
+	if (skb->protocol != htons(ETH_P_IP)) {
+		reason = SKB_DROP_REASON_INVALID_PROTO;
+		goto out;
+	}
 
 	if (!ipv4_is_zeronet(saddr)) {
-		err = -EINVAL;
 		reason = fib_validate_source_reason(skb, saddr, 0, dscp, 0,
 						    dev, in_dev, &itag);
 		if (reason)
@@ -2349,7 +2367,7 @@ out:	return err;
 		rth = rcu_dereference(nhc->nhc_rth_input);
 		if (rt_cache_valid(rth)) {
 			skb_dst_set_noref(skb, &rth->dst);
-			err = 0;
+			reason = SKB_NOT_DROPPED_YET;
 			goto out;
 		}
 	}
@@ -2386,7 +2404,7 @@ out:	return err;
 			rt_add_uncached_list(rth);
 	}
 	skb_dst_set(skb, &rth->dst);
-	err = 0;
+	reason = SKB_NOT_DROPPED_YET;
 	goto out;
 
 no_route:
@@ -2407,12 +2425,8 @@ out:	return err;
 				     &daddr, &saddr, dev->name);
 #endif
 
-e_inval:
-	err = -EINVAL;
-	goto out;
-
 e_nobufs:
-	err = -ENOBUFS;
+	reason = SKB_DROP_REASON_NOMEM;
 	goto out;
 
 martian_source:
@@ -2469,7 +2483,7 @@ static int ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		return reason ? -EINVAL : 0;
 	}
 
-	return ip_route_input_slow(skb, daddr, saddr, dscp, dev, res);
+	return ip_route_input_slow(skb, daddr, saddr, dscp, dev, res) ? -EINVAL : 0;
 }
 
 int ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-- 
2.39.5

