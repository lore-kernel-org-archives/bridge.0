Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11893115B8
	for <bridge@lists.linux.dev>; Sun, 12 Apr 2026 11:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775992271; cv=none; b=c+l6KbfYQo+rmYhLrdoSJgF+f1uBW9yEEWgEYX10TLlRdm6vT0lj+J0YlmTVrYrTUM8wFKMy0wXj5SebrQiI4VygYEfOsMn6F2Rh5Ty4grAmK8DKDp2l9qGe6b831eLbdXV6CI30ihiQEYZFRz7L88kRqscqfH9DQ5pPNy2raT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775992271; c=relaxed/simple;
	bh=QBIfIvmBuIoYpMtoyqBsB8dAeiNlwvpVdnfKO8oA6aA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e47iAYvEgd7EpFUwT7oTJDgDJSZmj0cx5kzGF1KLHfhmOly7t9ejONcEcCteJMW8wnXamQOVOcNEdK+ZeMpOU81tRcBZjqBKBFqxskXEhwHeHItkv/8Ns4w0h3QLb7wqAe4LAtiax85heTxr0ge/ScBLGuG010Jq6DbTSUd9L6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RH1iumN7; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RH1iumN7"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c76b6f9a50eso1390112a12.2
        for <bridge@lists.linux.dev>; Sun, 12 Apr 2026 04:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775992269; x=1776597069; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRagAfwxZRIpF0jJI41tPh4aZoJ+uueGkyeIJ7BFIUA=;
        b=RH1iumN7Qm1xROK8Zxbrs8MMorDQoN6bt7vnGlnic/UKv+15MLSg492g5iMBZvNtsu
         sZ2HPUlZfDfYefj4cYzVHsK9AW3hX4wq2XhlkXZU1g0sdnt1lht9Dis5Cp3u+xbRCr0+
         RcZawmTMgZNEz04whIP3Cd6C+zeG6vyqQ1p/iWHXpSTb7wMUJWwErPwebNtppvUBINwV
         HwCRVRBYkIl/u55nFW3HO0rC7/6TBpn7G8mauyW1W/LHLVlrWfvWfYKFE54dh1Ngssrv
         MPfYyDHy1Nb48ZgLZwmiqHUKf0ZFHyqdJLF22K+D3yN0l8HBwPeCIoOIOIQJrWsI6pPR
         z7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775992269; x=1776597069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qRagAfwxZRIpF0jJI41tPh4aZoJ+uueGkyeIJ7BFIUA=;
        b=ISp4EAk9emRj2eUCidz0SdhMeSjSj+3V7177cC4isOl7nIv3hcI4zCdq/pz9rf9Leu
         J3xgiVX2l2xD+HRE1GhQ3geOp2aRMgRSJXv5PLWZqc6iGejiFpW4WFQj6TsNti+B07YN
         mFk4tjL5OWMiGiXlZWlv5BvtCjcypFYBdJecRE5a2Q3H+JIpEj7TaU3AgVrRsx/7v8+6
         Ob6jp6goOjxJXK4fR79ZpspnJKzB9yWgHP+oKCKWKn68jm8l/AMN0mF9Ps6FdIoJ8T0O
         NA8pHKKg0vFErJzrWlVLEmiwgB8QVY49GyeKsKdZwbFV4O1dHH2rDutML05u8u7AUBnU
         aoEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjLtKWoVaBtM+sIV06z0X8WMd+Cez/tXRK+GDQIB6Lu0sFDoZQnWYciQzqwNyKbaGJtk9Mv4A=@lists.linux.dev
X-Gm-Message-State: AOJu0YxqHgsYL5+wf9CI891JL01u8uscxHQw5uqx2aah3Srh5l9iXHRh
	zeL9k/vb9XwnVP7o2kVDASqqGnwyfOqaXFtAiWvJnjutyzF7yjnkf56N
X-Gm-Gg: AeBDievcOz6BBaM2KJbynbx9HUlp4Q3JRwVCictGJKN1Q9GWEUiglyXj5nxEhFa8QS8
	VNy+ki4RAkGPWM3kkFCXO7wqjc9k941hTTeFr7LbKrVv7m6SdRf9z2VzPUcorVrjJv106sNSQtw
	H4zYkHU6tGoMAPKJNvROlFLTjM43wLytNwgG8IwntxOzSR/du0r6V717jN4XI0PaaZZ0kh2FM3a
	EkQ/mm8NikAGi6OTA2OXk8jLq8Vyt0RchFesMxa0D6QvqFQLwPCExSW1U1so8kJ3nanBqNWrZtk
	hI1vr+qhhRoqelwVMIUpXfbw/N6eSW+Nz53zdOQ7aJIz1D2nVPQ4UY+yI2SlFftqc7UtScFoQ7o
	tlm0hJAUwDty0ldFTG4unkj8QoYaFqWgmqGjN33A4hLgRiWfersrqMhlCHFLNe5yKu5ugcrxhKR
	eOSoOWLGXTjVA0HVoPnZuV0YekGOW0qKaf48Vqgo69Be0lPLFtF+s=
X-Received: by 2002:a05:6300:6a02:b0:39b:f9f5:7a74 with SMTP id adf61e73a8af0-39fe400f754mr7736909637.45.1775992269002;
        Sun, 12 Apr 2026 04:11:09 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.169])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7934c9ef38sm2522981a12.12.2026.04.12.04.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 04:11:08 -0700 (PDT)
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
Subject: [PATCH net-next v4 1/5] ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplify calculation
Date: Sun, 12 Apr 2026 11:10:43 +0000
Message-ID: <20260412111047.1326-2-royujjal@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260412111047.1326-1-royujjal@gmail.com>
References: <20260412111047.1326-1-royujjal@gmail.com>
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
 include/linux/igmp.h      | 80 +++++++++++++++++++++++++++++++++++----
 net/bridge/br_multicast.c |  2 +-
 net/ipv4/igmp.c           |  6 +--
 3 files changed, 76 insertions(+), 12 deletions(-)

diff --git a/include/linux/igmp.h b/include/linux/igmp.h
index 073b30a9b850..4443c914b3c8 100644
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

