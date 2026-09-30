Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EAE453A5E
	for <bridge@lists.linux.dev>; Wed, 30 Sep 2026 07:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752520; cv=none; b=G7PcybGqQMsRqsUW/BSB2qPhSI+Il2lm0PRhLEILK3jYQA5UBeaBs2dQfbbO2PtDFG4QgheGPgxDa0a+u+SsbOsAo3LmSBEXfHWv54Xk/6zhHxWGhwUtJSxj+iNNb6b4jX8W7GGwWGAMINfH4tkUx7qaK8Ha68gJgpZpF2JPa9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752520; c=relaxed/simple;
	bh=ldlfciuIYbv5X4j0OpaOB1JAWwUlNJAVu78g/rnmcXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyZ5rpYGSjT+4B44/0iZCl6Pl5/nvK4nECDJNYVmA7Mfm2IiEPq5f4jujEvI0QWXSKwhLxuPdYe8dhZYwdtHFIpzC0NnIfuUzWtVLGPgZz8psEJCmGBcocfilslGDjVa6SaebEjBhAFSFHiKYm7ndP6ZMy1Ky8XYeLgaDB7sVqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=MeR+bwcy; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="MeR+bwcy"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e79a408deso30924755e9.2
        for <bridge@lists.linux.dev>; Wed, 30 Sep 2026 00:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1790752511; x=1791357311; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WfaeNk+TbvRqojZcx8T2YQ1WiNBIMIQG8iQ0MxbUCt8=;
        b=MeR+bwcyMN58K1Xvm7HycGFme8Pl0MZpZ2PPPUfdAII6CzTZhDaKB2XkGQ0lSlpfgk
         y8Bv0wo6IWWoQyJS8lga23ClLHX1XaXqzJZPovJVd8k4ChWIU2ee559Ziqi6ordiCEVI
         5z88RhPnoXy8CHSjwNSfMVPdh0QemHIncz6+Pg+odryoz5b5ieFO0meko82sS/uNFKM8
         tlcbfllgRrH24XyMemhgjBPGsYMpeGdyQ501fioVkWMXjaxn1AlT6Mjc2Vp/TPVAuW/B
         px2YnCFjrJec+VUGZXB/nF/7wPc65K4vm323fTnc4kzH/JctxDdiAD1rUKn2kBbxHMnm
         5dEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752511; x=1791357311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WfaeNk+TbvRqojZcx8T2YQ1WiNBIMIQG8iQ0MxbUCt8=;
        b=VaqfAgFGP0mn3TV0Y7tlCigWbYQR3pcEa2ccUBbt9Ye6mcidqDj57T7u2x2o0A3eZ9
         ux9+Ff/iRhQ22w4ohT6sf+Hs/XIi9gf7tDSYozklfSyU6PGGYBheILFbrOQ0/s0Km0QO
         UKK20IptsMpPtQtSjf8b3xKzzxMj9cmmPhH/HaYnl/zWlssfxcbQjPTUT53e1JD/GLb/
         AxeQBqhuaji4MrMbmmJGFwKX57A2jxgSTU1ss14NrZUgpAYTugPSHeei2pxNO+GYzrFx
         gRsaEEm/H5HKfcaiASyAfq1cD0sFzMvaowT40Esmgc2pT+em6hM+bJc6/BZO4r6bZdGG
         onEQ==
X-Forwarded-Encrypted: i=1; AKwUvBxtpf9f8rV32PWzvK9Ut9I04YL3XVT6W/ZOG5mb6NAYUtyOC+q44M6UEb6XhNw1ynNAB8/I7wc=@lists.linux.dev
X-Gm-Message-State: AFuF++n6cSWdXVpEpDCrEdJjVGURAzPc4gxFEnJHpqXJFKGVNNPSHXT4
	UV7DgND9MTfv60YnF/Z1466OHCBY43zmNOfcFysv+bIT74OmwjjKM7kmfqBsITYYhW4=
X-Gm-Gg: AYBFou1eQLzAiFKjv5Ktdly9i3T4aiMuurZWLrHXOauBrSbbUEZRxhfYUs37hY2Hp2O
	iNMlwkmC3vwKiDUtMZXT6MjhqLoKwzimS7HBaWiDUkYfQCW0o43hn2rWEBAU3IOwXZvEvsdOTtY
	Yka34er2kjOF6s4nSzI+/+5ykpreGnwUQfO5EqafQz/NLjGXBYiK9C8jBKtzq9306s5/86oxVUj
	0rWcgWnELf8vohrcC3C2xHs++vn0Ea7NuFfJ3tztAXYSOyxhqIdcX7yB1n8UAGOO+ucUrMLeJ56
	IKVqUil+ThSQv44sD2Y9ymoc8O1zzzMNcJM7PRoFN1ryyEnWRibvY8KoUOZNaxhCqfK7WGxnx6E
	3yYcHhfGB6BLfjrAWB4y8+BUNigO4pGueWiqdczlQChoEJIUYXve0bbc8DqbBjEk5LfZtbWn1Xg
	fwf+OLXD0q9pQ6PkcLNlUnwD91vRSL5ugC1s2SxjRUgDNUJffnSpd0DPvz0utSDWKTszKaYoC0D
	0wwJ8NCQ0pNqBJRI1oY
X-Received: by 2002:a05:600c:c162:b0:49e:6778:c2bd with SMTP id 5b1f17b1804b1-4a01afe1e88mr6149585e9.6.1790752510711;
        Wed, 30 Sep 2026 00:15:10 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a017b67813sm18251115e9.2.2026.09.30.00.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:15:09 -0700 (PDT)
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
Subject: [PATCH net-next 08/12] net: bridge: vlan: quiesce readers before freeing port VLANs
Date: Wed, 30 Sep 2026 10:14:07 +0300
Message-ID: <20260930071411.2786201-9-razor@blackwall.org>
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

Later fdb entries will cache port-VLAN pointers so unpublish a VLAN, wait
for a grace period (existing readers) and then purge or rewrite fdb
references before releasing it. Cached destinations can continue forwarding
until they are cleaned, that is acceptable so add a comment to document it.
During port teardown unpublish the complete VLAN group first, clean the
port fdbs and then release the VLANs. This lets all VLANs share one grace
period.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_fdb.c     | 20 ++++++++++++++++----
 net/bridge/br_if.c      |  7 +++++--
 net/bridge/br_private.h | 12 ++++++++++--
 net/bridge/br_vlan.c    | 21 +++++++++++++++------
 4 files changed, 46 insertions(+), 14 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 7c68b540b358..307f9c12914e 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -883,7 +883,9 @@ void br_fdb_cleanup_by_dst(struct net_bridge *br,
 
 	spin_lock_bh(&br->hash_lock);
 	hlist_for_each_entry_safe(f, tmp, &br->fdb_list, fdb_node) {
-		if (br_fdb_dst_port(f) != p)
+		struct net_bridge_dst dst = br_fdb_dst_read(f);
+
+		if (br_dst_port(dst) != p)
 			continue;
 
 		if (vlan && f->key.vlan_id == vlan->vid &&
@@ -894,12 +896,22 @@ void br_fdb_cleanup_by_dst(struct net_bridge *br,
 			continue;
 		}
 
-		if (!do_all)
+		if (!do_all) {
+			if (vid && f->key.vlan_id != vid)
+				continue;
+
 			if (test_bit(BR_FDB_STATIC, &f->flags) ||
 			    (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &f->flags) &&
-			     !test_bit(BR_FDB_OFFLOADED, &f->flags)) ||
-			    (vid && f->key.vlan_id != vid))
+			     !test_bit(BR_FDB_OFFLOADED, &f->flags))) {
+				/* The entry outlives the VLAN, so it must fall
+				 * back to the raw port destination
+				 */
+				if (vlan && br_dst_vlan(dst) == vlan)
+					br_fdb_dst_write(f,
+							 br_port_to_dst(p));
 				continue;
+			}
+		}
 
 		if (test_bit(BR_FDB_LOCAL, &f->flags))
 			fdb_delete_local(br, p, f);
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index d94558a5e3e9..2c05ebc1299d 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -333,8 +333,9 @@ static void update_headroom(struct net_bridge *br, int new_hr)
  */
 static void del_nbp(struct net_bridge_port *p)
 {
-	struct net_bridge *br = p->br;
+	struct net_bridge_vlan_group *vg;
 	struct net_device *dev = p->dev;
+	struct net_bridge *br = p->br;
 
 	sysfs_remove_link(br->ifobj, p->dev->name);
 
@@ -354,8 +355,10 @@ static void del_nbp(struct net_bridge_port *p)
 		update_headroom(br, get_max_headroom(br));
 	netdev_reset_rx_headroom(dev);
 
-	nbp_vlan_flush(p);
+	vg = nbp_vlan_group(p);
+	nbp_vlan_group_unpublish(p);
 	br_fdb_cleanup_by_dst(br, br_port_to_dst(p), 0, 1);
+	nbp_vlan_flush(p, vg);
 	switchdev_deferred_process();
 	nbp_backup_clear(p);
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index a790368b69e9..951b6ac5f484 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1735,7 +1735,9 @@ int __br_vlan_set_default_pvid(struct net_bridge *br, u16 pvid,
 int nbp_vlan_add(struct net_bridge_port *port, u16 vid, u16 flags,
 		 bool *changed, struct netlink_ext_ack *extack);
 int nbp_vlan_delete(struct net_bridge_port *port, u16 vid);
-void nbp_vlan_flush(struct net_bridge_port *port);
+void nbp_vlan_group_unpublish(struct net_bridge_port *port);
+void nbp_vlan_flush(struct net_bridge_port *port,
+		    struct net_bridge_vlan_group *vg);
 int nbp_vlan_init(struct net_bridge_port *port, struct netlink_ext_ack *extack);
 int nbp_get_num_vlan_infos(struct net_bridge_port *p, u32 filter_mask);
 void br_vlan_get_stats(const struct net_bridge_vlan *v,
@@ -1894,7 +1896,13 @@ static inline int nbp_vlan_delete(struct net_bridge_port *port, u16 vid)
 	return -EOPNOTSUPP;
 }
 
-static inline void nbp_vlan_flush(struct net_bridge_port *port)
+static inline void nbp_vlan_group_unpublish(struct net_bridge_port *port)
+{
+}
+
+static inline void
+nbp_vlan_flush(struct net_bridge_port *port,
+	       struct net_bridge_vlan_group *vg)
 {
 }
 
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 8a914e249767..0675f74cf1b9 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1406,23 +1406,32 @@ int nbp_vlan_delete(struct net_bridge_port *port, u16 vid)
 	v = br_vlan_find(vg, vid);
 	if (!v)
 		return -ENOENT;
-	br_fdb_cleanup_by_dst(port->br, br_vlan_to_dst(v), vid, 0);
 	__vlan_unpublish(vg, v);
+	synchronize_net();
+	/* Traffic may still use v through cached fdb dsts until they are
+	 * cleaned below. This is acceptable during vlan deletion. Above we
+	 * drain the readers that could republish the dst before cleaning it
+	 */
+	br_fdb_cleanup_by_dst(port->br, br_vlan_to_dst(v), vid, 0);
 	__vlan_del(vg, v);
 
 	return 0;
 }
 
-void nbp_vlan_flush(struct net_bridge_port *port)
+void nbp_vlan_group_unpublish(struct net_bridge_port *port)
 {
-	struct net_bridge_vlan_group *vg;
-
 	ASSERT_RTNL();
 
-	vg = nbp_vlan_group(port);
-	__vlan_flush(port->br, port, vg);
 	RCU_INIT_POINTER(port->vlgrp, NULL);
 	synchronize_net();
+}
+
+void nbp_vlan_flush(struct net_bridge_port *port,
+		    struct net_bridge_vlan_group *vg)
+{
+	ASSERT_RTNL();
+
+	__vlan_flush(port->br, port, vg);
 	__vlan_group_free(vg);
 }
 
-- 
2.47.3

