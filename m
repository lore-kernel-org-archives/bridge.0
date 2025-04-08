Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2383B1E25EB
	for <bridge@lists.linux.dev>; Tue,  8 Apr 2025 14:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744122398; cv=none; b=bJbmrHhOGtfSLP01d8iBYiDNvdXDyk+1mXJoXWdlkYpiHeu/MKbQNPGPv0xroTXUmZEO8XcipE7OAXUf6vA3WkxRcgN4E/ABd6mMs4YJFDCzwv0/DbvCQrn+y1oCJqhlXgP9NgrXsJHovdJI59r/WI2CkQ4TXpp3Evd2Vl15XOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744122398; c=relaxed/simple;
	bh=uRS6L652Q8U04wSm9vVBsJo+AraqGWbdvUpqcrlUEAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vFm1W9yFP3FQpmtsaf6SEaz2+BjVAewBHsBkKNOaoGWVUyDHZ5QQtaZyjEuFfQnGhzsLB061w7IcGBptuZwns40JYUSG7AdluGH8P/xFFGXJXG4FbDnGEd64qpx2RE4e4k6dyw2Rkwmy43MlMmQG6sSlE77vJz8QBUDXNoa6rc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQ6IsPQT; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQ6IsPQT"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac297cbe017so1234350466b.0
        for <bridge@lists.linux.dev>; Tue, 08 Apr 2025 07:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744122393; x=1744727193; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWKZKslFax2kV4u5PDGKsv4N0lJQ1f1k8yO/foh+po0=;
        b=JQ6IsPQTW9blajTkwgEqseerWSNEoBC9CaRKdmHxeMpIH3KXdk+4FFHVJCD2VeGvDX
         Ii31RO2IUnrAAnQEVOuEdHA4Z3c3LnB8GR4zE90xH2gRYWSe1Yxj1izIFoHW1kk/Rdot
         sNQcq2eboBWF34qOmOxWtgnqghn1vg9wfC09vJX2sqRK0vtKMYLGAr4GWGqpj0Qe6qln
         u/RA0nXVgqRYAe6hJAcaQVI/Jx5aZwhk5hKMayf3tY+zwHNJhkkMEvNTzkX2gV6oWA/r
         dnMnTApR0IUXNdd8yECGaUDVgO/9PqKWKo7/YNgCA+tvGA+gZ7FO7tMy2UJJ27FQIfle
         MiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744122393; x=1744727193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWKZKslFax2kV4u5PDGKsv4N0lJQ1f1k8yO/foh+po0=;
        b=Uyba1ssBq2VUBJTYaBKP7RoBifFCBY+x4vi+URYaO+bcZiV3NDCx+Em1iXN/IDMurC
         vV0gebajLugTexNsnSkUbf6lA4Kuu15mwKwlevoUK0n1YK1dWgVPOU2fZt4hk0cRnZoN
         xI2mIYLk7GOtxwri1sVvNeY2tpRFAyHlYzhH0/9jhq7w31qRCRZsdqbFl33BJNJSi2O9
         1MFCd+DzWQIQN3NDFomLFkXUkSZHvf2rS+XPrNbeQAkc1dmP1jHZurwBhUbU5epxpqgL
         Tdi6y6aoq6ztpDJp4XcrhDhMGUEIlstAiJg3zk8U5rdnZrJE9WKTYbqqmc88lFtepgOL
         REug==
X-Forwarded-Encrypted: i=1; AJvYcCU+YoI1gfb0xR6c9DTaqR/k6D5WBremsODmN3X3I0EKJhv5e8pPvjK8SKZq0uhJaUeWrDbL62U=@lists.linux.dev
X-Gm-Message-State: AOJu0YzyGHd1cjL/CbQ69keGNv4jflPNMxKuKx9rft9noIT3A77tp298
	MDXx/8S42du6nw0hasA2HH6/AnDPNgc8w/8CqSSz6hxOXSnM+NbY
X-Gm-Gg: ASbGncvDZzMwSnMGV3Jqk8mfw9GDC7NJXhksivBjTe/xNZvpVZ1kccHLxK9h0/CgDiU
	tNUAdLlX3HEpCrVq2HU6eDtU29UtF62OtMy4Ph2xC2kEzQRwd3MAE8AyE/aUZ1mnZsaKrwsJv8b
	PB+Jf9YLr/KP5MShZG42A37FNPYCpLyEPdUgvb7IME5SOXYxb7qJk7USWNJ2SSVERiaUDe165Ya
	lcvAM0civtkxrCE5bAUoacPAQ//FN7zuySxtNejdgjjDp7q8nbzPe748zoagji1OdRIEbgArrOl
	4ch9daqOxrWwp9qlB6OVFsGfITc71noD7HzHvM+uK65gDUP/SFQTmLA/AHUM1HlmjeigqBKDoKY
	Jz00EAQC8f9DQ36kPMke3ptEw+8mv4XrL29vcsLoC+GkCdMNz7smVtvbGpxqOdFsOx5UQVALmhg
	==
X-Google-Smtp-Source: AGHT+IE/4xh7JZ8ie6FtQuBeNAOdK9l5F4HHL+F70wOa909hMeu4+jVo1k+aTmmbovneAXWkHDROVg==
X-Received: by 2002:a17:907:1c1d:b0:ac7:31a4:d4f5 with SMTP id a640c23a62f3a-ac81a667c03mr323981166b.18.1744122393113;
        Tue, 08 Apr 2025 07:26:33 -0700 (PDT)
Received: from localhost.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfee2591sm926664566b.79.2025.04.08.07.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 07:26:32 -0700 (PDT)
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
Subject: [PATCH v11 nf-next 1/2] netfilter: bridge: Add conntrack double vlan and pppoe
Date: Tue,  8 Apr 2025 16:26:18 +0200
Message-ID: <20250408142619.95619-2-ericwouds@gmail.com>
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

