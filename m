Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64C032F75B
	for <bridge@lists.linux.dev>; Tue,  4 Nov 2025 14:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268300; cv=none; b=e3OSc4PIQCkoFxf8g3K9iZVHSfN3AWwCr3wz8CZaMviSU45wM0Eny+GMfXhm9FVsUdkN2mqneKDWbs8Zug+4mjWHZgFTrd4UO0qxUiM2mBGWmo/VjQ3E3eCcgORV5YgrfeF6YqFjZqLQjHEBa2PcAgEJ+Vl17SL+J1Dvp1sQgyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268300; c=relaxed/simple;
	bh=NfMwE8dlBybLdyHrMU5tp+2O3dmiRVolCqKrdaLCBmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RdB19BDe78tqaYRRdBnCh4kJFX3/YwnUgZSxNrIxwC322y+6hhijbPu0IRQzRMKMa8+wpTXZn8cBhQ79We+9/7U/7dO5Y0qyhtyHnp5x6ljfqa/U7bcH7HNNJvPdfSJhqwWE7jObgK1FfQmQJj3LsfMSM48vR2EyNrglp5FcPqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajsbUOwd; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajsbUOwd"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b7155207964so377363766b.2
        for <bridge@lists.linux.dev>; Tue, 04 Nov 2025 06:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762268296; x=1762873096; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hS4vmMYkkCMh57/80KWcAsjRY0+LD1ZQh8tlkeNEwTE=;
        b=ajsbUOwdUXZuHehAeXfYIdaLlcsi05hJgUd77dL8AY+t4785PXHlN1qxpt9VN15YQj
         9NzrPUSVY6SiUpNMB5ol4HqhSHhnUFDaiesrss1g4kOnuH9+wEeU/7oXwkRuD4GQH03y
         NbUS42hesQylHDeLkc8EMszoHSx9Kqcb6jqqvTozRHRqNk1dvR6L0lFWBFHPUFtkONS1
         vbjpjd68CS8KHuUhWak0i0+Kgd5I32AuWxm1NaHgo6xa/9q39iM9r7jnRkukKobHQVge
         T/A1DNWHtzG0mWqvw6O6pO2j3hepRT2Zs/M2/mwJKZDvUsmqwHfbD3TxfjB5j+aje9Xq
         lwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762268296; x=1762873096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hS4vmMYkkCMh57/80KWcAsjRY0+LD1ZQh8tlkeNEwTE=;
        b=eaKTflpvSj63qwQhM+Z/TaFXV9SdwuSUDa4qF32EPAPk7aYU12zkWGe8qK0conLy7x
         XCBIakFCHVJNmjev9V06UcM2O1mnaB8igjQMx0MjzWhdJo1a81XWWhwHJIJVu2E+FSFN
         WcENfo7HzEvmai6uGQGJ7RiS+CkiNEmBTW5TT0lmbb2JhJ6DOmB3rd/l4S6mS+TMAUJY
         D62aQ7rrRurHVIaUMnQyxk7D8LTTXZD6cTlvR5j8kZ+qCCnYuhiOW6U4nIAVHsrtMr8T
         inPb1ZsqsuD+57m0VZrXH985cmbQLr6kUEDu/jHVb1K3gutfc6ONIF9J6i2TP1qbqTst
         tzIg==
X-Forwarded-Encrypted: i=1; AJvYcCVufcMddsNGsagmtLRBPzr4WHoN/BwHr9+r9StBIK8gkmE6q12crFCQO/Mt3UHeAGYy5LA91ic=@lists.linux.dev
X-Gm-Message-State: AOJu0YwL71HhYDu071MxYpSej5KK5eh2Qb9m3uoAc3XeoGBD2vR/8g8e
	dJx+oiNVByzL9V49IA1YNbmscWxr3++TfbvTIhR7mWpo0WyUXvx+G1Iy
X-Gm-Gg: ASbGncumkWaU5E4zg7tvZRZMZPdoNQjwhrzowFLu/q5UT66bOpU8ELmUDrLu5UWN/C0
	KLCDplS8pddLjwskBLz9iA0wTHGTPz2JH3SEUo12cu1YmYynJ5hvPe/T42cpQsv40CzzXvtZXUg
	C5FApwJxQ4S/Zay5gzp0gK136QoP7tW3fA6iPEPrrIWgnFI9NqkSUeMSr9M7i74otgujOOrNNyl
	JgzNib5dexvvVzTjRg+2x9P1doRhoC4TYXdi1PYgc7ZfCPgcjUdS7blhIWQXBsFsUgTiy4aiyAG
	mRI5yeetOb3Kg72AQxt4cdhoxdR08W4AI3nMt6vxSIpa6n9b4BPKKAdUtBI+NP36UGNxMOiiI6O
	QveBqPaQmB+6mQf1sqFfkTCocRmpq0iv93w1rBJNgc6e5vr6o3r3l35x1L8KhM51dWmeDJst2nF
	Oc5FmokCW5MhFYOIonD+tRp4uO3AWpxEBd49gwV7DKcp6ySILhZQyR8BZfYpfWLpAI8osoTDI=
X-Google-Smtp-Source: AGHT+IEzyqLNCwkiIEcsmd4yqk6UOJ2lkQsHu2qKvUmx/if9TQ0V8rUE84bH+QRg7d80a1B6xxzGPg==
X-Received: by 2002:a17:906:6051:b0:b70:8519:44a3 with SMTP id a640c23a62f3a-b7085195e4amr1116437366b.21.1762268295938;
        Tue, 04 Nov 2025 06:58:15 -0800 (PST)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723f6e2560sm232681666b.46.2025.11.04.06.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 06:58:15 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v16 nf-next 2/3] netfilter: bridge: Add conntrack double vlan and pppoe
Date: Tue,  4 Nov 2025 15:57:27 +0100
Message-ID: <20251104145728.517197-3-ericwouds@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20251104145728.517197-1-ericwouds@gmail.com>
References: <20251104145728.517197-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a bridge, until now, it is possible to track connections of plain
ip(v6) and ip(v6) encapsulated in single 802.1q or 802.1ad.

This patch adds the capability to track connections when the connection
is (also) encapsulated in PPPoE. It also adds the capability to track
connections that are encapsulated in an inner 802.1q, combined with an
outer 802.1ad or 802.1q encapsulation.

To prevent mixing connections that are tagged differently in the L2
encapsulations, one should separate them using conntrack zones.
Using a conntrack zone is a hard requirement for the newly added
encapsulations of the tracking capability inside a bridge.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/bridge/netfilter/nf_conntrack_bridge.c | 92 ++++++++++++++++++----
 1 file changed, 75 insertions(+), 17 deletions(-)

diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index 6482de4d8750..39e844b3d3c4 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -237,58 +237,116 @@ static int nf_ct_br_ipv6_check(const struct sk_buff *skb)
 	return 0;
 }
 
+static int nf_ct_bridge_pre_inner(struct sk_buff *skb, __be16 *proto, u32 *len)
+{
+	switch (*proto) {
+	case htons(ETH_P_PPP_SES): {
+		struct ppp_hdr {
+			struct pppoe_hdr hdr;
+			__be16 proto;
+		} *ph;
+
+		if (!pskb_may_pull(skb, PPPOE_SES_HLEN))
+			return -1;
+		ph = (struct ppp_hdr *)(skb->data);
+		switch (ph->proto) {
+		case htons(PPP_IP):
+			*proto = htons(ETH_P_IP);
+			*len = ntohs(ph->hdr.length) - 2;
+			skb_set_network_header(skb, PPPOE_SES_HLEN);
+			return PPPOE_SES_HLEN;
+		case htons(PPP_IPV6):
+			*proto = htons(ETH_P_IPV6);
+			*len = ntohs(ph->hdr.length) - 2;
+			skb_set_network_header(skb, PPPOE_SES_HLEN);
+			return PPPOE_SES_HLEN;
+		}
+		break;
+	}
+	case htons(ETH_P_8021Q): {
+		struct vlan_hdr *vhdr;
+
+		if (!pskb_may_pull(skb, VLAN_HLEN))
+			return -1;
+		vhdr = (struct vlan_hdr *)(skb->data);
+		*proto = vhdr->h_vlan_encapsulated_proto;
+		skb_set_network_header(skb, VLAN_HLEN);
+		return VLAN_HLEN;
+	}
+	}
+	return 0;
+}
+
 static unsigned int nf_ct_bridge_pre(void *priv, struct sk_buff *skb,
 				     const struct nf_hook_state *state)
 {
 	struct nf_hook_state bridge_state = *state;
+	int ret = NF_ACCEPT, offset = 0;
 	enum ip_conntrack_info ctinfo;
+	u32 len, pppoe_len = 0;
 	struct nf_conn *ct;
-	u32 len;
-	int ret;
+	__be16 proto;
 
 	ct = nf_ct_get(skb, &ctinfo);
 	if ((ct && !nf_ct_is_template(ct)) ||
 	    ctinfo == IP_CT_UNTRACKED)
 		return NF_ACCEPT;
 
-	switch (skb->protocol) {
-	case htons(ETH_P_IP):
-		if (!pskb_may_pull(skb, sizeof(struct iphdr)))
+	proto = skb->protocol;
+
+	if (ct && nf_ct_zone_id(nf_ct_zone(ct), CTINFO2DIR(ctinfo)) !=
+			NF_CT_DEFAULT_ZONE_ID) {
+		offset = nf_ct_bridge_pre_inner(skb, &proto, &pppoe_len);
+		if (offset < 0)
 			return NF_ACCEPT;
+	}
+
+	switch (proto) {
+	case htons(ETH_P_IP):
+		if (!pskb_may_pull(skb, offset + sizeof(struct iphdr)))
+			goto do_not_track;
 
 		len = skb_ip_totlen(skb);
-		if (pskb_trim_rcsum(skb, len))
-			return NF_ACCEPT;
+		if (pppoe_len && pppoe_len != len)
+			goto do_not_track;
+		if (pskb_trim_rcsum(skb, offset + len))
+			goto do_not_track;
 
 		if (nf_ct_br_ip_check(skb))
-			return NF_ACCEPT;
+			goto do_not_track;
 
 		bridge_state.pf = NFPROTO_IPV4;
 		ret = nf_ct_br_defrag4(skb, &bridge_state);
 		break;
 	case htons(ETH_P_IPV6):
-		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
-			return NF_ACCEPT;
+		if (!pskb_may_pull(skb, offset + sizeof(struct ipv6hdr)))
+			goto do_not_track;
 
 		len = sizeof(struct ipv6hdr) + ntohs(ipv6_hdr(skb)->payload_len);
-		if (pskb_trim_rcsum(skb, len))
-			return NF_ACCEPT;
+		if (pppoe_len && pppoe_len != len)
+			goto do_not_track;
+		if (pskb_trim_rcsum(skb, offset + len))
+			goto do_not_track;
 
 		if (nf_ct_br_ipv6_check(skb))
-			return NF_ACCEPT;
+			goto do_not_track;
 
 		bridge_state.pf = NFPROTO_IPV6;
 		ret = nf_ct_br_defrag6(skb, &bridge_state);
 		break;
 	default:
 		nf_ct_set(skb, NULL, IP_CT_UNTRACKED);
-		return NF_ACCEPT;
+		goto do_not_track;
 	}
 
-	if (ret != NF_ACCEPT)
-		return ret;
+	if (ret == NF_ACCEPT)
+		ret = nf_conntrack_in(skb, &bridge_state);
+
+do_not_track:
+	if (offset && ret == NF_ACCEPT)
+		skb_reset_network_header(skb);
 
-	return nf_conntrack_in(skb, &bridge_state);
+	return ret;
 }
 
 static unsigned int nf_ct_bridge_in(void *priv, struct sk_buff *skb,
-- 
2.50.0

