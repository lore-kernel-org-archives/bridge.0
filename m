Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7DF1B6D0E
	for <bridge@lists.linux.dev>; Sat,  4 Jan 2025 12:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735995533; cv=none; b=CITzKtyiA6M0EBCyDzmnrZyiMYad3lQaT+N9ShZGdoLEzFo23tn/4xASZE9PGC0lhpgnl6JWmIfmttwCGj9NR0ASEiPfdxIklCmeMbXKSTXBZYp97FMi+8cFyIYZ+k9SeEL4amoawklAWhDUWgaZhJJfYWZzz02j+E2bbqFr3qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735995533; c=relaxed/simple;
	bh=EFQ2oZ/pVpV182DEe1+4WrljQP7wjczrTMLRD//DgW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ina/OR0BP8O3S9ZdnOkV80a0JeFYCDy+pUg3Oz6RAber6oAEKGN8+FSlaqwDK+FjPw/Y9jRkdKHvR1O5AJKaqnCdZStAilkNddpkYfsgXCjybtUna5veu7foCtPEWg710EZBCEhs1jtmxWtmm1WTKwFFXi6+PcWqpGEzdeBcSxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bD87VcSc; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bD87VcSc"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-216728b1836so164392035ad.0
        for <bridge@lists.linux.dev>; Sat, 04 Jan 2025 04:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735995531; x=1736600331; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ce6VaPIVkPoT/BnqzSEc4rQsuMP37QI18aEevx41SAs=;
        b=bD87VcScQZMKbz7QN1v1CWv6mRS+9XHcnXdsA/tQGBB5CD99Yph1ybPxxIL02nqRTK
         0+zvH4xmlUCHjQjuP8TiDy15PVHe3d94fmzVG/Zw8bCGJE2oOH6N4sFJGn5CXcF4MIbL
         nuA2esFMdmZSDZNbn/IH7/eqfP3EZHNyLnwWN5bA6sQi/Jn5EIYOcXFBI/qY3MDYVRMu
         zaXwz9jj+YNKEijL4wWyEh4SPKzEOeWLwbAyimLerNwfZBG6FXhmIaIMlrBqL3UcIdLH
         1KO0v3RTY5AZ3g9pk97hMJ3eIp4lrIMxRTT5ubW14kKgIaRMcwXpkChcaOPKqhBMdP13
         TU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735995531; x=1736600331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ce6VaPIVkPoT/BnqzSEc4rQsuMP37QI18aEevx41SAs=;
        b=IPQ34CnVxa+1jwzkAbZqh3un9+uqwz7y/mBQs+4umgvSJTRCkox2zqtORbfTygJG9t
         Zb3cOB/9MvtTKV9ylrZ9B+daEpxQmi28Bl4guEmzzS3aWhprVGCTiZM+8AmSUlBZWBj8
         ZtnkIo10EWiS2AybkRq4EZnhLNK523PjJyg+0W/CmKX1fr4cyPQNC5TUBr3xZbO2JEpe
         Li7FAafWXpLdrx8MdEx5UKq1vkj4h9uT3eZA38nFyYe1gBA7rWaQZCeXVhfFQEyC9VXe
         jsFvicG7iIEidODKvaVBg8wNLdIgENttSzfHuRM/JO8l9t4WCI6awpRSbEysQnxfexmz
         AZKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf9llcipG+0+X3/bug6pHcUF17T1hvmiXMCwfgoD0GFjAjASTd2GIaJ6obxGUvF0Ff+9j0sbw=@lists.linux.dev
X-Gm-Message-State: AOJu0YxWTyN2Nyp29L9iHJ06CJesmwGAiqHOFLTP3aThmdnFJuy9fvdS
	IyE1VKAyLOFKFzYh6x8r90OuDXNzWh/F3WiBgAt/7o4vYw2A3MpR
X-Gm-Gg: ASbGncsbN3ylSqpoL301XyzPFy78de9zxrR6+jYSlkoSi+yAtseOpcTF0AqEnRdvcdh
	vzWYjuiBwuq5ngoz6m5/h/+6luedZiJsxeYda9fGivZAykxp2K3Vq2ANEnbIa9XsnvHEzuILQg6
	/1QtU38UKS+4yBP5Yu8abd5L8f0xu47Y+MzdeQe9HdtLEwJN68VF01SRfluCOgcMsWZKdT/V3h9
	h9rLn9x9LkSGJh81cmdSHWOfKBeGCmrcTIKHiy8H+HlH0A=
X-Google-Smtp-Source: AGHT+IFpOYXqaI1R+HGOEzzxslPytJ/PM+OYSeZsg4xs6ImgmD2P2d6ce4kFlhBJ9qWXqvAf2AhpWw==
X-Received: by 2002:a05:6a20:1596:b0:1e1:9f57:eab4 with SMTP id adf61e73a8af0-1e5e04609b4mr80108339637.16.1735995531119;
        Sat, 04 Jan 2025 04:58:51 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad830349sm27761344b3a.47.2025.01.04.04.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 04:58:50 -0800 (PST)
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
Subject: [PATCH net-next v7 08/11] rtnetlink: Remove "net" from newlink params
Date: Sat,  4 Jan 2025 20:57:29 +0800
Message-ID: <20250104125732.17335-9-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250104125732.17335-1-shaw.leon@gmail.com>
References: <20250104125732.17335-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that devices have been converted to use the specific netns instead
of ambiguous "net", let's remove it from newlink parameters.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 include/net/rtnetlink.h | 2 --
 net/core/rtnetlink.c    | 6 ------
 2 files changed, 8 deletions(-)

diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index ed970b4568d1..04fc0e91af42 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -72,7 +72,6 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
 /**
  *	struct rtnl_newlink_params - parameters of rtnl_link_ops::newlink()
  *
- *	@net: Netns of interest
  *	@src_net: Source netns of rtnetlink socket
  *	@link_net: Link netns by IFLA_LINK_NETNSID, NULL if not specified
  *	@peer_net: Peer netns
@@ -82,7 +81,6 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
  *	@extack: Netlink extended ACK
  */
 struct rtnl_newlink_params {
-	struct net *net;
 	struct net *src_net;
 	struct net *link_net;
 	struct net *peer_net;
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index f902b8a5189f..a2246bbaf2bc 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3758,7 +3758,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	char ifname[IFNAMSIZ];
 	int err;
 	struct rtnl_newlink_params params = {
-		.net = net,
 		.src_net = net,
 		.link_net = link_net,
 		.peer_net = peer_net,
@@ -3787,11 +3786,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	dev->ifindex = ifm->ifi_index;
 	params.dev = dev;
 
-	if (link_net)
-		params.net = link_net;
-	if (peer_net)
-		params.net = peer_net;
-
 	if (ops->newlink)
 		err = ops->newlink(&params);
 	else
-- 
2.47.1

