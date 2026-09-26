Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4D62EEE8C
	for <bridge@lists.linux.dev>; Sat, 26 Sep 2026 17:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790442303; cv=none; b=GfkknBcJHSRylQLxzB1mYfDZogiTfuCoQc0DYi9IyxWVXk7B+Og3IzZEG9KUU33YOQp44LNE4XTiI260e+Gkg9kbLVnrPy9/CynSATV/Tnn2OJB7u/Dy6ZH85eawfqFcbS+79c07HK1y9kCIvDsPteSj9BmqVSH8DnPHPIoQfiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790442303; c=relaxed/simple;
	bh=Fi/1kfxh/5xJvhFsjZtyC8k+s6AHgCpHivjoRYy1j5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZR+5NX5+YlTG67mFvtZiyvEXl7CkB1YmgnMN9oLExfobRpOJkKQr/FO/zVajKn58peCnARQi1PkIeAwWR8lK5+5Zh9iUz4aXvhjWfCxmLJ04VJJzg6QPeYLAFQ2a8IXNnbNsUTIaTOUjN08zNhR+D00YPsDMcqbWHWzBwqfCZyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=YbEcqxlQ; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="YbEcqxlQ"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc79223bcfbso875095a12.1
        for <bridge@lists.linux.dev>; Sat, 26 Sep 2026 10:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790442301; x=1791047101; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w3r5hOlOFibYDjtqVxddRZ/SThl5LCtzkfgboA5uvPc=;
        b=YbEcqxlQdzU5OaeG7jT3vCKvW/oWkMNKLh8D2x/giT405tUUVw45QXHHjH1/8ckrds
         dwnmy/OWxgJdbnUG1UBJDG6JpZxce5L8H2LaCVawfcTLgTGkAPn5+XCt8qXKxExgZKn1
         osqKUOiKi4gpPsQjnWwMzEoBYcPGY7L3XGRG2rKKpJmUyHOHoEZx0Yv2U1rr7aB48qRJ
         z8IUuP6C2evAT4KvGf3SesKuBOg1LnfRuTNNEubUlCvDZeSaWTsFvZhd77+dgYtZi96L
         HS3zzPJjdGT7RIYtxIUWZCPbrF4tzIGCdiIuCG5d7Ii3Z2NBPAIUehyHqG7za2oeSEy+
         2D8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790442301; x=1791047101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w3r5hOlOFibYDjtqVxddRZ/SThl5LCtzkfgboA5uvPc=;
        b=L3IZCRFbXFPO1I8ZGicHjn5l5899Dg2xbTF4/iVaL/o7JN+jggMga3VevB1UIY/Wxa
         dNZt29MPVA/WqUItAXfX0io5EUJzeTO95419R5x9bc0HAKqpslSQ3fA9Aqv8GTYJV/eD
         tc7qM+kXJTWX7gBY10qHIA2dQk3YoB3JqC0WC5BHOahW16lJGo/zx6dAWA1jWjuIkc1T
         gQHMha/FyrTpOUO5UswS+5nAelcfMqea0PG7s+HSC6D2JULgdLFVCJPKuA44y3oQof4H
         gUaPuN33xU/9dyuB9C8q3BIgM45vGSsRrvpwxsz5A5TgdYC7MV/L76ilou34CtTVvgCp
         OM6Q==
X-Gm-Message-State: AFq9FYJ9hYMvnuPoVT/6Qidw3+VaF9bhUIK3lM8AvjFfsPhTRRynQexB
	Fz1ssG2BqKNdqDkIWo7B+yNYaZ9WPWGr896UDsmaI7MaRaoPBvfJAWRo5224ErdVcA/XaQB0zQU
	XemvtqTh2
X-Gm-Gg: AYBFou2CidX3ON+IfLyA17Y+/C8hDdk+bSjSOYlJN+T6lpXZO6eDhKiGiCahpTen/RL
	HGZ8LDN8qcMWQ16wRvBm0SelvZduqiIiCmhe4mwFIYODMuASHJdqWY9BiEXct2UoI4y4G2YWO1E
	AwZRkRXwAcEg1/ypI3hvsawlLWOuJGkr30Jb0c/apCG50wBWuqLrFo12TNnKhj8ZA9iQ3kLk9Gp
	rXd6rjEvfsezQXKoONYZA/t1AgZh4JdX5lPXFNDTOo0N2r9w9i7bbPQ+ZWH0xtya2VqLQ/ICWRu
	AQL6nmel1Nb/14u8wSxm6gNP++1AQUeo7OB2GMjCC+2gJQALtt97u8Y5mEg0sZUiQIm7+TnlUG0
	O49RMxgtpz/pPyT2PCtUOxQl17tLZe11jEStw03AqaSi9MDKmyiELfztLtcqcod7HCD9aMNQhQA
	rGwFJulug3Cful49Pxs5+CtOZuCXykDTuEEMP//b+z3EbBRdV3yuvLKo/mLU/gcnDmPR+dM3v2p
	d9q6Z2u
X-Received: by 2002:a17:90b:3c87:b0:39e:4c7e:f040 with SMTP id 98e67ed59e1d1-3a098b9e6f8mr7273421a91.29.1790442300945;
        Sat, 26 Sep 2026 10:05:00 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc78791c072sm2540444a12.15.2026.09.26.10.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 10:05:00 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: bridge@lists.linux.dev,
	netdev@vger.kernel.org
Cc: razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	petalzu987@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net 1/1] net: bridge: avoid recursive multicast port cleanup
Date: Sun, 27 Sep 2026 01:04:39 +0800
Message-ID: <22b6678adf1451f4dd5bdd34b4f5288d725dd13f.1790323012.git.petalzu987@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790323012.git.petalzu987@gmail.com>
References: <cover.1790323012.git.petalzu987@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zixuan Chai <petalzu987@gmail.com>

br_multicast_sg_del_exclude_ports() removes automatically added STAR_EXCL
port groups by calling br_multicast_del_pg(). For S,G entries, that
deletion calls back into br_multicast_sg_del_exclude_ports(), so a large
number of STAR_EXCL ports consumes one kernel stack frame per port and can
hit the stack guard page.

Keep the complete port-group deletion path for cleanup, but suppress the
S,G exclude-port cleanup while that helper is already walking the same
entry. Normal deletion callers retain the existing behavior.

Fixes: 8266a0491e92 ("net: bridge: mcast: handle port group filter modes")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 net/bridge/br_multicast.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 2f9bb30e1a1f..3fbad7b59769 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -81,6 +81,10 @@ __br_multicast_add_group(struct net_bridge_mcast *brmctx,
 			 bool blocked);
 static void br_multicast_find_del_pg(struct net_bridge *br,
 				     struct net_bridge_port_group *pg);
+static void __br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
+				  struct net_bridge_port_group *pg,
+				  struct net_bridge_port_group __rcu **pp,
+				  bool sg_del_exclude_ports);
 static void __br_multicast_stop(struct net_bridge_mcast *brmctx);
 
 static int br_mc_disabled_update(struct net_device *dev, bool value,
@@ -458,7 +462,7 @@ static void br_multicast_sg_del_exclude_ports(struct net_bridge_mdb_entry *sgmp)
 	for (pp = &sgmp->ports;
 	     (p = mlock_dereference(*pp, sgmp->br)) != NULL;) {
 		if (!(p->flags & MDB_PG_FLAGS_PERMANENT))
-			br_multicast_del_pg(sgmp, p, pp);
+			__br_multicast_del_pg(sgmp, p, pp, false);
 		else
 			pp = &p->next;
 	}
@@ -799,9 +803,10 @@ static void br_multicast_destroy_port_group(struct net_bridge_mcast_gc *gc)
 	kfree_rcu(pg, rcu);
 }
 
-void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
-			 struct net_bridge_port_group *pg,
-			 struct net_bridge_port_group __rcu **pp)
+static void __br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
+				  struct net_bridge_port_group *pg,
+				  struct net_bridge_port_group __rcu **pp,
+				  bool sg_del_exclude_ports)
 {
 	struct net_bridge *br = pg->key.port->br;
 	struct net_bridge_group_src *ent;
@@ -820,7 +825,8 @@ void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
 	if (!br_multicast_is_star_g(&mp->addr)) {
 		rhashtable_remove_fast(&br->sg_port_tbl, &pg->rhnode,
 				       br_sg_port_rht_params);
-		br_multicast_sg_del_exclude_ports(mp);
+		if (sg_del_exclude_ports)
+			br_multicast_sg_del_exclude_ports(mp);
 	} else {
 		br_multicast_star_g_handle_mode(pg, MCAST_INCLUDE);
 	}
@@ -832,6 +838,13 @@ void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
 		mod_timer(&mp->timer, jiffies);
 }
 
+void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
+			 struct net_bridge_port_group *pg,
+			 struct net_bridge_port_group __rcu **pp)
+{
+	__br_multicast_del_pg(mp, pg, pp, true);
+}
+
 static void br_multicast_find_del_pg(struct net_bridge *br,
 				     struct net_bridge_port_group *pg)
 {
-- 
2.34.1
