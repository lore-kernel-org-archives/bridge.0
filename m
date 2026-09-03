Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4DD4B715B
	for <bridge@lists.linux.dev>; Thu,  3 Sep 2026 14:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445942; cv=none; b=EMZz7r6fOfhPTnr/HuXmmXfo1kasSid+D+SDlJziKRe9p5kxxmVhZW18pnU1h7arvi0WmwKv6WzmVEVkFBsdKogqJ6xqsoGRpA1R5QovoY7OWTY5LLf2hz/FQtTOqyLIlvM/yqAwix8eGRoMIXZ2njLz/m9fmKrHhihdmAH2bVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445942; c=relaxed/simple;
	bh=yJfkb3hM5Pba0nKvWUAIgOdfux2UtM7ON45POiZc+dE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uWw2IBy1+ytqhlt5lbrCyB58qbaoMd+SRp6ysywA8UxURB/wd2UIHxEyfpMM39U3CKtUqaQ24mTkkcMbnikRNi6s/YeN6vm8U1k+ZWfy+KXl8ujCLqfBhKfn/VtZQMRwU1R7Jh4cTk0OD4TE2G01SByI3fQVr8XJNh2+GMhGUFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=i4+PyDNR; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="i4+PyDNR"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49cd77e0f95so24809075e9.3
        for <bridge@lists.linux.dev>; Thu, 03 Sep 2026 07:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788445930; x=1789050730; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2HFs9DuHBOZWo0pRLMgZ/aZaO5LCPX7IYZ0kiem5E6M=;
        b=i4+PyDNRWfYDSL2bzKXrIOHLCn9dZOCdif7qNs0J1VrpNpilg/D27uvAfiq2jg0bWv
         aeXbX0GuzQyLFOFN+l5p/pcbsFYmlkBHETjLYEsP+hssam7z3RBdODyd91+O7KAch82G
         mb4/RDw0pAnZUYHuepe6ixPNic1u3ZEpxW60CHVx7OJIP/sGKQDk5px0MwTWgK0IO7TN
         czyEpRn7/0Tq1MP2Ognf+j0EC7RYyvBdT7NtZwSKGupTPrRP27I0NH/g8l21qes7QbiL
         vfTJP6lkBQb/Nbf6hL8TZq0eNMMtMsRc9PSRENEIfx4HhRva3vh/FTNMPqvpqmINXy82
         TMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788445930; x=1789050730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2HFs9DuHBOZWo0pRLMgZ/aZaO5LCPX7IYZ0kiem5E6M=;
        b=fuZLYEYpkh1wIDPgiZFNDX8Ck4cg9ZOZ/M1a8CT30sqDTKzJo89J96TuOsihdgOmcY
         xrx1rr+kRJ26Ny2pl/6MNdYoWYJuQ5xIE6srQWQ7O9sMmRJgcba8R9cJIlZIjlqmNTbH
         9ik1siHIhkYjTknbS6xh1zkam1xFhadqQpb6DRSOENvDMKppwJX61cJFgEjWlUrI0BTg
         +3D2Xbw15q1XrBtN0rVqI+L1JMcMTQZcm8hAjuvPqTZfsoZqcoYqjM2/3AX7sFWXn8e4
         OjJZ2Gf/yXandx82v4KvQyE9PcI8e+y0CeF+yqwhqcuKyMZZraD4gBKy5/tEcxBWRF75
         q9NA==
X-Forwarded-Encrypted: i=1; AKwUvByXYdgEVuEJmyx1tFuCYTkocgwljStomKoHiKsd0NCc+dozJlgnUOhxHHeA6Fir2IHVda+mtKM=@lists.linux.dev
X-Gm-Message-State: AFuF++khMDgB15BWJjJiguABjn2GXpKH1eKt4D2R0DlMDlhjiKc0Ptre
	Bcpv7KasZG9283cl3QhvtRYc8ZBWCCdZy+yIbPgazItANcpOZapMns90SGQKXPKta9Y=
X-Gm-Gg: AYBFou0HDe01pcSfJOqJtLU5MNDgHdbdmj0wIUNjBkqzmjztJV5rBFFQVPmD5uoqrGP
	hn6qpPeTPQpO0jgaDobyU9f5bnmGV4NLcw+IAlPpd/BWisVxdHgorGo3P6Q6xk5WrG1L7p11iwI
	AAY87Yf0DtqgVwy14oCCMZ8E65QsKJwDjW4g/2xrBhqWFY5SUTHkW1j4a58ynwrFmIjgGjEW7ET
	fYr6qguLeQcO+pxOnMbKs/8UMur6IFuUZDa71FYBohhQipcR1tUierW/vHGaIRUjenyH5fwKjV0
	eE9fg6tvWKfRwkTAfMrzXo3Ijmaj67SBIwfoU/L7Y7rBBhK1F7tDLW9Sf5HZ+evpSzqRaJ4ZGtx
	Ti7WyVzQbNcW+OH9FzP0X0GhzZMYud7jAWpmEXFw3NbbeKqcAEWEV9meW+9nWHma136Y2m2gAvd
	zvzHDjsk0qUj3xoBgJJhDQK9jTzDEdS5h/mRShN7sQNN/Qrw/w7OKeBNnaXWcF0i6jkW1VcVKEU
	V+jtty/yH0=
X-Received: by 2002:a05:600c:224b:b0:49b:96a0:5c00 with SMTP id 5b1f17b1804b1-49cf5c03b82mr6106425e9.13.1788445930276;
        Thu, 03 Sep 2026 07:32:10 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49cee5d587csm81801485e9.4.2026.09.03.07.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:32:09 -0700 (PDT)
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
Subject: [PATCH net-next v2 6/9] net: bridge: vlan: annotate lockless use of num_vlans
Date: Thu,  3 Sep 2026 17:31:35 +0300
Message-ID: <20260903143138.1574598-7-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260903143138.1574598-1-razor@blackwall.org>
References: <20260903143138.1574598-1-razor@blackwall.org>
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

