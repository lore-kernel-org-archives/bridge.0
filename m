Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F38E38656C
	for <bridge@lists.linux.dev>; Mon, 30 Mar 2026 19:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774898203; cv=none; b=nVFQ7BIxHsYabuzlfql1j+vh7rNKiWYIJ1p7pqUE1peFmeeX/MHCoFFE3OpXBgmN4FDdRKhKn1+Yn6s8Fy8wuQptFjoEYOoo269k5nUfWz2goi/+ugFbAEPIZJX+WQaqpjXHGsP8mWlVZQ9Qq356vjWRZeuC/6pYGBi0NEFsgdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774898203; c=relaxed/simple;
	bh=yJDiUN34AyED1s3Mh0BhhgYdT8RuWlDR34wMFTuxleY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IGYy5Q29d12RjQSx8Y35TIYJEqzwYqT5DGsNIuQONayy8vEZ55IuMoYa9vnjPBZqoIKWg4loNxEuoFKPYZuWO19kPwCFSxhxKh5HnDfMNBMIiR1XJgN1XtUS4ZylJlMMn2PYIJXqp8RZbQJIP3SPYD2Zm4eWfkvqFXIbpIst4TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWNSAwv5; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWNSAwv5"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35da2d35eccso1106862a91.0
        for <bridge@lists.linux.dev>; Mon, 30 Mar 2026 12:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774898202; x=1775503002; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1FELrnIn+Cl/sQAWOOdScMKmjJwFkZRPYjIHZTYdfw=;
        b=KWNSAwv54Rw5ZVTS0cweHvA8/CcyeQXBRtpnU4X/4qhQOevWtjKM6+ZTZDpq8yBtTv
         n+Vo58tjrO6GcytMjORt7jYSJMVo6Hl5acpjkw0NjIk7jEj2jmIrlZLYzH/FIQguUtfS
         qwnlTEtk8GeZpBlB1nK04qDE8MuWaZ8+8cd8uxV3ehH5Wj9wYhp/djjPFPRZ58l0vkyO
         7wCraaDhKKYTosCJ5V5Brtw1l2Kunnixt/aWpvMzDnEX5y35r3kQx/6fWa1aHXJApZIz
         D2OhJ8z2qa/C+USFop04GX/A7QEUn0K4nxy1RU21D/1lm/XJGfDNhf45hZtGZRlPjJR2
         cHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774898202; x=1775503002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c1FELrnIn+Cl/sQAWOOdScMKmjJwFkZRPYjIHZTYdfw=;
        b=c+m6alaM70JHmATm0CSBR84mXyQkEr1F2cQL29+5P+f0YFmPXOMWBBkAxvSWjnjGN8
         fWnfFgbCOmcCETApZS573iYXKu3iY2ix8UjqFonyUrOmOFPZxzcUkJV1nEuWX3YtbIZY
         +Gj04WXBkpdeZCgl8SDDk9XPvkmB3sYlYW+eQMIquKbCZ7ZrAWJTd5q+x7fSux9Z5ai3
         yLZsvo7U9/bhdb87CY7dJzynVu3ip0j5WhR9m/l6YYyX/YFZxiEbNMY82kOoSMpvHTNO
         eJ5Vsx2Vm2bKUrdP1aY//MFR+a80Kxa+aAZUD0Ipzdbtavo0fukOP+mzGuN8KAsx8NLI
         O+bg==
X-Forwarded-Encrypted: i=1; AJvYcCUz7GhffZ78at+Z49+cOTawGHIfECmHy0DwVuqGtcKQratT+3f5f/m4OKbrkdOvJxIWsEeZNfk=@lists.linux.dev
X-Gm-Message-State: AOJu0YxaKalT/xLEUdpOtArz9S5b+9DbrDzxj6wKcco7QwKKk7TjIVZI
	Er/hq5exCpBR2eCVhvN8UuVvXCxTzj/qrOFUEvgQwrUtWk5fkpAl37dL
X-Gm-Gg: ATEYQzxakStYxoPlHPN/SMH/7FQi2gq6Cqln7t8OnS6QPsMbY1/0ZyZn5IwjA9SYeQ0
	sRlNmh+rcJap5j98TozdG3hhOHjGSWhIW5OO2nI9PKzlYxnFrpEYMWC/RkTERXUukNExmX1sOvo
	Sk9eLFUwQrSB+KuKdMATNdVr7nVIPvvwNSotFuom5Txto9MzFlQ2EfjBNcdKEWNki0LXIhQlxBv
	nCGLdmA4w6VUCfQKQVSDzTC+0Xknp5PXOeuj9J4t2GYl6p1Br6FD6Yt2tr8Uso/H+ecun6pzXEp
	BVrq8KboTpQOmTAtYGvzsIUx0+dFzo0/GibtXBMG6Yq/B57tsXo3KyMi0qt6Hj/pZLhFzq+EtIo
	cunG+aU1bAbef3X54dJh+QE2WRkmE8z5y41tataYdSo4q1ViRW5wv1q1/j9bIIQT9LG1xCq7Oaj
	CxFKokvE4y8vAOtfpGEtfaZSiHeYkF1Z+g1zA7y4PI
X-Received: by 2002:a17:90b:1d11:b0:35c:a8f:5c5f with SMTP id 98e67ed59e1d1-35c2ff6afecmr12284030a91.8.1774898201514;
        Mon, 30 Mar 2026 12:16:41 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35d950d9b12sm9627178a91.17.2026.03.30.12.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 12:16:41 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/5] ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()
Date: Mon, 30 Mar 2026 19:16:08 +0000
Message-ID: <20260330191611.16929-3-royujjal@gmail.com>
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
index c07359808493..5e093f9c75d9 100644
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

