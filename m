Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345A41FD4
	for <bridge@lists.linux.dev>; Fri,  1 May 2026 17:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777656711; cv=none; b=SpIXVNHgJempwotwxxFXcRoHUg0wOtMH000OFJVQfdlg5QUc7fS7A3jR+2QCrwVZsrfiK/4O2v/2YGkB9c5GAZl+EYfjqvdWlr/5W4JyLIq0JzXycFb2BRiEC+yQBpsV3KAXpxQOCLo1lYjOBs5+kqiVKncxNI+Ra8rDvBEQdIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777656711; c=relaxed/simple;
	bh=OIVGLHkE0+zv8tPvOlRxlxnAchQfUFIaCtRMGLN9J8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r3NZMr7izAoU1YJFdomq1tfL2IwDHCtXaH/sA+0F1tDHoNXzMh4SMwRenshfYpvn4U2MdF/Tc0ApvfOTH8m6XLn4MJgZBKKQUJ4hJsKRUPniDqBB7omBFKN47RW+Xhf4yadVvX2h0WwiKqMZM0RFmJ5hNQ4F9fzvVVmiCZ/5rgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6pqQBBf; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6pqQBBf"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35e576110adso1570356a91.0
        for <bridge@lists.linux.dev>; Fri, 01 May 2026 10:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777656709; x=1778261509; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWCZJ9utsVn2aH4mDSbQniFeJPJsfUBS8uLBgw2m2To=;
        b=f6pqQBBfTKPSQB663NytPjLni5jJPPCIrv2GRMkyeF80GImh8Q3keT++VTRWY3Yh0n
         pjPeSp1PtliwLRpCldIkmDWmnBPAmUJaAgGFSD41xfwfqxakGQdMgsYdUk1AXfBJ6rU8
         3b299jsQLtfDlMlvcg238hFVCFz4qzixbBFVDrAZcGyz3LLUfDEkweuck8R2Bf0POgAw
         KMEybXq6lzBAWmHpjULyFSeTPnZPm4xTQb6ZoQBhP1j4kSyI3aZy522QllARwMaP2Pg7
         NWI7ER8sMMm+MwnBZ8mR8590qzcn/wm2E9GKIdAqsFaqdZ+BKj6P5eF0Md8TKiE39SOi
         PWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777656709; x=1778261509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YWCZJ9utsVn2aH4mDSbQniFeJPJsfUBS8uLBgw2m2To=;
        b=LtRM/s3Fyyak+UBr+R5mH0T+84STLhsW5Ob7zyEhvSkVedOr4W/sf+seAwepX7gLu/
         FdG1YllYJ+2l0pkEbb81hgLPNpZe3t2oAr3ZPqSmYzgi65jWYDhKy6x9pRoB0qyTzmiL
         qY5jYrPXH+ZyGT0znBk++/6RAr7ohRe7ZEDo0WAEhxd0FD2tVSQioxGkLDJIY0vEk6gM
         buU3NBfIQHWLv3QNcaqODHKZKJp+9DnDKn+HAFgK62cU2WP3vhMtomWaZXE010Vq0roh
         vfJHSBK9nb1LQ03pH9ik1SOjnhw9Js/b9prHVEPXuq28V14ggJsT6/4oGo1UNNSiaQJM
         wCsg==
X-Forwarded-Encrypted: i=1; AFNElJ9JNb1EMj36/eLN/UPv6feAlMYUDPe7phqLjO7cgP513DB4zYPl+o4Ab1e4XUXus7mrBYaZS7Q=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxsr3fpkY543T3nuEYyCsgC6afLCJ71F3xmVpAKPbwkrPvcFryu
	q8sSSvjIMlekIzX1FgPbpqBM0PmF9d9dJt8UK6oa24djY7OiSkZGlrt4
X-Gm-Gg: AeBDieupvTgO6hJ74R9ROdPUNDoI72r8he48RdFyZN8BPqiHrE7RJ2puZ8RNo1TUp09
	LBdwtYlU6K3r1l7ZfEsQ1uZocDdIeIaIL3HZdLgdQPSTfxbrivSYOjmQ7qHI1cEglqcN2L4EjBa
	GRYyO/vc6JTOtDwVf+mo4+Gquz2zHvUeLK1K44fpzNAFtAwVTyX+qbbUuvEYLyBxApB+7wG9XxG
	24MZOHSvDxi+Q66GnuYLdG1cD6gUHazushzKAZz+Vr6U7kJpDTNl84T24Q8w3ubq/kY/GbwW+d/
	g0JGIEanLt/l3CoBTnI04wG0S+LIkTOaLogoYiV2aEupyUhh/38ZfQiNZIkwvRYRhi/+PXG85IC
	LPZnAsVUzp4zy0a45ueek8aVd8S0xLlXSmNgbfM+RZaRYJxrHc79mOLS6Y8XfRoPI3NlDm9goB2
	dJwUb/NemL6Mb2+uWTKkeJfgdF8tLMsBe6UcmD4pinL9jDWibuhQ==
X-Received: by 2002:a17:90b:498c:b0:35f:b9f1:fded with SMTP id 98e67ed59e1d1-3650c4f44f4mr293791a91.12.1777656709241;
        Fri, 01 May 2026 10:31:49 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ebec73aasm2908906a91.2.2026.05.01.10.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 10:31:48 -0700 (PDT)
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
Subject: [PATCH net-next v5 1/5] ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplify calculation
Date: Fri,  1 May 2026 17:31:25 +0000
Message-ID: <20260501173130.3486-2-royujjal@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501173130.3486-1-royujjal@gmail.com>
References: <20260501173130.3486-1-royujjal@gmail.com>
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

