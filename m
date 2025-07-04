Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411C7207DEE
	for <bridge@lists.linux.dev>; Fri,  4 Jul 2025 19:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751656334; cv=none; b=seTHv4Bh72tMgCh5D7i2Wc9avY8W3Qpi2VBA4Tm0Jy49MOIeB6jlRXyJ9ZWf9DUMHrq+i5JqzKzj2aJyTbHom9GWfgq2hSyzZIlr97MaSzzQ7ZQy0R64RW62SUmkXeu2EqirnyCt5jkWKYwvcrTYn2GlcJHPjZJYflg/BVffOO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751656334; c=relaxed/simple;
	bh=igXxmnQ60mmeb6eAscn5xBG3t9Y/o2UhtUwwvQihY68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RYafKLjqpesF598xyutJa7awG78x5H2bfHLBGrHdUKi99ules8Z2ezdr+lPSlPlTye7wxNeqGE/LfBBaGdwtL7gyVzWsI6qLq9WmuyM8OM+zlC6LlCFcG/ZNQjYY9/3RSUkFVRjMC0Qln+BfDHYgPsy1urfybCDeibp+FpImU28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCieXkKa; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCieXkKa"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a16e5so2172273a12.0
        for <bridge@lists.linux.dev>; Fri, 04 Jul 2025 12:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751656330; x=1752261130; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHdUFtAdvgJwnXb8RIInEyCi2R2lnW6LihNXT9M7RKI=;
        b=VCieXkKatDHCGlPY3iwj5slR7+xiJP0u83cPPi2gaC9aQswuWcRJg00eeBdfb3g87R
         DcreMIII5BTn7JtfIma8L0QgSBxzjZC8FgE0UobWNPT9BJk1jPxdEL5b1a8K3dsvh/ML
         lboZApwbO4dUBSfm21JnbBJMKMcLpZs/OxeU5R8QnWMP6sfy4NtZD7RrqoyCGVFhslzv
         o6y+J6UNK0DePj1yIGnGUSeJhpNEWvSaqWGzV4MEX8bZ8cdrLUNwD5CuQgABKQAYPBsB
         Z1rKFpLPH+MY2Bx/cyAGxU1Tm5ScacvvLWJjyZoy4u0Z5B1KXj9EL2uDLA0wSPFYTeZZ
         jHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751656330; x=1752261130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHdUFtAdvgJwnXb8RIInEyCi2R2lnW6LihNXT9M7RKI=;
        b=ZcnE1/VFgGYJzAvgAt5+cmVy4aXAEaGnHxYGnJ+uzpmxNpqP8zp/I+UqO8zlScYVBh
         mkT8Waj1SW9NEstR7nMUmYYvY3PsYcoVsoC1yCmE1N+6pw646HryGEwQAS04k/4r7xw7
         mIKN73BWVaY70Evbibg/xKaLfTpnVSsET8TCe37qRm3iXo2kzD/DWkxCTOgO5Jsz5l12
         zHFGiy6SU0SOlHZzW73x/1FzLp2Lsk6wFbIBU2e17fPIVseRSzGxLAyrVSGhmZXcp7rM
         v4cx2ngDVCLkf6+jGABh8rh0fUoxfr1XAJxMMr/X4FEIyTIEQC9vXnosPojqU9pk/t3m
         F+Pg==
X-Forwarded-Encrypted: i=1; AJvYcCUTY4+KrJLz8tAnbhgJxZ2AmfVwL5BN3UUsTbXu0oQe8ecJeMpoQygD1d8KN6GY4+NIhz5dPJU=@lists.linux.dev
X-Gm-Message-State: AOJu0YxiOYIRQW31S+8up5aQPrEu9EfWkHBM2fYIroN4Y7au7VPOBfX6
	i+NRFC/Iu4HWQZuMRjKzhPi8nDlUAhqBb+mcAxdOkQXnwmvJwmoFOHKI
X-Gm-Gg: ASbGncthWhKa/yjKjCP98ylJZqwM+JiCPrDA41UJduvTmFNYP0eSmC3iz2mV2yD7d9f
	8YROz4YS+n9uivLbrZGYeKIp1nNHfBhZSAHR7OGR60uoP4Y65x6FbBpvFks4Paj/OmsTtpR9u+h
	UHtQx4DmOT1s5ymtZkNNkYT6HKFz3gqyZXtPPLVedpmK3uNdVA7OnQhKsWXrRbzIF9qrEli+oLS
	7pywk/CLg7yxI/Ov7cJ8joiDI74pBiLr3AqeX+q7sEq0b8gHRMm/tx7Vv+wxXazMgmT1BkFW3Cz
	CtIVuw+sIU2i7lqMdUzD+zboZUTB4xT3Zbg0UIL1uF36dC4qCmPMKg63vpkoWxvd9leaPPLECmc
	Xed6CPGiSNVaz3cQsu+NQK8EBullPjclZFvxG0Qu59TvB55m1wcEbxAcVj0f/FNIib5qO2C3tTY
	4cKp6M
X-Google-Smtp-Source: AGHT+IG28dLEipCl99gk1JhC/6x8fkRr4Ob5eBBDcI3fOD2kfCfsHMZ8G4wUVRKRnRh8VQOftWJa6A==
X-Received: by 2002:a17:907:394b:b0:ae0:a245:d940 with SMTP id a640c23a62f3a-ae3fbd809b3mr405229966b.51.1751656330251;
        Fri, 04 Jul 2025 12:12:10 -0700 (PDT)
Received: from localhost.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6ac5fd7sm219476366b.103.2025.07.04.12.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 12:12:09 -0700 (PDT)
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
Subject: [PATCH v13 nf-next 2/3] netfilter: bridge: Add conntrack double vlan and pppoe
Date: Fri,  4 Jul 2025 21:11:34 +0200
Message-ID: <20250704191135.1815969-3-ericwouds@gmail.com>
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

This adds the capability to conntrack 802.1ad, QinQ, PPPoE and PPPoE-in-Q
packets that are passing a bridge, only when a conntrack zone is set.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/bridge/netfilter/nf_conntrack_bridge.c | 88 ++++++++++++++++++----
 1 file changed, 72 insertions(+), 16 deletions(-)

diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index 6482de4d8750..5fcb1bdf2e31 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -242,53 +242,109 @@ static unsigned int nf_ct_bridge_pre(void *priv, struct sk_buff *skb,
 {
 	struct nf_hook_state bridge_state = *state;
 	enum ip_conntrack_info ctinfo;
+	u32 len, data_len = U32_MAX;
+	int ret, offset = 0;
 	struct nf_conn *ct;
-	u32 len;
-	int ret;
+	__be16 outer_proto;
 
 	ct = nf_ct_get(skb, &ctinfo);
 	if ((ct && !nf_ct_is_template(ct)) ||
 	    ctinfo == IP_CT_UNTRACKED)
 		return NF_ACCEPT;
 
+	if (ct && nf_ct_zone_id(nf_ct_zone(ct), CTINFO2DIR(ctinfo)) !=
+			NF_CT_DEFAULT_ZONE_ID) {
+		switch (skb->protocol) {
+		case htons(ETH_P_PPP_SES): {
+			struct ppp_hdr {
+				struct pppoe_hdr hdr;
+				__be16 proto;
+			} *ph;
+
+			offset = PPPOE_SES_HLEN;
+			if (!pskb_may_pull(skb, offset))
+				return NF_ACCEPT;
+			outer_proto = skb->protocol;
+			ph = (struct ppp_hdr *)(skb->data);
+			switch (ph->proto) {
+			case htons(PPP_IP):
+				skb->protocol = htons(ETH_P_IP);
+				break;
+			case htons(PPP_IPV6):
+				skb->protocol = htons(ETH_P_IPV6);
+				break;
+			default:
+				nf_ct_set(skb, NULL, IP_CT_UNTRACKED);
+				return NF_ACCEPT;
+			}
+			data_len = ntohs(ph->hdr.length) - 2;
+			skb_set_network_header(skb, offset);
+			break;
+		}
+		case htons(ETH_P_8021Q): {
+			struct vlan_hdr *vhdr;
+
+			offset = VLAN_HLEN;
+			if (!pskb_may_pull(skb, offset))
+				return NF_ACCEPT;
+			outer_proto = skb->protocol;
+			vhdr = (struct vlan_hdr *)(skb->data);
+			skb->protocol = vhdr->h_vlan_encapsulated_proto;
+			data_len = U32_MAX;
+			skb_set_network_header(skb, offset);
+			break;
+		}
+		}
+	}
+
+	ret = NF_ACCEPT;
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
-		if (!pskb_may_pull(skb, sizeof(struct iphdr)))
-			return NF_ACCEPT;
+		if (!pskb_may_pull(skb, offset + sizeof(struct iphdr)))
+			goto do_not_track;
 
 		len = skb_ip_totlen(skb);
-		if (pskb_trim_rcsum(skb, len))
-			return NF_ACCEPT;
+		if (data_len < len)
+			len = data_len;
+		if (pskb_trim_rcsum(skb, len + offset))
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
+		if (data_len < len)
+			len = data_len;
+		if (pskb_trim_rcsum(skb, len + offset))
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
+		skb_reset_network_header(skb);
+		skb->protocol = outer_proto;
+	}
+	return ret;
 }
 
 static unsigned int nf_ct_bridge_in(void *priv, struct sk_buff *skb,
-- 
2.47.1

