Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA1719067C
	for <bridge@lists.linux.dev>; Sun, 12 Apr 2026 11:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775992283; cv=none; b=mO46VWb/KYUixfkdpZGP98b45zaodUhKC1LIAUOgVUqf0euwzWg0oPdDLY7byUSZEmM5BDKP6LNDoFn2ejihUbNzQldRL2s1io84fkfvfRUpdRCC/Ohxi/fXRbnWXBn5XIoSi3qsj2GrPzsSmSUlhaoDn5kQ+YjUigocL5ITtNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775992283; c=relaxed/simple;
	bh=dj8E8sQuMvGGkeFgw8ZCRE6siDsAKhcLUq+TYgXiQ34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MB0GrzeCOPIx8IJynOLPxSSTECOK7cDAJ8f8n77Ar+st7a1LdZEErF1MajhkAjNgaVDH/QAGtqy9xT8F9UoJFlzYuFzLEXzCOUuafGrnYZouXPz91hhZ1OJM2SpiNrGYmQb+fogLQvT+C9NLGc5LS8sIi2AHT0FkHt8zOk9W6lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVmPkeDt; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVmPkeDt"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c742d4df00cso1252912a12.1
        for <bridge@lists.linux.dev>; Sun, 12 Apr 2026 04:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775992282; x=1776597082; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5YffUmzhaIkIbUoe3E2/Xuq3wXpeEBIn/sASnY+Ntk=;
        b=NVmPkeDtDsuUFpMY6fFtJtDYbiHMLzcNRkC+n6oSr05pzdhcAESuRBjADwal58CM/m
         VuKxComjHL7KFKz62yLJHvypV0WxaFhGl/rT8JBYxBlq30007m0t+zC+aweUX7xLBzfp
         NEGJfi3hL8Ogq9R/VQHNwBXDF9p3NByuDBOajeWqJ/liZR8TfvDJbvvivhXaffzmK5Jd
         culxLno0MoaQ682OWmFVt71hiDp8UgK67iIX0oQ684dSoXkSa+8Uk3PAH6VQhACV52YL
         7VWQOLFCBnSqJtbY02a0M1AyBnkKa77WdjGBdsnNAVh7w63BCs4Dgi22btUKNUcGrx3a
         KlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775992282; x=1776597082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I5YffUmzhaIkIbUoe3E2/Xuq3wXpeEBIn/sASnY+Ntk=;
        b=ef9AmyNZGkTz3THapd4ACThXYPMvE7eob6qDb4U+0lTiMvTEe5htwptv/bY1qmUVK2
         B6YhfkgV+5XWszh7WsyJ8vD+6SuEu9+NVM1CHs/YRDJ+a8puS2PgmHoZezEIKgaeK6lE
         dedLFw/NI4+AStEHOuYBWkW5P91P/RMPXO4H6boCZJcMNE9M9ncwEDNImvJMx2kx5naz
         f8e8jM6o8rEGtlRlpbJB2ci4G2upUcRf0h4NaJRPRArFprnr58h+JUSyT+nKfv03F+YJ
         lWaVhzHMekrETuKPniEiS6Cqz+kkc4noneo1Tcm/IT6FWXJ0fAOeIQt7MJLKUptE6zG8
         oTQA==
X-Forwarded-Encrypted: i=1; AJvYcCUVBsgv1ItJbEuZF0Lp1r059BbFkxkZOq/FLp+sEus3Y2Fh+pjHZPGePo86nUwRt4L3SoNO4zc=@lists.linux.dev
X-Gm-Message-State: AOJu0YxL3F05pHMVOTKEoSF9pwH/2s4H5qeyuwiFOBNLdxeX1e6STlJy
	DmxpIBFg/i9I7oTKIgjesjqpQYNKxiX00S/NckPmwrf8+D7d6NS5s5+t
X-Gm-Gg: AeBDietbhHL8fEeSEDQAXBRlHTR+8w4H+2SSKsgR2VmnBWfFtvTyUU7m4kJzhctqUt+
	7J5we7jMJofbOGNS2FlFHfI+t5Jf8zP3hwb2uhd+Psrwsw+2S6fjpHip0XlSCK+ukJC+Adt/YKz
	/SoW1dEtrPmBmU5LeP++BXJ85Oyu0cvomdO0JzdVBH4JNsQScF3tUeHzdejgHIHzuW384qoKGRB
	s++5g7ESe6thl6gsjnjXMu+OTNyBNgZzFtMmFHETh23bqmSD5NI295nOQlJp2vk39CXuM7nLl4X
	NizDA5vYpoTS9UEgvBrogc0ssNlEf5jD8Xl6R7r82ffG1I2RxZie0USZvVhJR4H0166Fr1W+w5K
	AZ2yEfURBhoq/ytCMH/wvIq6pZunwFSykj53oGwX6FkYeV1SAFUYrLZ1xiqsBry2XDiEXE2Of++
	AcGtjppT2DevKUyk3ooJZ50dOENsan7SD+k9Mf48sb
X-Received: by 2002:a05:6a20:3d87:b0:398:7667:b2fb with SMTP id adf61e73a8af0-39fe466bbd7mr8477194637.19.1775992281819;
        Sun, 12 Apr 2026 04:11:21 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.169])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7934c9ef38sm2522981a12.12.2026.04.12.04.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 04:11:21 -0700 (PDT)
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
Subject: [PATCH net-next v4 3/5] ipv4: igmp: encode multicast exponential fields
Date: Sun, 12 Apr 2026 11:10:45 +0000
Message-ID: <20260412111047.1326-4-royujjal@gmail.com>
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

Signed-off-by: Ujjal Roy <royujjal@gmail.com>
---
 include/linux/igmp.h      | 87 +++++++++++++++++++++++++++++++++++++++
 net/bridge/br_multicast.c | 14 +++----
 2 files changed, 93 insertions(+), 8 deletions(-)

diff --git a/include/linux/igmp.h b/include/linux/igmp.h
index 4443c914b3c8..4d8af9031e18 100644
--- a/include/linux/igmp.h
+++ b/include/linux/igmp.h
@@ -109,6 +109,93 @@ struct ip_mc_list {
 
 /* IGMPV3 floating-point exponential field threshold */
 #define IGMPV3_EXP_MIN_THRESHOLD	128
+/* Max representable (mant = 0xF, exp = 7) -> 31744 */
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

