Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135C51B2193
	for <bridge@lists.linux.dev>; Tue, 15 Oct 2024 14:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729001316; cv=none; b=hkm4z1glGOVDW+z+n8C+CRiyRhAC9E/4+d2R/n9XCarLezYiiySf/gViOZVBXyxFgCLoj5sp3SqX/pqUFk7Hiiq7zBZWsbHH6WLUY+Tv3Xlo7DGQVXSF+i33cXoeixmz08VesUfGWCS7CjoNNWDq9VXAEPGpzkGgtEL/tNlfl6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729001316; c=relaxed/simple;
	bh=zjlkYbbC8QBM7Wf3cdYohzkjfajX7qpT0FaW94GtYUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AyKOUn9s4v4HAmw6AFdPh5D/6I5QVZ7HNbYRdVWlkW/kYfygEc32X8aicIfH5Xkk1iVAkMU3TLjEZ5ACs4CaqXUHTkHiiujr88gKYhcyjR0yXnbYXWiQOD04aGpFGabhkLGWEtwAJ/V+ccec/IwkzVZj5P6rpuKjjhPmYVxs/gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SE7m5YKT; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SE7m5YKT"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-20c7edf2872so40884845ad.1
        for <bridge@lists.linux.dev>; Tue, 15 Oct 2024 07:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729001314; x=1729606114; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXNVpwdypQN7MhzdxvEJ3Is8WZEvjSGwXelKg8lkKU8=;
        b=SE7m5YKT/N+RUe8R80yReLV1oYyYTt4d27+icFBLPGLWGSKJvW2Iaitu66BGoKy/m3
         tGdhAQErDOzJeAr3QXTF/Lgwk+jnmAr27kx4pKFJbstxMkyImGTWz7vlG5MxI2yiTprr
         gUqfIrFcLGU9RLiwTEryi1DIgsHDDfH5Uul0nI73RUc9h/vmjneml8F3be3TsXfD4a0/
         x7sEwBK9bjZMKZLg1/UjecIvc6vstcbQ/M6utphnlexj/qlywdVXbqi0k0s+FqM0Mpuw
         N9b7MVV+DVHw0u3AkH0uOxFcveSaHg8S9UPgSJHXTZR+yixoLgeHuiX+jtwO1hhaBetw
         IvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729001314; x=1729606114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXNVpwdypQN7MhzdxvEJ3Is8WZEvjSGwXelKg8lkKU8=;
        b=JC7zmO4xgwe598V3irUFYb8dJWo046PVWaH8AK2yy+RvFqVgq6hfLTbzvPLp3oKvl7
         4QaOyTGIA2YVosoYhOKt0wMdzibFJH6jMw5cLyI/572yddsMnmNMwHxORJOfVStgqmTF
         RJ7juTs4DjpEtcNnihADodKF1pTrKSKEvK4H4CLCjsyWGRl6Otcp1OoC1CQgWYam5tvR
         7I58TfZEGphmOpbBio0ts2M6scF3uKbQa8E43UH6rwAuy9lg4mKhyuCMSCiDRlgCaQUa
         ZYqgVvZwb0TIHgfs9/tMPowEiKGAKoGm0lvDS3HAOOSmC5HvcbnOAxj8Dj3BdF6rFe+r
         aL1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZEsp4CZXuvQ3oyNgNcpW7od54+zV6ZYyL+jjSn+XDD1EXFde3P9P7iymUW1UsvLC6+Y4XQPo=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywppojz8rUBmFuMBjVRzz8nvhcgABwh5q3h3wW+8wGA2Tm1glUB
	KoCNX3NU+UMHG4glDsZSx2DGb3ZVchDGcX9hxdmjipENt0fQZywT
X-Google-Smtp-Source: AGHT+IGRXJjST0HTxQYk+VFHEHpjAD+R//v1UjrCQMEfF2mjki+N/bHGaWK/rOjw6+eX9IGlKmdSOQ==
X-Received: by 2002:a17:902:f647:b0:205:8b84:d5e8 with SMTP id d9443c01a7336-20ca03a6a5cmr217260785ad.18.1729001314209;
        Tue, 15 Oct 2024 07:08:34 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f9d419sm12437625ad.93.2024.10.15.07.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 07:08:33 -0700 (PDT)
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
Subject: [PATCH net-next v3 03/10] net: ip: make ip_route_input_mc() return drop reason
Date: Tue, 15 Oct 2024 22:07:53 +0800
Message-Id: <20241015140800.159466-4-dongml2@chinatelecom.cn>
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

Make ip_route_input_mc() return drop reason, and adjust the call of it
in ip_route_input_rcu().

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 net/ipv4/route.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index df5401efbf56..7f989e8eff30 100644
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

