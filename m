Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8782F5332
	for <bridge@lists.linux.dev>; Wed,  5 Nov 2025 11:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762341614; cv=none; b=dTRMdNsTpZNWMRfOpWtfs6BYlo8WU3FUb4e2fTTN/EnCcoiLHGp6b68nYSK7hr0jgRYhrr8hXepmwZ9t9J2PlD80XdSaCOuRP8WyStMqIui4clgi5eq0lkieB0vrkUUakBhwxi569WbLw8J4s1Y7zdOPMJEpDr8gxwRbEZEDlW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762341614; c=relaxed/simple;
	bh=2ZqPgpPiPHrS92JfBz+aBJWUDxgtCMKCK+HjZxs5CD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tj/J5eQX2LJnpH/MrZz9conl7tI26N+qy9it7pWM8vMwDObXKOKh/Yn+38w1mQg6cft0XSC2wxAIqPoshVNbd+JcdWEwYBWgCMwsNM8tZThT9raUrZcl2o6jPp2IiqTk8kQy+N00YWNpk1mLvDJ2V46gXsT4EmCqZk5GKy+a/vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=X95qoW77; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="X95qoW77"
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b7200568b13so399104966b.1
        for <bridge@lists.linux.dev>; Wed, 05 Nov 2025 03:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1762341611; x=1762946411; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMKJnQ1D1xmyer3aTvAUN3eT/mrH4zICFOPCjbHYI/I=;
        b=X95qoW77HDTxEKRPehO4LCd4I+8PYONSA5eFXQD2VUBY2xXJMc8cIH+Aj+Pi8oWD9P
         u2N5KAuBeN5AG5UrVwebH5oP97iNCXJPYaBmxVzGfF5ED/ztVfYjpd80hLiJaaqJLV3F
         j0w1waCLGN7Q5qsK53nkdi2Hrl6A2vyg+5YPRzx9Q1Y1gBB6dlG8DC9D/qFSSbXrxVwi
         7qiywLC73hEpdBCr7aLmQleOXoVoHJFejHts2fSzlCu6Sk4a4OfH6+NzXajca/IhBe99
         7uR4Er4nqCAdoim3u8Ip0YXneZBS2+Ui6LAFjIwtChEorP5ZmaE8U4kIQI02nTPdbFUa
         HuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762341611; x=1762946411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wMKJnQ1D1xmyer3aTvAUN3eT/mrH4zICFOPCjbHYI/I=;
        b=qcsswZ8vUODGAkLPIhHZsXLXzniB8j9O3AciZeHPc1Syd5DR71LAcyF5pN5Qsj3SFJ
         EvUo9RXJ3DlbC4l+qZFnEScSWUxUG9JdmoFgRX+ttXdc/OVTAwv3M/3Hi4Gml4ApSLpd
         x6BBLxZwkZt7WP7ahniQJ9E9juM6oHLC9b6FkRuZGqZcSaxLqg5EwKvcFrYQAy6TcsPq
         AymOuW2j4/FC4UyWizG0LLbNTy+r7+A4znY7r4jjMi2BBn0yd/YIP1TNfMe1toUnifp6
         TRtoGNPPQFKrte5s1h36k5CrE0GwlGGvYcjuJwbYUWo7k90hqn19UkRhBFnYipRFfJ0K
         C3Wg==
X-Forwarded-Encrypted: i=1; AJvYcCVqrk9I7dUr3sg8lNk53uThpsa9VxRGtrRLm94UYTAZVhHefhUEUkoNHr5K9UfPWFJ8Z3kEZPw=@lists.linux.dev
X-Gm-Message-State: AOJu0YxSYUjrZ3elSoTZUmTNUbgQn4nJGNexGC1h07kGzRx9g6vqD0BX
	82RGfSrv9ptWXyPH0Ovg/HTg98ik+8gdgcu24au35EKdQlGwCaJ54ijF5JpCbl3HVzU=
X-Gm-Gg: ASbGnctChP0ShgBatbIxlQBIMb/GktA78cFB+BUu7i83bvvHCOE04KwYjxLBneZ4fod
	jtdgIWnoooh1nYVDYmVDECMcoS3syNYc06Y3t2r1rFDTYKX1ob3f2t3ibrCjbRQLvE9JfRrxrJ0
	h19N/WsPl1rBq95Rs408IF6UIU/WK8NJJS9yRcQFtLchi4hrh5/s3OzOHMcnWy1AbglWS7S/VAW
	5UfT0+BNmtBBGdc2k343xu3/e1lcUJzWDcgo9YfeAsJa6KaoB7nGsV8fN+yiQUX3tFVZkzIEa9/
	k2zXZ4AWYoVDaESTjYvTUR4VYuTYlO3AS2KVMBVLy5pIjVW6fS6G9CUz1NFUXm3a8IzgCoT9XAo
	nYMvq2lNPLGRjOpn/jIh9iF31OqRPf5zybggXs7bDhZluc0F1bekWHmTeTzNP1A5ioOY0w5emWE
	2zoB2ZZD9JN0dXaAeOrsQC2K+rY3cwrnFIwg==
X-Google-Smtp-Source: AGHT+IHx03FuYXvELFzKpMaKbaxgNjC/IRcF4XcMpAXdnaRWceclyZ7+QT+bIuyV4EfsXKnTVW3QCA==
X-Received: by 2002:a17:907:26c8:b0:b71:75bd:cf51 with SMTP id a640c23a62f3a-b7265587b30mr239001766b.38.1762341610641;
        Wed, 05 Nov 2025 03:20:10 -0800 (PST)
Received: from debil.nvidia.com (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b724064d25csm455208266b.72.2025.11.05.03.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 03:20:10 -0800 (PST)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: tobias@waldekranz.com,
	idosch@nvidia.com,
	kuba@kernel.org,
	davem@davemloft.net,
	bridge@lists.linux.dev,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	petrm@nvidia.com,
	Nikolay Aleksandrov <razor@blackwall.org>,
	syzbot+dd280197f0f7ab3917be@syzkaller.appspotmail.com
Subject: [PATCH net v2 1/2] net: bridge: fix use-after-free due to MST port state bypass
Date: Wed,  5 Nov 2025 13:19:18 +0200
Message-ID: <20251105111919.1499702-2-razor@blackwall.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105111919.1499702-1-razor@blackwall.org>
References: <20251105111919.1499702-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported[1] a use-after-free when deleting an expired fdb. It is
due to a race condition between learning still happening and a port being
deleted, after all its fdbs have been flushed. The port's state has been
toggled to disabled so no learning should happen at that time, but if we
have MST enabled, it will bypass the port's state, that together with VLAN
filtering disabled can lead to fdb learning at a time when it shouldn't
happen while the port is being deleted. VLAN filtering must be disabled
because we flush the port VLANs when it's being deleted which will stop
learning. This fix adds a check for the port's vlan group which is
initialized to NULL when the port is getting deleted, that avoids the port
state bypass. When MST is enabled there would be a minimal new overhead
in the fast-path because the port's vlan group pointer is cache-hot.

[1] https://syzkaller.appspot.com/bug?extid=dd280197f0f7ab3917be

Fixes: ec7328b59176 ("net: bridge: mst: Multiple Spanning Tree (MST) mode")
Reported-by: syzbot+dd280197f0f7ab3917be@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/69088ffa.050a0220.29fc44.003d.GAE@google.com/
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
v2: new fix approach using port's vlan group check when MST is enabled
    we rely on the fact that the vlan group gets initialized to NULL
    when the port is getting deleted

 net/bridge/br_forward.c | 2 +-
 net/bridge/br_input.c   | 4 ++--
 net/bridge/br_private.h | 8 +++++---
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 870bdf2e082c..dea09096ad0f 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -25,7 +25,7 @@ static inline int should_deliver(const struct net_bridge_port *p,
 
 	vg = nbp_vlan_group_rcu(p);
 	return ((p->flags & BR_HAIRPIN_MODE) || skb->dev != p->dev) &&
-		(br_mst_is_enabled(p->br) || p->state == BR_STATE_FORWARDING) &&
+		(br_mst_is_enabled(p) || p->state == BR_STATE_FORWARDING) &&
 		br_allowed_egress(vg, skb) && nbp_switchdev_allowed_egress(p, skb) &&
 		!br_skb_isolated(p, skb);
 }
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 67b4c905e49a..777fa869c1a1 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -94,7 +94,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 
 	br = p->br;
 
-	if (br_mst_is_enabled(br)) {
+	if (br_mst_is_enabled(p)) {
 		state = BR_STATE_FORWARDING;
 	} else {
 		if (p->state == BR_STATE_DISABLED) {
@@ -429,7 +429,7 @@ static rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
 		return RX_HANDLER_PASS;
 
 forward:
-	if (br_mst_is_enabled(p->br))
+	if (br_mst_is_enabled(p))
 		goto defer_stp_filtering;
 
 	switch (p->state) {
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 16be5d250402..b571d6f61389 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1935,10 +1935,12 @@ static inline bool br_vlan_state_allowed(u8 state, bool learn_allow)
 /* br_mst.c */
 #ifdef CONFIG_BRIDGE_VLAN_FILTERING
 DECLARE_STATIC_KEY_FALSE(br_mst_used);
-static inline bool br_mst_is_enabled(struct net_bridge *br)
+static inline bool br_mst_is_enabled(const struct net_bridge_port *p)
 {
+	/* check the port's vlan group to avoid racing with port deletion */
 	return static_branch_unlikely(&br_mst_used) &&
-		br_opt_get(br, BROPT_MST_ENABLED);
+	       br_opt_get(p->br, BROPT_MST_ENABLED) &&
+	       rcu_access_pointer(p->vlgrp);
 }
 
 int br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state,
@@ -1953,7 +1955,7 @@ int br_mst_fill_info(struct sk_buff *skb,
 int br_mst_process(struct net_bridge_port *p, const struct nlattr *mst_attr,
 		   struct netlink_ext_ack *extack);
 #else
-static inline bool br_mst_is_enabled(struct net_bridge *br)
+static inline bool br_mst_is_enabled(const struct net_bridge_port *p)
 {
 	return false;
 }
-- 
2.51.0

