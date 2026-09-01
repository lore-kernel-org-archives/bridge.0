Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879F638D401
	for <bridge@lists.linux.dev>; Tue,  1 Sep 2026 12:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788264465; cv=none; b=G0OifEAoBubp6Biu0fYpzEPoB9jJvm+f4kRIZm4m0XyB49oo+hLgA+3GZx7qF0ujP8drxZbZ4cem5cij/GRXTFl4AmGeNRQ8MZivAYrJfVeQ8UyZMV0qS3lqnw2kcdw6p9ZAdDIu4De5ZVMBmS5fCTefIuOZxa+2dPIaUgfCQ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788264465; c=relaxed/simple;
	bh=tdJiRvngwBZJEFqckMVh5CbVJMAJJT/FEcsuLmpJ9ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CKxBDag9lATgFGAlL6ws12rZE+Xd4C90afite1bov6MIcsg5BFpfEMC1w5d+LJSEXWpZKd1WGjpFh7JjL/MblbF0KYlUYiLNCQF7zxVOhLPw6kTER1EGVeaq4IRPlv2ygWCypcStaxm37oXywkNoKFNnNLrsIRjqSzNGcSUzDf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=KG5RTihs; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="KG5RTihs"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-482f9309813so796848f8f.1
        for <bridge@lists.linux.dev>; Tue, 01 Sep 2026 05:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788264462; x=1788869262; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HMMQOAlRYAextL0wqVjD4N5g4g594G9DLp/sV2LJqQE=;
        b=KG5RTihsQ+dT81Tju4x3qFOnlq4kGm91eDPHHT2uyJ48DZX3N9KMHeqx0LmTzZ0KmK
         L2necIbrhQ7gAkuvA6gIbJA3DtE+9ETWoPERtf9Zb0qbVmV+ZmUpelpn5Qmq8iFCjvPo
         6j2wvqIX4UfqIFdCRVeelcjnk7bflLWFUcEGbLKUMnmCAp2SgRGlcEIrNKTHOk3TNz5B
         G9Lss103m+0O0EtyqsopqbbrVgRBiZGd1MrQfcdQul71fIITFuJTIJdsQrrgCaAsS5tE
         pOw9naeEtOCKLusmTH+03egg6ModB8sw0SYRaO/oJVU8wZVdE7b7t5kHAmCUomSZwnLJ
         2VXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788264462; x=1788869262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HMMQOAlRYAextL0wqVjD4N5g4g594G9DLp/sV2LJqQE=;
        b=dP35rCp/Qx3UoRPTWBfqBkvuzgt8Hxa/n7NNv16wFGqLiiA1EjQ4Y8xv5OWOOys4sh
         6j8FsbTkIZku/mqmgN6iAEybQZ7D47JMkWW6MOoUd+prDyRAZq+CX/7+KSPh3LucZVpD
         ynsoqdXOYKmjNb8nVqN2faLOn4oekJhEko8LWrTFkA2NS56qgqm2Vy46FJ5iYp0qqwqp
         etofHWRXmLe7NZaWleJT8iOR/4qWThTplnCCK2YAEcZEMWxeBGhkOqPk2bk+CNElrsZo
         K4uI+H7Bw/srb7V74GI4U7Lf0+8A/mf30FPJlYLwzfmL7JcJ3L7YTWMWXWCQ6b4s2uYv
         Yl1A==
X-Forwarded-Encrypted: i=1; AKwUvBytw7ChJ0+zJo26mqLvkMiGqqbsYzbeRK9nz/7n2U267BFFqdTFDpzVvI9bhg4bfa9dolk4uCI=@lists.linux.dev
X-Gm-Message-State: AFuF++kydN7RyVonNeEFgmR25xiHcbCTYn6HKvq8G/VOGwHYivxf8HQB
	maRQJnB4NWOerTJ8lAIb0kwPGzVwwSaah+AUIwBSJLAc4VpGoxBG0XgTIO17vzalekc=
X-Gm-Gg: AYBFou3KBQbBMgkd6UYR2GDLv5Uj+8dtj9nOygogxjcz4wbPeeG1HxtGfJW7dEJ8vr2
	jajD6BEjalNDz/MJIQi1InK9ooFWiFWNFJqzeU49tHjudzpNAFL5lO4KMxFseWxX8ik9ck0TwTF
	SeSFdWxEGc4X39DA6g7zBrQ/3g+dYexN8261YOz+C3O6WLrsXGnYMWyOdWlhAKd6Im5eRnZ9fL7
	7vi87uJXtBucSO4bLylW+9a7HcXZgi7NY4lmmGH0FjApvADHRMZfJyY/jDzMnUz25vSGLWLNDvN
	ye/lPnaxvR1H3gUYUdfFUnG3wMOEvlIKp+JBytrKEgNyfP0RZArrIV/nWviifWWzhDfU3wDk8aK
	fU4EU6vkqO7NdKylN2BA41+rODCMHtAUwVBin7PAXY0futluBfhcI49fuxVgrkA3e7JoRl1fMj0
	CzrqJdgpZByKhoFtR03IHemDpfl6Vx4F0B6KUfX4WYMxy6YJ12m/ZRghFIsZAp1S0JzsITsUleu
	oD7lLzCZyO5
X-Received: by 2002:a05:6000:4305:b0:47f:8ac0:ccb4 with SMTP id ffacd0b85a97d-4843faa7301mr15041009f8f.10.1788264461602;
        Tue, 01 Sep 2026 05:07:41 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48442d7e452sm4251154f8f.35.2026.09.01.05.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 05:07:40 -0700 (PDT)
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
Subject: [PATCH net-next 4/9] net: bridge: vlan: annotate lockless vlan flags use
Date: Tue,  1 Sep 2026 15:07:16 +0300
Message-ID: <20260901120721.747908-5-razor@blackwall.org>
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

