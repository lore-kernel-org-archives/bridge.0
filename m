Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A390E1EBA09
	for <bridge@lists.linux.dev>; Tue, 15 Oct 2024 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729001336; cv=none; b=LdIGmmCfHxcQWfYbRR5UcPNkTBmeuexg3d3eM/wybruABNVTRc2raGQbwsvYNfV13FHNtQ8BYGD460WFHMSlf20by8LXxjMzJnHtp+EBDgf1aqgTt4AHWzyxTSrZ4i3qAhhv8Xu0436XZPPoSUZHltMLGFFDyJw+m6fKP63SBgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729001336; c=relaxed/simple;
	bh=lZdovlYfC6CbOD44SDy1x+Dvebj19MuTrfjxQ1Wc7DY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rD7xOgzE7Pv5DlVSHE9fcLHfksmzoRRuHH41YZq664fj7ZQRL048wpSDazmOf7Ln4ftQ+K0YrxIunoi+zHrjxOTesoQIo3RVY3p/49AQRiUJOcydFjpS7BVdA6W75n1ApBwr9ubolWwTGXnqj6dv+zXOd5zKl9YfiCX/dPe01Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2UPE8wK; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2UPE8wK"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-20caccadbeeso40415455ad.2
        for <bridge@lists.linux.dev>; Tue, 15 Oct 2024 07:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729001334; x=1729606134; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOE1KEGRuQOpIUWAn8WtgPiDE4IJ9ftyaosDtmgCxs0=;
        b=O2UPE8wKwyxlVpb9yAZlUP5eyEaVYIfgFeGk015nB5+lkzF63SCZHIPJ65pw8OCWJp
         63uKq68g+WI4CY8JbpgwG7VDbbjjxNp5lkvTlTWoDzMUeYGVBva5V3twqVwoFDHa9Uw3
         +A/hr6JYRFW6tiMfRBoXi19Ud5aNwT+Rk8U5rDWBLuI/piFb0HtDuTiOlHcvXAtxNevS
         CGea+e5CU8cpSMT6/wfJE7jVA715gh1fQnkHbjiRvWJPYdIQcq3b9J2DlY9R8gdghGXB
         SCOSaXPAXsca+/aWUMxaWw8WwdnNIDEHn2SVS0GXP3djb0dO0gKMaSm1Eh8dND1h2aa8
         jbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729001334; x=1729606134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOE1KEGRuQOpIUWAn8WtgPiDE4IJ9ftyaosDtmgCxs0=;
        b=UYMDXqB8fTUlx9bbOvHnvJ3GHrloNavcg48iMGqrkDZLC3YV6ML+9+aew99TcLmMFZ
         nbvqtQMz+r7Wi+GkJdXftCtNBueYuHb2xKaEzJsmKViQo3AyRKxMKHXfyOb1Jlv3kSYm
         KgI2s66LaMVs3x0I1uqAjp4AvNLMechnjVgJ/S+sUkBkwR1PG730basDhlDsFwDNqDxm
         qb7btn+hPYB/777ZoVSwMbAslMB1ar3xM/tIJK6sAFkMQf5wjnPBj05p1Tw5Hm1ueY18
         o1Cwix2sTeu0fYFE8jIbgS5OTCy3slL3iWkMMsJva2MM6CZZdmhowwEYmM+dYh/QU+x0
         c+sA==
X-Forwarded-Encrypted: i=1; AJvYcCVBeaXKphMZkrRonEkN6TrZD9LNpeIHhfugovGlCFQcjOxYwFslvI37rvg0AZAOQ2F8x8RuaJY=@lists.linux.dev
X-Gm-Message-State: AOJu0YxpEgapKK0+eoHnhXUvi1jzCaqvtkku1U9dyBWvwSX4ccR51OlJ
	rIS62bOMjmQlhbZsV4puX7Z/6uPV4R7rCPnCKBi6Mu/rEFld3ggdXneAafzn
X-Google-Smtp-Source: AGHT+IEgiCflMtLy1/C38zFztiqfgmUIReH+WTEDV3zas5tvZpSawhYMZAytpJvBcWJRH6Z+Rclfkg==
X-Received: by 2002:a17:903:110f:b0:205:968b:31ab with SMTP id d9443c01a7336-20ca16e9c13mr213326295ad.58.1729001333801;
        Tue, 15 Oct 2024 07:08:53 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f9d419sm12437625ad.93.2024.10.15.07.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 07:08:53 -0700 (PDT)
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
Subject: [PATCH net-next v3 06/10] net: ip: make ip_route_input_rcu() return drop reasons
Date: Tue, 15 Oct 2024 22:07:56 +0800
Message-Id: <20241015140800.159466-7-dongml2@chinatelecom.cn>
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

In this commit, we make ip_route_input_rcu() return drop reasons, which
come from ip_route_input_mc() and ip_route_input_slow().

The only caller of ip_route_input_rcu() is ip_route_input_noref(). We
adjust it by making it return -EINVAL on error and ignore the reasons that
ip_route_input_rcu() returns. In the following patch, we will make
ip_route_input_noref() returns the drop reasons.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 net/ipv4/route.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 33bf83bcccdb..8ac298d69c8c 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2434,9 +2434,10 @@ out:	return reason;
 }
 
 /* called with rcu_read_lock held */
-static int ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-			      dscp_t dscp, struct net_device *dev,
-			      struct fib_result *res)
+static enum skb_drop_reason
+ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+		   dscp_t dscp, struct net_device *dev,
+		   struct fib_result *res)
 {
 	/* Multicast recognition logic is moved from route cache to here.
 	 * The problem was that too many Ethernet cards have broken/missing
@@ -2479,23 +2480,23 @@ static int ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 			reason = ip_route_input_mc(skb, daddr, saddr, dscp,
 						   dev, our);
 		}
-		return reason ? -EINVAL : 0;
+		return reason;
 	}
 
-	return ip_route_input_slow(skb, daddr, saddr, dscp, dev, res) ? -EINVAL : 0;
+	return ip_route_input_slow(skb, daddr, saddr, dscp, dev, res);
 }
 
 int ip_route_input_noref(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 			 dscp_t dscp, struct net_device *dev)
 {
+	enum skb_drop_reason reason;
 	struct fib_result res;
-	int err;
 
 	rcu_read_lock();
-	err = ip_route_input_rcu(skb, daddr, saddr, dscp, dev, &res);
+	reason = ip_route_input_rcu(skb, daddr, saddr, dscp, dev, &res);
 	rcu_read_unlock();
 
-	return err;
+	return reason ? -EINVAL : 0;
 }
 EXPORT_SYMBOL(ip_route_input_noref);
 
@@ -3308,6 +3309,7 @@ static int inet_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		err = ip_route_input_rcu(skb, dst, src,
 					 inet_dsfield_to_dscp(rtm->rtm_tos),
 					 dev, &res);
+		err = err ? -EINVAL : 0;
 
 		rt = skb_rtable(skb);
 		if (err == 0 && rt->dst.error)
-- 
2.39.5

