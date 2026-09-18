Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3D42D838E
	for <bridge@lists.linux.dev>; Fri, 18 Sep 2026 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745409; cv=none; b=U9ZJwC+bgHv1Gm/1v3i5UEXUjttwQ2zFHgxDSg7nLUpiGA5FT1CLu5EGSq1jWQq9p30MxVSFuK0jGy8BZBJfKrYbvHgPj4pWx6oReemftKjDiIjk9vQScOT4kp45mkrSeal3XKpffxzbEF6+8ak2xuhGj7anIEuvvPE2mZL3txo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745409; c=relaxed/simple;
	bh=xcwPMEyUdThFUZmECORcjLJNvICFMw6Si/uK6BGQKCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mn26lWNx2VdsUZ7OuHAaAPlx+CKUvUkq8oVmnocyQmGux56fMgu0nbDZvpcD4BKJjeLeWghPEwYdBIqWiXovuBTTFVM8NfqLhpfE7s+RGg7F2ESS9wD7YqVqCtXakUjUi5eRJh/XytVQo6lsbVubS98YXOOH5TlN56ae0tBTcBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Mpjwu9bv; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Mpjwu9bv"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd38e0e5dso11410825e9.2
        for <bridge@lists.linux.dev>; Fri, 18 Sep 2026 08:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1789745404; x=1790350204; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XAH6ybuLMH11ySnU7t7Cyg4qx6OtxBlHew5cBLxJKO4=;
        b=Mpjwu9bvDwqsnK3ThRGJA5FtzIO0v4UUGYI/3NeGJJC/GiCWEPHLJoSfOFOvPWSOre
         CcM7NPJI5zRLCInNrSS/320tQ//OCfoLwtqJYr4grrCxTsj5kYQZD3qhxqBpPyrpvXz7
         daXC4GFVt7lmrjhskwiAI3QufHvfIfNCwrYZDBuD7W6HqOiyG47xzzMUkdnqw4kUuzRp
         KBlAriEdvLoHPQt2dMa9/t5UCM89Vi6ouU+Zyf9KcT7BGzOox6zcXmIU1uxbEUjM8iyz
         YKAaG35XicAOUlPlhcSXuTe86QUl1hIGqKEm2bNbjzcu5xjpsg6fOAIbz4Gvg6Frx/vg
         AT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789745404; x=1790350204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XAH6ybuLMH11ySnU7t7Cyg4qx6OtxBlHew5cBLxJKO4=;
        b=z2rokSuWeRLH2ihW65OVlsfql3BDiVUAtczGE3A6jxAxmjcDsUejxzIq20ASn+2qa3
         LOT7EDH6SeuyVpMYGfXRThWT9D4Gr7FsejHPheS9Y0/CNRJ8Hh6rXsfCUUchGMbMeddV
         CzVQ4EeI6nxvEbwyk6mmOPtyb9DLtUw+JSr4Jzf6P55HrZf0VAvkmdOuku5w7VuscjCT
         yTKTWuxBgRj7UWhLKyAyEBodVh/PXKVGwZBRQuYDivb7YSz/KakzwPpbbiB0xHjS6hkX
         ZeYtnSeA0hEQXLxvqBBa6NFyEXcoF3l/yJsZzL9pMC4W9ClhaClH5h+uw5j/fysGKVum
         HkRA==
X-Forwarded-Encrypted: i=1; AKwUvBzrj1YHU2c/WjCIlW2bUslyj5jGojeoim8+znrDxadzB3VtgxUgMsclg+Sp15wG9QCnfDETt+E=@lists.linux.dev
X-Gm-Message-State: AFuF++lGxEe+nqSLLoi+dLYDhc1XZAC7vf3WzZPsab8EWzJLLwDn+6no
	CATCR/tE24Jo/a94fkODggCasyKrkzOjsx8CbQX+EC6Pnp45CfiF8I3F023jRFL+IVg=
X-Gm-Gg: AYBFou2OyIx8uSuHqkZxC0SBr1VlyPBUwAcBEeZq+w7jFueIq4mIjcT5Px9bukaSfYe
	/6b45pky58lQM1wZyn8M/FGfix77r6XpRMj7yTSs3UukAkmyq6waT5gAd1FvFQOzk7Ej9UdzLwZ
	0y50yO4xyo/s5PuQmgbmRox2q3aen4Z2BH+kyj5XGZQmUQX35U1Z5cIHU0NZ/UYd7NhnJAydJSL
	DyW6mbqsyVLllFqyqLcy9pcZ4SU4zMJcKIGnYN8yAMXMtJpM/BqIkq02/uV8UAwqHbJjcw/JobB
	snFQpnIH5sQMdn0dhUls0l2jjXDNH4bLUGM5smQo+lrgFMl2l4gurjzLg8LOI2vbPJ7QDUS/QQQ
	pbDyQojMAYWvFphFIWPBrkVCc9wsTo71c9NRNkM6fLdXsxrsRQtv3uNAmhOdnrQp/BDnS1A1k5u
	a0PRA9H6CU0PmcVFjtit0JdlqVZoeiJTtlr3tpEXUmgoGH5SbO3DD7p97E0NPhWydYgJTNeXrYY
	yzp9uQrlvWFLAk02uwm8A==
X-Received: by 2002:a05:600c:4e4c:b0:49f:bd3c:bc28 with SMTP id 5b1f17b1804b1-49fc574f456mr40286575e9.35.1789745404345;
        Fri, 18 Sep 2026 08:30:04 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49fcd0a381fsm261035e9.14.2026.09.18.08.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 08:30:03 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 8/9] net: bridge: avoid egress VLAN lookups when flooding
Date: Fri, 18 Sep 2026 18:29:49 +0300
Message-ID: <20260918152950.1938259-9-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918152950.1938259-1-razor@blackwall.org>
References: <20260918152950.1938259-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VLAN flooding already provides the exact port-VLAN entry associated with
each destination port. Use that entry directly for the egress state check
and VLAN handling instead of resolving it again from the packet VLAN ID.
Keep the existing lookup path for forwarding destinations which do not
provide a port-VLAN entry. This removes two VLAN hash lookups for every
flooded egress port. Use __always_inline for should_deliver as it provides
a measurable 3% additional gain, should_deliver wasn't inlined even though
it had the inline specifier, the bridge module size increases by 173 bytes.

The series were tested in a two CPU VM with packet generation and bridge
forwarding on separate pinned CPUs. The results are medians of seven runs
with 300000 64b tagged broadcast packets.

                   Mpps                   br_flood TSC cycles/input
  VIDs Ports  before    after    gain   before  after  reduction
     1  8/2   1.209298  1.636580   35.3%     1444    845      41.5%
     1  8/4   0.843175  0.986541   17.0%     3036   2527      16.8%
     1  8/8   0.508857  0.559844   10.0%     5999   5465       8.9%
     1 32/2   0.893896  1.586532   77.5%     3013    841      72.1%
     1 32/16  0.250567  0.282339   12.7%    13670  11137      18.5%
     1 32/32  0.135351  0.148461    9.7%    25429  22320      12.2%
     1 64/2   0.555010  1.603776  189.0%     5001    837      83.3%
     1 64/32  0.123831  0.149639   20.8%    27674  22602      18.3%
     1 64/64  0.069122  0.076047   10.0%    51508  45138      12.4%
    64  8/2   1.044185  1.500468   43.7%     1528    851      44.3%
    64  8/4   0.802680  0.977700   21.8%     3178   2546      19.9%
    64  8/8   0.479748  0.555419   15.8%     6283   5635      10.3%
    64 32/2   0.861074  1.561266   81.3%     3063    849      72.3%
    64 32/16  0.234011  0.280027   19.7%    14332  11165      22.1%
    64 32/32  0.126145  0.148085   17.4%    27225  22613      16.9%
    64 64/2   0.530587  1.496179  182.0%     4377    826      81.1%
    64 64/32  0.121105  0.147943   22.2%    29286  22541      23.0%
    64 64/64  0.063626  0.077051   21.1%    56147  45520      18.9%
  1024  8/2   1.008693  1.358408   34.7%     1538    879      42.8%
  1024  8/4   0.785636  0.943545   20.1%     3280   2704      17.6%
  1024  8/8   0.448194  0.521765   16.4%     6678   6011      10.0%
  1024 32/2   0.840864  1.417311   68.6%     2756    859      68.8%
  1024 32/16  0.195786  0.247129   26.2%    16269  12639      22.3%
  1024 32/32  0.097978  0.122742   25.3%    35249  29273      17.0%
  1024 64/2   0.536947  1.400985  160.9%     4421    849      80.8%
  1024 64/32  0.093962  0.123383   31.3%    37425  29197      22.0%
  1024 64/64  0.045147  0.057867   28.2%    72626  59198      18.5%

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_forward.c | 23 ++++++++++++++++-------
 net/bridge/br_input.c   |  2 +-
 net/bridge/br_private.h |  7 +++++++
 net/bridge/br_vlan.c    | 31 +++++++++++++++++--------------
 4 files changed, 41 insertions(+), 22 deletions(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 845193baf992..d89f1b7d6def 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -21,17 +21,26 @@ struct br_fwd_dst {
 	struct net_bridge_vlan *vlan;
 };
 
+static bool should_deliver_vlan(const struct br_fwd_dst *fwd,
+				const struct sk_buff *skb)
+{
+	if (fwd->vlan)
+		return br_vlan_state_allowed(br_vlan_get_state(fwd->vlan),
+					     false);
+
+	return br_allowed_egress(nbp_vlan_group_rcu(fwd->port), skb);
+}
+
 /* Don't forward packets to originating port or forwarding disabled */
-static inline int should_deliver(const struct br_fwd_dst *fwd,
-				 const struct sk_buff *skb)
+static __always_inline bool should_deliver(const struct br_fwd_dst *fwd,
+					   const struct sk_buff *skb)
 {
 	const struct net_bridge_port *p = fwd->port;
-	struct net_bridge_vlan_group *vg;
 
-	vg = nbp_vlan_group_rcu(p);
 	return (test_bit(BR_HAIRPIN_MODE_BIT, &p->flags) || skb->dev != p->dev) &&
 		(br_mst_is_enabled(p) || p->state == BR_STATE_FORWARDING) &&
-		br_allowed_egress(vg, skb) && nbp_switchdev_allowed_egress(p, skb) &&
+		should_deliver_vlan(fwd, skb) &&
+		nbp_switchdev_allowed_egress(p, skb) &&
 		!br_skb_isolated(p, skb);
 }
 
@@ -89,8 +98,8 @@ static void __br_forward(const struct br_fwd_dst *fwd,
 	 */
 	nbp_switchdev_frame_mark_tx_fwd_offload(to, skb);
 
-	vg = nbp_vlan_group_rcu(to);
-	skb = br_handle_vlan(to->br, to, vg, skb);
+	vg = fwd->vlan ? NULL : nbp_vlan_group_rcu(to);
+	skb = br_handle_vlan(to->br, to, vg, fwd->vlan, skb);
 	if (!skb)
 		return;
 
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index b20c7c182a80..4357d78524a6 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -58,7 +58,7 @@ static int br_pass_frame_up(struct sk_buff *skb, bool promisc)
 
 	indev = skb->dev;
 	skb->dev = brdev;
-	skb = br_handle_vlan(br, NULL, vg, skb);
+	skb = br_handle_vlan(br, NULL, vg, NULL, skb);
 	if (!skb)
 		return NET_RX_DROP;
 	/* update the multicast stats if the packet is IGMP/MLD */
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index a33da6e9765f..7c0b1d3e7931 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1606,6 +1606,7 @@ bool br_should_learn(struct net_bridge_port *p, struct sk_buff *skb, u16 *vid);
 struct sk_buff *br_handle_vlan(struct net_bridge *br,
 			       const struct net_bridge_port *port,
 			       struct net_bridge_vlan_group *vg,
+			       struct net_bridge_vlan *vlan,
 			       struct sk_buff *skb);
 int br_vlan_add(struct net_bridge *br, u16 vid, u16 flags,
 		bool *changed, struct netlink_ext_ack *extack);
@@ -1743,6 +1744,7 @@ static inline bool br_should_learn(struct net_bridge_port *p,
 static inline struct sk_buff *br_handle_vlan(struct net_bridge *br,
 					     const struct net_bridge_port *port,
 					     struct net_bridge_vlan_group *vg,
+					     struct net_bridge_vlan *vlan,
 					     struct sk_buff *skb)
 {
 	return skb;
@@ -1953,6 +1955,11 @@ static inline bool br_vlan_state_allowed(u8 state, bool learn_allow)
 		return false;
 	}
 }
+#else
+static inline bool br_vlan_state_allowed(u8 state, bool learn_allow)
+{
+	return false;
+}
 #endif
 
 /* br_mst.c */
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index d750581df64d..ce5aa15c4540 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -520,10 +520,10 @@ static void __vlan_flush(const struct net_bridge *br,
 struct sk_buff *br_handle_vlan(struct net_bridge *br,
 			       const struct net_bridge_port *p,
 			       struct net_bridge_vlan_group *vg,
+			       struct net_bridge_vlan *v,
 			       struct sk_buff *skb)
 {
 	struct pcpu_sw_netstats *stats;
-	struct net_bridge_vlan *v;
 	u16 vid;
 
 	/* If this packet was not filtered at input, let it pass */
@@ -534,19 +534,22 @@ struct sk_buff *br_handle_vlan(struct net_bridge *br,
 	 * a valid vlan id.  If the vlan id has untagged flag set,
 	 * send untagged; otherwise, send tagged.
 	 */
-	br_vlan_get_tag(skb, &vid);
-	v = br_vlan_find(vg, vid);
-	/* Vlan entry must be configured at this point.  The
-	 * only exception is the bridge is set in promisc mode and the
-	 * packet is destined for the bridge device.  In this case
-	 * pass the packet as is.
-	 */
-	if (!v || !br_vlan_should_use(v)) {
-		if ((br->dev->flags & IFF_PROMISC) && skb->dev == br->dev) {
-			goto out;
-		} else {
-			kfree_skb(skb);
-			return NULL;
+	if (!v) {
+		br_vlan_get_tag(skb, &vid);
+		v = br_vlan_find(vg, vid);
+		/* Vlan entry must be configured at this point.  The
+		 * only exception is the bridge is set in promisc mode and the
+		 * packet is destined for the bridge device.  In this case
+		 * pass the packet as is.
+		 */
+		if (!v || !br_vlan_should_use(v)) {
+			if ((br->dev->flags & IFF_PROMISC) &&
+			    skb->dev == br->dev) {
+				goto out;
+			} else {
+				kfree_skb(skb);
+				return NULL;
+			}
 		}
 	}
 	if (br_opt_get(br, BROPT_VLAN_STATS_ENABLED)) {
-- 
2.47.3

