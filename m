Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14D4209673
	for <bridge@lists.linux.dev>; Wed,  5 Mar 2025 10:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170612; cv=none; b=DHnxwkMBFCt9m/2ptdNj9cviP/t3Rx7AGMyjiZFfnqBaEEJBuUUlOjSnzQCIchLcMom4KBsnTUblQcKasndYpgGnq8cfvyoRp6Qro9/v0a7ZZHQdBWH9XTCnT1ArA0N8NGhuhXAXg9O58JxeA+AlLrWTG798LVxQyNKnkYOmExs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170612; c=relaxed/simple;
	bh=uRS6L652Q8U04wSm9vVBsJo+AraqGWbdvUpqcrlUEAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ci8gx+ClEmHbutwHTxxH+QX4xcsi3uSZ/37HB86UMD5I3Yrt54Nck9KaTHSXdiQt0l6k4zrcsvUyc0rbsKQ8Aze3nMDqhgT0GeL9+76RIfiD5hcz8R9DSY4tSFQ8wltV38W8yXnAN+Ugf8NiQP41yQPbn5Cl0bxAo+oS4JoLEOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WudNKBs3; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WudNKBs3"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abf52666efdso564687966b.1
        for <bridge@lists.linux.dev>; Wed, 05 Mar 2025 02:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741170608; x=1741775408; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWKZKslFax2kV4u5PDGKsv4N0lJQ1f1k8yO/foh+po0=;
        b=WudNKBs3LNkjLdtw9VWRQc/LCUohOIzR5clKkGVjWC+LZZ6mz6heN0OLX61lBQpsW5
         im5XT5NMjdBLEl3dTF9jtdi5pDGf0rc6ygVXQYaWqh10WSl1W2oFPjIiiMtotZ3kG6e/
         +J53Ftsw66cPkorY84rRS6qi51R15xdXwTZ2G63sJ18wIwV5uxeLf13Q/iueFWKB4Yok
         JsokxVm5xFbHGkI5Cxys8+r6KCPzasEXgASANFrEu/LGZ86rbb1m4afUDM4baz8sDx+h
         Ouj31Cztqj0SyySHpRU4xw4EC6K3oKVozX7TtX0GjiF/s84ZA4ObFNlMI2eZegV73dYa
         1GWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741170608; x=1741775408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWKZKslFax2kV4u5PDGKsv4N0lJQ1f1k8yO/foh+po0=;
        b=TpxL/8VCOAVsLFlaSJB2YOXpqknfCVUgte5Bw9saifSBDLmRAn2+bHbxfEEIKSxSMr
         d+41XbUlaNPRPFieKS9jO9tvSxN1PbbmBtTpZr6MOpWvt7vtP/jhQ5Li7c/3Ms8yJa+D
         z8nPTphjhX+Y56bj81MatD43eiUEkP8Pm3wAppcVQr7FcqdCaX69hZI57kFuY8TfH7ck
         LbS0Ef3Cbq9xskQyy2V7hKyWGomDZ4iCKPLnjC09HcL1Wggi4Lzg/ctNpWPLkxkc2FcJ
         RkZKJPA3OLOawtDhFgIDcNN5NmZ1wvyuF1mCaFCydl4mHOVOHc7NGNa6m7jDwsFkqEa+
         ePXA==
X-Forwarded-Encrypted: i=1; AJvYcCWRm196j6utxBIRFPyRHL+wd3AFPzuz0c4K8tO8AnCfcD+jgCGtEtDKN5IIxDgMsxPbCipWQlI=@lists.linux.dev
X-Gm-Message-State: AOJu0YxJns/yRzdvbsv+L7mzi5QT4RT2cO8+lBCUlYYUk5qdlTKqARLL
	bXriMjiGyhRwTl7JDmOqfl593J8IbLX97tdB2FaWK6JwCuJJXUPR
X-Gm-Gg: ASbGnctRg35nG68QzdY5EjY4Rca6IRIVFN0c3sj3hG2REgXUxy3HaeIawG4Wn4Gk80P
	myrryfRgm6Bir56a603ZLY8xSw1EWNgRWJsBTbHbFbIEkSj42K/+pmsU00MNgjKkDQymEaweJrE
	2SVShphsMMIpEjYqzUvgWfqep8J+8DeSoritknFZWSbhrS3hb5gWuhRvpDehp5l9NYMfq8UWNuB
	YXlvZmkV+fZWKdCHUYYHRfQ8JtRntznXRhxgoZI2mT0LQ32K6hJydwVW0ymVwCKp5ZeCzwXIu5f
	RZ5vRQWfPMZTIdghk4VOvpL0aHN7lKut/uhr7MgqY4P31ReM+KsTXhyg+LSkqgzAGz0mFFMdlSl
	SZeDOhTqKVOns4iY9sxUrKGERdYtjBjozrgO46icAI0wbkHXa2U7B6SE8lY7Npw==
X-Google-Smtp-Source: AGHT+IFexB2RNevlxHvMPAf8/WCLTLQ9IXmSXZbmZFMdhkY06Emnzf/hwS2/XrsP0oxSe3vo0bLssw==
X-Received: by 2002:a17:907:3f15:b0:ac1:509:79b1 with SMTP id a640c23a62f3a-ac20d8bc9a1mr236165766b.20.1741170608493;
        Wed, 05 Mar 2025 02:30:08 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1f7161a4esm247154266b.161.2025.03.05.02.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:30:07 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Ivan Vecera <ivecera@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Frank Wunderlich" <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v9 nf 04/15] netfilter: bridge: Add conntrack double vlan and pppoe
Date: Wed,  5 Mar 2025 11:29:38 +0100
Message-ID: <20250305102949.16370-5-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305102949.16370-1-ericwouds@gmail.com>
References: <20250305102949.16370-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the capability to conntrack 802.1ad, QinQ, PPPoE and PPPoE-in-Q
packets that are passing a bridge.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/bridge/netfilter/nf_conntrack_bridge.c | 83 ++++++++++++++++++----
 1 file changed, 71 insertions(+), 12 deletions(-)

diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index 816bb0fde718..4b4e3751fb13 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -242,53 +242,112 @@ static unsigned int nf_ct_bridge_pre(void *priv, struct sk_buff *skb,
 {
 	struct nf_hook_state bridge_state = *state;
 	enum ip_conntrack_info ctinfo;
+	int ret, offset = 0;
 	struct nf_conn *ct;
-	u32 len;
-	int ret;
+	__be16 outer_proto;
+	u32 len, data_len;
 
 	ct = nf_ct_get(skb, &ctinfo);
 	if ((ct && !nf_ct_is_template(ct)) ||
 	    ctinfo == IP_CT_UNTRACKED)
 		return NF_ACCEPT;
 
+	switch (skb->protocol) {
+	case htons(ETH_P_PPP_SES): {
+		struct ppp_hdr {
+			struct pppoe_hdr hdr;
+			__be16 proto;
+		} *ph;
+
+		offset = PPPOE_SES_HLEN;
+		if (!pskb_may_pull(skb, offset))
+			return NF_ACCEPT;
+		outer_proto = skb->protocol;
+		ph = (struct ppp_hdr *)(skb->data);
+		switch (ph->proto) {
+		case htons(PPP_IP):
+			skb->protocol = htons(ETH_P_IP);
+			break;
+		case htons(PPP_IPV6):
+			skb->protocol = htons(ETH_P_IPV6);
+			break;
+		default:
+			nf_ct_set(skb, NULL, IP_CT_UNTRACKED);
+			return NF_ACCEPT;
+		}
+		data_len = ntohs(ph->hdr.length) - 2;
+		skb_pull_rcsum(skb, offset);
+		skb_reset_network_header(skb);
+		break;
+	}
+	case htons(ETH_P_8021Q): {
+		struct vlan_hdr *vhdr;
+
+		offset = VLAN_HLEN;
+		if (!pskb_may_pull(skb, offset))
+			return NF_ACCEPT;
+		outer_proto = skb->protocol;
+		vhdr = (struct vlan_hdr *)(skb->data);
+		skb->protocol = vhdr->h_vlan_encapsulated_proto;
+		data_len = U32_MAX;
+		skb_pull_rcsum(skb, offset);
+		skb_reset_network_header(skb);
+		break;
+	}
+	default:
+		data_len = U32_MAX;
+		break;
+	}
+
+	ret = NF_ACCEPT;
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
 		if (!pskb_may_pull(skb, sizeof(struct iphdr)))
-			return NF_ACCEPT;
+			goto do_not_track;
 
 		len = skb_ip_totlen(skb);
+		if (data_len < len)
+			len = data_len;
 		if (pskb_trim_rcsum(skb, len))
-			return NF_ACCEPT;
+			goto do_not_track;
 
 		if (nf_ct_br_ip_check(skb))
-			return NF_ACCEPT;
+			goto do_not_track;
 
 		bridge_state.pf = NFPROTO_IPV4;
 		ret = nf_ct_br_defrag4(skb, &bridge_state);
 		break;
 	case htons(ETH_P_IPV6):
 		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
-			return NF_ACCEPT;
+			goto do_not_track;
 
 		len = sizeof(struct ipv6hdr) + ntohs(ipv6_hdr(skb)->payload_len);
+		if (data_len < len)
+			len = data_len;
 		if (pskb_trim_rcsum(skb, len))
-			return NF_ACCEPT;
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
 
-	return nf_conntrack_in(skb, &bridge_state);
+do_not_track:
+	if (offset) {
+		skb_push_rcsum(skb, offset);
+		skb_reset_network_header(skb);
+		skb->protocol = outer_proto;
+	}
+	return ret;
 }
 
 static unsigned int nf_ct_bridge_in(void *priv, struct sk_buff *skb,
-- 
2.47.1

