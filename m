Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E64212F0F
	for <bridge@lists.linux.dev>; Thu,  7 Nov 2024 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730984217; cv=none; b=ST4d4ut+CyUt+0tBFL+4gHtg6xsqoDpdQ6YESBL8OCy3pS0p4qKxlczqByB4e6WzloOt9Bu7g3LcKDPZmEpb3GHNXNnYA904u6piw9yypy1UaOQW02mcVCsVshSkX+gfT38A5EYHL+nlRXXjv7o0yBtSALskPLOQiZiIcWMI9xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730984217; c=relaxed/simple;
	bh=jalKiGNYxieOdmuauWZ46l1HYvkQABXljddM93EYgn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=suHInQ6JVf6l/m3XwO4mwlZwsqoiB4ANthyWs3ZlGxZ9KfwglFy8bI+E4jQCA8Qr0mE+RrQbLtC8XGbzs++0yvOO51i8ZDMD3e3DjHkxeRZ5VlfACb8mpBUBJWpx8NDaq8mdImCDgaEoTXESaov4jmS8HShWeFVZfriIxgK050U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQxXbji5; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQxXbji5"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-71e7086c231so715265b3a.0
        for <bridge@lists.linux.dev>; Thu, 07 Nov 2024 04:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730984215; x=1731589015; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCNnhtybNfvt04iDpo5zyre6+yqd+pwPbIIAs/JSjPU=;
        b=nQxXbji5c3FZoHfpw+0D+HdsJ0lkFH6msLFxvxVRbJu9Yz08VSVnPfVjsK7QPgKoau
         O9OAsvlj7XMz4809TcPrL8v6I91RgG0k5BoRAUJawo5A+PGNx+VicyjlIwus12KzF6E1
         sxfy4qBQC7KvODzzrRUf+Ew0MDjxElhKM6q2WCAHJ+jzFl51mZCqoAomorSAjvsiYjAT
         x7A1JsaCTnxebJgXXFKdjhuHuR9hZcMPpGMIwHtgxIJXTOb8UyrL9Uk0KUlY0P/oZ50v
         x8L5pFunFCuSOo64P+kQP3DyiXGh0vJo1HhbMNw0MyaH60uIITG0b16Ogl11Bl5pI4Sq
         uyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730984215; x=1731589015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YCNnhtybNfvt04iDpo5zyre6+yqd+pwPbIIAs/JSjPU=;
        b=dnanNT5GQTZ4JF5LNvIRu/DphRjGL4qUjx8dTBE/qw9DZUM1Ub7BED11jhtcz6abpw
         g49UEQyP8aKjx2GlLTiBNEaA1Ic1RFEdvpp3hlRriXq9uzMYkks+z0lyvMz77XR1fTm7
         qsQ5yeBf0FbPj9weOgCfgbFqZEs3z0GtZkIUk5Uwb6QvRZuJW5fY7AvZCq0i0JjnIPgj
         3HGC4DtRoEl+B65vhDoHYe8Vm2/MiaDax8TdL8ptZDFepc1Cr3fM90CI88+vCgAgb1XD
         WPF4jXc1iSNRY6S1BLUk9ygZG8zZ42b/wemw0iIWrcXT00gGzHk+/JQJFnlIQBJZBwNR
         0y7w==
X-Forwarded-Encrypted: i=1; AJvYcCX29+9jkaTbWHmvzdK6rxVGn4L9AZkCdOSRqSgbW9ZAP+pgroTTKoPb29tA63hIqYz2/V6a6vI=@lists.linux.dev
X-Gm-Message-State: AOJu0YyR/NcudEKEShU1MaAOg30fD6C7v/ecb/UNmew6gEHO8DlallUL
	XMjFwRCdQoKyii14qWsZPCZch2A/8WxfQA4AYPMYyCPeS8ad+SAB
X-Google-Smtp-Source: AGHT+IHeCdO4Mk8XM+g3M+PuhA6QC1V3CjuvQ5OxvLfarz4l+oMySgbRHgUpRjZFu1qRaDeoTU2ZdQ==
X-Received: by 2002:a05:6a00:2305:b0:71e:7046:c0f8 with SMTP id d2e1a72fcca58-72063095e6emr51487563b3a.26.1730984215331;
        Thu, 07 Nov 2024 04:56:55 -0800 (PST)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785ffeesm1441651b3a.3.2024.11.07.04.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 04:56:54 -0800 (PST)
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
Subject: [PATCH net-next v5 2/9] net: ip: make ip_route_input_mc() return drop reason
Date: Thu,  7 Nov 2024 20:55:54 +0800
Message-Id: <20241107125601.1076814-3-dongml2@chinatelecom.cn>
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

