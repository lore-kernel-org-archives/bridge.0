Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DC34BB5DD
	for <bridge@lists.linux.dev>; Thu,  3 Sep 2026 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445949; cv=none; b=JjUz0rTS6IliMYmRK7L2rWaRT7QiyEpGSfgiR7VhEbF2hxmYBu5maFLW7gEk+bnN5YPGjAfbgQSiJYYPmkd5FIKQ/PgLJAwue4xi+iE20yUlghxzl4V9TWuklPpgrkLC6ZxBQufQ2VxvxC26/mG9BKMdFnGUmrmYOdxo6SO6y1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445949; c=relaxed/simple;
	bh=JQ9WHNXd1zUXM8hq9MaOXxZqBdxkm2SZKoBtKHz7Wpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJrZNYTujUdT0OhjCJJBuHnxZvihairQQ1MAi0uGWWt/UQVWZZTh0oGNpJzi2WiQ/K774rmwvnAfu07YS00zujp4UFQTeC1yp92T60eWd8roE+7vKEkjnn1bKSvG/pHnjpc4mKHsxI8k9UJHE6a+bV/Cdo1P1qJ+cQazt71ozjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=SQRsGKjv; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="SQRsGKjv"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c255c58156bso418385166b.3
        for <bridge@lists.linux.dev>; Thu, 03 Sep 2026 07:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788445935; x=1789050735; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QYYOG0Do4xCECmpKXiXD6Dgae1lqnmNhz5mhp7Y8ks0=;
        b=SQRsGKjv1l+zC/+eqwzWnWMgd/2y+z0/0xZIiWJAGHfV4rofZ6utR4C+AmxGn8RIbw
         2N3S9KEcgPmGXqM3I6tY9H9y+OgsFNxS2DVR6VvlDajurEehF3lyUGwwVCx0aGHeDOhm
         rTp2OIsVYC+CtoweIHDWIfUzYqFH9d9n1hqxbvw113PkgRIXV+tRfVt6l4LpA7KIdm6n
         kiCvYua6N6XdQeV8HWVx1ssQe0PLz1G6xFH5UuR4hN7AoiD7FGs1rzYWULObQp+UqQZt
         zENvbdG1mrL7yesZFoy5HX0CehhOjEv0WQci10YqMjktvYFXw2r2pVoUPPMW8emsc2ds
         YXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788445935; x=1789050735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QYYOG0Do4xCECmpKXiXD6Dgae1lqnmNhz5mhp7Y8ks0=;
        b=hBWQaPoJHwRuZX+A9odphTi6+bnfeMqZYv7GknTI7yVW29y6dI5Jp5IswFYt5eL8S6
         xVlLsFt7xn+cl0s35VY2/7Z0aCINmhbm9DzvMS45ghqdZTxQnRotoTFlimKEJcSBPFkE
         O/9zuKTKt7A2hjBXySTsFLr4KzWnBedsvifUkR/QAeQ0nMBWlWml9YIMjGB6jDxqwfpG
         snQZvABX5YZJVoHIvJyDkGsFvLRxeXDCOGq2ZmnwT1B51jB0t1pUi8CqH9JZGy2BSUBy
         XVTCp1iGSEnrQpYzxEKnn0UxIkNFym+cUCs9rAPE15swOqo+NiAd+TcXxrQXiU7SzXjs
         v9Fg==
X-Forwarded-Encrypted: i=1; AKwUvBylmeAzUh8dC+ewfLgVqXOXwhowz9ZlmmCd2Bu/+K4gIjWTM9BjaNEC3LKeQ8icrcoxpMYtg0c=@lists.linux.dev
X-Gm-Message-State: AFuF++nUH/vsKVoD+jQylAgEIlHLxKTUGUnjos+Liec0QRbslqVV2Mp6
	l9nuAOaXkI4ljTGPXSwIVqBJxlwQKYX/4Dk9LP0gCQeCGf6IbakXSZx2V9rixPV1R6w=
X-Gm-Gg: AYBFou1X4VgqzybughDQBeylpg4Tq7xgKqMqiH+zKuL0n+05MH8ePLj2vbU813r59X6
	Rkw0O8/BovRfN584zerRQap4cdbbDFwFF8CRv88VHJEl+ZcxYkVyfE/x47lnwXSU6B9NAyHrQ3G
	wYgztYl6bRgMnd+JgvFPqqLxuc8fm/EiROF4GbhPkVBGdkgG4sJ0MiuSTUegYRQqJxTR7TCfpOX
	LxBrYaf9jsNVqnrQeTxnOmZ4DoJCH5Q2LE/4yF8ujgWElMAQ180dNtwGLA76ZeSPOMgyPmlLTPk
	/JKpjSW99iB9/mLqDzpK1Kv318BIZ8bIU4Xkdf0qqiTSXqzaOJLmbOFcl9GN6/pIy3aNze4NtF0
	b0GaxahyUlYlxT/X1V34m6JWEziJBmBD7RDXjZ0paI5nKJY0+NPVc9+KD7tjZUm117j6B5GEMpQ
	RhC1esooPKvDZNSPdIvwTjj6vlU6CTU6hl72+MCx9RjZ20xZ+BB2MldBq5+WlxbNmCoAjJ
X-Received: by 2002:a17:906:f58e:b0:c25:c954:faf2 with SMTP id a640c23a62f3a-c25d563a41cmr836658066b.21.1788445935349;
        Thu, 03 Sep 2026 07:32:15 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-c25f42861c1sm107705166b.63.2026.09.03.07.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:32:14 -0700 (PDT)
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
Subject: [PATCH net-next v2 8/9] net: bridge: vlan: add missing tinfo.tunnel_id annotations
Date: Thu,  3 Sep 2026 17:31:37 +0300
Message-ID: <20260903143138.1574598-9-razor@blackwall.org>
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

When I annotated data races around tinfo.tunnel_id before, I missed a few
places (e.g. bridge notifications, rhashtable compare), so add them now.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
v2: assign tunid_curr/last later due to long lines

 net/bridge/br_netlink_tunnel.c | 14 ++++++++------
 net/bridge/br_vlan_tunnel.c    |  2 +-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/bridge/br_netlink_tunnel.c b/net/bridge/br_netlink_tunnel.c
index e7eceab5b515..e64054628ac9 100644
--- a/net/bridge/br_netlink_tunnel.c
+++ b/net/bridge/br_netlink_tunnel.c
@@ -29,8 +29,10 @@ static size_t __get_vlan_tinfo_size(void)
 bool vlan_tunid_inrange(const struct net_bridge_vlan *v_curr,
 			const struct net_bridge_vlan *v_last)
 {
-	__be32 tunid_curr = tunnel_id_to_key32(v_curr->tinfo.tunnel_id);
-	__be32 tunid_last = tunnel_id_to_key32(v_last->tinfo.tunnel_id);
+	__be32 tunid_curr, tunid_last;
+
+	tunid_curr = tunnel_id_to_key32(READ_ONCE(v_curr->tinfo.tunnel_id));
+	tunid_last = tunnel_id_to_key32(READ_ONCE(v_last->tinfo.tunnel_id));
 
 	return (be32_to_cpu(tunid_curr) - be32_to_cpu(tunid_last)) == 1;
 }
@@ -43,7 +45,7 @@ static int __get_num_vlan_tunnel_infos(struct net_bridge_vlan_group *vg)
 	/* Count number of vlan infos */
 	list_for_each_entry_rcu(v, &vg->vlan_list, vlist) {
 		/* only a context, bridge vlan not activated */
-		if (!br_vlan_should_use(v) || !v->tinfo.tunnel_id)
+		if (!br_vlan_should_use(v) || !READ_ONCE(v->tinfo.tunnel_id))
 			continue;
 
 		if (!vtbegin) {
@@ -124,19 +126,19 @@ static int br_fill_vlan_tinfo_range(struct sk_buff *skb,
 	if (vtend && (vtend->vid - vtbegin->vid) > 0) {
 		/* add range to skb */
 		err = br_fill_vlan_tinfo(skb, vtbegin->vid,
-					 vtbegin->tinfo.tunnel_id,
+					 READ_ONCE(vtbegin->tinfo.tunnel_id),
 					 BRIDGE_VLAN_INFO_RANGE_BEGIN);
 		if (err)
 			return err;
 
 		err = br_fill_vlan_tinfo(skb, vtend->vid,
-					 vtend->tinfo.tunnel_id,
+					 READ_ONCE(vtend->tinfo.tunnel_id),
 					 BRIDGE_VLAN_INFO_RANGE_END);
 		if (err)
 			return err;
 	} else {
 		err = br_fill_vlan_tinfo(skb, vtbegin->vid,
-					 vtbegin->tinfo.tunnel_id,
+					 READ_ONCE(vtbegin->tinfo.tunnel_id),
 					 0);
 		if (err)
 			return err;
diff --git a/net/bridge/br_vlan_tunnel.c b/net/bridge/br_vlan_tunnel.c
index 257cae9f1569..04751f15d708 100644
--- a/net/bridge/br_vlan_tunnel.c
+++ b/net/bridge/br_vlan_tunnel.c
@@ -22,7 +22,7 @@ static inline int br_vlan_tunid_cmp(struct rhashtable_compare_arg *arg,
 	const struct net_bridge_vlan *vle = ptr;
 	__be64 tunid = *(__be64 *)arg->key;
 
-	return vle->tinfo.tunnel_id != tunid;
+	return READ_ONCE(vle->tinfo.tunnel_id) != tunid;
 }
 
 static const struct rhashtable_params br_vlan_tunnel_rht_params = {
-- 
2.47.3

