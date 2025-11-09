Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9FE2405E1
	for <bridge@lists.linux.dev>; Sun,  9 Nov 2025 19:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762716288; cv=none; b=pQUbUDbYJ2X9T9za41fwfwIs1+qkMlBPtAC81aMjLULuckSWIcrZoTKSpsWZByX10eOFczFPUdIxtKJBNQ9C2skGV6CkweddV5JWcIRoD4c7+GthpNhHb8YXUzxK9a60jQ/4eIIO18iqKssdISjATr3k1C4x1TADG9rHlh5sugY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762716288; c=relaxed/simple;
	bh=v+zTe+MP6vCuWVHy2+Z9n7YG0MTNenETyXa1YKFDJ4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pArWABeC6nc6H4EuUWaSNXX5vkNaNJj1CYtOSOPwdylIjh0RIGLMlyib4jjsEdbgVf1lnYTlEif1Nwc3c3dEkFF6PA1I58Ou1X3KTHDEYBCusja1OBtIkgBn+FhGIzQD8yLEZrpgyyceR7qWmgcNN/pg57iXKFqJB8vqTHnHzMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DI4p0lfT; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DI4p0lfT"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b714b1290aeso377369666b.2
        for <bridge@lists.linux.dev>; Sun, 09 Nov 2025 11:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762716284; x=1763321084; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuPeXO/I6x2sQUdun0Lm+zZ+NKcixKEKCn6iCfIHfaw=;
        b=DI4p0lfTGkaf3ArYfAschLsCo+QlksgQ7oPHYGVxmpWdLDb05YuwA4j0ZUXbnfH5eU
         1kDT5mpENlGpwNowFjjt2wvTIR57LeIw2CwMYKPf0m5/yzmvlg6S3qYAYIGfY3VdlLBf
         ngtw8qujTafTNv77o+0R0tydX8wBHZ/X4yPRCVfJucI3BUbPnRBg4bnTBqTBvDEKm56S
         pHgYptYPvD5jVRfGQk+1H4TbGfGExFhqELDeXrW6tEDzQkSG6UdzpNlPWUEE2ZZ+ME2F
         5J/WgVoeDoT+iWtGupAAwuZ9kNgNggej512m+/mPaXyN24pJJggb18BwnwndRMCysc8f
         AM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762716284; x=1763321084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GuPeXO/I6x2sQUdun0Lm+zZ+NKcixKEKCn6iCfIHfaw=;
        b=XCP93BE3yZO01nBW/Qw5UNFpBNpDjO6d9goBwifauHGHLScMPNddU2njGW0ogxhHYq
         pHgrbWysgaq7sSBwnQwAOg55RwX4mnB3cwf7j4EC8YzKNOvDu+wXDPURmtvpCfIM+3SU
         8/fI6r3CPi5fYMl9TW09x2bjp4qUNbTXVYnvDGoTXPlOxT+KD2vYZytq2vsYbig5Q9cn
         WPePtJCgB0IkFQhOqfY8i22YQNH2xBh5jI2Hm40fhy6iOnweFrJ2EdJm8D55mL5+rPOD
         V4v+PqmLPmpDLdLH9GTtpotRrEFJoMIWkUZJkRSPamIZ6rYer07JE4TR6mKnSnAGd+Ud
         q1cw==
X-Forwarded-Encrypted: i=1; AJvYcCUQkoQwMifSazvpBOuXE2mQ3ZqlElpl+UqbDuztJMrVq7XtmhTxE4yzDOZgf+WvUMYk/lzuxrs=@lists.linux.dev
X-Gm-Message-State: AOJu0YxY8hCo2S0HwzMiAIlaA2L9v4yD5BXUiR8C0xJUISV/fzTlXQmI
	CMDP4nHrys9iWWTHrnz0qrme2azL2PLctSXuylgPDDEwrGvkEXG3gkeU
X-Gm-Gg: ASbGncskCyGTRROV5/XHEGx3WlDqeMEAjl9oilFUxR3YnDp4VmBvE5TNaMvYut3ZtBj
	D0iXbjYuox6PJkrtVNqT3ePlk5gMzxAOfokQ5lWkcpC5BCENZbcJv+mZEBT92UCY64ZtpHdAIrk
	jl1JAMhZ20MSWHoTohfkm+XiYiUfkVHA2XeQWAnTUXdd7WUMUPeiw/CMlC0sXZN5tYRhDPx/Vgh
	A9z1iZtRCve0Ob7xB4wywt4qOE0RSQ3mSr2iZv4ZgsOL4PjDU0EKFJVm0Ha8G+sRbrXk3xawr0M
	k3391Siv3CEP0kwG/uPnpWVwnAExLfH7AgCH90s4SDYfVnw6A0KegyntWYmEHChaGrwi95uQKyv
	vr56akN2MJnnYHqKpGmtt9lqV32eqVwkSGggwxmV6ds/ZFEmvXLixZYlyTSndpR0RFeNUA5xYpL
	oy3PCvl6CX9Oilv7l6pwjKI2cU+ElvqLkDucIKkpQ9pnNVuhdNf+DU0T4yVFEon6+ZxEFG4lQ=
X-Google-Smtp-Source: AGHT+IGCL2Kt4ppj1YcuzvJTTJ47QEP14ltpfJD8wWMeHcQcuNGQiREt9ai0ze6KeJi6tazq5FlfGg==
X-Received: by 2002:a17:906:4fce:b0:b32:2b60:f13 with SMTP id a640c23a62f3a-b72e05bc267mr609654866b.54.1762716284095;
        Sun, 09 Nov 2025 11:24:44 -0800 (PST)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97e447sm919652466b.42.2025.11.09.11.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 11:24:43 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
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
Subject: [PATCH v17 nf-next 3/4] netfilter: nft_set_pktinfo_ipv4/6_validate: Add nhoff argument
Date: Sun,  9 Nov 2025 20:24:26 +0100
Message-ID: <20251109192427.617142-4-ericwouds@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20251109192427.617142-1-ericwouds@gmail.com>
References: <20251109192427.617142-1-ericwouds@gmail.com>
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
index a0633eeaec97..e7810c542856 100644
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
 
 	pkt_len = ntohs(ip6h->payload_len);
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
2.50.0

