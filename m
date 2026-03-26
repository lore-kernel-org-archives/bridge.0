Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620AF4014B5
	for <bridge@lists.linux.dev>; Thu, 26 Mar 2026 15:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774537681; cv=none; b=ahsSpzwxxcIeDVlpQDaNKbMV861x6fd14LU8g+Homgl34Db0AG4IsgIpAR7Ikk8+jOgtlcvn87hg2KD74fRhursISUVNYd+e5IYrG2nyQMLPUFR1CoTEsXCQ20WXUJ3Q9mWX55WcySZigik/Cp/vY5eWaShjNsVBbMKMzICO0xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774537681; c=relaxed/simple;
	bh=Plea5iBFdrt1H6d4ZGv0XEzQG+OQNdXeC+Jz94Z9T/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9yMWYM8Q9zhMOLNwx4a8Y34y2Rc9ag9EI8FlGwJ4DoTpDeWPNK4aUuP3KzTsZExt15+Sv8NmHsTfRJ1CcR28wY3E3JP4YbpxEadt4iL/NfPgYKQ94SAhmJomRSeJSb99ojDXLxjZ+OAqX1HYFKOzAJGJszJrxOo94Mgm+DDDmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qX9JhNR4; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qX9JhNR4"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2aecc6b0861so6857125ad.2
        for <bridge@lists.linux.dev>; Thu, 26 Mar 2026 08:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774537680; x=1775142480; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Vd4SXqk71/8Mc4Vs55kpxlo3429C4j+4N2/E0Qv8FI=;
        b=qX9JhNR4OL64iz5+wepKbRG6SmLXyF/r6onc3Ii0H5P1CbhqqNemnkOTHQmZFce/RR
         4L60/VeTzo3g6GoQ9qBbQf+WVGqc8ZZlqHB2577whiCqKtPsrUrs2KS1UouHPF3R5gIf
         KlAA1Zfjjag0aGnljV5tAyI7v9f3twHsPiTyNJw4BBa5LAYtk49MQ4ghvLl+PXBPMucW
         cLqMUZIUokdb/UMRlFbgzoY1ULkCp8ZWaTLrLB41G9EfA9AdVQUjVPjuCT0ne60ePqRw
         KDJoku0RxoveOKnLYIRvMhyKzEI/XaIfqSivbJDQcT5x5J+13x8LGUsEczc5f/TIhu3i
         CYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774537680; x=1775142480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Vd4SXqk71/8Mc4Vs55kpxlo3429C4j+4N2/E0Qv8FI=;
        b=GP2IwYlTv4ggCvpePplXKZ8sn6knv0oARF7Bp9zCdgZBtolH5hCiu4L1cTexLQgG7J
         AaNgwAhvSbQh5mOXuCRSoclB/JGic8QNSSBHixvbyOLrzIwU4iZhvYCCJ0bAvttcPzNF
         2KKbb1rgjm5lzUq40qDR9Rr0psRQtnCDmzZJ2ULQLEGFw4xTxTFpeJKVQHSaN1zjJJ9Y
         AXr8k89WeUpjplMSsCQwR0VEXPfBt99ryGHOl8i/nw8aTfPhVgpRLOGYRFrHTFz3XAus
         gpPAck90d4wgQ1HEnMNy5uZHjQGYpyynUk17reDdkd7glDMHHpGBuW9fiCw3+XCGjgTS
         mMRA==
X-Forwarded-Encrypted: i=1; AJvYcCXyiBb84sZKc3hV0zDbcnTroZlvvPU0Hy7FmtQXjwPGESTrza8hG+bUdMKoxO4fSMmbR/jwcik=@lists.linux.dev
X-Gm-Message-State: AOJu0YzPjxL7D73OdVMhSNjcXExVQqhc1SMMeeTaLtccmSv1PwPp6Gd9
	4PybPQPvTnTuW+ZFmTzM23yFApDBBXWyWp/GjdefJ6ucchxMb6Gqb39S
X-Gm-Gg: ATEYQzxG6OMa8zvQB4Anif1i8NeUfANsszATeDDjtbz0DavcN9epFX7/qWVYDc9EOgZ
	rEEiXBdFQ3v/lPyH5pv949pWSHSSPfaokZEMDs5sx9wbdK2g7b2J+79im9PM+rIdFA2EPgOxMrE
	cBrxicc7FD0cUFLpFr+M7CHyW1QAmOJ79nzL0mZgI1PbynrdMxhOl691wP3KkTo53PtdLafxi5b
	Jpj8PVnoIGgU7dY5XbK+9d0UIdQm41omFAeSvARPuKFZMipVpyRR9cvLj1fV9PjsVr2lLS1Sn55
	mKXHbj1svcRI6aQUrsk9DahPkgiFTb4fkz6XLsAVBtqLXMQH+m5YuL6TX2OOj3Hvv7/HHFaND4P
	obkUDTuwoa2tBz9JBsD7nz+PlbEFAoyiELhGAinfLriTHsJsoS5X2IPtgYNE+2QtgLXR5i9VZLL
	6DuVkw3F2r39z8+9B1ZAQitSm8LnXJPL+qypXjAczyV58laXWoAuA=
X-Received: by 2002:a17:903:2c04:b0:2ae:aa16:acf7 with SMTP id d9443c01a7336-2b0b0ad656fmr89027405ad.40.1774537679761;
        Thu, 26 Mar 2026 08:07:59 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8bb5fasm33146375ad.59.2026.03.26.08.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 08:07:59 -0700 (PDT)
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
Subject: [PATCH 2/4] ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()
Date: Thu, 26 Mar 2026 15:07:40 +0000
Message-ID: <20260326150742.50289-3-royujjal@gmail.com>
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

Rename mldv2_mrc() to mldv2_mrd() as it used to calculate
the Maximum Response Delay from the Maximum Response Code.

Introduce a new API mldv2_qqi() to define the existing
calculation logic of QQI from QQIC. This also organizes
the existing mld_update_qi() API.

Added by e3f5b1704 ("net: ipv6: mld: get rid of MLDV2_MRC and simplify calculation").

Signed-off-by: Ujjal Roy <royujjal@gmail.com>
---
 include/net/mld.h         | 64 +++++++++++++++++++++++++++++++++------
 net/bridge/br_multicast.c |  2 +-
 net/ipv6/mcast.c          | 19 ++----------
 3 files changed, 58 insertions(+), 27 deletions(-)

diff --git a/include/net/mld.h b/include/net/mld.h
index c07359808493..6373eb76efe5 100644
--- a/include/net/mld.h
+++ b/include/net/mld.h
@@ -89,29 +89,73 @@ struct mld2_query {
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
+		return ((mc_man | 0x1000) << (mc_exp + 3));
 	}
+}
 
-	return ret;
+/* Calculate Querier's Query Interval from Querier's Query Interval Code
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
+	unsigned long qqic = ntohs(mlh2->mld2q_qqic);
+
+	if (qqic < MLD_QQIC_MIN_THRESHOLD) {
+		return qqic;
+	} else {
+		unsigned long mc_man, mc_exp;
+
+		mc_exp = MLDV2_QQIC_EXP(qqic);
+		mc_man = MLDV2_QQIC_MAN(qqic);
+
+		return ((mc_man | 0x10) << (mc_exp + 3));
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

