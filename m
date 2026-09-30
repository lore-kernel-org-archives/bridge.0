Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1853045516A
	for <bridge@lists.linux.dev>; Wed, 30 Sep 2026 07:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752524; cv=none; b=nyZ6Yw+V6Zd6w2sbYTHuMe7YBiTzeLm0s08SJTYVazsoOlTrZLerF+H882V25XUXmleBx6Jk08TF1plMDe61UsmYSwQ+S0mzawnHHgY+5v5RlblHZ/Gqxj/2BEoJ2viY9EnL9ONaZZr4jexu9DCWrL5tXjaNTLBsuHc5TmUSK+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752524; c=relaxed/simple;
	bh=5Lt2lp+0hhePIuqU5nKfUcyVR1D24JAIXqAKhRwrfk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2Q/DiZyDc/EbJP9o4vj/JY5IyAJAu5MIXjAFSoDHGDGEASzSZBcP9LW17CU4i71WFLXvIw/Lsp0/BCGxbKnUcEyLWUhob8tXEQPs9zSxvB26OqBmwzWd3m2vvyM1GKWrMTdu7YQAwqmGPcSRaOJ8CRCkyzO8527Kmrx3PX2scg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Op5Za7Pa; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Op5Za7Pa"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso52160185e9.1
        for <bridge@lists.linux.dev>; Wed, 30 Sep 2026 00:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1790752515; x=1791357315; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C7cE0E09bFRA5/SD/7XaxlCKnqoq1sX0BHGAvwGXGDc=;
        b=Op5Za7PaT7dukE7Umwc1o76QLbs1y/Jn874l3RSJguCZbfTUYAmsrfGXFkU9KH34Vf
         kF4bhudzudU3RTI6CrTKaIv2o20nZkVxwDp88PZEeEGozi66gpFp/qFvIOC+kdIEhdL5
         N3bTKWOpDlqm2aKXJLfCL4iJz8M5sYh04QD0aRQOyiEp3tRB5elQ4SF81O/1tcEtJV5j
         mq7v6NUdZevrKITCKpUtU7D3jQ0tpW80IRCxXBs6NbWlLqGplVX9XAtXx3cgrRPj+aIp
         WQCeA64TAg62vSCbontaTUm6qjUdXamac6H38qVmYilBWD5OB3/K8duBtYticLmAhAar
         mVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752515; x=1791357315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C7cE0E09bFRA5/SD/7XaxlCKnqoq1sX0BHGAvwGXGDc=;
        b=JMTGU8u8//oNM9DhUTbcOPqTw+eWciteKj46JNey3JpvHycXCtD8hEOSdxIQoVowHd
         NT4HWaT5i/NW+kvawNA4IP79Jh1NJLsELdNjh0VZe+zLaf03vxtdArmpZobuTRBXYWM5
         Gq0UfQknDquIEjdcNFMUXBYb3Nd/0crqpe+PDrPgsY1drqga12hnv7YF5DaZ73ZXaziX
         sz8L/wT5mnFG8ojqocPJT9T8RomLOSciGhW18jF9jW15BPgcmeI4tzAL+AFLmzW2Wcdj
         eW6lK9mUc4/fGH1yrUi9sZUqfMq7qb8So7KA7o5v+CpiVu8RHrg8sR2VfNAdWXtejjA8
         USHA==
X-Forwarded-Encrypted: i=1; AKwUvBy90HRk9JOjKgA1Yw+3o0Yh5Q0ExMmk/JOSKDd6RZ1FEoUI9yDFB7sGq3isHZi6OZ0fGqbCBS8=@lists.linux.dev
X-Gm-Message-State: AFuF++lTYKS1XDEJ8aqV1OEeMyNN2CI5gpAKfORPrfk6WTfKisL/qyJA
	ptt5oAhjZ1kuVTweSq2q9tN7WGIo4V7bhvVd+OlKwYF7g6f/lgNNeOiJbRI9u/OfbuEJIFjFbtB
	xLiEB
X-Gm-Gg: AYBFou3F25OAGH94cMzlF9NcJGvvXLHK2st3Oy/HHUP6JFZVKWArZzVmRmoxJmSaSki
	nj05aFjVbYBvfhqeox+ng2zQpujlyG8XpblagTSI0yuqfMBiW9E1jYdtUDw+PbxO+q3h0QBc0oA
	iLYTKsX+vUlEnvF0aO7xstoZ7C6gaI2b1FpWtDis3hBTGL0XoQBmz4bmKDy0d9vdYYhAalGb7K5
	EBf3YA6Dbvg6JmJdy36rwdd6QJUWkCYjmYxpS3PJDAnJs45ZjJx6zhCZNkARDoc9gk1HtnNyNLc
	9qi3trEds310xQGIIklp5xBAHD6fwDjOVDnwUlxx9IxbUEHhXFsuLJJADNa6HWteezjBdxIHxoW
	83ZXbMPJTXjDF4TQzPEyP6mYs/tFVaRRNUVXacqenrjFryVUOc5bCck1y7GwcnAw5OKvV7yNSNr
	eBSPkdIMHhGOpRjONOPcsDH40ntKUNUKs7S2bxzPi31RBWF5UNRwkxwx3E+bnhDis79bS4AcX7e
	YFP4SJSSLAChWqO5yS+
X-Received: by 2002:a05:600c:4687:b0:4a0:3a3:33e2 with SMTP id 5b1f17b1804b1-4a01adde08dmr6362245e9.5.1790752515182;
        Wed, 30 Sep 2026 00:15:15 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a01771cf9fsm33112235e9.14.2026.09.30.00.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:15:14 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 11/12] net: bridge: fdb: cache VLAN destinations in configured entries
Date: Wed, 30 Sep 2026 10:14:10 +0300
Message-ID: <20260930071411.2786201-12-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930071411.2786201-1-razor@blackwall.org>
References: <20260930071411.2786201-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the known port-VLAN destination for user-configured fdb entries and
resolve switchdev vids with an fdb helper. VLAN 0, bridge entries and
unconfigured switchdev vids retain raw port destinations. Keep the vid
alongside the destination because it remains part of the fdb key.
Use conditional replacement for same port destination upgrades so they
don't overwrite a concurrent packet-learned roam. Port changing updates
remain direct and report a forwarding change.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_fdb.c | 61 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 11 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 5664f3d649fa..730b178cf6c4 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1192,10 +1192,11 @@ static bool fdb_handle_notify(struct net_bridge_fdb_entry *fdb, u8 notify)
 }
 
 /* Update (create or replace) forwarding database entry */
-static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
+static int fdb_add_entry(struct net_bridge *br, struct net_bridge_dst dst,
 			 const u8 *addr, struct ndmsg *ndm, u16 flags, u16 vid,
 			 struct nlattr *nfea_tb[])
 {
+	struct net_bridge_port *source = br_dst_port(dst);
 	bool is_sticky = !!(ndm->ndm_flags & NTF_STICKY);
 	bool refresh = !nfea_tb[NFEA_DONT_REFRESH];
 	struct net_bridge_fdb_entry *fdb;
@@ -1230,19 +1231,26 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
 		if (!(flags & NLM_F_CREATE))
 			return -ENOENT;
 
-		fdb = fdb_create(br, br_port_to_dst(source), addr, vid,
+		fdb = fdb_create(br, dst, addr, vid,
 				 BIT(BR_FDB_ADDED_BY_USER));
 		if (!fdb)
 			return -ENOMEM;
 
 		modified = true;
 	} else {
+		struct net_bridge_dst old_dst;
+
 		if (flags & NLM_F_EXCL)
 			return -EEXIST;
 
-		if (br_fdb_dst_port(fdb) != source) {
-			br_fdb_dst_write(fdb, br_port_to_dst(source));
-			modified = true;
+		old_dst = br_fdb_dst_read(fdb);
+		if (!br_dst_equal(old_dst, dst)) {
+			if (br_dst_port(old_dst) != source) {
+				modified = true;
+				br_fdb_dst_write(fdb, dst);
+			} else {
+				br_fdb_dst_replace(fdb, old_dst, dst);
+			}
 		}
 
 		set_bit(BR_FDB_ADDED_BY_USER, &fdb->flags);
@@ -1296,6 +1304,7 @@ static int __br_fdb_add(struct ndmsg *ndm, struct net_bridge *br,
 			bool *notified, struct netlink_ext_ack *extack)
 {
 	u16 vid = vlan ? vlan->vid : 0;
+	struct net_bridge_dst dst;
 	int err = 0;
 
 	if (ndm->ndm_flags & NTF_USE) {
@@ -1320,8 +1329,10 @@ static int __br_fdb_add(struct ndmsg *ndm, struct net_bridge *br,
 		}
 		err = br_fdb_external_learn_add(br, p, addr, vid, false, true);
 	} else {
+		dst = p && vlan ? br_vlan_to_dst(vlan) : br_port_to_dst(p);
 		spin_lock_bh(&br->hash_lock);
-		err = fdb_add_entry(br, p, addr, ndm, nlh_flags, vid, nfea_tb);
+		err = fdb_add_entry(br, dst, addr, ndm, nlh_flags, vid,
+				    nfea_tb);
 		spin_unlock_bh(&br->hash_lock);
 	}
 
@@ -1553,10 +1564,31 @@ void br_fdb_unsync_static(struct net_bridge *br, struct net_bridge_port *p)
 	rcu_read_unlock();
 }
 
+static struct net_bridge_dst br_fdb_resolve_dst(const struct net_bridge_port *p,
+						u16 vid)
+{
+	struct net_bridge_dst dst = br_port_to_dst(p);
+	struct net_bridge_vlan *v;
+
+	lockdep_assert(rcu_read_lock_held() || lockdep_rtnl_is_held());
+
+	if (!p || !vid)
+		return dst;
+
+	rcu_read_lock();
+	v = br_vlan_find(nbp_vlan_group_rcu(p), vid);
+	if (v)
+		dst = br_vlan_to_dst(v);
+	rcu_read_unlock();
+
+	return dst;
+}
+
 int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 			      const unsigned char *addr, u16 vid, bool locked,
 			      bool swdev_notify)
 {
+	struct net_bridge_dst dst = br_fdb_resolve_dst(p, vid);
 	struct net_bridge_fdb_entry *fdb;
 	bool modified = false;
 	int err = 0;
@@ -1581,25 +1613,32 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 		if (locked)
 			flags |= BIT(BR_FDB_LOCKED);
 
-		fdb = fdb_create(br, br_port_to_dst(p), addr, vid, flags);
+		fdb = fdb_create(br, dst, addr, vid, flags);
 		if (!fdb) {
 			err = -ENOMEM;
 			goto err_unlock;
 		}
 		fdb_notify(br, fdb, RTM_NEWNEIGH, swdev_notify);
 	} else {
+		struct net_bridge_dst old_dst;
+
+		old_dst = br_fdb_dst_read(fdb);
 		if (locked &&
 		    (!test_bit(BR_FDB_LOCKED, &fdb->flags) ||
-		     br_fdb_dst_port(fdb) != p)) {
+		     br_dst_port(old_dst) != p)) {
 			err = -EINVAL;
 			goto err_unlock;
 		}
 
 		WRITE_ONCE(fdb->updated, jiffies);
 
-		if (br_fdb_dst_port(fdb) != p) {
-			br_fdb_dst_write(fdb, br_port_to_dst(p));
-			modified = true;
+		if (!br_dst_equal(old_dst, dst)) {
+			if (br_dst_port(old_dst) != p) {
+				modified = true;
+				br_fdb_dst_write(fdb, dst);
+			} else {
+				br_fdb_dst_replace(fdb, old_dst, dst);
+			}
 		}
 
 		if (test_and_set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
-- 
2.47.3

