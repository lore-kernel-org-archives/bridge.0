Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61324248D2
	for <bridge@lists.linux.dev>; Wed, 30 Sep 2026 07:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752517; cv=none; b=NFvX51p699wKUL6RoGTG5yQdWBeBabCDi2k6WhXoQHgX1rsonm3PFI3OYcqH3BQWYRvCeZCM1OhhfIFpsmzNrxV3kxVAIG61bat85R8RroJd3R3i2cgdAvSw/B8U/Ujp/GgtZMCd8Fu/XOymv+i/RVkt3h0pW8rFrZsjgr1usCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752517; c=relaxed/simple;
	bh=Y1qxWBeZsMfTJrDUxMtxtXHqC26bAWa8yrkGRtYTOFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABXbAyqDw8H8uWIFLHoq1JZp1zwqj+zd7TFVRQl4wN34Ukh8SQ+sajElV5g83VjdK+jXY9oBR9g9Vyhi+wXM8I5p80TWzOkhc8BjsIV0QngwVywM3qOcg/w40wZigM4UwU2OCB82qoeF0HsS6FkTLnwN/c/rN9+AoVf2x9uhv0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=ZTUoOHFp; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="ZTUoOHFp"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48b017a3be3so254690f8f.2
        for <bridge@lists.linux.dev>; Wed, 30 Sep 2026 00:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1790752507; x=1791357307; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aHa5GVMDBQS3tgSHpEswPAMXyZTffMhhlGqGIpxHauA=;
        b=ZTUoOHFpTJUEWL5kiw2FPnoCllLYWf6l16Ze3yaACVPQfy2X83NbpKV42ieZUvtFBl
         m5rs/8xk8H61GDS+AXVDAh5uY0NCaj68w5XYtO/UYtHAcWOgSNQzWY6TcaGjyKDZZ2Va
         936MQCxg2wPJYrw5MmmM82h5ndVmzVgoNMSbhQ9U3LyefCREbADpF8QvQ8KwPKFikXd5
         6UK46R171NBFTAW5HZSHVJYIRgZpkPxDF/PCAOqfjeFA6yCYrc48vyRcSnYO76FPoxBG
         HX0MquRjhmc9efJX7K6iqTo7Oamvuk5Syvw3LPVMDphwjp8swXI95YgV4PFnhF8zq0m7
         wedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752507; x=1791357307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aHa5GVMDBQS3tgSHpEswPAMXyZTffMhhlGqGIpxHauA=;
        b=Z19kfo/AESdOAyuQSJgitAgDKI1yg0ZsAtZSDBiFuQ7AYtVLIU+mjY5iP3448bdhUf
         SB3Mkrn4KCBA6hHkhLXDVRY/25D6sSkCa9wRDSHgoD1wN3fWLpC9nxNOnGqUCHDjZV9E
         wAudh5ByMtqp9BnNNLQQm0MeW/yI6hIvcD81FJv28BjAG6dLkxLaRYy/IBFlDUWwtaYS
         FKAonf+oPuCmlg8870cx2CTWLjblMcG/JhL6J6/V4IX3Gn8Di+BgFaGEqUdOtYkmxpKs
         U5WYSu2DTUaLNpxPyzeYamDhYGkb1womQ60ogeb/yAwppeiiQ/kVfCoV6IebR0Ux5EQM
         VgJw==
X-Forwarded-Encrypted: i=1; AKwUvBy+KscONdmbHZ0bDnRBrEitJ6gF1BBFKjWfi/G04EZzvNyki/+XjdD6cUUD8S5Z+5u4ui/rj9U=@lists.linux.dev
X-Gm-Message-State: AFq9FYLHH90Bf12nGbGhKf2qXj+go0E9xwW3qIuoaFXc4LOWgx4nN36T
	snhP7f4BVAwZWLeGt4MRaUO00N7lcHd2GXw1kF6oR7CgyHYt+i2MvZXQ8Kyouf7N2eY=
X-Gm-Gg: AYBFou0mmmYHNt00Dmm6ZumgagQ4hCjwBnTDT9sQoPQM9FAHao1H4GQdWFxQvgBhUhh
	6pC5STfQ4ShsIkpw5yLfBgEWzDQYW7boPGpdN0adXujdz5cQoe+qXxUfouMHI/haIjGsvackvKe
	AwOydwFAZSxDzvvqXOZ5SdZoFG3z166X9ObXJARo9+5RgkBGi74+ueWtUibBOjNfSNb9mpQE0w8
	jhN+aRH9TS1l8rrWMwYLuW+HrmlqJZDUx6SSAXvczFsQ9HFzUWPNUugjgJJCPTcMAXkyOMaD4zS
	Zd3KdgsM12VxF9t6shUTpr3HB2Cl+bmnE1Fs5tOA79wlmB3j79muVaO4dbvZ+qPNzFbPc2lAo0H
	EBk4LR4hbrGphPS9RcCuxG5/4B0BCTyMgYwRcffqFuMjNoZb8TDIGO+k/f9gzwnrTs5JQWaQ8R6
	sXQl7UGCCTFjbfU+VAmwyukFglQ/MQKvhKUETt0huyyxu684Iz0SAKN6jfu/GH4y1q/BR6HU+N0
	dAURFU0W9BTHmOl859G
X-Received: by 2002:a05:6000:40ca:b0:48b:108:48cf with SMTP id ffacd0b85a97d-48b024d71acmr1012459f8f.25.1790752506765;
        Wed, 30 Sep 2026 00:15:06 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48b029f2b0dsm1151871f8f.25.2026.09.30.00.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:15:06 -0700 (PDT)
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
Subject: [PATCH net-next 06/12] net: bridge: fdb: consolidate port-VLAN cleanup
Date: Wed, 30 Sep 2026 10:14:05 +0300
Message-ID: <20260930071411.2786201-7-razor@blackwall.org>
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

Deleting a port-VLAN currently takes the hash_lock twice and performs two
fdb ops. The first removes its automatically generated local entry and the
second deletes dynamic entries associated with the port and vid. Rename
br_fdb_delete_by_port() to br_fdb_cleanup_by_dst() and pass a bridge dst so
it can distinguish a port-VLAN from a raw port. This allows both operations
to be done during the same locked fdb walk.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br.c          |  2 +-
 net/bridge/br_fdb.c      | 17 +++++++++++++----
 net/bridge/br_if.c       |  6 +++---
 net/bridge/br_netlink.c  |  2 +-
 net/bridge/br_private.h  |  4 ++--
 net/bridge/br_stp_if.c   |  2 +-
 net/bridge/br_sysfs_if.c |  3 ++-
 net/bridge/br_vlan.c     |  5 ++---
 8 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/net/bridge/br.c b/net/bridge/br.c
index 09a120b3b76c..b1abe1c5bbdd 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -202,7 +202,7 @@ static int br_switchdev_event(struct notifier_block *unused,
 	case SWITCHDEV_FDB_FLUSH_TO_BRIDGE:
 		fdb_info = ptr;
 		/* Don't delete static entries */
-		br_fdb_delete_by_port(br, p, fdb_info->vid, 0);
+		br_fdb_cleanup_by_dst(br, br_port_to_dst(p), fdb_info->vid, 0);
 		break;
 	}
 
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 9cd6deae8635..7c68b540b358 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -868,15 +868,16 @@ int br_fdb_delete_bulk(struct nlmsghdr *nlh, struct net_device *dev,
 	return 0;
 }
 
-/* Flush all entries referring to a specific port.
+/* Clean up all entries referring to a specific destination.
  * if do_all is set also flush static entries
  * if vid is set delete all entries that match the vlan_id
  */
-void br_fdb_delete_by_port(struct net_bridge *br,
-			   const struct net_bridge_port *p,
-			   u16 vid,
+void br_fdb_cleanup_by_dst(struct net_bridge *br,
+			   struct net_bridge_dst cleanup_dst, u16 vid,
 			   int do_all)
 {
+	const struct net_bridge_vlan *vlan = br_dst_vlan(cleanup_dst);
+	const struct net_bridge_port *p = br_dst_port(cleanup_dst);
 	struct net_bridge_fdb_entry *f;
 	struct hlist_node *tmp;
 
@@ -885,6 +886,14 @@ void br_fdb_delete_by_port(struct net_bridge *br,
 		if (br_fdb_dst_port(f) != p)
 			continue;
 
+		if (vlan && f->key.vlan_id == vlan->vid &&
+		    test_bit(BR_FDB_LOCAL, &f->flags) &&
+		    !test_bit(BR_FDB_ADDED_BY_USER, &f->flags) &&
+		    ether_addr_equal(f->key.addr.addr, p->dev->dev_addr)) {
+			fdb_delete_local(br, p, f);
+			continue;
+		}
+
 		if (!do_all)
 			if (test_bit(BR_FDB_STATIC, &f->flags) ||
 			    (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &f->flags) &&
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index c52613431f88..d94558a5e3e9 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -355,7 +355,7 @@ static void del_nbp(struct net_bridge_port *p)
 	netdev_reset_rx_headroom(dev);
 
 	nbp_vlan_flush(p);
-	br_fdb_delete_by_port(br, p, 0, 1);
+	br_fdb_cleanup_by_dst(br, br_port_to_dst(p), 0, 1);
 	switchdev_deferred_process();
 	nbp_backup_clear(p);
 
@@ -390,7 +390,7 @@ void br_dev_delete(struct net_device *dev, struct list_head *head)
 	br_mst_uninit(br);
 	br_recalculate_neigh_suppress_enabled(br);
 
-	br_fdb_delete_by_port(br, NULL, 0, 1);
+	br_fdb_cleanup_by_dst(br, br_port_to_dst(NULL), 0, 1);
 
 	timer_shutdown_sync(&br->hello_timer);
 	timer_shutdown_sync(&br->topology_change_timer);
@@ -696,7 +696,7 @@ int br_add_if(struct net_bridge *br, struct net_device *dev,
 	if (fdb_synced)
 		br_fdb_unsync_static(br, p);
 	list_del_rcu(&p->list);
-	br_fdb_delete_by_port(br, p, 0, 1);
+	br_fdb_cleanup_by_dst(br, br_port_to_dst(p), 0, 1);
 	nbp_update_port_count(br);
 	netdev_upper_dev_unlink(dev, br->dev);
 err5:
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index ae76df0de05a..f65b8b6ca97c 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1044,7 +1044,7 @@ static int br_setport(struct net_bridge_port *p, struct nlattr *tb[],
 	}
 
 	if (tb[IFLA_BRPORT_FLUSH])
-		br_fdb_delete_by_port(p->br, p, 0, 0);
+		br_fdb_cleanup_by_dst(p->br, br_port_to_dst(p), 0, 0);
 
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
 	if (tb[IFLA_BRPORT_MULTICAST_ROUTER]) {
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 058cc082311a..a790368b69e9 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -983,8 +983,8 @@ void br_fdb_change_mac_address(struct net_bridge *br, const u8 *newaddr);
 void br_fdb_cleanup(struct work_struct *work);
 int br_fdb_toggle_local_vlan_0(struct net_bridge *br, bool on,
 			       struct netlink_ext_ack *extack);
-void br_fdb_delete_by_port(struct net_bridge *br,
-			   const struct net_bridge_port *p, u16 vid, int do_all);
+void br_fdb_cleanup_by_dst(struct net_bridge *br,
+			   struct net_bridge_dst dst, u16 vid, int do_all);
 struct net_bridge_fdb_entry *br_fdb_find_rcu(struct net_bridge *br,
 					     const unsigned char *addr,
 					     __u16 vid);
diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index a7e5422eb5d1..2e5190278c90 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -114,7 +114,7 @@ void br_stp_disable_port(struct net_bridge_port *p)
 	timer_delete(&p->hold_timer);
 
 	if (!rcu_access_pointer(p->backup_port))
-		br_fdb_delete_by_port(br, p, 0, 0);
+		br_fdb_cleanup_by_dst(br, br_port_to_dst(p), 0, 0);
 	br_multicast_disable_port(p);
 
 	br_configuration_update(br);
diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index b9bcafa7f034..621d62a063d9 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -191,7 +191,8 @@ static BRPORT_ATTR(hold_timer, 0444, show_hold_timer, NULL);
 
 static int store_flush(struct net_bridge_port *p, unsigned long v)
 {
-	br_fdb_delete_by_port(p->br, p, 0, 0); // Don't delete local entry
+	/* Don't delete local entry */
+	br_fdb_cleanup_by_dst(p->br, br_port_to_dst(p), 0, 0);
 	return 0;
 }
 static BRPORT_ATTR(flush, 0200, NULL, store_flush);
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 471b4e7f0571..7ba6e57b18fa 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -870,7 +870,7 @@ int br_vlan_delete(struct net_bridge *br, u16 vid)
 		return -ENOENT;
 
 	br_fdb_find_delete_local(br, NULL, br->dev->dev_addr, vid);
-	br_fdb_delete_by_port(br, NULL, vid, 0);
+	br_fdb_cleanup_by_dst(br, br_port_to_dst(NULL), vid, 0);
 
 	vlan_tunnel_info_del(vg, v);
 	__vlan_del(v);
@@ -1396,8 +1396,7 @@ int nbp_vlan_delete(struct net_bridge_port *port, u16 vid)
 	v = br_vlan_find(nbp_vlan_group(port), vid);
 	if (!v)
 		return -ENOENT;
-	br_fdb_find_delete_local(port->br, port, port->dev->dev_addr, vid);
-	br_fdb_delete_by_port(port->br, port, vid, 0);
+	br_fdb_cleanup_by_dst(port->br, br_vlan_to_dst(v), vid, 0);
 	__vlan_del(v);
 
 	return 0;
-- 
2.47.3

