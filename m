Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C2E3DCD90
	for <bridge@lists.linux.dev>; Mon, 31 Aug 2026 11:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788174845; cv=none; b=sGBb4S8Yw1XvM2ae1pmI99nevk+eh6oM5pQtda78SVXKNw1I5ma1LDuxCF5iDpWbXzYSKEBlKNsGQJ2MnO7ZJnw1tYSPamYCXDBLGlF86fmq477COHvIXFb2HD1EhRd3Py+x5/k3Uv5qSw9OXbf2kc8MXJETGKrQ2BVrI15K9Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788174845; c=relaxed/simple;
	bh=6oLHWoiKE6PxbL40mPCFbnvkhnQ7KTpkUturhUz+hPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EzLZkq+nJ2NmESaqPvOmwSF+Se67EMAu95HfnX4IDP09GJN9xKN1P7EDundA8Bi0MuCk/Ch/5N+ET2x8S+92UNaMU+/eYyfMo8LvwiDmJSylYO+zQn/PqvwpHXKX13dyMTSIvKWm1swh5EqFcRw4FTAbNqWxWV/kLvaBI0pAMtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KX0/VDVt; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KX0/VDVt"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-853e2610bb4so2945810b3a.0
        for <bridge@lists.linux.dev>; Mon, 31 Aug 2026 04:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788174842; x=1788779642; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W/7mL4yqWLEKqVvJuqvWtKvTVqgdZx0s+TSdJcgWJMQ=;
        b=KX0/VDVtq03vISL/d0OeLvpqsVN+McLiMs5ObLJieouKaQ4BkYyJkBpDaoI2KEL+TS
         yDQIJz5MD210QWxF8kGu0jny4ku/lodgBb/zvn8zYSd5XxdSUCKugDucNVRnvx/ZkFdY
         jpNrNXRoU5r0x5ECd97Rp32UDbNp9koRCxfwi5HSfkokHLi6YNtmQLMQ5d0WOh2yBylC
         MIdaiQyZkKdyp5k8+rXkVvS/dRPqrmllPfeLB8e27R4/G8d6ljzmLn3orEB0gnA4cIGq
         Z+TbofFiLS9QFcBVKkVAA+i10UqQsajgHd+4boz5qL7hEk0ZNmdt9LC8vNuAV7GWlJvw
         LICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788174842; x=1788779642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W/7mL4yqWLEKqVvJuqvWtKvTVqgdZx0s+TSdJcgWJMQ=;
        b=KnvQsmbdlnpIuqgSCHPVzxv8wzSbfq8JGOBzB3qGMgS5Rq4FJc8KSAk/bQw1xIFTor
         X230UgJsLx3JgED74F5eAWbc+mArMSCRLqSdhvXSeUDl2zig2xOwMhTQdmin3z8TdhsH
         m46rejI+nH6kIumY6NSAyWevogmRLVr93epsmwZIjwEBjM+60k44ewN6rxKxFDEK76IL
         VkJtcURRc+Ayl90Ey5oqCLN+nneMQAQeCRzK6W+neGso3D86oFH2TajsgTDqBgpl7hHM
         1rhM8rcQB8eMS7yakj4pG0gjAiTPP4xFNISUGnfxQkhQFC/qMRuw+lKbsJjLj6L6bX03
         6rwg==
X-Forwarded-Encrypted: i=1; AHgh+RqgstJ+4CwOKV57Ak2gIybxpsJSUI/q0Z9crHpx/cqMLnZ9mng0eEFiffzKOPEPBfF1nCTgtEA=@lists.linux.dev
X-Gm-Message-State: AFuF++mhUwsl7ZOQWAy7FETTdHjXdVJ3/Eyp6fRN9NgeS7NwZub4P6vm
	1QEp04dwpOb2WHZqkC7aHFeBuh7O+dEdsgq9bYj9J+Up9ZFupd18LIdJ
X-Gm-Gg: AR+sD114WF63tTKs43JszNSCJpilJCXWP8D2n5Zfn6n/7oAEHjFZ+4u5w0lkB+ZGzQB
	qr/H20qiHR9rUjeV+faaepxPI9zZXoymyRvroH+Nyr4083EBt3xVzYRw7QMoln4w3cgH3gByOrs
	ka27mep7oRXyYLB0KQeI2diVz6zuV0vZ7wwtQBiFeEgXmAbNMXsduZDUgB/HPGR5cNCqY/urGsb
	CNBga6tAb0i5eL6d3M3FcP0XCmTWwnV52j2QxY6K34Sypeayr74eME/iCgNn9ARDQEb2UlzQPb/
	24DH38vkZJNvQhIN2UiZV10ntIgA1cYpXxFxE3y9KoXAjrzwWPqH0+2ZmqqM0Bi/KqWD746fIZ3
	JsMMreRX2UK5sV1A1Trt/OaHD0UVvSMjjWjNQwVhegaNzaH1N4Ob0plDwdG5GnUreM3CVP0luY2
	MyV/ITB5KvV4PZT5JOba9j7ctRuFDEk7fbPFvLyBvvJ4cZilzlLcLJB7gSiB6FtWEUsokwLQYO6
	Q==
X-Received: by 2002:a05:6a21:3216:b0:3d3:aed2:6f27 with SMTP id adf61e73a8af0-3d5da1aa7bamr6686426637.27.1788174842238;
        Mon, 31 Aug 2026 04:14:02 -0700 (PDT)
Received: from TENCENT64.site ([103.7.29.106])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f36aeb7esm4133282a12.15.2026.08.31.04.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 04:14:01 -0700 (PDT)
From: Jun Yang <littleddfu@gmail.com>
X-Google-Original-From: Jun Yang <junvyyang@tencent.com>
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
Subject: [PATCH net v3] net: bridge: mcast: don't truncate the port group walk on teardown
Date: Mon, 31 Aug 2026 19:13:04 +0800
Message-ID: <20260831111330.199543-1-junvyyang@tencent.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Preserving ->next means a walk can now reach a group that an earlier
iteration already deleted as a side effect. That group is off mp->ports,
so br_multicast_find_del_pg() would fall through its port scan and hit
the trailing WARN_ON(1). Skip such groups at the top of that helper: a
port group is put on port->mglist when it is created and only unlinked
when it is deleted, so hlist_unhashed() identifies exactly this case.

Fixes: b08123684bd5 ("net: bridge: mcast: install S,G entries automatically based on reports")
Cc: stable@vger.kernel.org
Suggested-by: Nikolay Aleksandrov <razor@blackwall.org>
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Assisted-by: tencentos-corvus-ai:kimi-k3
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
v3: skip already-unlinked groups at the top of br_multicast_find_del_pg()
    instead of in each teardown walk, per Nikolay's suggestion, so the
    preserved ->next no longer leads to the trailing WARN_ON(1).

v2: https://lore.kernel.org/netdev/20260826014200.362304-1-littleddfu@gmail.com/
    Use hlist_del_init_rcu() to preserve ->next, as suggested by Nikolay,
    instead of restarting the walks.

v1: https://lore.kernel.org/all/20260812113435.1854275-1-junvyyang@tencent.com/

 net/bridge/br_multicast.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 00aa9b2879d6..ea0a50eb8b77 100644
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
@@ -835,6 +839,13 @@ static void br_multicast_find_del_pg(struct net_bridge *br,
 	struct net_bridge_mdb_entry *mp;
 	struct net_bridge_port_group *p;
 
+	/* A teardown walk over port->mglist can reach a group that an earlier
+	 * iteration already deleted as a side effect. It is off mp->ports by
+	 * now, so skip it instead of falling through to the WARN_ON() below.
+	 */
+	if (hlist_unhashed(&pg->mglist))
+		return;
+
 	mp = br_mdb_ip_get(br, &pg->key.addr);
 	if (WARN_ON(!mp))
 		return;
-- 
2.43.7

