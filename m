Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC6922F167
	for <bridge@lists.linux.dev>; Mon, 10 Feb 2025 13:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194301; cv=none; b=j/xcZPgIpLpfW16PS733U08E1rAEi/sO6X3lYjG/HQKBDASniiCdifC3VTLroI4LBQJHKzklbf2I+Ua6UN6FcHcJMlhVo/xcQEBtgq268pYDw4YDEEMTpQcMxc8H2fX2oGs0xjj2KPBPdhRu8XG9EgkRCdlITRRKIB1AsjpWn70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194301; c=relaxed/simple;
	bh=069lUPDUvhmknVR9QmYXw35UhK+BSSNOI16puwTCeHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eV0sFfCyc6K5p7fGKXKhTCOxTyEdL91nh+CszlrqbV7o6OlGhrYp7KnS1lbYeE6ThibTqEQq2+l1SK6z2Si5YUwzchN0Am6gFelMkNvGn8ZEmyGEQ4uAeqgEN29bD4gxMIXAl8UuhqU1lCvM19pH+IPguQojUjbrdE031h104/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNgscqqX; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNgscqqX"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21f7f03d856so26135495ad.1
        for <bridge@lists.linux.dev>; Mon, 10 Feb 2025 05:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739194299; x=1739799099; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBYzKh666wM3wi72dCVNRA5e881/bj/k98p0ZebqkRo=;
        b=QNgscqqXkQao8Sx5qd2CNj/BR9plmQitskITkm/fw2EnZ/UrO+RMsN7DaOS+aes8Uo
         Mgmo0+qIuUNJ/MAdj6wJttMwMQlM2H4IaY9pEKYxZf1m+VNOTGHLy5tyDGK8k7D6VOeI
         0aVKXAzc37wfr4g0i5YVdpXfgC4utRg4uEly4VpG4IEsaKx8evF+7OhDS6QYr71rXKm6
         q/8Ffx2aJ0TcbAzisR7wKnGMORb6ZCuqKsJHpMfd9XmHaJ5gpWkMlDX8MzgJeRghsmrg
         jTbig+QgvwaZkIJ5HOmHOJAFlhr3FAo0t1kvQxfDMh22qaUaFhkSx6PkkHOeRHUaw6/4
         +QbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739194299; x=1739799099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBYzKh666wM3wi72dCVNRA5e881/bj/k98p0ZebqkRo=;
        b=w4ub2AeJBNZnw/8QotXwRgG4/5e8wk62LSVwOveL4d3HY+LM14bFu5JFI1kGu0vCxI
         Qb9if1rOj8CSl53wDIXXg1SUbRDzAkSZGxOYXlgXmKzETcHSJaruTxmJbaViE8W/cUij
         /RpyRcKkUDUMXlo7Bm8fzy6LD5pJWolxjwX622NjtukVwI+ajw64HSwDuw8V8VWgIdUl
         u/D83g+Bqz7lTI4MTbuDLSULkZCzqkjc9C9uvqAEBGda/WF0gVf2KdFlyfSDbonhudY2
         LdUiOjH+V2jvJxuaU0xp9xghgQOINCTvMRkhAgPSVJlSqZOUpj4u26BceM/hNc85nKxX
         +M+w==
X-Forwarded-Encrypted: i=1; AJvYcCVmVH1RyY87ntYC5oV3O2OBLDFJ9BOOY0IEOTfJ0jtAFk8UEjCs2R/DQ3wg7UXuegkNbd/GHLk=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzy8wXNfZ5oIBFz+fCEFRksHwkHrVIuRNn5GSUl3bKQ6x42w0Jh
	oVOIOYVX+wGpdHILvt86/sUkl8MGShFmmMMLQA2aX/AK803NbWd6
X-Gm-Gg: ASbGncuffPhgZkg2wqRIDN4hVEg68fSAXyH0cUsaEuhqF96Rsl7mTorSMJmg74L3L+Z
	JdoyNZcBgkFv4PUcRv7zyN5icQKX+C3n3IVTuGW6ruhmY372VfhRcD1H3f+lQfN5+/1OrywsBlA
	EEUIdHkefyx93luZ8mdjLB657iDaIJbgPsrOYFW4LiDFnqY9jgE54z4sX8XG8L86EZHI3pYyEld
	bxh5khOSg/+8g+krqlRoJU42uTvde69NMXkzmRnSiJunkY9ZtSRVqIWdj/wVu3OSaOch5H+d03V
	BfriUQ==
X-Google-Smtp-Source: AGHT+IEvqpw8e2KYvbqgEmvCDFUuCXdsu3E3xccl+ty2yNtqbZtpph7stG1AFKdWtDXwqVY0rqWqig==
X-Received: by 2002:a17:902:ce06:b0:20c:6399:d637 with SMTP id d9443c01a7336-21f4e78de85mr276877915ad.40.1739194299072;
        Mon, 10 Feb 2025 05:31:39 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653af3bsm78799445ad.57.2025.02.10.05.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 05:31:38 -0800 (PST)
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
Subject: [PATCH net-next v9 09/11] rtnetlink: Create link directly in target net namespace
Date: Mon, 10 Feb 2025 21:30:00 +0800
Message-ID: <20250210133002.883422-10-shaw.leon@gmail.com>
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

Make rtnl_newlink_create() create device in target namespace directly.
Avoid extra netns change when link netns is provided.

Device drivers has been converted to be aware of link netns, that is not
assuming device netns is and link netns is the same when ops->newlink()
is called.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/core/rtnetlink.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index e9af0775fa6b..a11b2c1f0985 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3788,8 +3788,8 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 		name_assign_type = NET_NAME_ENUM;
 	}
 
-	dev = rtnl_create_link(link_net ? : tgt_net, ifname,
-			       name_assign_type, ops, tb, extack);
+	dev = rtnl_create_link(tgt_net, ifname, name_assign_type, ops, tb,
+			       extack);
 	if (IS_ERR(dev)) {
 		err = PTR_ERR(dev);
 		goto out;
@@ -3809,11 +3809,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	err = rtnl_configure_link(dev, ifm, portid, nlh);
 	if (err < 0)
 		goto out_unregister;
-	if (link_net) {
-		err = dev_change_net_namespace(dev, tgt_net, ifname);
-		if (err < 0)
-			goto out_unregister;
-	}
 	if (tb[IFLA_MASTER]) {
 		err = do_set_master(dev, nla_get_u32(tb[IFLA_MASTER]), extack);
 		if (err)
-- 
2.48.1

