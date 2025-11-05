Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C7530F95C
	for <bridge@lists.linux.dev>; Wed,  5 Nov 2025 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762341615; cv=none; b=Yx9dL1kmyfi9LAIppbNs95HMLSPtQKu+vDq0AKbJBhlcHC0hTqaZ4HTsF52lRem5qd20ZbCinMb0Nfi9/pLv/lqBh2gBCEM5LxkqZy7RK7R0hViNvcGi/CiAVpteakkMfVH8s0L0k4n3AW4ovdli1EM2bx04ck5aE/uf+8cLqAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762341615; c=relaxed/simple;
	bh=a401LttyQ75fGtqxWKsOWl7Pv3QSIHLvklmCC6Xv5E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rrvvOuz/ZgryBt3NpmZFCfw1trR1ndzAqt0Aabgr890se1IetDAhaLb42ciqsAeIs74m/M9/nE2Ae6I2JhHZlYZJ739MetcjNkjiX96yfw38EZys3GhcnXeILy7zGA0WztMgUNFfgWOP2IBIqwzR3nl42d58GC83lIRjxp4Gk+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Q9k0qdZj; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Q9k0qdZj"
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-64080ccf749so8851828a12.2
        for <bridge@lists.linux.dev>; Wed, 05 Nov 2025 03:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1762341612; x=1762946412; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXuQLmFLJRmL3IxiXo4AbgeD2yxAF5Mj/ARWDStmAfA=;
        b=Q9k0qdZjK/YdBTCuq9YdEwmO5YZ3PWnZEDVxKI3m61lbWWfRVDfW+FEHTtV5hDrO9R
         yjj5jc0gpvPLkAiK8FbCQZzBu64xw/DrTILbll+GPk3YSCwHigE28QRlfJcJBRoJMjnH
         8FIXluH4opNvTMMk6VjWC9ZvSsGwdaWaaQIrLjrQ+eCDbn6AtxDPZsZpRiEyDSr+pGhb
         6+/7RAg7H8oQWxf+2sXCCJxl5uiHmtZM6SUqNKjIS2tNhItphqpI0bEuinpiqmvMxp0V
         ZvwUeq86Tw3aUHudtmp0uwSoCay18yAqpATxsRsCZ+ddRPUF9CtoKUTySkxBjPLfTHIO
         ND9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762341612; x=1762946412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXuQLmFLJRmL3IxiXo4AbgeD2yxAF5Mj/ARWDStmAfA=;
        b=H08pxqiQ4CEMyX5vx4hFTu4ck6r+EFCjv03WuiH3oGOmA6juyJ4EZ3aLcXKBx/1Xce
         9reTeYMCI3iYXLSJt34GbIEPRGyPHJe2RdoQ7n4/TKrr/213tp57Gm/zkiTkQwaDiP9a
         EynDV3IAhkd/u/6ZYWhQPrYce9NBhDNNeGLNGpa8zEYryODBQxgUXt8MtKTvi4uC0gfL
         Y3S8UI4X6VDJFEs9tH8MmqRucFKz1cpQNfw2CFDCaCwrLyB/Gt72umI6AX/6+Jx1CA8z
         SqUjNiIb9spsaUY7nz+PDqyHakbTT+03S3YmI3NnbDmjDwBGRyCAk4NZudhKL35kPXFa
         6kNw==
X-Forwarded-Encrypted: i=1; AJvYcCXhlCauD/ONxnnMehSYV6RdGih9YoCENokND4dOB4RPvYWhKhx7LOhGfRWzGbRUB6jkceJcE88=@lists.linux.dev
X-Gm-Message-State: AOJu0YyzKlh2osT8ibCdxf+RZgvZlrmOXIa1EqRgOBbyfYqUHMNtPLtZ
	aIfLHc9aFjdT8134s53FVISx1NTirSaZVypoiWzR25ZLl2McP5Ir+fbkJAn/Uh4R7Ic=
X-Gm-Gg: ASbGncsEhll3BJhyF4/TXd/0Y4En/rEUrZ6v6lFAscbJUBqGbDW0uCtd3vyms2P8axF
	A/SI9TIpy99tbhRN0AD8bDBfUBkuxRqGTrYXPr1QYBsyspy2BuQxyo9uP1UJoN2JGAI+a8R1hj2
	1aYtPiJLI8AD8na8YwtPGE+bUcOzNvjn0mzm20qXVkiOtBkuyIosqPNdynpzw+19AUnwT9NnAWp
	opbftyj4tkCwAJQhv+L2KwTuB0GY9jAaX/45AZkqa7gzK5/WcmFMZXojvBsSWaA5cRwfNAfWnZx
	z/wGWZo2hlFl1851QpIqcVOdIaLtiQF52nxl3rZp405p486Cv8yCaWbD/7GZuKnc5SCLyfwTCEn
	kxU40ksGcClGTS/KDlJ8nWsgQYxX7TK2hXvxO2qwtHmstNQzh6f05NpyLtdv6gwR1I0z/L4KBB2
	J4BC1xj7oPNIA/xmV6z9NFBlsAsyW3SrVAhg==
X-Google-Smtp-Source: AGHT+IHTjDVCx2Qm0j6PAJKMcvlD9wlV3gnSH90GhrBjX1D3t7o2Y5SBx2BDZbWvHZ8eBLNWGGFQqg==
X-Received: by 2002:a17:907:97d4:b0:b70:edaf:4ee5 with SMTP id a640c23a62f3a-b7265297d83mr264651266b.16.1762341612063;
        Wed, 05 Nov 2025 03:20:12 -0800 (PST)
Received: from debil.nvidia.com (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b724064d25csm455208266b.72.2025.11.05.03.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 03:20:11 -0800 (PST)
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
	petrm@nvidia.com,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net v2 2/2] net: bridge: fix MST static key usage
Date: Wed,  5 Nov 2025 13:19:19 +0200
Message-ID: <20251105111919.1499702-3-razor@blackwall.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105111919.1499702-1-razor@blackwall.org>
References: <20251105111919.1499702-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Ido pointed out, the static key usage in MST is buggy and should use
inc/dec instead of enable/disable because we can have multiple bridges
with MST enabled which means a single bridge can disable MST for all.
Use static_branch_inc/dec to avoid that. When destroying a bridge decrement
the key if MST was enabled.

Fixes: ec7328b59176 ("net: bridge: mst: Multiple Spanning Tree (MST) mode")
Reported-by: Ido Schimmel <idosch@nvidia.com>
Closes: https://lore.kernel.org/netdev/20251104120313.1306566-1-razor@blackwall.org/T/#m6888d87658f94ed1725433940f4f4ebb00b5a68b
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
v2: new fix

 net/bridge/br_if.c      |  1 +
 net/bridge/br_mst.c     | 10 ++++++++--
 net/bridge/br_private.h |  5 +++++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 98c5b9c3145f..ca3a637d7cca 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -386,6 +386,7 @@ void br_dev_delete(struct net_device *dev, struct list_head *head)
 		del_nbp(p);
 	}
 
+	br_mst_uninit(br);
 	br_recalculate_neigh_suppress_enabled(br);
 
 	br_fdb_delete_by_port(br, NULL, 0, 1);
diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index 3f24b4ee49c2..43a300ae6bfa 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -22,6 +22,12 @@ bool br_mst_enabled(const struct net_device *dev)
 }
 EXPORT_SYMBOL_GPL(br_mst_enabled);
 
+void br_mst_uninit(struct net_bridge *br)
+{
+	if (br_opt_get(br, BROPT_MST_ENABLED))
+		static_branch_dec(&br_mst_used);
+}
+
 int br_mst_get_info(const struct net_device *dev, u16 msti, unsigned long *vids)
 {
 	const struct net_bridge_vlan_group *vg;
@@ -225,9 +231,9 @@ int br_mst_set_enabled(struct net_bridge *br, bool on,
 		return err;
 
 	if (on)
-		static_branch_enable(&br_mst_used);
+		static_branch_inc(&br_mst_used);
 	else
-		static_branch_disable(&br_mst_used);
+		static_branch_dec(&br_mst_used);
 
 	br_opt_toggle(br, BROPT_MST_ENABLED, on);
 	return 0;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index b571d6f61389..7280c4e9305f 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1954,6 +1954,7 @@ int br_mst_fill_info(struct sk_buff *skb,
 		     const struct net_bridge_vlan_group *vg);
 int br_mst_process(struct net_bridge_port *p, const struct nlattr *mst_attr,
 		   struct netlink_ext_ack *extack);
+void br_mst_uninit(struct net_bridge *br);
 #else
 static inline bool br_mst_is_enabled(const struct net_bridge_port *p)
 {
@@ -1989,6 +1990,10 @@ static inline int br_mst_process(struct net_bridge_port *p,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline void br_mst_uninit(struct net_bridge *br)
+{
+}
 #endif
 
 struct nf_br_ops {
-- 
2.51.0

