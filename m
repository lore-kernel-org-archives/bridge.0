Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707F042123A
	for <bridge@lists.linux.dev>; Wed, 12 Aug 2026 11:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786534639; cv=none; b=mpdFeUscJzWyyyy7JMFJQn8pQVvDL7uYRwNxjvmqFplBU++JXE5HOAcsZFfU76A8lILx8cwY2NX4aR61GVBIZOit4g968x//RZ6z7ClOFDXm9AMtJjQ2GqRIyle14FEqivJvA4g5GDTnFMuIYUYfJBM/wHGKXF3YI6wYogPt+go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786534639; c=relaxed/simple;
	bh=CrTvb2kGHPK7+d0R14EHkHS3bKejDJlE1grVilZoGvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g3nUiOHSUWqXJ0AVSc56R5JZ+JH7XoGDd+ImmouREjE8/ouEACpuej9qmxr3f+Nywnt9ETVoVcq8b3hyxqLT6GxNLj3nX4DI5gbOH8s7nuiaXQydg/lrod3vLoivwMKBFHXqI8jIpPr//Z9WDQj2lsXPT2mjQx1RGmQsA+o4bwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pJnzfKUr; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJnzfKUr"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cc97653887so12851295ad.1
        for <bridge@lists.linux.dev>; Wed, 12 Aug 2026 04:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786534638; x=1787139438; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=awK1WKPMjKwqqW9lFazWbI/9bmuJ+2znKvkeY5ORX+M=;
        b=pJnzfKUrUEPv9gYUaZefWGIZa4P06gaDrjLAWd+0sw89JfG0Jj0CB5vpwRLLWc0E2/
         VdFg8WNekAfwZblBmiW7Vd8NXF0Bz9f/NuDvd2xOOGYX2reoIDs4R+ypMIRbDgCgKWrz
         BMvg+7rf2gpQZbR5PpJq1dBv8M+00stmQ6bS3TRJoGX7/vgzaKWv3rNTln/ePqGJhoLd
         bezpuoQDwsF+MU9H8YO5qBUiyK3y9m2eqvnrL5xR5feYqbP4xgyU1N0wkMGD80hFMfoF
         mPUSKQcZNklZC5Jy848UnDHeYoA2Dyva/n3uyG7RDpO9/53HKdzVdqS7aYvLWRtWWcds
         ORyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786534638; x=1787139438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=awK1WKPMjKwqqW9lFazWbI/9bmuJ+2znKvkeY5ORX+M=;
        b=SnS089NxGwp9y82MsbvwvGenaaJFYv4n+TFiXQCofK4aGkBP3zyj1HIG2tFSjae/a7
         zmAf8op4mxbTBxrekNi0MPi5Du5XPY4hY2M5vdQCpkRAYqzv5eMJ113k02WAjCWl8zb4
         FGA8gb1a3wBSQy6W6NKPShMXcN/kSo8ORrmZcni+wLSgy4UI7TWCXnIQTKIfh359NO1o
         JnHvUB7/bZ2FTm5Sg3N7sbJkT8z3L6SCzf6Igeqoz/IrQPgdMHS4Mhpzpa1gavNxVxVH
         e7yDXjza0NLXBhCtkF14xH2sNbMIF5AF9niGukHLFlnNvGwur7LDV+ifhu4L8RatAbdY
         Bwxg==
X-Forwarded-Encrypted: i=1; AHgh+RrN+6m5j6915NGvJkm+gPVwcfHKniIB1o6o0eJe9BQ7rFBUxvPdLUTcFssBV8Cs1yCqh9nOzpk=@lists.linux.dev
X-Gm-Message-State: AOJu0YxyRC6ujfvNDoIUjuC+zxPePYxCjGT6fSoHbsY85vbxEwIa6vuC
	HTbHXt/BTPpzEaSg+7yPKQVbbhP41cOgzGpXDH8M16iitjej/q6YxP+H
X-Gm-Gg: AR+sD13AWuEh0jcT4SWLoa3+/e9lm+urotZKKmdS/sw0pD97C9Fl3h7cc7ujhF7eDWi
	R7IO8/QwhHnPAft2X+0vCA4NQ7NcwEAnihiBDv7UkYjn2n8wTtRTz0/kTx1xdxnuUWH6T1YhYp/
	G1oS0qXeZGGLTLXW0gEONMuM8/6z1o/nWxb/FijnfOdsL8d0y/+h0S8dSW4589sn3it342U2rUQ
	Ou43kZyC2MkyYaTxE4xNGUyPzyYL1w/2uhq0xQLOZUZ9JbxxZIjPknN3+ccopvZW8Rq/UHOjGzo
	ag1vDBjrOpDUK9JPe1YoppC0rs7f0X07Ju/X0gMRaDwGutMtEVmgPLETBRzSYKNiekWoiUqzd00
	O7VxpxKqCzslvmytzBrqzbz0eEYgLhYeXXIxsYTRnRUE2bSJhArqErWvR1KPrslfQNhVU7j3me2
	5ndlJeWBgd91jGHOcJ094qR3ZPlSMXIDXDkqGV1HXrWhx9gRgO3G9QZoL9cJm8l48=
X-Received: by 2002:a17:902:cecf:b0:2ca:f8ef:33e4 with SMTP id d9443c01a7336-2d3456e06damr50057335ad.17.1786534637562;
        Wed, 12 Aug 2026 04:37:17 -0700 (PDT)
Received: from TENCENT64.site ([103.7.29.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d35222e5b3sm4942125ad.74.2026.08.12.04.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 04:37:17 -0700 (PDT)
From: Jun Yang <littleddfu@gmail.com>
X-Google-Original-From: Jun Yang <junvyyang@tencent.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: stable@vger.kernel.org,
	Jun Yang <junvyyang@tencent.com>,
	TencentOS Corvus AI <corvus@tencent.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: bridge: mcast: don't truncate the port group walk on teardown
Date: Wed, 12 Aug 2026 19:34:24 +0800
Message-ID: <20260812113435.1854275-1-junvyyang@tencent.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__br_multicast_disable_port_ctx() and br_multicast_del_port() walk
port->mglist with hlist_for_each_entry_safe(), which only guarantees that
the *current* node may be removed by the loop body.

The body is br_multicast_find_del_pg() -> br_multicast_del_pg(), and that
deletes further port groups of the very same port. br_multicast_del_pg()
drops the group's sources, and br_multicast_fwd_src_remove()
(net/bridge/br_multicast.c:583) deletes the (S,G) port group installed on
that same port; br_multicast_star_g_handle_mode() -> __fwd_del_star_excl()
(net/bridge/br_multicast.c:330) deletes the automatically installed
MDB_PG_FLAGS_STAR_EXCL entries, again on that same port. All of those sit
on the same port->mglist.

When one of them happens to be the node the iterator already latched as
"next", hlist_del_init() clears its ->next, the walk sees NULL and stops.
Every port group after it is silently left on the port. port->mglist is
head-inserted, so this needs the cascade victim to be older than the (*,G)
entry owning the source - a user-added, non-permanent (S,G) MDB entry added
before the (*,G) join produces exactly that ordering.

Hitting it once truncates the disable walk in
__br_multicast_disable_port_ctx() and once more truncates the flush in
br_multicast_del_port(), so del_nbp() goes on to free the port with port
groups still on port->mglist - and still linked in the bridge's mdb, with a
dangling ->key.port. Any subsequent mdb dump reads the freed port:

  BUG: KASAN: slab-use-after-free in __mdb_fill_info+0x1191/0x1320
  Read of size 8 at addr ffff88803065d008 by task bridge/9527
   __mdb_fill_info+0x1191/0x1320
   br_mdb_dump+0x594/0xe40
   rtnl_mdb_dump+0x1cf/0x5d0
  Freed by task 0:
   kfree+0x265/0x740
   kobject_put+0x212/0x6a0
   rcu_core+0x5c6/0x1140
  Last potentially related work creation:
   __call_rcu_common.constprop.0+0xb7/0x9e0
   br_del_if+0xdd/0x260

Don't rely on the pre-latched next pointer. br_multicast_del_port() deletes
everything, so just take the current list head each round. The filtered
walk in __br_multicast_disable_port_ctx() keeps its iterator but restarts
whenever the latched node has left the list; port groups are only freed by
the multicast GC work, which takes br->multicast_lock, so the node is still
valid memory for that check.

Fixes: b08123684bd5 ("net: bridge: mcast: install S,G entries automatically based on reports")
Cc: stable@vger.kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Assisted-by: tencentos-corvus-ai:kimi-k3
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
A KASAN reproducer for this issue is available if requested.

 net/bridge/br_multicast.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 00aa9b2879d6..624dfca4066b 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2065,12 +2065,17 @@ void br_multicast_del_port(struct net_bridge_port *port)
 {
 	struct net_bridge *br = port->br;
 	struct net_bridge_port_group *pg;
-	struct hlist_node *n;
 
-	/* Take care of the remaining groups, only perm ones should be left */
+	/* Take care of the remaining groups, only perm ones should be left.
+	 * Deleting one can delete others on this same port->mglist, so
+	 * always restart from the head.
+	 */
 	spin_lock_bh(&br->multicast_lock);
-	hlist_for_each_entry_safe(pg, n, &port->mglist, mglist)
+	while (!hlist_empty(&port->mglist)) {
+		pg = hlist_entry(port->mglist.first,
+				 struct net_bridge_port_group, mglist);
 		br_multicast_find_del_pg(br, pg);
+	}
 	spin_unlock_bh(&br->multicast_lock);
 	flush_work(&br->mcast_gc_work);
 	br_multicast_port_ctx_deinit(&port->multicast_ctx);
@@ -2126,11 +2132,23 @@ static void __br_multicast_disable_port_ctx(struct net_bridge_mcast_port *pmctx)
 	struct hlist_node *n;
 	bool del = false;
 
-	hlist_for_each_entry_safe(pg, n, &pmctx->port->mglist, mglist)
-		if (!(pg->flags & MDB_PG_FLAGS_PERMANENT) &&
-		    (!br_multicast_port_ctx_is_vlan(pmctx) ||
-		     pg->key.addr.vid == pmctx->vlan->vid))
-			br_multicast_find_del_pg(pmctx->port->br, pg);
+	/* br_multicast_find_del_pg() can delete further entries of this same
+	 * port->mglist, so the node latched in @n may be unlinked by the loop
+	 * body. Port groups are only freed by the GC work under multicast_lock,
+	 * so @n is still valid here; if it left the list, restart.
+	 */
+restart:
+	hlist_for_each_entry_safe(pg, n, &pmctx->port->mglist, mglist) {
+		if ((pg->flags & MDB_PG_FLAGS_PERMANENT) ||
+		    (br_multicast_port_ctx_is_vlan(pmctx) &&
+		     pg->key.addr.vid != pmctx->vlan->vid))
+			continue;
+
+		br_multicast_find_del_pg(pmctx->port->br, pg);
+
+		if (n && hlist_unhashed(n))
+			goto restart;
+	}
 
 	del |= br_ip4_multicast_rport_del(pmctx);
 	timer_delete(&pmctx->ip4_mc_router_timer);
-- 
2.55.0

