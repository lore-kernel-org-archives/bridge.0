Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5DD3191AD
	for <bridge@lists.linux.dev>; Thu, 25 Sep 2025 18:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758825064; cv=none; b=mtFp68Z3aXMu2rAx2bqd/QqVY6eh3VGwVXrFjJd+/7OkliiKZcRtJUSgh4q4TOvSEZRRfVIlqq9EkUZZ3W42s2g2liD+Xq7oQTsoN2i8qXVCZPOgSmnpb8bzozo3Nx9aIN+hmucYm08ydEKcQfY/3X2ReuiPrGnnZfx14P4Nayk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758825064; c=relaxed/simple;
	bh=ovH7NLxlzzSK9WVYC0PhEMqPjPiuDuf7OAcH4fUbX94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXg0zruVc++T9pu2CjheIztLCWBWlgduI5Opcy/WNGWJy4yJSJfau2frFYoa8T+46CvYIA6PIyqpIFYHxiWD1cMHGAZA2bWJAM0wEhdoiRo7nfRdF7xIOYRkGXAFxAalWKseKB04Cqdxl8fW8w1FpCl2RkjsoFOiqXcKLcCMsRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vie07ALf; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vie07ALf"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b00a9989633so211978166b.0
        for <bridge@lists.linux.dev>; Thu, 25 Sep 2025 11:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758825061; x=1759429861; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4i+bCQ5MlHbYcO9KO5Yge1iebjxDWaZWFM7hLHP88c=;
        b=Vie07ALfhXMfZAqsYAAs1JuctqHcIZcDKrFuLUWJGLfsxY7E1rSLAbUmhBZkZfGere
         Oke5ieRGvtwAz+Hz/iZX3SxjqyjJ3N+kwemabQ8slKJYDhei6nh/2jFRvq6514wM7nNC
         +hAkB6lUIQUoBdK/WZTe4GTCXcr5NSXAm4K9Fux5gZcE0Zd4bfzng4Nt+nVx0x2od+vY
         qGTNrQAB6srP3+8e3MPEc0PhINAIsh6R8UG9zlGhNcDg7PuQ2xZPBkSL2b9Hyc06Q2eU
         v4VmYkYg0CxQi3AiEQtJ/BlZrnlWHS9eFYX4d41kCY3HUM6kuXCqgjVHpLKOVEQWfKVy
         th/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758825061; x=1759429861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4i+bCQ5MlHbYcO9KO5Yge1iebjxDWaZWFM7hLHP88c=;
        b=ihRefcKw1+p/tDH4126Y4k6ZeFy1Dapd9CHN84dmRAhgZHOzbDJyaw0D8UvajzMxEL
         hMkEQvwfxqEAl/dft8hhexjeuSd5uQTrpkAN3vztukWi/LAgF+6rUuiW4ORRL0OYmaXs
         7xZiz8UjSf+p7/s0desj6mBrKTREjulHxtRP2piHgCqX1MLSRYCpUv/lxL3JJ8WP9n/B
         uvwYTzh3Id+opIRi71SDfKu+knPWj6OYA5uq00Vy7s9EM/Cj8GG+iqKorXXnNi50IlUz
         LPA7Cbo2ZA6o7TlLbgO3ecWpcMfla4Xkv8+90f+PDUjSZaueoi7JtSLUuM3TGwk8SKIP
         5xGA==
X-Forwarded-Encrypted: i=1; AJvYcCVsZXsRyDt0SRhTxgxp8S09tFR5WlF5Ajyk5Y8kiJJL9J0F1UmICasV/mm1sIKHPNtqO7ZvmqM=@lists.linux.dev
X-Gm-Message-State: AOJu0YxDFpFyyp41GvL4opjN6d7B5pFdS1Bv1U818Qv6eLaS20iG8Nw5
	ZZ0/nnTE62RwPeskXd8/3gizwoj36Qc1mye02bH4NZ9oVZwfybqWwn76
X-Gm-Gg: ASbGncu0Y+2k4TdwkHN/dfJDE+w0EGthP5BpFi09TOw5CgWSQOr+6RDchE7FN2d5dsz
	TavwxkcnvOPGqAaGqeea3GtY45izJRwl24sZiAN7juIQmfsSr+F13ICAay9Z79OwWoiPBmPwAOV
	6Q73i4rKBRFrCPZ+01uY7TKjTsnJ4cF6/TV2GdAwxQwclxyEco3aZxA2QUPvZtOhnUdv7cKa5DV
	hQErfliqpQg/QdLaUPIG/XNjP8qqC1jfVD3OhdHnhw6+AS4j9Fi+uBWd7OJTKXkMzsEnCxsHsYp
	UeqLSSPnLqILpPmPxu+RZpnbIlLKYnPDsX50E75jGlE1cQXgmrAmktDGkraLAe6GJkOkeKV3STM
	ncEP3ez1y+9d4C0+a3GktuounXTrYVfGO/40LEwCS6GCnNpWLVgokEGEocP+U2RU1tcc+wFpt+F
	iyM7FysB6x6D1M0QcV8w==
X-Google-Smtp-Source: AGHT+IFPe/dbeDF6Im7/W1h15NLhKANyKOEKqP6yxsuAyUtLh3wQ4f95Oj+7V/uEOpOQCqQ3G+kRuA==
X-Received: by 2002:a17:907:7f8a:b0:af9:8739:10ca with SMTP id a640c23a62f3a-b354e31bbacmr390106366b.28.1758825060520;
        Thu, 25 Sep 2025 11:31:00 -0700 (PDT)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3545a9c560sm211198666b.107.2025.09.25.11.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 11:31:00 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
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
Subject: [PATCH v15 nf-next 2/3] netfilter: bridge: Add conntrack double vlan and pppoe
Date: Thu, 25 Sep 2025 20:30:42 +0200
Message-ID: <20250925183043.114660-3-ericwouds@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250925183043.114660-1-ericwouds@gmail.com>
References: <20250925183043.114660-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the capability to conntrack 802.1ad, QinQ, PPPoE and PPPoE-in-Q
packets that are passing a bridge, only when a conntrack zone is set.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/bridge/netfilter/nf_conntrack_bridge.c | 97 ++++++++++++++++++----
 1 file changed, 80 insertions(+), 17 deletions(-)

diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index 6482de4d8750..d3745af60f3a 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -237,58 +237,121 @@ static int nf_ct_br_ipv6_check(const struct sk_buff *skb)
 	return 0;
 }
 
+/**
+ * nf_ct_bridge_pre_inner - advances network_header to the header that follows
+ * the pppoe- or vlan-header.
+ */
+
+static int nf_ct_bridge_pre_inner(struct sk_buff *skb, __be16 *proto, u32 *len)
+{
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
+			*len = ntohs(ph->hdr.length) - 2;
+			skb_set_network_header(skb, PPPOE_SES_HLEN);
+			return PPPOE_SES_HLEN;
+		case htons(PPP_IPV6):
+			*proto = htons(ETH_P_IPV6);
+			*len = ntohs(ph->hdr.length) - 2;
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
 static unsigned int nf_ct_bridge_pre(void *priv, struct sk_buff *skb,
 				     const struct nf_hook_state *state)
 {
 	struct nf_hook_state bridge_state = *state;
+	int ret = NF_ACCEPT, offset = 0;
 	enum ip_conntrack_info ctinfo;
+	u32 len, pppoe_len = 0;
 	struct nf_conn *ct;
-	u32 len;
-	int ret;
+	__be16 proto;
 
 	ct = nf_ct_get(skb, &ctinfo);
 	if ((ct && !nf_ct_is_template(ct)) ||
 	    ctinfo == IP_CT_UNTRACKED)
 		return NF_ACCEPT;
 
-	switch (skb->protocol) {
-	case htons(ETH_P_IP):
-		if (!pskb_may_pull(skb, sizeof(struct iphdr)))
+	proto = skb->protocol;
+
+	if (ct && nf_ct_zone_id(nf_ct_zone(ct), CTINFO2DIR(ctinfo)) !=
+			NF_CT_DEFAULT_ZONE_ID) {
+		offset = nf_ct_bridge_pre_inner(skb, &proto, &pppoe_len);
+		if (offset < 0)
 			return NF_ACCEPT;
+	}
+
+	switch (proto) {
+	case htons(ETH_P_IP):
+		if (!pskb_may_pull(skb, offset + sizeof(struct iphdr)))
+			goto do_not_track;
 
 		len = skb_ip_totlen(skb);
-		if (pskb_trim_rcsum(skb, len))
-			return NF_ACCEPT;
+		if (pppoe_len && pppoe_len != len)
+			goto do_not_track;
+		if (pskb_trim_rcsum(skb, offset + len))
+			goto do_not_track;
 
 		if (nf_ct_br_ip_check(skb))
-			return NF_ACCEPT;
+			goto do_not_track;
 
 		bridge_state.pf = NFPROTO_IPV4;
 		ret = nf_ct_br_defrag4(skb, &bridge_state);
 		break;
 	case htons(ETH_P_IPV6):
-		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
-			return NF_ACCEPT;
+		if (!pskb_may_pull(skb, offset + sizeof(struct ipv6hdr)))
+			goto do_not_track;
 
 		len = sizeof(struct ipv6hdr) + ntohs(ipv6_hdr(skb)->payload_len);
-		if (pskb_trim_rcsum(skb, len))
-			return NF_ACCEPT;
+		if (pppoe_len && pppoe_len != len)
+			goto do_not_track;
+		if (pskb_trim_rcsum(skb, offset + len))
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
+
+do_not_track:
+	if (offset && ret == NF_ACCEPT)
+		skb_reset_network_header(skb);
 
-	return nf_conntrack_in(skb, &bridge_state);
+	return ret;
 }
 
 static unsigned int nf_ct_bridge_in(void *priv, struct sk_buff *skb,
-- 
2.50.0

