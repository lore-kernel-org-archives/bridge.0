Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5DB28C02C
	for <bridge@lists.linux.dev>; Tue, 17 Jun 2025 06:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750143536; cv=none; b=sBk8U1nqV1Qk/UrRSw+r4WNhylg/fjEmLXBSSa8F+nYo6S5jPGdJ7AeeBPMBFxONnGD0gwhFEAvk+/tfMMFzGg9ajKX78m6zjXIik3aAfI7K+dqKRdrjJAAed4lqlhLXwKKZ9HxqDtctIHJq2xuQ53mE21OO9MbrEFiqCfJPFgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750143536; c=relaxed/simple;
	bh=TxdumPKtcywI6uKQ4pwKxBrxJvq5eX4R5rPP4NvYWC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qi3kjTQqt3YXf/3vHExu8Fc0a80gNoNWisE6G0qvMQ4Mndp+N0gqsIQj3iv+xD8XtZ06BBm9E7Vwbbwr6Ck9sgmlMk3mY4Th3HiUiS5UPPu2e0Cyd6Vyx/X4ue7b9YQFPVHaxN11R/zkCasCdVKkRfag1TOGgd0dRnTCUh/dAWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtktQ9UD; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtktQ9UD"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-607434e1821so7664387a12.0
        for <bridge@lists.linux.dev>; Mon, 16 Jun 2025 23:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750143532; x=1750748332; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEUA3s1rs6WdBTbpnUZoPmP+efvFUhPuP5B5crs3AeE=;
        b=BtktQ9UDRvsWbFTcG+RasPivfCznDhlWkkTYwyYstfnWqnSYWvsvrl/KbkLKLObosO
         sJJ3I8dLQaSEfCzR/ZMJhNvc/+xVA7F1NNChJcf/ASvO5xMwAqPwnOa/RuO/DLGdZaL7
         AwV4y/B8EMZPCv1v1jJpr9jCD9YVSEqzNpBEQRHr93cO4JdxYm1RucK2jn+z/c/DevvU
         l6XL7jlkMBQaC5gusbJsZ7HVUDCIjGnPzLRsF1kvpteypbR4vXlollInBqJFqbC2k/Pe
         tSM+QQXhm1kYs8bazcw9T1bvTzz78AyDQiFsNSnbh4BJzJebU1XY7QCHg41baIhq67jJ
         ASwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750143532; x=1750748332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEUA3s1rs6WdBTbpnUZoPmP+efvFUhPuP5B5crs3AeE=;
        b=sKyE/E1YwzN7hI/Tla8SL3vI/tSu35mm7Hp0KP9KnLGukAb1POgRDIxMuVwkqhcWjf
         SbZJ2KH4fBwqOtht6iRWX+TsFt3oa7xl75o3OK3XtUbRdq4xZi0lOEM+sk4rQXJvvnvV
         3PPhE7134nqaXQ5y/oxEsLD9mu8iWWdXKmlZxgPxwIf0QpCFyqZ5nO2FWOXsgN5uXKCB
         3bz5CYuUg2pHlZMfHMOgYdBpG4QfkYGJPYHoC2xaDnMYrF4diYr60nxB/LhvWJ7Rkm/j
         SnWNWsGfy7Ji3En3Sx7gsW0NxUH1B5zkm1dQ3kuqNWP994ilY5J8JevPMSFPdaKFrQl+
         9r5w==
X-Forwarded-Encrypted: i=1; AJvYcCV3L1jYr9wSD+jZkO8gUSeUKskLARcX/yeVOSEM2UJPIhKNuN/9AK8paPN6ggCfWK3Ncs33ClY=@lists.linux.dev
X-Gm-Message-State: AOJu0YyE/UBK1Mp73qO/u70hqjym68+9xLOwXueggbrRe0iNL2Zv6Sa4
	7pNTsgs21z+3Ts35kbdUh+V8csK7W8iBWZBGMb+bkcxJe9Z8uSN0y7EK
X-Gm-Gg: ASbGncvhPVW2kwNQ6/zsnr+x9iQKwxLUWfbuth5X+2LxwiMqJJvpu2glUlWeMj6jhLK
	3ZuNN9NFDwAREBbAldkEEmSM/AB+J0i9y6toCEW/Cv8C0xwpHujkEMN0DqTcEFwR/5k5Pj/FS5d
	SJfSJbhwg/fv339GRghvw28XYVgI+3FjShnln7kMSRcEYJmnLHKNYxWPA13t4uhiSou86f5Q/RU
	BFeFN0MU8Quly5F35EFniS/AZUqlMHwwrgRFEeVy0dQWpras4GUEKQ+P+l5Jd2nZWQ1/O1ETeeM
	JHKxJwX3r5J60ybh1YsxIkj/q4hWykd3M+QLrdr55KDLSwaMvHzG1LgJiUI8a16peMPeT/vTAQw
	hLDdu3ikh2kryJqs/77H9FinYAbmasZI75eUi8UzB5HS7yyI8MHy7O9BbUZ2TwlHFR3cflSCfEi
	a1AaazeBjT2v8mMRQ=
X-Google-Smtp-Source: AGHT+IEWvjSrTL6JNZv0ulgiz9/dYB+sJXThEPdkJZ1iROYdLX6684t6uUA2M9bAMVjS6TGmH9H79Q==
X-Received: by 2002:a17:907:97d4:b0:ad2:3fa9:7511 with SMTP id a640c23a62f3a-adfad4513e4mr1214994766b.41.1750143532099;
        Mon, 16 Jun 2025 23:58:52 -0700 (PDT)
Received: from localhost.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec81be674sm811109566b.53.2025.06.16.23.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 23:58:51 -0700 (PDT)
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
Subject: [PATCH v12 nf-next 1/2] netfilter: bridge: Add conntrack double vlan and pppoe
Date: Tue, 17 Jun 2025 08:58:34 +0200
Message-ID: <20250617065835.23428-2-ericwouds@gmail.com>
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

This adds the capability to conntrack 802.1ad, QinQ, PPPoE and PPPoE-in-Q
packets that are passing a bridge, only when a conntrack zone is set.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/bridge/netfilter/nf_conntrack_bridge.c | 83 ++++++++++++++++++----
 1 file changed, 71 insertions(+), 12 deletions(-)

diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index 6482de4d8750..6a17bd81038e 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -242,53 +242,112 @@ static unsigned int nf_ct_bridge_pre(void *priv, struct sk_buff *skb,
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
+			__skb_pull(skb, offset);
+			skb_reset_network_header(skb);
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
+			__skb_pull(skb, offset);
+			skb_reset_network_header(skb);
+			break;
+		}
+		}
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
+		__skb_push(skb, offset);
+		skb_reset_network_header(skb);
+		skb->protocol = outer_proto;
+	}
+	return ret;
 }
 
 static unsigned int nf_ct_bridge_in(void *priv, struct sk_buff *skb,
-- 
2.47.1

