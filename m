Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8C73AE195
	for <bridge@lists.linux.dev>; Tue,  1 Sep 2026 12:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788264470; cv=none; b=udPSKXK+GiPRFDIO5FK3vyQlyFIzLcjnbvuMe1mCuTLEK+Rn2bUszAquP+zv6jMIIReirZAwvIZDcsDRlMJvxqCoT5nXabpY+X51noNTcwq20clYqV5oiCpKCKVjPyWhvp8L2qyWLetDJZXLmQNRdzp+lxLr5IDk2CwupYbTC6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788264470; c=relaxed/simple;
	bh=SxImGqPf0zfqDmVkBuiZjei+0XPbUZkCD0Ehro4yeHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HrQegAmqxutQCZKfdZMNNr2fb7yhV+WyK2yOHLAxfX+QiUExUlY0ZU/YQfXxbixDBcEG+pS8kJ0x1fmhCXQQoxpSK1miOGwTlp7p+RT2sPA3gzPG52SJXlBu01oHd8vvOyLk7M4xfTV7qdklDWOZbIN9o+g/lxWerAQVYhaZ+10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=aMBTFy/n; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="aMBTFy/n"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48431648f33so729131f8f.0
        for <bridge@lists.linux.dev>; Tue, 01 Sep 2026 05:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788264467; x=1788869267; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RIFTrDCPgDQphKZqho55YQsD68R4VC9Mx+L02Osc+Z4=;
        b=aMBTFy/nkwPK9Dn15E59XtvZ9Vwz3GDY+kxY10zil1bwfIFFrUDvnFo74yZAdcZ0So
         Osn3U/Y/BD1wKZZffvk9UtOWkzUuSkn7S1lSSAqAd4N91BSjfQZptMaXO+N9Xt5lKgSZ
         t76oY8TI4/KAkdSUjAzPe3YRy7zSWO3pXj4U599wE1Mi4FFpqMaPj6Gwzckp9wZEaw96
         R5il4ZaR25DX8/unDWDjJzvKwcvJlw7WE0c/us6Gg91FbD2pPryLwvgSltC0k1tE5dl6
         mFZnPEeexjqgJB7P0Fer5Dhod5N8ImHd0xFRgD/5eWy8jpUMSF8KwpI+3dlBlbp0t1U2
         J+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788264467; x=1788869267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RIFTrDCPgDQphKZqho55YQsD68R4VC9Mx+L02Osc+Z4=;
        b=KXa+KqoJx95jho51DQTzOF7iJ5qAHepRkZ4GrRUSiyUp4/+Y6xLcSXWZaX2wqB2qll
         MZymxgwZVGuYBu2WhLwgjaC4bJhSC4dTuLNAW+YTvbH849qdjt+B8v6+zKBKhkkVD016
         iqyWzjE2z3VzJyIKoaG0Plc8TA6v4NPg5fpQadZ558gv8+DTdWEQBNUHHV3ySi8t2FaG
         GbYS6uZnyK4gJzge04x9uQBZq/XX7sSm0/CnaraDSEF+bYqgLd0HWSR2ZEPDznAgtFWS
         w+3q+ksHpPEimu6z0cTRiXJXSn2Btr/4Ea4yECnTQMAluH4J31SJqClpmxFWN0iTK/fj
         SH5Q==
X-Forwarded-Encrypted: i=1; AKwUvBy8DOkD/EbHYO2lr8A5diFAqg7/0i9aZt8GcLeXQYV9IB1fwoTm7n4SMBP1sptf7yMVwCa+kQo=@lists.linux.dev
X-Gm-Message-State: AFuF++n6bHyRPnyM2IHmJ/lcRXv4Z8N5WGiGCXCvhAFZZatDue/9ToGL
	eRXgzoLzeiYz3d9Osc0lkaFxQg4sa2m4Zbw3WN4yViJWz463wvduPgTrslxdiTgceaw=
X-Gm-Gg: AYBFou1TFYxPn+9Ha4uCV7Qmp1rbZai8UNLCh9zW9q1pseOy79VRvJc6IA1HKZG6joZ
	90UxsTsYZD6wZP6dl8eqGecm3FBzrgkLhyr42CCWO9b/22d4MouOcJG+RTxaA8DIXbaAP3qGoiX
	AOPwJjbEaRIxtR2WyL8/4ybTfpNjGQSv5oShAVQbM6MNRif2q0K+LFaGDVfvN5VZcmM5MoVC/+4
	SY+td0J9qwFvoIq9QS1N2GSol4syckvbiqhb8E3ajoWOncMcYfgL1Oh+aEv/qAHbnIOmi2My0FK
	RMN0MSr2+xgIMUp7qLow66/7h5pIUv0o4hs/WYkcCOkGrfw5f3/2ZrM9lUT7gxzzA6QrB0hKDaO
	IUKcazLfuZqeilwUE1InZAxNJtrAgm2Hy8O5XGpMDTG4Az2ZzFA4pIKUKIlT5uzmpzMtgIVjZro
	+wRFFrJGdeiLNgbtQuLuALYoUUucvxiP5mf/fZuHyljfiapUUVGiHDBRRDD4/LTV5kf/NGJh/2B
	cYc9a/p7mU=
X-Received: by 2002:a05:6000:46cf:b0:484:44ec:2c3a with SMTP id ffacd0b85a97d-48444ec2e31mr5495395f8f.0.1788264467369;
        Tue, 01 Sep 2026 05:07:47 -0700 (PDT)
Received: from localhost (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48442d78444sm5108478f8f.25.2026.09.01.05.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 05:07:46 -0700 (PDT)
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
Subject: [PATCH net-next 7/9] net: bridge: vlan: annotate lockless use of msti
Date: Tue,  1 Sep 2026 15:07:19 +0300
Message-ID: <20260901120721.747908-8-razor@blackwall.org>
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

