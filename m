Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F29257851
	for <bridge@lists.linux.dev>; Sat,  2 May 2026 13:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777727992; cv=none; b=oxOb+1kp46VBh01W54lWYBf5ERxZzX+jO25YaBtnoGtUqV8VTjm2DUXlGayNO+Y+/PlliXilyvYvHNlFGIO05XV9i5mXhbWbkKbkzfBnxi3KcNGl0cNYFSEHW32KRMZohTLOg0OcNmDGF+X3fb48Ybdd03EZth6deQ0PiXUEHqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777727992; c=relaxed/simple;
	bh=jJnc0mGZNzy4u3y501gtICX3ws5YMm+lbxgjciB6cvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9M8BcD3YgV3wvh9oIdyQMrFrUe9myiqmVnKaBjUZzXjxx8hzFv3pbEyyxofmoHPgKVoIbQMFrMPon3g17z2kWOOhu02Ruvsb1XnYdpeM6RRSk828ugI3RgGclRgek5x9x3JqYyUl517HK8sKAwAmG2wQ7+iZsuqNcBTfiSSbPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pInm5m3C; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pInm5m3C"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-83537a80ab6so128176b3a.1
        for <bridge@lists.linux.dev>; Sat, 02 May 2026 06:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777727989; x=1778332789; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zl++HpBCtAW5kzSiDlCg+WmmabaPSzgG75Hq/zfZ4gA=;
        b=pInm5m3CWiZRc3ZSDEL2SHskMlYppWVYlVPrR5p8bYZqh5H3g0RziYY3LEzeLywWLm
         IZLcVV94cctNT9T0EUpjPWWSls+UoqFRQSL8mjoaL5LHB53kedMQzDjwF+SahXKRYgQg
         S0k534sKjyNbuWnGW3bQrzOiqRMY3t0WTCIGBOjm9XqnthGZ/FT1KNkTrhsUXFlOXF4k
         0M3GhCULBF94qpqBvIIVcvyGYb6nWbXeV9PQ/gS0wZjg8XskZqYODVYwJpZ4djaywusU
         4sMdMqX3JW007HWH+suU1djO18qfOJxMHfmS6KoMX7lhfFN5r53rlRqoil1B3N6TaJK/
         WT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777727989; x=1778332789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zl++HpBCtAW5kzSiDlCg+WmmabaPSzgG75Hq/zfZ4gA=;
        b=lURHSHhn8fcPTmqIxgh4BkrT9nnAtyIYBdLNvGKiDP8OQmp3TyNLA8Bsorn+rZ9w3b
         UTHQYdu6B1a/eJu8Gt+K3l6YspBnsQsWysPWQsyv1fGqvm+wH44imBdUQPlraKrPHYvC
         xNVnlqLacN96lcW2Sf58rmiig26fRhZrReyvE/U6eX08mKCDEhBYmnXVRJFUg6Jv+8x/
         5wuF4Hz7Gs848MJr+Lfjd4biIDFekt6SUd+E+c6nsDkbnjyuNrjF058BwMQnPoWBELyJ
         v7l8uj8yXsCIoRmHjE8wTAOCNjTbteHfWpy/R3yp2OUWkm+lY2vRpcwg8wrg4g7zR5/2
         +Eyw==
X-Forwarded-Encrypted: i=1; AFNElJ8BKKH13bUqbWz2QQNTE3ZoUKIrjmoP8/A2DAu5TVGdwHNNVZEeGp2Hw+o/a2Sctphca4R+ZIA=@lists.linux.dev
X-Gm-Message-State: AOJu0YwzF8aFNKY2D+CCl4vNjF8nagMb5zHqTx7xPvqM7MPavK1chmsG
	wThtLIH3df/7I8kf1vBrbnlsiJV15HBmuGpEP1KHMMCWF1sLuvUqE7il
X-Gm-Gg: AeBDieuVap8STdWh9N1/byS4TuUymvnK7yLk1Dx9SNdmXaBoNSv1VwaDh2VK9alVf/t
	VHFHHdGbHWuBav3Azh5ZHCOgf+NOR5sCberp1VMxa8bAzGGvtM/Swvw3mlUcv4BfcrGH4360jYv
	dEcidJ0mSHuOxkhbH5r535V6vIyKBx3bwhw7KCkfqb0a5d1eKbUvmylmsFo4hbnagkKcIRt0JW7
	jxW6Q9Ptys2V8XcviPiD1PgUmHXgnzF9ClhuJZl/2ym0VY/SCL7fQ4JimmU2hcFux1/m33wk2J/
	FwE9/8QklEcxxBd9gQiaO4/3uB9M97I56H9nKDdssp41If1il4XXSFHBypa9+AtbZwVhEMEZzZY
	4+o3758Xns3hdELWylO5LUF0H62HRpzc4b959HEHZxlkuApWUCLDLvdlc4F1BkFbw0bnJRr9V8U
	EEtrvu0RVo/7foxhIC30gu1Yc6oC9zziPv5CuaXbSNysrUzFbBJw==
X-Received: by 2002:a05:6a00:13a0:b0:82f:4628:4186 with SMTP id d2e1a72fcca58-8352d2cf7aamr3023049b3a.42.1777727989546;
        Sat, 02 May 2026 06:19:49 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515ad0176sm5553791b3a.39.2026.05.02.06.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 06:19:47 -0700 (PDT)
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
Subject: [PATCH net-next v6 4/5] ipv6: mld: encode multicast exponential fields
Date: Sat,  2 May 2026 13:19:05 +0000
Message-ID: <20260502131907.987-5-royujjal@gmail.com>
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

In MLD, MRC and QQIC fields are not correctly encoded when
generating query packets. Since the receiver of the query
interprets these fields using the MLDv2 floating-point
decoding logic, any value that exceeds the linear threshold
is incorrectly parsed as an exponential value, leading to
an incorrect interval calculation.

Encode and assign the corresponding protocol fields during
query generation. Introduce the logic to dynamically
calculate the exponent and mantissa using bit-scan (fls).
This ensures MRC (16-bit) and QQIC (8-bit) fields are
properly encoded when transmitting query packets with
intervals that exceed their respective linear thresholds
(32768 for MRD; 128 for QQI).

RFC3810: If Maximum Response Code >= 32768, the Maximum
Response Code field represents a floating-point value as
follows:
     0 1 2 3 4 5 6 7 8 9 A B C D E F
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
    |1| exp |          mant         |
    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

RFC3810: If QQIC >= 128, the QQIC field represents a
floating-point value as follows:
     0 1 2 3 4 5 6 7
    +-+-+-+-+-+-+-+-+
    |1| exp | mant  |
    +-+-+-+-+-+-+-+-+

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Ujjal Roy <royujjal@gmail.com>
---
 include/net/mld.h         | 119 ++++++++++++++++++++++++++++++++++++++
 net/bridge/br_multicast.c |   4 +-
 2 files changed, 121 insertions(+), 2 deletions(-)

diff --git a/include/net/mld.h b/include/net/mld.h
index 10e402e0fe08..23255cc47ced 100644
--- a/include/net/mld.h
+++ b/include/net/mld.h
@@ -91,13 +91,132 @@ struct mld2_query {
 
 /* MLDv2 QQIC floating-point exponential field min threshold */
 #define MLD_QQIC_MIN_THRESHOLD	128
+/* MLDv2 QQIC FP max threshold (mant = 0xF, exp = 7) -> 31744 */
+#define MLD_QQIC_MAX_THRESHOLD	31744
 /* MLDv2 MRC floating-point exponential field min threshold */
 #define MLD_MRC_MIN_THRESHOLD	32768UL
+/* MLDv2 MRC FP max threshold (mant = 0xFFF, exp = 7) -> 8387584 */
+#define MLD_MRC_MAX_THRESHOLD	8387584
 #define MLDV1_MRD_MAX_COMPAT	(MLD_MRC_MIN_THRESHOLD - 1)
 
 #define MLD_MAX_QUEUE		8
 #define MLD_MAX_SKBS		32
 
+/* V2 exponential field encoding */
+
+/*
+ * Calculate Maximum Response Code from Maximum Response Delay
+ *
+ * MRC represents the 16-bit encoded form of Maximum Response Delay (MRD);
+ * once decoded, the resulting value is in milliseconds.
+ *
+ * RFC3810, 5.1.3. defines only the decoding formula:
+ *     Maximum Response Delay = (mant | 0x1000) << (exp + 3)
+ *
+ * but does NOT define the encoding procedure. To derive exponent:
+ *
+ * For the 16-bit MRC, the "hidden bit" (0x1000) is left shifted by 12 to
+ * sit above the 12-bit mantissa. The RFC then shifts this entire block
+ * left by (exp + 3) to reconstruct the value. So, 'hidden bit' is the
+ * MSB which is shifted by (12 + exp + 3).
+ *
+ * Total left shift of the hidden bit = 12 + (exp + 3) = exp + 15.
+ * This is the MSB at the 0-based bit position: (exp + 15).
+ * Since fls() is 1-based, fls(value) - 1 = exp + 15.
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
+	/* MRC < 32768 is literal */
+	if (mrd < MLD_MRC_MIN_THRESHOLD)
+		return mrd;
+
+	/* Saturate at max representable (mant = 0xFFF, exp = 7) -> 8387584 */
+	if (mrd >= MLD_MRC_MAX_THRESHOLD)
+		return 0xFFFF;
+
+	mc_exp = fls(mrd) - 16;
+	mc_man = (mrd >> (mc_exp + 3)) & 0x0FFF;
+
+	return 0x8000 | (mc_exp << 12) | mc_man;
+}
+
+/*
+ * Calculate Querier's Query Interval Code from Querier's Query Interval
+ *
+ * QQIC represents the 8-bit encoded form of Querier's Query Interval (QQI);
+ * once decoded, the resulting value is in seconds.
+ *
+ * RFC3810, 5.1.9. defines only the decoding formula:
+ *     QQI = (mant | 0x10) << (exp + 3)
+ *
+ * but does NOT define the encoding procedure. To derive exponent:
+ *
+ * For any value of mantissa and exponent, the decoding formula indicates
+ * that the "hidden bit" (0x10) is shifted 4 bits left to sit above the
+ * 4-bit mantissa. The RFC again shifts this entire block left by (exp + 3)
+ * to reconstruct the value. So, 'hidden bit' is the MSB which is shifted
+ * by (4 + exp + 3).
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
+	/* QQIC < 128 is literal */
+	if (value < MLD_QQIC_MIN_THRESHOLD)
+		return value;
+
+	/* Saturate at max representable (mant = 0xF, exp = 7) -> 31744 */
+	if (value >= MLD_QQIC_MAX_THRESHOLD)
+		return 0xFF;
+
+	mc_exp  = fls(value) - 8;
+	mc_man = (value >> (mc_exp + 3)) & 0x0F;
+
+	return 0x80 | (mc_exp << 4) | mc_man;
+}
+
 /* V2 exponential field decoding */
 
 /* Calculate Maximum Response Delay from Maximum Response Code
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 27010744d7ae..49ceea3ff974 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1181,7 +1181,7 @@ static struct sk_buff *br_ip6_multicast_alloc_query(struct net_bridge_mcast *brm
 		break;
 	case 2:
 		mld2q = (struct mld2_query *)icmp6_hdr(skb);
-		mld2q->mld2q_mrc = htons((u16)jiffies_to_msecs(interval));
+		mld2q->mld2q_mrc = htons(mldv2_mrc(jiffies_to_msecs(interval)));
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

