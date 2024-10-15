Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF78A1B218B
	for <bridge@lists.linux.dev>; Tue, 15 Oct 2024 14:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729001350; cv=none; b=EAKy6Qz5ODVtfYfiZA0F82pC5TvQ++khzZBtiU0tz4LZCegZnT6p2/bx+UfJKK6YsV4Ib6VzmyRkx8ferW9E70pr6bqJecTDBnbWQMGDfsFB21WWOLt5EpOAN652dM474qbzsFe3W6OSCmSaSUu+H7T7ZZ+zCJbs4ve2TPL/PQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729001350; c=relaxed/simple;
	bh=hRfn5rQNGzGek2Rl/WYwV2CDrJdk9y+72tdDnLlRft0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X8+LdOwsdpORv17p4f8rI7d8/+4fW0fTwHQz/2bn/7Jx4DC8aqCuzvwJ8+jdFC5tBXRvzH5+JpOo0kETXq7x+Hg7rUkYwGlMFWof7jrnf9UpTAokp6Ffut7DKOPOGT5krEHAxu6uW/0C1+Ws61q+PP7bG6jtg+pAF2c+2jLNHNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDWUZJux; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDWUZJux"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-20c7ee8fe6bso39334355ad.2
        for <bridge@lists.linux.dev>; Tue, 15 Oct 2024 07:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729001348; x=1729606148; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byj17PnEdOWNMLLbQ9DjmcaQd6Z/d2VuphpY3zlwdig=;
        b=QDWUZJux9SO0PJomBhjc7nsTxYAA8lszA3JkVB3hUK40eAxfaeqXfXe3iEXwpyw2GD
         mAU1gGzoH080Z7RVt1V1dYtHv3Qune8Et4sayg7aes8hSz2AM5JjSj5TujGVHIJZ085a
         /21VQ0mi9IBD5E0jHdIn6SreZPW/UoNHo+LOexLOj4nJdDsNSQOLSzjuTm/6so39r1P9
         Y7pkW41xMgdvWiRIgoO4F+OiqDlAU9Nq2MrZ+gs46FZiBf286xtLpF124vxDi+CfQqYe
         0shW5OX8lVVeeTvjhNAdwLg3Vt+owu9HiqK8fQus7+9uIbOr0DJLoiMCMd13hn0Xl3kY
         kiyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729001348; x=1729606148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=byj17PnEdOWNMLLbQ9DjmcaQd6Z/d2VuphpY3zlwdig=;
        b=WqjLlKb/TLrDLqZs/8h4E/KQR2i19ySNqsNBo8KDoHDD82JryZ+c+LEGAP0FIimRpb
         k4vI/e1m8vjq5QZeQXv3FTF0H0So6XC48N3U9DCN57hChg2K6JHsGNgmVFzhkRyfgwym
         3FE/P7+Hhr0xlDKIyoAucI6g7flv30pwml4Mj/Eraw9/i6FUqC696/gUpY0h7lrR/Ry0
         r1Hs+38CaEpdsLonjbZcWFtp6GdXqiq9MAinqjYiDOdRuIZuXC2oOs+6tF2NTK6bKBWp
         a3+PxWbDdZpKaNtQ01O4hk1GeVbPtUk6Cs4lJXdtQnpP3RvcvmJU52Hjlq2u9AlKJq6R
         +eIA==
X-Forwarded-Encrypted: i=1; AJvYcCXGbXOx3Vp5TI2uUvQITVTO8RA8vX4DIklPJMEVIhcSJLddgDamwG103sSEjuFY+Qk6I/4kT5k=@lists.linux.dev
X-Gm-Message-State: AOJu0YxQl7hgAPoqN2ct3MmhaH7LZNDJMXQ/vdMvrgri9zP2FYLohqcT
	4PxwKjGqIBFHtWboroGEM1n0T+rDPejyOhln/Ovw+Mc+l9o5mHS6
X-Google-Smtp-Source: AGHT+IFho0wkJSC3nuCh8eieAcM7whz7jbKavyQJaZKAu/jxcgJCiyMBMEcoEEjLgWEevXYGayEQiA==
X-Received: by 2002:a17:902:ceca:b0:20c:8839:c517 with SMTP id d9443c01a7336-20d27f26c00mr5475865ad.53.1729001348049;
        Tue, 15 Oct 2024 07:09:08 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f9d419sm12437625ad.93.2024.10.15.07.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 07:09:07 -0700 (PDT)
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
Subject: [PATCH net-next v3 08/10] net: ip: make ip_route_input() return drop reasons
Date: Tue, 15 Oct 2024 22:07:58 +0800
Message-Id: <20241015140800.159466-9-dongml2@chinatelecom.cn>
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

In this commit, we make ip_route_input() return skb drop reasons that come
from ip_route_input_noref().

Meanwhile, adjust all the call to it.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/net/route.h             |  7 ++++---
 net/bridge/br_netfilter_hooks.c | 11 ++++++-----
 net/ipv4/icmp.c                 |  1 +
 3 files changed, 11 insertions(+), 8 deletions(-)

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
index 23664434922e..c3bafff093e0 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -546,6 +546,7 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
 		skb_dst_set(skb_in, NULL);
 		err = ip_route_input(skb_in, fl4_dec.daddr, fl4_dec.saddr,
 				     dscp, rt2->dst.dev);
+		err = err ? -EINVAL : 0;
 
 		dst_release(&rt2->dst);
 		rt2 = skb_rtable(skb_in);
-- 
2.39.5

