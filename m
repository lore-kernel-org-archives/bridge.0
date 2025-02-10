Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED5722F3BB
	for <bridge@lists.linux.dev>; Mon, 10 Feb 2025 13:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194256; cv=none; b=d/JRz6o67/giuxXzbB568sPlZV0M9IsMMPZ6SSJSksfDZIud5gZQqZMJcdAEuivmoz6GU+Iyn5vc3gnhQxWl2Exla2+WIZ3b89q1RpplaydDrxeLso2rIzyah7sTzAgUPqdzi7qtnmG2Ts1LycdHs4iGyKDk/hMQT43EIMDMbrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194256; c=relaxed/simple;
	bh=2u3aiZwG7nXyk2L47N18SQQLK/lDv6g+qT0nQKd4pSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=siPIoIij+MXyCjMvUejv706glR9ha+rkNu3Y+AyDLfBgDettbfFCZH1vaJAfwCmE1SJEzEysVcH1n20gkvuney6hAvarnkSPlxsRcyEYTj/h8aThrAMVNBjc8SBFTbtdWvo0V5VHXQxs1ya5ggYyoj55yTxg7RifkvFTPguOKyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4/fOqsV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4/fOqsV"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f4a4fbb35so54705675ad.0
        for <bridge@lists.linux.dev>; Mon, 10 Feb 2025 05:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739194254; x=1739799054; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tN6LBIpl7aUsxZAQ1nC9Mvrd+HBX5wlThy/HCxYMvw=;
        b=E4/fOqsVir3KEhvnMQUJkZB0U5HE61ZoPSJNkHBsKfvtsvwsk1q18YWuRVWth7UQCX
         k1fN3qQvNrAuaORq5Wf9PgdaIGjdyA/vWCZmHfkbwXp4foqG74KxxMCzxq5PR2fXEpOP
         3iC8GOvpPjGmBaEPte4ZAZiyVIsap/+Muei2D0RFmJAigxexhoN+SSBkCPEWbHT4mzJ/
         r9PdTJQ54EyQONYmWZ22QXpz7OUVJh1Wnj+qzBUqsMQWlYz9jD146JrbsrC7COJ3Cg1Q
         5W/1T+YwvjtHaxssFWBiDXYAJIdwftHf7va6AASb4Xvv1WmY5gemyi7uN82KRifYI3SM
         JxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739194254; x=1739799054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0tN6LBIpl7aUsxZAQ1nC9Mvrd+HBX5wlThy/HCxYMvw=;
        b=TJsaIrJoHLuAxfHNcF706ZX4Z7htJuPRJAxTtX24Haxpgqt0CWKd0NmJKFF1ITnqMa
         qwYyTptutCXNnE4XMpWtDC9SAltYD6J9hxhTkBZuYxmUkCtLwCeKjeZnsor6OneJeAQv
         P2hfY4897pUpXrDhyy73kscNftkOB3+sR659h9xUmJKNA62fE3p3k8VBRKO/OfzNyxnq
         9FeC+A4UINGFICrBgi/VHSQjnUqHm1Bbz3FEK55vBcUZ239N4vtjWKabjYmSgGMGw5Wh
         B3XcMx91hhPLpYyrb4lGSJtczvNLw2WzY+ykhN/9p2FlQBpPmYNz7VFkWjSL/PT/CBgX
         +16A==
X-Forwarded-Encrypted: i=1; AJvYcCXL6X+vt9ouNEJqTVjWlIK3KW49flAscyMwPYMtCtH0jx/S2MKzAv4eHjarIZckOvtzq8HY6x4=@lists.linux.dev
X-Gm-Message-State: AOJu0YzYV51mvwbLAfEnaXeSMzkDbIYa3/6J2O1cGhJ8OBs5x3qC5O1I
	xrhMzlKFk1tbcKTOi8ybnJRICFwvtnrnYhOIVULQXA6yEJhOJ/Uk
X-Gm-Gg: ASbGncuqTaJqiUW6xIx1Qpplwhi5KdLvomq5rYURRgTLqHODJlDbogrpbBEG/pbS1tR
	6wwLcjhpZL9MqR4rJ30v21MOlwsCFphOm5pGRKam7VoPZqUEvsK7kctMdUmlIy4EDJzF3nO3rla
	ZR1ABZf9nZqM0Yh03PfmLgb5nxlvmH5Ak5Nr91iklyWsf6s7jXdU6xgt7alICZXTRB5tv9+EXhu
	DVdTgsjZ1EE6M6O0g1V7ACkgCKkQTam8r7P2pAyeBwfo153qwLQdvxND58LNod4NXmvpiTLLpsP
	9i/tdg==
X-Google-Smtp-Source: AGHT+IF8gihjdkRbSU1HRP8R4mEppMkEAKGDChElxIvCxKcXV79FUInFhj/RnX7alUKIg2RAq5xNnw==
X-Received: by 2002:a17:903:46cc:b0:21f:6d63:6f4f with SMTP id d9443c01a7336-21f6d636ff1mr134607475ad.2.1739194253851;
        Mon, 10 Feb 2025 05:30:53 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653af3bsm78799445ad.57.2025.02.10.05.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 05:30:53 -0800 (PST)
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
Subject: [PATCH net-next v9 04/11] ieee802154: 6lowpan: Validate link netns in newlink() of rtnl_link_ops
Date: Mon, 10 Feb 2025 21:29:55 +0800
Message-ID: <20250210133002.883422-5-shaw.leon@gmail.com>
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

Device denoted by IFLA_LINK is in link_net (IFLA_LINK_NETNSID) or
source netns by design, but 6lowpan uses dev_net.

Note dev->netns_local is set to true and currently link_net is
implemented via a netns change. These together effectively reject
IFLA_LINK_NETNSID.

This patch adds a validation to ensure link_net is either NULL or
identical to dev_net. Thus it would be fine to continue using dev_net
when rtnetlink core begins to create devices directly in target netns.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/ieee802154/6lowpan/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 704bf9e3f097..ee318d46817d 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -143,6 +143,8 @@ static int lowpan_newlink(struct net_device *ldev,
 
 	if (!tb[IFLA_LINK])
 		return -EINVAL;
+	if (params->link_net && !net_eq(params->link_net, dev_net(ldev)))
+		return -EINVAL;
 	/* find and hold wpan device */
 	wdev = dev_get_by_index(dev_net(ldev), nla_get_u32(tb[IFLA_LINK]));
 	if (!wdev)
-- 
2.48.1

