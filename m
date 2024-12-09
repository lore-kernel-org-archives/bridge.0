Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D9A1A238D
	for <bridge@lists.linux.dev>; Mon,  9 Dec 2024 14:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733752959; cv=none; b=ExIUCh8V+f+Tc7AjNuKicmBhzIb44bPLXbr+DaH1JMeZ+mVK6KswOx/9cHEvOi7OEx+w/i3rQYAQGUuO/TuIm8PuYk0LtyrNURKt4lC8QPfr5JGnfjq3JjuS2TT5CTrIT6uPuuO0xPL6xt9aBecOLInSUQ707rmJ3OYOC8wWeQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733752959; c=relaxed/simple;
	bh=lgJmK7QhO45xqDrvl66irdPCWIX4b3Dm6YQ5hpUAe5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QU58FqYQu6dE8QGLSWgkIeN1oSAGZu17BzCBM9DeoaPx5rtG+ZH+4iXGtk3WDZ+SgHS3COGrT+zwcFDojwev86hc6gbziPkTsvCR64O+BCthW4ImmUM8KUyseuxBraJ8jM/1COl6e8hEgtlQ/4XbvEwRgNa1KKY6SQCPzqwPTio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SuSrcIUZ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuSrcIUZ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21636268e43so17742445ad.2
        for <bridge@lists.linux.dev>; Mon, 09 Dec 2024 06:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733752957; x=1734357757; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93uG6ogDA0suRI92nCq7Qt11rTzcUQ+bpSh6BVGj6ZI=;
        b=SuSrcIUZ/XQ3YBnmrXQOJOV9o9LMWB8MifzuVH3luJBBXguEaUe+L4LaDJHmLZTqXr
         AP47ahaYgPLINNd+V5ttEcj3bCu3I3/Vw2e+PQoeNNGfIGIkq9IoYrkkdHhhfTOPBNBZ
         PhUf5Y+72rLGowvLb0x4YJPajGDczXpku/R1TJ00GVUpBq0ffsR/eG4pfFMxVMIxRxM8
         21m5JekrkUDQJdOUOnVsdfKhDeQmJ1yyLZ/kWgJHIuG5IulXayhakE46uGABpNBNC9rt
         JpMI5uek6R3lkySQ/RGN5J5m8BDlJHVNW8b8b3AFvbA5Yyayl/P1Z3pUlIbrS8tUpj3c
         pMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733752957; x=1734357757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93uG6ogDA0suRI92nCq7Qt11rTzcUQ+bpSh6BVGj6ZI=;
        b=EclBIkeOwhjNn3W5NvcbCyAc5zyV5Vars5YjO9c5sB6v+D4IYkZ8UhoSAoNjWX2Bb3
         t/r+wLnLQv4lZLPeacqdywEnsmf/k1UocnP5RVC76ivHXJgxgSj/BoYrmUCwkjEvvLT6
         nv4qQA/Mnuol/acjht15TzpJ5H3IA6wQXVIAfDd+LOJa7renZ70a+dZV2mcZJyjoS1UR
         45ibLn8Q9HFut2NXKf7ylX05TzuZJB1AneUdxtsu/4CF8PxUmfGv8Qle1/GYYkt3mwjW
         ev7jZ2b7Jsmp+bpb3G5oin2XT0tfHcqeBsW20QCCcvuj2DRBQYRdBK4qt2dL9H8ASgfU
         BLDg==
X-Forwarded-Encrypted: i=1; AJvYcCV+P1bN0t1pMeWoTyyxkYe6WZyQk97sHbVRoXDAXauaqyarkmdc/ESe2ppKE0lKFTsIFkOt6EQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YxOOSfzGfkhqWDjP2Bh8Y+EzFPG8sW0lYueERh4J5WNWLX4koNz
	UfN88UDWaKhDC5mByFYywPpLZ6FTXMWIFOGc4FEI3dgg85JgNLT4
X-Gm-Gg: ASbGncu9B4Julw1wgM4UweEEErANqY9otZ3U6G3t+iix/nyviL/OenLn17RsP5d5IR9
	gJyzh+iPxMRKz4O/I6P06hN3aIVt68RQdw0+fDBz0mTSLxWE/qXGqTRzZNur8RITOShwE5oo+7H
	afhx1uK3hWEAPJUuL7uWETFHcpKnRUwKy5qJdfLDHe6n0R2Gr6k2TxBazDqGTi/tv/v4efVFacJ
	/zhDc9kGZvgI9u2o1Hpc9X2Q3db+dJxkVbEhLbuXi998jg=
X-Google-Smtp-Source: AGHT+IEJ2QVBGY2MGcE4mBFIU/c+dzWKa28cbDvoqfUFybFT/JmX0nfLyJJqRhwpUbbXsTp1UoSovg==
X-Received: by 2002:a17:902:cf08:b0:205:6a9b:7e3e with SMTP id d9443c01a7336-2166a0b59acmr8694095ad.56.1733752957447;
        Mon, 09 Dec 2024 06:02:37 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216221db645sm49605645ad.46.2024.12.09.06.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:02:36 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Hangbin Liu <liuhangbin@gmail.com>,
	linux-rdma@vger.kernel.org,
	linux-can@vger.kernel.org,
	osmocom-net-gprs@lists.osmocom.org,
	bpf@vger.kernel.org,
	linux-ppp@vger.kernel.org,
	wireguard@lists.zx2c4.com,
	linux-wireless@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	bridge@lists.linux.dev,
	linux-wpan@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 1/5] net: ip_tunnel: Build flow in underlay net namespace
Date: Mon,  9 Dec 2024 22:01:47 +0800
Message-ID: <20241209140151.231257-2-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209140151.231257-1-shaw.leon@gmail.com>
References: <20241209140151.231257-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Build IPv4 flow in underlay net namespace, where encapsulated packets
are routed.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/ipv4/ip_tunnel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 25505f9b724c..09b73acf037a 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -294,7 +294,7 @@ static int ip_tunnel_bind_dev(struct net_device *dev)
 
 		ip_tunnel_init_flow(&fl4, iph->protocol, iph->daddr,
 				    iph->saddr, tunnel->parms.o_key,
-				    iph->tos & INET_DSCP_MASK, dev_net(dev),
+				    iph->tos & INET_DSCP_MASK, tunnel->net,
 				    tunnel->parms.link, tunnel->fwmark, 0, 0);
 		rt = ip_route_output_key(tunnel->net, &fl4);
 
@@ -611,7 +611,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	}
 	ip_tunnel_init_flow(&fl4, proto, key->u.ipv4.dst, key->u.ipv4.src,
 			    tunnel_id_to_key32(key->tun_id),
-			    tos & INET_DSCP_MASK, dev_net(dev), 0, skb->mark,
+			    tos & INET_DSCP_MASK, tunnel->net, 0, skb->mark,
 			    skb_get_hash(skb), key->flow_flags);
 
 	if (!tunnel_hlen)
@@ -774,7 +774,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	ip_tunnel_init_flow(&fl4, protocol, dst, tnl_params->saddr,
 			    tunnel->parms.o_key, tos & INET_DSCP_MASK,
-			    dev_net(dev), READ_ONCE(tunnel->parms.link),
+			    tunnel->net, READ_ONCE(tunnel->parms.link),
 			    tunnel->fwmark, skb_get_hash(skb), 0);
 
 	if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4) < 0)
-- 
2.47.1

