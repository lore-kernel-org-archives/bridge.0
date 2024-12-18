Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0F71AA1D1
	for <bridge@lists.linux.dev>; Wed, 18 Dec 2024 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734527432; cv=none; b=SfsJdo6Q5YLVKODBKK4MIbQiNPepN5imVdpY2jHWKZX+Kk1SyZrz7Crw0wZaHfSiG1ko5AWzdQBdr1E9stWL1Q72cj4R+F9fXgVmEBCzgUEjR0lRCyToHxBIkFrhwnnH67LXQTWhsEXuOaWFV0rN8qJjowlFFeTytKM4GtR2R4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734527432; c=relaxed/simple;
	bh=7cGPxfnNq5yiQ2uUz1I87Ai/9MiFtraEfBlwrKXtY4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOBQlUaBDWu8LK4OWaQ1S1IZKrBmKgbTqtaaYrwXL69vJiL+aFEwDS3KaV7leg/cUai0xf/X7P9QikvlGEwR/7Qw/FXIfsRL+l3VY0YzATUKdNL6e/6hMp8IkVqOPSr1y9EVrKfg2KlRWDEn35ICXYzok+mnxpZxv3kUniMKcPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKmnbpSJ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKmnbpSJ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2161eb94cceso43801045ad.2
        for <bridge@lists.linux.dev>; Wed, 18 Dec 2024 05:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734527430; x=1735132230; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKRdbuSYL7hnJpCbxB6/aqEJFoCo8iX729XZZAsUkqw=;
        b=MKmnbpSJorh7zxaPz2pW7SO3wYxjQOotIUkqWEVd8pKMBPvLnzbpO/eRlkwVAkEFjf
         gBsKPJLZLhiVgOTJp4E3YO7Sb9tpoILEGGRyGFgxQhu+mHeqTvE5CYR9poC+r6VDdXaA
         AP2UZfl612VeI2E9plqQltm98adJQ1XhW9fF+hBb6pjZD7pdULTqb79Ick6FXlsxMR69
         lCgGsfUIJIZLVzPKi933tazLeFrpNW1TdrpulDIR0jY8DEsv/gnln0dQSz9HGJD0Tfc/
         UbD4yrl4grdIqf8VJtku0q+2A2EawVcipuAtWbHVE/nQLjvBgPYXNA1hy/ztxqjEB3gQ
         HKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734527430; x=1735132230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKRdbuSYL7hnJpCbxB6/aqEJFoCo8iX729XZZAsUkqw=;
        b=dQpviaZZOofOxVaDEYk6ResCc6BVuLzLz+GAKKb6Wc8md9OO3wL9gdo+pnTTF78Lne
         YtwD2pQqO80UhbVmAzd0h/bR4OtHxLRAKeoijKKzp/ZRTN71muZMfDGYS1IkZSZVSHNO
         7nDlNwI2GO81bQbu1C1YgMPS1R790QLsgq0uLDezcmb+6zld/NoIS2S63kpZBRh2sOfM
         FHmjCBDu+xMl/6MuCNWXQl8Wlj3ndJhqpKrvp4ptexb1zMldNtA9XmCIgZKZ969v+WjP
         sBW3bvOlj2zoGl4QsNkOYKudyq6+YUVZf/jF5fvvpWLLxQWx3ze3CKAl68QY695dn8Cc
         y2WA==
X-Forwarded-Encrypted: i=1; AJvYcCW0Uzs+nZWD3j+kV6SUoUVl/X+x0CNSWGaZujRQJJdm/jFQO1I33A7VO/ZDxeveZvkX0RoJW7w=@lists.linux.dev
X-Gm-Message-State: AOJu0YzFTE5m84LhqOpCQIbT4588O7/dlK67kIc+OK4Lxgd62tNcLdhl
	VCZzZFBsOMlsWd/Q1+ZDNt+CsAqq+RwHToOpGMF/Pvd8XaI5BF1l
X-Gm-Gg: ASbGncvn373rXOk35QSEnpXitHs+9XnYqC2HtR/Kc8EKhRz9oTRuRCKtGjgXc9BSofj
	BMJNZnD2dyAe0B0EHCOACyZRUExnauSgzGobtexaIQ0MTSik4toS+GBgdQc++z5F6LwoCFnIeeH
	QtuEnzo/ATHJ9riqydg7sX512OdhXQRbBlMhA7LdvLmCEA4ye3FX5BqxYkk3wqT14/VJ2fYsRHD
	oiQZotszo9JQ1Whx4C5GdFK3q1AcGoNMAiL1rLfqBARPUc=
X-Google-Smtp-Source: AGHT+IG5uNon7/+5tavnAU1+6ODsDyulZAAiwNo5sldF4FHk8kNssZ4/V0oQpI2qOsRTRp3qJQ4m2Q==
X-Received: by 2002:a17:902:db01:b0:216:5867:976a with SMTP id d9443c01a7336-218d725b7aamr38087595ad.45.1734527430302;
        Wed, 18 Dec 2024 05:10:30 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5c0f59asm7434754a12.67.2024.12.18.05.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 05:10:29 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
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
Subject: [PATCH net-next v6 08/11] rtnetlink: Remove "net" from newlink params
Date: Wed, 18 Dec 2024 21:09:06 +0800
Message-ID: <20241218130909.2173-9-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218130909.2173-1-shaw.leon@gmail.com>
References: <20241218130909.2173-1-shaw.leon@gmail.com>
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
index f7c176a2f1a0..e33ef8a0a6d6 100644
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

