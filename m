Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06F63FEB18
	for <bridge@lists.linux.dev>; Thu, 26 Mar 2026 15:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774537676; cv=none; b=mz//7btgLjl49cqwmmSLctc9T3L7tieLj6vsqMADLGXz8XgLMpxSkgF76q6taCZblDFMAHRzw11Q7eB05AB82nfvpMwrrKSTrcW9sax0nN/flqCQ2PgdMdyXYrT8EcXSbBtkEip6kSNzaszcbTpvr9qPe1FKXhsDHnTmtQQ+Yhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774537676; c=relaxed/simple;
	bh=WW0vISqU8GwrmrIC4NHoR+TFPQ7BlX0/FvDVbKYURp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JhPd8bD+GtUoUJvzq9g3w7NhMARbF0BDdObZ4GeSK49tYqoURWNw/AcaIv7CA32a3LCHD2ywrKm4Qc1ZnJGRFx1EVkrK4WCahNR3Lqyw3rdrXjYNc0ecqadsnCzw9c2XZfYhVrQBzli6C4wYaVP8NIj8HISPUL3NZVaCSJxi0TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dG5YoHnW; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dG5YoHnW"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b062069f80so6577065ad.0
        for <bridge@lists.linux.dev>; Thu, 26 Mar 2026 08:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774537675; x=1775142475; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2s2FZ+Hg0ngcpnnbi9FLabs6QrxAbJsZ+G4M5k6jv8=;
        b=dG5YoHnW95zwXZt4rtXueH/+hfu2Ha7sUFjKJyW/iJzILj0XgVMQhB+Stc3YOL3lyp
         Lb3QRKdOne1vvdW6DBhlnsbtuFfJL3ShxJE22W7Na46Hj2TW+zm0PKmyMyYE/FVZD9jT
         OF/grGOg+DdP/UjPwDuocWxt/K63NuCsBH+/2u8y7RCCbt+sv7GtwbpIrMbqU9R6y0d+
         6Q5TusN3BYoqXWkESwtd4Tmz2aAMsh8VCWfZpfH2848STIWtPtCzzySTW2qWOe9AceVl
         fPe1V76O/LTPEC56uAn5ZSgzrWS48kzyf4PgDaMKl/+PL1lR6l/7tmQOGCEBOig+9m1L
         5iRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774537675; x=1775142475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O2s2FZ+Hg0ngcpnnbi9FLabs6QrxAbJsZ+G4M5k6jv8=;
        b=OsOteXMMCQPcMQY8lTez1BfIwyameIQcXQwexUtjTK2m/b5FU9ZVm/JMqmxaYikXXj
         LTTXSMtDfD12OYf9CRFRdXKn0XvGEhG4xQWSFJJFt6D7V+HB8t4LqUbAY5Gx3UsPgapg
         WHs3GisCHxq7UvRwkVd4sCa7IowhJyTFDz8guaXq3hlcvstA8vsfYafJj8fnOhCcbOY0
         g77nZ369TOpohxqC7tscviqVwWSuI5A1cWZhHqUaUsxRzYBOehVIsFLC73U3YnzUKbhN
         +sUYnc8acYeHu40EyelKZSc+iGFMYQJcsqEdewjc1gCRgkAHMSaf8fqgCtmydhgQfFS+
         3LeA==
X-Forwarded-Encrypted: i=1; AJvYcCV+QOL64ahltQbCr5+YnDW76+1/bipst9NJ0Y+x+DuqA9/I4VOyxuuievl2BlFXF2DVzJ8oy8E=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyknp0WTs1fRNDLRyfdoi+ineNjUx8AxAtPi4UsPkW7cV4uEakR
	mIStWNeUnFTbGsOZNLF/EU/RsUegTo09BoRdwo9qeLzaGOjGHEHCzbGc
X-Gm-Gg: ATEYQzx/DwXZYJocIpVfjAQqIJ4btcx8cl6BRyyGuSGLNv9wRugdmlta1MjTwTVrWzL
	B8aOGO/frg3+RH4St+9OXUl/8gzOpgyNjThmNUKrgjfbkBw5jEPM5Xk2MMSBx4ao/tevVSznlmz
	1nlgC8GuvxaWoxz8ULpyq1TLeSXZVML9aieE1NHUeWZZpmPpSCBhUMdEXq1jDVlnS492UBtHEdT
	C4vnThaQAfyKuo+AfAZ89eT3nO4wEychRoaxSHlUmgKBEZFaRD/1fh1fIbXL/rGU938hFViDPwg
	Eu5JdklwYuzzs1uES7OOUxSisZ29LnoDrK63BzRxz4Nri+o3k9DtpOV0LQHLFbaNNAoQvgix6Qi
	pMDtm/Wi4Rifw4L5si1kmdCOXxp5UcDemJGFFY3rgYVdxbmUBTYYWLBmQBZ/Gd36ZG5gO+3kdxX
	BnE26hWtm2w88vBtypNvNzG2mfcvL1/300n488xh2t
X-Received: by 2002:a17:902:ef07:b0:2ae:ba5f:3ac3 with SMTP id d9443c01a7336-2b0b09a7468mr88751885ad.2.1774537674911;
        Thu, 26 Mar 2026 08:07:54 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8bb5fasm33146375ad.59.2026.03.26.08.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 08:07:54 -0700 (PDT)
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
Subject: [PATCH 1/4] ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplify calculation
Date: Thu, 26 Mar 2026 15:07:39 +0000
Message-ID: <20260326150742.50289-2-royujjal@gmail.com>
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

Get rid of the IGMPV3_MRC macro and use the igmpv3_mrt() API to
calculate the Max Resp Time from the Maximum Response Code.

Similarly, for IGMPV3_QQIC, use the igmpv3_qqi() API to calculate
the Querier's Query Interval from the QQIC field.

Signed-off-by: Ujjal Roy <royujjal@gmail.com>
---
 include/linux/igmp.h      | 78 +++++++++++++++++++++++++++++++++++----
 net/bridge/br_multicast.c |  2 +-
 net/ipv4/igmp.c           |  6 +--
 3 files changed, 74 insertions(+), 12 deletions(-)

diff --git a/include/linux/igmp.h b/include/linux/igmp.h
index 073b30a9b850..3c12c0a63492 100644
--- a/include/linux/igmp.h
+++ b/include/linux/igmp.h
@@ -92,15 +92,77 @@ struct ip_mc_list {
 	struct rcu_head		rcu;
 };
 
+/* RFC3376, relevant sections:
+ *  - 4.1.1. Maximum Response Code
+ *  - 4.1.7. QQIC (Querier's Query Interval Code)
+ *
+ * If Max Resp Code >= 128, Max Resp Code represents a floating-point
+ * value as follows:
+ * If QQIC >= 128, QQIC represents a floating-point value as follows:
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
+/*
+ * IGMPv3 QQI/MRT 8-bit exponential field decode.
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
+	/* RFC3376, relevant sections:
+	 *  - 4.1.1. Maximum Response Code
+	 *  - 4.1.7. QQIC (Querier's Query Interval Code)
+	 */
+	if (code < IGMPV3_EXP_MIN_THRESHOLD) {
+		return (unsigned long)code;
+	} else {
+		unsigned long mc_man, mc_exp;
+
+		mc_exp = IGMPV3_FP_EXP(code);
+		mc_man = IGMPV3_FP_MAN(code);
+
+		return ((mc_man | 0x10) << (mc_exp + 3));
+	}
+}
+
+/* Calculate Max Resp Time from Maximum Response Code */
+static inline unsigned long igmpv3_mrt(const struct igmpv3_query *ih3)
+{
+	/* RFC3376, relevant sections:
+	 *  - 4.1.1. Maximum Response Code
+	 *  - 8.3. Query Response Interval
+	 */
+	return igmpv3_exp_field_decode(ih3->code);
+}
+
+/* Calculate Querier's Query Interval from Querier's Query Interval Code */
+static inline unsigned long igmpv3_qqi(const struct igmpv3_query *ih3)
+{
+	/* RFC3376, relevant sections:
+	 *  - 4.1.7. QQIC (Querier's Query Interval Code)
+	 *  - 8.2. Query Interval
+	 *  - 8.12. Older Version Querier Present Timeout
+	 *    (the [Query Interval] in the last Query received)
+	 */
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
index a674fb44ec25..8c6102737096 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -991,7 +991,7 @@ static bool igmp_heard_query(struct in_device *in_dev, struct sk_buff *skb,
 		 * different encoding. We use the v3 encoding as more likely
 		 * to be intended in a v3 query.
 		 */
-		max_delay = IGMPV3_MRC(ih3->code)*(HZ/IGMP_TIMER_SCALE);
+		max_delay = igmpv3_mrt(ih3)*(HZ/IGMP_TIMER_SCALE);
 		if (!max_delay)
 			max_delay = 1;	/* can't mod w/ 0 */
 	} else { /* v3 */
@@ -1006,7 +1006,7 @@ static bool igmp_heard_query(struct in_device *in_dev, struct sk_buff *skb,
 			ih3 = igmpv3_query_hdr(skb);
 		}
 
-		max_delay = IGMPV3_MRC(ih3->code)*(HZ/IGMP_TIMER_SCALE);
+		max_delay = igmpv3_mrt(ih3)*(HZ/IGMP_TIMER_SCALE);
 		if (!max_delay)
 			max_delay = 1;	/* can't mod w/ 0 */
 		WRITE_ONCE(in_dev->mr_maxdelay, max_delay);
@@ -1016,7 +1016,7 @@ static bool igmp_heard_query(struct in_device *in_dev, struct sk_buff *skb,
 		 * configured value.
 		 */
 		in_dev->mr_qrv = ih3->qrv ?: READ_ONCE(net->ipv4.sysctl_igmp_qrv);
-		in_dev->mr_qi = IGMPV3_QQIC(ih3->qqic)*HZ ?: IGMP_QUERY_INTERVAL;
+		in_dev->mr_qi = igmpv3_qqi(ih3)*HZ ?: IGMP_QUERY_INTERVAL;
 
 		/* RFC3376, 8.3. Query Response Interval:
 		 * The number of seconds represented by the [Query Response
-- 
2.43.0

