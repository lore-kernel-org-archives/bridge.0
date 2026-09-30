Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F8444F55C
	for <bridge@lists.linux.dev>; Wed, 30 Sep 2026 07:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752515; cv=none; b=uWg9uBOYeDGvTxyKtrGV8K6yh0u+rpxU/2pk0wxzuS9QbmOuc0x2rxNQ1ZZTVhbNgIrnbKxZMZ8VdvsaYIbpk0I10YiFZPXkDBBxm8Df4uCUqw/6QYV9lyfk1m41xecWY+Wa5uyEccStp0yBxUgZtG9V4+o9fRu+M2OTFbWlhws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752515; c=relaxed/simple;
	bh=7BtmL/J/xqiZYFCYwVh4qlSlNr3nP7akGSHJE8asqxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UA/NmYUXQAM9YN/czn4+CnsnZiAgAOuH9l5wEFROaQBvy5Bz2Sqs15SzKcP8jjTwUuqWAqNGKDC+nBEt2bYSUEi3456yfe8d6pJTwlk3te6GaWfODBdDayCf/f7LQe3RJtW2ENv3/fH1/SrPATp9jquJMRTvtF0qCuY7abxEN4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=ljnr3X9V; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="ljnr3X9V"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffe281cb1so24334215e9.1
        for <bridge@lists.linux.dev>; Wed, 30 Sep 2026 00:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1790752505; x=1791357305; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TzGeIiBvK9svEo9nqmM7pKUiwQRA9WD5WaK0fC8sXGE=;
        b=ljnr3X9VOn4IwWgd+wgKWpnuFGsOxCkW1Yz9TwSag35iNMfIzBBAp34qutSGZgQeXT
         hyBcu4qPSxSvMZkoN6SpbNnEaDwlc0yuakJeUSIr0+R2VR7x7FQBRFRjfR3Kv5ylV2y1
         BgP/3nLYWGZr34LjoAIQyPkpMp+seufHHiXTvNDBxcn7QVukiKIRyINnLB5p+bMcTWDZ
         Mp+An2iHjTULc7mrU+BJhOFuayupu64IB9MYlFib5cR46+JZ5gQDTNCOhebTX1RS2/7h
         xN7jpZz5R8Ip4ulp9DOkstt5iBIf+sjAL8wWIyioZHp/dMnOInHNAflGXZvLR10HcN08
         gX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752505; x=1791357305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TzGeIiBvK9svEo9nqmM7pKUiwQRA9WD5WaK0fC8sXGE=;
        b=wgfMGyEsYS7DnBvR+xBXNuIZXpia23PvdnEL4VnFZE8H3GWvGLdGQQUC26gY5TE/er
         avDvS1w8e7xHglYi1rNWndQAIQIcWTtV0kt+GyTMGOUhuGPgmGF455VnpQn/KZrvYJuV
         cwfwsPUniVfVJsMDK/BXtwQD44RNwrCJJ/7Vfixu6pjM8uoVUxvKkDyN1UGTpZ1YGGUX
         D8q24IB6SOSJnUJlxl3YJc9TYaEkBBQ19sNk+J7liKg+1FdS/MXtgMYRAqOnlTVr1PH+
         pGeXL2nWZidKTSg0xhH6LV90oQi5LJXFDaBQH0sXD59BbBDyfByZxd3m0Kcd7HqLXCQ1
         6aaA==
X-Forwarded-Encrypted: i=1; AKwUvBxrv+mHWsyM8gi0g1H+XsBAN7R5wJgeeMzmsY4n+pT9JnDbKMO+2xY1E12rcF2CzDJBTNq5BOw=@lists.linux.dev
X-Gm-Message-State: AFuF++mnzs7XDjz2lbtlx1590brCppQigxIjgafyYJbWt5h07iknWoNi
	+0UaTnAq5PvuOxQpHzOpXeoFfpIwk2rEYZnSWutydvx3ru69O0Es6OcVsP6DfBwzvMo=
X-Gm-Gg: AYBFou0MbsX6mz5663mWIAoQZ28aSrv4jd3LalnsUhgs66xbVTu7HHY+3c8Xjg2NMUI
	pKH9Y0KNAAse8CvQzjThNBX7ltazcuAodighAaBQNEVNUKnBdxgkIcdNR0bakfT2Hi+ME5r3RMh
	uuwnQxW759lcqL2Ap6byLBwJy7aeU8oFxxHN4V0RRSEDQFW9WLYPzlW1PYdU+vAuAbzCRxVmEkf
	IRUBfmDimYK0TX3CqNkBMju5BzV9uXUNqc8yeKaEyK5OP9qsx1H3SA6N+wwUMCGlRTCDYvgoxKA
	+njzSi98t63NFWnlk3/Ob5U2pgndmkNLmjo1Pgf3EsYDAtUqMx/8YrxiH7NEt+j0iREc1PyaElc
	y2vN982TQ8QXHnjfPjvKTpPcx/r5A88fKW4mH3cKRIm8GdY8BOxSq2jVM+xAcaqITkJAfxc9t9/
	p9N5EAFBWcHHj8hYVDup27RpiX5RntrncG+HTrbwMhzpLE6bFpInQYmxgf2jj1W/oL/Is4ybF+U
	Iqn173/vx4lkrzxBvtKPJJPO6Z3XoA=
X-Received: by 2002:a05:600c:354f:b0:49d:2536:402e with SMTP id 5b1f17b1804b1-4a01b11a05cmr5865365e9.30.1790752505252;
        Wed, 30 Sep 2026 00:15:05 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48b029be71csm1358855f8f.9.2026.09.30.00.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:15:04 -0700 (PDT)
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
Subject: [PATCH net-next 05/12] net: bridge: fdb: pass VLAN entries to learning updates
Date: Wed, 30 Sep 2026 10:14:04 +0300
Message-ID: <20260930071411.2786201-6-razor@blackwall.org>
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

Pass the resolved VLAN entry through fdb learning paths and derive the vid
inside br_fdb_update(). The fdb destination remains a port for now, this is
a preparation for caching the VLAN.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_fdb.c     | 16 ++++++++++------
 net/bridge/br_input.c   | 12 ++++++------
 net/bridge/br_private.h |  3 ++-
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 0f5cf5615b56..9cd6deae8635 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -974,9 +974,11 @@ static bool __fdb_mark_active(struct net_bridge_fdb_entry *fdb)
 }
 
 void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
-		   const unsigned char *addr, u16 vid, unsigned long flags)
+		   struct net_bridge_vlan *vlan, const unsigned char *addr,
+		   unsigned long flags)
 {
 	struct net_bridge_fdb_entry *fdb;
+	u16 vid = vlan ? vlan->vid : 0;
 
 	/* some users want to always flood. */
 	if (hold_time(br) == 0)
@@ -1247,9 +1249,11 @@ static int fdb_add_entry(struct net_bridge *br, struct net_bridge_port *source,
 
 static int __br_fdb_add(struct ndmsg *ndm, struct net_bridge *br,
 			struct net_bridge_port *p, const unsigned char *addr,
-			u16 nlh_flags, u16 vid, struct nlattr *nfea_tb[],
+			u16 nlh_flags, struct net_bridge_vlan *vlan,
+			struct nlattr *nfea_tb[],
 			bool *notified, struct netlink_ext_ack *extack)
 {
+	u16 vid = vlan ? vlan->vid : 0;
 	int err = 0;
 
 	if (ndm->ndm_flags & NTF_USE) {
@@ -1263,7 +1267,7 @@ static int __br_fdb_add(struct ndmsg *ndm, struct net_bridge *br,
 
 		local_bh_disable();
 		rcu_read_lock();
-		br_fdb_update(br, p, addr, vid, BIT(BR_FDB_ADDED_BY_USER));
+		br_fdb_update(br, p, vlan, addr, BIT(BR_FDB_ADDED_BY_USER));
 		rcu_read_unlock();
 		local_bh_enable();
 	} else if (ndm->ndm_flags & NTF_EXT_LEARNED) {
@@ -1355,10 +1359,10 @@ int br_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 		}
 
 		/* VID was specified, so use it. */
-		err = __br_fdb_add(ndm, br, p, addr, nlh_flags, vid, nfea_tb,
+		err = __br_fdb_add(ndm, br, p, addr, nlh_flags, v, nfea_tb,
 				   notified, extack);
 	} else {
-		err = __br_fdb_add(ndm, br, p, addr, nlh_flags, 0, nfea_tb,
+		err = __br_fdb_add(ndm, br, p, addr, nlh_flags, NULL, nfea_tb,
 				   notified, extack);
 		if (err || !vg || !vg->num_vlans)
 			goto out;
@@ -1370,7 +1374,7 @@ int br_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 		list_for_each_entry(v, &vg->vlan_list, vlist) {
 			if (!br_vlan_should_use(v))
 				continue;
-			err = __br_fdb_add(ndm, br, p, addr, nlh_flags, v->vid,
+			err = __br_fdb_add(ndm, br, p, addr, nlh_flags, v,
 					   nfea_tb, notified, extack);
 			if (err)
 				goto out;
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index d9a0e1f65ec9..44a217d65e7f 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -121,8 +121,9 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 			 * and drop the packet.
 			 */
 			if (test_bit(BR_PORT_MAB_BIT, &p->flags))
-				br_fdb_update(br, p, eth_hdr(skb)->h_source,
-					      vid, BIT(BR_FDB_LOCKED));
+				br_fdb_update(br, p, vlan,
+					      eth_hdr(skb)->h_source,
+					      BIT(BR_FDB_LOCKED));
 			goto drop;
 		} else if (br_fdb_dst_port(fdb_src) != p ||
 			   test_bit(BR_FDB_LOCAL, &fdb_src->flags)) {
@@ -132,7 +133,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 			/* FDB match, but entry is locked. Refresh it and drop
 			 * the packet.
 			 */
-			br_fdb_update(br, p, eth_hdr(skb)->h_source, vid,
+			br_fdb_update(br, p, vlan, eth_hdr(skb)->h_source,
 				      BIT(BR_FDB_LOCKED));
 			goto drop;
 		}
@@ -142,7 +143,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 
 	/* insert into forwarding database after filtering to avoid spoofing */
 	if (test_bit(BR_LEARNING_BIT, &p->flags))
-		br_fdb_update(br, p, eth_hdr(skb)->h_source, vid, 0);
+		br_fdb_update(br, p, vlan, eth_hdr(skb)->h_source, 0);
 
 	promisc = !!(br->dev->flags & IFF_PROMISC);
 	local_rcv = promisc;
@@ -253,8 +254,7 @@ static void __br_handle_local_finish(struct sk_buff *skb)
 	    nbp_state_should_learn(p) &&
 	    !br_opt_get(p->br, BROPT_NO_LL_LEARN) &&
 	    br_should_learn(p, skb, &vlan))
-		br_fdb_update(p->br, p, eth_hdr(skb)->h_source,
-			      vlan ? vlan->vid : 0, 0);
+		br_fdb_update(p->br, p, vlan, eth_hdr(skb)->h_source, 0);
 }
 
 /* note: already called with rcu_read_lock */
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 34e95741b940..058cc082311a 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -993,7 +993,8 @@ int br_fdb_fillbuf(struct net_bridge *br, void *buf, unsigned long count,
 int br_fdb_add_local(struct net_bridge *br, struct net_bridge_port *source,
 		     const unsigned char *addr, u16 vid);
 void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
-		   const unsigned char *addr, u16 vid, unsigned long flags);
+		   struct net_bridge_vlan *vlan, const unsigned char *addr,
+		   unsigned long flags);
 
 int br_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
 		  struct net_device *dev, const unsigned char *addr, u16 vid,
-- 
2.47.3

