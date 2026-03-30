Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330F6382291
	for <bridge@lists.linux.dev>; Mon, 30 Mar 2026 19:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774898217; cv=none; b=vGbanMXtiXZPmtPqNLccuDcPW2nKAiUR0mkHJA1VZve/FP24CM5zQLh1OeKHNpwvIrEMMa70h4WfrohkGiVrORkSanTEQTjtJiiwH10/lxE2Y+J5v+tY08r5x0kANvj+JZQpEzKCfzJsmWaHh8NhJBbgXQ+VkiW8uyTmDxE5kgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774898217; c=relaxed/simple;
	bh=/s+EgbT4cwqyAVP8otaVBOlL/dCCRmkYjYM+V8pat60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C3lvVTQFChXgD7QiTDKk/N6u9vzvvhrGKOw6uIFiQH0U5QbCVZ1h0kn7R2NwzRGv3Sa0u54Hs+2zL4Ys0sM5A31SFhXWFWIU4VSUHHaJw/28l1nDsG7chfobppFK+KMVNtxkUezlW8Val+ZFRxcuQOJZvuHonC4eKZwUu3m72Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPh0Wizf; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPh0Wizf"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35691a231a7so2946999a91.3
        for <bridge@lists.linux.dev>; Mon, 30 Mar 2026 12:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774898215; x=1775503015; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WISAf0QjUXrCjlDt5u3fdpEKEmBPI+ZNLLd/DIJAm8=;
        b=IPh0WizfobkAR+ZDCfDtbtYEaoJlTij2irV06T9vQc6Qo2SOSSnpIzMZ4dsp3PCvRt
         v1u0br//N8ZihDFkya1DhMOOpPVONZ6iNQ5ZNaRpPH8+ryfnd34J5jCRqpup3F/Ho3qz
         8lIsFvNrRyf+d0aK3foym3TJ+ok+scID0ugJlSYQQqxPN0iew9h8noeELgHP9VelEDRf
         JbWZ+tLN4eVAWIlxWAe8VHtHU1/CwWheJpFV+wiLHkE0J1OHO+6vdEiJuAIG9RRDK//f
         U+JMUpbsec/fyMdLoFyDZvnSHU8dO1skZmO79PPn2d0HM5vCWJa69n6uMYUJW+++MvgX
         iRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774898215; x=1775503015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5WISAf0QjUXrCjlDt5u3fdpEKEmBPI+ZNLLd/DIJAm8=;
        b=Z53aGrs7bLHUefr2hZMqG7jBiCSHJSD3VDTwSFraWXYH8j0PEcn5KvGQqEGjGuubaT
         zcEgmQsD70Sx90XLJNvJnGBZoj5CiWLRM0bMKNIWHY3KXQrfX2zYHhSamxcayawZt4gl
         9r5i4XHXc+uXqaSa8P49JGMONf8b2VldZflgOGPhg/9/1XUOez7qBcVra5kdu2yIE237
         sttyXaxv7DtZW9F7Mc61BGofKDKLwZt402kU457BdNheZaqSqU+ZswpqVhRJ+mnCaE8A
         bSl/I/jXnc02knEKlaZ2Dnzevb/VhKilx730p40qtTTrE26l4zgpGGv9fVc/cJHJMnvH
         qGZw==
X-Forwarded-Encrypted: i=1; AJvYcCWpO1oagdzwA8tZpMjeisMiSXPeOzT57lIRSkXsZAkEgnTqz1OTS3VL9PcUF2q8+QZg9Qy8tb8=@lists.linux.dev
X-Gm-Message-State: AOJu0YysSQNbNB1hH2f/FlajCvVjd4d/BZN1+Dbka3PU/cgGzX56YZkT
	btiNDXvT9q7vaGzcpNHsyCo/WfCeoFPtN7KknQAFRrO34cquOa3df8q4
X-Gm-Gg: ATEYQzz937Dz9QKQ7gHiTXhCy6km1M1ZuIEX3m4xrLd8KylNPbIWHgv+3n6qfUZdcAp
	l5iSRwqcQ0L2spyK0TwlDr5FylbUXZiol0nzrFG96PUiHuqw81fdAwQNSEcpgxrufFJ7IECjorY
	K4zuwDOqpz6HXpqcg9FAHVyd4dPQBFdXcFRgQqQAtkqkYVgcIfPIHwBIdqVsZsTWLTJ8zVsF0R3
	5yQzJUMWGUqCmeexkOG4j+whOKnTCjJZ8bKWKi+8HURpRfp6sT+0bsvvaiMm8RCljsAyRfaJohK
	OkWkofuV3VoniGhgKs0sz7TQkSqLCE4RBzrGOrbJ4AxAPq0bb9hc1bNmwjv5B49oGyzeL/ZzYoP
	khWysqR8D/QtdgeEKOVQezgim0l7IYx6iiRmPnN/NON03Xo6aOZBUXRi1rZtQPxdk+YxQVmHlyl
	BrVu/ApBgYr/rjqbJierh9sKy5X6MXnBQhY1zF9SWX
X-Received: by 2002:a17:90a:e7c1:b0:35d:a276:a87d with SMTP id 98e67ed59e1d1-35da276afa0mr6030327a91.27.1774898215457;
        Mon, 30 Mar 2026 12:16:55 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35d950d9b12sm9627178a91.17.2026.03.30.12.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 12:16:54 -0700 (PDT)
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
Subject: [PATCH net-next v2 4/5] ipv6: mld: encode multicast exponential fields
Date: Mon, 30 Mar 2026 19:16:10 +0000
Message-ID: <20260330191611.16929-5-royujjal@gmail.com>
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

In MLD, QQIC and MRC fields are not currently encoded when
generating query packets. Since the receiver of the query
interprets these fields using the MLDv2 floating-point
decoding logic, any raw interval value that exceeds the
linear threshold is currently parsed incorrectly as an
exponential value, leading to an incorrect interval
calculation.

Encode and assign the corresponding protocol fields during
query generation. Introduce the logic to dynamically
calculate the exponent and mantissa using bit-scan (fls).
This ensures QQIC (8-bit) and MRC (16-bit) fields are
properly encoded when transmitting query packets with
intervals that exceed their respective linear thresholds
(128 for QQI; 32768 for MRD).

RFC3810: If QQIC >= 128, the QQIC field represents a
floating-point value as follows:
     0 1 2 3 4 5 6 7
    +-+-+-+-+-+-+-+-+
    |1| exp | mant  |
    +-+-+-+-+-+-+-+-+

RFC3810: If Maximum Response Code >= 32768, the Maximum
Response Code field represents a floating-point value as
follows:
     0 1 2 3 4 5 6 7 8 9 A B C D E F
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    |1| exp |          mant         |
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

Signed-off-by: Ujjal Roy <royujjal@gmail.com>
---
 include/net/mld.h         | 117 ++++++++++++++++++++++++++++++++++++++
 net/bridge/br_multicast.c |   4 +-
 2 files changed, 119 insertions(+), 2 deletions(-)

diff --git a/include/net/mld.h b/include/net/mld.h
index 5e093f9c75d9..1ee7d3f68a33 100644
--- a/include/net/mld.h
+++ b/include/net/mld.h
@@ -90,12 +90,129 @@ struct mld2_query {
 #define MLDV2_QQIC_MAN(value)	((value) & 0x0f)
 
 #define MLD_QQIC_MIN_THRESHOLD	128
+/* Max representable (mant = 0xF, exp = 7) -> 31744 */
+#define MLD_QQIC_MAX_THRESHOLD	31744
 #define MLD_MRC_MIN_THRESHOLD	32768UL
+/* Max representable (mant = 0xFFF, exp = 7) -> 8387584 */
+#define MLD_MRC_MAX_THRESHOLD	8387584
 #define MLDV1_MRD_MAX_COMPAT	(MLD_MRC_MIN_THRESHOLD - 1)
 
 #define MLD_MAX_QUEUE		8
 #define MLD_MAX_SKBS		32
 
+/* V2 exponential field encoding */
+
+/*
+ * Calculate Maximum Response Code from Maximum Response Delay
+ *
+ * MLDv2 Maximum Response Code 16-bit encoding (RFC3810).
+ *
+ * RFC3810 defines only the decoding formula:
+ * Maximum Response Delay = (mant | 0x1000) << (exp + 3)
+ *
+ * but does NOT define the encoding procedure. To derive exponent:
+ *
+ * For the 16-bit MRC, the "hidden bit" (0x1000) is left shifted by 12
+ * to sit above the 12-bit mantissa. The RFC then shifts this entire
+ * block left by (exp + 3) to reconstruct the value.
+ * So, 'hidden bit' is the MSB which is shifted by (12 + exp + 3).
+ *
+ * - Total left shift of the hidden bit = 12 + (exp + 3) = exp + 15.
+ * - This is the MSB at the 0-based bit position: (exp + 15).
+ * - Since fls() is 1-based, fls(value) - 1 = exp + 15.
+ *
+ * Therefore:
+ *     exp  = fls(value) - 16
+ *     mant = (value >> (exp + 3)) & 0x0FFF
+ *
+ * Final encoding formula:
+ *     0x8000 | (exp << 12) | mant
+ *
+ * Example (value = 1311744):
+ *  0               1               2               3
+ *  0 1 2 3 4 5 6 7 0 1 2 3 4 5 6 7 0 1 2 3 4 5 6 7 0 1 2 3 4 5 6 7
+ * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ * |0 0 0 0 0 0 0 0 0 0 0 1 0 1 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0| 1311744
+ * |                      ^-^--------mant---------^ ^...(exp+3)...^| exp=5
+ * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ *
+ * Encoded:
+ *   0x8000 | (5 << 12) | 0x404 = 0xD404
+ */
+static inline u16 mldv2_mrc(unsigned long mrd)
+{
+	u16 mc_man, mc_exp;
+
+	/* RFC3810: MRC < 32768 is literal */
+	if (mrd < MLD_MRC_MIN_THRESHOLD)
+		return (u16)mrd;
+
+	/* Saturate at max representable (mant = 0xFFF, exp = 7) -> 8387584 */
+	if (mrd >= MLD_MRC_MAX_THRESHOLD)
+		return 0xFFFF;
+
+	mc_exp = (u16)(fls(mrd) - 16);
+	mc_man = (u16)((mrd >> (mc_exp + 3)) & 0x0FFF);
+
+	return (0x8000 | (mc_exp << 12) | mc_man);
+}
+
+/*
+ * Calculate Querier's Query Interval Code from Query Interval
+ *
+ * MLDv2 QQIC 8-bit floating-point encoding (RFC3810).
+ *
+ * RFC3810 defines only the decoding formula:
+ * QQI = (mant | 0x10) << (exp + 3)
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
+static inline u8 mldv2_qqic(unsigned long value)
+{
+	u8 mc_man, mc_exp;
+
+	/* RFC3810: QQIC < 128 is literal */
+	if (value < MLD_QQIC_MIN_THRESHOLD)
+		return (u8)value;
+
+	/* Saturate at max representable (mant = 0xF, exp = 7) -> 31744 */
+	if (value >= MLD_QQIC_MAX_THRESHOLD)
+		return 0xFF;
+
+	mc_exp  = (u8)(fls(value) - 8);
+	mc_man = (u8)((value >> (mc_exp + 3)) & 0x0F);
+
+	return (0x80 | (mc_exp << 4) | mc_man);
+}
+
 /* V2 exponential field decoding */
 
 /* Calculate Maximum Response Delay from Maximum Response Code
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 27010744d7ae..c2d144f6a86e 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1181,7 +1181,7 @@ static struct sk_buff *br_ip6_multicast_alloc_query(struct net_bridge_mcast *brm
 		break;
 	case 2:
 		mld2q = (struct mld2_query *)icmp6_hdr(skb);
-		mld2q->mld2q_mrc = htons((u16)jiffies_to_msecs(interval));
+		mld2q->mld2q_mrc = htons((u16)jiffies_to_msecs(mldv2_mrc(interval)));
 		mld2q->mld2q_type = ICMPV6_MGM_QUERY;
 		mld2q->mld2q_code = 0;
 		mld2q->mld2q_cksum = 0;
@@ -1190,7 +1190,7 @@ static struct sk_buff *br_ip6_multicast_alloc_query(struct net_bridge_mcast *brm
 		mld2q->mld2q_suppress = sflag;
 		mld2q->mld2q_qrv = 2;
 		mld2q->mld2q_nsrcs = htons(llqt_srcs);
-		mld2q->mld2q_qqic = brmctx->multicast_query_interval / HZ;
+		mld2q->mld2q_qqic = mldv2_qqic(brmctx->multicast_query_interval / HZ);
 		mld2q->mld2q_mca = *group;
 		csum = &mld2q->mld2q_cksum;
 		csum_start = (void *)mld2q;
-- 
2.43.0

