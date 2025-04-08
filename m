Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEBA219A90
	for <bridge@lists.linux.dev>; Tue,  8 Apr 2025 14:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744122399; cv=none; b=keAHzXKnNIKIhSh6yEM7/XSMkHSgvAUgINp0RfWz3C18wFDK4xcBKDqoSmQAgdIszcRzcjdGPOTpOhdBp5Zeg1gBgbtdThyWGpv1gxUYYgm6Nzttx6H+aB0OAmN7znXN7qvcv3iWdLb+ADI20+oHV7/opNq6zqZJFnqIctZRBOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744122399; c=relaxed/simple;
	bh=9Ed/mFFgQwIS+bKP/piGE8lQYd8/p2Gw39UsY7QGgYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pFgbpmZLITioNT+0A7ko5WIsoaR83NzJmW3pAFlPzm7njhBQjkI4Vz8ehWR5sGqjtj3HvsIVyHhCTsqEdNOUrPdryoFIIKQ+a6i2+hrTTp0vcBywTAs/1j/QLwc2Tp5lDkzEO/Dp8yYjROZfjBDjV7YVA7CNeHlCSXCi+13QGQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAJhOb20; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAJhOb20"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac289147833so941096966b.2
        for <bridge@lists.linux.dev>; Tue, 08 Apr 2025 07:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744122396; x=1744727196; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLc/IUi5wHGsbU8Rvwl+BFmfBN3QPI47jubpT8Zw/U0=;
        b=dAJhOb20nXFAsur1ud28FNKsQrLRqBW9cINvS0IbFO3f49/+LUJl+CokFAJOtrN4E5
         9JzX4YZzq7+riUojGJonhGuid9fmaqlr97OGt+SO+JfWnQqGYw+Mtt+rAVN/gJS63QXl
         Xj9unIIwM5jxaR+gDk1OfTDfOBkwbs5SdLgR8M8/6vswEMILJI0pzhHI1fAEf7LdOF/p
         FCHnJbbiv7lgtn5wwG6J4WqKFIMCTfJoGq3i9QcCdC9DuIKErZzk2FpNsFjMF/prtOXk
         xRjiuvq+7tlK/y+Za7aZJm8toVf8bCe4IWVNhjqZhDTb+e0BPcFfYnBf6IKs9d/vMK1E
         2oWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744122396; x=1744727196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLc/IUi5wHGsbU8Rvwl+BFmfBN3QPI47jubpT8Zw/U0=;
        b=ajTdImcLmwUaF6aYwFrA0P3JQmGenM6zNiMPNEpej6VzQ8c2i0ZEhkVXATLvjO5Gue
         YJyFAclV2EbxFyLo+kE0UvoGDSwEv3E3VbuxyZF20cHamSEq4q6LhIG8LCc2u0Z1rV+2
         kI+eoxVMBwUG+zYPpg5JbuYlDuVIsV1tSr/za/E21yao6nmMISZLpx8H06WyKeyIH10S
         RHevH41KedsPwqm4cxl2bkIsYrgWxR+Vyp8thP/bqFHYCph4xt0vj1o4+JY6ypzNE+Nl
         3CturoZVjfFOBx9u648nk8rNDp3J71YCefPKduQV11QkJ4ZXfECQOVgEeBcTUv1VBOGn
         S9dQ==
X-Forwarded-Encrypted: i=1; AJvYcCV38dHC95qpThzMYu0MWb4oO1ZqmhvBnOGixFq3pvKgI/iCiwyE4n4OGBANE61SmvNY7v1tbdw=@lists.linux.dev
X-Gm-Message-State: AOJu0YzJ3U5V5YRc4XA2vHqDTe+17eJJ7j4JdVPhvWXwf+6GAFA6EGYk
	jtxD6zDVaOtQvMfYEwGYbofKVHpUt5XyytWdRrkhi8wdAz8qN7y0
X-Gm-Gg: ASbGncs2G+NQaafbii4B36eUNb1zWi71HEoEtGsmEmp2bOzPt0fkRhPFx7A8Faq1FpL
	lDx/YQhXdK4bJ4ouEwBlWrGYYmMnMDGavITVv8WcdjkNp7RFcsn3V7rxxx09yU5W76WSSYhkqpy
	p53+J6xwlSMR9wXZ7PAsgvgz6QMQMd9l3UEDic6zp6e9wdRmZpdT1CjnEiaFR6ReyVumEkoDTtL
	GM84rNlv37vRawgv19bfSj47tPuUAGaMUY2+h0iH6Ga209lHeqJIUzJ2K79s/i/AQP6+N4LC5x3
	AKj4/s9Hsq4HTBBVkeOACfptU7kYHLYe90IJitU/6iPR4P1lDKatCvJnwdhl7VkyafnG9qg313Q
	31O1FpQ2kgdhYPh8pPZgINLz3O/zARpmu/cllp0h05Y9l9+VH5Y+vZg9c694ysbQ=
X-Google-Smtp-Source: AGHT+IHGItupR8AZMK4HAYR2nl0ykcSVi8qz4p01Fsmr2z4OTHYOfzOel4yl7D7BbOfRKvQ2GDFGXA==
X-Received: by 2002:a17:907:7e98:b0:ab3:2b85:5d5 with SMTP id a640c23a62f3a-ac7d1c64effmr1570316466b.49.1744122395290;
        Tue, 08 Apr 2025 07:26:35 -0700 (PDT)
Received: from localhost.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfee2591sm926664566b.79.2025.04.08.07.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 07:26:33 -0700 (PDT)
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
Subject: [PATCH v11 nf-next 2/2] netfilter: nft_chain_filter: Add bridge double vlan and pppoe
Date: Tue,  8 Apr 2025 16:26:19 +0200
Message-ID: <20250408142619.95619-3-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250408142619.95619-1-ericwouds@gmail.com>
References: <20250408142619.95619-1-ericwouds@gmail.com>
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
 net/netfilter/nft_chain_filter.c | 37 ++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
index 19a553550c76..fe0b12f748dc 100644
--- a/net/netfilter/nft_chain_filter.c
+++ b/net/netfilter/nft_chain_filter.c
@@ -233,10 +233,47 @@ nft_do_chain_bridge(void *priv,
 		    const struct nf_hook_state *state)
 {
 	struct nft_pktinfo pkt;
+	__be16 proto;
 
 	nft_set_pktinfo(&pkt, skb, state);
 
 	switch (eth_hdr(skb)->h_proto) {
+	case htons(ETH_P_PPP_SES): {
+		struct ppp_hdr {
+			struct pppoe_hdr hdr;
+			__be16 proto;
+		} *ph = (struct ppp_hdr *)(skb->data);
+
+		skb_set_network_header(skb, PPPOE_SES_HLEN);
+		switch (ph->proto) {
+		case htons(PPP_IP):
+			proto = htons(ETH_P_IP);
+			skb->protocol = proto;
+			break;
+		case htons(PPP_IPV6):
+			proto = htons(ETH_P_IPV6);
+			skb->protocol = proto;
+			break;
+		default:
+			proto = 0;
+			break;
+		}
+		break;
+	}
+	case htons(ETH_P_8021Q): {
+		struct vlan_hdr *vhdr = (struct vlan_hdr *)(skb->data);
+
+		skb_set_network_header(skb, VLAN_HLEN);
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
-- 
2.47.1

