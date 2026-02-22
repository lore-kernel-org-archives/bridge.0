Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E105935C1A6
	for <bridge@lists.linux.dev>; Sun, 22 Feb 2026 19:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771790349; cv=none; b=kKMeI4+2kAbykBlwOcgXEcKmyqVHdUviF+xQZ1wxBnfLZvlUv1uzGmd22UP6XpwNRMepF7swt54mrObwojJcnnvZnl2zQYaT8zxYyLF/nVY/q/s0TD//WfBCSNkXqwSQGMAy1vg83HaSeWpFcvuNil5PASxXHGQlm/xdHCJYowM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771790349; c=relaxed/simple;
	bh=otw/sidfsrVAXpxIAPSAHcc1JnUEwkQzo3iMewEEbLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNDt9d04pUP+nHiHBuWBaz3NpRH4voYuYSJytcyFt0qkp3djRWtaIwkn4ySq+4bq7SalvzhbTD3vFgdahFA1qlDWWlyud8k17ylS6YVwSaeE3KlD4s99tU/PhOqZm2UycLKepB+3URQLUlCQixz0WzgDLIoCp2qJX5gzkOIkyPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aL5LBatF; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aL5LBatF"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b8f8d80faebso664964466b.1
        for <bridge@lists.linux.dev>; Sun, 22 Feb 2026 11:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771790346; x=1772395146; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=coP60IDvUwENZ4G8REzPur6qzEmmqfojoUutShryN4c=;
        b=aL5LBatFFXNoUM/jC+ALv20KFQTqL7kDIEOZg4Fg5qqISzafoR/HA/9sCeMO7rU10y
         LuAg3A7MIMjqdU8upJD931y/Cj1jYSUwCiKizIjQVeO3e9oX/NdCrbcyQcHKuPWrCbGa
         NZLHvl5CCCKDdxNU27Dy+KiaVnFAoR/k0+lnAb2/73MowevOww5Len8k468k7YmiWrg9
         Upr1awjalA+1bxqpB7h3AI72yj6wXDgKbo3W2Ay21XvG//HoIUlvSQFyKelVbK6FsyWq
         wO+VCHjtI3ZoSqiO+JWO+Yxp/4P3DRHiNEXBmfT3ePX9s7YjW+9JQLlso8mVfFaSbI9N
         gk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771790346; x=1772395146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=coP60IDvUwENZ4G8REzPur6qzEmmqfojoUutShryN4c=;
        b=GuIgW/+YsKcErloxW7qwhqZtFGAZxyhdh/5UzW2YO7f32XhsoTayT9E4epPQKExLY5
         vu1tzKqEDfviCASptmFNdYIfLpHe7uXhdDNcIffUdsvvg7BiUnPU4WPzR7OG+jCU9i7F
         4o/McmW75qOEQNKJQVlwO6DCykVTjknGl37XEHzVCLj3pWF//zZa6B8x+x82tlyPuSz4
         afHm7MwO7JFJX5WYKyydDbMRfMcnX2jpVaDaG3aZvXfpOG/MNKCB+/wquoC8Sho2wCuh
         BTuP+E1tsyAbWVzFwRTFgSReGq7AiHg18FugQJLYloA18HNskObRUQZ7t4dmL1H0bJGm
         etCw==
X-Forwarded-Encrypted: i=1; AJvYcCWfVVrgXrSguOCeoU1fTxA1EIoovvk4v6I6umK8EuI/aM0QJAlUe3IjFrMaSbAb8NOX2fw/qY0=@lists.linux.dev
X-Gm-Message-State: AOJu0YwAKmThqiBkrQSpV4oLbI3NziYnTmE9MZD5HoOwl6qc2R4KKDQ4
	3Cf5M4JAR53zROM3KY4g4vKVhuXxqchF7VS50WWkUjXqnr3Sfy1WuNYO
X-Gm-Gg: AZuq6aKvEFiOixOaB1MiJNPPyvnobpa4KxudbkWl747dRjWbjnhh9ouw6NIGeI8QIK/
	byGiOhlW20wUkWujrxZk2fpo7cn5+3Z0jEFJXHmeZe+bkWVsliQIt+BHJRHrES7JpKCtltVUlLH
	MMWCvLSKLWuhk3bkLs4pvTBI7ovfkhfgImJk2/ZjR/xYNSoucKy3fVOlix4jg+mv0JDxYfdrusA
	EFJPdJj6g29sbpLFOOiOkiTDSJIAEKELPZnESQig8sU8tFeWgHV+Xz1uG6RFo2GBpRdlto7I/So
	hln4MBU404z55rvzLte5BvoieBDn/PD+mAB/L7my1yaEqQzZMmDB4XlBjn/z74MFN9KmtF9JjYM
	o+cIRs+C47Mnxq8cPQjkM8CtHBG7Ojc4bX6YimYlUA9WzhbtdPxsffuPwzJUxhaFuHi6E+uUWIU
	mMbTubC/F+upvhFyjaE0RmcWNQuKMyl6nl8ejyWLT4nCM8dqwj2PeFzpK3INT25MXzKZDsvNaVe
	ID/ZjnDI7aRL5zTaS912g5FFHWdKpPrkbwkEMN3LrYxvFyJjFJoYFxnohL1xfeKpA==
X-Received: by 2002:a17:907:988:b0:b88:1e2:ed49 with SMTP id a640c23a62f3a-b9080f13a76mr405909266b.8.1771790346139;
        Sun, 22 Feb 2026 11:59:06 -0800 (PST)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084c5c514sm246125466b.5.2026.02.22.11.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 11:59:05 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v18 nf-next 4/4] netfilter: nft_chain_filter: Add bridge double vlan and pppoe
Date: Sun, 22 Feb 2026 20:58:43 +0100
Message-ID: <20260222195845.77880-5-ericwouds@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260222195845.77880-1-ericwouds@gmail.com>
References: <20260222195845.77880-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In nft_do_chain_bridge() pktinfo is only fully populated for plain packets
and packets encapsulated in single 802.1q or 802.1ad.

When implementing the software bridge-fastpath and testing all possible
encapulations, there can be more encapsulations:

The packet could (also) be encapsulated in PPPoE, or the packet could be
encapsulated in an inner 802.1q, combined with an outer 802.1ad or 802.1q
encapsulation.

nft_flow_offload_eval() also examines the L4 header, with the L4 protocol
known from the conntrack-tuplehash. To access the header it uses
nft_thoff(), but for these packets it returns zero.

Introduce nft_set_bridge_pktinfo() to help populate pktinfo with the
offsets.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/nft_chain_filter.c | 55 +++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
index d4d5eadaba9c..66ef30c60e56 100644
--- a/net/netfilter/nft_chain_filter.c
+++ b/net/netfilter/nft_chain_filter.c
@@ -227,21 +227,68 @@ static inline void nft_chain_filter_inet_fini(void) {}
 #endif /* CONFIG_NF_TABLES_IPV6 */
 
 #if IS_ENABLED(CONFIG_NF_TABLES_BRIDGE)
+static int nft_set_bridge_pktinfo(struct nft_pktinfo *pkt, struct sk_buff *skb,
+				  const struct nf_hook_state *state,
+				  __be16 *proto)
+{
+	nft_set_pktinfo(pkt, skb, state);
+
+	switch (*proto) {
+	case htons(ETH_P_PPP_SES): {
+		struct ppp_hdr {
+			struct pppoe_hdr hdr;
+			__be16 proto;
+		} *ph, _ph;
+
+		ph = skb_header_pointer(skb, 0, sizeof(_ph), &_ph);
+		if (!ph) {
+			*proto = 0;
+			return -1;
+		}
+		switch (ph->proto) {
+		case htons(PPP_IP):
+			*proto = htons(ETH_P_IP);
+			return PPPOE_SES_HLEN;
+		case htons(PPP_IPV6):
+			*proto = htons(ETH_P_IPV6);
+			return PPPOE_SES_HLEN;
+		}
+		break;
+	}
+	case htons(ETH_P_8021Q): {
+		struct vlan_hdr *vhdr, _vhdr;
+
+		vhdr = skb_header_pointer(skb, 0, sizeof(_vhdr), &_vhdr);
+		if (!vhdr) {
+			*proto = 0;
+			return -1;
+		}
+		*proto = vhdr->h_vlan_encapsulated_proto;
+		return VLAN_HLEN;
+	}
+	}
+	return 0;
+}
+
 static unsigned int
 nft_do_chain_bridge(void *priv,
 		    struct sk_buff *skb,
 		    const struct nf_hook_state *state)
 {
 	struct nft_pktinfo pkt;
+	__be16 proto;
+	int offset;
 
-	nft_set_pktinfo(&pkt, skb, state);
+	proto = eth_hdr(skb)->h_proto;
+
+	offset = nft_set_bridge_pktinfo(&pkt, skb, state, &proto);
 
-	switch (eth_hdr(skb)->h_proto) {
+	switch (proto) {
 	case htons(ETH_P_IP):
-		nft_set_pktinfo_ipv4_validate(&pkt, 0);
+		nft_set_pktinfo_ipv4_validate(&pkt, offset);
 		break;
 	case htons(ETH_P_IPV6):
-		nft_set_pktinfo_ipv6_validate(&pkt, 0);
+		nft_set_pktinfo_ipv6_validate(&pkt, offset);
 		break;
 	default:
 		nft_set_pktinfo_unspec(&pkt);
-- 
2.53.0

