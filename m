Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BB022F17E
	for <bridge@lists.linux.dev>; Mon, 10 Feb 2025 13:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194292; cv=none; b=cs+GeRjx7EmmgcG1LwUosrskzVDiIUMwu4EzIPBZsF4KxSFw4LsF0IdQ63yFBBWGunZSbp56tBmO/qr0muRa3ExumlDnCky+8lYg/v46r5YGvcJusjG3FuI+gcr8k7AZyLPV6nEX1jlV2m4QDjiUWQnmuGPB4PfT9Jvz1A0ZHvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194292; c=relaxed/simple;
	bh=FC90xSA6ZrsI4/RZzCluVx1dKwXoKKlt/hRW+0eki0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8lzv+9RtJ2rnORCwI9wN+pdl+S7vVy+Trc2x6eQDFArInSrvhao9v/a7pZinC9JYl4i3FPnEjKoyQJezRBZphmirRR1gJyGKry/x14u+hPEgjes2c5ykG2dVR9VgUiOan2P6G5VAs3t77Vc5gRh60ZU2dVbyrbKk/TDByYE/io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjKUKtyo; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjKUKtyo"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f61b01630so38632795ad.1
        for <bridge@lists.linux.dev>; Mon, 10 Feb 2025 05:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739194290; x=1739799090; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIWpuyrhnho0qabV5ShFTJH6UcUC2BreOZhovgVT2xw=;
        b=CjKUKtyoBzdApfk6ZYYSiEGISObksSdzQbSa0w6H7WMxpNmXP1Lms4qNGCr7Bcbk9/
         AZ2M/s3Hw2rojDVWi2HG8uyYlYgylvth9TH/R71W44/JtMzmNnM728H0stwibWsvpTjT
         IAw98HpTsKSvfx/GiOueBnw5rKS08fYRmITyNqHwybLoG6I80bEHNVpD/RWUEqayUVIJ
         HDh8sKLuCQhrciQJuck9ZzlXkv9PkkzibwA1SrQOMsXiH74Ea/K3Ws0SpACRAu+FTG0q
         icXQxPzTIqkEtF4096+BSWqsefqKIib6UGJ9pcCDTxqEH3nTeUqx11OwuoP7jgcB65RG
         xUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739194290; x=1739799090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIWpuyrhnho0qabV5ShFTJH6UcUC2BreOZhovgVT2xw=;
        b=LpDeN00VMk4tplNOwlS2fOxj46HDQBmiRB3h/zoErNb6hRrWzG01sa5IDv5P5PFY2u
         ONNJsoZgNT0YM/zvLEe3l0actsfsLjvUfaDvLvvPUiMibXgX5NSpuucrx1B70xK3WVRm
         fxN4M/88mi2L13A2q/mr19cm1MGvbc7EWSuW2cxPWdowU3/QcW50LmIOxsQ9lqdLSi/d
         m8IcHt8PRBbl+JJ/19zdC719uhdaBYfpBobMW2JzqUWh/FspWsMHaWk5brI3hLh3nUlZ
         z2DvDUkSREVUwDTPamWGDdQiR/wPM/D/5R6KqhO+38ng+0wgc5CH83sTEejkd4yKSZXw
         uB+A==
X-Forwarded-Encrypted: i=1; AJvYcCX8Z7xywljxUz4uoa/4FAFxe6TH2g0h1zliXUagUawQY5H9Q2hfrC56LY5tO6kRe+R4BplnUsA=@lists.linux.dev
X-Gm-Message-State: AOJu0YwgwwV4PADflU6i/yhXoODsxF6ta/tEc5+KsPZzCp4QImyNHrR/
	Tow/hP7mZoO/NYF3z4Lot7mXVOEOoLpGPGN6y4fzSSmW5tEoK2lu
X-Gm-Gg: ASbGncv/V1ocA0M8GSB+/JwytughhM4mUZTzgdYhLP4ymtmgflo2gLGpdJD0A0JX9sj
	DwpWeYLl6Q/ytVHA9z5bhu/S47ZwRa2DLprUiWjEStN4v+h8+e4gzGcV2kgyIw0fNicfRx7iSOR
	3+1/YCS2FH6DS9oxcMiBSE6nhEp/2xREK61QNa7bFj8rbzizrq4npoiSxJ+kdqqLlW1mtrYt0Pa
	mUjfo9BVJCgpKT83qIxBhlVGv+7UwGZ3L8PB0F3P35OuU8LbXnMv0wH0FYBWFfaxLJgbFiygW+l
	eIYYcQ==
X-Google-Smtp-Source: AGHT+IELdC20KTjI7AEzrj7SsYJqrzU0cpR4bU0xmzWBFbAdZdANoU6evRtqtyIIyxHfa7kTbn7qJg==
X-Received: by 2002:a17:902:f60f:b0:215:6c5f:d142 with SMTP id d9443c01a7336-21f4f7a257fmr230770855ad.20.1739194290046;
        Mon, 10 Feb 2025 05:31:30 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653af3bsm78799445ad.57.2025.02.10.05.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 05:31:29 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
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
Subject: [PATCH net-next v9 08/11] rtnetlink: Remove "net" from newlink params
Date: Mon, 10 Feb 2025 21:29:59 +0800
Message-ID: <20250210133002.883422-9-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210133002.883422-1-shaw.leon@gmail.com>
References: <20250210133002.883422-1-shaw.leon@gmail.com>
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
index 00c086ca0c11..dd51240431b8 100644
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
@@ -80,7 +79,6 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
  *	@data: IFLA_INFO_DATA attributes
  */
 struct rtnl_newlink_params {
-	struct net *net;
 	struct net *src_net;
 	struct net *link_net;
 	struct net *peer_net;
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 7e98f3cd102b..e9af0775fa6b 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3797,12 +3797,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 
 	dev->ifindex = ifm->ifi_index;
 
-	params.net = params.src_net;
-	if (link_net)
-		params.net = link_net;
-	if (peer_net)
-		params.net = peer_net;
-
 	if (ops->newlink)
 		err = ops->newlink(dev, &params, extack);
 	else
-- 
2.48.1

