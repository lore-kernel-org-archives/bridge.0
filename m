Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D04722C9FA
	for <bridge@lists.linux.dev>; Mon, 13 Jan 2025 14:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779129; cv=none; b=ObbXPYkOVPw24MDVMXa0vjdS/09DxSdVSGBxBLQlDd7QEkkyBkG1QJMA34bEZAEUlw76y0xQqmzgYb5lUyODpPvwXX2SIxvOcot3g4bSEswkktqpiZ10HSwpH6f7ORr0uoB9egxdaaCYoLyij9rs6Nsz+Wd0PdkiZKP6kNavJdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779129; c=relaxed/simple;
	bh=3ZFVoGehuDwl/mWPg6mYnMbYtzRE432EuJk5jze9RMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YR5xzFB0AnW5DDqFx+hOLHX67ZjAoziTLBXVtSHS2/Sp+vF03uOQihqeUxrQHY+p3tWdTRghkbvYgPp6PTM8Qq5T1EK1alCqcBIWbC8c26ceJJbnGxzyEN/4Ybh3g1YuM2GlaMxwDrEo31R9sllu8MwqCT9+drbSn0cGrJYnnhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtaQw28H; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtaQw28H"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2156e078563so64662475ad.2
        for <bridge@lists.linux.dev>; Mon, 13 Jan 2025 06:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736779127; x=1737383927; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0itpuEZRuaRQ33kirP60JpiMAPNyz5teegcwQ5xuJQ=;
        b=FtaQw28HT1nbryaT7w1gXbWrvq1OT/+v0nl5R8wncjXj6ogE4+ZNqz1tkO/01wVQPU
         S4BEENuLDsj6oL5fwCYkV85il5EGxeWhOkjGKOrXUbMHZBkp1HQVbjdr63Mr/IQZFsR2
         Y4ccxMichogfccbzYoxLTFN3BzrZFGKqOiX2ZaQQ2iZPuaNbnAPZ7rdMi+U69Goz8atq
         vgo7BPx/6bOeHYDw4CucNIx0gqD4xz7qnJ2CB6MJpesdO3kAJXH7zIYOzBxRhWRacZ2h
         sTuDILL3UkthgQEkW8jocAJEtog/qh8T46byTx35yoFXmbW7XOdHJrkCH7ol4vp4MIc2
         /bWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736779127; x=1737383927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0itpuEZRuaRQ33kirP60JpiMAPNyz5teegcwQ5xuJQ=;
        b=OaYuaXNfUVG/STkY1LdatELFKUHN4fJoxKV/4rfcHbW9FmKC3eiFd3DbEbEqzUWKrR
         sEb57QQHU7lBBZZiimAkf+kZHvKnneD5UKgN9yGU2j1kWOkk9lW+G7xMang+ELJkFgeq
         twh4kTr+7gLZkOD4wncHoT4awx9KpiVme6vWvetB64JX0mVHl12zHAb9egbVxwGoLdN+
         DMBYTzJnXIbZvl9VDC3tDSMw7bnuSY4GG4IbIf+eEzOSbT0JBsMVIr70FCKyjWcDJ2Db
         TD7xjWXuNzvZ5vYKs+BTt7cYdq+0cYBhzDccZao8H+0vi1ecT5F1Y90+KB0y8mpVCu/P
         kvCg==
X-Forwarded-Encrypted: i=1; AJvYcCXNkSydp8HZXp0M+QpbFr979bs6zlJT3672dTZntWM0U6mMNlk3cXWQnNv2WAbj39x6DlXQjN4=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6/qLnVgfDIF7nvuouvNVc9Caaz4KwNj3syqQmD8I6yQjbih/u
	6gg5GMSaF5nOjNI9BAu8Q4G/XHhGYZFMKCB8g/MYauQ0FzRnfqG6
X-Gm-Gg: ASbGncv3DkqldZ+mgNkMgUX6J0S8A/lHXStBufmQfeFKiTUgjIQz6FF+XHgESkT1qKG
	PNdQyylVPoF0FdkAxcd5rmp6by5nw+xFwgS9+Z7vr3B10Kb8622JTTGZb+RzH9df8czun+wkm+h
	77SYuZ/PVlC/Ibt6ierCWjSsw8GOATj6wvZ8ktxS6EpSKz1WdHz+ixBFpLzLBTk8KRdwqlLFWbG
	jSIuBBUvqCbs3z5GQPkKNA9RXvrdYZOnuubdL4YqDyAZfs=
X-Google-Smtp-Source: AGHT+IF46BIJsHmY25FQQjjhe3rRKluIF8yEXaDZgFjxpJ6wghwfrMVhniqYlndXdS242mt6yFdpoQ==
X-Received: by 2002:a17:903:230d:b0:215:cbbf:8926 with SMTP id d9443c01a7336-21a83fb0da4mr356224215ad.35.1736779127243;
        Mon, 13 Jan 2025 06:38:47 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f155e00sm54328715ad.103.2025.01.13.06.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:38:46 -0800 (PST)
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
Subject: [PATCH net-next v8 08/11] rtnetlink: Remove "net" from newlink params
Date: Mon, 13 Jan 2025 22:37:16 +0800
Message-ID: <20250113143719.7948-9-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113143719.7948-1-shaw.leon@gmail.com>
References: <20250113143719.7948-1-shaw.leon@gmail.com>
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
index 7ff5e96f6ba7..cce5bcd1f257 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3767,7 +3767,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	char ifname[IFNAMSIZ];
 	int err;
 	struct rtnl_newlink_params params = {
-		.net = net,
 		.src_net = net,
 		.link_net = link_net,
 		.peer_net = peer_net,
@@ -3794,11 +3793,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 
 	dev->ifindex = ifm->ifi_index;
 
-	if (link_net)
-		params.net = link_net;
-	if (peer_net)
-		params.net = peer_net;
-
 	if (ops->newlink)
 		err = ops->newlink(dev, &params, extack);
 	else
-- 
2.47.1

