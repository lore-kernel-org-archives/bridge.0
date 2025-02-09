Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62CD15CD52
	for <bridge@lists.linux.dev>; Sun,  9 Feb 2025 11:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739099450; cv=none; b=ZlXhJJtwXWqYfXen5QXsi1zlW+Pz36N1BGjHkvDZnAobdugL1PBvz3AFZXKIPdKwE5AJnZ5JB7ygoQjOC/EY6hfZWPYa/mznuxzwSGj64tEobVpnC4R6/7IuiFAR4gyy6KGvMThqbrUcAZHbrdj4mhq1KqmGY1OsiP+Vr3y3RLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739099450; c=relaxed/simple;
	bh=Cv52Ysjt2lko9sBWDja1ONZ3DhITuFZz/l5ensZZgPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZmWswc4TkuG1vSMLmmUjTCYD+RXmLBP3zeKnAa1d2xMH8qpsuBnelgqxFyBpigWyAyiqhtr4+ng31JPV4RBNS74Uadq230jIo3+Vk5Rf0BNb1ws4OX3XT5gPxPXU9VtSMbdNIj3RfE91NY+inLd+lEVq/AjaS/DjsOF9qluWubM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5QcbuaB; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5QcbuaB"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaec61d0f65so774883166b.1
        for <bridge@lists.linux.dev>; Sun, 09 Feb 2025 03:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739099447; x=1739704247; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rhlCg4/52AHm6e8tJsmpQptNUxepmsLI5spztxpn6c=;
        b=f5QcbuaBeL4Q1sD4D5d1AVc55GM5i1MBwK6vuRt4mZae46Rm6ATSkWfkPgbMzZlCAx
         /ktfikQuiVRj8OuNSbsw8bhyHetv9TGoYw6eqwZeweVUqpGn1QG06HC466SBCpNPw/uD
         HVZBvtthh98JukXkFQO+Q81tYNMTCHd2Pmt5YOtdV4brB2kZ4o+EAEbxshpo2O0G+Rym
         8DND7pHSzIbvBobb2FMNhSRs5PsSiLiyqy3gUiuWc3JqgI1o7ds2qzIaH+vyx42bB4fc
         nD5ThLS2373/l/4p7u21SpJ+u8DkR4uqPAh5Hc9t8R6YHTsluiwdn6xa3EXJ/iK5xXJw
         /kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739099447; x=1739704247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+rhlCg4/52AHm6e8tJsmpQptNUxepmsLI5spztxpn6c=;
        b=jx79+jWGwOvnSTvrOanpN+ycieYkdj94jVOZdBuaTtsxGt2asvqlI67Zmmm/+zeAfc
         ShYD73Z26SXwnIkf2Ofqp/0eTbd2mfxFbzcHyTmaCWaD6T3uW+YJk0AJFQ20nPi3h361
         TLsGKNPfjF1W93w3hieURfbfRWlxowbP/ab/YGKZh5pEaGsZLI0Mq+OpaF/szOfHw/0R
         456PEvqzkVg8m6bBIppu/A17YRJZDw1OuFc3cID5a3i9uN37JjJdHdcVxDFGTgOt2WGK
         zwUNBbTTi7hw3FfcOQRJyxGM6xlAcEBKR377Qs0hzDcBMtXu3UNTaj/J/0G8qhyuazor
         Yi+g==
X-Forwarded-Encrypted: i=1; AJvYcCWzEw66HryFYo1wct+T1qlgvgD/hD9oqQxTDzEWoypAFWaWDpw7BYZloslBgA+pEjZI00Dbrhc=@lists.linux.dev
X-Gm-Message-State: AOJu0YxfgKO/BOSbfF2U1vlSW5aoOJj/D1iUH7Z5fmbnYq4nN3R0i+e5
	jL7RJdELELNZ063FKh2XaHozyD0uY3YSC+oFsQaPMSe1WuH/39oC
X-Gm-Gg: ASbGnctgKZpnfksR/CW39VbMB5b3WStvOn9ogzVAWJjU81XvlUG0qmQ3EJQxN3wv3hN
	FjV6Xiw35i7sQk0uHjIOVpi2inMrd8Mo7Up3Hs9HEU/b34KPwFnaL0xVthgTHLLPNnRA1837ygZ
	jYSS0+fCITYncbaNsTbThEBtfjqaxhyqevKr7ho3xOZnHTrG6PRCYjE+cNOHhKCtDQFg81ysUCE
	wIt+3jmRTVzSUQqNSrQTc9gVKdIdgn6VM+23RIMaWLjTzJtQ7NJvgqjYJxDbTHgoyCCcQqS6zlR
	QvSr9T9rYhrISJM/6xulTH5lCFbe+bSqUBfYZZgGQXaGzr4+cgXP7mmZrIB3YkC0jOwwOovq0n5
	ms5iaZl5YlFgALrXmKUB+j6p6dWaduUXP
X-Google-Smtp-Source: AGHT+IEJGx8wQoo1dMKGJULnbHYNaXYTUKaNfqX5z4+uVPE/Bt8Onuv1jKMr9kAQ8Pgh/X+AOmc+8w==
X-Received: by 2002:a17:907:c04:b0:ab7:e71:adb5 with SMTP id a640c23a62f3a-ab789cbe4f0mr1245719366b.35.1739099447174;
        Sun, 09 Feb 2025 03:10:47 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab79afc7452sm357516366b.163.2025.02.09.03.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 03:10:46 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
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
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Joe Damato <jdamato@fastly.com>,
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
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v6 net-next 03/14] netfilter: bridge: Add conntrack double vlan and pppoe
Date: Sun,  9 Feb 2025 12:10:23 +0100
Message-ID: <20250209111034.241571-4-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250209111034.241571-1-ericwouds@gmail.com>
References: <20250209111034.241571-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the capability to conntrack 802.1ad, QinQ, PPPoE and PPPoE-in-Q
packets that are passing a bridge.

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

