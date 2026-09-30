Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A8B4508F8
	for <bridge@lists.linux.dev>; Wed, 30 Sep 2026 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752511; cv=none; b=sZxvxD24TjClbhH/kaitWOqw5rUUlubJDKic3FpMBT/s5IZ2c+BU3Vq/5RudyEASEaHtvETAMz0i6i+donzjXwi6Z03YDTtf/ZNdhqPU9jZYUu9rx2T5Bu54fdoRAHTbqjC6pSvBf/nom7Dac38NtOw2B9Fwvb2jmsaqV8IN/1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752511; c=relaxed/simple;
	bh=bWE9ofDX9CCpzagYpyK7ryLzafK2njjC+bGI8hqcJSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNT7bJ1XzTrfm9sroHUEamoLS6tTxMI+ocrPqaRW0UKeur/5MJcgAb8N0bfXX5hXCyXPrRYmlhuBUux4PlmeVU9shokkden+A1p6FMZX3uGK6AVYIIm4RHlPrPMVuTpnOfIPBzZ+UOOELpwbhQCHG29uh8YgXrjTEAes2Q9IdCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=CPUtOLm9; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="CPUtOLm9"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48b01d89b23so124247f8f.2
        for <bridge@lists.linux.dev>; Wed, 30 Sep 2026 00:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1790752502; x=1791357302; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wh5ZySD4TgiYlccRMgkd8gbGRWxAVqs9TX0Efg3qKOU=;
        b=CPUtOLm9AWS+pxEIpvyXuuu05Hht6OqhAUhGpeXZH+5MaUBJzej57YL7iO1SRJ3qSB
         jqPZ2n3VZVfGhB/dCNZqsWAeRI2breWOUi0NA22brN/dDhmXE9PA7rOeEBny6mybPtz+
         6BKM1u3Gw+Cofc3V/qI5LCBHeBSXj0InMxMC4UVAs1rW0bVmTufHaMteQKzpSv28ehBl
         hTHkhKtaydJE0dtDFHUaewWc5kdlnUtD+VTvylwMBBNAC+8Bc9CUlqzLCj+vm8khKp6+
         lcCJXZWL9MtKbw01TklkeC3PfXE96apwAVBrQBh1brjwIyfYoTh04qrXO0CGjqsGEP8Z
         Jmgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752502; x=1791357302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wh5ZySD4TgiYlccRMgkd8gbGRWxAVqs9TX0Efg3qKOU=;
        b=pkW2NCC4g/tDEq39WVQXUqqZx7OFcCfD3mP9AY/5zy5rDtCPdmi9uQLavqSj+Jf4pp
         jT4AGppe5hywe19cZ4yxJ+1LsBVj+lK+CFzqAv4OT7z30qYQAui/N/WEOOIcmBSwrV3u
         5xK6YWm3tFPZqKtLux80ngCtu3lknafXicaMiECpuaK1wQhmwdWR7hecC0I2f8Xu3MBd
         YUXjZxsUh3kynunuDqYBxo139nPNSFttVbclDlzGKAs2BhcZPG5wn/hpUzhNFQ6Ng5JR
         W8Zn1oGORjvjdAgEYI7GDcbWRr/sl905F6wcgisG1DEfx98l8bOq/2enBtYUsP0APOj4
         aDyw==
X-Forwarded-Encrypted: i=1; AKwUvBz9Dy/9zJUjLl5pIXkDA/3Ye2G8mD/aq90ncZ/F4x6n9z0Xv1fy4N3myZAChkZznojAQdkXMYk=@lists.linux.dev
X-Gm-Message-State: AFq9FYLOVTwnEJTjxhquVEkkz703ZaxXweVM2dZgkKQriWKfU2TDcc3k
	2Ue/KGJ6oVUcKscQksLyaOk/VkPlrzuhTIR7kUKxZ2rgG88379ZZATRD9JdNch7c+B0=
X-Gm-Gg: AYBFou0sZ5bDNtZfkt86XvLk89BIUZ3xj6lE6UqTPm85ue/L4nQrs0PlehHU+5bUfZk
	4BysLCSd3iojz5Fbegf+pc61DSDXGpD+B/OhlbFBO6Nf657fTBt++NuyKlbvB2ctcDItxG2ZAD2
	7Idqt9Oa/ZaQbzS6iPG0lgLiCr76fqE3JB6a8EU0XIhNDm7FElniXzu74fyRa+srOhsrtBHVwZ1
	wCp+B4dixQXL0jvSaei2sgrLzsbiN2E1PWbmRcVc0nK/kccKVmrhJU8nZc8YjWYqeT0ePVuZdp5
	KUKeXt5e6sOECoy989kvPPisAYhUVlEJBede0ds1Pnn5NsVEjSTQxHj/p/NahhMb8HCDWB8Nlwu
	pCYOHq7DIZXiEcZZNS4pxqJss5PjeojOd+dUqCZpSsNOEsbCeSm0OlL92zgRJYui2FnN3MBogx6
	xbm9gseDL6HAQLdIH13H3RcPDpb4GgUB7Ehi37fgmPhZ6aYaMDpTLhtVYZub8BbR9gt6gi2jWNf
	I3gRK84rhW5SSLqDF7L
X-Received: by 2002:a05:6000:2408:b0:48a:f432:f266 with SMTP id ffacd0b85a97d-48b02380f8amr1072223f8f.0.1790752502446;
        Wed, 30 Sep 2026 00:15:02 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48b02e7b0d0sm732092f8f.14.2026.09.30.00.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:15:01 -0700 (PDT)
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
Subject: [PATCH net-next 03/12] net: bridge: add VLAN support to bridge destinations
Date: Wed, 30 Sep 2026 10:14:02 +0300
Message-ID: <20260930071411.2786201-4-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930071411.2786201-1-razor@blackwall.org>
References: <20260930071411.2786201-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use bit 0 to distinguish port-VLAN pointers from bridge port pointers in
struct net_bridge_dst. Add helpers for constructing and decoding VLAN
destinations. No caller creates one yet, so behavior remains unchanged.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_private.h | 50 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index bbb59b53e745..2bf7f4429a3b 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -306,6 +306,8 @@ struct net_bridge_fdb_key {
 	u16 vlan_id;
 };
 
+#define BR_DST_VLAN_TAG	BIT(0)
+
 struct net_bridge_dst {
 	unsigned long __private value;
 };
@@ -702,10 +704,56 @@ br_port_to_dst(const struct net_bridge_port *p)
 	return dst;
 }
 
+static inline struct net_bridge_dst
+br_vlan_to_dst(const struct net_bridge_vlan *v)
+{
+	struct net_bridge_dst dst;
+
+	ACCESS_PRIVATE(&dst, value) = (unsigned long)v | BR_DST_VLAN_TAG;
+
+	return dst;
+}
+
+static inline void br_dst_decode(struct net_bridge_dst dst,
+				 struct net_bridge_port **port,
+				 struct net_bridge_vlan **vlan)
+{
+	struct net_bridge_vlan *v;
+	unsigned long value;
+
+	value = ACCESS_PRIVATE(&dst, value);
+	if (!(value & BR_DST_VLAN_TAG)) {
+		*port = (struct net_bridge_port *)value;
+		*vlan = NULL;
+		return;
+	}
+
+	v = (struct net_bridge_vlan *)(value & ~BR_DST_VLAN_TAG);
+	*port = v->port;
+	*vlan = v;
+}
+
 static inline struct net_bridge_port *
 br_dst_port(struct net_bridge_dst dst)
 {
-	return (struct net_bridge_port *)ACCESS_PRIVATE(&dst, value);
+	struct net_bridge_port *p;
+	struct net_bridge_vlan *v;
+
+	br_dst_decode(dst, &p, &v);
+
+	return p;
+}
+
+static inline struct net_bridge_vlan *
+br_dst_vlan(struct net_bridge_dst dst)
+{
+	unsigned long value;
+
+	value = ACCESS_PRIVATE(&dst, value);
+	if (!(value & BR_DST_VLAN_TAG))
+		return NULL;
+
+	return (struct net_bridge_vlan *)(value & ~BR_DST_VLAN_TAG);
 }
 
 static inline struct net_bridge_dst
-- 
2.47.3

