Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54F235BDC7
	for <bridge@lists.linux.dev>; Sun, 22 Feb 2026 19:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771790348; cv=none; b=l3iAOgMh33WRcfsji1xBxZ29cKcbQRN60BTmRBeXigSeuTngluTxJWUoEVa3+rDEg6CRrumHUCSH9TRSrYFNSWh5iOc1EziDjjYyG4gECksna+SScfvL09J34qatUH/Z90/jDZUgvKT8cxljqsVPovlBNuDj/BEJ3kdlWVuVLBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771790348; c=relaxed/simple;
	bh=cZOvplO+acrDIC/bdnPngpv5Yz9c1Kq3wtTg6un4bYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SS8oIo77vOAGMKBsxzyuMcX/BhzflILJD4Yt4JFOtEj8ZFZ9pI/WAs72TLFkZsfUnnSU2/HSjAhE/hnkUs5WU+KkwcIV7Px6FZlJ23nFeSP23SAj7uDIuPopyTJKoX0VlA3d+3b/aJd8lm17Kz/oEUX/ziOx9Vbs5zJXk1xcAzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBjvR0pF; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBjvR0pF"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b8876d1a39bso504852966b.1
        for <bridge@lists.linux.dev>; Sun, 22 Feb 2026 11:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771790345; x=1772395145; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAePdTgx4rGcv9Ww6vpjOV8zuSULm275AmiWMO10ySE=;
        b=IBjvR0pF22OcyICzYjKJ2/WY0LSOm9KEtNct8IRheTvOSU/cwnd8vP3mU3G+XIixtp
         Y1E9BWmgDQyJBwi2ILocAuUDw1WhTxO1g22gElIhFiIWqYHt45stIcnA8c991N3xvkwe
         dOFso3MbbvwkX/0baStFiQH1yMYdS6NE6wo+RrY/EW/X76pVMvT6OYZlRqH7UTTtxzRR
         oqll3pnPLfSmUtk8XlZSW9GF1t9IZb3hPGCJ3tbsEaaDcXEsoLMlIQyskeMR28oMv6Rr
         H7KbvmvopU8jifXNu9sRDPBi0NKvbRVg0A0JxdQgISGA+KP3KkHhO8GUadPydcOnNZJM
         MQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771790345; x=1772395145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gAePdTgx4rGcv9Ww6vpjOV8zuSULm275AmiWMO10ySE=;
        b=VwSImz7EXRFrUU3K4//7NVSLQokM6De2in0vmfVlOfvqahHzUtBxA8q2PajLgRLpWO
         BTkRNZTYVUBs51BWFjQ0jy1rSZXNNEuHZp9PHjtT4ueKZDApXD/iWsWbnEiapYbEn14d
         7Q1n4aSoT5XnrlsP2SPKEaAu8CdBj+Xlkn9vbbUDBAvgCAPfbpj8nG4yg/uI/1H8Sqk3
         Bc9pnahxD412CFT4EN+VZaucpllpv8KsTxuSMENnqEvTxXIdeNsgBudHCFNLZhzOgTFX
         3VfdNC0QXJJI85ORpujL+ykwKsgFC9yMIWdYbe+NDfjGpn1mu8aTuyiojMk/PM25RnOZ
         fgZA==
X-Forwarded-Encrypted: i=1; AJvYcCVzMxObFRwHXnEeKrJsbC/PxcMg+H6iV9BedE4dJUR0nzaNY/vQXmS0v35GPluJSvGxS8rKVyI=@lists.linux.dev
X-Gm-Message-State: AOJu0YxxsSqSnIJmVccOLGKzVZR7O3L2cWF9h0/axZVYlrvjgmQf75R5
	tYodRBK68q06frPKvuJTTxUkZg1KNaNTVbqlLpYtrsD4v88Xwh+0JETq
X-Gm-Gg: AZuq6aKZE+z4buHoATNs7tMYOrozlKLnWL8o2HP6JnGutWxY2wIjV4vrwt0k0+GuT8I
	f/+znoWObL6RJOceeaBU/IpO/HlKoC1C+X4TEuNHRqjHmrK4+LzvF/74OMQJhXe6rNdEE0is/2Q
	CpkGdTWI/Wj2wckWhZi5fh9oqtoDUJKxv+Akf8l7jPU/yl5RY9a0C7W7DdvR7J2AMDp9sGAC3h+
	3EtZAEKIWU/ojYMY0mQykXt+hAIMBebuy2nrR1jj6ukDTPwWEt4bCNdiQ4fMuZ+ON8A5N3oFox3
	YsGiPt/qFzns9AvA3o6CqXVUS5eADJuUwbaMdLUNVXIWIgGO3Wfgku1uXnCqAFRavJxZRK3ddtB
	hvQWDtxFy+Jh0bd7psk/l0ICVNMZT0e/GM3+iNxRUTR0p6dYlhj2WRHF5ravDi5+Cg1qHgSSP1c
	elfqvRjxBirNHGRAXIUljkSRMscoqA8skMULUaTsNfGrXQJGDZL6MHyz9k3pFARQm6ueY7DrshU
	CSdWlg6qBejNWbJWVtHn6LISUXszLz60kMiw9qC4vrQkoGwmEt93c8=
X-Received: by 2002:a17:907:e110:b0:b87:17df:4d65 with SMTP id a640c23a62f3a-b9081b4d8b5mr301491366b.51.1771790345213;
        Sun, 22 Feb 2026 11:59:05 -0800 (PST)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084c5c514sm246125466b.5.2026.02.22.11.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 11:59:04 -0800 (PST)
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
Subject: [PATCH v18 nf-next 3/4] netfilter: nft_set_pktinfo_ipv4/6_validate: Add nhoff argument
Date: Sun, 22 Feb 2026 20:58:42 +0100
Message-ID: <20260222195845.77880-4-ericwouds@gmail.com>
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

Add specifying an offset when calling nft_set_pktinfo_ipv4/6_validate()
for cases where the ip(v6) header is not located at skb_network_header().

When an offset is specified other then zero, do not set pkt->tprot and
the corresponding pkt->flags to not change rule processing. It does make
the offsets in pktinfo available for code that is not checking pkt->flags
to use the offsets, like nft_flow_offload_eval().

Existing behaviour for a rule like "tcp dport 22 accept" is not changed
when, for instance, a PPPoE packet is being matched inside a bridge.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 include/net/netfilter/nf_tables_ipv4.h | 21 +++++++++++++--------
 include/net/netfilter/nf_tables_ipv6.h | 21 +++++++++++++--------
 net/netfilter/nft_chain_filter.c       |  8 ++++----
 3 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/include/net/netfilter/nf_tables_ipv4.h b/include/net/netfilter/nf_tables_ipv4.h
index fcf967286e37..bd354937134f 100644
--- a/include/net/netfilter/nf_tables_ipv4.h
+++ b/include/net/netfilter/nf_tables_ipv4.h
@@ -16,12 +16,12 @@ static inline void nft_set_pktinfo_ipv4(struct nft_pktinfo *pkt)
 	pkt->fragoff = ntohs(ip->frag_off) & IP_OFFSET;
 }
 
-static inline int __nft_set_pktinfo_ipv4_validate(struct nft_pktinfo *pkt)
+static inline int __nft_set_pktinfo_ipv4_validate(struct nft_pktinfo *pkt, u32 nhoff)
 {
 	struct iphdr *iph, _iph;
 	u32 len, thoff, skb_len;
 
-	iph = skb_header_pointer(pkt->skb, skb_network_offset(pkt->skb),
+	iph = skb_header_pointer(pkt->skb, skb_network_offset(pkt->skb) + nhoff,
 				 sizeof(*iph), &_iph);
 	if (!iph)
 		return -1;
@@ -31,7 +31,7 @@ static inline int __nft_set_pktinfo_ipv4_validate(struct nft_pktinfo *pkt)
 
 	len = iph_totlen(pkt->skb, iph);
 	thoff = iph->ihl * 4;
-	skb_len = pkt->skb->len - skb_network_offset(pkt->skb);
+	skb_len = pkt->skb->len - skb_network_offset(pkt->skb) - nhoff;
 
 	if (skb_len < len)
 		return -1;
@@ -40,17 +40,22 @@ static inline int __nft_set_pktinfo_ipv4_validate(struct nft_pktinfo *pkt)
 	else if (thoff < sizeof(*iph))
 		return -1;
 
-	pkt->flags = NFT_PKTINFO_L4PROTO;
-	pkt->tprot = iph->protocol;
-	pkt->thoff = skb_network_offset(pkt->skb) + thoff;
+	if (!nhoff) {
+		pkt->flags = NFT_PKTINFO_L4PROTO;
+		pkt->tprot = iph->protocol;
+	} else {
+		pkt->flags = 0;
+		pkt->tprot = 0;
+	}
+	pkt->thoff = skb_network_offset(pkt->skb) + nhoff + thoff;
 	pkt->fragoff = ntohs(iph->frag_off) & IP_OFFSET;
 
 	return 0;
 }
 
-static inline void nft_set_pktinfo_ipv4_validate(struct nft_pktinfo *pkt)
+static inline void nft_set_pktinfo_ipv4_validate(struct nft_pktinfo *pkt, u32 nhoff)
 {
-	if (__nft_set_pktinfo_ipv4_validate(pkt) < 0)
+	if (__nft_set_pktinfo_ipv4_validate(pkt, nhoff) < 0)
 		nft_set_pktinfo_unspec(pkt);
 }
 
diff --git a/include/net/netfilter/nf_tables_ipv6.h b/include/net/netfilter/nf_tables_ipv6.h
index c53ac00bb974..1e84a891f268 100644
--- a/include/net/netfilter/nf_tables_ipv6.h
+++ b/include/net/netfilter/nf_tables_ipv6.h
@@ -24,17 +24,17 @@ static inline void nft_set_pktinfo_ipv6(struct nft_pktinfo *pkt)
 	pkt->fragoff = frag_off;
 }
 
-static inline int __nft_set_pktinfo_ipv6_validate(struct nft_pktinfo *pkt)
+static inline int __nft_set_pktinfo_ipv6_validate(struct nft_pktinfo *pkt, u32 nhoff)
 {
 #if IS_ENABLED(CONFIG_IPV6)
 	unsigned int flags = IP6_FH_F_AUTH;
 	struct ipv6hdr *ip6h, _ip6h;
-	unsigned int thoff = 0;
+	unsigned int thoff = nhoff;
 	unsigned short frag_off;
 	u32 pkt_len, skb_len;
 	int protohdr;
 
-	ip6h = skb_header_pointer(pkt->skb, skb_network_offset(pkt->skb),
+	ip6h = skb_header_pointer(pkt->skb, skb_network_offset(pkt->skb) + nhoff,
 				  sizeof(*ip6h), &_ip6h);
 	if (!ip6h)
 		return -1;
@@ -43,7 +43,7 @@ static inline int __nft_set_pktinfo_ipv6_validate(struct nft_pktinfo *pkt)
 		return -1;
 
 	pkt_len = ipv6_payload_len(pkt->skb, ip6h);
-	skb_len = pkt->skb->len - skb_network_offset(pkt->skb);
+	skb_len = pkt->skb->len - skb_network_offset(pkt->skb) - nhoff;
 	if (pkt_len + sizeof(*ip6h) > skb_len)
 		return -1;
 
@@ -51,8 +51,13 @@ static inline int __nft_set_pktinfo_ipv6_validate(struct nft_pktinfo *pkt)
 	if (protohdr < 0 || thoff > U16_MAX)
 		return -1;
 
-	pkt->flags = NFT_PKTINFO_L4PROTO;
-	pkt->tprot = protohdr;
+	if (!nhoff) {
+		pkt->flags = NFT_PKTINFO_L4PROTO;
+		pkt->tprot = protohdr;
+	} else {
+		pkt->flags = 0;
+		pkt->tprot = 0;
+	}
 	pkt->thoff = thoff;
 	pkt->fragoff = frag_off;
 
@@ -62,9 +67,9 @@ static inline int __nft_set_pktinfo_ipv6_validate(struct nft_pktinfo *pkt)
 #endif
 }
 
-static inline void nft_set_pktinfo_ipv6_validate(struct nft_pktinfo *pkt)
+static inline void nft_set_pktinfo_ipv6_validate(struct nft_pktinfo *pkt, u32 nhoff)
 {
-	if (__nft_set_pktinfo_ipv6_validate(pkt) < 0)
+	if (__nft_set_pktinfo_ipv6_validate(pkt, nhoff) < 0)
 		nft_set_pktinfo_unspec(pkt);
 }
 
diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
index b16185e9a6dd..d4d5eadaba9c 100644
--- a/net/netfilter/nft_chain_filter.c
+++ b/net/netfilter/nft_chain_filter.c
@@ -238,10 +238,10 @@ nft_do_chain_bridge(void *priv,
 
 	switch (eth_hdr(skb)->h_proto) {
 	case htons(ETH_P_IP):
-		nft_set_pktinfo_ipv4_validate(&pkt);
+		nft_set_pktinfo_ipv4_validate(&pkt, 0);
 		break;
 	case htons(ETH_P_IPV6):
-		nft_set_pktinfo_ipv6_validate(&pkt);
+		nft_set_pktinfo_ipv6_validate(&pkt, 0);
 		break;
 	default:
 		nft_set_pktinfo_unspec(&pkt);
@@ -293,10 +293,10 @@ static unsigned int nft_do_chain_netdev(void *priv, struct sk_buff *skb,
 
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
-		nft_set_pktinfo_ipv4_validate(&pkt);
+		nft_set_pktinfo_ipv4_validate(&pkt, 0);
 		break;
 	case htons(ETH_P_IPV6):
-		nft_set_pktinfo_ipv6_validate(&pkt);
+		nft_set_pktinfo_ipv6_validate(&pkt, 0);
 		break;
 	default:
 		nft_set_pktinfo_unspec(&pkt);
-- 
2.53.0

