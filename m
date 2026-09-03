Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EBC4B3390
	for <bridge@lists.linux.dev>; Thu,  3 Sep 2026 14:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445941; cv=none; b=BiKoVkg1sj7qmhokLjeE7s/GPzIRCXTYEjsYcueOzsEYzDOPFBfMwOs/kdYS1jIHUHn8iWTgztGob7bJ2+tD2S8D4Kc7KRGMbA3ylxP29IhxMoMOMSR4Gdvv8VgIPgho9D5jN91KupAtWCtrsAthQBXmsn854y/Zvvb6CHPSVAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445941; c=relaxed/simple;
	bh=tdJiRvngwBZJEFqckMVh5CbVJMAJJT/FEcsuLmpJ9ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMQwn623fuEeQnLaNfhC+/8cw99zyf4+DQsu6J8NOSX0dPHEMRxHVbp6u/gbYx6Cij26PrStFAEQDwBU4i2kVA0TOsaLTZtKtXpWc/2oQTb5MPdqXbJNmYaN6NgAzjvK210QCBRsNuS8bF66bj0BYf+xjAs3QBpBRX3weH3zk0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=E5gtSxQs; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="E5gtSxQs"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49b0d78a801so20781855e9.2
        for <bridge@lists.linux.dev>; Thu, 03 Sep 2026 07:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788445925; x=1789050725; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HMMQOAlRYAextL0wqVjD4N5g4g594G9DLp/sV2LJqQE=;
        b=E5gtSxQsBO5fJz+tVDcseRTZSqoZI9U358iV6o+7cEATsOLWsTu5XzzPegzlyfTzGW
         dIixv0F7fe6dxXa3yqpGCa2xg6Wlt0UNZoNQP5Sw3fGJAl/+TKh5KEnyjq2WIx1M8IM0
         s3wcp9bjj8d8MGQYs5x08vv1gRq6t3mzIXFwR4UYQbqtguSQsCZm6h0tTw7zL7kmPqXO
         Fke4zjvM6Iu6cpB3Vz1z+Tby9XmCdgt0WsjQub//yo+qwSpVQ9CTFF8/S5iDTjECcURC
         V7bsDoIu/6+FiCx/tcjW+0NnJGUyqXpcMeZBTU6y1q9m8seJyVb5aQdNGyLUUp68x0Ts
         UXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788445925; x=1789050725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HMMQOAlRYAextL0wqVjD4N5g4g594G9DLp/sV2LJqQE=;
        b=eNzG2jFOoztgmRRXwbfl6882bhGPpILBSuESr9BEj+65OeG562Pv2BIYaRD02hdzEN
         jvPh5Nt7ow4is2/mQ0pKX2B3DlTLZWZ66cgaJQWBFIpIsEF24ihym3FHo7bc0U1KhLzl
         O1URXoXZ58ai6Hsr37DJUHPgU2ua6ipKx6O1G5pvHnM7DsTL4oLFxvGkOek9/A5BBlzS
         /xaDJH7TjcHJ3BvzGiqa8IgXcMD6EOd2ubxTELTdDyhIkIqdcaoES0mq+BVwkwjGp52E
         DiISpVhadkmMBzgCCa5cEq9/0xv1qJepcq1cCkOf/pILOjmpViUVT5qSUJokLGUai2Pb
         Mccg==
X-Forwarded-Encrypted: i=1; AKwUvByqo/yBBSqJrYuacR//O4gsM9Rv3VrtfFoz95rFvCdJqXX8+W66Nbgok3MGzwAb4OO0EvRKYbQ=@lists.linux.dev
X-Gm-Message-State: AFuF++mlZ3/VS9JAQN3o4FGeSFKDVus3ZSY7rpvhVrG/nZk4OL/1CtnR
	07hvS8pTDpkr5tjA9etP9oYifmElQpAeQdst6oSb28XLYKGc02grKJtlGlsj2EbLm80=
X-Gm-Gg: AYBFou0gYnZ9BzvdRfLCpSTQw8f5SVoPud+GMFZ/Qg90WOOIlFlSb8kUGwyOnSTvL1L
	Q84W4Ms26bDvRu9+bN2Ng852C/yib8asbY/U2cv4+fSklAvpQoaS6p557MwbFvVt1WQLHJ1zkpK
	qpamruNO3x9bKz8u+GCUolDfiyWN8whvBgos9xOh3tUXzU/XifHCA2SrYx+CUPqpac6NweMvubM
	TnPowZ1hPo87owoZ/ne/jKvQXP5/meAIdSIDfAs/yMVhaEDH8WF22JT5vpAfHKmiuEJQhXO8Xiv
	g66sqXgUoJi8kKDfWtSbUevJAOUz0MXTq9yIV9ihKrp5KYjq3wCm8DoA1Jsg/rgtNQv4KkUyK5s
	KPt/dw39pWzpZjePmxZW2BImpk+IbUIwG74uv5gVM9ReJEsyBJoVkFXDItHTeDnvzJ5l5GaHDPJ
	hkIeOXC9oSu6K4aWT0E/ZsXrpSk+krqq/pPUeVi8w8Bml6doQ/Q2vywZjqP+ohpXRhgXfn1mUl7
	bOLClQ9hMYoRgA6IGrstw==
X-Received: by 2002:a05:600c:a0b:b0:49b:910c:7703 with SMTP id 5b1f17b1804b1-49ce5818612mr225838985e9.9.1788445924852;
        Thu, 03 Sep 2026 07:32:04 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49cee5f914bsm91619145e9.3.2026.09.03.07.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:32:04 -0700 (PDT)
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
Subject: [PATCH net-next v2 4/9] net: bridge: vlan: annotate lockless vlan flags use
Date: Thu,  3 Sep 2026 17:31:33 +0300
Message-ID: <20260903143138.1574598-5-razor@blackwall.org>
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

Annotate vlan flags data races, they can be read lockless.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_multicast.c |  2 +-
 net/bridge/br_netlink.c   |  6 +++---
 net/bridge/br_private.h   |  4 ++--
 net/bridge/br_vlan.c      | 19 +++++++++++--------
 4 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 3ef5d8bbf552..bbcaedf15ca1 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -912,7 +912,7 @@ static void __br_multicast_query_handle_vlan(struct net_bridge_mcast *brmctx,
 	else if (br_multicast_ctx_is_vlan(brmctx))
 		vlan = brmctx->vlan;
 
-	if (vlan && !(vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED)) {
+	if (vlan && !(READ_ONCE(vlan->flags) & BRIDGE_VLAN_INFO_UNTAGGED)) {
 		u16 vlan_proto;
 
 		if (br_vlan_get_proto(brmctx->br->dev, &vlan_proto) != 0)
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index b2cd4e39326d..62ce96d9ba32 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -41,7 +41,7 @@ static int __get_num_vlan_infos(struct net_bridge_vlan_group *vg,
 		if (v->vid == pvid)
 			flags |= BRIDGE_VLAN_INFO_PVID;
 
-		if (v->flags & BRIDGE_VLAN_INFO_UNTAGGED)
+		if (READ_ONCE(v->flags) & BRIDGE_VLAN_INFO_UNTAGGED)
 			flags |= BRIDGE_VLAN_INFO_UNTAGGED;
 
 		if (vid_range_start == 0) {
@@ -385,7 +385,7 @@ static int br_fill_ifvlaninfo_compressed(struct sk_buff *skb,
 		if (v->vid == pvid)
 			flags |= BRIDGE_VLAN_INFO_PVID;
 
-		if (v->flags & BRIDGE_VLAN_INFO_UNTAGGED)
+		if (READ_ONCE(v->flags) & BRIDGE_VLAN_INFO_UNTAGGED)
 			flags |= BRIDGE_VLAN_INFO_UNTAGGED;
 
 		if (vid_range_start == 0) {
@@ -437,7 +437,7 @@ static int br_fill_ifvlaninfo(struct sk_buff *skb,
 		if (v->vid == pvid)
 			vinfo.flags |= BRIDGE_VLAN_INFO_PVID;
 
-		if (v->flags & BRIDGE_VLAN_INFO_UNTAGGED)
+		if (READ_ONCE(v->flags) & BRIDGE_VLAN_INFO_UNTAGGED)
 			vinfo.flags |= BRIDGE_VLAN_INFO_UNTAGGED;
 
 		if (nla_put(skb, IFLA_BRIDGE_VLAN_INFO,
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 0efd2e79e255..96554d293d22 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -665,13 +665,13 @@ static inline int br_is_root_bridge(const struct net_bridge *br)
 /* check if a VLAN entry is global */
 static inline bool br_vlan_is_master(const struct net_bridge_vlan *v)
 {
-	return v->flags & BRIDGE_VLAN_INFO_MASTER;
+	return READ_ONCE(v->flags) & BRIDGE_VLAN_INFO_MASTER;
 }
 
 /* check if a VLAN entry is used by the bridge */
 static inline bool br_vlan_is_brentry(const struct net_bridge_vlan *v)
 {
-	return v->flags & BRIDGE_VLAN_INFO_BRENTRY;
+	return READ_ONCE(v->flags) & BRIDGE_VLAN_INFO_BRENTRY;
 }
 
 /* check if we should use the vlan entry, returns false if it's only context */
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index a53054fcc093..c8b2e3bfd42d 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -60,6 +60,7 @@ static bool __vlan_flags_update(struct net_bridge_vlan *v, u16 flags,
 				bool commit)
 {
 	struct net_bridge_vlan_group *vg;
+	u16 vlan_flags;
 	bool change;
 
 	if (br_vlan_is_master(v))
@@ -68,8 +69,9 @@ static bool __vlan_flags_update(struct net_bridge_vlan *v, u16 flags,
 		vg = nbp_vlan_group(v->port);
 
 	/* check if anything would be changed on commit */
+	vlan_flags = v->flags;
 	change = !!(flags & BRIDGE_VLAN_INFO_PVID) == !!(vg->pvid != v->vid) ||
-		 ((flags ^ v->flags) & BRIDGE_VLAN_INFO_UNTAGGED);
+		 ((flags ^ vlan_flags) & BRIDGE_VLAN_INFO_UNTAGGED);
 
 	if (!commit)
 		goto out;
@@ -80,9 +82,10 @@ static bool __vlan_flags_update(struct net_bridge_vlan *v, u16 flags,
 		__vlan_delete_pvid(vg, v->vid);
 
 	if (flags & BRIDGE_VLAN_INFO_UNTAGGED)
-		v->flags |= BRIDGE_VLAN_INFO_UNTAGGED;
+		vlan_flags |= BRIDGE_VLAN_INFO_UNTAGGED;
 	else
-		v->flags &= ~BRIDGE_VLAN_INFO_UNTAGGED;
+		vlan_flags &= ~BRIDGE_VLAN_INFO_UNTAGGED;
+	WRITE_ONCE(v->flags, vlan_flags);
 
 out:
 	return change;
@@ -413,7 +416,7 @@ static int __vlan_del(struct net_bridge_vlan *v)
 	}
 
 	if (br_vlan_should_use(v)) {
-		v->flags &= ~BRIDGE_VLAN_INFO_BRENTRY;
+		WRITE_ONCE(v->flags, v->flags & ~BRIDGE_VLAN_INFO_BRENTRY);
 		vg->num_vlans--;
 	}
 
@@ -522,7 +525,7 @@ struct sk_buff *br_handle_vlan(struct net_bridge *br,
 	 * hardware on each egress port as appropriate. So only strip the VLAN
 	 * header if forwarding offload is not being used.
 	 */
-	if (v->flags & BRIDGE_VLAN_INFO_UNTAGGED &&
+	if (READ_ONCE(v->flags) & BRIDGE_VLAN_INFO_UNTAGGED &&
 	    !br_switchdev_frame_uses_tx_fwd_offload(skb))
 		__vlan_hwaccel_clear_tag(skb);
 
@@ -753,7 +756,7 @@ static int br_vlan_add_existing(struct net_bridge *br,
 		}
 
 		refcount_inc(&vlan->refcnt);
-		vlan->flags |= BRIDGE_VLAN_INFO_BRENTRY;
+		WRITE_ONCE(vlan->flags, vlan->flags | BRIDGE_VLAN_INFO_BRENTRY);
 		vg->num_vlans++;
 		*changed = true;
 		br_multicast_toggle_one_vlan(vlan, true);
@@ -1489,7 +1492,7 @@ int br_vlan_fill_forward_path_mode(struct net_bridge *br,
 	if (!v || !br_vlan_should_use(v))
 		return -EINVAL;
 
-	if (!(v->flags & BRIDGE_VLAN_INFO_UNTAGGED))
+	if (!(READ_ONCE(v->flags) & BRIDGE_VLAN_INFO_UNTAGGED))
 		return 0;
 
 	if (path->bridge.vlan_mode == DEV_PATH_BR_VLAN_TAG)
@@ -1550,7 +1553,7 @@ int br_vlan_get_info_rcu(const struct net_device *dev, u16 vid,
 		return -ENOENT;
 
 	p_vinfo->vid = vid;
-	p_vinfo->flags = v->flags;
+	p_vinfo->flags = READ_ONCE(v->flags);
 	if (vid == br_get_pvid(vg))
 		p_vinfo->flags |= BRIDGE_VLAN_INFO_PVID;
 	return 0;
-- 
2.47.3

