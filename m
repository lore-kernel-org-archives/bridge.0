Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C99243376
	for <bridge@lists.linux.dev>; Sun,  9 Nov 2025 19:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762716288; cv=none; b=RbPnN3MxqTMMRV2RkETH9WRFRPLODzH39wS/tqH07qFSwFy6zEDH3RImPxRZyCQkUzJiJ2LBnnvln+sg0WQp9ijwLTLo7nlc0p7JOjXIit+JQo68AMjH7M0j4mpVOOdP3f1+yBjH9m05rVIw8DaNDm+X6YU7l+fp6HTL4iwRJi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762716288; c=relaxed/simple;
	bh=fRAY5x0iiQZzMBRRTadDlTASkzjWZctbJeB0EhamTXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UKyNlq4zuw0CEZcVNc9s0H/PvkJlKAu8SgF/ITorQgZjkCnNhNeqhjn389xZlkc9GgUDvNQvSm7aTQ57TkiaBNZZPb9UyvPtMNEdUcnJJg9mGAJ/bauek+Gf3IQ3GOt1Jcf+Oo1Jhs/DskfpcWcTdsHtg2Ty2llTqMXWxRoigr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HP/39hTR; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HP/39hTR"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b6d402422c2so475729566b.2
        for <bridge@lists.linux.dev>; Sun, 09 Nov 2025 11:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762716285; x=1763321085; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0KTE+6UkuOljHxLPaa5JqpVN6oPc7OyA2U67mp05fg=;
        b=HP/39hTRe8o+L8NnXkB28cNkK6qIZzlVquGsfPM4qZyB81S7rEDiWGsfChxqqdQ1/2
         qsG+D88sdHXltiBfKyXjF1Mn12SLZQKk5XBC6gZh8fHWU3u/Vfk/Ca7EAQTK2y23wMhR
         fF84x42LpwYKXWvpuW3PHA/tzduUjlQ+eOCJntMfDWalmXpl+SLkh/wmvjf3xxvzj5Bw
         IWynlacgYW0IwKzeNMDc+UlT0uyViJfEc9seNmWjJjBQOgMGMGdyhz84AuQBCAAmR0VM
         SXy9OycPVxFAFLsl2eOKOvmwEsW4ZlqSqgPJvAwuO/g96S8WzrOPMRAodqCva+UfGkLh
         /ohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762716285; x=1763321085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O0KTE+6UkuOljHxLPaa5JqpVN6oPc7OyA2U67mp05fg=;
        b=WcX1dfMgc+4iWuObstC/iITMCyDdinm3vjz67gSTdqmfOcmhEhs9I5DxS85kwR/3wq
         Z7CqfeHijmlnTPu7/g36zXt2ZM4BTlhIulLo/S0804X8Z+InVGDDH6NU87EMcpeHIEtD
         2bQckOZea5PBt+offH6EkZMU3Aqj7r/z5gQ3yQ+M9vJKARjKoEuoZAEsVGmTaCGYhENl
         yEA7S6OW+1VMsM3yjFglhRsffmNbqDtkRb/z9QoaEOCdmpDZgWVgZPjOUsqgTHkPij5s
         1kFFCALROiEHGDRkbXh/WVj9vtub3yU6pqw/ih8e/G4CJpq8TOubcfOxyDRfaO/OrKHk
         lcYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVIDx/ZnmLLAfL4HTsog9ABDSuiMnswqWnGUGs04hVd4cyr3wpMp185fBKB8yNEBwkMUbUFjQ=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1qI0SrDLqb9MeEjdRQJZK6NJ3+fgDyj4F/AI1e1F4JQOBHiac
	WIhbgB1NlOa2ObKvtfYXYWYRlslEozD9CTtx8zJ9BNKK47QXS7r7ZKuR
X-Gm-Gg: ASbGncvrovJluFV0RouocO1UMLNj68qb1nzG/JRhpLzpPSwhvGLFCmKhDQ0dgjBYmih
	r573nk25nOGqeiyaZKU15R3TwA9U3HpDUNJevjKWA24QaGWbBCUY0L1B5naNHo/MglDcOg8roRz
	YD/+ejNsv7qSuLrVqZ65L3SipmQyGdevD82TZiz6EdpOMiQE5E+6l5G3qWGyDVuF8KniBlJKZd9
	7wbne/s9UujZlMB/TB5hZB8of3LoBcO0vwJ3BugMeNyhrp/Q88K2YXIJtPN7EGxowOESso2nQBT
	7fKTa0LNydp/s9S1Pllri8ieI9KV37w66K2QtK5yrN98liYNpTurBz23x6lLDMI7ycJ28ah9Ex8
	CLg36LnpoF/U9PnlAo2rvfWl/xbJ0SsH7YrUudERV0geLKbm3rCriTKoD0TtVlVWOwb7lPC5ug9
	VRWW54jrCIiT9a+dNYdPwIKdZIHPkCnXg9W4Pm6ozz0n5Unl1QQM0f9aHmjkDaYblvZDz2Y1k4z
	BJlAOumIA==
X-Google-Smtp-Source: AGHT+IHbYcQWGeRNfv+qzW3Tth8V6nuyKNbZz2fBbPX/OXmNJmzUeDKE8mETFfHc/vJK3DShLlkrpg==
X-Received: by 2002:a17:907:869f:b0:b6d:5a24:f124 with SMTP id a640c23a62f3a-b72e03035d6mr502044166b.22.1762716285087;
        Sun, 09 Nov 2025 11:24:45 -0800 (PST)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97e447sm919652466b.42.2025.11.09.11.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 11:24:44 -0800 (PST)
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
Subject: [PATCH v17 nf-next 4/4] netfilter: nft_chain_filter: Add bridge double vlan and pppoe
Date: Sun,  9 Nov 2025 20:24:27 +0100
Message-ID: <20251109192427.617142-5-ericwouds@gmail.com>
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
index d4d5eadaba9c..082b10e9e853 100644
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
+		} *ph;
+
+		if (!pskb_may_pull(skb, PPPOE_SES_HLEN)) {
+			*proto = 0;
+			return -1;
+		}
+		ph = (struct ppp_hdr *)(skb->data);
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
+		struct vlan_hdr *vhdr;
+
+		if (!pskb_may_pull(skb, VLAN_HLEN)) {
+			*proto = 0;
+			return -1;
+		}
+		vhdr = (struct vlan_hdr *)(skb->data);
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
2.50.0

