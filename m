Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CC318D623
	for <bridge@lists.linux.dev>; Wed, 30 Oct 2024 01:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730252623; cv=none; b=LzASuripQGCpuPH+03R5glWlJz74AWt/WkhNdl/YvVqp+E/DkoKkW7x9/BUK0ECRnAhnTS2ShVZGSdeSkUIITyp7xxe7UOgaZGxInj+Xwn6es2kfJMxQX5f1O98VAZ8c98X0vh+GKeMVuWKRb8H9MiK95GssBb22bS+O7FRfTeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730252623; c=relaxed/simple;
	bh=/GcSCadI+T3M4bQiXCZC/77mXVWFv6oknRB1DDIOeQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kvotp0tw22gY+vEG+RRyHZDNtSdmiPqlMpVvcqfH/9m3hPrcFQj/tlxugJ7mf+RPlJke4ncRClYKCYCNEJvqgmv8ClGCcyjmXHbJxz3AhOX7lsz17YP7MSJTZdYWoFt12k2XtPVkAZI+AP57tMNLqEYB+c/S8Rm3ESG3CLHi34o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+cfe0Md; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+cfe0Md"
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso5231764a12.2
        for <bridge@lists.linux.dev>; Tue, 29 Oct 2024 18:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730252621; x=1730857421; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=quVTfbnmhzjpXfeFKcq30xkkA8wdU+ycNi4wYR5plLw=;
        b=f+cfe0Mdh1rv95mkHXtyzyPYrxOiEv62Il4C4DbS257McTeghl/UVtSSq4YqqJnI+H
         dt8NoDlov185Df0UKw5KohXXql+5xSOGhkc73/kw1qFhr/sYnnECRVEUNFhECwhWfATO
         MgIsliU5ubvEcTwCFPFkgGnmaTcteUbwL1Tq5rbV9Oo8I4vZWModKimOU66socdFUC+N
         m5KJc8AD7tMAtkY7D3XY76AWa5RMJrx0CYu2ZvpKYMFg1xNKZpds18LQCzlBhutOT6Qb
         cQM/Fi2YMzOU/JmEHjVHZBzzd028MmQQx5CMsBYAjEJwwoODSxFU19+5l/vhw1z7w5em
         UQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730252621; x=1730857421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quVTfbnmhzjpXfeFKcq30xkkA8wdU+ycNi4wYR5plLw=;
        b=DmkxNQDF3qxSjQxs7q8+ptqQlF7aFvA37iY712p2bufhxTtM6VuIJVjGZExbXdI34d
         Uq8reBREKLRMIkJ33f7cMxdrjkpPTb1vJTkfLJq9JYGlWc/05XMOQ1Z/ljbuFqQFYWpq
         MrHaOP1MsQohdDsSx5JSn2Z2SOp2Xshhq3U/zbiXcRIXpEhOggcEnHCB5YPOk+jUI9h9
         k1yv0/oI8Dfwcrcqfmf9nZp4b9A68hnbN1ThTjiSeGzqX11aD8aMpovqIo6ma9g/EYS3
         nBxaPahd0xS+08cj2hJW4EnqkS3lZjOP93pupimeZFXjziV63uKLZRNjdRTRO+KIWaEc
         w1ww==
X-Forwarded-Encrypted: i=1; AJvYcCWhv/0R9gu0PTWvGXM1KUsnEEXXxYLrvHCYx6s/pEWaajfEnVlSxxiHXF+LFxW6ZGTAcUVAkHs=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6H1EWhM3TAYUOVMY5rP/RBmcnWo7kyPBNGQpG+Ed/P6VFUsRG
	D8ZSH3ItwGuVZyNYwspBBuB6De5823aBx0kFkLXWfDlhfpdMH7Tn
X-Google-Smtp-Source: AGHT+IHhiU/6+Ny8kIfRXHQkoKymamNt3NomfP/xyekCv09z+G1vXTFEUB9Bg+nsKvYXx4+/hfEMiA==
X-Received: by 2002:a05:6a20:4389:b0:1d9:28ae:5e88 with SMTP id adf61e73a8af0-1d9a85354d0mr13771177637.50.1730252620796;
        Tue, 29 Oct 2024 18:43:40 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc866906dsm8138407a12.10.2024.10.29.18.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 18:43:40 -0700 (PDT)
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
Subject: [PATCH RESEND net-next v4 8/9] net: ip: make ip_mkroute_input/__mkroute_input return drop reasons
Date: Wed, 30 Oct 2024 09:41:44 +0800
Message-Id: <20241030014145.1409628-9-dongml2@chinatelecom.cn>
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

In this commit, we make ip_mkroute_input() and __mkroute_input() return
drop reasons.

The drop reason "SKB_DROP_REASON_ARP_PVLAN_DISABLE" is introduced for
the case: the packet which is not IP is forwarded to the in_dev, and
the proxy_arp_pvlan is not enabled. This name is ugly, and I have not
figure out a suitable name for this case yet :/

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/net/dropreason-core.h |  7 +++++++
 net/ipv4/route.c              | 35 +++++++++++++++++++----------------
 2 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 74624d369d48..6c5a1ea209a2 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -104,6 +104,7 @@
 	FN(IP_TUNNEL_ECN)		\
 	FN(TUNNEL_TXINFO)		\
 	FN(LOCAL_MAC)			\
+	FN(ARP_PVLAN_DISABLE)		\
 	FNe(MAX)
 
 /**
@@ -477,6 +478,12 @@ enum skb_drop_reason {
 	 * the MAC address of the local netdev.
 	 */
 	SKB_DROP_REASON_LOCAL_MAC,
+	/**
+	 * @SKB_DROP_REASON_ARP_PVLAN_DISABLE: packet which is not IP is
+	 * forwarded to the in_dev, and the proxy_arp_pvlan is not
+	 * enabled.
+	 */
+	SKB_DROP_REASON_ARP_PVLAN_DISABLE,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index ce1201dbf464..e248e5577d0e 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1769,10 +1769,12 @@ static void ip_handle_martian_source(struct net_device *dev,
 }
 
 /* called in rcu_read_lock() section */
-static int __mkroute_input(struct sk_buff *skb, const struct fib_result *res,
-			   struct in_device *in_dev, __be32 daddr,
-			   __be32 saddr, dscp_t dscp)
+static enum skb_drop_reason
+__mkroute_input(struct sk_buff *skb, const struct fib_result *res,
+		struct in_device *in_dev, __be32 daddr,
+		__be32 saddr, dscp_t dscp)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct fib_nh_common *nhc = FIB_RES_NHC(*res);
 	struct net_device *dev = nhc->nhc_dev;
 	struct fib_nh_exception *fnhe;
@@ -1786,13 +1788,13 @@ static int __mkroute_input(struct sk_buff *skb, const struct fib_result *res,
 	out_dev = __in_dev_get_rcu(dev);
 	if (!out_dev) {
 		net_crit_ratelimited("Bug in ip_route_input_slow(). Please report.\n");
-		return -EINVAL;
+		return reason;
 	}
 
 	err = fib_validate_source(skb, saddr, daddr, dscp, FIB_RES_OIF(*res),
 				  in_dev->dev, in_dev, &itag);
 	if (err < 0) {
-		err = -EINVAL;
+		reason = -err;
 		ip_handle_martian_source(in_dev->dev, in_dev, skb, daddr,
 					 saddr);
 
@@ -1820,7 +1822,8 @@ static int __mkroute_input(struct sk_buff *skb, const struct fib_result *res,
 		 */
 		if (out_dev == in_dev &&
 		    IN_DEV_PROXY_ARP_PVLAN(in_dev) == 0) {
-			err = -EINVAL;
+			/* what do we name this situation? */
+			reason = SKB_DROP_REASON_ARP_PVLAN_DISABLE;
 			goto cleanup;
 		}
 	}
@@ -1843,7 +1846,7 @@ static int __mkroute_input(struct sk_buff *skb, const struct fib_result *res,
 	rth = rt_dst_alloc(out_dev->dev, 0, res->type,
 			   IN_DEV_ORCONF(out_dev, NOXFRM));
 	if (!rth) {
-		err = -ENOBUFS;
+		reason = SKB_DROP_REASON_NOMEM;
 		goto cleanup;
 	}
 
@@ -1857,9 +1860,9 @@ static int __mkroute_input(struct sk_buff *skb, const struct fib_result *res,
 	lwtunnel_set_redirect(&rth->dst);
 	skb_dst_set(skb, &rth->dst);
 out:
-	err = 0;
- cleanup:
-	return err;
+	reason = SKB_NOT_DROPPED_YET;
+cleanup:
+	return reason;
 }
 
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
@@ -2117,9 +2120,10 @@ int fib_multipath_hash(const struct net *net, const struct flowi4 *fl4,
 }
 #endif /* CONFIG_IP_ROUTE_MULTIPATH */
 
-static int ip_mkroute_input(struct sk_buff *skb, struct fib_result *res,
-			    struct in_device *in_dev, __be32 daddr,
-			    __be32 saddr, dscp_t dscp, struct flow_keys *hkeys)
+static enum skb_drop_reason
+ip_mkroute_input(struct sk_buff *skb, struct fib_result *res,
+		 struct in_device *in_dev, __be32 daddr,
+		 __be32 saddr, dscp_t dscp, struct flow_keys *hkeys)
 {
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
 	if (res->fi && fib_info_num_path(res->fi) > 1) {
@@ -2333,9 +2337,8 @@ ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	}
 
 make_route:
-	err = ip_mkroute_input(skb, res, in_dev, daddr, saddr, dscp, flkeys);
-	if (!err)
-		reason = SKB_NOT_DROPPED_YET;
+	reason = ip_mkroute_input(skb, res, in_dev, daddr, saddr, dscp,
+				  flkeys);
 
 out:
 	return reason;
-- 
2.39.5

