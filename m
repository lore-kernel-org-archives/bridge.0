Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B88C26E165
	for <bridge@lists.linux.dev>; Mon, 30 Mar 2026 19:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774898210; cv=none; b=AWiXCAhhJ9jyu5j9dYWSlMbX8W5QXZhV2t9fEo6AovqVTY5j4R+GTvXiHyvl2uKGvh9WHrisbsIY+iPFbrLJ/rVcT6LkYDrS6JhuyA3aCSITLzRWQGgytx349pDFu62CrZ8xZ1Es4CUpEmKJOqMsCs5FQ8PL3zpO4bnuMT4WIhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774898210; c=relaxed/simple;
	bh=kZVwnXWURA3X/G1DyhA5FWIIj06eTQFconwOEGeohEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZQsTSTJXAXRvkh/ymO3jpubPpvdZ1O3nFO8Ur8Qk1s3qf6bV3wy40NLVA9Jdjeoxm++2MCZ0/FOQMcTO7Bm0fWoPErMQfAXZjmC3VtHDXALOW2qPHSPlqb3F/jZZjngHYDFC330WqUqkfsl1mLFcGrHPOIEnzBVmZd1WsArgUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/O+NvTx; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/O+NvTx"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35d94f4ee36so1342793a91.3
        for <bridge@lists.linux.dev>; Mon, 30 Mar 2026 12:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774898209; x=1775503009; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6LmQvHoJMIuzVDw1ku5rpZrRgMMk/C43OeFB++Ma9c=;
        b=a/O+NvTxB7/5CPMyfOSl4nXD4NO3uFz74RJMg+fPAzPJdeZ9OiHdK+wxSUY2LoQa73
         R7DuOF2bZ5so5v64KQAIiwene1r313zsvvX2S60ZKAtyh++sq7x2VAO64VmtOz35LsFc
         VBpXoZlTlugJpHcvTJbgcRKhZovmxrTlTUFmcDwMsj9Ay8id0kqbQfH7OPlz7MuCDfpf
         YU7Ra+gac5M1Ee1+t+bUpqOFAwSOUCLqye36Rc1Gg8+fC4Mns8bK/QdW6/zT+3bHFCWy
         T6mWaLNb3tdr9Mji/59i4Wn/mn5zUAdXSHTEMuSj0I3UB8WFtrClbvV4PXiThMo+OTHK
         1bwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774898209; x=1775503009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L6LmQvHoJMIuzVDw1ku5rpZrRgMMk/C43OeFB++Ma9c=;
        b=htpTuspZN97Ldd5JJV9VfpBpc/ZkfJdQlWx9he4SBymjaFg/H/cA5Jm4gv2cqfkSgw
         xPVlx513u8jNtlOsFvXJU3zviebeeR3zW1eyFcCj5GiOHRoAQTkOPWEmF7sSy2nDSDPU
         0NdNiHCtijuywvSzfs6ALtWUtxfvCFiuuoH7Ag89bBnf9S9Fs7kvfXG7gAvW74MJIChc
         6qFkRLT9EjNYoyO56ZQ0wwJflM0uU+LaXthCXDI34tgDNQBCxOCev5A9ewIt9iRcpsUC
         ueDFvbb39npX8TkyIN5GJ+BgEjjc4RdtlbJ/vUCtLKoqS7lXKd4ueTiWWX+/XnuQhr76
         uoMA==
X-Forwarded-Encrypted: i=1; AJvYcCXJcs3vgG6d4NxBYv8Qg/bhukBdzQMxSyausnJckd3Mf6/omiu3BHtUuYLpFnAxDVOsNeeqO/I=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzybm+c2NdyWD3yfMyLN8FTetru3kUXyy2l8Ix0AXnOmrL9CYHD
	k5gH0ZPZDEhmODm+Qmm8TF2BbvHH+OvP8neBEID1aXT39ERvyP3XgbOY
X-Gm-Gg: ATEYQzwp/og16Twf/0GimIt46Pd+AhVozoyZNbQRouKLMDM9FQDZ0YIGZs40g0VKF6k
	xfV/9R0cpo+ES8wfZ6QbjtmhFmO742VLnp5RlFZVeGT3nww+NZ6dm5/W7rnTxboP6H4mLFSp1Py
	qW1O8ekGO67juo5TlQgDKLI6MSZ6+eoJowL2X2VocMUCmqElP83ORmQjJMqd91bhffvLUXtxYP7
	uiKZlJF0fVfKmJbQ2hOeVNJqdXqJuJf+kIgle2CRnlN0HUO7ZdcGttEsXbM8jnGxkI2ZcuNssOX
	77iJKb06vJNYaKUzxJt6I3Z2gqe2EmNl+SxPJvIh/Vx518A7NuqFcOOrmlCbhpl+rlJIxK5y6Nt
	2886Xr5qho74Hpmf6kgC9q4qglVPOABUURIIFYSGLj9O+yS81x2s+Ng4vjeV+4xfQd+Gv7p7sjp
	8ckxaMlqcjs6pfoEaSd1ewjiRlC3Faf1ZDShfggvWY
X-Received: by 2002:a17:90b:4b0e:b0:359:8e5e:43de with SMTP id 98e67ed59e1d1-35c300c19d2mr12577177a91.22.1774898208327;
        Mon, 30 Mar 2026 12:16:48 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35d950d9b12sm9627178a91.17.2026.03.30.12.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 12:16:47 -0700 (PDT)
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
Subject: [PATCH net-next v2 3/5] ipv4: igmp: encode multicast exponential fields
Date: Mon, 30 Mar 2026 19:16:09 +0000
Message-ID: <20260330191611.16929-4-royujjal@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330191611.16929-1-royujjal@gmail.com>
References: <f23ed1b3-6321-4e6d-9cda-ec5d34304f3b@blackwall.org>
 <20260330191611.16929-1-royujjal@gmail.com>
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
index 3c12c0a63492..3a4e9cec3959 100644
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

