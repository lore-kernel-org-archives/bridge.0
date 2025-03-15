Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D249519E98B
	for <bridge@lists.linux.dev>; Sat, 15 Mar 2025 20:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742068860; cv=none; b=o0ap9KrhyWwkpPpF1fVkuvJto7O/UXsvEvV6CyxGufkyANtVA8ZoyFK3TtvT8268mCDTeJ+zlVo2dot8iANQ9QxhNoqMcOahYGaDK1Pst8f9JUaxe/nG54FkvOjRclPiuCF5ZyWe618BVExGvGiaEl5ayVFgRxSyFeql2S7rIEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742068860; c=relaxed/simple;
	bh=uRS6L652Q8U04wSm9vVBsJo+AraqGWbdvUpqcrlUEAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Exm1oT46QdT/ZTZbyq9rFkOkDtsLaRLcKbUPZ8eUpsWAU/jDueBuH5nJvSJz6OIfdndimfREihvm78XsDndKd+5lhy3f0G/FSkdDxI9HU4AR6feD/6ldakwS/qqHYy8Tr29Qm1EbatBMkC9YoG9hckgjoiUcBx6fZpo6rwjYIXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AM03zgFE; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AM03zgFE"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab7430e27b2so600888666b.3
        for <bridge@lists.linux.dev>; Sat, 15 Mar 2025 13:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742068857; x=1742673657; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWKZKslFax2kV4u5PDGKsv4N0lJQ1f1k8yO/foh+po0=;
        b=AM03zgFE8IgvG22k+IBdL9SN5qfK2RLUFscD2dhEJ/vyvldsBySCSABnD+a11Myr4j
         pE/vUScBIXXQxoLBy5PtyDFwOeagVE7K1xackdbFIRdNSiXyELWeEWQoNWgUBfKV/V33
         /TNnRqt1jyJYRTNPDdWDRW6DzbMxXxTvK0QagEiH9KC+8pjf5MXS67Re97VRZQOMUq2U
         fsqNxxjhAPHG/8uuqTkG/Sc7RbavcV2AHAyfVYzc+JDXA0hhI6z6Sx9fv8cdSuYOEL5o
         ZUQ5eITfXUkq05GdQ0IC9xwprZOHNIPjLTdOHrSFA5y82vftWM9F84OklDnUKFJNJfIE
         sbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742068857; x=1742673657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWKZKslFax2kV4u5PDGKsv4N0lJQ1f1k8yO/foh+po0=;
        b=UhysjprPy3U5xnobNGoi/s84Vt0enhF73jHhWIuY3ARse5jgn8fhSASVmk/DArNeeN
         Dk/J8PNav2/atR3cUcab3YGOy1iYxov8xxWBi+vq9p+9Ll1+j/v298NIyP2UWAJsakiZ
         I/wrm8J2rRO14TKrvQ5TMxdEQWh0XfuVbGtRvgV2vR5R9wq3t3mwfK16Ma2jBqdJ7GOq
         elr/FhhSX5a9Z+jKiE0MAz9Vi16sSHJQyMy5JlWufklyL3WD6AQJyWaKLexSncqX3dki
         VoOOlVcxRzLJfW1k62RDWNsPIhyog16WxH2T0/i/R+INILF5khWklnGAcYejQMgnaodV
         nBfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVHRXMoXlXp+DPjWK1o6D5V6p/UStlheFGaEr31Bs38LHOnRmwB1Bz1946kpL9GIGoLCW8Irk=@lists.linux.dev
X-Gm-Message-State: AOJu0YxJUHTgT8RZNRmLm0DVX+dGj1gidck3FAc/0tNxaZ2ZxbSo+37X
	7maa0NgT8b0R3daYE0nseunyFwX1eCs2RzlrFu4bUOwyiy47OEBg
X-Gm-Gg: ASbGncsPaALWWr8U0JcQLxG2j5VrXsa8MdBZugrjxyeVQfOekDbQl4mjCsV13wb5zzZ
	mYNLMZsl74Ndvj2991OyDO6U1fi3rEsvjGdd3O4k5lXSDUiA5rjN0aeBi7TVFWuAB7VXd4lHTcI
	vV0d3PZAa+aJg01UE80ep40vgzoR3KxvUi/3vFTyYA+LbqK9jlsUMm2ls/9/lxxhtUflYhSZEG3
	WUYdUG530/eJhvRnXXsHmwufRPuEaLuw0czqfR9Bjl6f4uHoEMwFDYoVn0plFockJQS5bl38V8+
	s+ZYheLzT20MkLfRwXnpXRSpqJK0tZff5keF3UfM3t96lT4pERO+XRiqctkDy7CXXGY/0VTsciD
	uL0wKZZQ5QAviV1C6p4OW7N6w91v/jSPIenZ0Gr8ZpR1/fyL3wiroBoEqHBDLUrU=
X-Google-Smtp-Source: AGHT+IHmdpDrN39o/IkwTJNEru1TccCo+dNGWNgs5Efv+MeU9fbRfzseyMtpshQDwMjKn08rtN8PEA==
X-Received: by 2002:a17:907:94c7:b0:ac2:1c64:b0a with SMTP id a640c23a62f3a-ac3301940d2mr675256966b.14.1742068856975;
        Sat, 15 Mar 2025 13:00:56 -0700 (PDT)
Received: from localhost.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147e9bc6sm405908066b.49.2025.03.15.13.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 13:00:55 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v10 nf-next 1/3] netfilter: bridge: Add conntrack double vlan and pppoe
Date: Sat, 15 Mar 2025 21:00:31 +0100
Message-ID: <20250315200033.17820-2-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250315200033.17820-1-ericwouds@gmail.com>
References: <20250315200033.17820-1-ericwouds@gmail.com>
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

