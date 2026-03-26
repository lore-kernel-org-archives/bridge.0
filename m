Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5CD402429
	for <bridge@lists.linux.dev>; Thu, 26 Mar 2026 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774537686; cv=none; b=JKYYq2YecF2yiiUv7uerOYWVbJORtuFpqTlp2mqvHGFvtIOhKYDIQmtyM2hhp+OlQV2kIpOR8FdPMUUd3oeyZ2cO0LKDCoRPbtdL1VuVOFFGAAaUuC91KDO0j+auvPPxsw8MOpwnHk+ODFGtDdwLAKszdJXsZ7HpBL3cRdL528Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774537686; c=relaxed/simple;
	bh=SrJ8v2JXUP4BQ/htK1TW22nfXu8yKqHl2EOzmrry8MI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJwE6l3nbwhCOI1DY+IiCGVXvS2I+FiBvQkteDQV2vHG7hSyFmk1VMZkcf04/pHVA2rVpksU9SfmzLMR+ERhjn64tbE4hsPK6wSNoBGYuEp0mLUfbUG3BhU0Br/I46PxGJJLwjWGyZrxSLmBLdxnLdyKR8Cj+J+mUub6r7a8VYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmVhnyhF; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmVhnyhF"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2adff872068so4538555ad.1
        for <bridge@lists.linux.dev>; Thu, 26 Mar 2026 08:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774537684; x=1775142484; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htKXcnTzcKDeqjMpn8hCX3YfwiSQQ8z5MdKwPZHhth8=;
        b=LmVhnyhFjvinh5cWdkzgDBYi2v60jvtc6q3wCq+66Y/LFYq284a1GBtbCt+pBgQ09+
         CKnLhBMOxpUlREQw1MRck13uUijpwKCNp++Ol0Dpco/DEvqkrbSpEIxK+VYkrQfPxma2
         PJRbBDFogbhTrlaH+JqSsz3TqIMJhTMZdD+MpIXRf3mcocYBYvmqIf9b+z4hUo6iMmnW
         Vm5yjvaE4rpW95Tod0w4yM9idlV3OEH4seHXl+cRWyXQWjpiKRUnmAVqqgoGpnMtIs7o
         TeUjfCrBbWresbXQE123wH6Mk76DO/biHPCcruddIctR7cBKrrF1maSyt1EouA48nSCm
         p9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774537684; x=1775142484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=htKXcnTzcKDeqjMpn8hCX3YfwiSQQ8z5MdKwPZHhth8=;
        b=EwIMxCfaLdxuvA0VGBDNZDWi5yaold6q5nGGsJUIZuuYDtyIjqm+Tqi91lp5eWcTe0
         Wlu6ftwizNrMdK6xwgoCVHWXALUYB44os0N790NK+CkgsewOx+Fs2l5j49DqaUuqxnYw
         vXob1vhkdQYYrmEBfNHpFH2QiyxU4c5ZZNXho25Rtnjq5rykLfg9kz00HYJVIBNMahdw
         1gNOSySI9KvwEN2307PZEouwdY5ZfKaqBM+utPZ9mSmw5aRPCEQ6YlTAAkD29NPB9lfM
         79A1P7i0UfVSEh/j50ZOIVPDdni0Ds5MKdfwE42PDkdrI6piQn4cxHN9k4TU3HJB1w63
         J5Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUVW4zdWRjOz3JvdnYGFcwCWGgCC4EnAnJVK+X8Qr+Fui9kmMpwgsFhHnDIN1Jn0pdFPRiUpjs=@lists.linux.dev
X-Gm-Message-State: AOJu0YzpgMVuerCz9ZDe4F0y84AJyxd/hdMZk4yqckdw213BVasI/HXZ
	76TevHnMkCDCzHnYzhuF89xjMymdcXEnT/N17mjyr5mV9/BEQK+w8eLb
X-Gm-Gg: ATEYQzz6qhH+2TD9Uzb3tUYprirIMNjFhkGBJXR+3i0Vzra8kZgQ+GE5ih3b7Jj1ApX
	cfV2LnYVptK3fOfAkPIQCNLJI3tZETFaCWW5Xbtc/fz5eQC5CqtH/V8GCcMH8rrnfvlu/dQNoQS
	4lejuFDA72QAFFgCB91WsFhSFTRG+rOrBZqw0JqueViE7tDaQpBx2yB+2L+ViXY6SzaSj0aukQJ
	PyuSYlIyZdNsrm5U63R7JVfEgX2FJDBcHuBsSn/eI/FEhw/DJxkL3LDnsnpxx4bhYrDeCYBCchR
	YMAbaK53B1BlCEWHagGFA9Y3NyA8lw6BSxjwQi55W26qlocRVg7HdHR1hnqt7zD8t3poXyOyfHi
	U4hVSEamFbJbmWoVDEptMLGD1EhAfiGKdA0RYM7RqFdFZvNJWKIB9nIoYCr8K9icbanxDuQcT9u
	NbxbNjcnO1FaYeJiROY+z/KEt6Gyg5VCj18NzgBV10
X-Received: by 2002:a17:903:3884:b0:2ae:5655:b16 with SMTP id d9443c01a7336-2b0b0a140d0mr86962365ad.21.1774537684401;
        Thu, 26 Mar 2026 08:08:04 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8bb5fasm33146375ad.59.2026.03.26.08.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 08:08:03 -0700 (PDT)
From: Ujjal Roy <royujjal@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	David Ahern <dsahern@kernel.org>
Cc: Ujjal Roy <ujjal@alumnux.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] ipv4: igmp: encode multicast exponential fields
Date: Thu, 26 Mar 2026 15:07:41 +0000
Message-ID: <20260326150742.50289-4-royujjal@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326150742.50289-1-royujjal@gmail.com>
References: <20260326150742.50289-1-royujjal@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In IGMP, QQIC and MRC fields are not currently encoded
when generating query packets. Since the receiver of the
query interprets these fields using the IGMPv3 floating-
point decoding logic, any raw interval value that exceeds
the linear threshold is currently parsed incorrectly as
an exponential value, leading to an incorrect interval
calculation.

Encode and assign the corresponding protocol fields during
query generation. Introduce the logic to dynamically
calculate the exponent and mantissa using bit-scan (fls).
This ensures QQIC and MRC fields (8-bit) are properly
encoded when transmitting query packets with intervals
that exceed their respective linear threshold value of
128 (for QQI/MRT).

RFC 3376: if QQIC/MRC >= 128, the QQIC/MRC field represents
a floating-point value as follows:
     0 1 2 3 4 5 6 7
    +-+-+-+-+-+-+-+-+
    |1| exp | mant  |
    +-+-+-+-+-+-+-+-+

Signed-off-by: Ujjal Roy <royujjal@gmail.com>
---
 include/linux/igmp.h      | 80 +++++++++++++++++++++++++++++++++++++++
 net/bridge/br_multicast.c | 14 +++----
 2 files changed, 86 insertions(+), 8 deletions(-)

diff --git a/include/linux/igmp.h b/include/linux/igmp.h
index 3c12c0a63492..99fce6b0625f 100644
--- a/include/linux/igmp.h
+++ b/include/linux/igmp.h
@@ -110,6 +110,86 @@ struct ip_mc_list {
 
 /* IGMPV3 floating-point exponential field threshold */
 #define IGMPV3_EXP_MIN_THRESHOLD	128
+/* Max representable (mant = 0xF, exp = 7) -> 31744 */
+#define IGMPV3_EXP_MAX_THRESHOLD	31744
+
+/* V3 exponential field encoding */
+
+/*
+ * IGMPv3 QQIC/MRC 8-bit exponential field encode.
+ *
+ * RFC3376 defines only the decoding formula:
+ * QQI/MRT = (mant | 0x10) << (exp + 3)
+ *
+ * but does NOT define the encoding procedure. To derive exponent:
+ *
+ * For any value of mantissa and exponent, the decoding formula
+ * indicates that the "hidden bit" (0x10) is shifted 4 bits left
+ * to sit above the 4-bit mantissa. The RFC again shifts this
+ * entire block left by (exp + 3) to reconstruct the value.
+ * So, 'hidden bit' is the MSB which is shifted by (4 + exp + 3).
+ *
+ * Total left shift of the 'hidden bit' = 4 + (exp + 3) = exp + 7.
+ * This is the MSB at the 0-based bit position: (exp + 7).
+ * Since fls() is 1-based, fls(value) - 1 = exp + 7.
+ *
+ * Therefore:
+ *     exp  = fls(value) - 8
+ *     mant = (value >> (exp + 3)) & 0x0F
+ *
+ * Final encoding formula:
+ *     0x80 | (exp << 4) | mant
+ *
+ * Example (value = 3200):
+ *  0               1
+ *  0 1 2 3 4 5 6 7 0 1 2 3 4 5 6 7
+ * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ * |0 0 0 0 1 1 0 0 1 0 0 0 0 0 0 0| (value = 3200)
+ * |        ^-^-mant^ ^..(exp+3)..^| exp = 4, mant = 9
+ * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ *
+ * Encoded:
+ *   0x80 | (4 << 4) | 9 = 0xC9
+ */
+static inline u8 igmpv3_exp_field_encode(unsigned long value)
+{
+	u8 mc_exp, mc_man;
+
+	/* RFC3376: QQIC/MRC < 128 is literal */
+	if (value < IGMPV3_EXP_MIN_THRESHOLD)
+		return (u8)value;
+
+	/* Saturate at max representable (mant = 0xF, exp = 7) -> 31744 */
+	if (value >= IGMPV3_EXP_MAX_THRESHOLD)
+		return 0xFF;
+
+	mc_exp  = (u8)(fls(value) - 8);
+	mc_man = (u8)((value >> (mc_exp + 3)) & 0x0F);
+
+	return 0x80 | (mc_exp << 4) | mc_man;
+}
+
+/* Calculate Maximum Response Code from Max Resp Time */
+static inline u8 igmpv3_mrc(unsigned long mrt)
+{
+	/* RFC3376, relevant sections:
+	 *  - 4.1.1. Maximum Response Code
+	 *  - 8.3. Query Response Interval
+	 */
+	return igmpv3_exp_field_encode(mrt);
+}
+
+/* Calculate Querier's Query Interval Code from Query Interval */
+static inline u8 igmpv3_qqic(unsigned long qi)
+{
+	/* RFC3376, relevant sections:
+	 *  - 4.1.7. QQIC (Querier's Query Interval Code)
+	 *  - 8.2. Query Interval
+	 *  - 8.12. Older Version Querier Present Timeout
+	 *    (the [Query Interval] in the last Query received)
+	 */
+	return igmpv3_exp_field_encode(qi);
+}
 
 /* V3 exponential field decoding */
 
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 1438c023db62..1de6242413e0 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -939,7 +939,7 @@ static struct sk_buff *br_ip4_multicast_alloc_query(struct net_bridge_mcast *brm
 	struct sk_buff *skb;
 	struct igmphdr *ih;
 	struct ethhdr *eth;
-	unsigned long lmqt;
+	unsigned long lmqt, mrt;
 	struct iphdr *iph;
 	u16 lmqt_srcs = 0;
 
@@ -1004,15 +1004,15 @@ static struct sk_buff *br_ip4_multicast_alloc_query(struct net_bridge_mcast *brm
 	skb_put(skb, 24);
 
 	skb_set_transport_header(skb, skb->len);
+	mrt = group ? brmctx->multicast_last_member_interval :
+		      brmctx->multicast_query_response_interval;
 	*igmp_type = IGMP_HOST_MEMBERSHIP_QUERY;
 
 	switch (brmctx->multicast_igmp_version) {
 	case 2:
 		ih = igmp_hdr(skb);
 		ih->type = IGMP_HOST_MEMBERSHIP_QUERY;
-		ih->code = (group ? brmctx->multicast_last_member_interval :
-				    brmctx->multicast_query_response_interval) /
-			   (HZ / IGMP_TIMER_SCALE);
+		ih->code = mrt / (HZ / IGMP_TIMER_SCALE);
 		ih->group = group;
 		ih->csum = 0;
 		csum = &ih->csum;
@@ -1021,11 +1021,9 @@ static struct sk_buff *br_ip4_multicast_alloc_query(struct net_bridge_mcast *brm
 	case 3:
 		ihv3 = igmpv3_query_hdr(skb);
 		ihv3->type = IGMP_HOST_MEMBERSHIP_QUERY;
-		ihv3->code = (group ? brmctx->multicast_last_member_interval :
-				      brmctx->multicast_query_response_interval) /
-			     (HZ / IGMP_TIMER_SCALE);
+		ihv3->code = igmpv3_mrc(mrt / (HZ / IGMP_TIMER_SCALE));
 		ihv3->group = group;
-		ihv3->qqic = brmctx->multicast_query_interval / HZ;
+		ihv3->qqic = igmpv3_qqic(brmctx->multicast_query_interval / HZ);
 		ihv3->nsrcs = htons(lmqt_srcs);
 		ihv3->resv = 0;
 		ihv3->suppress = sflag;
-- 
2.43.0

