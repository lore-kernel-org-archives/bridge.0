Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C465A4BAA14
	for <bridge@lists.linux.dev>; Thu,  3 Sep 2026 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445940; cv=none; b=DHMp4DN9DqvMgqqss1s+XI7Y66QdVDILHZ2n/GPxaaKgz44A3P2b8g2XuITRZA+d2jkxl8tPvFhJmNpEMogvblP20XvHZU8etD7ht7gwiOSbIqP/yBYI3r+2YWvVT6Sj09Z3DvO4Sm4FrOXYHobRo6ZDoJtU7/PXN4P58wOPQWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445940; c=relaxed/simple;
	bh=SxImGqPf0zfqDmVkBuiZjei+0XPbUZkCD0Ehro4yeHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7be1YQzEQLxmeAs4RIw2eLZopJ0zn8fI4efetpgBHJciBuGOmiydKqe0Am12PmKMHGvtvVsovbzv4GhAxk8CbX3MVIPP/NbgltNiucSJ5ja2WSKmoA3gRYD9xhZF8exU6UcLTOw+IqYz+8BxPVwT0UEGcctHT+tLnV3PHCKyTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=SyyXdjHY; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="SyyXdjHY"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49b8ce9b733so18360735e9.1
        for <bridge@lists.linux.dev>; Thu, 03 Sep 2026 07:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788445933; x=1789050733; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RIFTrDCPgDQphKZqho55YQsD68R4VC9Mx+L02Osc+Z4=;
        b=SyyXdjHY4vBqnsLZqSwsWXvr5OJSVIZBJ17z1KVddNh2W+3tsS5H/xuMj58dwN4Skv
         +WEoFBPduIcXJGASdGQsIIDAyLMUYOMt3IG7fY874ufCQuvMGq4BIBYzaqKSfnohdzQY
         KB3mevlXv9Mpu6MShhsp1gGbqQr9gkB9aRe8XEk0rs4pzNPvZqiL4F8r5v2/Z3dz3JB+
         Fy5RFF04gT2DnnGSficpGuOp5EqtggJZUDNnDCsv+UrJ+XJQRXqgU8QYB5BnOEtHkNxO
         Iz2rvCNDfRgrphurPjtxjvPtkYJCSok0aEEepDGg2ly7RAiXlAJb8Bu8LdJ0uO52v4ue
         vOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788445933; x=1789050733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RIFTrDCPgDQphKZqho55YQsD68R4VC9Mx+L02Osc+Z4=;
        b=J3suXdswsmmpgshwoKCYokvZQrs2qA9IUBEi2OGZBnr4isLCoNNUbLxPPnreH2/YC1
         sMAqGG0t5Pjyo9z7m3n6xtrhObJZa7Rd/7OYyiWqlK6LdVldwbQ123yvMUKCsejcjD8i
         TQvttPFYD3OpappJRNUlcZwkLHbv+FVQZ7SG+/XzBliZGtPdJFm2Och1vXOdYnD7oSHR
         P+atc/7u0QCgRkv1wkcMAi3hHv0VIb6fyU6vORoJ6gQXMRKy4aP6cXG5gcvzq9Y3e9iQ
         V1ZtH7X9g2PyyJdRc/yRC+drOh13coMoEqNnA4LcHjfFbyjSkLdD/w3GF74kAT+SZrKP
         yFOA==
X-Forwarded-Encrypted: i=1; AKwUvBzli+PoXFjS96NZGAQia8UY5JKRLPeBJqMBtehAxnNZL+KjFSNkWNc9ht9aOZSiBWhREClC4gg=@lists.linux.dev
X-Gm-Message-State: AFuF++kxasmbrakabDJDR0TVGM4gA+aaZ9pePYK5hj7RFboAYz7z3GOE
	IzQ3ofuth9xO/IgQZ7IAPFbRPpbfWYOlCTdWMwqU5fJhTBDNTYMxBWRAWty2faTFEvS+kgh1Af7
	RmqEWzBM=
X-Gm-Gg: AYBFou2zhm73htgPEZSiGUopcSz1r03de6R55YzAVVx1HWex7cvCLFMOrwjpLJLAJHp
	0PxtDNumAhA2SEjb0M9JMZlhcOdGq7w9+UUuxApD8Yph/rEOVuoA4MaDRUtokV0nKtm6zYek4PU
	9Fh5YSdTqWaZkD6wHopzjSDFWmP9tTc1xfb6wT49/ulKo+zb3Q4BjuxMmFc/VVL8tu65q/7H8iF
	TFiSG4En76l4RnHZEBr2jxK+QkEYJQ7qCrC9byyA+uQ/dHp850GHqXjKrShTSeXRpEKS3vaj3K6
	DuW86xfkgMgMN52hoR8/SsSSQ2zfP6vCLn2WSlF0sf4GTO0tEadVTwPHZ18o8R8DlS61tNeIlK3
	uPJdFi070tLKtcYX2QozH0bw61TZpc9sArmmMsLsJg8TYvIkJLFW8/9+pt25kq59/ItdR6aFULN
	jc6gREnhLxdyOp385IS7ngrKftSS+GhCrLMk7W9ZBr5LdXE+vlJW0Jywztuf8wK7IVfAc+iSF0y
	vTCSlNv0/g=
X-Received: by 2002:a05:600c:1907:b0:49c:ee08:6ed1 with SMTP id 5b1f17b1804b1-49cee1d993emr123427045e9.5.1788445933421;
        Thu, 03 Sep 2026 07:32:13 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49cee5dec54sm90165335e9.12.2026.09.03.07.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:32:11 -0700 (PDT)
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
Subject: [PATCH net-next v2 7/9] net: bridge: vlan: annotate lockless use of msti
Date: Thu,  3 Sep 2026 17:31:36 +0300
Message-ID: <20260903143138.1574598-8-razor@blackwall.org>
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

Annotate data races around vlan msti field, it can be read lockless.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_mst.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index 95e49ec8065e..76a5bf287578 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -123,7 +123,7 @@ int br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state,
 
 	err = 0;
 	list_for_each_entry_rcu(v, &vg->vlan_list, vlist) {
-		if (v->brvlan->msti != msti)
+		if (READ_ONCE(v->brvlan->msti) != msti)
 			continue;
 
 		br_mst_vlan_set_state(vg, v, state);
@@ -176,7 +176,7 @@ int br_mst_vlan_set_msti(struct net_bridge_vlan *mv, u16 msti)
 	if (err && err != -EOPNOTSUPP)
 		return err;
 
-	mv->msti = msti;
+	WRITE_ONCE(mv->msti, msti);
 
 	list_for_each_entry(p, &mv->br->port_list, list) {
 		vg = nbp_vlan_group(p);
@@ -249,7 +249,9 @@ size_t br_mst_info_size(const struct net_bridge_vlan_group *vg)
 	sz = nla_total_size(0);
 
 	list_for_each_entry_rcu(v, &vg->vlan_list, vlist) {
-		if (test_bit(v->brvlan->msti, seen))
+		u16 msti = READ_ONCE(v->brvlan->msti);
+
+		if (test_bit(msti, seen))
 			continue;
 
 		/* IFLA_BRIDGE_MST_ENTRY */
@@ -259,7 +261,7 @@ size_t br_mst_info_size(const struct net_bridge_vlan_group *vg)
 			/* IFLA_BRIDGE_MST_ENTRY_STATE */
 			nla_total_size(sizeof(u8));
 
-		__set_bit(v->brvlan->msti, seen);
+		__set_bit(msti, seen);
 	}
 
 	return sz;
-- 
2.47.3

