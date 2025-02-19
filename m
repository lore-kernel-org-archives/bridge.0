Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A9E1F7095
	for <bridge@lists.linux.dev>; Wed, 19 Feb 2025 12:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969545; cv=none; b=gFnGx4D4RUHvOfBH9fNXJ9KxSwK4CXiB18f6QMtCDjKc1/MK+U1wFNz7gOJRPKlwE4ikIvjfz2bSvuRhhbz/zl6NW51QO3Ve7d9pPDs9PVJcjGIVCDGyEkutsfPeLHvxQXLhF3dQ6xSYq/mwFqDjrsFUkvPX9GREkP8fP7xzRaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969545; c=relaxed/simple;
	bh=vrqN/QDiEY3adtUjiHJ4zc9O1wCwDFXuoMcSbYrSEaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8hiEbqt4k1jVsdv4G+lJCpStE0S1jBxM38+Mg7/Hi1bRXCB4xLycQyvdfoU9QGKwSBg/fVBd+Ql8HwyLd503MejWXXpwtF5j4/1CX+oS+Jc9WR+kC7C9JIih5SbfBrz/w4Ecmq0nxcevu1+T0jzmIxf1bSzstmdpvrGaxgEK2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crRO7sHr; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crRO7sHr"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220e989edb6so137428035ad.1
        for <bridge@lists.linux.dev>; Wed, 19 Feb 2025 04:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969544; x=1740574344; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRequyiks98F4TvQO/vmtwESixnPXuO1TfB2/aKs1TA=;
        b=crRO7sHrz47WcJHVEUQ0PIWHC49o+8fnCD8ck4mQzglEMmfCT6gpzZUROHVG7GOJWd
         xzHeA+GGXAzCUEfKplLHCLd9pyY1vpTSqrgXvFMAx3jv07sHdtfz5n0IfkYhQVeTsdna
         1+jjV/qCPLFpf5i4+K1rtI9rH+to3a5zmBIYe97e0cGxhGhl8OZP6fnWpTYtxHoimnI5
         GViTYjf+KFUCOeli2aklquKh+VRoOyK2GaInrhcN+EbvDtfzGXbuzlE2/O4G1ufVE27s
         2hfHr3juwWf6emwHcGzHNWBbgeICLBloImfgY4rpbpFHC5OMCP3afTF0t4OYzB6sPXmX
         TlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969544; x=1740574344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HRequyiks98F4TvQO/vmtwESixnPXuO1TfB2/aKs1TA=;
        b=ausjMS1E+Rv5BL7m8XVYw1h2rS4XId+1VhR8NiZnK4L33I0GeJ3UyYQK04L9/Vcg9k
         80KZIXucAeGVzcfqGbd16hoUPzJaAJZMfw9lBWFdp9FqPcjlOgWYpV1a9u2vWgpeKpP7
         bsi9Zyb1BHpsFkSFkDrglZJcMRkofdzqUKkTBU3/KsTugYk44jLP9mBsltOtY+G9IXoq
         g/8QwdlzhSMyVzCWXkZZOIgtdajtFnCWn4kAxJQ+zRFROFaGMjoMCWK47opbpbfZyTp6
         HVWt3XBgEgWZ/pfLrkBKOjAmiHEOwdXNcyeLcgKFwV76nQ373UuW/gGRG5NiS4SuYLYm
         hPpg==
X-Forwarded-Encrypted: i=1; AJvYcCVUz/6Si03raEHiWYn/sn2rkpwNpklSB/yrnaB1PCklp9E/oCc+M9Q639fszk2xdZ2mAFdR0XE=@lists.linux.dev
X-Gm-Message-State: AOJu0YwPq6JFZQIOaI7ylxI5m5/f18hhInCqD/KYph6ra3MOlf0b7xxB
	rbG5td0F0ier8lfGechlrsqs52kXrXK1D7nc+fwJddFXduRbX3l2
X-Gm-Gg: ASbGncvfz3yRdEnSPL5IdAwOE6V/NYtpgwnw/7Z+fyLFk3kTBodCDqst7Pdg4rUfLo0
	4QiAoHoDBILmxpVHG92jIJezNBR8fXusUT1wnMQUg9V4yYSzjSn06BkXxhTI8QwFa0G4or8/V9C
	IxBlpEqVSGeOnKSY33z8a9HM4AAVNMDtfVa8pB2A84VtFQLc67MV1Kl4ICrsSZe4DToOCT/bs2I
	EBgfYoCNwh44kLntuiERH7eXH/GaoTu3Bec5bF/geosolPowHxEComX5VcUaJwkFsFKCPLbN/CL
	zl9Ulg==
X-Google-Smtp-Source: AGHT+IHnb5v62m0BvDxfIowP9iMNtE/Y7pYhM/eIGIlagffbyppVP0uCqTnvfVFz3C1LICvyxAmpug==
X-Received: by 2002:a17:902:e841:b0:21f:564:80a4 with SMTP id d9443c01a7336-221040a9a0emr294098225ad.33.1739969543796;
        Wed, 19 Feb 2025 04:52:23 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536436fsm103427175ad.64.2025.02.19.04.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:52:23 -0800 (PST)
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
Subject: [PATCH net-next v10 10/13] rtnetlink: Remove "net" from newlink params
Date: Wed, 19 Feb 2025 20:50:36 +0800
Message-ID: <20250219125039.18024-11-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219125039.18024-1-shaw.leon@gmail.com>
References: <20250219125039.18024-1-shaw.leon@gmail.com>
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
index b22a106621fb..ec65a8cebb99 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -72,7 +72,6 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
 /**
  * struct rtnl_newlink_params - parameters of rtnl_link_ops::newlink()
  *
- * @net: Netns of interest
  * @src_net: Source netns of rtnetlink socket
  * @link_net: Link netns by IFLA_LINK_NETNSID, NULL if not specified
  * @peer_net: Peer netns
@@ -80,7 +79,6 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
  * @data: IFLA_INFO_DATA attributes
  */
 struct rtnl_newlink_params {
-	struct net *net;
 	struct net *src_net;
 	struct net *link_net;
 	struct net *peer_net;
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 9ebbde0d131c..e980481bdd28 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3798,12 +3798,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 
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

