Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF434215034
	for <bridge@lists.linux.dev>; Thu,  7 Nov 2024 12:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730984241; cv=none; b=WwtXsolGR8p3rIo3LdoMUMNuvmic8sssKY2a8X6589GiLYfamm0bg3EX+WpDRwe8Jafc1KDJFdyq47ZFlKqt24qwHzbSkpkSxSj3P10dsOR4XXWrnoKKP/wJy2x+6V77kgBiqnkiGV6Z2NEWf/DX3DHH9zTOcWHyxT0XW3IMORs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730984241; c=relaxed/simple;
	bh=A/n+tA2LV99QwIElK+AO6/wgstFiziRfCh0zEBgGADk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IZJe2OD2igKX65ip3qAqdavp/49kbQyxfiVu14iRAoNIlx1Kg4sszKfA6KMEDbKyeAMgXfDLPqjeRlp7NaMcjsIjxIMaUOz0SJPXrkk5ZOroqVAPOXzYzmOEFcKrhzOhSnVq4hBa87PI/L1cpc7YNPvSmgyDNdXugYWxLQHMvF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6Az93Df; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6Az93Df"
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-7eae96e6624so677421a12.2
        for <bridge@lists.linux.dev>; Thu, 07 Nov 2024 04:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730984238; x=1731589038; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsqFsNdo4NVKbN05C2RYi/RSEJVp+Ni3JWGZTDWcFI8=;
        b=h6Az93DfjFXycwmV6/hZEAfbdTETriU3bdun3BJIMyFIEK0jhNfUEA1/jER8SRCjB9
         9Mwq+nJeVJFvfkz+15bpyl908LvYQsQP8zRi24Eqze9s/PDOlrUenWz2Q5pFo+3WVrtG
         h22mz8TLHs7f4oLeCDn98XGX41Lupnl51vTjyueqzGdxBJ7fRjtH32gPxQ45uymwbeYr
         QpwU0a0A+K0oJUNHrz/EeJhrY+32uHZamR5pEekh+5XgRe275M0wDyX34SHLFrivzBOL
         SiMyIl6w1ogszPGliF+njO/jc8vLexqGQ6kv9KYX5+7zOBP66mKI83G1hjL2i/VOYz41
         nRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730984238; x=1731589038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VsqFsNdo4NVKbN05C2RYi/RSEJVp+Ni3JWGZTDWcFI8=;
        b=BtGl9y3hlIlpC5NI+YzvmMISnajm2evgON0iV2ITga6UfxCCtcvxvSUs6tMBNbl7+B
         VfZUoc7tOqLSyOvR7gITXm7BUyU/xy94cpPY4v4jq19v/G9EY91ifjQwQ2VB8cXK1QPJ
         rUs35L148+CpikqtapIkoV32E55WPryv8tXmJrwz4lIQIRAurMyLSMwkNAKEow4I7FFl
         xBCG6/iE5golPCIGZJ0Hs9gVeWFhLROHnSW4IpgJxrX6sLkxcZwxb2rHCoFKy+A8V156
         eVSW2dVMBCsr6/mvB47/8dQUrBQj63Jht1ji1VeXEjdPDp30Dhygnf4CL9hJr73k3Wa2
         Tn+A==
X-Forwarded-Encrypted: i=1; AJvYcCV8JevZOUaaLt985ospU3wQYKQLdyy9XiX7JG6yHvk7oNq4Gr3AnjHZRl2XKx46bOFAKXuza0M=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzo2GVEQfZtEaVRqnsSE30y9lXV+jVsHDXiKu/Hl8yzHoE7b3HL
	1VOsjhdyGFMkgSeABD4wzauGe+5wTTaG8XisGvFkiULQSG0cVptu
X-Google-Smtp-Source: AGHT+IEM0orGjnsXZ39bCCPI3eXWNBAkK3qH9tMOnfcMoHpor7kACaDKwRqanDDKMEb4STUHWrZx4Q==
X-Received: by 2002:a05:6a20:b925:b0:1d9:6a6b:faf4 with SMTP id adf61e73a8af0-1d9a83d6639mr43154191637.15.1730984238019;
        Thu, 07 Nov 2024 04:57:18 -0800 (PST)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785ffeesm1441651b3a.3.2024.11.07.04.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 04:57:17 -0800 (PST)
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
Subject: [PATCH net-next v5 5/9] net: ip: make ip_route_input_rcu() return drop reasons
Date: Thu,  7 Nov 2024 20:55:57 +0800
Message-Id: <20241107125601.1076814-6-dongml2@chinatelecom.cn>
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

In this commit, we make ip_route_input_rcu() return drop reasons, which
come from ip_route_input_mc() and ip_route_input_slow().

The only caller of ip_route_input_rcu() is ip_route_input_noref(). We
adjust it by making it return -EINVAL on error and ignore the reasons that
ip_route_input_rcu() returns. In the following patch, we will make
ip_route_input_noref() returns the drop reasons.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v4:
- collapse the 2 lines that we modify in inet_rtm_getroute()
---
 net/ipv4/route.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 1c4727504909..1926a8a1a83a 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2435,9 +2435,10 @@ ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
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
@@ -2480,23 +2481,23 @@ static int ip_route_input_rcu(struct sk_buff *skb, __be32 daddr, __be32 saddr,
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
 
@@ -3308,7 +3309,7 @@ static int inet_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		skb->mark	= mark;
 		err = ip_route_input_rcu(skb, dst, src,
 					 inet_dsfield_to_dscp(rtm->rtm_tos),
-					 dev, &res);
+					 dev, &res) ? -EINVAL : 0;
 
 		rt = skb_rtable(skb);
 		if (err == 0 && rt->dst.error)
-- 
2.39.5

