Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473B33CA4AA
	for <bridge@lists.linux.dev>; Fri,  3 Apr 2026 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775228485; cv=none; b=t0Y2YcDVhGwgbx7T5XGXkvnzXyto6rh1Fi0SswPRFzdHyi5KkdOPyVeWji1UhpSN5hCJsZMgmdXsy0USTvzjArUoL5ah0IIOqs31tliV4ylMfsXyLiZjtrosA8LrjGtDRU+F8oOyqVuVjvYy3fLY3zbK0keGw2+ge63CdhqGUzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775228485; c=relaxed/simple;
	bh=Iq0tktjsX7ePEwq4lGlKSL1uL+gib4ijw7o7rXmI/94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=STSn48/XIlRGMCsM2ehvTo6mZAmy6ZKgkelW0WN4T5od/HmkzsUNchQkawD1X+Nbv9S6QJFNZ8hhjXupfOt3DsSs2l7C53LOuRWq/iAoWBa9z5iWDNCleSjRfkpYRJjp/oho3GXheQm60W01NeIi7tdkKbdKDk6ARvamLOdyIyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBxcKH6u; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBxcKH6u"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82cef263bedso952183b3a.0
        for <bridge@lists.linux.dev>; Fri, 03 Apr 2026 08:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775228483; x=1775833283; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4ZMqjHC+tTjU8qo0ldftPqXLWyA0cBMe3rgBvQvxRs=;
        b=nBxcKH6u9I3pKl6SNt+Qw04RZmOT1J7+sOKngMt9BjzCiK07ffxS0OauTjepG3jcKx
         Gt615qLcrszUmerfGuXM/YRvA3xpFdJTDK/nrFHkGmhC8FDgpDi6OyL54tZn42oCgRfp
         gj/sRsamJvxacEYbQHWcA4Vu5qpTx89ps2I2btK7Z0nFvwKsiECB2Mu4w7626ASTiJup
         w5L64kwkluoh/BlcAFX2rwRnyQ5W5mWI8tDYPS+Eux/0PvAoQvtOKbAjJPIo2uh67G+8
         cKZ0eyDaAGhhVcMIjyRoh4BK6SxbDSB991fyf162sHe/YqbPM+8tsdP1X06sYpx3OrNk
         iRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775228483; x=1775833283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W4ZMqjHC+tTjU8qo0ldftPqXLWyA0cBMe3rgBvQvxRs=;
        b=ZoMD3KJ7kVIQPzjJK2s7LveWhItF00Q3FICCIAlG0FT6tAH7lUF18uBlKAt43n0xVK
         L8XWdlPHDx9ePucRWXKPZWCi/xr3zX8nS0u6wNLaO0ywinWqs1gp4LT3X44xwxoO5Nds
         xDqD3Vu41B0rHSl7ZTeQwqeSuC/FI3UKEPAtt6nAkvi/7J1YFm2hw0Ad6apYpcrTSph7
         TBIYUut2cs6QnKl+OhmjUUXo88NeqGD/sj+60d27zP/RcMWAU2cGhqogCuG/2ks0LX9T
         bmX+d+G8rOAZSGQeEABXX2eyOrW3P2K3RjNdfT+HPzhU336vUZ5Y477rKnrkYUVrWB/P
         QJzQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2/kCZeSDIZTcvVF72AacDLjv4Y8jc645q9VfxBAN4xi/Hz8rXveEmElfWOCEDBc8qlS+aLig=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx6pQ5h1zP3fWl0PR/vB7Ljt5nyPI4eFgs9sDLSHQofInDeUB6F
	ecERWv4CsYIQxDlVyXyKe5W517vtlDVo+883aBWgkUXDQc/1X+AWxYaJ
X-Gm-Gg: ATEYQzzlWmX3KtHNSl9dTsH6wq04roo2G7zrUvvj+0t9OjV/8h4ScavwW/XPW+rGu/u
	+7ajPxAvyxl1tPOnEvRGCS+bHJVavW23T3oe4v0UHt872y4yuF8630PR4poJZiFBmqyqIALx5hA
	C+4K1wCtv4YybFWyVRxtV9jPLFCK/2LOMK7KAQKCGdLYrv4qYD1CqWNQ2ncFn+trpzqcVv2mxto
	JLA18LgrtysK9b3YkEARYvKHZKwVuW0dsDTqEVbCE8Wuj5lbz0wfW8fc92JbQNggeHaQMetEGN+
	8FVzQ6HyTFmt5lhqPZBN9YN5cLaBVn2eM3YfJWQ4sS6u9PX4gSiWM1GKjswrn8QszMpsaHXrwgn
	RGrBF5jTrCo+82PXAPRSiMFUO5RbwKEfrqNPPUbmm8yG0fTu3HAg8XKL/hFThsDW3r0dhRJRw+c
	DuwLv4jovZFvjo/pf+xM9OznxhW4sRSr8xL6o9XQJ20TcEy6Gm5do=
X-Received: by 2002:a05:6a00:4397:b0:829:862d:6b46 with SMTP id d2e1a72fcca58-82d0da2f24bmr3265722b3a.6.1775228482267;
        Fri, 03 Apr 2026 08:01:22 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9ca79basm7789483b3a.58.2026.04.03.08.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 08:01:20 -0700 (PDT)
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
Subject: [PATCH net-next v3 3/5] ipv4: igmp: encode multicast exponential fields
Date: Fri,  3 Apr 2026 15:00:48 +0000
Message-ID: <20260403150050.1235-4-royujjal@gmail.com>
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

In IGMP, QQIC and MRC fields are not correctly encoded
when generating query packets. Since the receiver of the
query interprets these fields using the IGMPv3 floating-
point decoding logic, any value that exceeds the linear
threshold is incorrectly parsed as an exponential value,
leading to an incorrect interval calculation.

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
 include/linux/igmp.h      | 87 +++++++++++++++++++++++++++++++++++++++
 net/bridge/br_multicast.c | 14 +++----
 2 files changed, 93 insertions(+), 8 deletions(-)

diff --git a/include/linux/igmp.h b/include/linux/igmp.h
index 0624410e75c6..4e895829cd0e 100644
--- a/include/linux/igmp.h
+++ b/include/linux/igmp.h
@@ -109,6 +109,93 @@ struct ip_mc_list {
 
 /* IGMPV3 floating-point exponential field threshold */
 #define IGMPV3_EXP_MIN_THRESHOLD	128
+/* Max representable (mant = 0xF, exp = 7) -> 31744 */
+#define IGMPV3_EXP_MAX_THRESHOLD	31744
+
+/* V3 exponential field encoding */
+
+/* IGMPv3 QQIC/MRC 8-bit exponential field encode.
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
+		return value;
+
+	/* Saturate at max representable (mant = 0xF, exp = 7) -> 31744 */
+	if (value >= IGMPV3_EXP_MAX_THRESHOLD)
+		return 0xFF;
+
+	mc_exp  = fls(value) - 8;
+	mc_man = (value >> (mc_exp + 3)) & 0x0F;
+
+	return 0x80 | (mc_exp << 4) | mc_man;
+}
+
+/* Calculate Maximum Response Code from Max Resp Time
+ *
+ * MRC represents the encoded form of Max Resp Time (MRT); once
+ * decoded, the resulting value is in units of 0.1 seconds (100 ms).
+ */
+static inline u8 igmpv3_mrc(unsigned long mrt)
+{
+	/* RFC3376, relevant sections:
+	 *  - 4.1.1. Maximum Response Code
+	 *  - 8.3. Query Response Interval
+	 */
+	return igmpv3_exp_field_encode(mrt);
+}
+
+/* Calculate Querier's Query Interval Code from Query Interval
+ *
+ * QQIC represents the encoded form of Query Interval (QI); once
+ * decoded, the resulting value is in units of seconds.
+ */
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
index 1438c023db62..27010744d7ae 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -934,12 +934,12 @@ static struct sk_buff *br_ip4_multicast_alloc_query(struct net_bridge_mcast *brm
 	size_t pkt_size, igmp_hdr_size;
 	unsigned long now = jiffies;
 	struct igmpv3_query *ihv3;
+	unsigned long lmqt, mrt;
 	void *csum_start = NULL;
 	__sum16 *csum = NULL;
 	struct sk_buff *skb;
 	struct igmphdr *ih;
 	struct ethhdr *eth;
-	unsigned long lmqt;
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

