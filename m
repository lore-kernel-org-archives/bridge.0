Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758C025BADB
	for <bridge@lists.linux.dev>; Fri, 28 Feb 2025 20:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773785; cv=none; b=tCNqTwg4UtU3rQRoL4FacRCPlZG0OddncKlTXrnturB14cU3tflxVgN2ahnfgTWJjGFRimfoQa5fKvLsUpueHxuFBSZVPhOs7fwRfZHJHj6gccV+UP7Q9s1qex6pX33fRO6QDfEG5FTPQ850HyeiLq6oP4gz8719wBbgroFRotw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773785; c=relaxed/simple;
	bh=Cv52Ysjt2lko9sBWDja1ONZ3DhITuFZz/l5ensZZgPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p40+sN41TZMrsPE3+9sM7Ld6SD1GcJFYjykreY4nNLs9JhPe2q748Wm8QTWhTtCZQ8fJKj5k1WrfnUK4UmrDkZUPNep47AnozZnsy3AuSZLct54hh7sfF4oA9scUptojBTy+tbJmLzc9mKWiFuYRMZn9CU1PLaGxeT5/+xWz7EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdWuqOFq; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdWuqOFq"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e04861e7a6so4158131a12.1
        for <bridge@lists.linux.dev>; Fri, 28 Feb 2025 12:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740773782; x=1741378582; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rhlCg4/52AHm6e8tJsmpQptNUxepmsLI5spztxpn6c=;
        b=KdWuqOFqYkZlZxYOatokMMqFipqzNzPiZJeJnwDQaOli+4/+82dkI4eOr/wHB8bnkh
         2AZlBuIKx79YPDRVQKHkij0jtgMcgdRYJJJxbtLczgzN8lT+RlTWbTcVbreqDb6lNG65
         srg/BhxtcZnmKXGGu7wOyd3ZY1OY3ixm4nk7yfH9E8nged1d3jseCOtxmNES/UksaTSN
         x2mgdgXloCDVxjN5hJztem3FWIeLMdCIScv3DYevZKw5olyHqBZIyrwgiVEw824L4vMq
         O9XmNknbmtRLs1sbvnP1auzlb3PM8ZyMZgHlLxUo7pO7Vz18hcpD+iu5Dm/SS4EPdaQ7
         Q7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740773782; x=1741378582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+rhlCg4/52AHm6e8tJsmpQptNUxepmsLI5spztxpn6c=;
        b=KQTbqLHMhlC50y83KkrY4cCLSW7iBvsPpWQggtwCycZfg5/ux5fh9Qs8JtZAhj8+Tq
         KIFUaMETEu1SsWDyE7BqWIWzMbYukfPhTtglKwfwDgkMfh6wKm6n/YrsFVpVOW9qeYUF
         4QzHMQFfkpr2aollbLdZp/zQltEH8Xl+s9zvHq8O17UkzWIpou92u7QZrwhRpxYhEpkX
         ARBAH9StFRvb3kYws2VQm2iivNiQLnvSE8tHCH4r7i6fQDPFaKoBwdcY+QcUQ9kF8+h5
         fGxNiBr3KBwmi72cgoEUhLkDxWhqp32AxOzp7cr1c8/uOVAHZuNuYDpnyW/NeBwCtYgk
         Pb6A==
X-Forwarded-Encrypted: i=1; AJvYcCWnGcjwl251BO2EwhpjGoHmfGjux5Kjq1fYdS+cRGrdZD/cbr2OqdUAhzud537BXquEZZiKrpg=@lists.linux.dev
X-Gm-Message-State: AOJu0YyFv6hBCoCadj9PuY6Ys7VsmlUFxmoRWEMaHuM7DERCHjuPYHbu
	1kjT8xvHXt5VcY8FsRKlWoHlZHypdkAHBFSv/lvx+NNzXI2Eiyca
X-Gm-Gg: ASbGncvXd8vTEa5E3KcaCatVOQc+xk8RgUUuD4mmKpJrHQsrEBENcp+12cSMo5z+vzZ
	AY8bWafimWRT9k+k2hvbs10GRDCslW1eRKnwz4ZZYpzBZfkSFtlOr19PQdaaJjdMHonmF09Bb52
	YxCFYXOsR4/XJrOCWNHJs38QAOGHS5z8lJxDkNIHhnwhMSUTXeHD/jKkTjr5baCcBjqiPyk3Qc7
	SdQXDna5MpYPlnWo7vgmYkx3LlazQ9ZrY6P7cfLUf5HqqgjILL7MT7ZhA57YAg6HeY4V1HMhPKl
	MQ3R6fVHFp+1R4Ylx4RiY83tZODVrxO2SKGNwx3RPO4rUyLMPR2xnTFpLpJqNbCNj27edR38ncp
	ILjwMUeGFxJQL3zZmW7qw+rfI40gVGroZ2bErBp57wPU=
X-Google-Smtp-Source: AGHT+IGiUhgcy0UU2Q21kNRFUyXsV4EZ5JKfRHYY7rLJLVAwzjlILW+HrVFwXhJC9gDCOjiMIMoAKA==
X-Received: by 2002:a17:907:2d90:b0:ab7:8930:5669 with SMTP id a640c23a62f3a-abf25fbb482mr535437266b.18.1740773781534;
        Fri, 28 Feb 2025 12:16:21 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c755c66sm340812666b.136.2025.02.28.12.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 12:16:21 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Michal Ostrowski <mostrows@earthlink.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
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
Subject: [PATCH v8 net-next 04/15] netfilter: bridge: Add conntrack double vlan and pppoe
Date: Fri, 28 Feb 2025 21:15:22 +0100
Message-ID: <20250228201533.23836-5-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250228201533.23836-1-ericwouds@gmail.com>
References: <20250228201533.23836-1-ericwouds@gmail.com>
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

