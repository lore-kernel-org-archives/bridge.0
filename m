Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A01330B37
	for <bridge@lists.linux.dev>; Tue,  4 Nov 2025 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268300; cv=none; b=G6+K1r/P2c4laeMx2FP/gLrVI/uzbrc1cRw+hQbdzQQs5bKNf0lFzroGhcZ8deLqmqnJco92szghfDbSwez5NGRj7rMH6zQM9Ph+kWuPY7KDcQ2Sl9oGfdY3djZ/zL3bfJ5P6RMbS06ME/8iQcI8EL14YdKCIZ6YvwcSKPHQAvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268300; c=relaxed/simple;
	bh=Fy0W9gxzWa5phBf2U5OgVY5Lg4WAKVgwOkuBRbqjIao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tRcHe2DTYbV3zCm7lQZqB1yXsqCo9nHX5bv30qpiCYRDt5+LMwUtOxeu04LFCDbXJz60DIfCajA6kf5v5O1SIrfOwVn9I5FSt+5lHFiNGyziX4MxVw15hw2LBSH4ZXVA3tkeElyd3hOpJINCSosFjcHuN5GqugMI/VnKhoa3Bx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1Zma9P+; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1Zma9P+"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b6d3340dc2aso1349937066b.0
        for <bridge@lists.linux.dev>; Tue, 04 Nov 2025 06:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762268297; x=1762873097; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqNOLZew1B/4/qGT1ZskVp7oVfq0YezN6w+W/pCgZf4=;
        b=h1Zma9P+sr/ahKCAM7Hnu98LUJmyvjKBTr6cZ/AwNNsgQP0nmYPiBIlyI1gAPZMF/O
         +UXKE4dY1FNOMDJ6O35ZwUSLUbbt0/S/1L+uAdeX3Z8xlDeDQKQSvZJDp3F/N2KgO/7Z
         daKuj/tsw1aJ+FxFUW74pOUiKg9oTYnjNt6hTWabX26hzmX17T2UNZhgczvtQ12au5yo
         qqwcVCIUg8oercxO+Uii1wbnjuxYglRwxoLye5wfSHR3LlTQwsS/eBsxVKBqFtrEdSYO
         m8vDu1YqefoLXShG83KcJdryXr6y+J0q8g5TB918InmeSPgtLN4YfDzqdlxu/jAHccvG
         9oTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762268297; x=1762873097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqNOLZew1B/4/qGT1ZskVp7oVfq0YezN6w+W/pCgZf4=;
        b=eWC38p1YBSxqWSvbTmsr01b3lW243QPdWZEkkS9UshEkRFGx9Gt+jti+rycRE4YqPt
         oQeID+c9gCqzRgCxpAJaphfSOum4s0R1SBvJe86EZLI6SsJDudFAdk8G7mS72CP78Xxe
         7/TMYHggXNs5VkyJVib3s4LmW2wcCNnhyT+3eIVByjNZW6q/5gFc16+cxATov8YBA8ZC
         eAcinra7Bks45WSx5GXj0vg2r/yalr/LH3KSsdkPUtXob8k5P4KdB/MsTnSN6426ytAt
         xb50sbYd7Or0vMPTJxa/lnmLf5wHt3NpkbcSvpGG+1fni29wplZDOCEzb/tAsk5LCBfv
         T9hA==
X-Forwarded-Encrypted: i=1; AJvYcCWs+IIlcUjtSixLYylR0exL2PJK9frAoLY1uD8i1Ec3NIGSoHapGoUwfxrMtqcb2jn64FtSaFs=@lists.linux.dev
X-Gm-Message-State: AOJu0YweQ5Tp9fgXTrBmdVjKOFM7BNgwTcjyZ7iA83bW1T/er/7havJd
	6amNut1wlzuwBvK6w0RhIVJ2QEd/IbEQbKev88y6gYkWOzu7he0ZTaNf
X-Gm-Gg: ASbGncuR8NbgRzcIUh/UC5bxPldpbmep+lSLvfObjpvgWbm+sQKj2VZ0NpT8M0fB63o
	S4g/rMoa/yOXZOZ29BqpRn+bqnxpkwy6SsjyOMgxgSl8MyEAwuEiRU2fqo8t7KKtw+thXblaUmH
	FZhK4SaWzS462PSka9mjEOxoyss0j91qJR1rCTvdZ/v5rmIlS8DC4TLJ7fIE49WvgPH7r7uFXc5
	WZEmdjf91Ck5LR1/e5DJaaMOjFacT8XRDf0DhkpPW2TWNvFEX+VoQjZ19Szna4h7ySJRiYzjyBu
	L6RD9BekjDDrXD3cz+CWKPse/ds9+Z/7yfR+ow73uYWufEOvYIvC76gMezf/ivlNEg1YQH/Iv2k
	IGucq2pFQsBnY+FDX74Xce0OMmvFQiqI8Veo8EV3/2zg0EaH5c24fdWip63bQ/ak83qefuuEgBf
	T+a5eePO5wE/jdEQT92Iz/Jb9oBX9x0dnTDty/XgaL2PM2M1KKoMwlqCZw6Glov7SWxEN9o7M=
X-Google-Smtp-Source: AGHT+IFVxavNltv6OT0DR+ikoiqQd1j38ojj7cLxan/xShMoKGlMagjyohBNUH/d8xEtKzERUxNvHg==
X-Received: by 2002:a17:907:60c9:b0:b65:7f88:72d5 with SMTP id a640c23a62f3a-b7216e61f39mr377047266b.28.1762268296988;
        Tue, 04 Nov 2025 06:58:16 -0800 (PST)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723f6e2560sm232681666b.46.2025.11.04.06.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 06:58:16 -0800 (PST)
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
Subject: [PATCH v16 nf-next 3/3] netfilter: nft_chain_filter: Add bridge double vlan and pppoe
Date: Tue,  4 Nov 2025 15:57:28 +0100
Message-ID: <20251104145728.517197-4-ericwouds@gmail.com>
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
offsets, without setting pkt->tprot and the corresponding pkt->flags.

This will not change rule processing, but does make these offsets
available for code that is not checking pkt->flags to use the offsets,
like nft_flow_offload_eval().

Existing behaviour for a rule like "tcp dport 22 accept" is not changed
when, for instance, a PPPoE packet is being matched.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/nft_chain_filter.c | 58 ++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
index b16185e9a6dd..1f3ae5687917 100644
--- a/net/netfilter/nft_chain_filter.c
+++ b/net/netfilter/nft_chain_filter.c
@@ -227,16 +227,64 @@ static inline void nft_chain_filter_inet_fini(void) {}
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
+		if (!pskb_may_pull(skb, PPPOE_SES_HLEN))
+			return -1;
+		ph = (struct ppp_hdr *)(skb->data);
+		switch (ph->proto) {
+		case htons(PPP_IP):
+			*proto = htons(ETH_P_IP);
+			skb_set_network_header(skb, PPPOE_SES_HLEN);
+			return PPPOE_SES_HLEN;
+		case htons(PPP_IPV6):
+			*proto = htons(ETH_P_IPV6);
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
 
-	switch (eth_hdr(skb)->h_proto) {
+	offset = nft_set_bridge_pktinfo(&pkt, skb, state, &proto);
+	if (offset < 0)
+		return NF_ACCEPT;
+
+	switch (proto) {
 	case htons(ETH_P_IP):
 		nft_set_pktinfo_ipv4_validate(&pkt);
 		break;
@@ -248,6 +296,12 @@ nft_do_chain_bridge(void *priv,
 		break;
 	}
 
+	if (offset) {
+		skb_reset_network_header(skb);
+		pkt.flags = 0;
+		pkt.tprot = 0;
+	}
+
 	return nft_do_chain(&pkt, priv);
 }
 
-- 
2.50.0

