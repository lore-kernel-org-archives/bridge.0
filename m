Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5EF220F36
	for <bridge@lists.linux.dev>; Fri,  4 Jul 2025 19:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751656334; cv=none; b=OTfc/l3IugU/A/KDQ3kJmmDQjWy6P3R3gbCDeRbjJ5yNG5Em1RnJ3sWS6aNfpwQamKaTLiBRl1QSu39PkPFCqDXIZwsdhPt7ZHM3YhB0WxfjmIVKt6Odyt1cXSBcves012RHpYr7FKxEGQi1LMGlcCHB+o4xdrpIB1ABJgqtmrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751656334; c=relaxed/simple;
	bh=Q/lrdq2Uikvlke/32oZHP0bIjd+ePE8bpseap/4Mp0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qu+iZR2SX9NvraFMPrYBkWdmxdoxwUztNIAfw0zVK1ihtXMBOX8ofeIxwyWcF7cNxQq9AkyU1rkZlS3pGumwr632BWXnGOjCeM9OppibvH4fO8zurPl8R8UJp9onVe2nVhx6McVbml23GRaz4yCzgFM8uVhbq2QHQV7+JWvNyt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jx4Zs2q7; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jx4Zs2q7"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad56cbc7b07so209026966b.0
        for <bridge@lists.linux.dev>; Fri, 04 Jul 2025 12:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751656331; x=1752261131; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmZsUY7dpf8eao6+4v2lrJjyeF3MwXa41UKxk0tU7Co=;
        b=Jx4Zs2q7T68r/tA7aclYbXH7PxVtaz6+YU71laFq5rCLmnkcZuhUFCtfZJl60++1TP
         71s00SfMXyJ5XRnhURqM0CQbmVNmHq74qKaBT3gsGBrEHkxL8yR8S8odKHXb4DBBJAWF
         fLhJouF/e3nQWowPTbG5e1zs1GdtOCPlNiNC9jsLB8z7tNanxFSSLnRX5uDPmBwWLtmj
         rNYWTBpJmuyR4veeE3uLeos1fXaJUe6ooW+zgpT89RyNEhZUybnKQZfSX+scKoXx7ClH
         lRIxOCU9VlgBoY8p4sooZQi7ysSKRIzGWk9o1jrKtBXmV1PBc4AFrXgtrL8DEIgk9RrI
         Uwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751656331; x=1752261131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OmZsUY7dpf8eao6+4v2lrJjyeF3MwXa41UKxk0tU7Co=;
        b=SsZPdrfWgkdnw9D2PtQGS8Jlu3XL70rvyVpU5TfLFXieOfpPT66YCAOJDGd+oqYYY5
         KOOra9x5BdiwbiYFTb002CSDHUEf4LtzcYHxCWrl2VJVG++VvUO/xQEcVGkuCetMU+zy
         Q636jk3hv+5o7/PZbr8cYL3Dez9Hf4Rr6BtGhKGlpAgzITb9ILKt7VsnbE+JjOT4V880
         mHYYsyd2FgVts7tAoHoszi0LvQ/KjNdUzzbk6k41P3sFEwPAsXbiz/q4Eq7gi20U7XY6
         X5xpmGmVDGDfb5Wnslntubk1IKHu3UIi3O9fi90EbWLltydezthX5MsMcTuEM2nVuOx3
         Knfw==
X-Forwarded-Encrypted: i=1; AJvYcCV25ebFHvKWB3a8KIHZ3920tTWV7AI8FkWHdPrIRF0tFa/9Geyxic7nYl8hc55dY4kJPTzV3PE=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxcz0mpRq9B8R7z1uyoy+VleuHHnJHz5bLUOStNKZmekiBHSKz/
	2x/l6cQHejgKJtQNlOw0xicLwRuaUhT3veNcB8iYq5mTfm1ZLWhtLjUmZ+pD6A==
X-Gm-Gg: ASbGncssU850T5wN1qI8mWNTmGG58NbYViUGTLCQhV4VPkBhezZlVhELw+18vUWsju3
	o3mGyvLg5y8sBK6sKwaH9MB716+O7trLL2+Zk1sfAcr5dEYZmDJuWG6ybZSxIMAIrC8SooDKhx1
	qiwzVMGDmZxeoY+yY2mHEhCPwIHZHcAlmy+6iCBew+jpoeeNAEfq9EL2eu1p1tu0fwUB3XQV4Ei
	dLYUtMQKkT/fLZoLvJa6YVi7+3JiuyJl9gpl2t3yOpmAA2QucEFf3RRN6vtaOM8k7B8iANXhBjn
	zFE/2urYvsY0VmYsIE34TOx4tfNfmVajJKWwb+j7Ml87BHAL2f/FjN8dhIN6tksp8vfxGv/b/FG
	//NBezCx8wCJjtvBqgODzSll7GRiiWtau8aNiFhd+bMJHCmTQKgTgsH4pCSAjDHlvd1jtGG8CrH
	KYSdiY
X-Google-Smtp-Source: AGHT+IEeXAJoE2Ma43SXkCEuo3RyDIgqb9kmpp3aaYZZQ/WrcATyFVvyLOOnKU6Am6D5hgzbpWQ0+g==
X-Received: by 2002:a17:907:9485:b0:ae0:ba0f:85af with SMTP id a640c23a62f3a-ae3fe800101mr359646266b.51.1751656331097;
        Fri, 04 Jul 2025 12:12:11 -0700 (PDT)
Received: from localhost.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6ac5fd7sm219476366b.103.2025.07.04.12.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 12:12:10 -0700 (PDT)
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
Subject: [PATCH v13 nf-next 3/3] netfilter: nft_chain_filter: Add bridge double vlan and pppoe
Date: Fri,  4 Jul 2025 21:11:35 +0200
Message-ID: <20250704191135.1815969-4-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250704191135.1815969-1-ericwouds@gmail.com>
References: <20250704191135.1815969-1-ericwouds@gmail.com>
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
 net/netfilter/nft_chain_filter.c | 52 +++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
index 19a553550c76..8445ddfb9cea 100644
--- a/net/netfilter/nft_chain_filter.c
+++ b/net/netfilter/nft_chain_filter.c
@@ -232,11 +232,55 @@ nft_do_chain_bridge(void *priv,
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
+		offset = PPPOE_SES_HLEN;
+		outer_proto = skb->protocol;
+		ph = (struct ppp_hdr *)(skb->data);
+		switch (ph->proto) {
+		case htons(PPP_IP):
+			proto = htons(ETH_P_IP);
+			break;
+		case htons(PPP_IPV6):
+			proto = htons(ETH_P_IPV6);
+			break;
+		}
+		skb_set_network_header(skb, offset);
+		skb->protocol = proto;
+		break;
+	}
+	case htons(ETH_P_8021Q): {
+		struct vlan_hdr *vhdr;
+
+		if (!pskb_may_pull(skb, VLAN_HLEN))
+			break;
+		offset = VLAN_HLEN;
+		outer_proto = skb->protocol;
+		vhdr = (struct vlan_hdr *)(skb->data);
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
@@ -248,7 +292,13 @@ nft_do_chain_bridge(void *priv,
 		break;
 	}
 
-	return nft_do_chain(&pkt, priv);
+	ret = nft_do_chain(&pkt, priv);
+
+	if (offset) {
+		skb_reset_network_header(skb);
+		skb->protocol = outer_proto;
+	}
+	return ret;
 }
 
 static const struct nft_chain_type nft_chain_filter_bridge = {
-- 
2.47.1

