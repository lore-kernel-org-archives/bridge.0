Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43978502D43
	for <bridge@lists.linux.dev>; Fri, 18 Sep 2026 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745401; cv=none; b=QjahFwTAo6K+LXK7hkJpkxmfbNyAYmDVNTdZInmfxtA8b7cGndd447RpPwjBzW6lSbxUdOLJdRG62h0x1abCCI+umly4aw5Wnze+ybsE748Mm80QTPFmVmU2umklSd6faz/TJP3ZlOMJoInAViHGq32m1tF3nLSoa9mMwvE0lHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745401; c=relaxed/simple;
	bh=rmQhi5zPbkNa+/qoorrwDelLL9t/EqR+C0YBSh380LM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0MoR1cjd6Jn0ITxElV/MXNH8QYdIEs8txHVeULU2OYzuQCMO6X2ETGHZjBn0hS2E7JJh5iu4/93ZLbQNiSm/SenZeOXgBw46JoCBrvlQSyFbG5yZY8DbmJ5QrAjtcSTUfiV6WVQG8MuJ+I79VT4magxmU5719FaY9cCJdi/WF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=MiRKow4q; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="MiRKow4q"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e6598dd44so5214015e9.1
        for <bridge@lists.linux.dev>; Fri, 18 Sep 2026 08:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1789745398; x=1790350198; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mi+0ABG8vMO2t6JqGnB0v+5K4lCi669MG0dctZCIzWc=;
        b=MiRKow4q0p3fCCQVMyVH/C6rZr6rDmT3uVMh6E+meUmHULRZzev+Yd8rFob7jv8lPG
         EifgjzkaoieXMgfHhoX0TLUr+t8jClCTK4SgyrvcEySUKI5Ntcoy5ZgiT8OeaJOnZHRF
         /iK87PG8SgmhFR0DH+kBnQ/XhpcoBDvU8gywlUesmLmJ7wWBWLQr673xGe9ckwTX1Zil
         KrKGYOUxLjnLD8mSjObTF3aN7+XOV5eLuPMonYFuGOsBGEnzigkcGFJXeFwl+m/FUBP7
         TfOJLvPh3cT+Ybjf7ogZ8sZMijv+/l8XaKr/heSm685F/RWx1jyjLFVUg37lydCE3LwG
         2y+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789745398; x=1790350198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mi+0ABG8vMO2t6JqGnB0v+5K4lCi669MG0dctZCIzWc=;
        b=iCBUEwsqflzgAAMHPqtSHgcei8lvgmNZ5NQJ9JpPZ0TVj3ufftBy0xsQaNH1PfZ8ag
         YzzMtcJwSGjHwnq2iROXv/uiavoCMc2XkO+hoYHkG+eBWf/jt7JU9okqpGagA/VBi2tx
         kChOjuQZ/UnytIMU7M4wDVHRE59Po9kMqWKhaVnyrUIOzvB8hfDZKC0OhrtlSGVA9E2p
         KFTLWKNm0/1/jCEeVg/ViwqOuaXZHdwzgGrNk3ZLpz6mYS1I47J1ze92ZXBpGIG69ZWb
         3stTXJsirwq4L0HpxL0gp74W5ouH2/oVml78nSO8Z5fwun97G+XrgWOFXawUHodPMOhP
         h3tQ==
X-Forwarded-Encrypted: i=1; AKwUvBz0YQAKklYI97w6t9GonWOcjZu56a8Zw5lq+np54hWmTCLvigawQTZxeyw2J3oxT9QWxFDEj/c=@lists.linux.dev
X-Gm-Message-State: AFuF++nQzH/17K5RGym0RwRqa3NnfKgKP6w17/6acMAR8Y59yfYeDU+t
	F4Ehp2IT/2dxsdqC7H9pyxbme7OEP9j0l0JcZUzbasC6PwNKOfLLJdRYIosODFJxnSM=
X-Gm-Gg: AYBFou1qHaJIpmAcQTBNLhnFyVExQIGBlkekBA9wwkwCbf5qT1Kz1rFeX7b4SN1GWYJ
	danYqROM9koDwwyfG8iX7fXArkQ2aj+1r+Kxhdw4y9sZ5yZyr4iV5uxKyVi9t0ks1qm+rL5glpR
	bKA/pcJcDnE1LZ+ykvsgF4AwPmVAwBDaVqnfGyq5pwuHye83//jaaF+pzYKdjOiG7S0sqfHHIjn
	zqYMZiEhngifGXfrcVMOAzciVraWpitYd+o4tJd7anDomB7r3hvdncVB5cI6dvJkGqx2fyoynV6
	nbL0RYuLfjTMitONdCB6p/UiCunhzOZgKBW14N7hAtRnh8TzBc8yz4Bl2DRkf5857EdotI2qxMs
	ZURE9Z7L114EsTDdeblsKW0lpzuepOEW914wt357R85asomYPFU//0OVEodW351WRGcWoB2nmik
	AAF9/fErTanKq1WIeg9Q/3CEv8hWWOSUV97R9/DrZcBIg+ltNek360JAqLay1UnMRDymZ7PHo1S
	7OQYKbXfvB5GwEJcR0tEQ==
X-Received: by 2002:a05:600c:81c8:b0:49f:bb8a:b4ce with SMTP id 5b1f17b1804b1-49fc573dae5mr34789235e9.28.1789745398529;
        Fri, 18 Sep 2026 08:29:58 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49fcd074336sm476995e9.8.2026.09.18.08.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 08:29:57 -0700 (PDT)
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
Subject: [PATCH net-next 4/9] net: bridge: vlan: introduce a list of port-VLANs in the master VLAN
Date: Fri, 18 Sep 2026 18:29:45 +0300
Message-ID: <20260918152950.1938259-5-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918152950.1938259-1-razor@blackwall.org>
References: <20260918152950.1938259-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keep a list of all port-VLANs that have been created within their
master VLAN. The list is rcu-safe and will be used for optimizing
the flood path.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_private.h |  2 ++
 net/bridge/br_vlan.c    | 11 +++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index bda25f851342..b2a12b6298cb 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -210,6 +210,7 @@ enum {
  * @port_mcast_ctx: if MASTER flag unset, this is the per-port/vlan multicast
  *                  context
  * @msti: if MASTER flag set, this holds the VLANs MST instance
+ * @port_vlist: if MASTER flag set, this is the port-VLAN list
  * @vlist: sorted list of VLAN entries
  * @rcu: used for entry destruction
  *
@@ -244,6 +245,7 @@ struct net_bridge_vlan {
 
 	u16				msti;
 
+	struct list_head		port_vlist;
 	struct list_head		vlist;
 
 	struct rcu_head			rcu;
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index bfedd13e3fd4..34d1df59d190 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -130,10 +130,12 @@ static void __vlan_add_list(struct net_bridge_vlan *v)
 	struct list_head *headp, *hpos;
 	struct net_bridge_vlan *vent;
 
-	if (br_vlan_is_master(v))
+	if (br_vlan_is_master(v)) {
 		vg = br_vlan_group(v->br);
-	else
+	} else {
 		vg = nbp_vlan_group(v->port);
+		list_add_rcu(&v->port_vlist, &v->brvlan->port_vlist);
+	}
 
 	headp = &vg->vlan_list;
 	list_for_each_prev(hpos, headp) {
@@ -147,6 +149,10 @@ static void __vlan_add_list(struct net_bridge_vlan *v)
 static void __vlan_del_list(struct net_bridge_vlan *v)
 {
 	list_del_rcu(&v->vlist);
+	if (br_vlan_is_master(v))
+		WARN_ON(!list_empty(&v->port_vlist));
+	else
+		list_del_rcu(&v->port_vlist);
 }
 
 static int __vlan_vid_del(struct net_device *dev, struct net_bridge *br,
@@ -335,6 +341,7 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 flags,
 		}
 		br_multicast_ctx_init(br, v, &v->br_mcast_ctx);
 		v->priv_flags |= BR_VLFLAG_GLOBAL_MCAST_ENABLED;
+		INIT_LIST_HEAD(&v->port_vlist);
 	}
 
 	/* Add the dev mac and count the vlan only if it's usable */
-- 
2.47.3

