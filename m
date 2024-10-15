Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8947314D283
	for <bridge@lists.linux.dev>; Tue, 15 Oct 2024 14:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729001303; cv=none; b=SJ9J8ejbwa8FSeCyoOMp7NP2mxoA+KTSVyqY5zYmczUiHR7dQWqn3q16/3j2+0WOZf1SSkrZ6ISeiUVGq7IHGtKh6v7maCpQWBfCEeklbudr60vbuALlSh7FJQwIjbDv989HRLPejwisT1tQb6/JnpQJ12EceGokdl/hiBe2700=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729001303; c=relaxed/simple;
	bh=Q02mPHSdawuoacP3FWbSIcLy+LqtdxaSYcl7vnKHZ/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qVpTaT47MwNQltQ4XtZG1fEwSOHaJ17u42fw0L+f1GuePPyoTLkVQOHXwKBKjqKEq9RehNdFe7bNm0da345v9VXLvxvdrzeJ2N3RPni8eQX7B3LqjwPiBFavkU7RHJgCggWBodT8QLcOyofoKLHQdq5urWooew8bgBXLYLMQbkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgWMkQE5; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgWMkQE5"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-20c6f492d2dso60236605ad.0
        for <bridge@lists.linux.dev>; Tue, 15 Oct 2024 07:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729001301; x=1729606101; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WuHCIlXMzbgZGREkpMiEjnEhIkYiYw79l5/zuLO8F5Q=;
        b=SgWMkQE5m6KOfaONVyHXa3r3CpIRxcstvxZ+xRfGIrz+1zbyCGQ61p1/xV3EwQHBwX
         b/Q7wlBXp9OO66g2iKqsW53NkaBNkplGwTEnGyJo5rQffWySwa2+ntI7i68faGhcWvvv
         Y0xk9j6zm7vFdtRf1VH2mo7Tj54rUKmcTwOUa+wa/nwKWo25By5TE5jfUX9Nc4/ygLGL
         lVGxnneyA5j6K7cNRCtfEv5r/lJZC1FDyj5jvDcmIbhzSDmzOew5QIod8C783yFJugjt
         27DV7+JJJV/IYljrNucctOfASC0lRHkI2Z8k9mHhTEWmD2HRuR2n26IsqpVL5jWUUfU+
         Vaxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729001301; x=1729606101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WuHCIlXMzbgZGREkpMiEjnEhIkYiYw79l5/zuLO8F5Q=;
        b=brhusWJHOQ2jIB+ZoCGwZu1ch7crrgJP7MoU5LPmDUVZf3YBKeEgz+owIXdaCBYWqL
         ggIt2leHR3vNW8zvnj9kzEQFGf2hAUN0nF3up0pvmLiZ5OUcSIh6qabBplycYA/AsT1C
         7EZqJUUAapgE9aciyXSCMXmAtz6Q9of+UIlcacQ6UCJCq5CWp11Ewzr86grH6wqoNXgR
         4/stAKiA9/agA8y7KWvOzMVkOLCabwrngIrXa7Mb0x8fiHH9ycR+5ezX3VifwMw8BO9b
         pHnEJ54xm+ko0k4KQanRhT5nXZNGgUc/S6nFzFFEdIyRqoVtSbRaMGYJX8vyJWDFYTbg
         WXIg==
X-Forwarded-Encrypted: i=1; AJvYcCVhLtgsVqMjQZVmwqnz1zv0Y4XiAIM/JEdx9rQxAgwmwmBRrIbmGkag8O8j88SYMddJBIeSuV4=@lists.linux.dev
X-Gm-Message-State: AOJu0YyHyjHlqZU+xRnWty+Q18jsUbhKBolCGdaq0Blp7i9bJrUAPAmE
	Y12U1hZWdOkuHLeedxqTnKHK+RzB5PN075T0mbIsqbSnAbzt4R46
X-Google-Smtp-Source: AGHT+IGbmeVE+JhrsrK3HAk9iuaIB4S9x5eE0tZ4XUwVZrEWYa3we3NvOttIji7BlAsXUq/hEJEBYg==
X-Received: by 2002:a17:902:d48e:b0:20c:ef81:db with SMTP id d9443c01a7336-20cef810287mr103721535ad.28.1729001300614;
        Tue, 15 Oct 2024 07:08:20 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f9d419sm12437625ad.93.2024.10.15.07.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 07:08:20 -0700 (PDT)
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
Subject: [PATCH net-next v3 01/10] net: ip: refactor fib_validate_source/__fib_validate_source
Date: Tue, 15 Oct 2024 22:07:51 +0800
Message-Id: <20241015140800.159466-2-dongml2@chinatelecom.cn>
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

The only caller of __fib_validate_source() is fib_validate_source(), so
we can combine fib_validate_source() into __fib_validate_source(), and
make fib_validate_source() an inline call to __fib_validate_source().

This will make it easier to make fib_validate_source() return drop reasons
in the next patch.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/net/ip_fib.h    | 15 ++++++++--
 net/ipv4/fib_frontend.c | 64 +++++++++++++++++------------------------
 2 files changed, 38 insertions(+), 41 deletions(-)

diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index b6e44f4eaa4c..90ff815f212b 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -448,9 +448,18 @@ int fib_gw_from_via(struct fib_config *cfg, struct nlattr *nla,
 		    struct netlink_ext_ack *extack);
 __be32 fib_compute_spec_dst(struct sk_buff *skb);
 bool fib_info_nh_uses_dev(struct fib_info *fi, const struct net_device *dev);
-int fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
-			dscp_t dscp, int oif, struct net_device *dev,
-			struct in_device *idev, u32 *itag);
+int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
+			  dscp_t dscp, int oif, struct net_device *dev,
+			  struct in_device *idev, u32 *itag);
+
+static inline int
+fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
+		    dscp_t dscp, int oif, struct net_device *dev,
+		    struct in_device *idev, u32 *itag)
+{
+	return __fib_validate_source(skb, src, dst, dscp, oif, dev, idev,
+				     itag);
+}
 
 #ifdef CONFIG_IP_ROUTE_CLASSID
 static inline int fib_num_tclassid_users(struct net *net)
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 8353518b110a..f74138f4d748 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -341,10 +341,11 @@ EXPORT_SYMBOL_GPL(fib_info_nh_uses_dev);
  * - check, that packet arrived from expected physical interface.
  * called with rcu_read_lock()
  */
-static int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
-				 dscp_t dscp, int oif, struct net_device *dev,
-				 int rpf, struct in_device *idev, u32 *itag)
+int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
+			  dscp_t dscp, int oif, struct net_device *dev,
+			  struct in_device *idev, u32 *itag)
 {
+	int rpf = secpath_exists(skb) ? 0 : IN_DEV_RPFILTER(idev);
 	struct net *net = dev_net(dev);
 	struct flow_keys flkeys;
 	int ret, no_addr;
@@ -352,6 +353,28 @@ static int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
 	struct flowi4 fl4;
 	bool dev_match;
 
+	/* Ignore rp_filter for packets protected by IPsec. */
+	if (!rpf && !fib_num_tclassid_users(net) &&
+	    (dev->ifindex != oif || !IN_DEV_TX_REDIRECTS(idev))) {
+		if (IN_DEV_ACCEPT_LOCAL(idev))
+			goto last_resort;
+		/* with custom local routes in place, checking local addresses
+		 * only will be too optimistic, with custom rules, checking
+		 * local addresses only can be too strict, e.g. due to vrf
+		 */
+		if (net->ipv4.fib_has_custom_local_routes ||
+		    fib4_has_custom_rules(net))
+			goto full_check;
+		/* Within the same container, it is regarded as a martian source,
+		 * and the same host but different containers are not.
+		 */
+		if (inet_lookup_ifaddr_rcu(net, src))
+			return -EINVAL;
+
+		goto last_resort;
+	}
+
+full_check:
 	fl4.flowi4_oif = 0;
 	fl4.flowi4_l3mdev = l3mdev_master_ifindex_rcu(dev);
 	fl4.flowi4_iif = oif ? : LOOPBACK_IFINDEX;
@@ -417,41 +440,6 @@ static int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
 	return -EXDEV;
 }
 
-/* Ignore rp_filter for packets protected by IPsec. */
-int fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
-			dscp_t dscp, int oif, struct net_device *dev,
-			struct in_device *idev, u32 *itag)
-{
-	int r = secpath_exists(skb) ? 0 : IN_DEV_RPFILTER(idev);
-	struct net *net = dev_net(dev);
-
-	if (!r && !fib_num_tclassid_users(net) &&
-	    (dev->ifindex != oif || !IN_DEV_TX_REDIRECTS(idev))) {
-		if (IN_DEV_ACCEPT_LOCAL(idev))
-			goto ok;
-		/* with custom local routes in place, checking local addresses
-		 * only will be too optimistic, with custom rules, checking
-		 * local addresses only can be too strict, e.g. due to vrf
-		 */
-		if (net->ipv4.fib_has_custom_local_routes ||
-		    fib4_has_custom_rules(net))
-			goto full_check;
-		/* Within the same container, it is regarded as a martian source,
-		 * and the same host but different containers are not.
-		 */
-		if (inet_lookup_ifaddr_rcu(net, src))
-			return -EINVAL;
-
-ok:
-		*itag = 0;
-		return 0;
-	}
-
-full_check:
-	return __fib_validate_source(skb, src, dst, dscp, oif, dev, r, idev,
-				     itag);
-}
-
 static inline __be32 sk_extract_addr(struct sockaddr *addr)
 {
 	return ((struct sockaddr_in *) addr)->sin_addr.s_addr;
-- 
2.39.5

