Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EC81CFEB1
	for <bridge@lists.linux.dev>; Thu, 24 Oct 2024 09:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762511; cv=none; b=tUICZGUdGiNofU2Gl9CZmGsiEJ/tegPA3CEvnSWXlPESSlOzRRMffRhgoJ6by7Z99LTy2bp0YItHfNgS+H3zaYshiwlBqLXeJXWnXV7E2Ql2aoEez+mxVqjxF6lwxuaWJYJLrojBFaDlDB5A2PhIg7PHbk6uiLoOy7nBKobAhfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762511; c=relaxed/simple;
	bh=SMznvpM6I8IKeqpx/OkxMk7v5dBsmBPNdSI5IDb8K4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zp6e0pPKN7Q/TWEJQDARUCpgt4DRtyVqeltNg6NJkKRUzrNmptwu4ZOIEFmwdHOHbI+ftIG2u90Iarqyk326cgtQYgfGfvZvOYaFNWKNjw8uA/4ahAFYN2VItKnVgRCFx6MDBleXh77IYKVU5KTOM35xQKSGh30cITWl+fuXOG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8aY6arh; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8aY6arh"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-71e49ad46b1so453961b3a.1
        for <bridge@lists.linux.dev>; Thu, 24 Oct 2024 02:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729762509; x=1730367309; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKF8GRab9vIGC7OVVlgdZTWcvJOyU79YNruFFlVjlr0=;
        b=P8aY6arhDj+B6Wem6sRyAElR/NAXIyAwp/Wz6JdU3epKmyojb7uuYYkW6ibraacHB7
         uOx0pBldRPgli2mYdT9cZL/hCO2hAsX9Z0GpI2o/FWXwnaM+K6vK+ayw5iKxkWyqYlI8
         +Ndc0OQIGTKtaHYgmeH5vSBDI+cLUjhkCKWV4hEuYB+IEI3mBBoUrGLkdowuLETSZQex
         zt0l0yweCuljXNbSGXYaraRIC3D/+KEuvuaJSyW68G0oPUFs6bpDW/+fPzUwK9/a6lkP
         RjfOrBpX3XqsA/0RZOutsTcfMtGeGS74P9UCE6XxXT3HubOznAZ1q0tB+XUljshHo1+H
         4WHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729762509; x=1730367309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKF8GRab9vIGC7OVVlgdZTWcvJOyU79YNruFFlVjlr0=;
        b=bIqIb2yN1gRFDQs7bzapdwfP0bzPLcpjRhbCjC1VC48MFdcKqCklkUEWL5LPF2xfp0
         MpLBnMeYs08IbipQekFX1WL4DxpNqAslLG7omGIM5nQc9umnJ1P9z86g7Gx5eilqqlwh
         q+PSjUH2eWn8sGNEBcoPmP7wjq2QQSbJEgW/DNRp6Qu/enAL2e5O17U5qxUxHPIVlEAD
         MDzqPzqe2bjRpikFS9rxsbkOdVlCKwa4CVFN+Ldg871KNr2ZDBDfL4rmbPq2JYcpRoiR
         d3eyhGggocDFid5ByPfkrtxpH4Si3d1Iw6yRX/6laExOdEkcxYdITCyoav/Tnm22F6jY
         QLpA==
X-Forwarded-Encrypted: i=1; AJvYcCWLt2z3iAM0Hz4KTO137jXsPbms0oLxWdLTH7Np4Up3FU4EPZOMj0x5zy9FzTrXJ3GbUXsehlE=@lists.linux.dev
X-Gm-Message-State: AOJu0YxWbPVCkvPwLGXOi09DFJ3Zy/m/ZM2BEkEKzU3AoRRjMFRU+84D
	CjJYCFztXdOL380Tw5znmRSG23U9PzSauf+0XwanWfjTBAcgP0QG
X-Google-Smtp-Source: AGHT+IHJTsb9JJqJmmOmnSfNY64SPM8B2FQqgpuC1Eyu27a/9C0R/Xb6xWsHo14tMoRY2Ov75owgcg==
X-Received: by 2002:a05:6a20:db0d:b0:1d9:87e3:120c with SMTP id adf61e73a8af0-1d989ca8e6cmr1171984637.32.1729762509195;
        Thu, 24 Oct 2024 02:35:09 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1415071sm7600287b3a.217.2024.10.24.02.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:35:08 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 5/9] net: ip: make ip_route_input_rcu() return drop reasons
Date: Thu, 24 Oct 2024 17:33:44 +0800
Message-Id: <20241024093348.353245-6-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241024093348.353245-1-dongml2@chinatelecom.cn>
References: <20241024093348.353245-1-dongml2@chinatelecom.cn>
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
index 7976f687d039..4b0daf3510d7 100644
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

