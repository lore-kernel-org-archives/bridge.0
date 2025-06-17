Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0B828C016
	for <bridge@lists.linux.dev>; Tue, 17 Jun 2025 06:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750143536; cv=none; b=o/WNpRLKrvnEN5Rnpmf4UhJT08ctvOO5NCWWcJEOW55IPrVku+CD2o72H8umeAren51D6i/BlxE/zRLdtaCr9QUBH8FKzAQGgdfZTJABxetHzCCuIQpi2g15Z7vHjVZTXO79xC9VtYBHLvnfM3vcOapJRSnwGT45Gc/JHKTRH+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750143536; c=relaxed/simple;
	bh=RWmkJ/7u5G1HzllFN3491RhnCUCphXkvPgUlTLkcvKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sbszwugZcdeNID+AH8Uth0EcFhGO4KHti7D8bM5NVYfd+htB2LNqENI4HS+c5XOD61lJ/Rw7ZqNy8ndPxvcqSXAjGfsJTmkyoHd3n5hmsaElyafEPC5G78koxAjTw7hsbphWYqvjn6GfU4C/1NyfbKNlCAa1uUY4QpjPNgZHCoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6Kg0kUS; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6Kg0kUS"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6071ac9dc3eso9328933a12.1
        for <bridge@lists.linux.dev>; Mon, 16 Jun 2025 23:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750143533; x=1750748333; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sqk/3oU5AS/JSMdKQuGdEhrPxwTap+QDTjCKKWH0KEQ=;
        b=Z6Kg0kUSVrlMHVgXIvQMUCofOEcltQNM4Em9oG/WJu5H+kQyTt2T5oBKQJNkc+tNIV
         arv27WktZ5yk3GMVHvoT3Tf0kpt0GkDPp+PlJ8eo+gx24qi4QiNZOblLWROPQ0pMyCj/
         FydwIpV/Gc8G+MyN7dDbOkNe427uNGE+gFN6fzSEL1IiNA/m2D2rGq8nKxYLJY91FDUa
         M8pYI4CxQDaFivLNex12/Flg3eSq3EbezbGgz+00z/RbMnG9jbhycEpZqRj9ffAwL4eX
         n1kYikLRNJ0oochwCNbHJ9ny+AAZuCTPDAuRiQ8L/AWry22sqa1sCHz2xLS+XRxzHq7i
         /lkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750143533; x=1750748333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sqk/3oU5AS/JSMdKQuGdEhrPxwTap+QDTjCKKWH0KEQ=;
        b=Xb/U1KseIfOSHj/yrLSvocDbw4fxSqo8YWwSACfSTlWhcS1gb3cD54JxE9Cl+U/+hM
         Inluy/+sSI4ZlT3lT6lb/g8IrdCSsTwTu+FOzvD6LhGswgpvcAXDXrPAuAL79YoY/lgJ
         MZo5PqCiaZ+BBJAlDOLNE7eLjCe5a1ViUZFzm15YaYAEs6zn+1Aw2q+eCedntkF27FFu
         mGl8F5UmaAB+YCjZABgxMfIYw8Ayrz+cNsh3enLh5exhtqNO8rvTcT9Nt55wUPEnH6TW
         WaaSgIsmjRaYDh2ah1rkfusUoFMa742zx/h5MNmYfTmQd0QzQurd+lNXAkNR36rnvc0A
         3eMg==
X-Forwarded-Encrypted: i=1; AJvYcCXsfjW5hNduSVbeALcUA6/kX99RXZxXbZ8B9/JsrY9/DynSlc91quHWCm8TnITY8LGjZROwvP4=@lists.linux.dev
X-Gm-Message-State: AOJu0YwYBIVvf/Y1TtU+B0R3T2uBksJcKHmLso7/ncSO+CFO6ujqLRXS
	JjZTZZFS9mnZoGm0An67Z32YjAFKeP1FKQPjcSTy8FhIKzjvjcEc7ymL
X-Gm-Gg: ASbGnctRYwgJl9abPytfc4uwUi46bx4qyYn85h4jucg8oCg5BdqTdH75qLO+AMHNGeL
	hL6SasFpVhDIZ9jzb6jKlPUfilYaSiNh31lHipyrBRWkXwAVFCyH3U1HUy8pnVV9CW15F/NTCu8
	GjM2k4BAqpm4bQbXNJLtY0LjDPqZ9by49lpsW81BlPEEDeozVKVMCWXDYrVKPEkwTQNJA4qKwCF
	vZU2HZcCupOdTvrrxbqLJ51AROmiawHbFAS6XqsOSLqBr8iFukhlrRnl9IoB+S+5ebKlOTyllnk
	0R0gNHxQfH8fvsqr3lVdiVVkFag3e2pct1uoRurTEQTO1oOPP/lIQWVu5FhWCccatEctO5fFVyy
	Oev5+IFYaio2UtVAaDFv7rEx9ISyNwj0D6J6AERIY4yFpKkW/L6th50BZP4iDMKlHs9JZadlt+0
	VNgSp75xlOnA5b4T8=
X-Google-Smtp-Source: AGHT+IHVq3Jr4g6X4B6ydhVjvr05hSehOxXcoQyHnaOYsqdPbHyQel1QYjNRYThbcmfP5Zxv+EAmbQ==
X-Received: by 2002:a17:907:94c8:b0:ade:32fa:7394 with SMTP id a640c23a62f3a-adfad416c29mr1138271166b.35.1750143532908;
        Mon, 16 Jun 2025 23:58:52 -0700 (PDT)
Received: from localhost.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec81be674sm811109566b.53.2025.06.16.23.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 23:58:52 -0700 (PDT)
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
Subject: [PATCH v12 nf-next 2/2] netfilter: nft_chain_filter: Add bridge double vlan and pppoe
Date: Tue, 17 Jun 2025 08:58:35 +0200
Message-ID: <20250617065835.23428-3-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250617065835.23428-1-ericwouds@gmail.com>
References: <20250617065835.23428-1-ericwouds@gmail.com>
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
 net/netfilter/nft_chain_filter.c | 55 +++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
index 19a553550c76..b9ab1916be94 100644
--- a/net/netfilter/nft_chain_filter.c
+++ b/net/netfilter/nft_chain_filter.c
@@ -232,11 +232,57 @@ nft_do_chain_bridge(void *priv,
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
+		__skb_pull(skb, offset);
+		skb_reset_network_header(skb);
+		switch (ph->proto) {
+		case htons(PPP_IP):
+			proto = htons(ETH_P_IP);
+			break;
+		case htons(PPP_IPV6):
+			proto = htons(ETH_P_IPV6);
+			break;
+		}
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
+		__skb_pull(skb, offset);
+		skb_reset_network_header(skb);
+		proto = vhdr->h_vlan_encapsulated_proto;
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
@@ -248,7 +294,14 @@ nft_do_chain_bridge(void *priv,
 		break;
 	}
 
-	return nft_do_chain(&pkt, priv);
+	ret = nft_do_chain(&pkt, priv);
+
+	if (offset) {
+		__skb_push(skb, offset);
+		skb_reset_network_header(skb);
+		skb->protocol = outer_proto;
+	}
+	return ret;
 }
 
 static const struct nft_chain_type nft_chain_filter_bridge = {
-- 
2.47.1

