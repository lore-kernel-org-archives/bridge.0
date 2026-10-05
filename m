Received: from mail-wr2-f33.google.com (mail-wr2-f33.google.com [74.125.225.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9834AD4C4
	for <bridge@lists.linux.dev>; Mon,  5 Oct 2026 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211212; cv=none; b=IpnUvHHWOgrFYB/cZCXpUVbBeSIiGkw9/XII4nVQkNXVH7LPElfph2LEy6Id8KNX1Csxd+IP3qlvqzit5fDuME7LtKMGMJVyd8U8QZBvSCckuSSsQMnGfKkHMxFjNBfceKSQnhm1LyfVKMsFBqz1rBZNKZlevwDiXnbReJw4t0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211212; c=relaxed/simple;
	bh=tiMGbl7YiySDDxaT7mP39g7i86oEja0S83IXc1lcNX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nv/7iGL2hUe+oB3Kc38/rw65WIPACWkMlsVWSzitWb0NRu3s6HyhSdas7sSXMcmEsFmkZuozXWdglI35/1GyH53MsuCiT5mkhDiFozjiOYr+V5epNRefNycv4Sv44SuazfgZ1pk+QeX7dK+SIGI748Fv0cbst1AHsgu7PceUplM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=djsmJ1Ep; arc=none smtp.client-ip=74.125.225.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="djsmJ1Ep"
Received: by mail-wr2-f33.google.com with SMTP id ffacd0b85a97d-48c54d65743so1128381f8f.1
        for <bridge@lists.linux.dev>; Mon, 05 Oct 2026 07:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1791211199; x=1791815999; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b6deinWBLjHPGJwkUzGgA8QKl3at9nB5CJnJYmjFnTs=;
        b=djsmJ1Ep5oVdpZF8TKVxOrr8SbQSNl41+ivqPmOQv5EaU78lVU+KaC0uqmeyqDS4Ta
         R5NaibtFTtaVmjFI77KyNaPcOU5NP7hCDBjp9ax59gnZY+gA41Lo3kyGX7Q5XXIJMXV9
         RfdaZ+lja7hoXNLoLFENhAT2Cx20JCI3S4SlxTBtrZ5b4d6EgxeF8yFRq3PDJzMldv8Z
         vT22olXu0rnj2JjMviI1rGzLxzXFLhdX2PyUjWGA3zBj2Sd5dAmOsV7APHyUnS/lYiDX
         s9FcycAuI5Z5/ErnzW6LPWxacsf2BE8fOeN9KqxzdEDHmrL/kI1jyX2jfGTh9ui4FhiT
         aDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791211199; x=1791815999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b6deinWBLjHPGJwkUzGgA8QKl3at9nB5CJnJYmjFnTs=;
        b=wlJOO0qfX7CElaFGGCpZzvTh1Jdmcss2mk6HNkbrnrJp/ouIVj5kGIYhRp9IXXso3y
         OKvbikY3IxYifyo5RHUkXxVNcd87eN0uKvSnBxRCLKCKD8wx5BISX6s1yfrfuK7X8XrG
         dpySAOUXrnwMkDbj7unFug6bzQgKl5TJibnjn8yrKRG0hwo0GmfHr3eM929nDSXflCq7
         r9oJQmloQaANUWZ5jX470lNVC/mEG79h05YQ2NMwRCLfGebSocW7AZY659wHxIqcInqd
         e+rCQtQw/mlK9ZlTOTDtELF+ghwrv4joekgtuHPnmK1XGVjBVL+6uYxDVWBLaOaT7OMS
         6fnQ==
X-Forwarded-Encrypted: i=1; AKwUvBx/Jhr5TSwxrhetrBju1hlCsOnSoBt068RNZynZOHyJcRmQAujegNw8I6/cML3+fz3FBP/IRPU=@lists.linux.dev
X-Gm-Message-State: AFq9FYJ1KqMR+9OtloZf8RNuYA3mys9dgAOokfB9xL8AVkMAKGTSEFc0
	fJP3myOjRQ4v7r57yCkDG+8BdPxLaexDW5SE22QGn0XFLzKEKYw1Qp3U70/zEiOH2Dg=
X-Gm-Gg: AYBFou07ZixDfUY0RGQeTcMbHERBIeXrO5hKKAcOnqCQfrDjhdwYP7i5+mETOLJMXeV
	CKbTCkErgpcDmKgudj8pEGQoi0laFmrcV8bwuaqd6l91UGCEuOKQeJLNwi8jwSQtIqX1gb1upq9
	+VaSKacnfd7c+DYUmTJDtD8HzkzklXgXfey4fCY6mCBSYuGKAhM33mouknszxKgWUk+HyLo9/TK
	b1FloondFPRCOS8L8c8CSjwfa73PsYuAdPf1oYt6192s2muCBRSPsabCSG6lE5DKhxF3al0OPdC
	Emz/r3VloIa11G4qedZxVyTgkceiH5Pz4pkW4X7otI1HLdnxCzEGtUH8EEqEvPqCq0hjdYN96/p
	x5gpma5W2cYdU5gr59Z02TqlSnrRnPYQfpB17TSpx2ErR4DOt7HTc+94Y7TMFy2a2GbxdsWOyfE
	CiCYZ4Ajiw8NTl4IA/h9fvRzjv33WVQi67OE1REw/OFDMR2Z1bcq3juTItu5E53ALH0mY1e5orF
	WC+NqUSoNqXJXj27sOv
X-Received: by 2002:a05:6000:4b04:b0:48a:f36d:fb57 with SMTP id ffacd0b85a97d-48b1270af7dmr21384724f8f.18.1791211198767;
        Mon, 05 Oct 2026 07:39:58 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48c622ad9afsm4259504f8f.39.2026.10.05.07.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 07:39:58 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 4/6] net: bridge: vlan: inline pvid pointer updates
Date: Mon,  5 Oct 2026 17:39:35 +0300
Message-ID: <20261005143937.877466-5-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005143937.877466-1-razor@blackwall.org>
References: <20261005143937.877466-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After caching the pvid VLAN entry directly, the add and delete helpers
only check and update the pointer. So inline them both and clear pvid
directly in __vlan_flush before walking the VLAN entries.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_vlan.c | 33 +++++++++------------------------
 1 file changed, 9 insertions(+), 24 deletions(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index dcf783e1a440..c4e7e03e0969 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -34,24 +34,6 @@ static struct net_bridge_vlan *br_vlan_lookup(struct rhashtable *tbl, u16 vid)
 	return rhashtable_lookup_fast(tbl, &vid, br_vlan_rht_params);
 }
 
-static void __vlan_add_pvid(struct net_bridge_vlan_group *vg,
-			    struct net_bridge_vlan *v)
-{
-	if (rcu_access_pointer(vg->pvid) == v)
-		return;
-
-	RCU_INIT_POINTER(vg->pvid, v);
-}
-
-static void __vlan_delete_pvid(struct net_bridge_vlan_group *vg,
-			       struct net_bridge_vlan *v)
-{
-	if (rcu_access_pointer(vg->pvid) != v)
-		return;
-
-	RCU_INIT_POINTER(vg->pvid, NULL);
-}
-
 /* Update the BRIDGE_VLAN_INFO_PVID and BRIDGE_VLAN_INFO_UNTAGGED flags of @v.
  * If @commit is false, return just whether the BRIDGE_VLAN_INFO_PVID and
  * BRIDGE_VLAN_INFO_UNTAGGED bits of @flags would produce any change onto @v.
@@ -78,10 +60,12 @@ static bool __vlan_flags_update(struct net_bridge_vlan *v, u16 flags,
 	if (!commit)
 		goto out;
 
-	if (flags & BRIDGE_VLAN_INFO_PVID)
-		__vlan_add_pvid(vg, v);
-	else
-		__vlan_delete_pvid(vg, v);
+	if (flags & BRIDGE_VLAN_INFO_PVID) {
+		if (pvid != v)
+			RCU_INIT_POINTER(vg->pvid, v);
+	} else if (pvid == v) {
+		RCU_INIT_POINTER(vg->pvid, NULL);
+	}
 
 	if (flags & BRIDGE_VLAN_INFO_UNTAGGED)
 		vlan_flags |= BRIDGE_VLAN_INFO_UNTAGGED;
@@ -432,7 +416,8 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 flags,
 static void __vlan_unpublish(struct net_bridge_vlan_group *vg,
 			     struct net_bridge_vlan *v)
 {
-	__vlan_delete_pvid(vg, v);
+	if (rcu_access_pointer(vg->pvid) == v)
+		RCU_INIT_POINTER(vg->pvid, NULL);
 	if (!br_vlan_is_master(v)) {
 		struct net_bridge_vlan *masterv = v->brvlan;
 
@@ -503,7 +488,7 @@ static void __vlan_flush(const struct net_bridge *br,
 	struct net_bridge_vlan *vlan, *tmp;
 	u16 v_start = 0, v_end = 0;
 
-	__vlan_delete_pvid(vg, rtnl_dereference(vg->pvid));
+	RCU_INIT_POINTER(vg->pvid, NULL);
 	list_for_each_entry_safe(vlan, tmp, &vg->vlan_list, vlist) {
 		/* take care of disjoint ranges */
 		if (!v_start) {
-- 
2.47.3

