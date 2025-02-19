Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCC91E0DCD
	for <bridge@lists.linux.dev>; Wed, 19 Feb 2025 12:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969492; cv=none; b=mOi+rWeH5I6T5MFk1seoW5jia+Dc4Mw/wbwvWKbz5NRw+8+26m08DpGzwMcedj9hSh0RymAQw7xYd8o1UrLTX9zsMyI50LzwnBncGLNmuyr9MpVjNmfmLudcLNoic03jEx7FyuX7AiHcwpZhWNa57NrjaHaMzyp5/B1vEhTv2H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969492; c=relaxed/simple;
	bh=wPBh+lm62MwNx5uxT7ebUmt4/Z+4/EESOV0PaYKRJhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HKc+bxFZhFXdhc6X5rg/SlbQo8t+GdmQbZ2nMCekaP4tm+o1+jEHJOr6AJI4vWKAzD4YD/2Ppdr7UZmkQt6DTxarxp4vjtqJC4Zelbi+4mgN4JrgnHZbQJkK9XxD9nzV/bl3ebM52ce0du2n4D4VVuAwFU8WjeyJ7KpM/3mGtmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntntIzgK; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntntIzgK"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220ecbdb4c2so2357905ad.3
        for <bridge@lists.linux.dev>; Wed, 19 Feb 2025 04:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969490; x=1740574290; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=so6ixpN3+kGL2R8Euj1cLc9vRqq6Wkcgz/xNsuJc6Sk=;
        b=ntntIzgKAE7UfcC00P4rvRxCNHuFwK7voGsyD+qMYhMpQ7NS+RejIxYZSWa62Bs3cs
         oNEHmpFTA3NxRgmOrX7UhsF0ugRWu3kVU1FHsGmhTJ9ABJD4D5lXMpEHB79MqucV2GYH
         I7WaqJLooYIcPJNydh6IePbOhadagb5xCM3n1B/PKRsW91RYIGSBz1c+EW/IUbP0OS0i
         srS/b1Bs4moVmMxVpsjEh55GesrnRWXEjj7CEWE9yTE9Fz2aUsYprCbWOUp0N6PQpYfn
         cAWvScZbI+YK5wacKIKGsfLvAzubajKdxHSzCCxlFE3l2ZyrgBcVhitbXfd0fLZ6E99d
         ztGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969490; x=1740574290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=so6ixpN3+kGL2R8Euj1cLc9vRqq6Wkcgz/xNsuJc6Sk=;
        b=lbUhj/AkB+zrACWJ1HSnNPZAYLHAIODxh7iydTngdY8qe92wV5oGe5IJfoGjCRDC+S
         sx/fMMsJJ8XzB1fAKQdvRaTB3yEfeD3Hc9wTomeTj1HeNP/DS1C1viN8brGD6mCdf1AC
         ql2TygSQ4Y5n/Dn4v7ggqMUO09+EWSH61WZ23HYpuD7ZBcHNnswa50z1ZBotc57NGVfH
         88pWPPFzuOMoSVAccOC3aPqnU4tR3hsj08t2L4TTpNz2HDFwZ1PI5o9mWJIMND8le1zA
         jRaVGc21NHJ/mkq77VLGmsz1taZYyPnDJ66dEMtWitsenaUuZRgP49ZWurwc/mQf976Y
         lBAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG2KgVWLHZKm/ca1sOvXFNhEv1/n7haR3d1UX4QXAAxNv7L+uYAU/z84FWeEozBHjQck4gBcY=@lists.linux.dev
X-Gm-Message-State: AOJu0YzTQHvFVX1giLAbO8LDsTuwN3maYmH27snInCZRQFnOAV9Ppy14
	NKDaXx3QJuPI31MVa3RrBiB3Y6cI0u26MlsJhD/WcCxOcbDizI3l
X-Gm-Gg: ASbGncuwSZPkUug4J3mUkI5j7McrMrkQlYcj/c7d91jVt6HZD0PqcwyFQGdtHQQ+uGQ
	u4MRDMHoSzrAvEFrsZDo/8AgOBmFbjF5tNKEtrh1zd4V5+9ZOD+kqR2CZQAqejqxL1wp3tUhL4X
	xXNIXZftHkkQ3I8TwOjDFpyM4E3eykC6ArmRM14VLO51wfqEmTMpMkaqn7R1d2hWp/ewmWeFRWa
	FLuQAHgfDLbyrgPLiY3KhTVPwJRYkjI0Y3qMPNjeDzfDre/1UCtXIcbjsP7tEI/dGpMUfM2QmC8
	AW/SnQ==
X-Google-Smtp-Source: AGHT+IEqkCyGg/QTxep/fqv5CqcRvswNVHWV96b7TSvHtcfDnyWeYpeOAf5Az1bAxRJk7mW/W72uWQ==
X-Received: by 2002:a17:902:ce0d:b0:215:a179:14ca with SMTP id d9443c01a7336-22103ef5861mr278510175ad.2.1739969490317;
        Wed, 19 Feb 2025 04:51:30 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536436fsm103427175ad.64.2025.02.19.04.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:51:29 -0800 (PST)
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
Subject: [PATCH net-next v10 04/13] ieee802154: 6lowpan: Validate link netns in newlink() of rtnl_link_ops
Date: Wed, 19 Feb 2025 20:50:30 +0800
Message-ID: <20250219125039.18024-5-shaw.leon@gmail.com>
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

Device denoted by IFLA_LINK is in link_net (IFLA_LINK_NETNSID) or
source netns by design, but 6lowpan uses dev_net.

Note dev->netns_local is set to true and currently link_net is
implemented via a netns change. These together effectively reject
IFLA_LINK_NETNSID.

This patch adds a validation to ensure link_net is either NULL or
identical to dev_net. Thus it would be fine to continue using dev_net
when rtnetlink core begins to create devices directly in target netns.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
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

