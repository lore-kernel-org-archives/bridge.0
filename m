Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A9349E15C
	for <bridge@lists.linux.dev>; Mon,  5 Oct 2026 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211216; cv=none; b=saUJ7dkg0njwBjMIEnXDkZVeAPHWQvwK+deab+8jLvudPzNkZuZLpMmLDOVp9ETK+xkk0L6PHLT+FtqhQUkJ78P866REG/4jBT/QbT0XSDoS2c0WxKpcZZkSdtsqCuO06OSEhYHaX8h/9RFIz7U/2FE9EHGeDcpr03P8uVQRLbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211216; c=relaxed/simple;
	bh=RRWozVHTotAkW5kYj0hU5Xgt5Xu3zoj4m11js62A+Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jzhIPdtmyVeym83P3E1fkBhNKi1yZA+GNwE67OkTxQFvlMpDXNJ39tO72p+kBib3euje4F0BBt2FMcpC2b3C3V+cHcMHVplpuAAEZXmPV12EmD8Fvxz9eyWD+dbnsOG2s+HpFTs9CdlJSPoNgAOBRFisrwDPGsjyvgfec+NHhcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=JaLIanQC; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="JaLIanQC"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so19622505e9.0
        for <bridge@lists.linux.dev>; Mon, 05 Oct 2026 07:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1791211201; x=1791816001; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EYtXcI173soT5vTdt1+eussUhxIt+D0gw4zaR9j1Ifc=;
        b=JaLIanQCSgdLX7oLsA8+muvvVVgv2JjVip4B8JYPZGxv3JeEzqMJyNoqhu87A5GHqG
         vh6UBTxPlRSG7yIjCywqFSn8SDir2t5ngJqyjW/F3VoFyOjgXjka0lbZ5O4nT5xpUczu
         455c5BW0GzwYtL+jdfdObQZVfnSsQYlafFCiwUvZk0zTV5Co4ncI4/UZZ+KsresqUIbJ
         ogmTWJ28AyIVlK88rbSZn0K8xaYoDNOFNWPpL/PviHE8ZUJw2uEkdDNnOABlbljRkT2J
         tLje6AGNFAezZbws+lq/kILPeOCa6B56iZ8zuukRFu4iXj8InzxGm+cbfzIv1JzgAlo5
         dfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791211201; x=1791816001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EYtXcI173soT5vTdt1+eussUhxIt+D0gw4zaR9j1Ifc=;
        b=iLBFbly3Kz9SyJ9oyjTi192YIdmg7mTn1vtVY+9umk0RvNVJ16Zm2NlwNaFBt0Q9cF
         XDh7PJ2QE3YEFdiuZdgw8n71xnRZLKfjp0qFz1Fo4xHHg+s2vnIVF3NboVjEns3kmUG8
         Dc7R6b8GybfhfBYvWLKqTJ9UD6P6K9QHzHrYAg/QW3owGY1EF3f3dF8360rI08gpkgau
         t3xPaij8LC4KHhwAVjcd/yMqs3uapAM9+KMzzrjSNC2BGFen8ut4hKgIEB8GNSW26Vhl
         NmyppfsGymL5Ruzn0LVEwp5zD6GAVsO1sRCxl6vAwCvTZN0DiJf/mE7h/memKJjYXl4N
         9EWA==
X-Forwarded-Encrypted: i=1; AKwUvByj6sR2Nrvs3VFnRvrC5pRN0FvE/ZN+36MQh7IqutpSiZHhbyWlc2kBGjSAwin8IM7rSOZ49cY=@lists.linux.dev
X-Gm-Message-State: AFuF++mnZaySPonWw280zCTebzTd7keR4vr9f2PoFaIdSGwP9LHVZ5gu
	LIzTaslNE2cf90EQjuvpFgaSwNO1BSeHzelbr/WN3HubjkjGmWkUC9bIS8OYol6gKOg=
X-Gm-Gg: AYBFou0jAJEm1kFyLD0qrP/0UCtOvGFpkDZ3IMoDtXQnGzKPrT1T0FRw4/sODY4g0A9
	K9Z1kkUBARFJ6/dTpwSnDyyhG75QkzHPAHNPId/E610zkcjxDwfKgKYyf8Tpj2iTtizRh3ABCiw
	VZBA+X2aW9L6dyByWXrkRCwZ5ARTVZKBuf+yRwRHK0J5ZSaHIZDRPUhmPYxIYF6JOct/SptUZQp
	Ohp8MygB1SLcHnl4SfKoDkjqFFFaw6c28wyYghAdABFy4c58g5uzAvtLVQc0IcKCoImxc985S7U
	QfxYfXZBa+f1fxHvXhWOfy7j2a6ahBvBPcXLh/dl/i3Ja+Wsf+NLr3IdXRuF6dJxGG+M5n4q4Np
	yX79ta3ZqtrOobw9dB94VH6qWJRgqUOGHu2vxWq4JCQj+DRd9mgi8HKKXZ/8fsfNWMI9fnW5p5/
	sy/Sm1ToN0jYByXIJFPhEDlZrXOesUXszvaQR5oAvMIQitaG6YQkMTO8hL7Qvpeg/JBaL/pGBNW
	ANxpPcv3H6qgSu0mOoA
X-Received: by 2002:a05:600c:3b01:b0:49c:ffab:551f with SMTP id 5b1f17b1804b1-4a1680ed179mr109451445e9.22.1791211201035;
        Mon, 05 Oct 2026 07:40:01 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a02752aeb3sm359304555e9.0.2026.10.05.07.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 07:40:00 -0700 (PDT)
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
Subject: [PATCH net-next 6/6] net: bridge: fdb: use the entry key in __fdb_update
Date: Mon,  5 Oct 2026 17:39:37 +0300
Message-ID: <20261005143937.877466-7-razor@blackwall.org>
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

The address and VLAN ID passed to __fdb_update() match the key of the entry
just found, so we can just use it.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_fdb.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 927e5f23df5b..b601245ad923 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1000,7 +1000,6 @@ static void __fdb_update(struct net_bridge *br,
 			 struct net_bridge_fdb_entry *fdb,
 			 struct net_bridge_port *source,
 			 struct net_bridge_dst dst,
-			 const unsigned char *addr, u16 vid,
 			 unsigned long flags)
 {
 	struct net_bridge_port *old_port;
@@ -1012,7 +1011,8 @@ static void __fdb_update(struct net_bridge *br,
 	if (unlikely(test_bit(BR_FDB_LOCAL, &fdb->flags))) {
 		if (net_ratelimit())
 			br_warn(br, "received packet on %s with own address as source address (addr:%pM, vlan:%u)\n",
-				source->dev->name, addr, vid);
+				source->dev->name, fdb->key.addr.addr,
+				fdb->key.vlan_id);
 		return;
 	}
 
@@ -1055,7 +1055,8 @@ static void __fdb_update(struct net_bridge *br,
 	}
 
 	if (unlikely(fdb_modified)) {
-		trace_br_fdb_update(br, source, addr, vid, flags);
+		trace_br_fdb_update(br, source, fdb->key.addr.addr,
+				    fdb->key.vlan_id, flags);
 		fdb_notify(br, fdb, RTM_NEWNEIGH, true);
 	}
 }
@@ -1075,7 +1076,7 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 
 	fdb = fdb_find_rcu(&br->fdb_hash_tbl, addr, vid);
 	if (likely(fdb)) {
-		__fdb_update(br, fdb, source, dst, addr, vid, flags);
+		__fdb_update(br, fdb, source, dst, flags);
 	} else {
 		spin_lock(&br->hash_lock);
 		fdb = fdb_create(br, dst, addr, vid, flags);
-- 
2.47.3

