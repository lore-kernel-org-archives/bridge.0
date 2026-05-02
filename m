Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E19D1E8342
	for <bridge@lists.linux.dev>; Sat,  2 May 2026 13:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777727983; cv=none; b=p/yj+eiQ0xmuIXQF5xujDTBWCfSMPFSH1GqgoJaiYxG2t5+kSTuiyGFFWjatpE3CIr6Lz8VhLQq7aYdqjlT+ijH7VQxtLl5pl9l2B6p3dnG3w6QE2iTK5SX9d2s5I927GVBXALY8peX/sJq9wHg9p44cdsUwLwYJF8xVRtDWgjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777727983; c=relaxed/simple;
	bh=Gt27CTUkBy3/9y5hHiuXgkkQRu0kM5q36flW22f2Fr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t48TbaZqeKBqfj9B9hX9inn7bzpmhQ1Vnxekbq6eV/4PaOPQZcJLURg6F2h39uUqee6ZWV6Roh1fcEIkhKHxwXZq7yGBVsPuZzIO1cgxUa0jjDbnn9epM1T5WjWSCZoAIsCu3VigVK7MvtAhLbyj++AI0L8g828F/ARXN4Us/7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZzVbIZo; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZzVbIZo"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c801912c903so75364a12.0
        for <bridge@lists.linux.dev>; Sat, 02 May 2026 06:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777727981; x=1778332781; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmZ9G/rM0nAD31XWpPt5TscDsPxaAtvREA8xoPmeb2k=;
        b=nZzVbIZoPOL/m90CVY6BB7l6PgSXVWrcu/agfD2SDG5Z+dFg0/lZt/3KXHhULWpLD6
         ofUHfm2KxU1uRzuy1qUxbI43TMyv3Z17TTxjIGMTFYzIoCNYX6Xi/9K11IEPj0hsATN0
         tjrv1io/YyDB3lQiv3zwq06svU/UhtsyN0rjnHaTCHfMCrTYxdRC/pVrBBsLR7jZ0H9L
         zHf6YAAM9LmUY5+Vjf2c8A+FuZE519ukmkaAdknwgRZNboFvJXyRE9CBKW7fDSiytx4j
         S84h9wO4Qi//hf0NYB/ZH0ErM8PqRrhXysOg+v371CtA2zKjbyYV1EetMg+CM3VkFTag
         WyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777727981; x=1778332781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jmZ9G/rM0nAD31XWpPt5TscDsPxaAtvREA8xoPmeb2k=;
        b=GyXhhWzZ2L8K5ZAKrV9t3PL7NIVsFhq1S0hufz+BMFfj+SFVusJhu7S6FiyZW2IWTd
         HDpImEhfXBfeCSy7Fb74ycfv2VHE8vUcxSJYO3TGtHcdVERDpEgfuW482BwnkZn8RyJu
         /ZnXZaMO7oFjcSLASv3bxhs64WRw5nkZ9B/rMtix8JcAntHw4foKHHtSL4P9FeHXRPzg
         QBYk/0JESC7bThLo4pPPqD0/DksgYYotjLZU4jOfu3jcIyLX4/3DiOH0LhRCDH5SodKf
         J4Yd8XqXviYmm/m2f4SpeYKTQjYSCBTM7Jvhh2atHWapqCfodT+tY/0mCXWwkHieLnjs
         p9lA==
X-Forwarded-Encrypted: i=1; AFNElJ/mwYW63ZZcX1mz1GrLhOwKhGPpgmqyqOVKHRaKn2tH8FquJlRlvKf1Sq9isb84escRj7RlXjM=@lists.linux.dev
X-Gm-Message-State: AOJu0YyOrADg2DvubVXt0uVkFsKVBmDirTHP3hY87m+PecEYAAsgIqkg
	rEESRSmwaBcRiwg5ViVxlt7XbzvRWBXAuKKlw4R1nJyDOOMCjba3YOAV
X-Gm-Gg: AeBDievdCjpMt1Uwg5M1//IL8qp7ymxY1uKs11Q6B3WaHYoAPDLHsLHW7xk3Jix/RYN
	hT7sudwUovOUerVGdbChh+Ch2fYVBXFrVlUY6RIi2uCepU/oWuP0seWx7eHidc3rBspodwC/Pqm
	HPie2oPD+3OEZ/XidlBKTZzpCLCifFXrRGcLX+6U9LPkzuOqogAKxPfB6DmZ9yBpZWDh2QwsyxO
	+rP1MB7YvsaYswzf+g+ciJsLae/HhgdfNQmDkXyp1jrPy+fsCN1VoENYcY6LcfC1C/ZEvZkuE27
	WC55qjR8b17VvzKKsxJGbpzckaU93Uxv4Bkz8jJaUkgt3zVgLB4F6mIl5dd6mNGskUI/888X0LH
	nUHXisTsQtD2sTnzPE91eEcuvJmzJAORrc/QK8w1ksdoP/p+L7Y5lKx31pxBGHlHu3/Tkasip4A
	qwlP70PxCF8KcGKW4MJ0quPblcSNaCqJMeRGkU8FnHPGzFzxDEYw==
X-Received: by 2002:a05:6a20:12ca:b0:39c:c07:1450 with SMTP id adf61e73a8af0-3a7f1c748f6mr2909119637.42.1777727980852;
        Sat, 02 May 2026 06:19:40 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515ad0176sm5553791b3a.39.2026.05.02.06.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 06:19:39 -0700 (PDT)
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
Subject: [PATCH net-next v6 3/5] ipv4: igmp: encode multicast exponential fields
Date: Sat,  2 May 2026 13:19:04 +0000
Message-ID: <20260502131907.987-4-royujjal@gmail.com>
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

In IGMP, MRC and QQIC fields are not correctly encoded
when generating query packets. Since the receiver of the
query interprets these fields using the IGMPv3 floating-
point decoding logic, any value that exceeds the linear
threshold is incorrectly parsed as an exponential value,
leading to an incorrect interval calculation.

Encode and assign the corresponding protocol fields during
query generation. Introduce the logic to dynamically
calculate the exponent and mantissa using bit-scan (fls).
This ensures MRC and QQIC fields (8-bit) are properly
encoded when transmitting query packets with intervals
that exceed their respective linear threshold value of
128 (for MRT/QQI).

RFC3376: for both MRC and QQIC, values >= 128 represent
the same floating-point encoding as follows:
     0 1 2 3 4 5 6 7
    +-+-+-+-+-+-+-+-+
    |1| exp | mant  |
    +-+-+-+-+-+-+-+-+

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Ujjal Roy <royujjal@gmail.com>
---
 include/linux/igmp.h      | 87 +++++++++++++++++++++++++++++++++++++++
 net/bridge/br_multicast.c | 14 +++----
 2 files changed, 93 insertions(+), 8 deletions(-)

diff --git a/include/linux/igmp.h b/include/linux/igmp.h
index 0e095c9f234e..3a2d35a9f307 100644
--- a/include/linux/igmp.h
+++ b/include/linux/igmp.h
@@ -109,6 +109,93 @@ struct ip_mc_list {
 
 /* IGMPv3 floating-point exponential field min threshold */
 #define IGMPV3_EXP_MIN_THRESHOLD	128
+/* IGMPv3 FP max threshold (mant = 0xF, exp = 7) -> 31744 */
+#define IGMPV3_EXP_MAX_THRESHOLD	31744
+
+/* V3 exponential field encoding */
+
+/* IGMPv3 MRC/QQIC 8-bit exponential field encode
+ *
+ * RFC3376, 4.1.1 & 4.1.7. defines only the decoding formula:
+ *     MRT/QQI = (mant | 0x10) << (exp + 3)
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
+	/* MRC/QQIC < 128 is literal */
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
+ * RFC3376, relevant sections:
+ *  - 4.1.1. Maximum Response Code
+ *  - 8.3. Query Response Interval
+ *
+ * MRC represents the encoded form of Max Resp Time (MRT); once
+ * decoded, the resulting value is in units of 0.1 seconds (100 ms).
+ */
+static inline u8 igmpv3_mrc(unsigned long mrt)
+{
+	return igmpv3_exp_field_encode(mrt);
+}
+
+/* Calculate Querier's Query Interval Code from Querier's Query Interval
+ *
+ * RFC3376, relevant sections:
+ *  - 4.1.7. QQIC (Querier's Query Interval Code)
+ *  - 8.2. Query Interval
+ *  - 8.12. Older Version Querier Present Timeout
+ *    (the [Query Interval] in the last Query received)
+ *
+ * QQIC represents the encoded form of Querier's Query Interval (QQI);
+ * once decoded, the resulting value is in units of seconds.
+ */
+static inline u8 igmpv3_qqic(unsigned long qi)
+{
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

