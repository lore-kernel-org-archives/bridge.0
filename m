Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144651B4239
	for <bridge@lists.linux.dev>; Wed, 18 Dec 2024 13:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734527440; cv=none; b=mOypQ0DDGNU1AuuBI1dQ2ColAgrmZfeF2uWUXHLxtlaAEHS9+rvQoekSNoiAUFsEjKA0nosWfB2aWux15n9cUPyLIPpsyczq9AaMzT+K+PrKvw2sL+cYxVEBj99Alqv6NoUO67P5YNpHR9TYX+V5fqciLUqMdlzKiu7XnxVU6m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734527440; c=relaxed/simple;
	bh=v/XyDBj1rv0kMGLFRo/fVc4C1+xJWpbKQllsecdMufM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iNZKSxshn4RlXp7JvP9BML4k8icLgzBmzbjcY5Zc/4V4xKbcycSKQEJgkZqsmHDpffjvMHcMsM7USDXPMkIg7xOyhorqmFpiK/s9bHIrASbImSnZn1+ece5c9WpcgbvoE5t6u/3KG2jLq+JHpfwriYSwnvio/QRDFvtKGkOCark=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GT/5F7xT; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GT/5F7xT"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2efded08c79so4486265a91.0
        for <bridge@lists.linux.dev>; Wed, 18 Dec 2024 05:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734527438; x=1735132238; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEdGbFyA09FJ7+QqmmCxpz6A7u+HUg5+S5fgAXCQeJc=;
        b=GT/5F7xT+iBlq8m+YwcYJhWu+DPiHUBHQrtyTZYUemm+9hMaHusfgJI6DEs5F5rZNG
         UEjO5NOC7G/57J5OV0rs7nnMcdTbYMBL8EAKQ+NGcKCaIxNJav23atb5qiuXc0j3mLhR
         IpC3ExoukMGNqAda2niQ8HR1K2YvbHUPPlvsSxi4vlSMlltIFU8R2VcvLwRhQ+LXwnU+
         csH33eyJ/1K3a6zZGSMUoJRgXh73lCftodr1PZ6T5KI7uEAwbDY+2SESCF+R2pfYe9uy
         Q8XOr237nx3Yv0dR5GnlOZCh9+UZBtFke05swCVuW7utINkPBJdt+SB8bj0Ec+2OBdlX
         R/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734527438; x=1735132238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VEdGbFyA09FJ7+QqmmCxpz6A7u+HUg5+S5fgAXCQeJc=;
        b=fx4k7y48/Y4jrLQ7+2EWqRozdgmLfEb6IMb4nUykyKSQn21T3TER6X6wJxn+3yuIA0
         v/Zcq/KzvB/uRjncbX4CeZs1/swE+HSvEc0q+ciLInzvgm+Bu+F4/ZxlH19wzF3C4nu9
         9pq9IqaBbhRrk4JzwHHQ2qYjMPcanLf/ztfLL2iZjcyOpwNLst2SH76xEklk06Sa/dDf
         SCyV4iDajKo2TxHgfViqfE5lL1BBntRz3Ud2eU1777XVnZnD4cVsthqLbiI1cr7T3zcb
         7SEof6mV1CbuEP2FXP79B4THBI5smCMoXaa7wy6iKVNy08jKgrbUFmzKsVUZBmXEHacS
         TvDA==
X-Forwarded-Encrypted: i=1; AJvYcCX2DlKVytHgVgW9vbVwzTi4UBJCFgb6RM/N6M/Afcm2x3/5nB1mKr9fgdPKWbyFDel+00rOVM4=@lists.linux.dev
X-Gm-Message-State: AOJu0YyUkseiz1YIUy0Uh18UQt/5HoaaDpvtkn1NuekzAx5DUQEfkI8G
	UPuzc+v4skWXwHPqLYnDhhg8AQJ63Jo/YcZBSPg3O6gCo1N+SKQN
X-Gm-Gg: ASbGncsbygI/l18+gPSED7kEk1JZejulCAjQUWCiTCwhzBEFH5Vxd5tnN5RpVgVJhKW
	QB+hkRVg7jxN6n+zBl5OkL9M1NkNp17cHq/kzZEe1KmUENbzNZAKzMt8cEibrM4X+NXwEjMwjQ2
	4AXPlJvCvwSXhVN6J0GE62DakxNLh47JxUVPgAMf5yLkvdFxLCgyzKEJAGz/uoZE0z+r/pXH9/F
	OXv7T062f07c8Ri4I3kptXl824oihavnOnXNCGeE5ZZ8UI=
X-Google-Smtp-Source: AGHT+IH6m2w3HOgAGhkzn76085OHsWsSUyL1uFaSoqu4LH4xby0CPd4muKbobH9sGAmWFqgh4Hldug==
X-Received: by 2002:a17:90b:53cc:b0:2ee:fd53:2b17 with SMTP id 98e67ed59e1d1-2f2e934616amr4153078a91.29.1734527438446;
        Wed, 18 Dec 2024 05:10:38 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5c0f59asm7434754a12.67.2024.12.18.05.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 05:10:37 -0800 (PST)
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
Subject: [PATCH net-next v6 09/11] rtnetlink: Create link directly in target net namespace
Date: Wed, 18 Dec 2024 21:09:07 +0800
Message-ID: <20241218130909.2173-10-shaw.leon@gmail.com>
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
index e33ef8a0a6d6..ce5bea096bac 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3776,8 +3776,8 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 		name_assign_type = NET_NAME_ENUM;
 	}
 
-	dev = rtnl_create_link(link_net ? : tgt_net, ifname,
-			       name_assign_type, ops, tb, extack);
+	dev = rtnl_create_link(tgt_net, ifname, name_assign_type, ops, tb,
+			       extack);
 	if (IS_ERR(dev)) {
 		err = PTR_ERR(dev);
 		goto out;
@@ -3798,11 +3798,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
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
2.47.1

