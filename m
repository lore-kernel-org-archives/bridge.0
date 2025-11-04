Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12282E5B1B
	for <bridge@lists.linux.dev>; Tue,  4 Nov 2025 12:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762257803; cv=none; b=Xqy1AOieUdmoEf6OnSe5s7mbsKfzmIw/PjZP9KpK3GG8Yn9MYRoB8iKaioVQKx2eHKAKqJ/ZBhcePXrDCjlyd8/xIzqajIch3Jsq9F7pYhYLSkVdtfx9J58nxEZrzxDYNE8wRS212H9cOBOH+0gc/IpQMEjaW9QNghwCR5uVd9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762257803; c=relaxed/simple;
	bh=uxs/iZONtkysdoEYh0TYj6L15sDcCF+xti3WB6jljeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szLuJQlYyGN7+U4TaEFklveB2FUOjbVTlrJhRzMmXFq4gLvzMkO2s4lydawHxPEAtr5+AM2hBDm4SdhdrhkcUKk+FBOiqrvCPlDnUg5mT5zNG8koWs3VGPbTUxivMv5B/KTLyobPe/ocDk2j7JJoS76YC7cvbge+y8X+oC9HqRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=msr/5vLM; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="msr/5vLM"
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-b5b823b4f3dso876342066b.3
        for <bridge@lists.linux.dev>; Tue, 04 Nov 2025 04:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1762257800; x=1762862600; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cq+bG+eJXl71qSp6ixRRiwG9h8t8D2Um16KyxjJF7o=;
        b=msr/5vLMNmsKVSJPsEGOAGdumvJy+OgNn59hTp6JwIJMba0j+iDXKyXw2lLnnEa4dt
         4SqlengGfOFNmYZChruxcTLk0fhqgBHjBSIyQbCqL3syVqyq5LWwGMUsPxwezHTOrwDG
         fB3TbGRMPHI/CZ/phC68XKOJHuxsmRtyN/lyboeO35GvMbCNaEHqEci2C+mPwxwYIYP7
         D3vN5um777zekPwstul/FF3x1XtQzLdYsiNG0LbOgMiwyEWBnTDCnjmqi6QPRRioMg8d
         C5jvIbMkBXdAcx6E3f6o1W7srWG2ikiy3zSPfZXvuPTAVzRAy39Vk+pfE8qzTOTS2HHD
         usPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762257800; x=1762862600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6cq+bG+eJXl71qSp6ixRRiwG9h8t8D2Um16KyxjJF7o=;
        b=NBkA2x9qE7aXAxnl2H4YIy9mG0i08SDpheUMsRYIm4mu+aykJeruSOydh4fe/d/Vhp
         +ljAjzSAng6L8cVbGT0Z9mTYN6sllRuwYnYYv7E6mWSUlgxjcTgnLgwXi1J39ty++CdN
         9MtkHw6XwXpGzaOKXQni9bGboyz2VAcaOYggCZWeJmy9DMlnRHmPHuBAyFhHBIArlzpU
         ABGiY2OZwjTKFpsC55m5kT+W7+solFAi2SsaQkSJTdu/VbTBGtfX6AOEKPgVi1oYaOBU
         86jCwiEaLL94JlVmjH0hRnhYMUz0vTTFeK8VSkkAArqg/5+jrNJ36sUYI+y/NBLsbl3L
         kSTw==
X-Forwarded-Encrypted: i=1; AJvYcCU/62XtWxDxcyf8tPOW4PEf34RtAF/rXCf89q0feAd4WS/sJzUEOexTVmHgRcyxwKU3CegUtMc=@lists.linux.dev
X-Gm-Message-State: AOJu0YzKN7akiqTgd/llgKsLIl2fTaYtxcJNsImImb+ZwQJRXFYNXPmp
	slQ517qMZ1ki1m8cl50dmEA5oAF3/YhLCJIlR1tp9SlHiNqf4GwZr8ebjj94e0kTF8E=
X-Gm-Gg: ASbGncv+QmrjX5Ssa10K35uHI/y5Xnm0Y0LeEBwzrPmFprqnCnTwi85sjf6BuyLeErb
	6CHz2RhcVkNNuoEwKK3peZO2GbDMtEFFlbHKyYNzUBHKXlp9ux6B/3JjE8MYp0tLlxMnmxwnotK
	QCyE2/U7wWrHC5JWbQ6wwoJket6MSVi690P29InqFEsmU3AWII1La73sw/jdNdKJJ+1qHEAYRmv
	jh2IdVjMv4weF5QVlHfvcfM9mIn8GTLMFAVufTFziOvtbytW143xQdEwHljGK4p043ijvzkG71X
	iVhzHAoB+alJCwt8GvqL5dADrr0ZK2aEXKUWpSVNz/trQgsNXzBK+A+Y8eXJqccV2dREZMRk40L
	WE5qtlXzh3QAnBe7ohDitPWAvC+Fg1jZnpga82EXfcwAwxATMJJ8g+hKUFR8oCjuDrVWo1YQ6ZR
	cN6zz/Ry8PdCKqWwFOHtaiWvIJwcLjR6jSddTC+pJyeJo0
X-Google-Smtp-Source: AGHT+IF4FIF4AXqOpmhsabGe02+8vfJF5OMMRMawtSVwJVY40Y2Ec3KnR/1nPf5j50ocsAT1zWg3RA==
X-Received: by 2002:a17:907:3e16:b0:b6d:8557:19a with SMTP id a640c23a62f3a-b70704c3e8amr1873656066b.30.1762257799462;
        Tue, 04 Nov 2025 04:03:19 -0800 (PST)
Received: from debil.nvidia.com (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d3a3082sm195032166b.11.2025.11.04.04.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 04:03:18 -0800 (PST)
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
	Nikolay Aleksandrov <razor@blackwall.org>,
	syzbot+dd280197f0f7ab3917be@syzkaller.appspotmail.com
Subject: [PATCH net 1/2] net: bridge: fix use-after-free due to MST port state bypass
Date: Tue,  4 Nov 2025 14:03:12 +0200
Message-ID: <20251104120313.1306566-2-razor@blackwall.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104120313.1306566-1-razor@blackwall.org>
References: <20251104120313.1306566-1-razor@blackwall.org>
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
learning. This fix avoids adding more checks in the fast-path and instead
toggles the MST static branch when changing VLAN filtering which
effectively disables MST when VLAN filtering gets disabled, and re-enables
it when VLAN filtering is enabled && MST is enabled as well.

[1] https://syzkaller.appspot.com/bug?extid=dd280197f0f7ab3917be

Fixes: ec7328b59176 ("net: bridge: mst: Multiple Spanning Tree (MST) mode")
Reported-by: syzbot+dd280197f0f7ab3917be@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/69088ffa.050a0220.29fc44.003d.GAE@google.com/
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
Initially I did look into moving the rx handler
registration/unregistration but that is much more difficult and
error-prone. This solution seems like the cleanest approach that doesn't
affect the fast-path.

 net/bridge/br_mst.c     | 18 +++++++++++++-----
 net/bridge/br_private.h |  5 +++++
 net/bridge/br_vlan.c    |  1 +
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index 3f24b4ee49c2..4abf8551290f 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -194,6 +194,18 @@ void br_mst_vlan_init_state(struct net_bridge_vlan *v)
 		v->state = v->port->state;
 }
 
+void br_mst_static_branch_toggle(struct net_bridge *br)
+{
+	/* enable the branch only if both VLAN filtering and MST are enabled
+	 * otherwise port state bypass can lead to learning race conditions
+	 */
+	if (br_opt_get(br, BROPT_VLAN_ENABLED) &&
+	    br_opt_get(br, BROPT_MST_ENABLED))
+		static_branch_enable(&br_mst_used);
+	else
+		static_branch_disable(&br_mst_used);
+}
+
 int br_mst_set_enabled(struct net_bridge *br, bool on,
 		       struct netlink_ext_ack *extack)
 {
@@ -224,11 +236,7 @@ int br_mst_set_enabled(struct net_bridge *br, bool on,
 	if (err && err != -EOPNOTSUPP)
 		return err;
 
-	if (on)
-		static_branch_enable(&br_mst_used);
-	else
-		static_branch_disable(&br_mst_used);
-
+	br_mst_static_branch_toggle(br);
 	br_opt_toggle(br, BROPT_MST_ENABLED, on);
 	return 0;
 }
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 16be5d250402..052bea4b3c06 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1952,6 +1952,7 @@ int br_mst_fill_info(struct sk_buff *skb,
 		     const struct net_bridge_vlan_group *vg);
 int br_mst_process(struct net_bridge_port *p, const struct nlattr *mst_attr,
 		   struct netlink_ext_ack *extack);
+void br_mst_static_branch_toggle(struct net_bridge *br);
 #else
 static inline bool br_mst_is_enabled(struct net_bridge *br)
 {
@@ -1987,6 +1988,10 @@ static inline int br_mst_process(struct net_bridge_port *p,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline void br_mst_static_branch_toggle(struct net_bridge *br)
+{
+}
 #endif
 
 struct nf_br_ops {
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index ce72b837ff8e..636d11f932eb 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -911,6 +911,7 @@ int br_vlan_filter_toggle(struct net_bridge *br, unsigned long val,
 	br_manage_promisc(br);
 	recalculate_group_addr(br);
 	br_recalculate_fwd_mask(br);
+	br_mst_static_branch_toggle(br);
 	if (!val && br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED)) {
 		br_info(br, "vlan filtering disabled, automatically disabling multicast vlan snooping\n");
 		br_multicast_toggle_vlan_snooping(br, false, NULL);
-- 
2.51.0

