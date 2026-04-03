Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA463C944F
	for <bridge@lists.linux.dev>; Fri,  3 Apr 2026 15:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775228476; cv=none; b=jHo/oS9ZBHKEVGTOqOw3FwMg57KnRlDPTSIt8Oe0jnttydTmoL3Hqykj2qWACSVbdYBjpIY/pX3+l2RUUHcPFZl+2Y3g8tU2IoXMOY4EsKGxg6BJtOK2FFRo5PQN+p5DJazhGrclImEWHsNB4SKCoLg2yEMuSSseikkZV/mPPxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775228476; c=relaxed/simple;
	bh=/mvWdn/wGAykwRVbilLUMYweyyaQRxjwPI/Js63ZwqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PymAPyL+0vlQ6ED93jNomZ6g2usyH1sIX/ycjWHbw6NqjLkR7boluaznapZQgHHzTNQUAxUmcCgu1BVMyZ6kk2ODkBrFLKcrQm/imWtffYezNwXOY2Wf1srkmwH0jN20bJk/GY9Cv0LNW0D/poyfn6E8Q7YCSo/IYQv9dwyl5Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgpbmr7f; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgpbmr7f"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c742d4df00cso1242134a12.1
        for <bridge@lists.linux.dev>; Fri, 03 Apr 2026 08:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775228474; x=1775833274; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOZNpt/bcu1cEQwQ1aXYPtHdfiB4Rn2c0iK1yBAhiAY=;
        b=fgpbmr7f3fcFEjSTAMOR1KkgcYB0Gnue4EMfZu3g55L5esIeTEgjemwaWvoHl6b221
         TRmlxem4rlNz6XyVhk/Vg1F7/L61tkEGzUDxsOw8+lXw3BPlMxB2cAgk0UFfaX59y/p7
         nFjvwqkYkR4tMT6Ejtj5aHWzjXfoO0ATOy9tY95TSiFzyS+OrVyyo8VeBlxyAe5Df307
         jeCgCp6bvn8ga1mLV7Zxy3G4/BKIKYcuQFJlZpnu7QLP6+p8L17BZZm1CTcBQ6Aj6Eq6
         qI6zebioB9VrtFgLJ7N7KfudV4PNIjjcN9HrpSjUjuLUMma/9mCDZKvGmVSt853Nyy8B
         ihZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775228474; x=1775833274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vOZNpt/bcu1cEQwQ1aXYPtHdfiB4Rn2c0iK1yBAhiAY=;
        b=AF3NaIvQL+Q4vdnKuwpsSgNCOx+Nq6inVpnnodkU3/AxXYiLtMrSulCRSig3bYb15T
         Int3SRDTBA4oZ2hd/VPVYt7N/qkUQ0kWLvMYn1il35LZVJ11hvt7biS5ZgYalPsiY4HP
         rfhBUwvpBk8W3uMo9LLnSKU4gy5WzY1GlXiVUBV07RnprDqDAqSFqRDdYnaWSBi+hzhm
         FwUpzCesBilOYs/dXNGpcEMMiW8J6Kzx3A+FYkKrFTVKR1of2jhbm8OUHTKGNQUzb+ba
         8+Jff4p670tMwcNdLCu7LTau8r/MB1GaXnFFH+nAh4Jq9wBIcYwuXMT6ku7IahEo7O95
         UDrQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9eSq0KgIGCK1kz0/NeF7blgUw7vFFGy6EfrH1GNQXzWnmkuVOl5qCNPZmHCReQh+oKI1HJI8=@lists.linux.dev
X-Gm-Message-State: AOJu0YyHgUz2m66CG9n762AUv9HcaAQkL0by9+2lCvkXDVZoaRl8Rv/5
	Gd9qv1QHz22HJ867A7uGGMZJ4/U9oB4x0m4m/nuHSEfzCAeAqS9k6uDG
X-Gm-Gg: ATEYQzwAdvozcoRlSQQ5sJKicK6zyAygX3564TAyqME5dYAcvtRhsNOYUv/e27MEbeW
	R6IOw4lMbhiAuHy3hkU1LRDSP0Dzq1xtzDWGldUMta0Il1QDpICEVdxEtHc/9/gi7EVjvy1WNtE
	aR3K2JJslCybRL87+C2vMUIWg1E0tPOnATJsMxVZMpmRufJHTOcFJA3p5o0XXr5Y49ZfPVs+BIB
	PLwF1c5SgVk3BPld/oleODQPHwNrmjEaDsDx7rMLcYEShWxOoEInhuVx4AOQmWR9d5ASiAPNU8z
	xl9u9JVL+Bi2QgcykemieXzTLqzCZm2nWPrdW54Nufi91QSfV4vu2DzhGuBvH81Y0A5+i6rvOgD
	Q2ufOzEq3G/dzdSdB33cE85M/fBopkxQbqE0So1aHbUhsUEUWhCaEx977L8Ai0rIN/jqZs19oy2
	6gwJ1QbczgKLGyZa4gdqiMA3a6YPeC3mf1hvbiamH2
X-Received: by 2002:a05:6a20:7d8a:b0:39f:a42:924b with SMTP id adf61e73a8af0-39f2d8a8ea8mr3039990637.11.1775228473764;
        Fri, 03 Apr 2026 08:01:13 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9ca79basm7789483b3a.58.2026.04.03.08.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 08:01:12 -0700 (PDT)
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
Subject: [PATCH net-next v3 2/5] ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()
Date: Fri,  3 Apr 2026 15:00:47 +0000
Message-ID: <20260403150050.1235-3-royujjal@gmail.com>
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

Rename mldv2_mrc() to mldv2_mrd() as it is used to calculate
the Maximum Response Delay from the Maximum Response Code.

Introduce a new API mldv2_qqi() to define the existing
calculation logic of QQI from QQIC. This also organizes
the existing mld_update_qi() API.

Signed-off-by: Ujjal Roy <royujjal@gmail.com>
---
 include/net/mld.h         | 70 +++++++++++++++++++++++++++++++++------
 net/bridge/br_multicast.c |  2 +-
 net/ipv6/mcast.c          | 19 ++---------
 3 files changed, 64 insertions(+), 27 deletions(-)

diff --git a/include/net/mld.h b/include/net/mld.h
index c07359808493..da3299545ebd 100644
--- a/include/net/mld.h
+++ b/include/net/mld.h
@@ -89,29 +89,79 @@ struct mld2_query {
 #define MLDV2_QQIC_EXP(value)	(((value) >> 4) & 0x07)
 #define MLDV2_QQIC_MAN(value)	((value) & 0x0f)
 
-#define MLD_EXP_MIN_LIMIT	32768UL
-#define MLDV1_MRD_MAX_COMPAT	(MLD_EXP_MIN_LIMIT - 1)
+#define MLD_QQIC_MIN_THRESHOLD	128
+#define MLD_MRC_MIN_THRESHOLD	32768UL
+#define MLDV1_MRD_MAX_COMPAT	(MLD_MRC_MIN_THRESHOLD - 1)
 
 #define MLD_MAX_QUEUE		8
 #define MLD_MAX_SKBS		32
 
-static inline unsigned long mldv2_mrc(const struct mld2_query *mlh2)
-{
-	/* RFC3810, 5.1.3. Maximum Response Code */
-	unsigned long ret, mc_mrc = ntohs(mlh2->mld2q_mrc);
+/* V2 exponential field decoding */
 
-	if (mc_mrc < MLD_EXP_MIN_LIMIT) {
-		ret = mc_mrc;
+/* Calculate Maximum Response Delay from Maximum Response Code
+ *
+ * After decode, MRC represents the Maximum Response Delay (MRD) in units
+ * of milliseconds.
+ *
+ * RFC3810, 5.1.3. defines the decoding formula:
+ *      0 1 2 3 4 5 6 7 8 9 A B C D E F
+ *     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ *     |1| exp |          mant         |
+ *     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ * Maximum Response Delay = (mant | 0x1000) << (exp+3)
+ */
+static inline unsigned long mldv2_mrd(const struct mld2_query *mlh2)
+{
+	/* RFC3810, relevant sections:
+	 *  - 5.1.3. Maximum Response Code
+	 *  - 9.3. Query Response Interval
+	 */
+	unsigned long mc_mrc = ntohs(mlh2->mld2q_mrc);
+
+	if (mc_mrc < MLD_MRC_MIN_THRESHOLD) {
+		return mc_mrc;
 	} else {
 		unsigned long mc_man, mc_exp;
 
 		mc_exp = MLDV2_MRC_EXP(mc_mrc);
 		mc_man = MLDV2_MRC_MAN(mc_mrc);
 
-		ret = (mc_man | 0x1000) << (mc_exp + 3);
+		return (mc_man | 0x1000) << (mc_exp + 3);
 	}
+}
 
-	return ret;
+/* Calculate Querier's Query Interval from Querier's Query Interval Code
+ *
+ * After decode, QQIC represents the Querier's Query Interval in units
+ * of seconds.
+ *
+ * RFC3810, 5.1.9. defines the decoding formula:
+ *      0 1 2 3 4 5 6 7
+ *     +-+-+-+-+-+-+-+-+
+ *     |1| exp | mant  |
+ *     +-+-+-+-+-+-+-+-+
+ * QQI = (mant | 0x10) << (exp + 3)
+ */
+static inline unsigned long mldv2_qqi(const struct mld2_query *mlh2)
+{
+	/* RFC3810, relevant sections:
+	 *  - 5.1.9. QQIC (Querier's Query Interval Code)
+	 *  - 9.2. Query Interval
+	 *  - 9.12. Older Version Querier Present Timeout
+	 *    (the [Query Interval] in the last Query received)
+	 */
+	unsigned long qqic = mlh2->mld2q_qqic;
+
+	if (qqic < MLD_QQIC_MIN_THRESHOLD) {
+		return qqic;
+	} else {
+		unsigned long mc_man, mc_exp;
+
+		mc_exp = MLDV2_QQIC_EXP(qqic);
+		mc_man = MLDV2_QQIC_MAN(qqic);
+
+		return (mc_man | 0x10) << (mc_exp + 3);
+	}
 }
 
 #endif
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 9fec76e887bc..1438c023db62 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -3606,7 +3606,7 @@ static int br_ip6_multicast_query(struct net_bridge_mcast *brmctx,
 		    mld2q->mld2q_suppress)
 			goto out;
 
-		max_delay = max(msecs_to_jiffies(mldv2_mrc(mld2q)), 1UL);
+		max_delay = max(msecs_to_jiffies(mldv2_mrd(mld2q)), 1UL);
 	}
 
 	is_general_query = group && ipv6_addr_any(group);
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 3330adcf26db..6ddc18ac59b9 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -1315,20 +1315,7 @@ static void mld_update_qi(struct inet6_dev *idev,
 	 *  - 9.12. Older Version Querier Present Timeout
 	 *    (the [Query Interval] in the last Query received)
 	 */
-	unsigned long mc_qqi;
-
-	if (mlh2->mld2q_qqic < 128) {
-		mc_qqi = mlh2->mld2q_qqic;
-	} else {
-		unsigned long mc_man, mc_exp;
-
-		mc_exp = MLDV2_QQIC_EXP(mlh2->mld2q_qqic);
-		mc_man = MLDV2_QQIC_MAN(mlh2->mld2q_qqic);
-
-		mc_qqi = (mc_man | 0x10) << (mc_exp + 3);
-	}
-
-	idev->mc_qi = mc_qqi * HZ;
+	idev->mc_qi = mldv2_qqi(mlh2) * HZ;
 }
 
 static void mld_update_qri(struct inet6_dev *idev,
@@ -1338,7 +1325,7 @@ static void mld_update_qri(struct inet6_dev *idev,
 	 *  - 5.1.3. Maximum Response Code
 	 *  - 9.3. Query Response Interval
 	 */
-	idev->mc_qri = msecs_to_jiffies(mldv2_mrc(mlh2));
+	idev->mc_qri = msecs_to_jiffies(mldv2_mrd(mlh2));
 }
 
 static int mld_process_v1(struct inet6_dev *idev, struct mld_msg *mld,
@@ -1390,7 +1377,7 @@ static int mld_process_v1(struct inet6_dev *idev, struct mld_msg *mld,
 static void mld_process_v2(struct inet6_dev *idev, struct mld2_query *mld,
 			   unsigned long *max_delay)
 {
-	*max_delay = max(msecs_to_jiffies(mldv2_mrc(mld)), 1UL);
+	*max_delay = max(msecs_to_jiffies(mldv2_mrd(mld)), 1UL);
 
 	mld_update_qrv(idev, mld);
 	mld_update_qi(idev, mld);
-- 
2.43.0

