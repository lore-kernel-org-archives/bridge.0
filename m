Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CEA158875
	for <bridge@lists.linux.dev>; Mon, 10 Feb 2025 13:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194228; cv=none; b=nvufuqOpFxsYeLuRVvC/UVyElBT1E/dDPsvhzpeDLyov6rsmYIh8BvL8OX2Oa1XFiIwpHJGL+gN916qmrqKJsGAIJbMcws00oOdzuD5wv6t4U6Ts1+bLIynRnLFSGAEUj463SAfLT1/LYLPHhD1b0D0Q7HDZa2JjpNRHw85ja0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194228; c=relaxed/simple;
	bh=GjfoXCki/WJvjmnx4S+xzsgMh0oaUaBRvXwm00gIc9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bbWboGAKTm32NyAdgrzwDkZqBupbAWBILZiApFkRbiPdwER/o/whP/37wXVALu1bkvZWzJl8gY8rY8VZMEQcBh6xyF0dfOp0a5wsFRNrQX/4Ga5XN43DcNfCRyE/YBFrAL0dhjWu3myLNYJAKFHiB0Pdk/CJLNFOZw1I96TIog0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9egOxtN; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9egOxtN"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f3c119fe6so95782205ad.0
        for <bridge@lists.linux.dev>; Mon, 10 Feb 2025 05:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739194226; x=1739799026; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1pf9SNTQbR6dSoBCEAV6dPuN8Gz1/YecnHQoz2AJqpo=;
        b=Q9egOxtN98uY2n8OdVIYfvObTLiaMWUwifIte8U6ozd5Hha13KrpRUyswmir3zhMfM
         EtOQBxRCnUhjYf9UWTu57E8izgwEbwR16EeW7MAFJLxJ+gsDPOcBMzcE5/i0BqZera5C
         X2jdougJ0uNy28F7mhe+q088sDkH2DbikrSOmrvqlcfXmtofnvXLQnzPMskXqUKhdcIF
         wg7wTqZuSFxupb5gXzuRTgfqSkQMkVnw4TJXEgRrB55TWscATjWBK8P42JYoEMQKAFRg
         PYSdizxkno/96H8kLApYGUHSmJ1WoNZ265cbfXQZxcngMXDnGbkLl3Iw1wV/T+cgTpOI
         V/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739194226; x=1739799026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1pf9SNTQbR6dSoBCEAV6dPuN8Gz1/YecnHQoz2AJqpo=;
        b=SuqICpFgsmq3kPm3dF6GgtNz/5ff1iAQYB5/WN+VIxqueJfCiJNKyIO0JmnRH60fHI
         KxHCPGK+pxz5BsBAV5QlpsJFngqIw00vEKIG6zZObT8hCqia6emMcccZE1bAQs/Uwh7U
         1OHIbVKYpfXVmJWhLsEqszUOxtP+qCXpv+b66QrLw9OtcBpSg0mktsTnUyaXJMQ9yOm3
         ZAZfsoNWOrLl9xk4kwNibTb2oYejt5AENaDYFiZ9QIuO9485KRBb7g7e9EllVof+IFTl
         qNtad4ayGvdJl+Q0gH2FL/QEBpDuccV1NP8VhEHAv19AXFe+8YTzu1UQNwZ+g+oQnYcu
         NKog==
X-Forwarded-Encrypted: i=1; AJvYcCXBP3NI5UAPCnBNOeFizWld5vMMllFQnMbw4DEXW9o7Vp2PFGexq1HVFL6MoCtEpqrzOrz2pPk=@lists.linux.dev
X-Gm-Message-State: AOJu0YxbbZKLXzm4IzRpD/pmm5+XGMU7aqysHHtT7CHI+8kQbol1DYGI
	aSbhhM9saNrMwDXoqV5Ua8frBUsi43sCa/4A2Ry72KpfrdsVgjkO
X-Gm-Gg: ASbGncvOpPVBVKSri2JEnQ5eB4YtYljmkmQWhgGNNym3L+sqyLe7qOMnxVEHYomTEDA
	X3AIfm0oYEhHFoniEXaWYqEOINLCiqAERcT+PpZSHdmlG7UtTm2sW1pVvcYnWqVrv+uDEdcY7m9
	ZPiGdxtjmQFEkKGA+nV4TT2+tiRSAv0MQS7+1RaSNu8+JINdm89+yambj7T5h0cV1S8ZnYPglQk
	4oolxOChnCdy41IkevlLB0D+qlhMUASPOq+kni0Wkhc/AOWKy7op+9+uUgbEYcXlfy4OcT/K4To
	tN7bpw==
X-Google-Smtp-Source: AGHT+IHnIbIec9duqjv7lrtmGReNVQPeBtoczKplB0CDd7UUW+fM90Yj1MwAFqvvYB9Zquhv6onO5g==
X-Received: by 2002:a17:903:240f:b0:216:7cde:523 with SMTP id d9443c01a7336-21f4e739f99mr242405235ad.32.1739194225944;
        Mon, 10 Feb 2025 05:30:25 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653af3bsm78799445ad.57.2025.02.10.05.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 05:30:25 -0800 (PST)
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
Subject: [PATCH net-next v9 01/11] rtnetlink: Lookup device in target netns when creating link
Date: Mon, 10 Feb 2025 21:29:52 +0800
Message-ID: <20250210133002.883422-2-shaw.leon@gmail.com>
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

When creating link, lookup for existing device in target net namespace
instead of current one.
For example, two links created by:

  # ip link add dummy1 type dummy
  # ip link add netns ns1 dummy1 type dummy

should have no conflict since they are in different namespaces.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/rtnetlink.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index cb7fad8d1f95..3b3398283a8f 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3866,20 +3866,26 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 {
 	struct nlattr ** const tb = tbs->tb;
 	struct net *net = sock_net(skb->sk);
+	struct net *device_net;
 	struct net_device *dev;
 	struct ifinfomsg *ifm;
 	bool link_specified;
 
+	/* When creating, lookup for existing device in target net namespace */
+	device_net = (nlh->nlmsg_flags & NLM_F_CREATE) &&
+		     (nlh->nlmsg_flags & NLM_F_EXCL) ?
+		     tgt_net : net;
+
 	ifm = nlmsg_data(nlh);
 	if (ifm->ifi_index > 0) {
 		link_specified = true;
-		dev = __dev_get_by_index(net, ifm->ifi_index);
+		dev = __dev_get_by_index(device_net, ifm->ifi_index);
 	} else if (ifm->ifi_index < 0) {
 		NL_SET_ERR_MSG(extack, "ifindex can't be negative");
 		return -EINVAL;
 	} else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME]) {
 		link_specified = true;
-		dev = rtnl_dev_get(net, tb);
+		dev = rtnl_dev_get(device_net, tb);
 	} else {
 		link_specified = false;
 		dev = NULL;
-- 
2.48.1

