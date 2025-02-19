Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBF21EA7FB
	for <bridge@lists.linux.dev>; Wed, 19 Feb 2025 12:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969555; cv=none; b=C6BmtzbllbhvJCly3SPqmN/DXiRPxtJcmGChuIVSNehOWdUqJPKXhMkgPlOr769iHCv/fCWk9TiA5BaxI0Nc09aSyT5RrCchmVCWK9CbQLt/p1FdqrFpOyeedN/Gj5IVucw4XOXiwQqMZaQqvH+R1R1oVC48/fxVgoMqV2sPuT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969555; c=relaxed/simple;
	bh=Ued/MDbt2p6tJKKcyAlb084zWv9B8seAzSAzEKvzX0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XTiZegVlkAgFnInFOpBZ487ojzORxiUMdk34eiGiAV/JXVZhppC+kyrfQjLVmImspGAcYKJno9sm9HbW/cRGuPbgmYfMPcipeRW4OuhsEdqCWgOAWujQMovVhl4ysZLQXGad1w83nPOY/esaUE8EY4ZjnfxtbuLudre0cNUlGfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyJvIROr; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyJvIROr"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220d398bea9so93019895ad.3
        for <bridge@lists.linux.dev>; Wed, 19 Feb 2025 04:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969553; x=1740574353; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14Wr2OB3TipJqOg2i3ltQmzAxlBlaCt+7msGZ+i4teQ=;
        b=AyJvIROrEfn1cMO3f+MjnX97/TRFj8kUBt88+JJOzLXiHznyUox7CTrgLM/LVmI42c
         VsbP1H3OoQHtWqYtRycSyLovzyrMmN5QeJSQCJGbs+i6f1uEprFLshtZKMOdolJHJ1r6
         XaaM2wUzg6cXcI2C7J7VXcZ7nJMbX8Ts81/qp0xuq7nVz5xti6uVheLS4I/gQmMHHil5
         5oGmuiw5A/AV3aagAof6uVNL46Lh5+uE6HmhQymzcDdEl9wkYLOMAt6m4FYwTy1yXboo
         SiSx8K4/wX0XgaGpWykUfImO4wF3A2PJEF7d4A6cNynsBGOWcVmhO4CeqkO65YTR8m9d
         ldZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969553; x=1740574353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14Wr2OB3TipJqOg2i3ltQmzAxlBlaCt+7msGZ+i4teQ=;
        b=YbL0iP1f2bykAcInZHzOR5hHcZ7yBUtIEksH461m1bEDE62paynf11q7PW0dE6iIZB
         1bVmubUICoDPJeg7uf0LkWTxko1jUjJOWWS/1W4VzxHPnylwaPBYAnivdpBf947my+BA
         mBVtd6v8gQZJa5Zi7jBXE+Shn6xLLSCvM+0ivbgvitLCaVhTmHKC+T2CrweoBSea+5tq
         T+vjKoMx3rwdBfBAxXrj3hKVxVDTiUAoZAcQRsLJb5Tl86yFSpd62tr4b2SJ4rQH0l2T
         Ylq7yacnblC144ZqLS0G+pic3Il3shxUF0sXgrGWiVMKwrtu0TJiuOWgPVke6ClzOncR
         xsMA==
X-Forwarded-Encrypted: i=1; AJvYcCW73bA0AWEoBKkBOpuxW/qCowIZ4zuDTwrs+LMBKRZHqkw2UBt4CxiuKK0YxlWo/ALsjWT9boo=@lists.linux.dev
X-Gm-Message-State: AOJu0YwuspJR4EVCkNmO1HZa7X1ctCnYrWoa3b7VV0rG0aTBeF+n3yFu
	v9xrVZBLXFX1O4GlZE3siRKpas8nsY1aeWDrMsM0u54bx99yqydf
X-Gm-Gg: ASbGncti/mrFjdMrk8UYb+9UQ7zdxBPgvTZOZvo3cuoK3jKRlVvCanp+VIMwprpvP2L
	Tlbn1mT2y21FAL4CYwU8cxTN3BsMMrdaRWPe76SWfZ8qyGVM6pQ43N6WUwB5DOvcMB9Vx/2O52m
	v2U2lFRnf+/xgxvkYvSo9NDeF6aY3Xq6u61CjH1Ptd2YdFjLWsrUum3ytEUgxXbTKoWTs696eU+
	gbnGL2N+5PhOTKZx4K3/KN+7RGOBAHmzWrFpq5tYZr/1qTmW1UnbodwQrSt7zM8BfK9mSgJzgEC
	Apr2WQ==
X-Google-Smtp-Source: AGHT+IE1TMZXqzhrHhhVSaIMtrPumBVmrpPdtKnId51KbxVQ9NXXxJP9rSJ1kBfk/uhAUxck4sNSxA==
X-Received: by 2002:a17:903:1a2d:b0:220:c813:dfd1 with SMTP id d9443c01a7336-221040bd77bmr298031085ad.36.1739969552787;
        Wed, 19 Feb 2025 04:52:32 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536436fsm103427175ad.64.2025.02.19.04.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:52:32 -0800 (PST)
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
Subject: [PATCH net-next v10 11/13] rtnetlink: Create link directly in target net namespace
Date: Wed, 19 Feb 2025 20:50:37 +0800
Message-ID: <20250219125039.18024-12-shaw.leon@gmail.com>
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
index e980481bdd28..b52e610e157e 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3789,8 +3789,8 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 		name_assign_type = NET_NAME_ENUM;
 	}
 
-	dev = rtnl_create_link(link_net ? : tgt_net, ifname,
-			       name_assign_type, ops, tb, extack);
+	dev = rtnl_create_link(tgt_net, ifname, name_assign_type, ops, tb,
+			       extack);
 	if (IS_ERR(dev)) {
 		err = PTR_ERR(dev);
 		goto out;
@@ -3810,11 +3810,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
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

