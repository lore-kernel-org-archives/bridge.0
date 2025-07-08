Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28BF2E0929
	for <bridge@lists.linux.dev>; Tue,  8 Jul 2025 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987550; cv=none; b=toGz0ck+8ltTHUBuJ6xbdzvgU/p3S9+Nb8qm4L01Qx1Pghds311BTUUK/yLQQ3k85r76AGhy+yEqZH0aCmyGYyzl87yqQda3E60LvNCV74MoluxBdEHIllts2K/dwodsuv/3YGrzFuTnXLoS5L4plG7bApR6jUrvowjEUZ2jJD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987550; c=relaxed/simple;
	bh=1EGeNMcKEoAS6plzFdAvSLnrC7CBK/RtieKjFgE4p+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FhbL0PiEuSO/8U4fZRxcb2mGE1oc0bRkwJ9yASmM7Abat/qEm5JtwdsukEoiFvH9u40NGHZpiuUHC5gEakCkrBaHlndpPVIMWhLCVJVW8BddhgOLzrY6BuAJsgcF8fHMv54Uan4DXa42HIItkoMPcLkm0l8bIUL0MofrKQBjzfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYUQp3l2; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYUQp3l2"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae3703c2a8bso886843066b.0
        for <bridge@lists.linux.dev>; Tue, 08 Jul 2025 08:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751987547; x=1752592347; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOzzS6CGyYck17Ilz06ZcjMy829mvTI6FpgNABmXetM=;
        b=aYUQp3l2JTp5M6IQIZPAORzf4WzWZnaAZJ78IvyER21nuWCFtteI/4INhuGRoBqGvy
         2XKfmRyVa+laUO2n7Pr+a8twljeJstnHoGH1iEvzcFG2mUlAPzPIVygCr4nvUEVG4KOL
         ux9Hm9lisMk49J5sga0LQjvytx5jrL5308WD/tee8YM+swDqksbvda/m8TZFcIqbhiDR
         ITvNFsRKvb9e0Hbvf3NC/WuVCAG2Bb10lo/9Uj7vS9Dy8DduTOWBR3fG+kc3A0bBaiJx
         E8AYbcMvSgvVxV0CJlq+W1vqtqrt65FLWgRtWvHJHZ8yry8L1DEy4SKLWZBBiKKznjTl
         wQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751987547; x=1752592347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tOzzS6CGyYck17Ilz06ZcjMy829mvTI6FpgNABmXetM=;
        b=P1zlQxyj6DdCN0V6xLXwgPMrDJpH6szMcqNbnVDi5/DGOtJYRDd7DdUCvIZFC5i4aj
         AjTuUmqqYDD4NkJdZKImB50TRIfeivEtg4nllpHwxlFbZMI52MxYZEISC4NX8JGSD8Bj
         EWQyrQNna7qVTE5TeOStQPHLxBZr3fNpvmI1cOoNDHbZ8NEH4ya862TvzoP3kqZTqID2
         lFA63K5VDp5s4gM3qx1RR9LvC50lmvob66ENABOirpT38gQ99Y0QTKnZpuXrbOGLbng8
         xNziUKIVk5ZShWORQ3YA8QFQ3v7LhHL0Z8Pcigk5xdNtVLDC47VZ3OB3XY+g7tg0be3x
         zm6Q==
X-Forwarded-Encrypted: i=1; AJvYcCX0X7kmEo4Zbnole9KSw2Ef90H+LBk6OxO7+GbQiIP6ji+w2sZqRALaPBlmVN/uwkMdfjdMET4=@lists.linux.dev
X-Gm-Message-State: AOJu0YwQC2VGdjIFUfhnKmTTobalGVRIhgB/S6y4IevnFkz6EZ8lfppt
	6cI97BTK/o41co1kN3nQ6DOKKpsAm3tX74g2wm+KWc8Zgn/JrWpNwMnp
X-Gm-Gg: ASbGncs4iAmshWD9sn0HFeavFmKLuqIQC4unujITnD6YtLbb0uxODQ940c6kqMVeoNY
	r0n4TFYQ7o+fLCoBYjP6h8I5zKDoNMH4FfrPgrFV8/ZWCmUZmBQg8wi1nSfuao0NmM+63wd8R0k
	SlhksU9BneE1gXinL+xEmsMc34CVn+XDDjZyK6FJLxI41pa3Dqnk4ya0NTLL1zLXle7U2fqJ49+
	Tlu4XrRvRnKxq+Okv2Z3tGSZ3l62T7nYA6iDpLbGjDoWECtghckrAuz2yAZi4wgcxJgekwDstq4
	zFyqGqytJ4DIwPi061m8QfLTDe3gGH7m9CTFgDJHmZVTkJTqucHkw53ATlETlhkT5gpeV7u5TUg
	ccCs5Kp9ziNBVUYekZ5NBzulgEMC+NCOrJRb2rOZX4p9saBwxMglnHAOUYKj2FfdaLpzEmfRdUE
	rBkJKX
X-Google-Smtp-Source: AGHT+IEJAWtzd09MByxZZBm7YIZpblH/PVFUkia/DbtlWbWHUGuRi5Lu7PnQgzWaBu0x7eNmOZ7RAQ==
X-Received: by 2002:a17:906:28d6:b0:ae3:cd73:efbc with SMTP id a640c23a62f3a-ae6b021b6c3mr325082766b.46.1751987546429;
        Tue, 08 Jul 2025 08:12:26 -0700 (PDT)
Received: from localhost.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b02a23sm907596766b.112.2025.07.08.08.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 08:12:26 -0700 (PDT)
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
Subject: [PATCH v14 nf-next 2/3] netfilter: bridge: Add conntrack double vlan and pppoe
Date: Tue,  8 Jul 2025 17:12:08 +0200
Message-ID: <20250708151209.2006140-3-ericwouds@gmail.com>
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

This adds the capability to conntrack 802.1ad, QinQ, PPPoE and PPPoE-in-Q
packets that are passing a bridge, only when a conntrack zone is set.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/bridge/netfilter/nf_conntrack_bridge.c | 88 ++++++++++++++++++----
 1 file changed, 72 insertions(+), 16 deletions(-)

diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index 6482de4d8750..ccfe1df5e92e 100644
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
+		if (data_len < len)
+			len = data_len;
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

