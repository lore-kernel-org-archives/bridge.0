Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9754AB3DC
	for <bridge@lists.linux.dev>; Mon,  5 Oct 2026 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211203; cv=none; b=UsSAs6olyx1kVfWI0iu8WVHK1km5Y/jq9g7XhtgpdtmEJlwgS2JNFo3lEAiz+vmpEYbvZ/1c2HJP2fyggtMCF95mGiAkradCINbSsQciV5B0yNgGQd78kJ7fCCelCgaz7X2ccvpcVuUVWTbTn3SmiwgJQxs70fgA/jAbUYyskig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211203; c=relaxed/simple;
	bh=bc3UIeJGXymNWzviGzi36dDwbhBuh5YOUZaBLyslBh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IctEoLy2dC24e4toCsaLuQYDBpqbumOaOvYUR6RFFOHgmzmsgnkE9RWI6EElSFy5FZjYFSCf4v2d+gUxbaSxmXAqwX3w8CMoZa4Ay+s/IGQBqv3J6z80p/qVkY0wb8DiFZWHlLYa1yihZuDvxCJIWhllBsEnD+M9ZfCpU/lgZsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Kr0Ogx/u; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Kr0Ogx/u"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48b02b1b4cfso584585f8f.0
        for <bridge@lists.linux.dev>; Mon, 05 Oct 2026 07:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1791211196; x=1791815996; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xM7Nwx8pyio9tSiG3XrEnckcr2m2atmYD5UuxvLKzZY=;
        b=Kr0Ogx/uOhP3rirH1i1XpvJBwPzSwBfpnjhY9n5CnV5U3W723T0Qmyd4C1y1a82VDT
         c9p8RcEa9bfnY2EA5Tyl3thGJx/eOY/JGfnwK72f0Ig4ltADofCDixknmND1pzoGE1W2
         yb9QqCzVCCT6Rmjkdq4pC0LZs1Ydy9J8z+kGbjDgjaIfkEKEZKZvZugZNVq1K/IRvkBI
         C9/VzdrWXIpco3vfF7xBmw4Ebp3mqKhdljfedOzWB+X9m0nnE3iiiyYSS+wMdwnro6QD
         dJm11PitY2xdQ6X33I0HjNP0GJXW3U6RaIq08KDXOejBxF2j7LsKyPy5fKr4hzgFRWwd
         Z+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791211196; x=1791815996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xM7Nwx8pyio9tSiG3XrEnckcr2m2atmYD5UuxvLKzZY=;
        b=VLpNYwpPOmzhOD+0Cfj5BeHv0qv7XJjpvW3S6BuQAyj4Rsh1ppZq5ZbkJfv3NLu5xJ
         mh8QPIg4dWonqyBSDZRf3ZqqXys46RByEbe44mR/koQorvIr0yojQQarpnVzYU5zyqio
         JGiVPzaojXKWOd2HWSBb+2YsAJxxCFm8vzWHyuNVd0GD1iQSYmN6zCbnwppgfCtEU00u
         KATTDQnH94whtz7S/q6BNeI8Cg6jG99mabBeudbZTnyXsUr2xRUzGxHRIpGQnChbcKPH
         b10Cu+iIAvyDGJanpuR6ZdfYzxAaDiBMSmyiBTDfYFiSYJEW00XsDSMuF8OE6AshWFE0
         ugAQ==
X-Forwarded-Encrypted: i=1; AKwUvBxGkKF1nZWlGf5P50H86cdPo5JCRJHkt3nEGAq2XqsLbM+5g6Z9aquusBx+TY2m3IOzvMY1L/4=@lists.linux.dev
X-Gm-Message-State: AFq9FYJ1gxLUXZwOrQDT7mZbqfLnvKMftbjIVGj121ChbBplld/O+DXK
	96FXiYgxspSpC2ptbtfOIZA+2sq7nDED/BIKSLYzI75yt0zMEAAk5okq2ClVrsPkA4M=
X-Gm-Gg: AYBFou2rKc5fneVLcd+JsTQwRzttV/oOJ2zHAQELRO6WcgS3K/Jb4c/OkFfjGApWm1u
	smQTCdURmChIsAEYpq711ePL0vHIgUaah2Z5yO9liGcl8ZQaVGaMkLefBaxa8gJdJjnRJfQhfZR
	NDg5dmjDnRGwWhnjhYQ8T+0Z1BXJjq2hnIrWZcVluuWhsGdA/hVdPCsm4pdT+kBh1HajRu/J2J5
	Azh9PQ7ZJB4Y9XWdWsxw/cO/ZPGaoNSw01hxBfoYvsKX+BDrT7VnMyeiDHHALHe57wC6lbFf5cm
	wgKIh+BrGmlTnuL3mfZZ7E0ghaulyqNOJ81kUu2G1TbWK3uoVbEd+pyUX2GTw3Y3HEHF7RNgfKw
	pegBveBQcJHDQ5a2wyGR4MadF7pidgWMyZhjTNILXURlciOVZsPbI9C1yo5XNAJw8vn7TTvQxME
	Vfh7myZWzgaHC3FHFYvl6i5LMJhfvz8jt2Qvz7ukqEbApl0DnlvDkumaiu+Oi76eDQalpgqw3iC
	HAFc6sjtaOEn6mTjRqW
X-Received: by 2002:a05:6000:648:b0:48c:55c1:fb47 with SMTP id ffacd0b85a97d-48c55c2040amr9419659f8f.10.1791211195153;
        Mon, 05 Oct 2026 07:39:55 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48c622704c1sm3388213f8f.10.2026.10.05.07.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 07:39:54 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 1/6] net: bridge: rename dst to fwd in br_flood_vlan
Date: Mon,  5 Oct 2026 17:39:32 +0300
Message-ID: <20261005143937.877466-2-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005143937.877466-1-razor@blackwall.org>
References: <20261005143937.877466-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename dst to fwd to be consistent and avoid confusion (dst is used for
fdbs).

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_forward.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 82645db32efb..54365c6104b5 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -291,7 +291,7 @@ static int br_flood_vlan(struct br_fwd_dst *prev,
 {
 	struct net_bridge_vlan_port_array *array;
 	struct net_bridge_vlan *masterv, *pv;
-	struct br_fwd_dst dst;
+	struct br_fwd_dst fwd;
 	int err;
 
 	masterv = br_vlan_is_master(v) ? v : v->brvlan;
@@ -301,18 +301,18 @@ static int br_flood_vlan(struct br_fwd_dst *prev,
 
 		for (i = 0; i < array->count; i++) {
 			pv = array->vlans[i];
-			dst.port = pv->port;
-			dst.vlan = pv;
-			err = br_flood_port(prev, &dst, skb, pkt_type,
+			fwd.port = pv->port;
+			fwd.vlan = pv;
+			err = br_flood_port(prev, &fwd, skb, pkt_type,
 					    local_orig);
 			if (err)
 				return err;
 		}
 	} else {
 		list_for_each_entry_rcu(pv, &masterv->port_vlist, port_vlist) {
-			dst.port = pv->port;
-			dst.vlan = pv;
-			err = br_flood_port(prev, &dst, skb, pkt_type,
+			fwd.port = pv->port;
+			fwd.vlan = pv;
+			err = br_flood_port(prev, &fwd, skb, pkt_type,
 					    local_orig);
 			if (err)
 				return err;
-- 
2.47.3

