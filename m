Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C22210F55
	for <bridge@lists.linux.dev>; Tue, 10 Dec 2024 09:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823978; cv=none; b=K9lvbeQlCrE7sBBg5AKEGPJlaZlTKmHeU6pkCV4T0bTZIKmgRh3Xl087bmkC5+aEUieKJEs5CE1UnzPuDWofP8LA90/xNP96qGAvYeUpmc+q/fHOrrnFNVe5rEFVBfvCly88HeOqHu1U64H11x4mkyJVYfaU/aIk1q1316bJ83o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823978; c=relaxed/simple;
	bh=EiUlqjqcyycmVQh/cReUaNfMFD5MK6JvPeuoOO/UWjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HScubllFfhhUHiT03U7iHObYFfTauN0YoNbQC0bdYKdhrr4TIl+tV+Gs31Z92A7ifNoS7uuRSHgBK14/n032PA5D2uRLDSge/pNRudURhMf6izUOHyIcsh2GQilt7c2NKkY4XXUBicsf5cBIzlAmyks01wkS875dtHfxmEEjETI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/pUDpaS; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/pUDpaS"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3ecae02beso3176125a12.0
        for <bridge@lists.linux.dev>; Tue, 10 Dec 2024 01:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733823975; x=1734428775; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+WwlYEDG0HLvBd8VAnV5F5MIiHlMD5bJhzWof6nBUU=;
        b=c/pUDpaSrinMtbpNeMFedXtBGXwr7IVHisCOo4EbxvGPgGIHcbrgmcA3PD8Vqnc01v
         gME5gl2fcjslwBE6Jh2pbIsk+xVCVQ7eY8bMB14zNNyEm+9G6GoYKToI10cuZFWdIezr
         +BHk9V+6FKprzPlA/P/ABlNahPy0RKp3uyOhtsD9jE2iDHL74qyBmU3gusjdnAIPxNOQ
         eWSu+Zp4yp0gWJwI+MwPXOzO6r9hT4d4HlCnddfIvncFKRNJOKcGIn5WEtwWmy0Akp7V
         haYL9+nGbNmjaUXd7IgWxJFTQAutuAK86rXdc9FXd612M85/9ENWkj+iYF45WU1Y3K0K
         B/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733823975; x=1734428775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+WwlYEDG0HLvBd8VAnV5F5MIiHlMD5bJhzWof6nBUU=;
        b=jYdIQXHxBpLgTV8QiPD7Hp8s6yapCU7IQO84p+Pio/SzzwJ/UlTMCRAX2xmTvabFuO
         ra1245uJ2p2srOJlg7ZJ20W5cRSXDee1zVaVycJKdDn/OMFOqwQ8THAsE8kqwMKEGYqf
         1datL8fd1eCv9C76DkePhCAaXM8onZlXDYA/BtJ/G+DVm0KQDmRqJd45JYYVIy3wC8HY
         fXvZ7/XgCbrdtMJ52t+ew15fuvIIDGlpDJ0+8QDRLA8a610/iZ4ILrbGmuHwDyrdbby1
         cL+dWPV6YZbhCQuGZSHOmNN6dZpbQaIvuiZj0lkHQdWAL3dsFIOcj+MAb8A9jTYdN0x+
         JfyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKEAnRPLoVNBGpe4YNm+HEHG3GdCNDdZbWgdk73MNY8vo7zLZJ8MxjgYOsYCfn15rHIDW1fTA=@lists.linux.dev
X-Gm-Message-State: AOJu0YxELVHCh7JgnsPkGzEV+iUJpAGKotrhulDnSBZEQrAW28EOAq9L
	gJY5hII0EGTT2tjlyF5mh7XkuZCqZSpgAzvsYZ3Fl/LXHHl/oKBr
X-Gm-Gg: ASbGncsTlk5nU6TcIQhMja66t914lErsnw/7wDopHP39zu+kxHQ7M7+ySFUnWrLnjVj
	nZTSY1k4H9YI0Qx5TSZm/CiwYR3s9e1hsuDmJI84cVUvdkk8TmnkPT7Ep4ILFgysFunpx0BiD6u
	Uuez388pSfsW3JpZ+1B1E7h866on668t1j1UTNzFBWKPIcC65lm9SeANQ3Nxxwi/8NuBQ9gscAw
	RxwtyAkmwor/t6p1GsY1omAio/U8uO5mjLw6pH7oek/ojXOcbJ8J4MMshifStluubCZToHke+Y3
	M+fxMDCbIGuPz4F6cj7Bh+U2QnxcLKcqcKwj1NaJKR8X/WEbISSU4+uSJaFrk/NGnGPs10Y=
X-Google-Smtp-Source: AGHT+IFN3njHf4zlSvRJy82iqOt9EgBaVK0pDLpNl3FfM/NqTtRAx0hFLhBw6GAH1TXoonBsNWdlBA==
X-Received: by 2002:a05:6402:2550:b0:5d0:bf4a:3dfe with SMTP id 4fb4d7f45d1cf-5d3be7f01e6mr14645479a12.23.1733823975128;
        Tue, 10 Dec 2024 01:46:15 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14b609e56sm7313936a12.40.2024.12.10.01.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:46:13 -0800 (PST)
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
	David Ahern <dsahern@kernel.org>,
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
Subject: [PATCH RFC v3 net-next 02/13] netfilter: bridge: Add conntrack double vlan and pppoe
Date: Tue, 10 Dec 2024 10:44:50 +0100
Message-ID: <20241210094501.3069-3-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210094501.3069-1-ericwouds@gmail.com>
References: <20241210094501.3069-1-ericwouds@gmail.com>
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
 net/bridge/netfilter/nf_conntrack_bridge.c | 88 ++++++++++++++++++----
 1 file changed, 75 insertions(+), 13 deletions(-)

diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index 816bb0fde718..31e2bcd71735 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -241,56 +241,118 @@ static unsigned int nf_ct_bridge_pre(void *priv, struct sk_buff *skb,
 				     const struct nf_hook_state *state)
 {
 	struct nf_hook_state bridge_state = *state;
+	__be16 outer_proto, inner_proto;
 	enum ip_conntrack_info ctinfo;
+	int ret, offset = 0;
 	struct nf_conn *ct;
-	u32 len;
-	int ret;
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
+		data_len = ntohs(ph->hdr.length) - 2;
+		offset = PPPOE_SES_HLEN;
+		outer_proto = skb->protocol;
+		switch (ph->proto) {
+		case htons(PPP_IP):
+			inner_proto = htons(ETH_P_IP);
+			break;
+		case htons(PPP_IPV6):
+			inner_proto = htons(ETH_P_IPV6);
+			break;
+		default:
+			return NF_ACCEPT;
+		}
+		break;
+	}
+	case htons(ETH_P_8021Q): {
+		struct vlan_hdr *vhdr = (struct vlan_hdr *)(skb->data);
+
+		data_len = 0xffffffff;
+		offset = VLAN_HLEN;
+		outer_proto = skb->protocol;
+		inner_proto = vhdr->h_vlan_encapsulated_proto;
+		break;
+	}
+	default:
+		data_len = 0xffffffff;
+		break;
+	}
+
+	if (offset) {
+		switch (inner_proto) {
+		case htons(ETH_P_IP):
+		case htons(ETH_P_IPV6):
+			if (!pskb_may_pull(skb, offset))
+				return NF_ACCEPT;
+			skb_pull_rcsum(skb, offset);
+			skb_reset_network_header(skb);
+			skb->protocol = inner_proto;
+			break;
+		default:
+			return NF_ACCEPT;
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
+		skb_push_rcsum(skb, offset);
+		skb_reset_network_header(skb);
+		skb->protocol = outer_proto;
+	}
+	return ret;
 }
-
 static unsigned int nf_ct_bridge_in(void *priv, struct sk_buff *skb,
 				    const struct nf_hook_state *state)
 {
-- 
2.47.1

