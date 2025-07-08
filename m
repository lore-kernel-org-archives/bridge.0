Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779D92E0938
	for <bridge@lists.linux.dev>; Tue,  8 Jul 2025 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987551; cv=none; b=SIYym2AUnCZzMfjnx2LsXdabiuAa6iM7rqd1uCl8KDla+Ng/aOvlg7caipPa+Ok8f+8D01hfIealNet7+7bFDLr0khFjOoJCATaLPaUGHi50lsTWmwIz3OKXQeBZnz/PeSHgSYPK8Q954GhIUb0vsdQQBiB8bRmgVFehkNtkgiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987551; c=relaxed/simple;
	bh=Tp1Bz8yUu3aS2rr8dOstQpb0hyvWmmXi1gc2V+SaRL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ATpRlgSD3lLJK3o+Byvmr/F1kDP4QY5fJekR1QnqAKXi2W46bKCXk1EPva3iLknPhs7lBhBEnBn0QJBhXYvMPBV9cWuYjAAVw36JGk/dPPWu76LmlP1WETDdj4G3DYfmzuxMycGp78t34tmpS70mpTENCbMQ+VXvOSPEYrssUJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExAYxgqF; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExAYxgqF"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae3a604b43bso698189166b.0
        for <bridge@lists.linux.dev>; Tue, 08 Jul 2025 08:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751987548; x=1752592348; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YAUBR/u+RT3eCuaRQRZ/Ht0agoAR4js0pHVirBrIafo=;
        b=ExAYxgqFkVzu+ZSYd4Zs2LC4YYHXa+N4jN+N384Ju//X5SeQQj8wug0HiRGv0vVVFL
         pGkV6DNCTNQS9EPuAcoa5Yko6OyumbT0De9eKaudYqeDzEghaUyJVi5LSdmPhkd/XXPx
         OQ+ZB9AlFvOiyOF/1abTtnPBIPUBnGlBq1GP6lA3saUrcXQm3Dj4MZQ/WHtbKrxdL5GA
         mZ9WDfNsevq2JqtPA7AZ3P+ACGMv9jKE0didxzoluUkzKLFt0k0217LVgHhPILyk/OnI
         XGOmdh1+SywK2fzULJGZ8Ty/nzQcE2x6gVzf61g1X18gQaXvjUQ6UcctqmrQDeC8W1dp
         5D7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751987548; x=1752592348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YAUBR/u+RT3eCuaRQRZ/Ht0agoAR4js0pHVirBrIafo=;
        b=m+ynzRYYQvr4V5oRgEktAshDTwHTr86hFydhLuUMlcU7FPH0gdToORSWZVhiCF8/AB
         G/g2xb+w9N8lASaP1fhHj9VE7R4Pkdekx1vQd1R95UNR/JU0pjSvBfl3P8gtmRtG7NcC
         c3O94bJL2fWc6SD0HPW25/fQSMiaujdW2twbPQvjnvpbabnR3xkvFaMe9GBAwuHZfze7
         AJyrT9f0GRzr32i3kyIsnquhOGEsxHt85+MiUjz1nYTyCJop60y1KAw0hKrQxDE41QbF
         sqtnzCaG0gpsm1FBED81sPhbYt30gKgRoSMAywMINSiyovFVB2heUkdmtAZG5FKwTZIy
         ikZA==
X-Forwarded-Encrypted: i=1; AJvYcCXKnCKreSQh7NZMkSmIIfi8xDKNm8HIgJPgq9v5fRLdC1eClH0KuqRkdRIb4x2eQJBvx9iauiM=@lists.linux.dev
X-Gm-Message-State: AOJu0YxOytNLYt9yTIqrQ3h30IG8xjIBjQcEPkPbOtfLLfCOP6M6aeOf
	znBZfNgJDndRnK2iZ1/sdsXtuN0/vMlbzjunQ6KNcc1TKcu3AE99e+jc
X-Gm-Gg: ASbGncuyyQXGYTiJSETow+3BlMV5zsrabHFW5FYK3/66WzkeGkefDBaYb/UDHqF684o
	wBV6cF9zXPtY29UQL5y95LnaBXsAFXrP+pudJEIFoO42/+F4A0/KOuydMX9WiCwuNu4j/f8sffU
	+noS8Nhw/4wv5m5mDdbPceJZmzVui6ENVPgZqPcUn5owb/+K1MXVw8YWqHpMC0rrqED9lJMS1sI
	9pm6y44ogeUSe9IhH1paXQ52pO1CT+JpJVLXhXk/GywbQOYsSfpwEuYfpWzxsQwMqnyyI0R3Cpg
	RE8Sju7PNLsjRO+fomc0Wh5DDsqjpQoJ38Y1UI89AKnO7uCJHQ/OjFIr2S+x1wmZCJEZM6DnMaK
	lnhyal4jpYR+m9LtNT64eBlIE+fWp5+U9WWSuCVjfhQwv4YJ2W/eiXvy+duPnbXs2zMC8Flj52S
	FxdTvb
X-Google-Smtp-Source: AGHT+IEv3oJ4Ui33L0KLof0NPPSG/UhfK4myNPOGcqm1VFqUfy96pX7vQ+1OxM6f0rlFUOuQBD3tVw==
X-Received: by 2002:a17:906:6206:b0:ae3:cf41:b93b with SMTP id a640c23a62f3a-ae3fbd50f83mr1632665766b.41.1751987547316;
        Tue, 08 Jul 2025 08:12:27 -0700 (PDT)
Received: from localhost.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b02a23sm907596766b.112.2025.07.08.08.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 08:12:27 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
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
Subject: [PATCH v14 nf-next 3/3] netfilter: nft_chain_filter: Add bridge double vlan and pppoe
Date: Tue,  8 Jul 2025 17:12:09 +0200
Message-ID: <20250708151209.2006140-4-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250708151209.2006140-1-ericwouds@gmail.com>
References: <20250708151209.2006140-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the capability to evaluate 802.1ad, QinQ, PPPoE and PPPoE-in-Q
packets in the bridge filter chain.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/nft_chain_filter.c | 59 +++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
index 846d48ba8965..1d09015a64d6 100644
--- a/net/netfilter/nft_chain_filter.c
+++ b/net/netfilter/nft_chain_filter.c
@@ -232,11 +232,62 @@ nft_do_chain_bridge(void *priv,
 		    struct sk_buff *skb,
 		    const struct nf_hook_state *state)
 {
+	__be16 outer_proto, proto = 0;
 	struct nft_pktinfo pkt;
+	int ret, offset = 0;
 
 	nft_set_pktinfo(&pkt, skb, state);
 
 	switch (eth_hdr(skb)->h_proto) {
+	case htons(ETH_P_PPP_SES): {
+		struct ppp_hdr {
+			struct pppoe_hdr hdr;
+			__be16 proto;
+		} *ph;
+
+		if (!pskb_may_pull(skb, PPPOE_SES_HLEN))
+			break;
+		ph = (struct ppp_hdr *)(skb->data);
+		switch (ph->proto) {
+		case htons(PPP_IP):
+			offset = PPPOE_SES_HLEN;
+			outer_proto = skb->protocol;
+			proto = htons(ETH_P_IP);
+			skb_set_network_header(skb, offset);
+			skb->protocol = proto;
+			break;
+		case htons(PPP_IPV6):
+			offset = PPPOE_SES_HLEN;
+			outer_proto = skb->protocol;
+			proto = htons(ETH_P_IPV6);
+			skb_set_network_header(skb, offset);
+			skb->protocol = proto;
+			break;
+		default:
+			proto = eth_hdr(skb)->h_proto;
+			break;
+		}
+		break;
+	}
+	case htons(ETH_P_8021Q): {
+		struct vlan_hdr *vhdr;
+
+		if (!pskb_may_pull(skb, VLAN_HLEN))
+			break;
+		vhdr = (struct vlan_hdr *)(skb->data);
+		offset = VLAN_HLEN;
+		outer_proto = skb->protocol;
+		proto = vhdr->h_vlan_encapsulated_proto;
+		skb_set_network_header(skb, offset);
+		skb->protocol = proto;
+		break;
+	}
+	default:
+		proto = eth_hdr(skb)->h_proto;
+		break;
+	}
+
+	switch (proto) {
 	case htons(ETH_P_IP):
 		nft_set_pktinfo_ipv4_validate(&pkt);
 		break;
@@ -248,7 +299,13 @@ nft_do_chain_bridge(void *priv,
 		break;
 	}
 
-	return nft_do_chain(&pkt, priv);
+	ret = nft_do_chain(&pkt, priv);
+
+	if (offset && ret == NF_ACCEPT) {
+		skb_reset_network_header(skb);
+		skb->protocol = outer_proto;
+	}
+	return ret;
 }
 
 static const struct nft_chain_type nft_chain_filter_bridge = {
-- 
2.47.1

