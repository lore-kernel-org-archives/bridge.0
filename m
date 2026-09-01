Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702FA37C923
	for <bridge@lists.linux.dev>; Tue,  1 Sep 2026 12:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788264468; cv=none; b=VDwajZMntxHGh6HoauNFiwUO1QsdgC4AGH/qzO56oZTqNTZI3MkHmn/De217CG6UgnPELxvkbq5JsSR9G9Ze4zpDJzLVzm7bvuqsMZmcg/2AdXQ+glYO2kcHHKxBGUDM4GipDwneCd/QYL6YWCJ/BpCJkZJk5QifvtVoTzvNglI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788264468; c=relaxed/simple;
	bh=yJfkb3hM5Pba0nKvWUAIgOdfux2UtM7ON45POiZc+dE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L0VsjUwlCv8Um0XTYpXrR9o+3qLLOuaS3vTpncELLjSwP9w8Oo0jZe731jAGlD/HW3XKJuBo2saJ2ecYV18pKBEztWEOlx2CaK4H+hhi+axo4KjhViSnsMKru2Gc2VGlqHJMembAjnJU5c0wTBZQmS0SQAmPNiLP8MRSknlRaSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=NaEyfW0b; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="NaEyfW0b"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49b0d78a801so37737945e9.2
        for <bridge@lists.linux.dev>; Tue, 01 Sep 2026 05:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788264466; x=1788869266; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2HFs9DuHBOZWo0pRLMgZ/aZaO5LCPX7IYZ0kiem5E6M=;
        b=NaEyfW0bn/WsN5F+/I/LMgQ8mxz9ewsrroHKjOUP6alHDXdeHMVfGTIel/26E0GZEo
         2eVb3VUo/KtsmGbCCsQmsQfxxAZvKWyNI8Bvcvx8bCa1Euqbt7m0yURxydG8bYJmnya3
         az1orB9Bn1KuXIDlEWz2DuNFGLhOCqr4bMj/VOSy3B86FPWzV5PQOdMID60Khwprsgyt
         vbu89h9L2h5IFoEiC+Q69wlOhRa7UeAWzCljkIExPVQW+H3Xd0D2Y/TPewy8rrGHYp3a
         Ib1EgryzLae4aD54nh/KWJYnyNQFWv8n+oDZLJPQnw1WOk93OWtNXu1Wr4NalISRZpkE
         /Kbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788264466; x=1788869266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2HFs9DuHBOZWo0pRLMgZ/aZaO5LCPX7IYZ0kiem5E6M=;
        b=WQ2+IANvnf4MJ6v8dI9hVB2pZG8x0Cg/+RqZBWmR1qK73xmQzQUj+j6YAiOBzYWBZ4
         bu4d/n5hB/DFw81VVndQyt01F/3b3SaNp6pzRCZ26lodOLcEA5LNJ5TGnQl3JIo0QlaL
         05fsMIm0wpY0GVkbLWvg/U8dCiLuusB/VSmx4/loSdijwzF1UhYXG5tmMfcHjJwYFw7A
         X7m42BeLkEJdihls5JfmLEwToa5ho2D5C4Zn9nz1Oq42iuk9Gr5heWEl7BeICdi2LVFk
         veOultYXdvotkV9f3iiN01Bm2x7jMBlbnNjAtVtf36mkv0V5rz1WNJtSllepWeDqYshu
         tw3w==
X-Forwarded-Encrypted: i=1; AHgh+RqF34aIyTTb48zqfKh575gCmiRFpz9erhMXnXAh8TNp/KKIPQytvim9jUkq8YZ83D008GPyrl4=@lists.linux.dev
X-Gm-Message-State: AFuF++lG2ZvumO0wcDzfxD6AM/bIjINEL3JmjX7of+0iaN6E5GkmuQ7r
	MqcmjThq5bVHISls5hGDR4XCiJp2cTA8ou2PhqUCVFoZsq0x2KHvw6q+SpRNLaCnjF4=
X-Gm-Gg: AR+sD13gOzw97XIDuzmu0y4RWL7IAfIA05hojE/ROf3dw/wY1AnlXG3Z7+hdgrvtDrD
	Zh0BVkWro8QJQ82yJUVAfj89IWHFuv/1sMrqZt98RjlFhsm4acwaHSA3s0bPNkbHizSHNii9UvM
	QgajesAk1XQWr6mNrq+wF2MzgQO9g91PkMKyHvjNd7HpN58rLOL1E4mTj15YgZGHJGF4koIjxE0
	8J9ar3uZsle1zT4rRdZhtAuX9O/cx6113Jq2S2laVndYVKMO4A5IzlxPKyT/UT5j7XvQfTrEz0/
	f8ivqt1wf52UN0j7rC2JkA1WbyqwNpOcWaWDOQyTlsIEDmXy5rRLjV8/rD01pN+m5utT9zcHo1n
	gH69r3i251pFvoASTOfMuBMn/86wYYV/37HsBGC7pyK+ozobkMyrwG7UB0gtmO4BWXb1AYniPcK
	yW7OJo5mCPSJIgnVYcgDbeai6lnsbtlJB1HdblFW8ivxeCaSgKQrCQBSKuncNCXmxSBFCjEEnMH
	lc0u5v9XBU=
X-Received: by 2002:a05:600c:8107:b0:49c:d26a:cf70 with SMTP id 5b1f17b1804b1-49cd26ad005mr330907835e9.15.1788264465295;
        Tue, 01 Sep 2026 05:07:45 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49cdce1a3fesm66474005e9.12.2026.09.01.05.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 05:07:44 -0700 (PDT)
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
Subject: [PATCH net-next 6/9] net: bridge: vlan: annotate lockless use of num_vlans
Date: Tue,  1 Sep 2026 15:07:18 +0300
Message-ID: <20260901120721.747908-7-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901120721.747908-1-razor@blackwall.org>
References: <20260901120721.747908-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate data races around vlan group's num_vlans, it can be read lockless.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_netlink.c |  4 ++--
 net/bridge/br_vlan.c    | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 62ce96d9ba32..ae76df0de05a 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -81,7 +81,7 @@ static int br_get_num_vlan_infos(struct net_bridge_vlan_group *vg,
 		return 0;
 
 	if (filter_mask & RTEXT_FILTER_BRVLAN)
-		return vg->num_vlans;
+		return READ_ONCE(vg->num_vlans);
 
 	rcu_read_lock();
 	num_vlans = __get_num_vlan_infos(vg, filter_mask);
@@ -531,7 +531,7 @@ static int br_fill_ifinfo(struct sk_buff *skb,
 		else
 			vg = br_vlan_group_rcu(br);
 
-		if (!vg || !vg->num_vlans) {
+		if (!vg || !READ_ONCE(vg->num_vlans)) {
 			rcu_read_unlock();
 			goto done;
 		}
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 102792f20a5e..95187a607ec2 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -344,7 +344,7 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 flags,
 				goto out_filt;
 			}
 		}
-		vg->num_vlans++;
+		WRITE_ONCE(vg->num_vlans, vg->num_vlans + 1);
 	}
 
 	/* set the state before publishing */
@@ -367,7 +367,7 @@ static int __vlan_add(struct net_bridge_vlan *v, u16 flags,
 out_fdb_insert:
 	if (br_vlan_should_use(v)) {
 		br_fdb_find_delete_local(br, p, dev->dev_addr, v->vid);
-		vg->num_vlans--;
+		WRITE_ONCE(vg->num_vlans, vg->num_vlans - 1);
 	}
 
 out_filt:
@@ -417,7 +417,7 @@ static int __vlan_del(struct net_bridge_vlan *v)
 
 	if (br_vlan_should_use(v)) {
 		WRITE_ONCE(v->flags, v->flags & ~BRIDGE_VLAN_INFO_BRENTRY);
-		vg->num_vlans--;
+		WRITE_ONCE(vg->num_vlans, vg->num_vlans - 1);
 	}
 
 	if (masterv != v) {
@@ -695,7 +695,7 @@ bool br_should_learn(struct net_bridge_port *p, struct sk_buff *skb, u16 *vid)
 		return true;
 
 	vg = nbp_vlan_group_rcu(p);
-	if (!vg || !vg->num_vlans)
+	if (!vg || !READ_ONCE(vg->num_vlans))
 		return false;
 
 	if (!br_vlan_get_tag(skb, vid) && skb->vlan_proto != br->vlan_proto)
@@ -757,7 +757,7 @@ static int br_vlan_add_existing(struct net_bridge *br,
 
 		refcount_inc(&vlan->refcnt);
 		WRITE_ONCE(vlan->flags, vlan->flags | BRIDGE_VLAN_INFO_BRENTRY);
-		vg->num_vlans++;
+		WRITE_ONCE(vg->num_vlans, vg->num_vlans + 1);
 		*changed = true;
 		br_multicast_toggle_one_vlan(vlan, true);
 	}
-- 
2.47.3

