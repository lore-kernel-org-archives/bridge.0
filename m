Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23B4219A7E
	for <bridge@lists.linux.dev>; Tue,  4 Feb 2025 19:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738698598; cv=none; b=KA+NVAwP0cec5MSFC/Xn2z6ZPaKXu4Fp6qaZOzDqNmr081QGWt+nX7H+9CEmnhY/uN9LUKpJmkIbCpf4zMbUXGBqJx5u4wsMjfK4kg3EEUHpgPb24BCATnm6YR3BcaH0qCGJA0E6VnMrkk9KrcDPIC/mmBdt+2N4wg4k+u6mGYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738698598; c=relaxed/simple;
	bh=RF5LvDCYnydj6qn0qJH84ZScpLNAa8mIOdNORjie3so=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVij8qMxSVSljbR9MSL2HdDOlUVcz6bHWM9NyvYBYA2bs97K6vHa2vKSxwoQK+yBhEqpdWv+w85UKHtuWuZVtIEcBd0fiVqZD80JSmH3SNfsp7HvNfzq/vIXxkLk7jbUZjCztT2w89JE3rjpjTuXIffnN7XrDLEC2Fv8pnjj1M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AshgMB+h; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AshgMB+h"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3d479b1e6so8346934a12.2
        for <bridge@lists.linux.dev>; Tue, 04 Feb 2025 11:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738698595; x=1739303395; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ib9AvLEqJNS6gnJbPJClceeQRzwP8bycAwF1f+d+KWA=;
        b=AshgMB+hhMRQm+LvJlLFLR+oCqCRMtR0GuFEXymNb1DBp/1Xsm/YPtZCwcz710sUQ9
         pa0wSvPd6RCI5bJ2CGIGkp4rkQc3wdY9i7bfF0q6rL9u3DYDhlhr7YBZcA273aPjOdXe
         Qtje4CD6Vx9zXsy/oVET55wSmz3UbpmT7FzCpQoolXxC7KQ6nJyoaZOCDKcsQtVMStaX
         L2gmemDsodrfhB366EeYq1llXLQ8q3uPda4WzDP7RMKKya8PLc8sdvvvcPv28AWOvXks
         /f6gGEEQPE1VYT8HyqGgdjqD67e+R1K3HAHP2XVAnXykcxI9d4CB2P0Oj1KPxXN/Uywd
         MuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738698595; x=1739303395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ib9AvLEqJNS6gnJbPJClceeQRzwP8bycAwF1f+d+KWA=;
        b=E/4z7TuhadaNJk1eerIBQfe0yMz9NsZ4eKNT3oQ2emCGMfPJoQ/sY070itIhK0ISww
         0EjeVrluknPlc4K+D+vs7YXRfbmBNT8f7GGlVnLwC2SAArsv7VahfaDOMeWcoqmC8hwk
         ZBJC0k97tG8rpogQx+vb7x66r22xxOLHHXscAcMJ/R3gsINQdAJDwY0BXxIFB506osiM
         hcpBJRqCJNVVaO/0NMBGi4mh+UO1yflNGoVuaal6Aas2xysPqFP5hXYrEwPeZ5IdPtCd
         AsKvSms1VNmcIMeXUgbTa74J5vM6OA6wOlgpbIMUV0uPrUEtyycu8DVCUVP3FfPay2/2
         4LdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLq9IdY7d1mMygj1s9tplYcbMrh9wcVME1DUH2c475GrTYyCvakMalDtx12u3SmbSVFN1A784=@lists.linux.dev
X-Gm-Message-State: AOJu0YzXBDcbW/p5VmwOp298LtmUQd/78SwabZBeigz1cV/LpNvOGuZO
	t+mbK/8WRwZ5SFvlpY+5x09jbkZRD3d64kny9R9GDsQQbmrwvqMG
X-Gm-Gg: ASbGnctdJbXLUuO5c4KSL4LjAqyTWS1SnpPm1ey4BMIPHkMyKCKMN9AHBeiBNsyPbTx
	Pz1b4DYKEFO4KEVet90GYEA8cWyRQCkb1ZTQuHKXj34iZeRZU3r9nhkKp8T+ubdkqdthe+Z1EnI
	82CGvcIlsnj5i1KAvWdo8YAr7wF7b2T9sW84ACy2tIzKxqsrYIJ4tyfy6xNBNEOp2sXH2fdT2Wa
	R2x4fwyCQIwAapdv3GSdtbFq2B3k7iyunhcMcoqubyanKKoI9L9ykWZ/hkEoltkSyI7rULfhC6Y
	zsfma1gCk2S3sf8aCp4HNcVbAp8tpHOK++BDte7uLnEFMZ49HfTVE0hjflLENFX7gPG8yD1N0hp
	2lTrBCIIpXo70Cn96TsUpg7CGSAWEcLOJ
X-Google-Smtp-Source: AGHT+IGf3IkwvSSJoKILC1ANmqlMUZbmn5SVVf78+zzm+WJ3NpPA8bAAleXtOAgaw/lW6KLqcZmgsA==
X-Received: by 2002:a05:6402:4604:b0:5d0:9054:b119 with SMTP id 4fb4d7f45d1cf-5dcdb762aaamr643520a12.21.1738698594982;
        Tue, 04 Feb 2025 11:49:54 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e4a5635bsm964684466b.164.2025.02.04.11.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 11:49:54 -0800 (PST)
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
Subject: [PATCH v5 net-next 03/14] netfilter: bridge: Add conntrack double vlan and pppoe
Date: Tue,  4 Feb 2025 20:49:10 +0100
Message-ID: <20250204194921.46692-4-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250204194921.46692-1-ericwouds@gmail.com>
References: <20250204194921.46692-1-ericwouds@gmail.com>
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
 net/bridge/netfilter/nf_conntrack_bridge.c | 81 ++++++++++++++++++----
 1 file changed, 69 insertions(+), 12 deletions(-)

diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index 816bb0fde718..6411bfb53fad 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -242,53 +242,110 @@ static unsigned int nf_ct_bridge_pre(void *priv, struct sk_buff *skb,
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
+		} *ph = (struct ppp_hdr *)(skb->data);
+
+		offset = PPPOE_SES_HLEN;
+		if (!pskb_may_pull(skb, offset))
+			return NF_ACCEPT;
+		outer_proto = skb->protocol;
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
+		struct vlan_hdr *vhdr = (struct vlan_hdr *)(skb->data);
+
+		offset = VLAN_HLEN;
+		if (!pskb_may_pull(skb, offset))
+			return NF_ACCEPT;
+		outer_proto = skb->protocol;
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

