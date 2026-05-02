Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3527C23D281
	for <bridge@lists.linux.dev>; Sat,  2 May 2026 13:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777727968; cv=none; b=dbmIGwpnEwHo8jLG0/7YIDARtnh4DEFWiL0f8S4ppgMZi8Bu6jVwUbp60vq95E2VAertBX42EQPMFRqL3HiqwCtO6gvLFkw2O5frt6bvWf7W71tOEzxMb/SW1mqe0eaAfVr4efdYFMPnAvyyaZUmsKeFeD9crnKcvINK+o07Yps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777727968; c=relaxed/simple;
	bh=PH9zdGszS2v4ltP/Vm27MJNnYZX6pbBgq07/H3IXfok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDRG67Wc7XCAmhGIa1jAi4dA2onC4FhN+DGtzHD7vAO9RsLMO1oabNRkBJDFI9r0WLpQHU8xTbZKvLUhwyFRtzjmICUTnTLaWn7Ae1GyoDYdaGpapKIwpVdMUO2cu35puOrfabSpjHCE/E0ji0ACzf2e/xWJKhuH+EouXzXroH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLNouWNG; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLNouWNG"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82735a41920so1049089b3a.2
        for <bridge@lists.linux.dev>; Sat, 02 May 2026 06:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777727966; x=1778332766; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SBkUEIvhzDL4buR9DLMar8que8lJAciCkjc6oYU6Uo=;
        b=BLNouWNGbRXnmu7+mlK/D8J7/dnh/IdOo71b71i7iiuEB0Yf+93/WxFimOR6MqziN1
         rBFPMQybY/xmdvlUUfLjba805oBcWZ5FBwRoVsgpKUEUi9fVruolKg2IL4nRtjNUzfLO
         zRsHfaywgQOPBYQVSu49J9V9+dkMD+SljxKsITv7NCeFLP+iU+SzzzLApKKaKcDIIyci
         AVlPu+N/PzklISa+ihRudcoFF2hx9jAoV7yEfmpzGgsQjWgnIz9Fnj9Urn7hnAcm6CCI
         G7jdpNPs6rBUR2nUaBILQkgcElDTfqiooiLK9SaavbvI4696JGTUbjVTFAH1cLJ1OYFd
         8gkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777727966; x=1778332766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6SBkUEIvhzDL4buR9DLMar8que8lJAciCkjc6oYU6Uo=;
        b=CSKyoYt05kSWPikd4c04Bfbv/nbA40EplD/P/HgetBilUGUf9DylOx26OBpbrffhPq
         9ijLuDdodA/CqK0KBndY67RlrvzeFfG2di1YfhUTZO3lpcEZwzZqgAiwo6Kx1yKLS2Sc
         XC3Bx/YjIYdNOLjOO1PZ9R80/HLoagXuOf2p5IWbvhSnt5NN9jSUS4+JtAmXIlxRNrao
         0rsPW0rtcW/Ub6nWz0UpucoMHUijiGQ/RKeDJ7H4w1AVbOJ2QNSmVVZt1rYXf2wKgahh
         pP0EzT5UARy2wuqkUwEN5N00BO5CAfJ0u3s34qY1odoslBuGY5KfBT1SJNUSZFxbc1vy
         7azg==
X-Forwarded-Encrypted: i=1; AFNElJ+9dK/IpV1xopxsZKG/2o8ZoUd6iSToQ5piH9UDq/1pNfLtbu9emPpoqvEXE0+it1LmPBAHCRg=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7M2HCoBYsisl6zRhZC41llE/ALce3vYPu2zm3/Qv6tYUn6Z6m
	9GeCtWdDE7f8OaX8a78F+OTMf5HaxkiTdgYTwZM3GM6YkllJ72aWJnBEabzcE5ecwSE=
X-Gm-Gg: AeBDieuYc7t4edI/MFrm1g59SZJ+hxIrR2rG9snm3ShP3pSNwY4XgPkwWeJnsxxX7xb
	ncCSkV0ilScp/JuO5fF7BCYWsB8x01BI4/BL9omGl5sbOH1qjqHGSy3rsLoJurBDD23iWMB1xqJ
	zZyzVXWrRuksN6O5XTtT8rAq1+g2WWgZDbLhW5ZvXQ6So2ACkQtvKWzC2V8h3uloVXjMupJT+LJ
	nlwv4HOzfkPXt8ZYdlndU0Gt1ry+eIUmdclbQEgMgbu+F4O7R5ttlJJRSWINWxO/cR8UJXvwfmg
	p/wdL1/Rr48BJNwyUeijUCw6L6GooeqnVWCa8Kxpvt55gUNpEcIdSW5ZWEY5L3x6Vm/4ky8zinB
	fmvcS6AVTxkM46DyO3nk4cjP5tgqU/LylYuGIjxPmsOfrMnwkRJAE9ao35/cbO9fMSP41J2WCRN
	Jq8adPu61cp5Wt7bRiYs+nfJ4b3vN7j0OTlBBx3C/n7Llbdk3RQZlGfllIr6qC
X-Received: by 2002:a05:6a00:448b:b0:82c:d7c4:4c5c with SMTP id d2e1a72fcca58-8352d178e85mr3057979b3a.20.1777727966440;
        Sat, 02 May 2026 06:19:26 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515ad0176sm5553791b3a.39.2026.05.02.06.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 06:19:25 -0700 (PDT)
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
Subject: [PATCH net-next v6 1/5] ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplify calculation
Date: Sat,  2 May 2026 13:19:02 +0000
Message-ID: <20260502131907.987-2-royujjal@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260502131907.987-1-royujjal@gmail.com>
References: <20260502131907.987-1-royujjal@gmail.com>
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

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Ujjal Roy <royujjal@gmail.com>
---
 include/linux/igmp.h      | 80 +++++++++++++++++++++++++++++++++++----
 net/bridge/br_multicast.c |  2 +-
 net/ipv4/igmp.c           |  6 +--
 3 files changed, 76 insertions(+), 12 deletions(-)

diff --git a/include/linux/igmp.h b/include/linux/igmp.h
index 073b30a9b850..0e095c9f234e 100644
--- a/include/linux/igmp.h
+++ b/include/linux/igmp.h
@@ -92,15 +92,79 @@ struct ip_mc_list {
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
+/* IGMPv3 floating-point exponential field min threshold */
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
+/* IGMPv3 MRC/QQIC 8-bit exponential field decode
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
+ * RFC3376, relevant sections:
+ *  - 4.1.1. Maximum Response Code
+ *  - 8.3. Query Response Interval
+ *
+ * After decode, MRC represents the Maximum Response Time (MRT) in
+ * units of 0.1 seconds (100 ms).
+ */
+static inline unsigned long igmpv3_mrt(const struct igmpv3_query *ih3)
+{
+	return igmpv3_exp_field_decode(ih3->code);
+}
+
+/* Calculate Querier's Query Interval from Querier's Query Interval Code
+ *
+ * RFC3376, relevant sections:
+ *  - 4.1.7. QQIC (Querier's Query Interval Code)
+ *  - 8.2. Query Interval
+ *  - 8.12. Older Version Querier Present Timeout
+ *    (the [Query Interval] in the last Query received)
+ *
+ * After decode, QQIC represents the Querier's Query Interval in units
+ * of seconds.
+ */
+static inline unsigned long igmpv3_qqi(const struct igmpv3_query *ih3)
+{
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

