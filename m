Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD203C8711
	for <bridge@lists.linux.dev>; Fri,  3 Apr 2026 15:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775228469; cv=none; b=I7znMnFgX36+eu3IUo3kO3HI7euACsO6k5rphHM6/GQHLWJLppviQ/LUVGDZGqGkXfAKoYtqBfXD5gROQw2oWtTw3nHjGK5UM7NDfftNctMjeh6Tp2d2GPWOx9WkCxKmnY9PoBE1E1uZjIGGENYkqm1nf0AuAcPBypdqickIgU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775228469; c=relaxed/simple;
	bh=J0qBZOFYr25CwqolwkVoKoYOv65Rm2yGyYDO9qaRe6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxWD5oDC8441AAcxqzakT72Km/O77Oew8M4P6k2/fpuf/vvWc6OXdaVPuvG+/NmWI+Ue803NdC7HZNSBtXWv5sDpbb9vKM9ucrMNGCkimXQvH6lJqGIhf+rugriY6f6Oh98mlZbcXK83bXB/e7bvoBMUM66zSG/PsHxgMnOWepo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tby7YfLs; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tby7YfLs"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82cd6614a90so869099b3a.3
        for <bridge@lists.linux.dev>; Fri, 03 Apr 2026 08:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775228467; x=1775833267; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cej7nCKLEwnUD6W7mDHvwY/cOSNtwOIhgAuZzAFc2ac=;
        b=Tby7YfLsmV2nOb9dhMdZXwRZ8EVgd3+ODN5/L1b5iEF8THk4rx+b+/SYpM3lQeymru
         qL1hwJ1SbaYHGMQBotoXsCM8xtz7sADnIMdix9JEhGfzszZ9gzorwJUXMg/800sMytOB
         YfpZQbR1ydP9QzOLAYNU0YVazutA1mEyg3HXQKucl0/BkTWYwtWiKRWJjPRPEI7Jfoil
         HcSfaGoE0mBB8p/krtqm5bjmqQby6dn/x1lAfJ7Ldl2kuG5xi4cGBlrsyZKXB8PpXLBj
         BDhNYqKEkZJEF5fpKMSdb2LCagqJwC8JL1c8uRWuGktZIjuOCAZePqERRDqTzUMxRr3T
         UFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775228467; x=1775833267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cej7nCKLEwnUD6W7mDHvwY/cOSNtwOIhgAuZzAFc2ac=;
        b=Yuld2j3G6t2zkeqCxZb7DMgGPF1zlq5zKaaobVeF9IjAuZBCcMNKJ/xt+Um1F0klXz
         AeOCH76IOFC66djw5lxUPXX0EFgKt82rtmmK+k9ODUP4Cl23eXW7ulqSdpmfinlAng3o
         lUnd65PFSZ2MaVah1fSu50THU9mT4mqRX7xGydq+yhx+3boDxomXtiWx3gNLEEB210LA
         vL1FVpQS0O8zyqCxvB6cQt2eDYwZcg8l5jiYVdPKUt8wglGVP13UpJNGc7mACyDjfclt
         MseeNkU0M0DKUvujkxDyQvAFh6cV1ZSwUDzx9KlPqAVLjH+fqWClZsl19puVEeewWzQy
         OeWw==
X-Forwarded-Encrypted: i=1; AJvYcCUUv1MVbuzfKREM4irl/cCylBtdgRC1vaYkBw8Z2bvDSYudWSpGMq2Ep/TvfLd+REL0LbUqLm4=@lists.linux.dev
X-Gm-Message-State: AOJu0YwK8ONhsJyKQBtA3ZfRzdh4YjurRdIhZGWKpk69HgAW4h2/+cQy
	uMtJLqLH15imXy7OTlIjyQcMrVtuafoqSil+g4dfVLrdmG9eWMfj1GrP
X-Gm-Gg: ATEYQzzWYVKKB9LSrpFcS046/Qr6vxPTIvWkefWRYLjztAKZqheLkc4yXAs42gDTmyT
	o3OZjNP0xCzBbfBhWpnR1vGDnRf3vcVW0gjiIibBcKr63sDpW9+HLD+xhI3WaRRlLHachR42QzK
	oL8s74jh44AfAirGhC5FcoZrukX9G38vPXlg40Ikuk7jyGwpfZ30N/OzKSe6rltlUfxWteSD21Y
	hPm9KR8xh51YBgfQwd0cPQoT1oDsNBtqlxDxrIoTO916k/tujPPvMGsyCOSHulSfUaHDnmurkCd
	bQ8Ycg7NA1L/t9VSkyTRtZ72oWg4O/TeAVX6lZUsSeaoE2gH5NcGoQDo81Vgqv10fchoMBGH8P+
	gBtv96JMSBvn1op4eygzhpsLsayH3EI2UHU+5JVbOjVj5Yd3CvKvCCtjTwa/QfyOh1WUbr5MiFA
	4eptEkEZughh5eymylIK4zrANgWVPVi6OL7w6lT+UX
X-Received: by 2002:a05:6a00:8018:b0:82c:215d:5e9d with SMTP id d2e1a72fcca58-82d0db6bfc5mr3316415b3a.32.1775228467048;
        Fri, 03 Apr 2026 08:01:07 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9ca79basm7789483b3a.58.2026.04.03.08.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 08:01:05 -0700 (PDT)
From: Ujjal Roy <royujjal@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Andy Roulin <aroulin@nvidia.com>,
	Yong Wang <yongwang@nvidia.com>,
	Petr Machata <petrm@nvidia.com>
Cc: Ujjal Roy <ujjal@alumnux.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v3 1/5] ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplify calculation
Date: Fri,  3 Apr 2026 15:00:46 +0000
Message-ID: <20260403150050.1235-2-royujjal@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403150050.1235-1-royujjal@gmail.com>
References: <20260403150050.1235-1-royujjal@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Get rid of the IGMPV3_MRC macro and use the igmpv3_mrt() API to
calculate the Max Resp Time from the Maximum Response Code.

Similarly, for IGMPV3_QQIC, use the igmpv3_qqi() API to calculate
the Querier's Query Interval from the QQIC field.

Signed-off-by: Ujjal Roy <royujjal@gmail.com>
---
 include/linux/igmp.h      | 84 +++++++++++++++++++++++++++++++++++----
 net/bridge/br_multicast.c |  2 +-
 net/ipv4/igmp.c           |  6 +--
 3 files changed, 80 insertions(+), 12 deletions(-)

diff --git a/include/linux/igmp.h b/include/linux/igmp.h
index 073b30a9b850..0624410e75c6 100644
--- a/include/linux/igmp.h
+++ b/include/linux/igmp.h
@@ -92,15 +92,83 @@ struct ip_mc_list {
 	struct rcu_head		rcu;
 };
 
+/* RFC3376, relevant sections:
+ *  - 4.1.1. Maximum Response Code
+ *  - 4.1.7. QQIC (Querier's Query Interval Code)
+ *
+ * For both MRC and QQIC, values >= 128 use the same floating-point
+ * encoding as follows:
+ *
+ *  0 1 2 3 4 5 6 7
+ * +-+-+-+-+-+-+-+-+
+ * |1| exp | mant  |
+ * +-+-+-+-+-+-+-+-+
+ */
+#define IGMPV3_FP_EXP(value)		(((value) >> 4) & 0x07)
+#define IGMPV3_FP_MAN(value)		((value) & 0x0f)
+
+/* IGMPV3 floating-point exponential field threshold */
+#define IGMPV3_EXP_MIN_THRESHOLD	128
+
 /* V3 exponential field decoding */
-#define IGMPV3_MASK(value, nb) ((nb)>=32 ? (value) : ((1<<(nb))-1) & (value))
-#define IGMPV3_EXP(thresh, nbmant, nbexp, value) \
-	((value) < (thresh) ? (value) : \
-        ((IGMPV3_MASK(value, nbmant) | (1<<(nbmant))) << \
-         (IGMPV3_MASK((value) >> (nbmant), nbexp) + (nbexp))))
-
-#define IGMPV3_QQIC(value) IGMPV3_EXP(0x80, 4, 3, value)
-#define IGMPV3_MRC(value) IGMPV3_EXP(0x80, 4, 3, value)
+
+/* IGMPv3 QQIC/MRC 8-bit exponential field decode.
+ *
+ * RFC3376, 4.1.1 & 4.1.7. defines the decoding formula:
+ *      0 1 2 3 4 5 6 7
+ *     +-+-+-+-+-+-+-+-+
+ *     |1| exp | mant  |
+ *     +-+-+-+-+-+-+-+-+
+ * Max Resp Time = (mant | 0x10) << (exp + 3)
+ * QQI = (mant | 0x10) << (exp + 3)
+ */
+static inline unsigned long igmpv3_exp_field_decode(const u8 code)
+{
+	/* RFC3376, relevant sections:
+	 *  - 4.1.1. Maximum Response Code
+	 *  - 4.1.7. QQIC (Querier's Query Interval Code)
+	 */
+	if (code < IGMPV3_EXP_MIN_THRESHOLD) {
+		return code;
+	} else {
+		unsigned long mc_man, mc_exp;
+
+		mc_exp = IGMPV3_FP_EXP(code);
+		mc_man = IGMPV3_FP_MAN(code);
+
+		return (mc_man | 0x10) << (mc_exp + 3);
+	}
+}
+
+/* Calculate Max Resp Time from Maximum Response Code
+ *
+ * After decode, MRC represents the Maximum Response Time (MRT) in units
+ * of 0.1 seconds (100 ms).
+ */
+static inline unsigned long igmpv3_mrt(const struct igmpv3_query *ih3)
+{
+	/* RFC3376, relevant sections:
+	 *  - 4.1.1. Maximum Response Code
+	 *  - 8.3. Query Response Interval
+	 */
+	return igmpv3_exp_field_decode(ih3->code);
+}
+
+/* Calculate Querier's Query Interval from Querier's Query Interval Code
+ *
+ * After decode, QQIC represents the Querier's Query Interval in units
+ * of seconds.
+ */
+static inline unsigned long igmpv3_qqi(const struct igmpv3_query *ih3)
+{
+	/* RFC3376, relevant sections:
+	 *  - 4.1.7. QQIC (Querier's Query Interval Code)
+	 *  - 8.2. Query Interval
+	 *  - 8.12. Older Version Querier Present Timeout
+	 *    (the [Query Interval] in the last Query received)
+	 */
+	return igmpv3_exp_field_decode(ih3->qqic);
+}
 
 static inline int ip_mc_may_pull(struct sk_buff *skb, unsigned int len)
 {
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 881d866d687a..9fec76e887bc 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -3518,7 +3518,7 @@ static void br_ip4_multicast_query(struct net_bridge_mcast *brmctx,
 			goto out;
 
 		max_delay = ih3->code ?
-			    IGMPV3_MRC(ih3->code) * (HZ / IGMP_TIMER_SCALE) : 1;
+			    igmpv3_mrt(ih3) * (HZ / IGMP_TIMER_SCALE) : 1;
 	} else {
 		goto out;
 	}
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index a674fb44ec25..d7eff36d98c3 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -991,7 +991,7 @@ static bool igmp_heard_query(struct in_device *in_dev, struct sk_buff *skb,
 		 * different encoding. We use the v3 encoding as more likely
 		 * to be intended in a v3 query.
 		 */
-		max_delay = IGMPV3_MRC(ih3->code)*(HZ/IGMP_TIMER_SCALE);
+		max_delay = igmpv3_mrt(ih3) * (HZ / IGMP_TIMER_SCALE);
 		if (!max_delay)
 			max_delay = 1;	/* can't mod w/ 0 */
 	} else { /* v3 */
@@ -1006,7 +1006,7 @@ static bool igmp_heard_query(struct in_device *in_dev, struct sk_buff *skb,
 			ih3 = igmpv3_query_hdr(skb);
 		}
 
-		max_delay = IGMPV3_MRC(ih3->code)*(HZ/IGMP_TIMER_SCALE);
+		max_delay = igmpv3_mrt(ih3) * (HZ / IGMP_TIMER_SCALE);
 		if (!max_delay)
 			max_delay = 1;	/* can't mod w/ 0 */
 		WRITE_ONCE(in_dev->mr_maxdelay, max_delay);
@@ -1016,7 +1016,7 @@ static bool igmp_heard_query(struct in_device *in_dev, struct sk_buff *skb,
 		 * configured value.
 		 */
 		in_dev->mr_qrv = ih3->qrv ?: READ_ONCE(net->ipv4.sysctl_igmp_qrv);
-		in_dev->mr_qi = IGMPV3_QQIC(ih3->qqic)*HZ ?: IGMP_QUERY_INTERVAL;
+		in_dev->mr_qi = igmpv3_qqi(ih3) * HZ ? : IGMP_QUERY_INTERVAL;
 
 		/* RFC3376, 8.3. Query Response Interval:
 		 * The number of seconds represented by the [Query Response
-- 
2.43.0

