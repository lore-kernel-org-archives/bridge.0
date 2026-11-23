Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429725;
	b=EGwsF4fhmmrPVF/So9W6WOXKMc4qmuCLaBU7l0n7YEOtTAX8ytn3cqvHyZWdtZgWxjR9
	 n3MRvqgNVs5yBJyCa28IET4hLSX2ABNILq4xyOaS7SRoyQu+J+kfZVQh11C+4/KUgRIJI
	 wjyIF+X8u0MucZMQnaj53lCflRivIKqu4D3G12Te0I9w7nua5K5DyetHGP3elIjEo6ST8
	 mCE3Gza7tYjYGZt6codLuriH5MjpdKdbvReAuCArepZe6VlUZ9VIZShybgBS8IVDW3UFz
	 RHGl+52L7K2HrIFzqZUmT7cWBZv3JeqtC5vQpEfP12e5Z1kAo8dyBu6Jevgnu8gTgQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MbCT6kMCgXiWS2cYOuIzCOxXqN/CG0QGdZHpCWESMQY=;
	b=OnFps6RJ9YhgBUFAorDAwlNJ8ykjw+HArpwe+TINCNUTxZvRHWxE+Ow33P/omuN3w0lr
	 B7o5dZMt5TbGzI6nukWY5JK49WqoXA5gHu0MVS1jbtfr+eOib5MjqZKfJopLErcg9vZC7
	 X+Uc4UlV4Sy9gPgC8mpSq+irAq/cUA+qyC5URLsIpyApwsM8OQpLtbrGZp4lXFZurex3k
	 EyR+8VJSjpj0oQDsLmqCqCZ1s2GskWKqDfuimJaRTXbtHX0PEH9bYg+4OaOiEGHLJsT/H
	 yyFrTb4Heqvm6RnuE/sz1mjpkswMlztpCEdrQiuuOKsvlX5U4AguObPIFv4THAftsAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=hPiCsOGj;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEA2606A31E
	for <bridge@lists.linux.dev>; Mon, 23 Nov 2026 10:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFEA2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=hPiCsOGj
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-498f5fa5103so1787181f8f.2
        for <bridge@lists.linux.dev>; Mon, 23 Nov 2026 02:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1795429723; x=1796034523; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MbCT6kMCgXiWS2cYOuIzCOxXqN/CG0QGdZHpCWESMQY=;
        b=hPiCsOGjDfVQYi1HdWe4z9zrvoz2/MGx4S9ip5LPnUx7Tdmg6GrvijNWTJos+jpLGi
         Ivfd67HZVJkpOtORD69lzEijRdrZHhFCgFRMCjEMipJHeFJoIKqUKvpzCSpWXZIzs0b2
         pi7+D3ovd8y3S4O5mM62f5t07RzEGJzvm4atVg0n603CuCz1nanEtN1T3wB5YMjAbLYt
         RHqfIFPROmWhnaOBsDcCj025MBzHbTiy3PYZEvDqiG3o3GwV5B/O+1L9BseQnP8wR/iP
         g7Bnm78Z9ierB/Zcj8T6sHeviHDTNZtEEybfuvmBvk6/oE02THq4eKgqVxFKsvAdhTcE
         J3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795429723; x=1796034523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MbCT6kMCgXiWS2cYOuIzCOxXqN/CG0QGdZHpCWESMQY=;
        b=Z/ud4JnyrdAbFYGHUkFGomHzSDfbKluX1hVgnYJaV01cYGezC/Fr1R/a/BDq6XqkOE
         lt0FXHKiCNf/Jy/1oOFttqzft5oJnT/GsqLRBqX6O4t3kmDkiOzxW1yYbBUr5e7cISEY
         cPSIer8d5PuutX8zh7tchOpY8fqDGK5Mdd3zB1A7gzu1UevImYadpTyog6uN4jvxYd3g
         drQeRBa8wH9corK9JWyxiY177+DspFhvqt6XoI1iHdppX9M5aTszV0dv3KTwtaSNrNYT
         MapnfPxp9vgoe/mEOxkcLK5S3d9dsJcNpfuujaXUlbJk/Ura+ZpsY5I23kMZF2SJJSMX
         l8Yw==
X-Forwarded-Encrypted: i=1; AL+hErG12D0IaOSQW6BQuL1we5FIJvXWA4xSNfu8Tp2DxrS96lhysl943jnEjxR+U+lCkG9xIBLdLAU=@lists.linux.dev
X-Gm-Message-State: APuU4Z+6cUjbyEbpwJmzuvSzCZ8TSojkpwFByFBd949UnM5hFZCt1uLj
	5vUk16xqR4fPSVO3Av1+bAnNjNuyXvj7SsV5NpWZKyTCsEqOEC0RVUwQA5yt0AyET+c=
X-Gm-Gg: AZFdTZdUyVxGTWNZmRdJhHRILdf2WmqIYuYz6FlgmPwu+rFKMNFmb/W2sbDAyYQ4TkX
	CXulLuh70+jxDpdQ4fmjKTrzudv3U6+rXAIdUj0VYHLSlpzOBhpulCd5wF5l3/NW9xgrRYqOTBW
	DSeyxdF2U1JpIgwWnXyPb1GzFuzYbxmzwc2pD83XqwXwMV9/cUaOs8dHeOyDUY9nLKVRbR8HcNa
	4mLWL89tBezpIsk1zMp7iMSt4i6aVffl7TUxAvDlhtMuipdNyhmlS1kA0xeUznHoS8MeimSPe+B
	HEyALBF3kKvJFoBQ0pGa7q/OffLsMllgw2Q/5gUu8SGQY97x4KCPpr/6HRSq9XgX/VbPGT1OP+x
	/8rXaCSvLsGtyPLAJjehOUop0HIEP8s4Sqzag5vMu5nROzCC2PPji+3RN/aD4nacw1ppfzO4P0E
	JV7Ps0FEwA7Ckh3KbdM9SnRtiqQBg6+xRs1KqcFDAqzFKe1w4vhwLqaY+20+0j0596y5Zb+/dCU
	qI1+eCWYU0C7EZKjYwvwWdhhRcOo13OgdkCunEIpV4I4FdkcIYeGrh++MZpZFP/qxaSkWlh18+6
	sdsSWS+4tjjd9e9xi/mpQoXWYSTXW0CkEu5tA3I1F70pYQV5ZJI=
X-Received: by 2002:a05:6000:26d0:b0:4a6:8012:197 with SMTP id ffacd0b85a97d-4ad5d5f9320mr18552786f8f.2.1795429723291;
        Mon, 23 Nov 2026 02:28:43 -0800 (PST)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4ab65cb4341sm21786888f8f.4.2026.11.23.02.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 02:28:42 -0800 (PST)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bridge@lists.linux.dev
Subject: [PATCH net-next 2/3] net: bridge: mdb: index port groups by VLAN
Date: Mon, 23 Nov 2026 12:28:32 +0200
Message-ID: <20261123102833.924427-3-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123102833.924427-1-razor@blackwall.org>
References: <20261123102833.924427-1-razor@blackwall.org>
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Index each port's multicast groups by VID in a fixed 64-bucket hash
table. Maintain the index under multicast_lock alongside mglist,
including groups retained without port VLAN membership, and remove
entries on both port-group deletion paths.

Use the index when counting groups for a newly created port VLAN
context, avoiding a scan of all groups on the port for every added VLAN.
Keep mglist for its existing RCU readers and teardown walks. The index
also lets VLAN publication and unpublication update cached destinations
without repeatedly walking the full group list.

Operation  VLANs   Global ms before/after   Change %   Per-VLAN ms before/after   Change %
  ------------------------------------------------------------------------------------------
  add            1      0.0519 /   0.0900      +73.52       0.0481 /   0.0895      +86.16
  add           64      2.2500 /   0.7190      -68.04       2.2726 /   0.7441      -67.26
  add         1024     32.7464 /   5.7028      -82.58      32.9841 /   6.3116      -80.86
  add         4094    149.6750 /  34.3223      -77.07     151.5808 /  35.4586      -76.61

Note that the struct net_bridge_port_group increase pushes the allocations
above 256 bytes and into kmalloc-512, this can be kept compact by
introducing a kmalloc cache for these. It can be done separately.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
CC: Ido Schimmel <idosch@nvidia.com>
CC: David S. Miller <davem@davemloft.net>
CC: Eric Dumazet <edumazet@kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>
CC: bridge@lists.linux.dev

 net/bridge/br_multicast.c | 7 ++++++-
 net/bridge/br_private.h   | 4 ++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index ae4fa050be97..7285229ca6d7 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -826,6 +826,7 @@ static void __br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
 	 * and deleting other groups of the same port must not truncate it.
 	 */
 	hlist_del_init_rcu(&pg->mglist);
+	hash_del(&pg->vlan_node);
 	br_multicast_eht_clean_sets(pg);
 	hlist_for_each_entry_safe(ent, tmp, &pg->src_list, node)
 		br_multicast_del_group_src(ent, false);
@@ -1472,6 +1473,7 @@ struct net_bridge_port_group *br_multicast_new_port_group(
 
 	RCU_INIT_POINTER(p->next, next);
 	hlist_add_head_rcu(&p->mglist, &port->mglist);
+	hash_add(port->mdb_vlan_hash, &p->vlan_node, group->vid);
 
 	return p;
 
@@ -1488,6 +1490,7 @@ void br_multicast_del_port_group(struct net_bridge_port_group *p)
 	__u16 vid = p->key.addr.vid;
 
 	hlist_del_init_rcu(&p->mglist);
+	hash_del(&p->vlan_node);
 	if (!br_multicast_is_star_g(&p->key.addr))
 		rhashtable_remove_fast(&port->br->sg_port_tbl, &p->rhnode,
 				       br_sg_port_rht_params);
@@ -2105,7 +2108,8 @@ void br_multicast_port_ctx_init(struct net_bridge_port *port,
 		u32 n = 0;
 
 		spin_lock_bh(&port->br->multicast_lock);
-		hlist_for_each_entry(pg, &port->mglist, mglist)
+		hash_for_each_possible(port->mdb_vlan_hash, pg, vlan_node,
+				       vlan->vid)
 			if (pg->key.addr.vid == vlan->vid)
 				n++;
 		WRITE_ONCE(pmctx->mdb_n_entries, n);
@@ -2138,6 +2142,7 @@ int br_multicast_add_port(struct net_bridge_port *port)
 {
 	int err;
 
+	hash_init(port->mdb_vlan_hash);
 	port->multicast_eht_hosts_limit = BR_MCAST_DEFAULT_EHT_HOSTS_LIMIT;
 	br_multicast_port_ctx_init(port, NULL, &port->multicast_ctx);
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 20e423e22132..04430dc32d02 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -18,6 +18,7 @@
 #include <net/pkt_cls.h>
 #include <linux/if_vlan.h>
 #include <linux/rhashtable.h>
+#include <linux/hashtable.h>
 #include <linux/refcount.h>
 
 #define BR_HASH_BITS 8
@@ -29,6 +30,7 @@
 #define BR_MAX_PORTS	(1<<BR_PORT_BITS)
 
 #define BR_MULTICAST_DEFAULT_HASH_MAX 4096
+#define BR_MDB_VLAN_HASH_BITS 6
 #define BR_MULTICAST_QUERY_INTVL_MIN msecs_to_jiffies(1000)
 #define BR_MULTICAST_STARTUP_QUERY_INTVL_MIN BR_MULTICAST_QUERY_INTVL_MIN
 #define BR_MULTICAST_QUERY_INTVL_MAX msecs_to_jiffies(86400000) /* 24 hours */
@@ -386,6 +388,7 @@ struct net_bridge_port_group {
 	struct timer_list		timer;
 	struct timer_list		rexmit_timer;
 	struct hlist_node		mglist;
+	struct hlist_node		vlan_node;
 	struct rb_root			eht_set_tree;
 	struct rb_root			eht_host_tree;
 
@@ -449,6 +452,7 @@ struct net_bridge_port {
 	u32				multicast_eht_hosts_limit;
 	u32				multicast_eht_hosts_cnt;
 	struct hlist_head		mglist;
+	DECLARE_HASHTABLE(mdb_vlan_hash, BR_MDB_VLAN_HASH_BITS);
 #endif
 
 #ifdef CONFIG_SYSFS
-- 
2.47.3

