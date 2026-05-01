Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7683A30E0D6
	for <bridge@lists.linux.dev>; Fri,  1 May 2026 17:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777656726; cv=none; b=nTxIt3vGDfE4IkZUbhKxCh2vdea8EKe0/CI7s7w7yGwmZLdjP0UVWdE1mbC0xvBcHm0zE3C9AwkBoloiUaHovx3LFVTp3Rw6WBEQsjGK1Y9N8FK80DT1W4SkD7q0D5199ZfR59UUfqMKTA8ZyDsCJ/7EEXZQqScoIBHHVRFRpMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777656726; c=relaxed/simple;
	bh=ZVHW1z1PIb5ePVtbyq08NJ8dexrkCXfgDVaSH/sbAuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KFKTstKNYNYHG/aQH/CKZ4sRPUtIWXcjl0zoT2nW+MC9igS/dsOyj5zufAQ2XzZV01TnlwjO4JZY3vHhItj96lU4zBrgwOdB+Am1x1THxKRfLB0hIemQ1LxM8gq+9yNkMpPRaSfwoG5ZWL8USUhY9d3xju3s//lrorGaTEGuKtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=opXabRLX; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="opXabRLX"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-356337f058aso1404181a91.2
        for <bridge@lists.linux.dev>; Fri, 01 May 2026 10:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777656725; x=1778261525; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnFHFq0X3do40vbZFzPcxUaeVD7TkwqS7ui8TNvbysY=;
        b=opXabRLXwTvubZlWTokt5Of7cKqAD/0gTKm5NRhw9SwwkqPPX0CfEfxk8EskswIdpT
         pMtDGNDqh5/zT+R5J5woJQwJJ5hGR3Bp8noZMW4KRAGWuMBQDN02ExfX5MEsDvn9cyet
         jtL/1rU9J2xaWTeQcJ5vWgJtOpih0ANSLNmtZ9nWsYIrlPMdwBtHKCAKpPrAsm11v8Jr
         k+rOUbFWjDIllRyFqfOi0JNzJsEuIlsDnOXFRaHoc5lRyEmjwEryJ8ro5CTLbon/LNME
         gR1TrVKAovrh9B+FnslzPNojZMBloR9opu1C1512hJR2+a5bzOqMW1z+8BZo/+X2uYP/
         PIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777656725; x=1778261525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qnFHFq0X3do40vbZFzPcxUaeVD7TkwqS7ui8TNvbysY=;
        b=EEfN9DwmLBoCunDWf83CgMlMOdSMfd/3N52z33txGNhGGOqzj5/MgWA7B+alDgLD2l
         VQ0pnzd7izHT431ZL0V0+XBm3hQ1pNayu8LKLzyq5J0Pep0omrumq0HnHDrM7RqMn6Go
         9LEGLredu71ElNtKZr812PrxIQfLmq+qgus31TXArh8+lMwEYF5bK3iWRZCvaDQT/mXv
         wATYtdabRpdgfbM16Vquq4gmNv8/XYGmmV/2apqyfzwR0/OBw96DTKU/F0oWZPdZvZdp
         NAn1sxCpyDdrVItvk54vnaTb2limp46b519WWFfFAtWfU6MCsTIbKQIK+NWwlgYhz23Y
         s6SA==
X-Forwarded-Encrypted: i=1; AFNElJ/6I6nen+qCGOYi8ja3J2El0jTps3BviWKnUNVw7QPwTyx4n+tdyJS5yM7jv7CRLl10A8ro0O4=@lists.linux.dev
X-Gm-Message-State: AOJu0YyYDkyBQCilyY+D1u4DiJnMJjtZf+rVvnmdl+swQs3LKrmMJLkg
	4W7kId//u0yMnRzS4ofSO4buf2gxbpNZdeDxJHrTrRQVgIAptpxKnVF9
X-Gm-Gg: AeBDiet1aF8K2rfLV3PyKQy748I1o3p5BRtHhlPmc0b1Sj4EHfhOqIHhg2BG+zIcwU+
	wYTs6CfEA6WqIFxA6RkvX83+ziD+UdskNfvemMNAO0CX1IF+aeIwGQCSX6iFpNVsJcyZs5HyFoy
	H6NGajscFzJhR6pj5cffATQK/6H4st3Y04AyMtFeuzEMvtFETroawt8J8MCgT9DvNn1iievZrV4
	XVpUqaXbAOOLoJsozwkj54e68sCbYt47s/8bPTtQoZ4SPbUE3s+el+iHcB6PbXR7++g85korgah
	X0BTbAdYoAweuj+or0QHHCOECGXrD2ui3zTQgmLcXOmHk4GF34ZHcHkUEcsg7vVvbFgYLDt60as
	9RW65dzBXTz0JsTsLZORN9kf+QLKWRRWlHM6pY2XvV2Z3z5skLLR2Uil1BXWOk3rs3sx74tDCGq
	n8AIMTDdHm6uUl9ohfvxNsDNsEh86njQwN7SwW9hPz6am0HwTG+w==
X-Received: by 2002:a17:90b:518e:b0:35f:b5df:449 with SMTP id 98e67ed59e1d1-3650cec16c5mr137991a91.21.1777656724709;
        Fri, 01 May 2026 10:32:04 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ebec73aasm2908906a91.2.2026.05.01.10.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 10:32:04 -0700 (PDT)
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
Subject: [PATCH net-next v5 3/5] ipv4: igmp: encode multicast exponential fields
Date: Fri,  1 May 2026 17:31:27 +0000
Message-ID: <20260501173130.3486-4-royujjal@gmail.com>
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

