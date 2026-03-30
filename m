Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B10A299A81
	for <bridge@lists.linux.dev>; Mon, 30 Mar 2026 19:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774898196; cv=none; b=eLTCHsEuzDcM7eSfchZKUx9GqZmizU7KtTztglq5p0pC9L5bDl68JfQkKNS4Bg1gNP9GTrlUacNa9+FBdNCBwuULVm8m7taTwNhSvllSwmtaLnquuhKsBeK/0NmMxSMBC0RMLDMIprH8ZYvEwBb+Frk/efS3cyQ5J+ei0q8+dlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774898196; c=relaxed/simple;
	bh=WW0vISqU8GwrmrIC4NHoR+TFPQ7BlX0/FvDVbKYURp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KpDURiZl9fj22ikTyh3ECsHKqHmlsUI18aBrBBPkkc8Jtt1J8rjK1OXdOF1vDMdP0P6TPbtStYEgqaxdrLW2g9aaHjDTvwJUTyEmhmqNL+tVFDKGqmQuToe8ubu0lINS9IBrBbmc6ITCIGhNu8u8INs4rAjJhrG44j0ljrgw3do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KH8Kt3K7; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KH8Kt3K7"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35d8e548a05so2929446a91.1
        for <bridge@lists.linux.dev>; Mon, 30 Mar 2026 12:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774898195; x=1775502995; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2s2FZ+Hg0ngcpnnbi9FLabs6QrxAbJsZ+G4M5k6jv8=;
        b=KH8Kt3K77F2LlBQS+iFCqXR5z4CHC6rmBPlVOV5mEczvUjlP4UmBv2a7PuSoaYGPwS
         TJpzbbHv/nSti8yo2uXQsT4hWbCIskio+BqNm0N0trigE1GPLkxfFKAmAK1xJzpnE3is
         FacWmsKC8nFodfYaNsulNWj6w3eoWyLqGHinY4cZicRbuOItV/1fweUNfxIT3TsfGvAJ
         MNv9qHW7Jc77fjUOTCD8lhsfIMwF6MgCrNaPOnxIx3zS28NeEdDyhh9cU7qhiwk05ngO
         qk3W2Gjlxy+vlMqIFZMZdNFPfWklXrX+7dAdO+9Y07JgKvXbDFcbKJEUQ2Nh+03zshiE
         CyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774898195; x=1775502995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O2s2FZ+Hg0ngcpnnbi9FLabs6QrxAbJsZ+G4M5k6jv8=;
        b=onMYpyc5JUUHmaLwdgq7WQKaloPfWeX71cdBgZ435ngvjwdWZ8DtBHnJ3u+c4eQ7N3
         vlJw3DOIGcDDNPepjhD+YQlH7sKZRlnTzVNCpPU6x1QMHMgOwVmF4xrZRoLMXc8dDFhL
         Gw80jagxk7kZzZ8ZrJ7hXgRScsf76NV6XqtOvMUwEBKCzPThxSpd/8ct0fjqqZUW/+jE
         UIU8ovIZcS1OXnMfY6xlyrqI/1j/qfO61hy58yzEltnDNd6RLruK/1Xtxhu6h5xLzGzf
         3uwxrhEJSO1hZSxDJ+BkYRWjBbuN45G2Z8duFfTN1k0JdMxv5GduVWV7uB5nXZpvp5qh
         anvw==
X-Forwarded-Encrypted: i=1; AJvYcCXmsmM6+6JOGQZFz84Dzb/6qmIR+UhUzABGdcO23cqJY8/fX6l8fP0NmQ9EMXb5DPZrJuMhpmU=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxr7Mnc3Oejm5rbEaLJDxZztliIS6e+KwRS5x8X7M07ssSrKPp3
	16kNmwzyWPZ1v8L1gbnqNmFT6oZKAcXpngIg3GC8B4oArQcDilRmqV1L
X-Gm-Gg: ATEYQzy+pEJyUSu47vbVWMF9DD/y4nNVlAv9Q1eBeo0G/aFveHr8v9RWw4oJy61pwaI
	OlCQekSWyqtN8hFYnuICoTQ9/mbwVI80dG55rV7TyeAmWm0rkzzXbywF9rKI/ouEgIeLqCsLflz
	uKPt2SgoDRpeCtoWmTYaFVMyMnXvCUDXbAi4Bnj19h0zWWSx6DJGIUYsWuiaxBOUM4wZEcGbTXo
	JFkUv+vZVuGzj3JGbjBXMCem/dhK8iJ24j2F+kePSs+/6sMShUOVIrgLbJle7waXhRY1UXpiqQN
	FAUhuvgMpaldme6BBlIlmSU8mWe9Unds7E5TjNWFOqsYrRXXRtEs8emlRr8srq5yo/qAxBTxZHN
	flEzkFEcc7bzlkVKxvkYFBuUB98b0r4DEbactTKay9sqbcBH2EjankKCtqZqy67afPqb8yY9Acx
	htOBlIhTJpk2fg4yGLmQM6eZcc8fp00utpLj34j3NX
X-Received: by 2002:a17:90b:3c8b:b0:35b:a1b6:5bf5 with SMTP id 98e67ed59e1d1-35c30146fe2mr12855192a91.31.1774898194656;
        Mon, 30 Mar 2026 12:16:34 -0700 (PDT)
Received: from DESKTOP-82PPU4A.localdomain ([202.8.116.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35d950d9b12sm9627178a91.17.2026.03.30.12.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 12:16:34 -0700 (PDT)
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
Subject: [PATCH net-next v2 1/5] ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplify calculation
Date: Mon, 30 Mar 2026 19:16:07 +0000
Message-ID: <20260330191611.16929-2-royujjal@gmail.com>
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

