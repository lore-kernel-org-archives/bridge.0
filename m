Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D5F175A6D
	for <bridge@lists.linux.dev>; Wed, 26 Aug 2026 01:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787708567; cv=none; b=t1bERf6lKhwrkZUTeBikHpBkfPcRlGGKcuCs8rONIdTG+HtAa/MI2hVvlKFEbriuLsGL4J8YU8+Ob5AiiZaLChBBUnFerMKBQRPCPYVR+5R5cxjq+VAUDhCGtOPF7JoxZ5SxU1+ItPnDapxzLiaby9d1GsEabjWGhkdyjOwoXr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787708567; c=relaxed/simple;
	bh=xkHYSMpPHPn5UAznXrMTLNZUM0GY8dMnzzBw3PK9Ecw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kJ7DG3E1tGDI95i/Bov2PNBHgrLs8Cv60m/Ps+kaDiUXsOdiUqlzTBvNUfA/039UVqesvx+5UIfGseRF+jjTyvCly31tHWvMfS2wXyx1/ns+H0sbUJYu8Nu+yya71IjCGAmB3AI9QnDAh5LLNcCevGrvy9RxGm12sY9Jk7Lxmn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcJS7Pmi; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcJS7Pmi"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2caed617615so5163695ad.3
        for <bridge@lists.linux.dev>; Tue, 25 Aug 2026 18:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787708566; x=1788313366; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uX7w3zYS1582cLpnHIAGQCV970wUYP+EwxQlHWpL6X4=;
        b=jcJS7PmijGreoE9cHYn2Zr99NRQ+MD2zlQ3MKmOGCxXUZiRThs/TsEexdmFpQK4XY8
         ruTen70vKQAoLAhMZYzRvjYkEg2e6JpIM4pB4qmg6AtVdT2QsPSiFXgp1LVGFpwZ/m+o
         2y421dLEfxrohsfQDw2cbjKLoDOA2QnmgUEEL/RoQOY1sbiYwZQqt9teH/t9n/GyIJVy
         wAsglUKosU1O47KiUCecEMdYd20dtXULkrAbdqITK/hpXWUo/CApasudxIubfXE0VSq+
         emu9zORz7MQT0Bgluuo9P542ULQCNA4QD2HqGR4SBKojQYnl1bfmSraxcrMj8yHXK19V
         rEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787708566; x=1788313366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uX7w3zYS1582cLpnHIAGQCV970wUYP+EwxQlHWpL6X4=;
        b=NptYfQ+uQSKLl3ybL+Jxmy6WFSFwuExYFETtcZfSUDcYe2eKPcOeC5eyzpozccYN/y
         45W6OIRRH4lXT1wmi4ZAkY4eYeCLYolK5G0EvOx9Nj1aFCu9FcFN3KT9dFtxBJcbnpFq
         0OEogVbBL6Z4aKcFscukpkevifAd7EZEU/RGZi8fDWiPVaWtBWNnBFCW1qivmjX3EOoa
         RoJ+HC6hWIFQAML72azReA7nwjW3v23D8hC2x98c1svgbq7eTERxINxWUJZG7rDPz+DN
         Ej0HluNkf5ClMQKJr5DS8VlultkVyULlxwohctsXo+f7RrgEP/EmT0ejJxXdMkJFtca4
         +Ipg==
X-Forwarded-Encrypted: i=1; AHgh+RqSHGghnDh4KPTd6Fu8Uwk733DXwsD1oOc3hDAfBlmwb57Mjtqzt5dBcv4hYu6ihFmNepq242I=@lists.linux.dev
X-Gm-Message-State: AFuF++kIGjL7RaZuZ9g7gOrT8SGYKWVroQJuT/alAuGX7BTROup1jrEH
	M+Ked5AKlvvz4o8TZSbXYxmcvLxClyqvSls14ucVXHju9KVi8djx91Y8
X-Gm-Gg: AR+sD11E99cZ3YJk8Y6lBIWUQKC0M4oW+G7lggVX/G/x+/M5GPMj+vv0nFHslFWcYxi
	LXLpn7fLkdivB7v4Gn6y3a+DUuH9FV6z9cOmn4s3ybcSaFqKoi8JP9mSTNV0cGWtSrzLJFTeswL
	jI/n6onp5hWNcWjSII7Ej/ngUVXaegUCs3gcQr62Uhlqh1o/ewlt32FQ/9qMSMI5UJGeiBvpdMK
	yR1XII6dni9l9q0qBFslmvHsL8OGTzuJci+ZXqaFYlT3gRquPVjEWfguwD/S1KfJpX3Ez5G8FB+
	CYi0UXt/Uytrm6KuvNFpq94FHrq9vavGLZD4rIOjo4yFxnAnli2EoZVVpvMQb7sGu08FrafMnpF
	xQZTp5ht8ACYSv7hPeIdwLMa4+7oh5lDyUj0LBNBYbEbJkzzmZofIm6cHDs5fQiRDW5em7a7Eex
	jVgLbUNiq7iN5v818YeWyIgfS6Z99zTK+XsL1KZqah/RJo0CXH48N16gGZhIoePg==
X-Received: by 2002:a17:903:2c03:b0:2d6:ee6b:1b08 with SMTP id d9443c01a7336-2d707a2f363mr42050785ad.3.1787708565680;
        Tue, 25 Aug 2026 18:42:45 -0700 (PDT)
Received: from TENCENT64.site ([103.7.29.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d7049aac32sm2943735ad.33.2026.08.25.18.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 18:42:45 -0700 (PDT)
From: Jun Yang <littleddfu@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	Jun Yang <junvyyang@tencent.com>
Subject: [PATCH net v2] net: bridge: mcast: don't truncate the port group walk on teardown
Date: Wed, 26 Aug 2026 09:41:44 +0800
Message-ID: <20260826014200.362304-1-littleddfu@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jun Yang <junvyyang@tencent.com>

__br_multicast_disable_port_ctx() and br_multicast_del_port() walk
port->mglist with hlist_for_each_entry_safe(). However,
br_multicast_find_del_pg() can also delete other entries from the same
list through br_multicast_fwd_src_remove() or __fwd_del_star_excl().

If such an entry is the iterator's saved next node, hlist_del_init()
clears its ->next and terminates the walk early. The reproducer triggers
this in both teardown walks, leaving port groups in the bridge mdb with
a dangling ->key.port after del_nbp() frees the port:

  BUG: KASAN: slab-use-after-free in __mdb_fill_info+0x1191/0x1320
   __mdb_fill_info+0x1191/0x1320
   br_mdb_dump+0x594/0xe40
   rtnl_mdb_dump+0x1cf/0x5d0

Use hlist_del_init_rcu() to unlink the group while preserving ->next.
br_multicast_del_pg() and the teardown walks run under
br->multicast_lock. The GC worker must acquire the same lock before
detaching the group for destruction, so the node remains alive while
the walk uses the preserved pointer.

Fixes: b08123684bd5 ("net: bridge: mcast: install S,G entries automatically based on reports")
Cc: stable@vger.kernel.org
Suggested-by: Nikolay Aleksandrov <razor@blackwall.org>
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Assisted-by: tencentos-corvus-ai:kimi-k3
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
v2: delete with hlist_del_init_rcu() to preserve ->next for an in-progress
    teardown walk, per Nikolay's suggestion, instead of restarting the walks.
    Tested on 7.2-rc7 with KASAN: the original use-after-free is no longer
    reported.

v1: https://lore.kernel.org/all/20260812113435.1854275-1-junvyyang@tencent.com/

 net/bridge/br_multicast.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 00aa9b2879d6..8022c7f12169 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -808,7 +808,11 @@ void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
 	struct hlist_node *tmp;
 
 	rcu_assign_pointer(*pp, pg->next);
-	hlist_del_init(&pg->mglist);
+	/* Keep ->next (held under multicast_lock, freed later by the GC work):
+	 * a port->mglist teardown walk may have latched this node as its next,
+	 * and deleting other groups of the same port must not truncate it.
+	 */
+	hlist_del_init_rcu(&pg->mglist);
 	br_multicast_eht_clean_sets(pg);
 	hlist_for_each_entry_safe(ent, tmp, &pg->src_list, node)
 		br_multicast_del_group_src(ent, false);
-- 
2.43.7

