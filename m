Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7011C3F01
	for <bridge@lists.linux.dev>; Wed, 30 Oct 2024 01:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730252607; cv=none; b=Y0IiHtOX2rGqzHL14azjW83Ab2iwe08zIcQQpg7IdoYlEnRGpNXVpxnFMTGyEX2FE4L2gLqn65FP3ZBiUePMQ4KMIBxtUPpMcsPw3s3iKpAVQxBqwCaJ5QJHvjKBsawquCqk47/VbrC3uq1OdDzRN5GwV77YSFDALibUxErOYbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730252607; c=relaxed/simple;
	bh=A/n+tA2LV99QwIElK+AO6/wgstFiziRfCh0zEBgGADk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JieyU+U7z5tgcLAPm58Rnpy9DLYWbQgR1mIoLjx1rVo8z34xh35v0sruBx/hukuSodBdf2MLl0hZ5ZmGq2EGmyxHtnSBB/VD+3bD/IilGx9XiXGC+JjtspZXbo1uHlIbfhncZgCIRPICC8ZrMFq2cV69BE1FpnWCVk9RDsCr93A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWRij3Ss; arc=none smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWRij3Ss"
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-3e602994635so3753127b6e.0
        for <bridge@lists.linux.dev>; Tue, 29 Oct 2024 18:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730252604; x=1730857404; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsqFsNdo4NVKbN05C2RYi/RSEJVp+Ni3JWGZTDWcFI8=;
        b=TWRij3SsDc6nniTgTgjoiP4ZEoZlpu60cfQwuJoadGK68a1DNF/ilJQ+nC5jLk3Dxj
         ROZ7zrcU72Sa/XOnwxzpvSTZpp3ewnx3TpIO+wG1bsNQIEYJ79sYKaxKDy5VmgDKyWLw
         co/z1dXvkPnEIAx1V4Z3h4PhrTv8cEQc+Cps9vYdZ2Qch1vWqloPT9B06NkkJ1b8uAyA
         0UIL0ZrRb3LhkTDjxoy66UbW4R4meYwTSFvUDiXX/QLzAulh13Oy+1olSzgqULFcE2HP
         yJAxePzAZBqHxgrb7s06BRBkZMlvA/q6juSPobTyb9xIXPBpa/f18BZPUJG8SoGIo54o
         s1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730252604; x=1730857404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VsqFsNdo4NVKbN05C2RYi/RSEJVp+Ni3JWGZTDWcFI8=;
        b=TaBV5LI4tTtMkyNKz/UGXGA3qjTlTuTSsq/ttnAhKVvoVjzo7zUN2EznZ5cIDX9OuX
         45XrMXLsry5s3E4tx1PVDMzD1rZSYG0afgy4Y35hYM/joYO8hdDxS5TU0QbSl/g8aBHm
         mPVAKcVUuyxjXrKxqwv8Y9fivRNHzcBjoQy0SEvgWu4If9vqq+JOFwTkt2sgGam7lJlD
         6PBM8FeP4ITAOrI2QGegbtnNPKmPWXdeOGB7RrXAAEeXUzxH8a71WALGbZdtACyAa0XO
         Tuj4IZZiJEnRBz18lddZ59PFzX+r2IuUudR01P5bFdVn9vSoXDM9qvc7av75eXT4Qkn0
         cJgQ==
X-Forwarded-Encrypted: i=1; AJvYcCULTGBAWhg0EIKe4ScSuPmJ01elKB4izR6h/FZKDs8g91nYvietpAHuJP7U3ZDXW4uwgByfW5M=@lists.linux.dev
X-Gm-Message-State: AOJu0YzBaWGCqY3ymaX3bWuX2uORse066ovNWtz0lY5UMc8ps42Att+q
	iepA577oGMsK7Y7hZcc+/LH/XSwmzkY8S8E+FS0CUOmFR/R+nCJK
X-Google-Smtp-Source: AGHT+IFRqo3e3L4yXTv3rX5bR7Hg6ifzhHqEYCt+WbgiCc4zN+xOObjiqS/gASg+PXrO7UKBKJyK+A==
X-Received: by 2002:a05:6808:1649:b0:3e6:4d87:8f02 with SMTP id 5614622812f47-3e64d879ac9mr5753123b6e.12.1730252604097;
        Tue, 29 Oct 2024 18:43:24 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc866906dsm8138407a12.10.2024.10.29.18.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 18:43:23 -0700 (PDT)
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
Subject: [PATCH RESEND net-next v4 5/9] net: ip: make ip_route_input_rcu() return drop reasons
Date: Wed, 30 Oct 2024 09:41:41 +0800
Message-Id: <20241030014145.1409628-6-dongml2@chinatelecom.cn>
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

